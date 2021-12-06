# nano-node-bandaid

a utility for updating the nano code with the standard banano changes.

## usage of converter

1. clone https://github.com/nanocurrency/nano-node.git into your own repo.

2. git clone your repo into <coinPrefix>ano_build

    git clone --branch develop https://github.com/coranos/nulnode.git nulano_build;

3. set coinPrivateKey and coinPrefixCamelCase to something other than ban.
    try
      coinPrivateKey = '0000000000000000000000000000000000000000000000000000000000000000';
    and
      coinPrefixCamelCase = 'Nul';

4. run:

    npm start;

5. check in the code that was changed.

## usage of bandaid

1.  edit ./bandaid.sh to have the correct build info based on nano and banano latest builds

    <https://github.com/BananoCoin/banano/wiki/Building-a-Bananode-from-sources>

    <https://docs.nano.org/integration-guides/build-options/#node_1>

2.  run ./bandaid.sh

3.  follow the instructions to build banano from source up until 'make bananode'

    <https://github.com/BananoCoin/banano/wiki/Building-a-Bananode-from-sources>

4.  copy bandaid_build over banano_build

5. python3 record_rep_weights.py --rpc http://localhost:7072 ../rep_weights_live.bin

6.  resume building banano from source 'make bananode'

7.  check in the new source code.
