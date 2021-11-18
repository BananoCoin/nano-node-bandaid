#!/bin/bash

reset;

# "bandaid_build" is the nano_build with banano changes applied.
# if all the changes are applied correctly, it should be identical to banano_build
# git diff is
# https://github.com/nanocurrency/nano-node/compare/V22.1...BananoCoin:V22dev2
# https://github.com/BananoCoin/banano/compare/V23develop...nanocurrency:develop

# check_type="BananoCoin_vs_nanocurrency_develop"
# check_type="coranos_vs_nanocurrency_V22"
# check_type="BananoCoin_V23develop_vs_nanocurrency_develop"
check_type="nanocurrency_develop_edited_vs_nanocurrency_develop"
# check_type="coranos_nullnode_edited_vs_nanocurrency_develop"
# check_type="local"

if [ $check_type = "BananoCoin_vs_nanocurrency_V22" ]
then
  echo "comparing BananoCoin V22dev2 vs nanocurrency V22.1"
  rm -rf banano_build;
  rm -rf nano_build;
  git clone --branch V22dev2 https://github.com/BananoCoin/banano.git banano_build;
  git clone --branch V22.1 https://github.com/nanocurrency/nano-node.git nano_build;
elif [ $check_type = "BananoCoin_vs_nanocurrency_develop" ]
then
  echo "comparing BananoCoin V22dev2 vs nanocurrency develop"
  rm -rf banano_build;
  rm -rf nano_build;
  git clone --branch V22dev2 https://github.com/BananoCoin/banano.git banano_build;
  git clone --branch develop https://github.com/nanocurrency/nano-node.git nano_build;
elif [ $check_type = "coranos_vs_nanocurrency_V22" ]
then
  echo "comparing coranos V22dev2 vs nanocurrency V22.1"
  rm -rf banano_build;
  rm -rf nano_build;
  git clone --branch V22dev2 https://github.com/coranos/banano.git banano_build;
  git clone --branch V22.1 https://github.com/nanocurrency/nano-node.git nano_build;
elif [ $check_type = "BananoCoin_V23develop_vs_nanocurrency_develop" ]
then
  echo "comparing BananoCoin V23develop vs nanocurrency develop"
  rm -rf banano_build;
  rm -rf nano_build;
  git clone --branch V23develop https://github.com/BananoCoin/banano.git banano_build;
  git clone --branch develop https://github.com/nanocurrency/nano-node.git nano_build;
elif [ $check_type = "nanocurrency_develop_edited_vs_nanocurrency_develop" ]
then
  echo "comparing nanocurrency develop edited vs nanocurrency develop"
  rm -rf banano_build;
  rm -rf nano_build;
  git clone --branch develop https://github.com/nanocurrency/nano-node.git banano_build;
  git clone --branch develop https://github.com/nanocurrency/nano-node.git nano_build;
  npm start;
elif [ $check_type = "coranos_nullnode_edited_vs_nanocurrency_develop" ]
then
  echo "comparing coranos nullnode edited vs nanocurrency develop"
  rm -rf banano_build;
  rm -rf nano_build;
  git clone --branch develop https://github.com/coranos/nulnode.git nulano_build;
  git clone --branch develop https://github.com/nanocurrency/nano-node.git nano_build;
  cd nano_build;
  git reset --hard bf22417a10a3cd770af66e9a3732775ca2d7f65d;
  cd ..;
  npm start;
elif [ $check_type = "local" ]
then
  echo "comparing local"
else
  echo "unknown check_type $check_type"
fi

rm -rf bandaid_build;

cp -r nano_build bandaid_build;

rm -rf banano_build/.git;
rm -rf bandaid_build/.git;
rm -rf banano_build/.github;
rm -rf bandaid_build/.github;

###
#### SECURITY.md should not be in banano's repo, as it lists PRs in nano's repo.
rm -f banano_build/SECURITY.md;
rm -f bandaid_build/SECURITY.md;
###

cp banano_build/rep_weights_live.bin bandaid_build/rep_weights_live.bin;
cp banano_build/Info.plist.in bandaid_build/Info.plist.in;
cp banano_build/README.md bandaid_build/README.md;
cp banano_build/Banano.rc bandaid_build/Banano.rc;
cp banano_build/banano.ico bandaid_build/banano.ico;
cp banano_build/banano.png bandaid_build/banano.png;
cp banano_build/docker/node/Dockerfile bandaid_build/docker/node/Dockerfile;
cp banano_build/docker/node/Dockerfile-alpine bandaid_build/docker/node/Dockerfile-alpine;
cp banano_build/docker/node/build.sh bandaid_build/docker/node/build.sh;
cp banano_build/docker/node/entry.sh bandaid_build/docker/node/entry.sh;
cp banano_build/logo.png bandaid_build/logo.png;
cp banano_build/Nano.ico bandaid_build/Nano.ico;
cp banano_build/rep_weights_beta.bin bandaid_build/rep_weights_beta.bin;

#### files that have been edited by banano
## TODO: process this list.
cp banano_build/nanocurrency.spec.in bandaid_build/nanocurrency.spec.in;
cp banano_build/util/changelog.py bandaid_build/util/changelog.py;
## end of list to process.

#CMakeLists.txt
awk  'NR==53 { sub("Nano Currency", "Bananocoin") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==165 || NR==178 || NR==191 || NR==364 || NR==630 || NR==691 || NR==728 || NR==738 || NR==739 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==738 || NR==739 || NR=742 || NR=744 || NR=745 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==177 || NR==179 || NR==190 || NR==192 || NR==203 || NR==205 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==717 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==719 { sub("nano_rpc", "banano_rpc") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==764 || NR==765 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

#api/flatbuffers/nanoapi.fbs
awk  'NR==3 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/api/flatbuffers/nanoapi.fbs > bandaid_build/api/flatbuffers/nanoapi.fbs.awk
mv bandaid_build/api/flatbuffers/nanoapi.fbs.awk bandaid_build/api/flatbuffers/nanoapi.fbs;

#ci/actions/linux/deploy-docker.sh
awk  'NR==31 || NR==48 || NR==49 || NR==50 || NR==54 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/ci/actions/linux/deploy-docker.sh > bandaid_build/ci/actions/linux/deploy-docker.sh.awk
mv bandaid_build/ci/actions/linux/deploy-docker.sh.awk bandaid_build/ci/actions/linux/deploy-docker.sh;

#ci/actions/linux/install_deps.sh
awk  'NR==5 || NR==6 || NR==7 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/ci/actions/linux/install_deps.sh > bandaid_build/ci/actions/linux/install_deps.sh.awk
mv bandaid_build/ci/actions/linux/install_deps.sh.awk bandaid_build/ci/actions/linux/install_deps.sh;

#ci/build-centos.sh
awk  'NR==13 || NR==14 || NR==18 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/ci/build-centos.sh > bandaid_build/ci/build-centos.sh.awk
mv bandaid_build/ci/build-centos.sh.awk bandaid_build/ci/build-centos.sh;

#ci/deploy-docker.sh
awk  'NR==11 || NR==18 || NR==19 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/ci/deploy-docker.sh > bandaid_build/ci/deploy-docker.sh.awk
mv bandaid_build/ci/deploy-docker.sh.awk bandaid_build/ci/deploy-docker.sh;

awk  'NR==18 || NR==38 || NR==39 || NR==42 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/ci/deploy-docker.sh > bandaid_build/ci/deploy-docker.sh.awk
mv bandaid_build/ci/deploy-docker.sh.awk bandaid_build/ci/deploy-docker.sh;

#debian-control/postinst.in
awk  'NR==5 || NR==6 || NR==8 || NR==9 || NR==10 || NR==11  { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/debian-control/postinst.in > bandaid_build/debian-control/postinst.in.awk
mv bandaid_build/debian-control/postinst.in.awk bandaid_build/debian-control/postinst.in;

awk  'NR==11  { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/debian-control/postinst.in > bandaid_build/debian-control/postinst.in.awk
mv bandaid_build/debian-control/postinst.in.awk bandaid_build/debian-control/postinst.in;

awk  'NR==8 || NR==9 || NR==10 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/debian-control/postinst.in > bandaid_build/debian-control/postinst.in.awk
mv bandaid_build/debian-control/postinst.in.awk bandaid_build/debian-control/postinst.in;

#doxygen.config
awk  'NR==35 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/doxygen.config > bandaid_build/doxygen.config.awk
mv bandaid_build/doxygen.config.awk bandaid_build/doxygen.config;

#etc/systemd/nanocurrency-beta.service
awk  'NR==2 || NR==8 || NR==9 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency-beta.service > bandaid_build/etc/systemd/nanocurrency-beta.service.awk
mv bandaid_build/etc/systemd/nanocurrency-beta.service.awk bandaid_build/etc/systemd/nanocurrency-beta.service;

awk  'NR==7 || NR==8 || NR==9 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency-beta.service > bandaid_build/etc/systemd/nanocurrency-beta.service.awk
mv bandaid_build/etc/systemd/nanocurrency-beta.service.awk bandaid_build/etc/systemd/nanocurrency-beta.service;

#etc/systemd/nanocurrency-test.service
awk  'NR==2 || NR==8 || NR==9 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency-test.service > bandaid_build/etc/systemd/nanocurrency-test.service.awk
mv bandaid_build/etc/systemd/nanocurrency-test.service.awk bandaid_build/etc/systemd/nanocurrency-test.service;

awk  'NR==7 || NR==8 || NR==9 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency-test.service > bandaid_build/etc/systemd/nanocurrency-test.service.awk
mv bandaid_build/etc/systemd/nanocurrency-test.service.awk bandaid_build/etc/systemd/nanocurrency-test.service;

#etc/systemd/nanocurrency.service
awk  'NR==2 || NR==8 || NR==9 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency.service > bandaid_build/etc/systemd/nanocurrency.service.awk
mv bandaid_build/etc/systemd/nanocurrency.service.awk bandaid_build/etc/systemd/nanocurrency.service;

awk  'NR==7 || NR==8 || NR==9 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency.service > bandaid_build/etc/systemd/nanocurrency.service.awk
mv bandaid_build/etc/systemd/nanocurrency.service.awk bandaid_build/etc/systemd/nanocurrency.service;

#nano/core_test/block.cpp
awk  'NR==512 || NR==515 || NR==554 || NR==557 || NR==573 || NR==615 || NR==618 || NR==669 || NR==707 { sub("xrb_", "ban_") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

awk  'NR==629 || NR==630 { sub("xrb_3t6k35gi95xu6tergt6p69ck76ogmitsa8mnijtpxm9fkcm736xtoncuohr3", "ban_1bananobh5rat99qfgt1ptpieie5swmoth87thi74qgbfrij7dcgjiij94xr") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

awk  'NR==631 || NR==634 { sub("E89208DD038FBB269987689621D52292AE9C35941A7484756ECCED92A65093BA", "2514452A978F08D1CF76BB40B6AD064183CF275D3CC5D3E0515DC96E2112AD4E") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

awk  'NR==633 { sub("991CF190094C00F0B68E2E5F75F6BEE95A2E0BD93CEAA4A6734DB9F19B728948", "F61A79F286ABC5CC01D3D09686F0567812B889A5C63ADE0E82DD30F3B2D96463") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

awk  'NR==713 { sub("nano_1gys8r4crpxhp94n4uho5cshaho81na6454qni5gu9n53gksoyy1wcd4udyb", "ban_1gys8r4crpxhp94n4uho5cshaho81na6454qni5gu9n53gksoyy1wcd4udyb") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

#nano/core_test/difficulty.cpp
awk  'NR==57 { sub("0xffffffc000000000", "0xfffffe0000000000") }; { print $0 }' bandaid_build/nano/core_test/difficulty.cpp > bandaid_build/nano/core_test/difficulty.cpp.awk
mv bandaid_build/nano/core_test/difficulty.cpp.awk bandaid_build/nano/core_test/difficulty.cpp;

awk  'NR==114 { sub("8.", "1e-10") }; { print $0 }' bandaid_build/nano/core_test/difficulty.cpp > bandaid_build/nano/core_test/difficulty.cpp.awk
mv bandaid_build/nano/core_test/difficulty.cpp.awk bandaid_build/nano/core_test/difficulty.cpp;

#nano/core_test/message.cpp
awk  'NR==55 { sub("0x52", "0x42") }; { print $0 }' bandaid_build/nano/core_test/message.cpp > bandaid_build/nano/core_test/message.cpp.awk
mv bandaid_build/nano/core_test/message.cpp.awk bandaid_build/nano/core_test/message.cpp;

#nano/core_test/toml.cpp
awk  'NR==416 { sub("nano_3arg3asgtigae3xckabaaewkx3bzsh7nwz7jkmjos79ihyaxwphhm6qgjps4", "bano_3arg3asgtigae3xckabaaewkx3bzsh7nwz7jkmjos79ihyaxwphhm6qgjps4") }; { print $0 }' bandaid_build/nano/core_test/toml.cpp > bandaid_build/nano/core_test/toml.cpp.awk
mv bandaid_build/nano/core_test/toml.cpp.awk bandaid_build/nano/core_test/toml.cpp;

awk  'NR==534 { sub("nano_rpc", "banano_rpc") }; { print $0 }' bandaid_build/nano/core_test/toml.cpp > bandaid_build/nano/core_test/toml.cpp.awk
mv bandaid_build/nano/core_test/toml.cpp.awk bandaid_build/nano/core_test/toml.cpp;

#nano/core_test/uint256_union.cpp
awk  'NR==102 || NR==105 { sub("340,282,366", "3,402,823,669") }; { print $0 }' bandaid_build/nano/core_test/uint256_union.cpp > bandaid_build/nano/core_test/uint256_union.cpp.awk
mv bandaid_build/nano/core_test/uint256_union.cpp.awk bandaid_build/nano/core_test/uint256_union.cpp;

awk  'NR==103 { sub("340,282,366.920938463463374607431768211455", "3,402,823,669.20938463463374607431768211455") }; { print $0 }' bandaid_build/nano/core_test/uint256_union.cpp > bandaid_build/nano/core_test/uint256_union.cpp.awk
mv bandaid_build/nano/core_test/uint256_union.cpp.awk bandaid_build/nano/core_test/uint256_union.cpp;

awk  'NR==106 { sub("340,282,366.920938463463374607431768211454", "3,402,823,669.20938463463374607431768211454") }; { print $0 }' bandaid_build/nano/core_test/uint256_union.cpp > bandaid_build/nano/core_test/uint256_union.cpp.awk
mv bandaid_build/nano/core_test/uint256_union.cpp.awk bandaid_build/nano/core_test/uint256_union.cpp;

awk  'NR==371 || NR==384 || NR==402 { sub("xrb", "ban") }; { print $0 }' bandaid_build/nano/core_test/uint256_union.cpp > bandaid_build/nano/core_test/uint256_union.cpp.awk
mv bandaid_build/nano/core_test/uint256_union.cpp.awk bandaid_build/nano/core_test/uint256_union.cpp;

awk  'NR==372  { sub("nano", "ban") }; { print $0 }' bandaid_build/nano/core_test/uint256_union.cpp > bandaid_build/nano/core_test/uint256_union.cpp.awk
mv bandaid_build/nano/core_test/uint256_union.cpp.awk bandaid_build/nano/core_test/uint256_union.cpp;


awk  'NR==386 || NR==404 { sub("\047x\047", "\047b\047") }; { print $0 }' bandaid_build/nano/core_test/uint256_union.cpp > bandaid_build/nano/core_test/uint256_union.cpp.awk
mv bandaid_build/nano/core_test/uint256_union.cpp.awk bandaid_build/nano/core_test/uint256_union.cpp;

#nano/core_test/wallet.cpp
awk  'NR==343 || NR==360 { sub("xrb", "ban") }; { print $0 }' bandaid_build/nano/core_test/wallet.cpp > bandaid_build/nano/core_test/wallet.cpp.awk
mv bandaid_build/nano/core_test/wallet.cpp.awk bandaid_build/nano/core_test/wallet.cpp;

#nano/core_test/wallet.cpp
awk  'NR==346 { sub("65", "64") }; { print $0 }' bandaid_build/nano/core_test/wallet.cpp > bandaid_build/nano/core_test/wallet.cpp.awk
mv bandaid_build/nano/core_test/wallet.cpp.awk bandaid_build/nano/core_test/wallet.cpp;


awk  'NR==345 || NR==362 { sub("\047x\047", "\047b\047") }; { print $0 }' bandaid_build/nano/core_test/wallet.cpp > bandaid_build/nano/core_test/wallet.cpp.awk
mv bandaid_build/nano/core_test/wallet.cpp.awk bandaid_build/nano/core_test/wallet.cpp;

#nano/core_test/websocket.cpp
awk  'NR==174 || NR==607 { sub("xrb", "ban") }; { print $0 }' bandaid_build/nano/core_test/websocket.cpp > bandaid_build/nano/core_test/websocket.cpp.awk
mv bandaid_build/nano/core_test/websocket.cpp.awk bandaid_build/nano/core_test/websocket.cpp;

#nano/ipc_flatbuffers_lib/flatbuffer_producer.hpp
awk  'NR==13 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/ipc_flatbuffers_lib/flatbuffer_producer.hpp > bandaid_build/nano/ipc_flatbuffers_lib/flatbuffer_producer.hpp.awk
mv bandaid_build/nano/ipc_flatbuffers_lib/flatbuffer_producer.hpp.awk bandaid_build/nano/ipc_flatbuffers_lib/flatbuffer_producer.hpp;

#nano/lib/blockbuilders.hpp
awk  'NR==100 || NR==106 || NR==122 || NR==145 || NR==178 || NR==205 || NR==151 { sub("xrb", "ban") }; { print $0 }' bandaid_build/nano/lib/blockbuilders.hpp > bandaid_build/nano/lib/blockbuilders.hpp.awk
mv bandaid_build/nano/lib/blockbuilders.hpp.awk bandaid_build/nano/lib/blockbuilders.hpp;

#nano/lib/config.cpp
awk  'NR==29 { sub("0xffffffc000000000", "0xfffffe0000000000") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

awk  'NR==30 { sub("0xfffffff800000000, // 8x higher than epoch_1", "0xfffffff000000000, // 32x higher than originally") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

awk  'NR==31 { sub("0xfffffe0000000000 // 8x lower than epoch_1", "0x0000000000000000 // remove receive work requirements") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

awk  'NR==48 { sub("0xffffffc000000000", "0xfffffe0000000000") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

awk  'NR==267 { sub("RX", "BT") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

#nano/lib/config.hpp
awk  'NR==70 { sub("0x5241", "0x4241") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==72 { sub("0x5242", "0x4242") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==74 { sub("0x5243", "0x4258") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==76 { sub("0x5258", "0x4243") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==70 || NR==72 || NR==74 || NR==76 { sub("R", "B") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==74 { sub("C", "X") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==76 { sub("X", "C") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

# awk  'NR==70 || NR==73 || NR==76 || NR==79 { sub("rai", "banano") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
# mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==142 { sub("1000; // 0.1%", "2000; // 0.2%") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==144 { sub("7075", "7071") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==147 { sub("7076", "7072") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==150 { sub("7077", "7073") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==153 { sub("7078", "7074") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

#nano/lib/numbers.cpp
# note: includes strange codes to use a single quote in an awk pattern.
awk  'NR==54 { sub("destination_a.append \\(\"_onan\"\\); // nano_", "destination_a.append (\"_nab\");") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

awk  'NR==90 || NR==93 || NR==96 || NR==98 { sub("xrb", "ban") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

awk  'NR==90 { sub("\047b\047", "\047n\047") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

awk  'NR==90 { sub("\047r\047", "\047a\047") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

awk  'NR==90 { sub("\047x\047", "\047b\047") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

awk  'NR==91 { sub("source_a\\[0\\] == \047n\047", "source_a[0] == \047b\047") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

awk  'NR==11 { sub("Gxrb_ratio = nano::uint128_t \\(\"1000000000000000000000000000000000\"\\); // 10\\^33", "MBAN_ratio = nano::uint128_t (\"100000000000000000000000000000000000\"); // 10^35 = 1 million banano") }; { print $0 }' bandaid_build/nano/lib/numbers.hpp > bandaid_build/nano/lib/numbers.hpp.awk
mv bandaid_build/nano/lib/numbers.hpp.awk bandaid_build/nano/lib/numbers.hpp;

awk  'NR==12 { sub("Mxrb_ratio = nano::uint128_t \\(\"1000000000000000000000000000000\"\\); // 10\\^30", "BAN_ratio = nano::uint128_t (\"100000000000000000000000000000\"); // 10^29 = 1 banano") }; { print $0 }' bandaid_build/nano/lib/numbers.hpp > bandaid_build/nano/lib/numbers.hpp.awk
mv bandaid_build/nano/lib/numbers.hpp.awk bandaid_build/nano/lib/numbers.hpp;

awk  'NR==13 { sub("kxrb_ratio = nano::uint128_t \\(\"1000000000000000000000000000\"\\); // 10\\^27", "banoshi_ratio = nano::uint128_t (\"1000000000000000000000000000\"); // 10^27 = 1 hundredth banano") }; { print $0 }' bandaid_build/nano/lib/numbers.hpp > bandaid_build/nano/lib/numbers.hpp.awk
mv bandaid_build/nano/lib/numbers.hpp.awk bandaid_build/nano/lib/numbers.hpp;

awk  'NR==14 { sub("nano::uint128_t \\(\"1000000000000000000000000\"\\); // 10\\^24", "nano::uint128_t (\"1\"); // 10^0") }; { print $0 }' bandaid_build/nano/lib/numbers.hpp > bandaid_build/nano/lib/numbers.hpp.awk
mv bandaid_build/nano/lib/numbers.hpp.awk bandaid_build/nano/lib/numbers.hpp;


#nano/lib/plat/windows/registry.cpp
awk  'NR==8 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/lib/plat/windows/registry.cpp > bandaid_build/nano/lib/plat/windows/registry.cpp.awk
mv bandaid_build/nano/lib/plat/windows/registry.cpp.awk bandaid_build/nano/lib/plat/windows/registry.cpp;

awk  'NR==8 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/lib/plat/windows/registry.cpp > bandaid_build/nano/lib/plat/windows/registry.cpp.awk
mv bandaid_build/nano/lib/plat/windows/registry.cpp.awk bandaid_build/nano/lib/plat/windows/registry.cpp;

#nano/lib/rpcconfig.cpp
awk  'NR==286 { sub("nano_rpc", "banano_rpc") }; { print $0 }' bandaid_build/nano/lib/rpcconfig.cpp > bandaid_build/nano/lib/rpcconfig.cpp.awk
mv bandaid_build/nano/lib/rpcconfig.cpp.awk bandaid_build/nano/lib/rpcconfig.cpp;

#nano/nano_node/CMakeLists.txt
awk  'NR==1 || NR==4 || NR==13 || NR==17 || NR==21 || NR==25 || NR==27 || NR==29 || NR==34 || NR==36 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/nano/nano_node/CMakeLists.txt > bandaid_build/nano/nano_node/CMakeLists.txt.awk
mv bandaid_build/nano/nano_node/CMakeLists.txt.awk bandaid_build/nano/nano_node/CMakeLists.txt;

awk  'NR==18 { sub(" -DGIT_COMMIT_HASH", "-DGIT_COMMIT_HASH") }; { print $0 }' bandaid_build/nano/nano_node/CMakeLists.txt > bandaid_build/nano/nano_node/CMakeLists.txt.awk
mv bandaid_build/nano/nano_node/CMakeLists.txt.awk bandaid_build/nano/nano_node/CMakeLists.txt;

awk  'NR==22 { sub(" \"-DQT_NO_KEYWORDS", "\"-DQT_NO_KEYWORDS") }; { print $0 }' bandaid_build/nano/nano_node/CMakeLists.txt > bandaid_build/nano/nano_node/CMakeLists.txt.awk
mv bandaid_build/nano/nano_node/CMakeLists.txt.awk bandaid_build/nano/nano_node/CMakeLists.txt;

#nano/nano_node/daemon.cpp
awk  'NR==116 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/nano_node/daemon.cpp > bandaid_build/nano/nano_node/daemon.cpp.awk
mv bandaid_build/nano/nano_node/daemon.cpp.awk bandaid_build/nano/nano_node/daemon.cpp;

#nano/nano_node/entry.cpp
awk  'NR==1906 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/nano_node/entry.cpp > bandaid_build/nano/nano_node/entry.cpp.awk
mv bandaid_build/nano/nano_node/entry.cpp.awk bandaid_build/nano/nano_node/entry.cpp;

awk  'NR==1906 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/nano_node/entry.cpp > bandaid_build/nano/nano_node/entry.cpp.awk
mv bandaid_build/nano/nano_node/entry.cpp.awk bandaid_build/nano/nano_node/entry.cpp;

#nano/nano_rpc/CMakeLists.txt
awk  'NR==1 || NR==4 || NR==16 || NR==23 || NR==25 { sub("nano_rpc", "banano_rpc") }; { print $0 }' bandaid_build/nano/nano_rpc/CMakeLists.txt > bandaid_build/nano/nano_rpc/CMakeLists.txt.awk
mv bandaid_build/nano/nano_rpc/CMakeLists.txt.awk bandaid_build/nano/nano_rpc/CMakeLists.txt;

#nano/nano_wallet/entry.cpp
awk  'NR==30 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/nano_wallet/entry.cpp > bandaid_build/nano/nano_wallet/entry.cpp.awk
mv bandaid_build/nano/nano_wallet/entry.cpp.awk bandaid_build/nano/nano_wallet/entry.cpp;

#nano/node/bootstrap/bootstrap_frontier.cpp
awk  'NR==36 || NR==209 || NR==308 || NR==324 { sub("%1%", "%1%, to %2%") }; { print $0 }' bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp > bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk
mv bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp;

awk  'NR==36 { sub("ec.message ()", "ec.message () % this_l->connection->channel->to_string ") }; { print $0 }' bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp > bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk
mv bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp;

awk  'NR==209 { sub("ec.message ()", "ec.message () % connection->channel->to_string ") }; { print $0 }' bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp > bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk
mv bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp;

awk  'NR==308 || NR==324 { sub("ec.message ()", "ec.message () % connection->socket->remote_endpoint ") }; { print $0 }' bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp > bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk
mv bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp;

#nano/node/cli.cpp
awk  'NR==701 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/cli.cpp > bandaid_build/nano/node/cli.cpp.awk
mv bandaid_build/nano/node/cli.cpp.awk bandaid_build/nano/node/cli.cpp;

#nano/node/json_handler.hpp
awk  'NR==77 || NR==78 { sub("Mxrb_ratio", "BAN_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.hpp > bandaid_build/nano/node/json_handler.hpp.awk
mv bandaid_build/nano/node/json_handler.hpp.awk bandaid_build/nano/node/json_handler.hpp;

#nano/node/json_handler.cpp
awk  'NR==101 { sub("krai_from_raw", "banoshi_from_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==103 || NR==107 { sub("kxrb_ratio", "banoshi_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==105 { sub("krai_to_raw", "banoshi_to_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==111 || NR==115 { sub("xrb_ratio", "RAW_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==109 { sub("rai_from_raw", "raw_from_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==113 { sub("rai_to_raw", "raw_to_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==117 { sub("mrai_from_raw", "ban_from_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==121 { sub("mrai_to_raw", "ban_to_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2803 || NR==2821 { sub("Mxrb_ratio", "BAN_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4212 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

#nano/node/logging.cpp
awk  'NR==42 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/logging.cpp > bandaid_build/nano/node/logging.cpp.awk
mv bandaid_build/nano/node/logging.cpp.awk bandaid_build/nano/node/logging.cpp;

awk  'NR==42 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/logging.cpp > bandaid_build/nano/node/logging.cpp.awk
mv bandaid_build/nano/node/logging.cpp.awk bandaid_build/nano/node/logging.cpp;

#nano/node/node.cpp
awk  'NR==397 { sub("XRB", "BAN") }; { print $0 }' bandaid_build/nano/node/node.cpp > bandaid_build/nano/node/node.cpp.awk
mv bandaid_build/nano/node/node.cpp.awk bandaid_build/nano/node/node.cpp;

#nano/node/node_pow_server_config.cpp
awk  'NR==6 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/node_pow_server_config.cpp > bandaid_build/nano/node/node_pow_server_config.cpp.awk
mv bandaid_build/nano/node/node_pow_server_config.cpp.awk bandaid_build/nano/node/node_pow_server_config.cpp;

#nano/qt/qt.cpp
awk  'NR==62 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/qt/qt.cpp > bandaid_build/nano/qt/qt.cpp.awk
mv bandaid_build/nano/qt/qt.cpp.awk bandaid_build/nano/qt/qt.cpp;

awk  'NR==1828 || NR==1002 { sub("Mxrb_ratio", "BAN_ratio") }; { print $0 }' bandaid_build/nano/qt/qt.cpp > bandaid_build/nano/qt/qt.cpp.awk
mv bandaid_build/nano/qt/qt.cpp.awk bandaid_build/nano/qt/qt.cpp;

#nano/rpc_test/rpc.cpp
awk  'NR==1917 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/rpc_test/rpc.cpp > bandaid_build/nano/rpc_test/rpc.cpp.awk
mv bandaid_build/nano/rpc_test/rpc.cpp.awk bandaid_build/nano/rpc_test/rpc.cpp;

awk  'NR==2411 || NR==2417 { sub("mrai_to_raw", "ban_to_raw") }; { print $0 }' bandaid_build/nano/rpc_test/rpc.cpp > bandaid_build/nano/rpc_test/rpc.cpp.awk
mv bandaid_build/nano/rpc_test/rpc.cpp.awk bandaid_build/nano/rpc_test/rpc.cpp;

awk  'NR==2423 { sub("mrai_from_raw", "ban_from_raw") }; { print $0 }' bandaid_build/nano/rpc_test/rpc.cpp > bandaid_build/nano/rpc_test/rpc.cpp.awk
mv bandaid_build/nano/rpc_test/rpc.cpp.awk bandaid_build/nano/rpc_test/rpc.cpp;

awk  'NR==2435 || NR==2441 { sub("krai_to_raw", "banoshi_to_raw") }; { print $0 }' bandaid_build/nano/rpc_test/rpc.cpp > bandaid_build/nano/rpc_test/rpc.cpp.awk
mv bandaid_build/nano/rpc_test/rpc.cpp.awk bandaid_build/nano/rpc_test/rpc.cpp;

awk  'NR==2447 { sub("krai_from_raw", "banoshi_from_raw") }; { print $0 }' bandaid_build/nano/rpc_test/rpc.cpp > bandaid_build/nano/rpc_test/rpc.cpp.awk
mv bandaid_build/nano/rpc_test/rpc.cpp.awk bandaid_build/nano/rpc_test/rpc.cpp;

#nano/node/nodeconfig.cpp
awk  'NR==19 { sub("peering.nano.org", "livenet.banano.cc") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

awk  'NR==52 { sub("nano_1defau1t9off1ine9rep99999999999999999999999999999999wgmuzxxy", "bano_1defau1t9off1ine9rep99999999999999999999999999999999wgmuzxxy") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

awk  'NR==58 { sub("A30E0A32ED41C8607AA9212843392E853FCBCB4E7CB194E35C94F07F91DE59EF", "36B3AFC042CCB5099DC163FA2BFE42D6E486991B685EAAB0DF73714D91A59400") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

awk  'NR==59 { sub("67556D31DDFC2A440BF6147501449B4CB9572278D034EE686A6BEE29851681DF", "29126049B40D1755C0A1C02B71646EEAB9E1707C16E94B47100F3228D59B1EB2") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

awk  'NR==60 { sub("5C2FBB148E006A8E8BA7A75DD86C9FE00C83F5FFDBFD76EAA09531071436B6AF", "2514452A978F08D1CF76BB40B6AD064183CF275D3CC5D3E0515DC96E2112AD4E") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

awk  'NR==61 { sub("AE7AC63990DAAAF2A69BF11C913B928844BF5012355456F2F164166464024B29", "2B0C65A063CEC23725E70DB2D39163C48020D66F7C8E0352C1DA8C853E14F8F5") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

awk  'NR==62 { sub("BD6267D6ECD8038327D2BCC0850BDF8F56EC0414912207E81BCF90DFAC8A4AAA", "6A164D74E73321CE4D6CD49D6948ECFAF4490FBE2BAAF3EBBF4C85F96AD637C0") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

awk  'NR==63 { sub("2399A083C600AA0572F5E36247D978FCFC840405F8D4B6D33161C0066A55F431", "490086E62B376C0EFBAA6AF9C41269EE7D723F98B4667416F075951E981E3F37") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

awk  'NR==64 { sub("preconfigured_representatives.emplace_back \\(\"2298FAB7C61058E77EA554CB93EDEEDA0692CBFCC540AB213B2836B29029E23A\"\\);", "// removed a preconfigured_representative") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

awk  'NR==65 { sub("			preconfigured_representatives.emplace_back \\(\"3FE80B4BC842E82C1C18ABFEEC47EA989E63953BC82AC411F304D13833D52A56\"\\);", "") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

#nano/node/nodeconfig.hpp
awk  'NR==49 { sub("8076", "8072") }; { print $0 }' bandaid_build/nano/node/nodeconfig.hpp > bandaid_build/nano/node/nodeconfig.hpp.awk
mv bandaid_build/nano/node/nodeconfig.hpp.awk bandaid_build/nano/node/nodeconfig.hpp;

awk  'NR==53 { sub("xrb_ratio", "RAW_ratio") }; { print $0 }' bandaid_build/nano/node/nodeconfig.hpp > bandaid_build/nano/node/nodeconfig.hpp.awk
mv bandaid_build/nano/node/nodeconfig.hpp.awk bandaid_build/nano/node/nodeconfig.hpp;

awk  'NR==58 { sub("60000", "900") }; { print $0 }' bandaid_build/nano/node/nodeconfig.hpp > bandaid_build/nano/node/nodeconfig.hpp.awk
mv bandaid_build/nano/node/nodeconfig.hpp.awk bandaid_build/nano/node/nodeconfig.hpp;

awk  'NR==95 { sub("10 \\* 1024", "2 * 1024") }; { print $0 }' bandaid_build/nano/node/nodeconfig.hpp > bandaid_build/nano/node/nodeconfig.hpp.awk
mv bandaid_build/nano/node/nodeconfig.hpp.awk bandaid_build/nano/node/nodeconfig.hpp;

#nano/node/portmapping.cpp
awk  'NR==109 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/portmapping.cpp > bandaid_build/nano/node/portmapping.cpp.awk
mv bandaid_build/nano/node/portmapping.cpp.awk bandaid_build/nano/node/portmapping.cpp;

#nano/secure/common.cpp
awk  'NR==30 || NR==37 || NR==38 { sub("xrb", "ban") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==32 { sub("E89208DD038FBB269987689621D52292AE9C35941A7484756ECCED92A65093BA", "2514452A978F08D1CF76BB40B6AD064183CF275D3CC5D3E0515DC96E2112AD4E") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==32 { sub("xrb_3t6k35gi95xu6tergt6p69ck76ogmitsa8mnijtpxm9fkcm736xtoncuohr3", "ban_1bananobh5rat99qfgt1ptpieie5swmoth87thi74qgbfrij7dcgjiij94xr") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==46 || NR==47 { sub("nano_1betagoxpxwykx4kw86dnhosc8t3s7ix8eeentwkcg1hbpez1outjrcyg4n1", "bano_1betagoxpxwykx4kw86dnhosc8t3s7ix8eeentwkcg1hbpez1outjrcyg4n1") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==54 { sub("E89208DD038FBB269987689621D52292AE9C35941A7484756ECCED92A65093BA", "2514452A978F08D1CF76BB40B6AD064183CF275D3CC5D3E0515DC96E2112AD4E") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==55 || NR==56 { sub("xrb_3t6k35gi95xu6tergt6p69ck76ogmitsa8mnijtpxm9fkcm736xtoncuohr3", "ban_1bananobh5rat99qfgt1ptpieie5swmoth87thi74qgbfrij7dcgjiij94xr") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==57 { sub("62f05417dd3fb691", "fa055f79fa56abcf") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==58 { sub("9F0C933C8ADE004D808EA1985FA746A7E95BA2A38F867640F53EC8F180BDFE9E2C1268DEAD7C2664F356E37ABA362BC58E46DBA03E523A7B5A19E4B6EB12BB02", "533DCAB343547B93C4128E779848DEA5877D3278CB5EA948BB3A9AA1AE0DB293DE6D9DA4F69E8D1DDFA385F9B4C5E4F38DFA42C00D7B183560435D07AFA18900") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==64 || NR==65 { sub("nano_1jg8zygjg3pp5w644emqcbmjqpnzmubfni3kfe1s8pooeuxsw49fdq1mco9j", "bano_1jg8zygjg3pp5w644emqcbmjqpnzmubfni3kfe1s8pooeuxsw49fdq1mco9j") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==78 { sub("868C6A9F79D4506E029B378262B91538C5CB26D7C346B63902FFEB365F1C1947", "B61453D27E843EB30B8288E37D5E7C64447F9202E589AB9E573DA4460DF7B21B") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==78 { sub("nano_33nefchqmo4ifr3bpfw4ecwjcg87semfhit8prwi7zzd8shjr8c9qdxeqmnx", "ban_3finchb9x33ype7r7495hoh9rs46hyb17sebogh7ghf6ar8zheiucm87mfha") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==79 { sub("7CBAF192A3763DAEC9F9BAC1B2CDF665D8369F8400B4BC5AB4BA31C00BAA4404", "B61453D27E843EB30B8288E37D5E7C64447F9202E589AB9E573DA4460DF7B21B") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==79 { sub("nano_1z7ty8bc8xjxou6zmgp3pd8zesgr8thra17nqjfdbgjjr17tnj16fjntfqfn", "ban_3finchb9x33ype7r7495hoh9rs46hyb17sebogh7ghf6ar8zheiucm87mfha") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==80 { sub("3BAD2C554ACE05F5E528FBBCE79D51E552C55FA765CCFD89B289C4835DE5F04A", "B61453D27E843EB30B8288E37D5E7C64447F9202E589AB9E573DA4460DF7B21B") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==80 { sub("nano_1gxf7jcnomi7yqkkjyxwwygo5sckrohtgsgezp6u74g6ifgydw4cajwbk8bf", "ban_3finchb9x33ype7r7495hoh9rs46hyb17sebogh7ghf6ar8zheiucm87mfha") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==94 { sub("\047R\047, \047A\047", "\047B\047, \047Z\047") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==94 { sub("\047R\047, \047B\047", "\047B\047, \047Y\047") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==94 { sub("\047R\047, \047C\047", "\047B\047, \047X\047") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==146 { sub("nano_3qb6o6i1tkzr6jwr5s7eehfxwg9x6eemitdinbpi7u8bjjwsgqfj4wzser3x", "bano_3qb6o6i1tkzr6jwr5s7eehfxwg9x6eemitdinbpi7u8bjjwsgqfj4wzser3x") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

# nano/secure/common.hpp
awk  'NR==359 { sub("0x12", "0x11") }; { print $0 }' bandaid_build/nano/secure/common.hpp > bandaid_build/nano/secure/common.hpp.awk
mv bandaid_build/nano/secure/common.hpp.awk bandaid_build/nano/secure/common.hpp;

#nano/secure/utility.cpp
awk  'NR==18 { sub("NanoDev", "BananoDev") }; { print $0 }' bandaid_build/nano/secure/utility.cpp > bandaid_build/nano/secure/utility.cpp.awk
mv bandaid_build/nano/secure/utility.cpp.awk bandaid_build/nano/secure/utility.cpp;

awk  'NR==21 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/secure/utility.cpp > bandaid_build/nano/secure/utility.cpp.awk
mv bandaid_build/nano/secure/utility.cpp.awk bandaid_build/nano/secure/utility.cpp;

awk  'NR==27 { sub("NanoTest", "BananoTest") }; { print $0 }' bandaid_build/nano/secure/utility.cpp > bandaid_build/nano/secure/utility.cpp.awk
mv bandaid_build/nano/secure/utility.cpp.awk bandaid_build/nano/secure/utility.cpp;

awk  'NR==24 { sub("Nano", "BananoData") }; { print $0 }' bandaid_build/nano/secure/utility.cpp > bandaid_build/nano/secure/utility.cpp.awk
mv bandaid_build/nano/secure/utility.cpp.awk bandaid_build/nano/secure/utility.cpp;

#nanocurrency-beta.spec.in
awk  'NR==1 || NR==13 || NR==45 || NR==60 || NR==61 || NR==62 || NR==66 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==45 || NR==54 || NR==58 || NR==59 || NR==60 || NR==61 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==59 || NR==60 || NR==61 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==60 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==4 || NR==13 || NR==58 || NR==60 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

#util/build_prep/bootstrap_boost.sh
awk  'NR==21 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/util/build_prep/bootstrap_boost.sh > bandaid_build/util/build_prep/bootstrap_boost.sh.awk
mv bandaid_build/util/build_prep/bootstrap_boost.sh.awk bandaid_build/util/build_prep/bootstrap_boost.sh;

#util/build_prep/common.sh
awk  'NR==1 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/util/build_prep/common.sh > bandaid_build/util/build_prep/common.sh.awk
mv bandaid_build/util/build_prep/common.sh.awk bandaid_build/util/build_prep/common.sh;

### for the remainder of the script
### run the replacement once per filename in the given file.
### note: if the filename is listed multiple times, its because the replacement must be ran multiple times.

#Gxrb_ratio-to-MBAN_ratio.txt
while IFS="" read -r p || [ -n "$p" ]
do
  printf 'Gxrb_ratio-to-MBAN_ratio %s\n' "$p"
  awk  '{ sub("Gxrb_ratio", "MBAN_ratio") }; { print $0 }' bandaid_build/$p > bandaid_build/$p.awk
  mv bandaid_build/$p.awk bandaid_build/$p;
done < input/Gxrb_ratio-to-MBAN_ratio.txt

#Mxrb_ratio-to-BAN_ratio.txt
while IFS="" read -r p || [ -n "$p" ]
do
  printf 'Mxrb_ratio-to-BAN_ratio %s\n' "$p"
  awk  '{ sub("Mxrb_ratio", "BAN_ratio") }; { print $0 }' bandaid_build/$p > bandaid_build/$p.awk
  mv bandaid_build/$p.awk bandaid_build/$p;
done < input/Mxrb_ratio-to-BAN_ratio.txt

#xrb_ratio-to-RAW_ratio.txt
while IFS="" read -r p || [ -n "$p" ]
do
  printf 'xrb_ratio-to-RAW_ratio %s\n' "$p"
  awk  '{ sub("xrb_ratio", "RAW_ratio") }; { print $0 }' bandaid_build/$p > bandaid_build/$p.awk
  mv bandaid_build/$p.awk bandaid_build/$p;
done < input/xrb_ratio-to-RAW_ratio.txt

# #MRAW_ratio-to-BAN_ratio.txt
# while IFS="" read -r p || [ -n "$p" ]
# do
#   printf 'MRAW_ratio-to-BAN_ratio %s\n' "$p"
#   awk  '{ sub("MRAW_ratio", "BAN_ratio") }; { print $0 }' bandaid_build/$p > bandaid_build/$p.awk
#   mv bandaid_build/$p.awk bandaid_build/$p;
# done < input/MRAW_ratio-to-BAN_ratio.txt

#kRAW-to-banoshi.txt
while IFS="" read -r p || [ -n "$p" ]
do
  printf 'kRAW-to-banoshi %s\n' "$p"
  awk  '{ sub("kRAW", "banoshi") }; { print $0 }' bandaid_build/$p > bandaid_build/$p.awk
  mv bandaid_build/$p.awk bandaid_build/$p;
done < input/kRAW-to-banoshi.txt

### diff the two directories.
diff -r banano_build bandaid_build | head -n 20;

### print pass/fail based on empty diff or not.
diff -r banano_build bandaid_build >/dev/null 2>&1;
ret=$?

if [[ $ret -eq 0 ]]; then
    echo "passed."
else
    echo "failed."
fi
