// libraries
const path = require('path');
const fs = require('fs');
const bananojs = require('@bananocoin/bananojs');
const blake = require('../node_modules/@bananocoin/bananojs/libraries/blake2b/blake2b.js');

// constants
const inputDir = 'input';

/** set coin name */
const coinPrefixCamelCase = 'Ban';

// const coinPrivateKey = '0000000000000000000000000000000000000000000000000000000000000000';
const coinPrivateKey = undefined;

const coinWorkDifficulty = '0xfffffe0000000000';

const coinRatio = '1e-10';

const coinMessageByte0 = '0x42';

const coinAddressLength = '64';

const nodePort = '7071';

const rpcPort = '7072';

const ipcPort = '7073';

const websocketPort = '7074';

const workPeerPort = '8072';

const coinPeeringNode = 'livenet.banano.cc';

/** the rest are derived */
const run = async () => {
  const genesisWork = 'fa055f79fa56abcf';

  let genesisPublicKey = '2514452A978F08D1CF76BB40B6AD064183CF275D3CC5D3E0515DC96E2112AD4E';

  let genesisAccount = 'ban_1bananobh5rat99qfgt1ptpieie5swmoth87thi74qgbfrij7dcgjiij94xr';

  let canaryAccount = 'ban_3finchb9x33ype7r7495hoh9rs46hyb17sebogh7ghf6ar8zheiucm87mfha';

  let epochSignerAccount = 'bano_3qb6o6i1tkzr6jwr5s7eehfxwg9x6eemitdinbpi7u8bjjwsgqfj4wzser3x';

  let genesisBlockHash = 'F61A79F286ABC5CC01D3D09686F0567812B889A5C63ADE0E82DD30F3B2D96463';

  let genesisSignature = '533DCAB343547B93C4128E779848DEA5877D3278CB5EA948BB3A9AA1AE0DB293DE6D9DA4F69E8D1DDFA385F9B4C5E4F38DFA42C00D7B183560435D07AFA18900';

  let canaryPublicKey = 'B61453D27E843EB30B8288E37D5E7C64447F9202E589AB9E573DA4460DF7B21B';

  let coinRepresentative0 = '36B3AFC042CCB5099DC163FA2BFE42D6E486991B685EAAB0DF73714D91A59400';
  let coinRepresentative1 = '29126049B40D1755C0A1C02B71646EEAB9E1707C16E94B47100F3228D59B1EB2';
  let coinRepresentative2 = '2514452A978F08D1CF76BB40B6AD064183CF275D3CC5D3E0515DC96E2112AD4E';
  let coinRepresentative3 = '2B0C65A063CEC23725E70DB2D39163C48020D66F7C8E0352C1DA8C853E14F8F5';
  let coinRepresentative4 = '6A164D74E73321CE4D6CD49D6948ECFAF4490FBE2BAAF3EBBF4C85F96AD637C0';
  let coinRepresentative5 = '490086E62B376C0EFBAA6AF9C41269EE7D723F98B4667416F075951E981E3F37';

  if (coinPrivateKey !== undefined) {
    const prefix = coinPrefixCamelCase.toLowerCase() + '_';
    genesisPublicKey = await bananojs.getPublicKey(coinPrivateKey);
    console.log('genesisPublicKey', genesisPublicKey);
    genesisAccount = bananojs.getAccount(genesisPublicKey, prefix);

    console.log('genesisAccount', genesisAccount);

    canaryAccount = genesisAccount;
    epochSignerAccount = genesisAccount;

    const context = blake.blake2bInit(32, null);
    // source
    blake.blake2bUpdate(context, bananojs.bananoUtil.bytesToHex(genesisPublicKey));
    // representative
    blake.blake2bUpdate(context, bananojs.bananoUtil.bytesToHex(genesisPublicKey));
    // account
    blake.blake2bUpdate(context, bananojs.bananoUtil.bytesToHex(genesisPublicKey));
    genesisBlockHash = bananojs.bananoUtil.bytesToHex(blake.blake2bFinal(context));

    genesisSignature = bananojs.signHash(coinPrivateKey, genesisBlockHash);

    canaryPublicKey = genesisPublicKey;

    coinRepresentative0 = genesisPublicKey;
    coinRepresentative1 = genesisPublicKey;
    coinRepresentative2 = genesisPublicKey;
    coinRepresentative3 = genesisPublicKey;
    coinRepresentative4 = genesisPublicKey;
    coinRepresentative5 = genesisPublicKey;
  }

  /** all other variables are derived */

  const coinPrefix = coinPrefixCamelCase.toLowerCase();

  const coinPrefixArray = coinPrefix.split('');

  const coinPrefix0InQuotes = `'${coinPrefixArray[0]}'`;

  const coinPrefix1InQuotes = `'${coinPrefixArray[1]}'`;

  const coinPrefix2InQuotes = `'${coinPrefixArray[2]}'`;

  const coinPrefixBackwards = '_' + coinPrefixArray.reverse().join('');

  const coinPrefix2 = coinPrefix + 'o';

  const coinNameCamelCase = coinPrefixCamelCase + 'ano';

  const packageVendor = coinNameCamelCase + 'coin';

  const coinNameLowerCase = packageVendor.toLowerCase();

  const sourceDir = coinNameCamelCase.toLowerCase() + '_build';

  const coinDataDirCamelCase = coinNameCamelCase + 'Data';

  const coinCentsNameLowerCase = coinPrefix2 + 'shi';

  const coinNodeNameLowerCase = coinPrefix + 'anode';

  const coinRpcNameLowerCase = coinPrefix + 'ano_rpc';

  const coinPrefixUppercase = coinPrefix.toUpperCase();

  const replacements = [
    {
      file: 'CMakeLists.txt',
      changes: [
        {
          old: 'Nano Currency',
          new: packageVendor,
          lines: [53],
        },
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [174, 187, 200, 373, 659, 754, 764, 765, 768, 770, 771, 774, 775],
        },
        {
          old: 'nanocurrency',
          new: coinNameLowerCase,
          lines: [177, 179, 190, 192, 203, 205],
        },
        {
          old: 'nano_node',
          new: coinNodeNameLowerCase,
          lines: [717],
        },
        {
          old: 'nano_rpc',
          new: coinRpcNameLowerCase,
          lines: [719],
        },
      ],
    },
    {
      file: 'api/flatbuffers/nanoapi.fbs',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [3],
        },
      ],
    },
    {
      file: 'ci/actions/linux/deploy-docker.sh',
      changes: [
        {
          old: 'nanocurrency',
          new: coinNameLowerCase,
          lines: [31, 48, 49, 50, 54],
        },
      ],
    },
    {
      file: 'ci/actions/linux/install_deps.sh',
      changes: [
        {
          old: 'nanocurrency',
          new: coinNameLowerCase,
          lines: [5, 7],
        },
      ],
    },
    {
      file: 'ci/build-centos.sh',
      changes: [
        {
          old: 'nanocurrency',
          new: coinNameLowerCase,
          lines: [13, 14, 18],
        },
      ],
    },
    {
      file: 'ci/deploy-docker.sh',
      changes: [
        {
          old: 'nanocurrency',
          new: coinNameLowerCase,
          lines: [11, 18, 19, 38, 39, 42],
        },
      ],
    },
    {
      file: 'debian-control/postinst.in',
      changes: [
        {
          old: 'nanocurrency',
          new: coinNameLowerCase,
          lines: [5, 6, 8, 9, 10, 11],
        },
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [8, 9, 10],
        },
      ],
    },
    {
      file: 'doxygen.config',
      changes: [
        {
          old: 'nanocurrency',
          new: coinNameLowerCase,
          lines: [],
        },
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [35],
        },
      ],
    },
    {
      file: 'etc/systemd/nanocurrency-beta.service',
      changes: [
        {
          old: 'nanocurrency',
          new: coinNameLowerCase,
          lines: [7, 8, 9],
        },
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [2, 8, 9],
        },
      ],
    },
    {
      file: 'etc/systemd/nanocurrency-test.service',
      changes: [
        {
          old: 'nanocurrency',
          new: coinNameLowerCase,
          lines: [7, 8, 9],
        },
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [2, 8, 9],
        },
      ],
    },
    {
      file: 'etc/systemd/nanocurrency.service',
      changes: [
        {
          old: 'nanocurrency',
          new: coinNameLowerCase,
          lines: [7, 8, 9],
        },
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [2, 8, 9],
        },
      ],
    },
    {
      file: 'nano/core_test/block.cpp',
      changes: [
        {
          old: 'xrb',
          new: coinPrefix,
          lines: [512, 515, 554, 557, 573, 615, 618, 629, 630, 669, 707],
        },
        {
          old: 'nano',
          new: coinPrefix,
          lines: [713],
        },
        {
          old: 'E89208DD038FBB269987689621D52292AE9C35941A7484756ECCED92A65093BA',
          new: genesisPublicKey,
          lines: [631, 634],
        },
        {
          old: coinPrefix + '_3t6k35gi95xu6tergt6p69ck76ogmitsa8mnijtpxm9fkcm736xtoncuohr3',
          new: genesisAccount,
          lines: [629, 630],
        },
        {
          old: '991CF190094C00F0B68E2E5F75F6BEE95A2E0BD93CEAA4A6734DB9F19B728948',
          new: genesisBlockHash,
          lines: [633],
        },
      ],
    },
    {
      file: 'nano/core_test/blockprocessor.cpp',
      changes: [],
      addNewLine: true,
    },
    {
      file: 'nano/core_test/difficulty.cpp',
      changes: [
        {
          old: '0xffffffc000000000',
          new: coinWorkDifficulty,
          lines: [57],
        },
        {
          old: '8.',
          new: coinRatio,
          lines: [114],
        },
      ],
    },
    {
      file: 'nano/core_test/message.cpp',
      changes: [
        {
          old: '0x52',
          new: coinMessageByte0,
          lines: [55],
        },
      ],
    },
    {
      file: 'nano/core_test/toml.cpp',
      changes: [
        {
          old: 'nano',
          new: coinPrefix2,
          lines: [416],
        },
        {
          old: 'nano_rpc',
          new: coinRpcNameLowerCase,
          lines: [534],
        },
      ],
    },
    {
      file: 'nano/core_test/uint256_union.cpp',
      changes: [
        {
          old: '340,282,366',
          new: '3,402,823,669',
          lines: [102, 105],
        },
        {
          old: '340,282,366.920938463463374607431768211455',
          new: '3,402,823,669.20938463463374607431768211455',
          lines: [103],
        },
        {
          old: '340,282,366.920938463463374607431768211454',
          new: '3,402,823,669.20938463463374607431768211454',
          lines: [106],
        },
        {
          old: 'xrb',
          new: coinPrefix,
          lines: [371, 384, 402],
        },
        {
          old: 'nano',
          new: coinPrefix,
          lines: [372],
        },
        {
          old: '\'x\'',
          new: coinPrefix0InQuotes,
          lines: [386, 404],
        },
      ],
    },
    {
      file: 'nano/core_test/wallet.cpp',
      changes: [
        {
          old: 'xrb',
          new: coinPrefix,
          lines: [343, 360],
        },
        {
          old: '\'x\'',
          new: coinPrefix0InQuotes,
          lines: [345, 362],
        },
        {
          old: '65',
          new: coinAddressLength,
          lines: [346],
        },
      ],
    },
    {
      file: 'nano/core_test/websocket.cpp',
      changes: [
        {
          old: 'xrb',
          new: coinPrefix,
          lines: [174, 607],
        },
      ],
    },
    {
      file: 'nano/ipc_flatbuffers_lib/flatbuffer_producer.hpp',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [13],
        },
      ],
    },
    {
      file: 'nano/lib/blockbuilders.hpp',
      changes: [
        {
          old: 'xrb',
          new: coinPrefix,
          lines: [100, 106, 122, 145, 151, 178, 205],
        },
      ],
    },
    {
      file: 'nano/lib/config.cpp',
      changes: [
        {
          old: '0xffffffc000000000',
          new: '0xfffffe0000000000',
          lines: [29],
        },
        {
          old: '0xfffffff800000000, // 8x higher than epoch_1',
          new: '0xfffffff000000000, // 32x higher than originally',
          lines: [30],
        },
        {
          old: '0xfffffe0000000000 // 8x lower than epoch_1',
          new: '0x0000000000000000 // remove receive work requirements',
          lines: [31],
        },
        {
          old: 'RX',
          new: 'BT',
          lines: [267],
        },
      ],
    },
    {
      file: 'nano/lib/config.hpp',
      changes: [
        {
          old: 'R',
          new: 'B',
          lines: [70, 72, 74, 76],
        },
        {
          old: '0x52',
          new: coinMessageByte0,
          lines: [70, 72, 74, 76],
        },
        {
          old: '43,',
          new: '58,',
          lines: [74],
        },
        {
          old: '58,',
          new: '43,',
          lines: [76],
        },
        {
          old: 'C',
          new: 'X',
          lines: [74],
        },
        {
          old: 'X',
          new: 'C',
          lines: [76],
        },
        {
          old: '1000; // 0.1%',
          new: '2000; // 0.2%',
          lines: [142],
        },
        {
          old: '7075',
          new: nodePort,
          lines: [144],
        },
        {
          old: '7076',
          new: rpcPort,
          lines: [147],
        },
        {
          old: '7077',
          new: ipcPort,
          lines: [150],
        },
        {
          old: '7078',
          new: websocketPort,
          lines: [153],
        },
      ],
    },
    {
      file: 'nano/lib/numbers.cpp',
      changes: [
        {
          old: '_onan',
          new: coinPrefixBackwards,
          lines: [54],
        },
        {
          old: ' // nano_',
          new: '',
          lines: [54],
        },
        {
          old: `xrb_prefix (source_a[0] == 'x' && source_a[1] == 'r' && source_a[2] == 'b' && (source_a[3] == '_' || source_a[3] == '-'));`,
          new: `${coinPrefix}_prefix (source_a[0] == ${coinPrefix0InQuotes} && source_a[1] == ${coinPrefix1InQuotes} && source_a[2] == ${coinPrefix2InQuotes} && (source_a[3] == '_' || source_a[3] == '-'));`,
          lines: [90],
        },
        {
          old: `(source_a[0] == 'n' && source_a[1] == 'a' && source_a[2] == 'n' && source_a[3] == 'o' && (source_a[4] == '_' || source_a[4] == '-'));`,
          new: `(source_a[0] == ${coinPrefix0InQuotes} && source_a[1] == ${coinPrefix1InQuotes} && source_a[2] == ${coinPrefix2InQuotes} && source_a[3] == 'o' && (source_a[4] == '_' || source_a[4] == '-'));`,
          lines: [91],
        },
        {
          old: 'xrb',
          new: coinPrefix,
          lines: [93, 96, 98],
        },
      ],
    },
    {
      file: 'nano/lib/numbers.hpp',
      changes: [
        {
          old: '("1000000000000000000000000000000000"); // 10^33',
          new: '("100000000000000000000000000000000000"); // 10^35 = 1 million banano',
          lines: [11],
        },
        {
          old: '("1000000000000000000000000000000"); // 10^30',
          new: '("100000000000000000000000000000"); // 10^29 = 1 banano',
          lines: [12],
        },
        {
          old: '("1000000000000000000000000000"); // 10^27',
          new: '("1000000000000000000000000000"); // 10^27 = 1 hundredth banano',
          lines: [13],
        },
        {
          old: '("1000000000000000000000000"); // 10^24',
          new: '("1"); // 10^0',
          lines: [14],
        },
      ],
    },
    {
      file: 'nano/lib/plat/windows/registry.cpp',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [8],
        },
      ],
    },
    {
      file: 'nano/lib/rpcconfig.cpp',
      changes: [
        {
          old: 'nano_rpc',
          new: coinRpcNameLowerCase,
          lines: [286],
        },
      ],
    },
    {
      file: 'nano/nano_node/CMakeLists.txt',
      changes: [
        {
          old: 'nano_node',
          new: coinNodeNameLowerCase,
          lines: [1, 4, 13, 17, 21, 25, 27, 29, 34, 36],
        },
        {
          old: ' -DGIT_COMMIT_HASH',
          new: '-DGIT_COMMIT_HASH',
          lines: [18],
        },
        {
          old: ' "-DQT_NO_KEYWORDS',
          new: '"-DQT_NO_KEYWORDS',
          lines: [22],
        },
      ],
    },
    {
      file: 'nano/nano_node/daemon.cpp',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [116],
        },
      ],
    },
    {
      file: 'nano/nano_node/entry.cpp',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [1906],
        },
      ],
    },
    {
      file: 'nano/nano_rpc/CMakeLists.txt',
      changes: [
        {
          old: 'nano_rpc',
          new: coinRpcNameLowerCase,
          lines: [1, 4, 16, 23, 25],
        },
      ],
    },
    {
      file: 'nano/nano_wallet/entry.cpp',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [30],
        },
      ],
    },
    {
      file: 'nano/node/bootstrap/bootstrap_frontier.cpp',
      changes: [
        {
          old: '("Error while sending bootstrap request %1%") % ec.message ()',
          new: '("Error while sending bootstrap request %1%, to %2%") % ec.message () % this_l->connection->channel->to_string ()',
          lines: [36],
        },
        {
          old: '("Error while receiving frontier %1%") % ec.message ()',
          new: '("Error while receiving frontier %1%, to %2%") % ec.message () % connection->channel->to_string ()',
          lines: [209],
        },
        {
          old: '("Error sending frontier finish: %1%") % ec.message ()',
          new: '("Error sending frontier finish: %1%, to %2%") % ec.message () % connection->socket->remote_endpoint ()',
          lines: [308],
        },
        {
          old: '("Error sending frontier pair: %1%") % ec.message ()',
          new: '("Error sending frontier pair: %1%, to %2%") % ec.message () % connection->socket->remote_endpoint ()',
          lines: [324],
        },
      ],
    },
    {
      file: 'nano/node/cli.cpp',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [701],
        },
      ],
    },
    {
      file: 'nano/node/json_handler.hpp',
      changes: [
        {
          old: 'Mxrb_ratio',
          new: `${coinPrefixUppercase}_ratio`,
          lines: [77, 78],
        },
      ],
    },
    {
      file: 'nano/node/json_handler.cpp',
      changes: [
        {
          old: 'krai_from_raw',
          new: `${coinCentsNameLowerCase}_from_raw`,
          lines: [101],
        },
        {
          old: 'krai_to_raw',
          new: `${coinCentsNameLowerCase}_to_raw`,
          lines: [105],
        },
        {
          old: 'rai_from_raw',
          new: `raw_from_raw`,
          lines: [109],
        },
        {
          old: 'rai_to_raw',
          new: `raw_to_raw`,
          lines: [113],
        },
        {
          old: 'mrai_from_raw',
          new: `${coinPrefix}_from_raw`,
          lines: [117],
        },
        {
          old: 'mrai_to_raw',
          new: `${coinPrefix}_to_raw`,
          lines: [121],
        },
        {
          old: 'kxrb_ratio',
          new: `${coinCentsNameLowerCase}_ratio`,
          lines: [103, 107],
        },
        {
          old: 'xrb_ratio',
          new: `RAW_ratio`,
          lines: [111, 115],
        },
        {
          old: 'Mxrb_ratio',
          new: `${coinPrefixUppercase}_ratio`,
          lines: [2803, 2821],
        },
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [4212],
        },
      ],
    },
    {
      file: 'nano/node/logging.cpp',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [42],
        },
      ],
    },
    {
      file: 'nano/node/node.cpp',
      changes: [
        {
          old: 'XRB',
          new: coinPrefixUppercase,
          lines: [397],
        },
      ],
    },
    {
      file: 'nano/node/node_pow_server_config.cpp',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [6],
        },
      ],
    },
    {
      file: 'nano/node/nodeconfig.cpp',
      changes: [
        {
          old: 'peering.nano.org',
          new: coinPeeringNode,
          lines: [19],
        },
        {
          old: 'nano',
          new: coinPrefix2,
          lines: [52],
        },
        {
          old: `preconfigured_representatives.emplace_back ("A30E0A32ED41C8607AA9212843392E853FCBCB4E7CB194E35C94F07F91DE59EF");`,
          new: `preconfigured_representatives.emplace_back ("${coinRepresentative0}");`,
          lines: [58],
        },
        {
          old: `preconfigured_representatives.emplace_back ("67556D31DDFC2A440BF6147501449B4CB9572278D034EE686A6BEE29851681DF");`,
          new: `preconfigured_representatives.emplace_back ("${coinRepresentative1}");`,
          lines: [59],
        },
        {
          old: `preconfigured_representatives.emplace_back ("5C2FBB148E006A8E8BA7A75DD86C9FE00C83F5FFDBFD76EAA09531071436B6AF");`,
          new: `preconfigured_representatives.emplace_back ("${coinRepresentative2}");`,
          lines: [60],
        },
        {
          old: `preconfigured_representatives.emplace_back ("AE7AC63990DAAAF2A69BF11C913B928844BF5012355456F2F164166464024B29");`,
          new: `preconfigured_representatives.emplace_back ("${coinRepresentative3}");`,
          lines: [61],
        },
        {
          old: `preconfigured_representatives.emplace_back ("BD6267D6ECD8038327D2BCC0850BDF8F56EC0414912207E81BCF90DFAC8A4AAA");`,
          new: `preconfigured_representatives.emplace_back ("${coinRepresentative4}");`,
          lines: [62],
        },
        {
          old: `preconfigured_representatives.emplace_back ("2399A083C600AA0572F5E36247D978FCFC840405F8D4B6D33161C0066A55F431");`,
          new: `preconfigured_representatives.emplace_back ("${coinRepresentative5}");`,
          lines: [63],
        },
        {
          old: `preconfigured_representatives.emplace_back ("2298FAB7C61058E77EA554CB93EDEEDA0692CBFCC540AB213B2836B29029E23A");`,
          new: `// removed a preconfigured_representative`,
          lines: [64],
        },
        {
          old: `\t\t\tpreconfigured_representatives.emplace_back ("3FE80B4BC842E82C1C18ABFEEC47EA989E63953BC82AC411F304D13833D52A56");`,
          new: ``,
          lines: [65],
        },
      ],
    },
    {
      file: 'nano/node/nodeconfig.hpp',
      changes: [
        {
          old: '8076',
          new: workPeerPort,
          lines: [49],
        },
        {
          old: '60000',
          new: '900',
          lines: [58],
        },
        {
          old: '10 * 1024 * 1024',
          new: '2 * 1024 * 1024',
          lines: [95],
        },
      ],
    },
    {
      file: 'nano/node/portmapping.cpp',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [109],
        },
      ],
    },
    {
      file: 'nano/qt/qt.cpp',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [62],
        },
        {
          old: 'MRAW_ratio',
          new: coinPrefixUppercase + '_ratio',
          lines: [1002, 1828],
        },
      ],
    },
    {
      file: 'nano/rpc_test/rpc.cpp',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [1917],
        },
        {
          old: 'mrai_to_raw',
          new: `${coinPrefix}_to_raw`,
          lines: [2411, 2417],
        },
        {
          old: 'mrai_from_raw',
          new: `${coinPrefix}_from_raw`,
          lines: [2423],
        },
        {
          old: 'krai_to_raw',
          new: `${coinCentsNameLowerCase}_to_raw`,
          lines: [2435, 2441],
        },
        {
          old: 'krai_from_raw',
          new: `${coinCentsNameLowerCase}_from_raw`,
          lines: [2447],
        },
      ],
    },
    {
      file: 'nano/secure/common.cpp',
      changes: [
        {
          old: 'xrb',
          new: coinPrefix,
          lines: [30, 32, 37, 38, 55, 56],
        },
        {
          old: coinPrefix + '_3t6k35gi95xu6tergt6p69ck76ogmitsa8mnijtpxm9fkcm736xtoncuohr3',
          new: genesisAccount,
          lines: [32, 55, 56],
        },
        {
          old: 'E89208DD038FBB269987689621D52292AE9C35941A7484756ECCED92A65093BA',
          new: genesisPublicKey,
          lines: [32, 54],
        },
        {
          old: '62f05417dd3fb691',
          new: genesisWork,
          lines: [57],
        },
        {
          old: '9F0C933C8ADE004D808EA1985FA746A7E95BA2A38F867640F53EC8F180BDFE9E2C1268DEAD7C2664F356E37ABA362BC58E46DBA03E523A7B5A19E4B6EB12BB02',
          new: genesisSignature,
          lines: [58],
        },
        {
          old: 'nano',
          new: coinPrefix2,
          lines: [46, 47, 64, 65],
        },
        {
          old: 'nano',
          new: coinPrefix,
          lines: [78, 79],
        },
        {
          old: 'nano_3qb6o6i1tkzr6jwr5s7eehfxwg9x6eemitdinbpi7u8bjjwsgqfj4wzser3x',
          new: epochSignerAccount,
          lines: [146],
        },
        {
          old: '868C6A9F79D4506E029B378262B91538C5CB26D7C346B63902FFEB365F1C1947',
          new: canaryPublicKey,
          lines: [78],
        },
        {
          old: '7CBAF192A3763DAEC9F9BAC1B2CDF665D8369F8400B4BC5AB4BA31C00BAA4404',
          new: canaryPublicKey,
          lines: [79],
        },
        {
          old: '3BAD2C554ACE05F5E528FBBCE79D51E552C55FA765CCFD89B289C4835DE5F04A',
          new: canaryPublicKey,
          lines: [80],
        },
        {
          old: coinPrefix + '_33nefchqmo4ifr3bpfw4ecwjcg87semfhit8prwi7zzd8shjr8c9qdxeqmnx',
          new: canaryAccount,
          lines: [78],
        },
        {
          old: coinPrefix + '_1z7ty8bc8xjxou6zmgp3pd8zesgr8thra17nqjfdbgjjr17tnj16fjntfqfn',
          new: canaryAccount,
          lines: [79],
        },
        {
          old: 'nano_1gxf7jcnomi7yqkkjyxwwygo5sckrohtgsgezp6u74g6ifgydw4cajwbk8bf',
          new: canaryAccount,
          lines: [80],
        },
      ],
    },
    {
      file: 'nano/secure/utility.cpp',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [18, 21, 27],
        },
        {
          old: 'Nano',
          new: coinDataDirCamelCase,
          lines: [24],
        },
      ],
    },
    {
      file: 'nanocurrency-beta.spec.in',
      changes: [
        {
          old: 'nanocurrency',
          new: coinNameLowerCase,
          lines: [1, 13, 45, 54, 58, 59, 60, 61, 62, 66],
        },
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [4, 13, 58, 60],
        },
      ],
    },
    {
      file: 'util/build_prep/bootstrap_boost.sh',
      changes: [
        {
          old: 'Nano',
          new: coinNameCamelCase,
          lines: [21],
        },
      ],
    },
    {
      file: 'util/build_prep/common.sh',
      changes: [
        {
          old: 'nanocurrency',
          new: coinNameLowerCase,
          lines: [1],
        },
      ],
    },
  ];

  const DEBUG = false;

  const replaceAll = (fileListFile, regex, replacement) => {
    const files = [...new Set(fs.readFileSync(fileListFile, 'UTF-8').split('\n'))];
    for (let fileIx = 0; fileIx < files.length; fileIx++) {
      const filePrefix = files[fileIx];
      if (filePrefix.length > 0) {
        const file = path.join(sourceDir, filePrefix);
        console.log('replaceAll', fileIx, 'file', file);
        const fileData = fs.readFileSync(file, 'UTF-8');
        const regexp = new RegExp(regex, 'g');
        if (fileData.indexOf(regex) >= 0) {
          let newFileData = fileData.replaceAll(regex, replacement);
          while (newFileData.indexOf(regex) >= 0) {
            newFileData = fileData.replaceAll(regex, replacement);
          }
          const filePtr = fs.openSync(file, 'w');
          fs.writeSync(filePtr, newFileData);
          fs.closeSync(filePtr);
        } else {
          console.log('ERROR, no regex match',
              'regex', regex,
              'file', file,
          );
        }
      }
    }
  };

  replaceAll('input/Gxrb_ratio-to-MBAN_ratio.txt', 'Gxrb_ratio', `M${coinPrefixUppercase}_ratio`);
  // replaceAll('input/MRAW_ratio-to-BAN_ratio.txt', 'MRAW_ratio', 'BAN_ratio');
  replaceAll('input/Mxrb_ratio-to-BAN_ratio.txt', 'Mxrb_ratio', coinPrefixUppercase + '_ratio');
  replaceAll('input/xrb_ratio-to-RAW_ratio.txt', 'xrb_ratio', 'RAW_ratio');
  replaceAll('input/kRAW-to-banoshi.txt', 'kRAW', coinCentsNameLowerCase);

  console.log('replacements', replacements.length);
  for (let replacementIx = 0; replacementIx < replacements.length; replacementIx++) {
    const replacement = replacements[replacementIx];
    const file = path.join(sourceDir, replacement.file);
    console.log('replacementIx', replacementIx, 'file', file);

    const fileData = fs.readFileSync(file, 'UTF-8');
    const fileLines = fileData.split('\n');

    for (let changeIx = 0; changeIx < replacement.changes.length; changeIx++) {
      const change = replacement.changes[changeIx];
      for (changeLineIx = 0; changeLineIx < change.lines.length; changeLineIx++) {
        const lineIx = change.lines[changeLineIx];
        const lineNum = lineIx-1;
        const oldLine = fileLines[lineNum];
        const regex = change.old;
        if (oldLine.indexOf(regex) >= 0) {
          const newLine = oldLine.replaceAll(regex, change.new);
          if (DEBUG) {
            console.log('replacementIx', replacementIx, 'lineIx', lineIx);
            console.log('replacementIx', replacementIx, 'regexp', change.old);
            console.log('replacementIx', replacementIx, 'oldLine', oldLine);
            console.log('replacementIx', replacementIx, 'newLine', newLine);
          }
          fileLines[lineNum] = newLine;
        } else {
          console.log('ERROR, no regex match',
              'replacementIx', replacementIx,
              'changeIx', changeIx,
              'lineIx', lineIx,
              'regexp', change.old,
              'oldLine', oldLine,
          );
        }
      }
    }
    let newFileData = fileLines.join('\n');
    if (replacement.addNewLine == true) {
      newFileData += '\n';
    }
    const filePtr = fs.openSync(file, 'w');
    fs.writeSync(filePtr, newFileData);
    fs.closeSync(filePtr);
  }
};

run();
