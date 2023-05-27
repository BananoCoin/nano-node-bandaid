#!/bin/bash

reset;

# "bandaid_build" is the nano_build with banano changes applied.
# if all the changes are applied correctly, it should be identical to banano_build
# git diff is
# https://github.com/nanocurrency/nano-node/compare/V22.1...BananoCoin:V22dev2
# https://github.com/BananoCoin/banano/compare/v25...nanocurrency:V25.0

check_type=BananoCoin_v25_vs_nanocurrency_v25
# check_type=BananoCoin_master_vs_nanocurrency_v24
# check_type="local"

if [ $check_type = "BananoCoin_v25_vs_nanocurrency_v25" ]
then
  echo "comparing BananoCoin v25 vs nanocurrency releases/v25"
  # --depth 1 means clone with no history.
  rm -rf banano_build;
  rm -rf nano_build;
  git clone -c advice.detachedHead=false --depth 1 --branch v25 https://github.com/BananoCoin/banano.git banano_build;
  git clone -c advice.detachedHead=false --depth 1 --branch V25.0 https://github.com/nanocurrency/nano-node.git nano_build;
elif [ $check_type = "BananoCoin_master_vs_nanocurrency_v24" ]
then
  echo "comparing BananoCoin master vs nanocurrency releases/v24"
  # --depth 1 means clone with no history.
  rm -rf banano_build;
  rm -rf nano_build;
  git clone -c advice.detachedHead=false --depth 1 --branch master https://github.com/BananoCoin/banano.git banano_build;
  git clone -c advice.detachedHead=false --depth 1 --branch V24.0 https://github.com/nanocurrency/nano-node.git nano_build;
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
rm -f banano_build/CODE_OF_CONDUCT.md;
rm -f bandaid_build/CODE_OF_CONDUCT.md;
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

#new code from banano
cp banano_build/nano/lib/convert.cpp bandaid_build/nano/lib/convert.cpp;
cp banano_build/nano/lib/convert.hpp bandaid_build/nano/lib/convert.hpp;

#.gitignore
awk  'NR==33 || NR==34 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/.gitignore > bandaid_build/.gitignore.awk
mv bandaid_build/.gitignore.awk bandaid_build/.gitignore;

awk  'NR==35 || NR==36 { sub("nano_wallet", "banano_wallet") }; { print $0 }' bandaid_build/.gitignore > bandaid_build/.gitignore.awk
mv bandaid_build/.gitignore.awk bandaid_build/.gitignore;

awk  'NR==39 || NR==40 { sub("nano_rpc", "banano_rpc") }; { print $0 }' bandaid_build/.gitignore > bandaid_build/.gitignore.awk
mv bandaid_build/.gitignore.awk bandaid_build/.gitignore;

#nanocurrency.spec.in
awk  'NR==1 || NR==13 || NR==45 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==45 || NR==54 || NR==58 || NR==59 || NR==60 || NR==61 || NR==62 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==59 || NR==60 || NR==61 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==60 || NR==61 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==60 || NR==66 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==4 || NR==58 || NR==60 || NR==61 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==13 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==36 || NR==43 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==43 || NR==52 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==37 || NR==44 { sub("nano_rpc", "banano_rpc") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==44 || NR==53 { sub("/nano_rpc", "/banano_rpc") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

#util/changelog.py
awk  'NR==118 { sub("incremental", "BananoCoin/banano") }; { print $0 }' bandaid_build/util/changelog.py > bandaid_build/util/changelog.py.awk
mv bandaid_build/util/changelog.py.awk bandaid_build/util/changelog.py;

awk  'NR==131 { sub("nanocurrency/nano-node", "BananoCoin/banano") }; { print $0 }' bandaid_build/util/changelog.py > bandaid_build/util/changelog.py.awk
mv bandaid_build/util/changelog.py.awk bandaid_build/util/changelog.py;

#CMakeLists.txt
awk  'NR==53 { sub("Nano Currency", "Bananocoin") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==163  { sub( " nano_", " banano_") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==166 || NR==167 { sub( " nano_", " banano_") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==166 || NR==167 { sub(" nano_", " banano_") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==175 || NR==179 || NR==192 { sub( "\"nano_", "\"banano_") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==165 || NR==178 || NR==172 || NR==185 || NR==198 || NR==691 || NR==728 || NR==738 || NR==739 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

# awk  'NR==738 || NR==739 || NR=742 || NR=744 || NR=745 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
# mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==175 || NR==177 || NR==188 || NR==190 || NR==201 || NR==203 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

# awk  'NR==622 || NR==739 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
# mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

# awk  'NR==622 || NR==741 { sub("nano_rpc", "banano_rpc") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
# mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

# awk  'NR==786 || NR==787 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
# mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

#api/flatbuffers/nanoapi.fbs
awk  'NR==3 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/api/flatbuffers/nanoapi.fbs > bandaid_build/api/flatbuffers/nanoapi.fbs.awk
mv bandaid_build/api/flatbuffers/nanoapi.fbs.awk bandaid_build/api/flatbuffers/nanoapi.fbs;

#ci/test.sh
awk  'NR==59 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/ci/test.sh > bandaid_build/ci/test.sh.awk
mv bandaid_build/ci/test.sh.awk bandaid_build/ci/test.sh;

#ci/build-gitlab.sh
awk  'NR==56 || NR==59 { sub("=nano_", "=banano_") }; { print $0 }' bandaid_build/ci/build-gitlab.sh > bandaid_build/ci/build-gitlab.sh.awk
mv bandaid_build/ci/build-gitlab.sh.awk bandaid_build/ci/build-gitlab.sh;

#ci/actions/linux/deploy-docker.sh
awk  'NR==31 || NR==48 || NR==49 || NR==50 || NR==54 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/ci/actions/linux/docker-deploy.sh > bandaid_build/ci/actions/linux/docker-deploy.sh.awk
mv bandaid_build/ci/actions/linux/docker-deploy.sh.awk bandaid_build/ci/actions/linux/docker-deploy.sh;

#ci/actions/linux/install_deps.sh
awk  'NR==10 || NR==12 || NR==14 || NR==15 || NR==16 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/ci/actions/linux/install_deps.sh > bandaid_build/ci/actions/linux/install_deps.sh.awk
mv bandaid_build/ci/actions/linux/install_deps.sh.awk bandaid_build/ci/actions/linux/install_deps.sh;

#ci/actions/linux/docker-impl/docker-common.sh
awk  'NR==36 { sub("\\$\\{GITHUB_REPOSITORY\\}", "bananocoin") }; { print $0 }' bandaid_build/ci/actions/linux/docker-impl/docker-common.sh > bandaid_build/ci/actions/linux/docker-impl/docker-common.sh.awk
mv bandaid_build/ci/actions/linux/docker-impl/docker-common.sh.awk bandaid_build/ci/actions/linux/docker-impl/docker-common.sh;

# ci/build-docker-image.sh
awk  'NR==11 || NR==23 { sub("\\$\\{GITHUB_REPOSITORY\\}", "bananocoin") }; { print $0 }' bandaid_build/ci/build-docker-image.sh > bandaid_build/ci/build-docker-image.sh.awk
mv bandaid_build/ci/build-docker-image.sh.awk bandaid_build/ci/build-docker-image.sh;

#ci/actions/linux/ghcr_push.sh
awk  'NR==6 || NR==7 || NR==8 || NR==9 { sub("\\$\\{GITHUB_REPOSITORY\\}", "bananocoin") }; { print $0 }' bandaid_build/ci/actions/linux/ghcr_push.sh > bandaid_build/ci/actions/linux/ghcr_push.sh.awk
mv bandaid_build/ci/actions/linux/ghcr_push.sh.awk bandaid_build/ci/actions/linux/ghcr_push.sh;

#ci/actions/deploy.sh
awk  'NR==17 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/ci/actions/deploy.sh > bandaid_build/ci/actions/deploy.sh.awk
mv bandaid_build/ci/actions/deploy.sh.awk bandaid_build/ci/actions/deploy.sh;

awk  'NR==17 { sub("nano-node", "bananode") }; { print $0 }' bandaid_build/ci/actions/deploy.sh > bandaid_build/ci/actions/deploy.sh.awk
mv bandaid_build/ci/actions/deploy.sh.awk bandaid_build/ci/actions/deploy.sh;

#ci/build-centos.sh
awk  'NR==15 || NR==17 || NR==22 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/ci/build-centos.sh > bandaid_build/ci/build-centos.sh.awk
mv bandaid_build/ci/build-centos.sh.awk bandaid_build/ci/build-centos.sh;

#ci/record_rep_weights.py
awk  'NR==56 { sub("nano_", "ban_") }; { print $0 }' bandaid_build/ci/record_rep_weights.py > bandaid_build/ci/record_rep_weights.py.awk
mv bandaid_build/ci/record_rep_weights.py.awk bandaid_build/ci/record_rep_weights.py;

#coverage/CMakeLists.txt 
awk  'NR==37 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/coverage/CMakeLists.txt > bandaid_build/coverage/CMakeLists.txt.awk;
mv bandaid_build/coverage/CMakeLists.txt.awk bandaid_build/coverage/CMakeLists.txt

awk  'NR==38 { sub("nano_wallet", "banano_wallet") }; { print $0 }' bandaid_build/coverage/CMakeLists.txt > bandaid_build/coverage/CMakeLists.txt.awk;
mv bandaid_build/coverage/CMakeLists.txt.awk bandaid_build/coverage/CMakeLists.txt

awk  'NR==39 { sub("nano_rpc", "banano_rpc") }; { print $0 }' bandaid_build/coverage/CMakeLists.txt > bandaid_build/coverage/CMakeLists.txt.awk;
mv bandaid_build/coverage/CMakeLists.txt.awk bandaid_build/coverage/CMakeLists.txt

#debian-control/postinst.in
awk  'NR==5 || NR==6 || NR==8 || NR==9 || NR==10 || NR==11  { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/debian-control/postinst.in > bandaid_build/debian-control/postinst.in.awk
mv bandaid_build/debian-control/postinst.in.awk bandaid_build/debian-control/postinst.in;

awk  'NR==11  { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/debian-control/postinst.in > bandaid_build/debian-control/postinst.in.awk
mv bandaid_build/debian-control/postinst.in.awk bandaid_build/debian-control/postinst.in;

awk  'NR==8 || NR==9 || NR==10 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/debian-control/postinst.in > bandaid_build/debian-control/postinst.in.awk
mv bandaid_build/debian-control/postinst.in.awk bandaid_build/debian-control/postinst.in;

#etc/systemd/nanocurrency-beta.service
awk  'NR==2 || NR==8 || NR==9 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency-beta.service > bandaid_build/etc/systemd/nanocurrency-beta.service.awk
mv bandaid_build/etc/systemd/nanocurrency-beta.service.awk bandaid_build/etc/systemd/nanocurrency-beta.service;

awk  'NR==7 || NR==8 || NR==9 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency-beta.service > bandaid_build/etc/systemd/nanocurrency-beta.service.awk
mv bandaid_build/etc/systemd/nanocurrency-beta.service.awk bandaid_build/etc/systemd/nanocurrency-beta.service;

awk  'NR==7 || NR==8 || NR==9 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency-beta.service > bandaid_build/etc/systemd/nanocurrency-beta.service.awk
mv bandaid_build/etc/systemd/nanocurrency-beta.service.awk bandaid_build/etc/systemd/nanocurrency-beta.service;

#etc/systemd/nanocurrency-test.service
awk  'NR==2 || NR==8 || NR==9 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency-test.service > bandaid_build/etc/systemd/nanocurrency-test.service.awk
mv bandaid_build/etc/systemd/nanocurrency-test.service.awk bandaid_build/etc/systemd/nanocurrency-test.service;

awk  'NR==7 || NR==8 || NR==9 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency-test.service > bandaid_build/etc/systemd/nanocurrency-test.service.awk
mv bandaid_build/etc/systemd/nanocurrency-test.service.awk bandaid_build/etc/systemd/nanocurrency-test.service;

awk  'NR==7 || NR==8 || NR==9 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency-test.service > bandaid_build/etc/systemd/nanocurrency-test.service.awk
mv bandaid_build/etc/systemd/nanocurrency-test.service.awk bandaid_build/etc/systemd/nanocurrency-test.service;

#etc/systemd/nanocurrency.service
awk  'NR==2 || NR==8 || NR==9 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency.service > bandaid_build/etc/systemd/nanocurrency.service.awk
mv bandaid_build/etc/systemd/nanocurrency.service.awk bandaid_build/etc/systemd/nanocurrency.service;

awk  'NR==7 || NR==8 || NR==9 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency.service > bandaid_build/etc/systemd/nanocurrency.service.awk
mv bandaid_build/etc/systemd/nanocurrency.service.awk bandaid_build/etc/systemd/nanocurrency.service;

awk  'NR==7 || NR==8 || NR==9 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/etc/systemd/nanocurrency.service > bandaid_build/etc/systemd/nanocurrency.service.awk
mv bandaid_build/etc/systemd/nanocurrency.service.awk bandaid_build/etc/systemd/nanocurrency.service;

#nano/core_test/telemetry.cpp
awk  'NR==576 { sub("nano_dev_network", "banano_dev_network") }; { print $0 }' bandaid_build/nano/core_test/telemetry.cpp > bandaid_build/nano/core_test/telemetry.cpp.awk
mv bandaid_build/nano/core_test/telemetry.cpp.awk bandaid_build/nano/core_test/telemetry.cpp;

#nano/core_test/block.cpp
awk  'NR==611 || NR==514 || NR==653 || NR==656 || NR==672 || NR==614 || NR==714 || NR==717 || NR==768 || NR==806 { sub("xrb_", "ban_") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

awk  'NR==728 || NR==729 { sub("xrb_3t6k35gi95xu6tergt6p69ck76ogmitsa8mnijtpxm9fkcm736xtoncuohr3", "ban_1bananobh5rat99qfgt1ptpieie5swmoth87thi74qgbfrij7dcgjiij94xr") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

awk  'NR==730 || NR==733 { sub("E89208DD038FBB269987689621D52292AE9C35941A7484756ECCED92A65093BA", "2514452A978F08D1CF76BB40B6AD064183CF275D3CC5D3E0515DC96E2112AD4E") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

awk  'NR==732 { sub("991CF190094C00F0B68E2E5F75F6BEE95A2E0BD93CEAA4A6734DB9F19B728948", "F61A79F286ABC5CC01D3D09686F0567812B889A5C63ADE0E82DD30F3B2D96463") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

awk  'NR==812 { sub("nano_1gys8r4crpxhp94n4uho5cshaho81na6454qni5gu9n53gksoyy1wcd4udyb", "ban_1gys8r4crpxhp94n4uho5cshaho81na6454qni5gu9n53gksoyy1wcd4udyb") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

#nano/core_test/difficulty.cpp
awk  'NR==57 { sub("0xffffffc000000000", "0xfffffe0000000000") }; { print $0 }' bandaid_build/nano/core_test/difficulty.cpp > bandaid_build/nano/core_test/difficulty.cpp.awk
mv bandaid_build/nano/core_test/difficulty.cpp.awk bandaid_build/nano/core_test/difficulty.cpp;

awk  'NR==114 { sub("8.", "1e-10") }; { print $0 }' bandaid_build/nano/core_test/difficulty.cpp > bandaid_build/nano/core_test/difficulty.cpp.awk
mv bandaid_build/nano/core_test/difficulty.cpp.awk bandaid_build/nano/core_test/difficulty.cpp;

#nano/core_test/message.cpp
awk  'NR==75 { sub("0x52", "0x42") }; { print $0 }' bandaid_build/nano/core_test/message.cpp > bandaid_build/nano/core_test/message.cpp.awk
mv bandaid_build/nano/core_test/message.cpp.awk bandaid_build/nano/core_test/message.cpp;

#nano/core_test/toml.cpp
awk  'NR==421 { sub("nano_3arg3asgtigae3xckabaaewkx3bzsh7nwz7jkmjos79ihyaxwphhm6qgjps4", "bano_3arg3asgtigae3xckabaaewkx3bzsh7nwz7jkmjos79ihyaxwphhm6qgjps4") }; { print $0 }' bandaid_build/nano/core_test/toml.cpp > bandaid_build/nano/core_test/toml.cpp.awk
mv bandaid_build/nano/core_test/toml.cpp.awk bandaid_build/nano/core_test/toml.cpp;

awk  'NR==539 { sub("nano_rpc", "banano_rpc") }; { print $0 }' bandaid_build/nano/core_test/toml.cpp > bandaid_build/nano/core_test/toml.cpp.awk
mv bandaid_build/nano/core_test/toml.cpp.awk bandaid_build/nano/core_test/toml.cpp;

#nano/core_test/uint256_union.cpp
awk  'NR==105 || NR==108 { sub("340,282,366", "3,402,823,669") }; { print $0 }' bandaid_build/nano/core_test/uint256_union.cpp > bandaid_build/nano/core_test/uint256_union.cpp.awk
mv bandaid_build/nano/core_test/uint256_union.cpp.awk bandaid_build/nano/core_test/uint256_union.cpp;

awk  'NR==106 { sub("340,282,366.920938463463374607431768211455", "3,402,823,669.20938463463374607431768211455") }; { print $0 }' bandaid_build/nano/core_test/uint256_union.cpp > bandaid_build/nano/core_test/uint256_union.cpp.awk
mv bandaid_build/nano/core_test/uint256_union.cpp.awk bandaid_build/nano/core_test/uint256_union.cpp;

awk  'NR==109 { sub("340,282,366.920938463463374607431768211454", "3,402,823,669.20938463463374607431768211454") }; { print $0 }' bandaid_build/nano/core_test/uint256_union.cpp > bandaid_build/nano/core_test/uint256_union.cpp.awk
mv bandaid_build/nano/core_test/uint256_union.cpp.awk bandaid_build/nano/core_test/uint256_union.cpp;

awk  'NR==374 || NR==401|| NR==419 || NR==405 { sub("xrb", "ban") }; { print $0 }' bandaid_build/nano/core_test/uint256_union.cpp > bandaid_build/nano/core_test/uint256_union.cpp.awk
mv bandaid_build/nano/core_test/uint256_union.cpp.awk bandaid_build/nano/core_test/uint256_union.cpp;

awk  'NR==375  { sub("nano", "ban") }; { print $0 }' bandaid_build/nano/core_test/uint256_union.cpp > bandaid_build/nano/core_test/uint256_union.cpp.awk
mv bandaid_build/nano/core_test/uint256_union.cpp.awk bandaid_build/nano/core_test/uint256_union.cpp;

awk  'NR==403 || NR==421 { sub("\047x\047", "\047b\047") }; { print $0 }' bandaid_build/nano/core_test/uint256_union.cpp > bandaid_build/nano/core_test/uint256_union.cpp.awk
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

#nano/lib/CMakeLists.txt
# awk 'NR==33 { print "  convert.cpp\n  convert.hpp" }; { print $0 }' bandaid_build/nano/lib/CMakeLists.txt > bandaid_build/nano/lib/CMakeLists.txt.awk
# mv bandaid_build/nano/lib/CMakeLists.txt.awk bandaid_build/nano/lib/CMakeLists.txt;

#nano/lib/blocks.cpp
awk 'NR==3 { print "#include <nano/lib/convert.hpp>" }; { print $0 }' bandaid_build/nano/lib/blocks.cpp > bandaid_build/nano/lib/blocks.cpp.awk
mv bandaid_build/nano/lib/blocks.cpp.awk bandaid_build/nano/lib/blocks.cpp;

awk 'NR==321 || NR==1201 { print "\ttree.put (\"balance_decimal\", convert_raw_to_dec (hashables.balance.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/lib/blocks.cpp > bandaid_build/nano/lib/blocks.cpp.awk
mv bandaid_build/nano/lib/blocks.cpp.awk bandaid_build/nano/lib/blocks.cpp;

#nano/lib/blockbuilders.hpp
awk  'NR==100 || NR==106 || NR==122 || NR==145 || NR==178 || NR==205 || NR==151 { sub("xrb", "ban") }; { print $0 }' bandaid_build/nano/lib/blockbuilders.hpp > bandaid_build/nano/lib/blockbuilders.hpp.awk
mv bandaid_build/nano/lib/blockbuilders.hpp.awk bandaid_build/nano/lib/blockbuilders.hpp;

#nano/lib/config.cpp
awk  'NR==30 { sub("0xffffffc000000000", "0xfffffe0000000000") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

awk  'NR==31 { sub("0xfffffff800000000, // 8x higher than epoch_1", "0xfffffff000000000, // 32x higher than originally") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

awk  'NR==32 { sub("0xfffffe0000000000 // 8x lower than epoch_1", "0x0000000000000000 // remove receive work requirements") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

awk  'NR==49 { sub("0xffffffc000000000", "0xfffffe0000000000") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

awk  'NR==262 { sub("RX", "BT") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

awk  'NR==270 { sub("nano_dev_network", "banano_dev_network") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

#nano/lib/config.hpp
awk  'NR==128 { sub("0x5241", "0x4241") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==130 { sub("0x5242", "0x4242") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==132 { sub("0x5243", "0x4258") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==134 { sub("0x5258", "0x4243") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==128 || NR==130 || NR==132 || NR==134 { sub("R", "B") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==132 { sub("C", "X") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==134 { sub("X", "C") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==128 || NR==130 || NR==132 || NR==134 || NR==136 { sub("nano", "banano") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==199 { sub("1000), // 0.1%", "2000), // 0.2%") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==221 { sub("7075", "7071") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==222 { sub("7076", "7072") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==223 { sub("7077", "7073") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==224 { sub("7078", "7074") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==335 || NR==339 || NR==343 || NR==347 || NR==365 || NR==369 || NR==373 || NR==377 { sub("nano_", "banano_") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;


#nano/lib/numbers.cpp
# note: includes strange codes to use a single quote in an awk pattern.
awk  'NR==54 { sub("destination_a.append \\(\"_onan\"\\); // nano_", "destination_a.append (\"_nab\");") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

awk  'NR==91 || NR==93 || NR==96 || NR==98 { sub("xrb", "ban") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

awk  'NR==91 { sub("\047b\047", "\047n\047") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

awk  'NR==91 { sub("\047r\047", "\047a\047") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

awk  'NR==91 { sub("\047x\047", "\047b\047") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

awk  'NR==92 { sub("source_a\\[0\\] == \047n\047", "source_a[0] == \047b\047") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

#nano/lib/numbers.hpp
awk  'NR==14 { sub("Gxrb_ratio = nano::uint128_t \\(\"1000000000000000000000000000000000\"\\); // 10\\^33", "MBAN_ratio = nano::uint128_t (\"100000000000000000000000000000000000\"); // 10^35 = 1 million banano") }; { print $0 }' bandaid_build/nano/lib/numbers.hpp > bandaid_build/nano/lib/numbers.hpp.awk
mv bandaid_build/nano/lib/numbers.hpp.awk bandaid_build/nano/lib/numbers.hpp;

awk  'NR==15 { sub("Mxrb_ratio = nano::uint128_t \\(\"1000000000000000000000000000000\"\\); // 10\\^30", "BAN_ratio = nano::uint128_t (\"100000000000000000000000000000\"); // 10^29 = 1 banano") }; { print $0 }' bandaid_build/nano/lib/numbers.hpp > bandaid_build/nano/lib/numbers.hpp.awk
mv bandaid_build/nano/lib/numbers.hpp.awk bandaid_build/nano/lib/numbers.hpp;

awk  'NR==16 { sub("kxrb_ratio = nano::uint128_t \\(\"1000000000000000000000000000\"\\); // 10\\^27", "banoshi_ratio = nano::uint128_t (\"1000000000000000000000000000\"); // 10^27 = 1 hundredth banano") }; { print $0 }' bandaid_build/nano/lib/numbers.hpp > bandaid_build/nano/lib/numbers.hpp.awk
mv bandaid_build/nano/lib/numbers.hpp.awk bandaid_build/nano/lib/numbers.hpp;

awk  'NR==17 { sub("nano::uint128_t \\(\"1000000000000000000000000\"\\); // 10\\^24", "nano::uint128_t (\"1\"); // 10^0") }; { print $0 }' bandaid_build/nano/lib/numbers.hpp > bandaid_build/nano/lib/numbers.hpp.awk
mv bandaid_build/nano/lib/numbers.hpp.awk bandaid_build/nano/lib/numbers.hpp;


#nano/lib/plat/windows/registry.cpp
awk  'NR==8 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/lib/plat/windows/registry.cpp > bandaid_build/nano/lib/plat/windows/registry.cpp.awk
mv bandaid_build/nano/lib/plat/windows/registry.cpp.awk bandaid_build/nano/lib/plat/windows/registry.cpp;

awk  'NR==8 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/lib/plat/windows/registry.cpp > bandaid_build/nano/lib/plat/windows/registry.cpp.awk
mv bandaid_build/nano/lib/plat/windows/registry.cpp.awk bandaid_build/nano/lib/plat/windows/registry.cpp;

#nano/lib/rpcconfig.cpp
awk  'NR==156 { sub("nano_rpc", "banano_rpc") }; { print $0 }' bandaid_build/nano/lib/rpcconfig.cpp > bandaid_build/nano/lib/rpcconfig.cpp.awk
mv bandaid_build/nano/lib/rpcconfig.cpp.awk bandaid_build/nano/lib/rpcconfig.cpp;

#nano/nano_node/CMakeLists.txt
awk  'NR==1 || NR==4 || NR==14 || NR==18 || NR==22 || NR==24 || NR==26 || NR==31 || NR==33 || NR==36 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/nano/nano_node/CMakeLists.txt > bandaid_build/nano/nano_node/CMakeLists.txt.awk
mv bandaid_build/nano/nano_node/CMakeLists.txt.awk bandaid_build/nano/nano_node/CMakeLists.txt;

awk  'NR==18 { sub(" -DGIT_COMMIT_HASH", "-DGIT_COMMIT_HASH") }; { print $0 }' bandaid_build/nano/nano_node/CMakeLists.txt > bandaid_build/nano/nano_node/CMakeLists.txt.awk
mv bandaid_build/nano/nano_node/CMakeLists.txt.awk bandaid_build/nano/nano_node/CMakeLists.txt;

awk  'NR==22 { sub(" \"-DQT_NO_KEYWORDS", "\"-DQT_NO_KEYWORDS") }; { print $0 }' bandaid_build/nano/nano_node/CMakeLists.txt > bandaid_build/nano/nano_node/CMakeLists.txt.awk
mv bandaid_build/nano/nano_node/CMakeLists.txt.awk bandaid_build/nano/nano_node/CMakeLists.txt;

#nano/nano_node/daemon.cpp
awk  'NR==116 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/nano_node/daemon.cpp > bandaid_build/nano/nano_node/daemon.cpp.awk
mv bandaid_build/nano/nano_node/daemon.cpp.awk bandaid_build/nano/nano_node/daemon.cpp;

#nano/nano_node/entry.cpp
awk  'NR==165 { sub("nano_dev_network", "banano_dev_network") }; { print $0 }' bandaid_build/nano/nano_node/entry.cpp > bandaid_build/nano/nano_node/entry.cpp.awk
mv bandaid_build/nano/nano_node/entry.cpp.awk bandaid_build/nano/nano_node/entry.cpp;

awk  'NR==1915 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/nano_node/entry.cpp > bandaid_build/nano/nano_node/entry.cpp.awk
mv bandaid_build/nano/nano_node/entry.cpp.awk bandaid_build/nano/nano_node/entry.cpp;

awk  'NR==1915 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/nano_node/entry.cpp > bandaid_build/nano/nano_node/entry.cpp.awk
mv bandaid_build/nano/nano_node/entry.cpp.awk bandaid_build/nano/nano_node/entry.cpp;

#nano/nano_rpc/CMakeLists.txt
awk  'NR==1 || NR==4 || NR==16 || NR==23 || NR==25 { sub("nano_rpc", "banano_rpc") }; { print $0 }' bandaid_build/nano/nano_rpc/CMakeLists.txt > bandaid_build/nano/nano_rpc/CMakeLists.txt.awk
mv bandaid_build/nano/nano_rpc/CMakeLists.txt.awk bandaid_build/nano/nano_rpc/CMakeLists.txt;

#nano/nano_wallet/entry.cpp
awk  'NR==30 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/nano_wallet/entry.cpp > bandaid_build/nano/nano_wallet/entry.cpp.awk
mv bandaid_build/nano/nano_wallet/entry.cpp.awk bandaid_build/nano/nano_wallet/entry.cpp;

#nano/node/bootstrap/bootstrap_frontier.cpp
awk  'NR==37 || NR==210 || NR==309 || NR==328 { sub("%1%", "%1%, to %2%") }; { print $0 }' bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp > bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk
mv bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp;

awk  'NR==37 { sub("ec.message ()", "ec.message () % this_l->connection->channel->to_string ") }; { print $0 }' bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp > bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk
mv bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp;

awk  'NR==210 { sub("ec.message ()", "ec.message () % connection->channel->to_string ") }; { print $0 }' bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp > bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk
mv bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp;

awk  'NR==309 || NR==328 { sub("ec.message ()", "ec.message () % connection->socket->remote_endpoint ") }; { print $0 }' bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp > bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk
mv bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp.awk bandaid_build/nano/node/bootstrap/bootstrap_frontier.cpp;

#nano/node/cli.cpp
awk 'NR==74 { print "\t(\"timestamps_import\", \"Imports a CSV file, overwriting the timestamps recorded in the database (warning: high resource usage).\")" }; { print $0 }' bandaid_build/nano/node/cli.cpp > bandaid_build/nano/node/cli.cpp.awk
mv bandaid_build/nano/node/cli.cpp.awk bandaid_build/nano/node/cli.cpp;

awk 'NR==75 { print "\t(\"timestamps_export\", \"Writes a CSV file with the local timestamp recorded for each hash with timestamp in the database.\")" }; { print $0 }' bandaid_build/nano/node/cli.cpp > bandaid_build/nano/node/cli.cpp.awk;
mv bandaid_build/nano/node/cli.cpp.awk bandaid_build/nano/node/cli.cpp;

awk 'NR==76 { print "\t(\"timestamps_update_frontiers\", \"Updates the \047modified\047 timestamp of each account chain with the stamps of each frontier\")" }; { print $0 }' bandaid_build/nano/node/cli.cpp > bandaid_build/nano/node/cli.cpp.awk;
mv bandaid_build/nano/node/cli.cpp.awk bandaid_build/nano/node/cli.cpp;

  # copy lines from bandaid_build, (nano with edits)
# sed -n '1,9p' bandaid_build/nano/node/cli.cpp > bandaid_build/nano/node/cli.cpp.sed;
# echo '#include <boost/lexical_cast.hpp>' >> bandaid_build/nano/node/cli.cpp.sed;
# sed -n '10,77p' bandaid_build/nano/node/cli.cpp >> bandaid_build/nano/node/cli.cpp.sed;

  # copy lines from bandaid_build, (nano with edits)
sed -n '78,90p' bandaid_build/nano/node/cli.cpp >> bandaid_build/nano/node/cli.cpp.sed;

  # copy lines from banano_build, (banano with no edits)
# sed -n '92,94p' banano_build/nano/node/cli.cpp >> bandaid_build/nano/node/cli.cpp.sed;

  # copy lines from bandaid_build, (nano with edits)
sed -n '91,1357p' bandaid_build/nano/node/cli.cpp >> bandaid_build/nano/node/cli.cpp.sed;

  # copy lines from banano_build, (banano with no edits)
sed -n '1358,1558p' banano_build/nano/node/cli.cpp >> bandaid_build/nano/node/cli.cpp.sed;

  #copy to the end, delete the top lines.
# sed '1,1320d' bandaid_build/nano/node/cli.cpp >> bandaid_build/nano/node/cli.cpp.sed;
# mv bandaid_build/nano/node/cli.cpp.sed bandaid_build/nano/node/cli.cpp;

awk  'NR==91 { sub("entries\"\);", "entries\"\)") }; { print $0 }' bandaid_build/nano/node/cli.cpp > bandaid_build/nano/node/cli.cpp.awk;
mv bandaid_build/nano/node/cli.cpp.awk bandaid_build/nano/node/cli.cpp;

awk  'NR==712 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/cli.cpp > bandaid_build/nano/node/cli.cpp.awk;
mv bandaid_build/nano/node/cli.cpp.awk bandaid_build/nano/node/cli.cpp;

#nano/node/election.cpp
awk 'NR==196 { sub("node.network_params.network.is_dev_network \\(\\) \\? 500 : ","") }; { print $0 }' bandaid_build/nano/node/election.cpp > bandaid_build/nano/node/election.cpp.awk
mv bandaid_build/nano/node/election.cpp.awk bandaid_build/nano/node/election.cpp;

#nano/node/json_handler.hpp
awk  'NR==77 || NR==78 { sub("Mxrb_ratio", "BAN_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.hpp > bandaid_build/nano/node/json_handler.hpp.awk
mv bandaid_build/nano/node/json_handler.hpp.awk bandaid_build/nano/node/json_handler.hpp;

#nano/node/json_handler.cpp
awk  'NR==2 { print "#include <nano/lib/convert.hpp>" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==103 { sub("krai_from_raw", "banoshi_from_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==105 || NR==109 { sub("kxrb_ratio", "banoshi_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==107 { sub("krai_to_raw", "banoshi_to_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==113 || NR==117 { sub("xrb_ratio", "RAW_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==111 { sub("rai_from_raw", "raw_from_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==115 { sub("rai_to_raw", "raw_to_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==119 { sub("mrai_from_raw", "ban_from_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==123 { sub("mrai_to_raw", "ban_to_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

sed -n '1,133p' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.sed;
sed -n '134,146p' banano_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
sed '1,134d' bandaid_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
mv bandaid_build/nano/node/json_handler.cpp.sed bandaid_build/nano/node/json_handler.cpp;

awk  'NR==543 { print "\t\tresponse_l.put (\"balance_decimal\", convert_raw_to_dec (balance.first.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==545 { print "\t\tresponse_l.put (\"pending_decimal\", convert_raw_to_dec (balance.second.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==547 { print "\t\tresponse_l.put (\"receivable_decimal\", convert_raw_to_dec (balance.second.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==648 { print "\t\t\tresponse_l.put (\"balance_decimal\", convert_raw_to_dec (balance));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==665 { print "\t\t\t\tresponse_l.put (\"confirmed_balance_decimal\", convert_raw_to_dec (confirmed_balance));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==712 { print "\t\t\t\tresponse_l.put (\"weight_decimal\", convert_raw_to_dec (account_weight.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==713 { print "\t\t\t\tresponse_l.put (\"weight_decimal_millions\", convert_raw_to_dec (account_weight.convert_to<std::string> (), nano::MBAN_ratio));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==719 { print "\t\t\t\tresponse_l.put (\"pending_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==721 { print "\t\t\t\tresponse_l.put (\"receivable_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==728 { print "\t\t\t\t\tresponse_l.put (\"confirmed_pending_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==911 { print "\t\tresponse_l.put (\"weight_decimal\", convert_raw_to_dec (balance.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==931 { print "\t\t\t\tentry.put (\"balance_decimal\", convert_raw_to_dec (balance.first.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==933 { print "\t\t\t\tentry.put (\"balance_decimal\", convert_raw_to_dec (balance.second.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==935 { print "\t\t\t\tentry.put (\"receivable_decimal\", convert_raw_to_dec (balance.second.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==1070 { print "\t\t\t\t\t\t\t\tpending_tree.put (\"amount_decimal\", convert_raw_to_dec (info.amount.number ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==1161 { print "\t\t\t\tresponse_l.put (\"amount_decimal\", convert_raw_to_dec (amount.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==1165 { print "\t\t\tresponse_l.put (\"balance_decimal\", convert_raw_to_dec (balance.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==1323 { print "\t\t\t\t\t\tentry.put (\"amount_decimal\", convert_raw_to_dec (amount.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==1327 { print "\t\t\t\t\tentry.put (\"balance_decimal\", convert_raw_to_dec (balance.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2050 { print "\t\t\t\telection.put (\"tally_decimal\", convert_raw_to_dec (status.tally.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2092 { print "\t\t\t\tentry.put (\"tally_decimal\", convert_raw_to_dec (tally.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2130 { print "\t\t\tresponse_l.put (\"total_tally_decimal\", convert_raw_to_dec (total.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2132 { print "\t\t\t//response_l.put (\"final_tally_decimal\", info.status.final_tally.to_string_dec ());" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2150 { print "\tresponse_l.put (\"quorum_delta_decimal\", convert_raw_to_dec (node.online_reps.delta ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2153 { print "\tresponse_l.put (\"online_weight_minimum_decimal\", convert_raw_to_dec (node.config.online_weight_minimum.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2155 { print "\tresponse_l.put (\"online_stake_total_decimal\", convert_raw_to_dec (node.online_reps.online ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2157 { print "\tresponse_l.put (\"trended_stake_total_decimal\", convert_raw_to_dec (node.online_reps.trended ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2159 { print "\tresponse_l.put (\"peers_stake_total_decimal\", convert_raw_to_dec (node.rep_crawler.total_weight ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2169 { print "\t\t\tpeer_node.put (\"weight_decimal\", convert_raw_to_dec (peer.weight.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

sed -n '1,2257p' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.sed;
#   # echo '// INSERT HERE' >> bandaid_build/nano/node/json_handler.cpp.sed;
sed -n '2258,2293p' banano_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
sed '1,2257d' bandaid_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
mv bandaid_build/nano/node/json_handler.cpp.sed bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2457 { print "\t\t\ttree.put (\"amount_decimal\", convert_raw_to_dec (amount));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2463 { print "\t\t\ttree.put (\"balance_decimal\", convert_raw_to_dec (block_a.hashables.balance.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2480 { print "\t\t\ttree.put (\"amount_decimal\", convert_raw_to_dec (amount));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2514 { print "\t\t\t\ttree.put (\"amount_decimal\", convert_raw_to_dec (amount));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2521 { print "\t\t\ttree.put (\"amount_decimal\", convert_raw_to_dec (nano::dev::constants.genesis_amount.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2541 { print "\t\t\ttree.put (\"balance_decimal\", convert_raw_to_dec (block_a.hashables.balance.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2575 { print "\t\t\ttree.put (\"amount_decimal\", convert_raw_to_dec ((previous_balance - balance).convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2615 { print "\t\t\t\ttree.put (\"amount_decimal\", convert_raw_to_dec ((balance - previous_balance).convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2839 { print "\t\t\t\t\t\tresponse_a.put (\"pending_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2841 { print "\t\t\t\t\t\tresponse_a.put (\"receivable_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2849 { print "\t\t\t\t\tresponse_a.put (\"balance_decimal\", convert_raw_to_dec (balance));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2860 { print "\t\t\t\t\t\tresponse_a.put (\"weight_decimal\", convert_raw_to_dec (account_weight.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2896 { print "\t\t\t\t\t\tresponse_a.put (\"pending_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2898 { print "\t\t\t\t\t\tresponse_a.put (\"receivable_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2906 { print "\t\t\t\t\tresponse_a.put (\"balance_decimal\", convert_raw_to_dec (balance));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2917 { print "\t\t\t\t\t\tresponse_a.put (\"weight_decimal\", convert_raw_to_dec (account_weight.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2964 { sub("Mxrb_ratio", "MBAN_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

sed -n '1,2975p' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.sed;
  # echo '// INSERT HERE' >> bandaid_build/nano/node/json_handler.cpp.sed;
sed -n '2976,2985p' banano_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
sed '1,2975d' bandaid_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
mv bandaid_build/nano/node/json_handler.cpp.sed bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2992 { sub("Mxrb_ratio", "MBAN_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==3170 { print "\t\t\t\t\t\t\tpending_tree.put (\"amount_decimal\", convert_raw_to_dec (info.amount.number ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

sed -n '1,3624p' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.sed;
  # echo '// INSERT HERE' >> bandaid_build/nano/node/json_handler.cpp.sed;
sed -n '3625,3669p' banano_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
sed '1,3624d' bandaid_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
mv bandaid_build/nano/node/json_handler.cpp.sed bandaid_build/nano/node/json_handler.cpp;

awk  'NR==3718 { print "\t\t\t\tweight_node.put (\"weight_decimal\", convert_raw_to_dec (account_weight.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4456 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4586 { print "\t\tresponse_l.put (\"balance_decimal\", convert_raw_to_dec (balance.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4588 { print "\t\tresponse_l.put (\"pending_decimal\", convert_raw_to_dec (receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4590 { print "\t\tresponse_l.put (\"receivable_decimal\", convert_raw_to_dec (receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4620 { print "\t\t\t\tentry.put (\"balance_decimal\", convert_raw_to_dec (balance.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4622 { print "\t\t\t\tentry.put (\"pending_decimal\", convert_raw_to_dec (receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  ' NR==4624 { print "\t\t\t\tentry.put (\"receivable_decimal\", convert_raw_to_dec (receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4885 { print "\t\t\t\t\tentry.put (\"balance_decimal\", convert_raw_to_dec (balance));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4896 { print "\t\t\t\t\t\tentry.put (\"weight_decimal\", convert_raw_to_dec (account_weight.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4902 { print "\t\t\t\t\t\tentry.put (\"pending_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4904 { print "\t\t\t\t\t\tentry.put (\"receivable_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4973 { print "\t\t\t\t\t\t\t\tpending_tree.put (\"amount_decimal\", convert_raw_to_dec (info.amount.number ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==5507 { print "\tno_arg_funcs.emplace (\"raw_to_dec\", &nano::json_handler::raw_to_dec);" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

#nano/node/json_handler.hpp
awk  'NR==70 { print "\tvoid delegators_decimal ();" }; { print $0 }' bandaid_build/nano/node/json_handler.hpp > bandaid_build/nano/node/json_handler.hpp.awk
mv bandaid_build/nano/node/json_handler.hpp.awk bandaid_build/nano/node/json_handler.hpp;

awk  'NR==96 { print "\tvoid raw_to_dec ();" }; { print $0 }' bandaid_build/nano/node/json_handler.hpp > bandaid_build/nano/node/json_handler.hpp.awk
mv bandaid_build/nano/node/json_handler.hpp.awk bandaid_build/nano/node/json_handler.hpp;

awk  'NR==101 { print "\tvoid representatives_decimal_millions ();" }; { print $0 }' bandaid_build/nano/node/json_handler.hpp > bandaid_build/nano/node/json_handler.hpp.awk
mv bandaid_build/nano/node/json_handler.hpp.awk bandaid_build/nano/node/json_handler.hpp;

#nano/node/network.cpp
awk  'NR==1088 || NR==1090 || NR==1092 || NR==1094 { sub(":nano", ":banano") }; { print $0 }' bandaid_build/nano/node/network.cpp > bandaid_build/nano/node/network.cpp.awk
mv bandaid_build/nano/node/network.cpp.awk bandaid_build/nano/node/network.cpp;

#nano/node/logging.cpp
awk  'NR==42 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/logging.cpp > bandaid_build/nano/node/logging.cpp.awk
mv bandaid_build/nano/node/logging.cpp.awk bandaid_build/nano/node/logging.cpp;

awk  'NR==42 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/logging.cpp > bandaid_build/nano/node/logging.cpp.awk
mv bandaid_build/nano/node/logging.cpp.awk bandaid_build/nano/node/logging.cpp;

#nano/node/node.cpp
awk  'NR==1 { print "#include <nano/lib/convert.hpp>" }; { print $0 }' bandaid_build/nano/node/node.cpp > bandaid_build/nano/node/node.cpp.awk
mv bandaid_build/nano/node/node.cpp.awk bandaid_build/nano/node/node.cpp;

awk  'NR==259 { print "\t\t\t\t\t\tevent.add (\"amount_decimal\", convert_raw_to_dec (amount_a.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/node.cpp > bandaid_build/nano/node/node.cpp.awk
mv bandaid_build/nano/node/node.cpp.awk bandaid_build/nano/node/node.cpp;

awk  'NR==399 { sub("XRB", "BAN") }; { print $0 }' bandaid_build/nano/node/node.cpp > bandaid_build/nano/node/node.cpp.awk
mv bandaid_build/nano/node/node.cpp.awk bandaid_build/nano/node/node.cpp;

#nano/qt/qt.cpp
awk  'NR==62 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/qt/qt.cpp > bandaid_build/nano/qt/qt.cpp.awk
mv bandaid_build/nano/qt/qt.cpp.awk bandaid_build/nano/qt/qt.cpp;

awk  'NR==1835 || NR==1009 { sub("Mxrb_ratio", "BAN_ratio") }; { print $0 }' bandaid_build/nano/qt/qt.cpp > bandaid_build/nano/qt/qt.cpp.awk
mv bandaid_build/nano/qt/qt.cpp.awk bandaid_build/nano/qt/qt.cpp;

#nano/rpc_test/rpc.cpp
awk  'NR==2294 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/rpc_test/rpc.cpp > bandaid_build/nano/rpc_test/rpc.cpp.awk
mv bandaid_build/nano/rpc_test/rpc.cpp.awk bandaid_build/nano/rpc_test/rpc.cpp;

awk  'NR==1117 || NR==1201 { sub("Gxrb_ratio", "MBAN_ratio") }; { print $0 }' bandaid_build/nano/rpc_test/rpc.cpp > bandaid_build/nano/rpc_test/rpc.cpp.awk
mv bandaid_build/nano/rpc_test/rpc.cpp.awk bandaid_build/nano/rpc_test/rpc.cpp;

awk  'NR==2849 || NR==2855 { sub("mrai_to_raw", "ban_to_raw") }; { print $0 }' bandaid_build/nano/rpc_test/rpc.cpp > bandaid_build/nano/rpc_test/rpc.cpp.awk
mv bandaid_build/nano/rpc_test/rpc.cpp.awk bandaid_build/nano/rpc_test/rpc.cpp;

awk  'NR==2861 { sub("mrai_from_raw", "ban_from_raw") }; { print $0 }' bandaid_build/nano/rpc_test/rpc.cpp > bandaid_build/nano/rpc_test/rpc.cpp.awk
mv bandaid_build/nano/rpc_test/rpc.cpp.awk bandaid_build/nano/rpc_test/rpc.cpp;

awk  'NR==2873 || NR==2879 { sub("krai_to_raw", "banoshi_to_raw") }; { print $0 }' bandaid_build/nano/rpc_test/rpc.cpp > bandaid_build/nano/rpc_test/rpc.cpp.awk
mv bandaid_build/nano/rpc_test/rpc.cpp.awk bandaid_build/nano/rpc_test/rpc.cpp;

awk  'NR==2885 { sub("krai_from_raw", "banoshi_from_raw") }; { print $0 }' bandaid_build/nano/rpc_test/rpc.cpp > bandaid_build/nano/rpc_test/rpc.cpp.awk
mv bandaid_build/nano/rpc_test/rpc.cpp.awk bandaid_build/nano/rpc_test/rpc.cpp;

#nano/node/nodeconfig.cpp
awk  'NR==18 { sub("peering.nano.org", "livenet.banano.cc") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

awk  'NR==19 { sub("peering-beta.nano.org", "livenet-beta.banano.cc") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

awk  'NR==49 || NR==53 || NR==61 { sub(":nano", ":banano") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

awk  'NR==57 { sub("nano", "bano") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

sed -n '1,62p' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.sed;
  # echo '// INSERT HERE' >> bandaid_build/nano/node/nodeconfig.cpp.sed;
sed -n '63,72p' banano_build/nano/node/nodeconfig.cpp >> bandaid_build/nano/node/nodeconfig.cpp.sed;
sed '1,71d' bandaid_build/nano/node/nodeconfig.cpp >> bandaid_build/nano/node/nodeconfig.cpp.sed;
mv bandaid_build/nano/node/nodeconfig.cpp.sed bandaid_build/nano/node/nodeconfig.cpp;

awk  'NR==73 { sub(":nano", ":banano") }; { print $0 }' bandaid_build/nano/node/nodeconfig.cpp > bandaid_build/nano/node/nodeconfig.cpp.awk
mv bandaid_build/nano/node/nodeconfig.cpp.awk bandaid_build/nano/node/nodeconfig.cpp;

#nano/node/nodeconfig.hpp
awk  'NR==47 { sub("8076", "8072") }; { print $0 }' bandaid_build/nano/node/nodeconfig.hpp > bandaid_build/nano/node/nodeconfig.hpp.awk
mv bandaid_build/nano/node/nodeconfig.hpp.awk bandaid_build/nano/node/nodeconfig.hpp;

awk  'NR==51 { sub("xrb_ratio", "RAW_ratio") }; { print $0 }' bandaid_build/nano/node/nodeconfig.hpp > bandaid_build/nano/node/nodeconfig.hpp.awk
mv bandaid_build/nano/node/nodeconfig.hpp.awk bandaid_build/nano/node/nodeconfig.hpp;

awk  'NR==56 { sub("60000", "900") }; { print $0 }' bandaid_build/nano/node/nodeconfig.hpp > bandaid_build/nano/node/nodeconfig.hpp.awk
mv bandaid_build/nano/node/nodeconfig.hpp.awk bandaid_build/nano/node/nodeconfig.hpp;

awk  'NR==93 { sub("10 \\* 1024", "2 * 1024") }; { print $0 }' bandaid_build/nano/node/nodeconfig.hpp > bandaid_build/nano/node/nodeconfig.hpp.awk
mv bandaid_build/nano/node/nodeconfig.hpp.awk bandaid_build/nano/node/nodeconfig.hpp;

#nano/node/portmapping.cpp
awk  'NR==109 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/portmapping.cpp > bandaid_build/nano/node/portmapping.cpp.awk
mv bandaid_build/nano/node/portmapping.cpp.awk bandaid_build/nano/node/portmapping.cpp;

#nano/node/websocket.cpp
awk  'NR==4 { print "#include <nano/lib/convert.hpp>" }; { print $0 }' bandaid_build/nano/node/websocket.cpp > bandaid_build/nano/node/websocket.cpp.awk
mv bandaid_build/nano/node/websocket.cpp.awk bandaid_build/nano/node/websocket.cpp;

awk  'NR==734 { print "\tmessage_node_l.add (\"amount_decimal\", convert_raw_to_dec (amount_a.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/websocket.cpp > bandaid_build/nano/node/websocket.cpp.awk
mv bandaid_build/nano/node/websocket.cpp.awk bandaid_build/nano/node/websocket.cpp;

awk  'NR==760 { print "\t\telection_node_l.add (\"tally_decimal\", convert_raw_to_dec (election_status_a.tally.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/websocket.cpp > bandaid_build/nano/node/websocket.cpp.awk
mv bandaid_build/nano/node/websocket.cpp.awk bandaid_build/nano/node/websocket.cpp;

awk  'NR==775 { print "\t\t\t\tentry.put (\"weight\", convert_raw_to_dec (vote_l.weight.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/websocket.cpp > bandaid_build/nano/node/websocket.cpp.awk
mv bandaid_build/nano/node/websocket.cpp.awk bandaid_build/nano/node/websocket.cpp;

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

awk  'NR==84 || NR==89 || NR==90 || NR==114 || NR==115 || NR==123 || NR==124 || NR==130 || NR==148 { sub(":nano", ":banano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==89 || NR==114 || NR==123 || NR==130 || NR==131 || NR==148 || NR==149 { sub(":nano", ":banano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==90 || NR==115 || NR==124 || NR==131 || NR==149 { sub("\\? nano", "  ? nano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==91 { sub(": nano", "\t: nano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==116 { sub("   : nano", "\t   : nano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==125 { sub("\t : nano", "\t\t : nano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==132 { sub("\t   : nano", "\t\t   : nano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==150 { sub("\t  : nano", "\t\t  : nano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==94 { sub("\047R\047, \047A\047", "\047B\047, \047Z\047") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==94 { sub("\047R\047, \047B\047", "\047B\047, \047Y\047") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==94 { sub("\047R\047, \047C\047", "\047B\047, \047X\047") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==146 { sub("nano_3qb6o6i1tkzr6jwr5s7eehfxwg9x6eemitdinbpi7u8bjjwsgqfj4wzser3x", "bano_3qb6o6i1tkzr6jwr5s7eehfxwg9x6eemitdinbpi7u8bjjwsgqfj4wzser3x") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

#nano/secure/common.hpp
awk  'NR==359 { sub("0x12", "0x11") }; { print $0 }' bandaid_build/nano/secure/common.hpp > bandaid_build/nano/secure/common.hpp.awk
mv bandaid_build/nano/secure/common.hpp.awk bandaid_build/nano/secure/common.hpp;

#nano/secure/utility.cpp
awk  'NR==17 || NR==20 || NR==23 || NR==26 { sub(":nano", ":banano") }; { print $0 }' bandaid_build/nano/secure/utility.cpp > bandaid_build/nano/secure/utility.cpp.awk
mv bandaid_build/nano/secure/utility.cpp.awk bandaid_build/nano/secure/utility.cpp;

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

awk  'NR==36 || NR==43 || NR==52 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==43 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

#systest/cli_wallet_create.sh
awk  'NR==9 || NR==10 || NR==11 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/systest/cli_wallet_create.sh > bandaid_build/systest/cli_wallet_create.sh.awk
mv bandaid_build/systest/cli_wallet_create.sh.awk bandaid_build/systest/cli_wallet_create.sh;

#systest/node_initialize.sh
awk  'NR==7 || NR==8 || NR==9 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/systest/node_initialize.sh > bandaid_build/systest/node_initialize.sh.awk
mv bandaid_build/systest/node_initialize.sh.awk bandaid_build/systest/node_initialize.sh;

#systest/set_bandwidth_params.sh.disabled
awk  'NR==26 || NR==27 || NR==28 || NR==33 || NR==35 || NR==50 || NR==63 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/systest/set_bandwidth_params.sh.disabled > bandaid_build/systest/set_bandwidth_params.sh.disabled.awk
mv bandaid_build/systest/set_bandwidth_params.sh.disabled.awk bandaid_build/systest/set_bandwidth_params.sh.disabled;

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
