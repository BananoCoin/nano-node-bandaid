'use strict';
// libraries
const path = require('path');
const fs = require('fs');

// modules
const fetch = require('node-fetch');

// constants
const firstAccount = 'ban_1111111111111111111111111111111111111111111111111111hifc8npp';

const openPrevious = '0000000000000000000000000000000000000000000000000000000000000000';

const DEBUG = false;

const config = {
  'publicNodeUrl': 'http://api-beta.banano.cc:7070/',
  'frontiersCount': 10000,
  'dataFolder': 'frontiers',
};

const loggingUtil = {};
loggingUtil.log = console.log;
loggingUtil.isDebugEnabled = () => {
  return false;
};
loggingUtil.debug = () => {};
// loggingUtil.debug = console.log;
loggingUtil.trace = console.trace;

// functions
const getHeaders = (config) => {
  const headers = {
    'accept': '*/*',
    'accept-language': 'en-US,en;q=0.9',
    'content-type': 'application/json',
  };
  return headers;
};

const getDate = () => {
  return new Date().toISOString();
};

const run = async (url) => {
  if (DEBUG) {
    // config.frontiersCount = 100;
  }
  const headers = getHeaders(config);

  if (!fs.existsSync(config.dataFolder)) {
    fs.mkdirSync(config.dataFolder, {recursive: true});
  }

  const cachedGapFile = path.join(config.dataFolder, 'gap-frontiers.json');
  const gapFrontiers = [];
  if (fs.existsSync(cachedGapFile)) {
    const gapFrontiersStr = fs.readFileSync(cachedGapFile);
    const gapFrontiersJson = JSON.parse(gapFrontiersStr);
    gapFrontiersJson.forEach((frontier) => {
      gapFrontiers.push(frontier);
    });
  } else {
    const publicNodeFrontiers = await getFrontiers(config.publicNodeUrl, headers, loggingUtil, getDate, config.frontiersCount);
    // loggingUtil.log(getDate(), 'publicNodeFrontiers.length', publicNodeFrontiers);

    const rocksdbFrontiers = await getFrontiers(url, headers, loggingUtil, getDate, config.frontiersCount);
    // loggingUtil.log(getDate(), 'rocksdbFrontiers.length', rocksdbFrontiers);

    const publicNodeAccountFrontier = {};
    const publicNodeFrontierHashSet = new Set();
    publicNodeFrontiers.forEach((elt) => {
      publicNodeFrontierHashSet.add(elt.hash);
      publicNodeAccountFrontier[elt.account] = elt.hash;
    });

    const rocksdbHashSet = new Set();
    for (let ix = 0; ix < rocksdbFrontiers.length; ix++) {
      const elt = rocksdbFrontiers[ix];
      rocksdbHashSet.add(elt.hash);
    }

    for (let ix = 0; ix < publicNodeFrontiers.length; ix++) {
      const elt = publicNodeFrontiers[ix];
      if (!rocksdbHashSet.has(elt.hash)) {
        const publicNodeHash = publicNodeAccountFrontier[elt.account];
        elt.publicNodeHash = publicNodeHash;
        const info = await getAccountInfo(headers, url, elt.account);
        const history = await getAccountHistory(headers, config.publicNodeUrl, info.frontier);
        elt.publicNodeNext = history.next;
        gapFrontiers.push(elt);
        loggingUtil.log(getDate(), 'rocksdb frontier', ix, 'of', rocksdbFrontiers.length, 'total gap count', gapFrontiers.length);
      }
    }
    const gapFile = path.join(config.dataFolder, 'gap-frontiers-' + getDate() + '.json');
    saveJson(gapFrontiers, gapFile);
  }
  const publicNodeNexts = [];
  for (let ix = 0; ix < gapFrontiers.length; ix++) {
    const elt = gapFrontiers[ix];
    if (elt.publicNodeNext !== undefined) {
      publicNodeNexts.push(elt.publicNodeNext);
    }
  }

  // console.log('publicNodeNexts', publicNodeNexts);
  const publicNodeNextBlocks = await getBlocksInfo(headers, config.publicNodeUrl, publicNodeNexts, loggingUtil, getDate);
  // console.log('publicNodeNextBlocks', publicNodeNextBlocks);

  const publicNodeLinkPrevs = [];

  for (let ix = 0; ix < gapFrontiers.length; ix++) {
    const elt = gapFrontiers[ix];
    if (elt.publicNodeNext !== undefined) {
      const block = publicNodeNextBlocks.blocks[elt.publicNodeNext];
      elt.publicNodeNextBlock = block;
      if (block.subtype == 'receive') {
        const sendHash = block.contents.link;
        publicNodeLinkPrevs.push(sendHash);
      }
      const previous = block.contents.previous;
      if (previous !== openPrevious) {
        publicNodeLinkPrevs.push(previous);
      }
    }
  }

  const rocksdbHashSet = new Set();

  const minBlockHeightByAccount = {};

  let hasAllGapBlocks = true;
  while (hasAllGapBlocks) {
    loggingUtil.log(getDate(), 'total gap count', publicNodeLinkPrevs.length, 'total rocksdb hash', rocksdbHashSet.size);
    const newPublicNodeLinkPrevs = new Set();
    const publicNodeLinkPrevBlocks = await getBlocksInfo(headers, config.publicNodeUrl, publicNodeLinkPrevs, loggingUtil, getDate);
    const rocksdbLinkPrevBlocks = await getBlocksInfo(headers, url, publicNodeLinkPrevs, loggingUtil, getDate);
    for (let ix = 0; ix < publicNodeLinkPrevs.length; ix++) {
      const hash = publicNodeLinkPrevs[ix];
      if (rocksdbLinkPrevBlocks.blocks[hash] !== undefined) {
        rocksdbHashSet.add(hash);
      } else {
        const block = publicNodeLinkPrevBlocks.blocks[hash];
        if (block == undefined) {
          loggingUtil.log(getDate(), 'hash not found in synched node', hash);
        } else {
          let gapBlock = false;
          const previous = block.contents.previous;
          if (block.subtype == 'receive') {
            const sendHash = block.contents.link;
            if (rocksdbLinkPrevBlocks.blocks[sendHash] !== undefined) {
              if (rocksdbLinkPrevBlocks.blocks[previous] !== undefined) {
                // loggingUtil.log(getDate(), 'sendHash and previous found in unsynched node');
                rocksdbHashSet.add(previous);
                rocksdbHashSet.add(sendHash);
              } else {
                gapBlock = true;
                // loggingUtil.log(getDate(), 'sendHash found in unsynched node, previous missing');
                newPublicNodeLinkPrevs.add(previous);
                rocksdbHashSet.add(sendHash);
              }
            } else {
              // loggingUtil.log(getDate(), 'previous and sendHash missing from unsynched node');
              newPublicNodeLinkPrevs.add(sendHash);
              newPublicNodeLinkPrevs.add(previous);
              gapBlock = true;
            }
          } else {
            if (rocksdbLinkPrevBlocks.blocks[previous] !== undefined) {
              // loggingUtil.log(getDate(), 'previous found in unsynched node', 'subtype', block.subtype);
              rocksdbHashSet.add(previous);
            } else {
              // loggingUtil.log(getDate(), 'previous missing from unsynched node');
              newPublicNodeLinkPrevs.add(previous);
              gapBlock = true;
            }
          }
          if (!gapBlock) {
            loggingUtil.log(getDate(), 'non gap block found hash', hash);
            const synchResponse = await processHash(headers, config.publicNodeUrl, url, hash, loggingUtil, getDate, 'false');
            loggingUtil.log(getDate(), 'rocksdb account synch response', hash, synchResponse);
            if (synchResponse.error == 'Fork' || synchResponse.error == 'RPC control is disabled') {
              loggingUtil.log(getDate(), 'rocksdb account synch somehow got a fork. continuing.', hash);
            } else if (synchResponse.hash == hash) {
              loggingUtil.log(getDate(), 'rocksdb account synch successful. continuing.', hash);
            } else {
              hasAllGapBlocks = false;
            }
          }
        }
      }
    }

    const blockHeightCountHashes = [];
    let crosscheckCount = 0;
    newPublicNodeLinkPrevs.forEach((hash) => {
      if (hash !== openPrevious) {
        if (!rocksdbHashSet.has(hash)) {
          blockHeightCountHashes.push(hash);
        } else {
          crosscheckCount++;
        }
      }
    });

    const blockHeightCountBlocks = await getBlocksInfo(headers, config.publicNodeUrl, blockHeightCountHashes, loggingUtil, getDate);

    publicNodeLinkPrevs.length = 0;
    let blockHeightCount = 0;
    blockHeightCountHashes.forEach((hash) => {
      const block = blockHeightCountBlocks.blocks[hash];
      if (block === undefined) {
        publicNodeLinkPrevs.push(hash);
      } else {
        const account = block.block_account;
        const height = parseInt(block.height);
        if (minBlockHeightByAccount[account] == undefined) {
          minBlockHeightByAccount[account] = height;
        } else {
          const oldMinHeight = minBlockHeightByAccount[account];
          if (height < oldMinHeight) {
            minBlockHeightByAccount[account] = height;
          }
        }
        const oldMinHeight = minBlockHeightByAccount[account];
        if (oldMinHeight == height) {
          publicNodeLinkPrevs.push(hash);
        } else {
          blockHeightCount++;
        }
      }
    });

    loggingUtil.log(getDate(), 'filter results',
        'rocksdb dupes', crosscheckCount,
        'account dupes', blockHeightCount,
        'new set', publicNodeLinkPrevs.length, 'of', newPublicNodeLinkPrevs.size);
    if (publicNodeLinkPrevs.length == 0) {
      loggingUtil.log(getDate(), 'no more hashes to process');
      return;
    }
  }
};

const getFrontiers = async (url, headers, loggingUtil, getDate, frontiersCount) => {
  let lastAccount = firstAccount;
  let getNextPageFlag = true;
  const frontiers = [];
  while (getNextPageFlag) {
    loggingUtil.log(getDate(), url, 'lastAccount', lastAccount);
    getNextPageFlag = false;
    const page = await getFrontiersPage(url, headers, frontiersCount, lastAccount);
    Object.keys(page.frontiers).forEach((account) => {
      frontiers.push({
        account: account,
        hash: page.frontiers[account],
      });
      const compareFlag = lastAccount.localeCompare(account);
      // loggingUtil.log(getDate(), 'lastAccount', lastAccount, 'account', account, 'compareFlag', compareFlag);
      if (compareFlag != 0) {
        lastAccount = account;
        if (!DEBUG) {
          getNextPageFlag = true;
        }
      }
    });
  }
  return frontiers;
};

const getFrontiersPage = async (url, headers, frontiersCount, account) => {
  // loggingUtil.log(getDate(), 'frontiersUrl', url);
  const body = `{"action": "frontiers","account": "${account}","count": "${frontiersCount}"}`;
  const request = {
    method: 'POST',
    headers: headers,
    body: body,
  };
  // loggingUtil.log(getDate(), 'request', request);
  const response = await fetch(url, request);
  // loggingUtil.log(getDate(), 'response', response);
  const responseJson = await response.json();
  // loggingUtil.log(getDate(), 'responseJson', responseJson);
  return responseJson;
};

const processHash = async (headers, publicNodeUrl, url, hash, loggingUtil, getDate, force) => {
  const blocks = await getBlocksInfo(headers, publicNodeUrl, [hash], loggingUtil, getDate);
  const block = blocks.blocks[hash];
  const response = await processBlockOnNode(headers, url, block, loggingUtil, getDate, force);
  // console.log('processHash', 'block.subtype', block.subtype, hash, 'response', response);
  return response;
};

const getAccountInfo = async (headers, url, account) => {
  // loggingUtil.log(getDate(), 'frontiersUrl', url);
  // loggingUtil.log(getDate(), 'hashes', hashes);
  const bodyJson = {
    'action': 'account_info',
    'account': account,
  };
  const body = JSON.stringify(bodyJson);
  // loggingUtil.log(getDate(), 'body', body);
  const request = {
    method: 'POST',
    headers: headers,
    body: body,
  };
  // loggingUtil.log(getDate(), 'request', request);
  const response = await fetch(url, request);
  // loggingUtil.log(getDate(), 'response', response);
  const responseJson = await response.json();
  // loggingUtil.log(getDate(), 'responseJson', responseJson);
  return responseJson;
};

const getBlocksInfo = async (headers, url, hashes, loggingUtil, getDate) => {
  const chunkSize = 1000;
  const combinedResponse = {};
  combinedResponse.blocks = {};
  for (let i = 0; i < hashes.length; i += chunkSize) {
    const chunk = hashes.slice(i, i + chunkSize);
    // loggingUtil.log('getBlocksInfo', getDate(), 'url', url, 'chunk', i, 'of', hashes.length);
    // loggingUtil.log(getDate(), 'hashes', hashes);
    const bodyJson = {
      'action': 'blocks_info',
      'json_block': 'true',
      'include_not_found': 'true',
      'hashes': chunk,
    };
    const body = JSON.stringify(bodyJson);
    // loggingUtil.log(getDate(), 'body', body);
    const request = {
      method: 'POST',
      headers: headers,
      body: body,
    };
    // loggingUtil.log(getDate(), 'request', request);
    const response = await fetch(url, request);
    // loggingUtil.log(getDate(), 'response', response);
    const responseJson = await response.json();
    // loggingUtil.log(getDate(), 'responseJson', responseJson);
    chunk.forEach((hash) => {
      const block = responseJson.blocks[hash];
      if (block !== undefined) {
        combinedResponse.blocks[hash] = block;
      }
    });
  }
  return combinedResponse;
};

const processBlockOnNode = async (headers, url, block, loggingUtil, getDate, force) => {
  loggingUtil.log(getDate(), 'url', url);
  // loggingUtil.log(getDate(), 'hashes', hashes);
  const bodyJson = {
    action: 'process',
    json_block: 'true',
    force: force,
    // subtype: block.subtype,
    block: block.contents,
  };
  const body = JSON.stringify(bodyJson);
  // loggingUtil.log(getDate(), 'body', body);
  const request = {
    method: 'POST',
    headers: headers,
    body: body,
  };
    // loggingUtil.log(getDate(), 'request', request);
  const response = await fetch(url, request);
  // loggingUtil.log(getDate(), 'response', response);
  const responseJson = await response.json();
  // loggingUtil.log(getDate(), 'responseJson', responseJson);
  return responseJson;
};

const getAccountHistory = async (headers, url, head) => {
  // loggingUtil.log(getDate(), 'frontiersUrl', url);
  // loggingUtil.log(getDate(), 'hashes', hashes);
  const bodyJson = {
    'action': 'account_history',
    'count': '1',
    'raw': 'true',
    'reverse': 'true',
    'head': head,
  };
  const body = JSON.stringify(bodyJson);
  // loggingUtil.log(getDate(), 'body', body);
  const request = {
    method: 'POST',
    headers: headers,
    body: body,
  };
  // loggingUtil.log(getDate(), 'request', request);
  const response = await fetch(url, request);
  // loggingUtil.log(getDate(), 'response', response);
  const responseJson = await response.json();
  // loggingUtil.log(getDate(), 'responseJson', responseJson);
  return responseJson;
};

const saveJson = (json, file) => {
  const filePtr = fs.openSync(file, 'w');
  fs.writeSync(filePtr, JSON.stringify(json, undefined, ' '));
  fs.closeSync(filePtr);
};

// const trimBlock = (block) => {
//   delete block.amount;
//   delete block.balance;
//   delete block.local_timestamp;
//   delete block.confirmed;
//   delete block.contents.type;
//   delete block.contents.account;
//   delete block.contents.representative;
//   delete block.contents.balance;
//   delete block.contents.link_as_account;
//   delete block.contents.signature;
//   delete block.contents.work;
// };

// const addAccountInfoToBlock = async (config, headers, block) => {
//   block.rocksDbInfo = await getAccountInfo(headers, config.rocksdbUrl, block.block_account);
//   block.publicNodeInfo = await getAccountInfo(headers, config.publicNodeUrl, block.block_account);
//   trimAccountInfo(block.rocksDbInfo);
//   trimAccountInfo(block.publicNodeInfo);
// };
//
// const trimAccountInfo = (info) => {
//   delete info.frontier;
//   delete info.open_block;
//   delete info.representative_block;
//   delete info.balance;
//   delete info.modified_timestamp;
//   delete info.account_version;
//   delete info.confirmation_height;
//   delete info.confirmation_height_frontier;
// };

const init = async () => {
  loggingUtil.log(getDate(), 'STARTED init');

  if (process.argv.length < 3) {
    console.log(`usage: node frontiers.js <out-of-synch-node-url>`);
    return;
  }
  loggingUtil.log(getDate(), 'SUCCESS init');
  const url = process.argv[2];
  console.log('url', url);
  run(url);
};

init()
    .catch((e) => {
      console.log('FAILURE init.', e.message);
      console.trace('FAILURE init.', e);
    });
