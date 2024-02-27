#!/bin/bash

reset;

# "bandaid_build" is the nano_build with banano changes applied.
# if all the changes are applied correctly, it should be identical to banano_build
# git diff is
# https://github.com/nanocurrency/nano-node/compare/V22.1...BananoCoin:V22dev2
# https://github.com/BananoCoin/banano/compare/v25...nanocurrency:V25.0

check_type=BananoCoin_v26_1_vs_nanocurrency_v26_1
# check_type="local"

if [ $check_type = "BananoCoin_v26_1_vs_nanocurrency_v26_1" ]
then
  echo "comparing BananoCoin v26 vs nanocurrency releases/V26.1"
  # --depth 1 means clone with no history.
  rm -rf banano_build;
  rm -rf nano_build;
  git clone -c advice.detachedHead=false --depth 1 --branch v26.1 https://github.com/BananoCoin/banano.git banano_build;
  git clone -c advice.detachedHead=false --depth 1 --branch V26.1 https://github.com/nanocurrency/nano-node.git nano_build;
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
awk  'NR==1 || NR==13 || NR==45 || NR==50 || NR==55 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==41 || NR==54 || NR==55 || NR==56 || NR==58 || NR==59 || NR==60 || NR==61 || NR==62 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==41 || NR==56 || NR==59 || NR==60 || NR==61 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==60 || NR==61 || NR==56 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==60 || NR==66 || NR==56 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==4 || NR==58 || NR==60 || NR==61 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==13 || NR==54 || NR==56 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==32 || NR==39 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==39 || NR==48 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==33 || NR==40 { sub("nano_rpc", "banano_rpc") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==40 || NR==49 { sub("/nano_rpc", "/banano_rpc") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==57 { sub("/nanocurrency", "/bananocoin") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

awk  'NR==57 { sub("nanocurrency:nanocurrency", "bananocoin:bananocoin") }; { print $0 }' bandaid_build/nanocurrency.spec.in > bandaid_build/nanocurrency.spec.in.awk
mv bandaid_build/nanocurrency.spec.in.awk bandaid_build/nanocurrency.spec.in;

#util/changelog.py
awk  'NR==118 { sub("incremental", "BananoCoin/banano") }; { print $0 }' bandaid_build/util/changelog.py > bandaid_build/util/changelog.py.awk
mv bandaid_build/util/changelog.py.awk bandaid_build/util/changelog.py;

awk  'NR==131 { sub("nanocurrency/nano-node", "BananoCoin/banano") }; { print $0 }' bandaid_build/util/changelog.py > bandaid_build/util/changelog.py.awk
mv bandaid_build/util/changelog.py.awk bandaid_build/util/changelog.py;

#CMakeLists.txt
awk  'NR==40 { sub("Nano Currency", "Bananocoin") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

sed -n '1,48p' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.sed;
# echo '// INSERT HERE' >> bandaid_build/CMakeLists.txt.sed
sed -n '49,51p' banano_build/CMakeLists.txt >> bandaid_build/CMakeLists.txt.sed;
sed '1,50d' bandaid_build/CMakeLists.txt >> bandaid_build/CMakeLists.txt.sed;
mv bandaid_build/CMakeLists.txt.sed bandaid_build/CMakeLists.txt;

awk  'NR==53 { sub("Nano Currency", "Bananocoin") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==159  { sub( " nano_", " banano_") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==162 || NR==163 { sub( " nano_", " banano_") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==162 || NR==163 { sub(" nano_", " banano_") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==696 || NR==739 || NR==851 || NR==853 || NR==855 { sub(" nano_", " banano_") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==696 || NR==739 { sub(" nano_", " banano_") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==175 || NR==179 || NR==188 { sub( "\"nano_", "\"banano_") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==168 || NR==181 || NR==175 || NR==188 || NR==194 || NR==201 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

awk  'NR==171 || NR==173 || NR==184 || NR==186 || NR==197 || NR==199 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/CMakeLists.txt > bandaid_build/CMakeLists.txt.awk
mv bandaid_build/CMakeLists.txt.awk bandaid_build/CMakeLists.txt;

#api/flatbuffers/nanoapi.fbs
awk  'NR==3 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/api/flatbuffers/nanoapi.fbs > bandaid_build/api/flatbuffers/nanoapi.fbs.awk
mv bandaid_build/api/flatbuffers/nanoapi.fbs.awk bandaid_build/api/flatbuffers/nanoapi.fbs;

#ci/test.sh
awk  'NR==59 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/ci/test.sh > bandaid_build/ci/test.sh.awk
mv bandaid_build/ci/test.sh.awk bandaid_build/ci/test.sh;

#ci/build-gitlab.sh
awk  'NR==57 || NR==61 || NR==65 { sub("=nano_", "=banano_") }; { print $0 }' bandaid_build/ci/build-gitlab.sh > bandaid_build/ci/build-gitlab.sh.awk
mv bandaid_build/ci/build-gitlab.sh.awk bandaid_build/ci/build-gitlab.sh;

#ci/actions/linux/deploy-docker.sh
awk  'NR==31 || NR==48 || NR==49 || NR==50 || NR==54 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/ci/actions/linux/docker-deploy.sh > bandaid_build/ci/actions/linux/docker-deploy.sh.awk
mv bandaid_build/ci/actions/linux/docker-deploy.sh.awk bandaid_build/ci/actions/linux/docker-deploy.sh;

#ci/actions/linux/install_deps.sh
awk  'NR==5 || NR==10 || NR==12 || NR==14 || NR==15 || NR==16 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/ci/actions/linux/install_deps.sh > bandaid_build/ci/actions/linux/install_deps.sh.awk
mv bandaid_build/ci/actions/linux/install_deps.sh.awk bandaid_build/ci/actions/linux/install_deps.sh;

#ci/actions/linux/docker-impl/docker-common.sh
awk  'NR==36 { sub("\\$\\{GITHUB_REPOSITORY\\}", "bananocoin") }; { print $0 }' bandaid_build/ci/actions/linux/docker-impl/docker-common.sh > bandaid_build/ci/actions/linux/docker-impl/docker-common.sh.awk
mv bandaid_build/ci/actions/linux/docker-impl/docker-common.sh.awk bandaid_build/ci/actions/linux/docker-impl/docker-common.sh;

# ci/build-docker-image.sh
awk  'NR==11 || NR==23 { sub("\\$\\{GITHUB_REPOSITORY\\}", "bananocoin") }; { print $0 }' bandaid_build/ci/build-docker-image.sh > bandaid_build/ci/build-docker-image.sh.awk
mv bandaid_build/ci/build-docker-image.sh.awk bandaid_build/ci/build-docker-image.sh;

# ci/build-rhel.sh
awk  'NR==16 || NR==19 || NR==29 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/ci/build-rhel.sh > bandaid_build/ci/build-rhel.sh.awk
mv bandaid_build/ci/build-rhel.sh.awk bandaid_build/ci/build-rhel.sh;

#ci/actions/deploy.sh
awk  'NR==17 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/ci/actions/deploy.sh > bandaid_build/ci/actions/deploy.sh.awk
mv bandaid_build/ci/actions/deploy.sh.awk bandaid_build/ci/actions/deploy.sh;

awk  'NR==17 { sub("nano-node", "bananode") }; { print $0 }' bandaid_build/ci/actions/deploy.sh > bandaid_build/ci/actions/deploy.sh.awk
mv bandaid_build/ci/actions/deploy.sh.awk bandaid_build/ci/actions/deploy.sh;

sed -n '1,24p' bandaid_build/ci/actions/deploy.sh > bandaid_build/ci/actions/deploy.sh.sed;
# echo '// INSERT HERE' >> bandaid_build/ci/actions/deploy.sh.sed
sed -n '25,29p' banano_build/ci/actions/deploy.sh >> bandaid_build/ci/actions/deploy.sh.sed;
sed '1,26d' bandaid_build/ci/actions/deploy.sh >> bandaid_build/ci/actions/deploy.sh.sed;
mv bandaid_build/ci/actions/deploy.sh.sed bandaid_build/ci/actions/deploy.sh;


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
awk  'NR==610 || NR==513 || NR==652 || NR==655 || NR==671 || NR==613 || NR==713 || NR==716 || NR==767 || NR==805 { sub("xrb_", "ban_") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

awk  'NR==727 || NR==728 { sub("xrb_3t6k35gi95xu6tergt6p69ck76ogmitsa8mnijtpxm9fkcm736xtoncuohr3", "ban_1bananobh5rat99qfgt1ptpieie5swmoth87thi74qgbfrij7dcgjiij94xr") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

awk  'NR==729 || NR==732 { sub("E89208DD038FBB269987689621D52292AE9C35941A7484756ECCED92A65093BA", "2514452A978F08D1CF76BB40B6AD064183CF275D3CC5D3E0515DC96E2112AD4E") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

awk  'NR==731 { sub("991CF190094C00F0B68E2E5F75F6BEE95A2E0BD93CEAA4A6734DB9F19B728948", "F61A79F286ABC5CC01D3D09686F0567812B889A5C63ADE0E82DD30F3B2D96463") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
mv bandaid_build/nano/core_test/block.cpp.awk bandaid_build/nano/core_test/block.cpp;

awk  'NR==811 { sub("nano_1gys8r4crpxhp94n4uho5cshaho81na6454qni5gu9n53gksoyy1wcd4udyb", "ban_1gys8r4crpxhp94n4uho5cshaho81na6454qni5gu9n53gksoyy1wcd4udyb") }; { print $0 }' bandaid_build/nano/core_test/block.cpp > bandaid_build/nano/core_test/block.cpp.awk
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
awk 'NR==33 { print "  convert.cpp\n  convert.hpp" }; { print $0 }' bandaid_build/nano/lib/CMakeLists.txt > bandaid_build/nano/lib/CMakeLists.txt.awk
mv bandaid_build/nano/lib/CMakeLists.txt.awk bandaid_build/nano/lib/CMakeLists.txt;

#nano/lib/blocks.cpp
awk 'NR==3 { print "#include <nano/lib/convert.hpp>" }; { print $0 }' bandaid_build/nano/lib/blocks.cpp > bandaid_build/nano/lib/blocks.cpp.awk
mv bandaid_build/nano/lib/blocks.cpp.awk bandaid_build/nano/lib/blocks.cpp;

awk 'NR==321 || NR==1201 { print "\ttree.put (\"balance_decimal\", convert_raw_to_dec (hashables.balance.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/lib/blocks.cpp > bandaid_build/nano/lib/blocks.cpp.awk
mv bandaid_build/nano/lib/blocks.cpp.awk bandaid_build/nano/lib/blocks.cpp;

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

awk  'NR==49 { sub("0xffffffc000000000", "0xfffffe0000000000") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

awk  'NR==261 { sub("RX", "BT") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

awk  'NR==269 { sub("nano_dev_network", "banano_dev_network") }; { print $0 }' bandaid_build/nano/lib/config.cpp > bandaid_build/nano/lib/config.cpp.awk
mv bandaid_build/nano/lib/config.cpp.awk bandaid_build/nano/lib/config.cpp;

#nano/lib/config.hpp
awk  'NR==121 { sub("0x5241", "0x4241") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==123 { sub("0x5242", "0x4242") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==125 { sub("0x5243", "0x4258") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==127 { sub("0x5258", "0x4243") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==121 || NR==123 || NR==125 || NR==127 { sub("R", "B") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==125 { sub("C", "X") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==127 { sub("X", "C") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==121 || NR==123 || NR==125 || NR==127 || NR==136 { sub("nano", "banano") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==199 { sub("1000), // 0.1%", "2000), // 0.2%") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==215 { sub("7075", "7071") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==216 { sub("7076", "7072") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==217 { sub("7077", "7073") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==218 { sub("7078", "7074") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;

awk  'NR==332 || NR==336 || NR==340 || NR==344 || NR==362 || NR==366 || NR==370 || NR==374 { sub("nano_", "banano_") }; { print $0 }' bandaid_build/nano/lib/config.hpp > bandaid_build/nano/lib/config.hpp.awk
mv bandaid_build/nano/lib/config.hpp.awk bandaid_build/nano/lib/config.hpp;


#nano/lib/numbers.cpp
# note: includes strange codes to use a single quote in an awk pattern.
awk  'NR==53 { sub("destination_a.append \\(\"_onan\"\\); // nano_", "destination_a.append (\"_nab\");") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

awk  'NR==89 || NR==92 || NR==95 || NR==97 { sub("xrb", "ban") }; { print $0 }' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.awk
mv bandaid_build/nano/lib/numbers.cpp.awk bandaid_build/nano/lib/numbers.cpp;

sed -n '1,88p' bandaid_build/nano/lib/numbers.cpp > bandaid_build/nano/lib/numbers.cpp.sed;
  # echo '// INSERT HERE' >> bandaid_build/nano/lib/numbers.cpp.sed;
sed -n '89,91p' banano_build/nano/lib/numbers.cpp >> bandaid_build/nano/lib/numbers.cpp.sed;
sed '1,91d' bandaid_build/nano/lib/numbers.cpp >> bandaid_build/nano/lib/numbers.cpp.sed;
mv bandaid_build/nano/lib/numbers.cpp.sed bandaid_build/nano/lib/numbers.cpp;

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
awk  'NR==1 || NR==3 || NR==8 || NR==12 || NR==16 || NR==18 || NR==20 || NR==25 || NR==27 || NR==33 || NR==36 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/nano/nano_node/CMakeLists.txt > bandaid_build/nano/nano_node/CMakeLists.txt.awk
mv bandaid_build/nano/nano_node/CMakeLists.txt.awk bandaid_build/nano/nano_node/CMakeLists.txt;

awk  'NR==15 { sub(" -DGIT_COMMIT_HASH", "-DGIT_COMMIT_HASH") }; { print $0 }' bandaid_build/nano/nano_node/CMakeLists.txt > bandaid_build/nano/nano_node/CMakeLists.txt.awk
mv bandaid_build/nano/nano_node/CMakeLists.txt.awk bandaid_build/nano/nano_node/CMakeLists.txt;

awk  'NR==19 { sub(" \"-DQT_NO_KEYWORDS", "\"-DQT_NO_KEYWORDS") }; { print $0 }' bandaid_build/nano/nano_node/CMakeLists.txt > bandaid_build/nano/nano_node/CMakeLists.txt.awk
mv bandaid_build/nano/nano_node/CMakeLists.txt.awk bandaid_build/nano/nano_node/CMakeLists.txt;

#nano/nano_node/daemon.cpp
awk  'NR==116 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/nano_node/daemon.cpp > bandaid_build/nano/nano_node/daemon.cpp.awk
mv bandaid_build/nano/nano_node/daemon.cpp.awk bandaid_build/nano/nano_node/daemon.cpp;

#nano/nano_node/entry.cpp
awk  'NR==84 { sub("nano_dev_network", "banano_dev_network") }; { print $0 }' bandaid_build/nano/nano_node/entry.cpp > bandaid_build/nano/nano_node/entry.cpp.awk
mv bandaid_build/nano/nano_node/entry.cpp.awk bandaid_build/nano/nano_node/entry.cpp;

awk  'NR==85 { sub("nano_dev_network", "banano_dev_network") }; { print $0 }' bandaid_build/nano/nano_node/entry.cpp > bandaid_build/nano/nano_node/entry.cpp.awk
mv bandaid_build/nano/nano_node/entry.cpp.awk bandaid_build/nano/nano_node/entry.cpp;

awk  'NR==86 { sub("nano_dev_network", "banano_dev_network") }; { print $0 }' bandaid_build/nano/nano_node/entry.cpp > bandaid_build/nano/nano_node/entry.cpp.awk
mv bandaid_build/nano/nano_node/entry.cpp.awk bandaid_build/nano/nano_node/entry.cpp;

awk  'NR==87 { sub("nano_dev_network", "banano_dev_network") }; { print $0 }' bandaid_build/nano/nano_node/entry.cpp > bandaid_build/nano/nano_node/entry.cpp.awk
mv bandaid_build/nano/nano_node/entry.cpp.awk bandaid_build/nano/nano_node/entry.cpp;

awk  'NR==153 { sub("nano_dev_network", "banano_dev_network") }; { print $0 }' bandaid_build/nano/nano_node/entry.cpp > bandaid_build/nano/nano_node/entry.cpp.awk
mv bandaid_build/nano/nano_node/entry.cpp.awk bandaid_build/nano/nano_node/entry.cpp;

awk  'NR==1915 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/nano_node/entry.cpp > bandaid_build/nano/nano_node/entry.cpp.awk
mv bandaid_build/nano/nano_node/entry.cpp.awk bandaid_build/nano/nano_node/entry.cpp;

awk  'NR==1915 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/nano_node/entry.cpp > bandaid_build/nano/nano_node/entry.cpp.awk
mv bandaid_build/nano/nano_node/entry.cpp.awk bandaid_build/nano/nano_node/entry.cpp;

#nano/nano_rpc/CMakeLists.txt
awk  'NR==1 || NR==3 || NR==6 || NR==13 || NR==15 { sub("nano_rpc", "banano_rpc") }; { print $0 }' bandaid_build/nano/nano_rpc/CMakeLists.txt > bandaid_build/nano/nano_rpc/CMakeLists.txt.awk
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

  ## start_timestamp and end_timestamp
  # copy lines from bandaid_build, (nano with edits)
sed -n '1,85p' bandaid_build/nano/node/cli.cpp > bandaid_build/nano/node/cli.cpp.sed;
  # copy lines from banano_build, (banano with no edits)
sed -n '86,89p' banano_build/nano/node/cli.cpp >> bandaid_build/nano/node/cli.cpp.sed;

  # copy lines from bandaid_build, (nano with edits)
sed -n '87,103p' bandaid_build/nano/node/cli.cpp >> bandaid_build/nano/node/cli.cpp.sed;

  # copy lines from banano_build, (banano with no edits)
sed -n '107,109p' banano_build/nano/node/cli.cpp >> bandaid_build/nano/node/cli.cpp.sed;

  # copy lines from bandaid_build, (nano with edits)
sed -n '104,1303p' bandaid_build/nano/node/cli.cpp >> bandaid_build/nano/node/cli.cpp.sed;

  # copy lines from banano_build, (banano with no edits)
sed -n '1310,1558p' banano_build/nano/node/cli.cpp >> bandaid_build/nano/node/cli.cpp.sed;

  #copy to the end, delete the top lines.
sed '1,1537d' bandaid_build/nano/node/cli.cpp >> bandaid_build/nano/node/cli.cpp.sed;

sed -n '1559,1599p' banano_build/nano/node/cli.cpp >> bandaid_build/nano/node/cli.cpp.sed;

mv bandaid_build/nano/node/cli.cpp.sed bandaid_build/nano/node/cli.cpp;

awk  'NR==701 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/cli.cpp > bandaid_build/nano/node/cli.cpp.awk;
mv bandaid_build/nano/node/cli.cpp.awk bandaid_build/nano/node/cli.cpp;

#nano/node/election.cpp
awk 'NR==196 { sub("node.network_params.network.is_dev_network \\(\\) \\? 500 : ","") }; { print $0 }' bandaid_build/nano/node/election.cpp > bandaid_build/nano/node/election.cpp.awk
mv bandaid_build/nano/node/election.cpp.awk bandaid_build/nano/node/election.cpp;

#nano/node/json_handler.hpp
awk  'NR==70 { print "\tvoid delegators_decimal ();" }; { print $0 }' bandaid_build/nano/node/json_handler.hpp > bandaid_build/nano/node/json_handler.hpp.awk
mv bandaid_build/nano/node/json_handler.hpp.awk bandaid_build/nano/node/json_handler.hpp;

awk  'NR==77 || NR==78 { sub("Mxrb_ratio", "BAN_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.hpp > bandaid_build/nano/node/json_handler.hpp.awk
mv bandaid_build/nano/node/json_handler.hpp.awk bandaid_build/nano/node/json_handler.hpp;

awk  'NR==97 { print "\tvoid raw_to_dec ();" }; { print $0 }' bandaid_build/nano/node/json_handler.hpp > bandaid_build/nano/node/json_handler.hpp.awk
mv bandaid_build/nano/node/json_handler.hpp.awk bandaid_build/nano/node/json_handler.hpp;

awk  'NR==102 { print "\tvoid representatives_decimal_millions ();" }; { print $0 }' bandaid_build/nano/node/json_handler.hpp > bandaid_build/nano/node/json_handler.hpp.awk
mv bandaid_build/nano/node/json_handler.hpp.awk bandaid_build/nano/node/json_handler.hpp;

# nano/node/json_handler.cpp
awk  'NR==2 { print "#include <nano/lib/convert.hpp>" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==104 { sub("krai_from_raw", "banoshi_from_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==106 || NR==110 { sub("kxrb_ratio", "banoshi_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==108 { sub("krai_to_raw", "banoshi_to_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==114 || NR==118 { sub("xrb_ratio", "RAW_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==112 { sub("rai_from_raw", "raw_from_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==116 { sub("rai_to_raw", "raw_to_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==120 { sub("mrai_from_raw", "ban_from_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==124 { sub("mrai_to_raw", "ban_to_raw") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

sed -n '1,133p' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.sed;
sed -n '134,146p' banano_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
sed '1,134d' bandaid_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
mv bandaid_build/nano/node/json_handler.cpp.sed bandaid_build/nano/node/json_handler.cpp;

awk  'NR==549 { print "\t\tresponse_l.put (\"balance_decimal\", convert_raw_to_dec (balance.first.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==551 { print "\t\tresponse_l.put (\"pending_decimal\", convert_raw_to_dec (balance.second.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==553 { print "\t\tresponse_l.put (\"receivable_decimal\", convert_raw_to_dec (balance.second.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==654 { print "\t\t\tresponse_l.put (\"balance_decimal\", convert_raw_to_dec (balance));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==671 { print "\t\t\t\tresponse_l.put (\"confirmed_balance_decimal\", convert_raw_to_dec (confirmed_balance));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==718 { print "\t\t\t\tresponse_l.put (\"weight_decimal\", convert_raw_to_dec (account_weight.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==719 { print "\t\t\t\tresponse_l.put (\"weight_decimal_millions\", convert_raw_to_dec (account_weight.convert_to<std::string> (), nano::MBAN_ratio));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==725 { print "\t\t\t\tresponse_l.put (\"pending_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==727 { print "\t\t\t\tresponse_l.put (\"receivable_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==734 { print "\t\t\t\t\tresponse_l.put (\"confirmed_pending_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==917 { print "\t\tresponse_l.put (\"weight_decimal\", convert_raw_to_dec (balance.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==936 { print "\t\t\tentry.put (\"balance_decimal\", convert_raw_to_dec (balance.first.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==938 { print "\t\t\tentry.put (\"balance_decimal\", convert_raw_to_dec (balance.second.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==940 { print "\t\t\tentry.put (\"receivable_decimal\", convert_raw_to_dec (balance.second.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==1095 { print "\t\t\t\t\t\t\t\tpending_tree.put (\"amount_decimal\", convert_raw_to_dec (info.amount.number ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==1186 { print "\t\t\t\tresponse_l.put (\"amount_decimal\", convert_raw_to_dec (amount.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==1190 { print "\t\t\tresponse_l.put (\"balance_decimal\", convert_raw_to_dec (balance.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==1348 { print "\t\t\t\t\t\tentry.put (\"amount_decimal\", convert_raw_to_dec (amount.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==1352 { print "\t\t\t\t\tentry.put (\"balance_decimal\", convert_raw_to_dec (balance.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2075 { print "\t\t\t\telection.put (\"tally_decimal\", convert_raw_to_dec (status.tally.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2117 { print "\t\t\t\tentry.put (\"tally_decimal\", convert_raw_to_dec (tally.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2155 { print "\t\t\tresponse_l.put (\"total_tally_decimal\", convert_raw_to_dec (total.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2157 { print "\t\t\t//response_l.put (\"final_tally_decimal\", info.status.final_tally.to_string_dec ());" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2175 { print "\tresponse_l.put (\"quorum_delta_decimal\", convert_raw_to_dec (node.online_reps.delta ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2178 { print "\tresponse_l.put (\"online_weight_minimum_decimal\", convert_raw_to_dec (node.config.online_weight_minimum.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2180 { print "\tresponse_l.put (\"online_stake_total_decimal\", convert_raw_to_dec (node.online_reps.online ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2182 { print "\tresponse_l.put (\"trended_stake_total_decimal\", convert_raw_to_dec (node.online_reps.trended ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2184 { print "\tresponse_l.put (\"peers_stake_total_decimal\", convert_raw_to_dec (node.rep_crawler.total_weight ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

# awk  'NR==2186 { print "\t\t\tpeer_node.put (\"weight_decimal\", convert_raw_to_dec (peer.weight.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
# mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

sed -n '1,2281p' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.sed;
  # echo '// INSERT HERE' >> bandaid_build/nano/node/json_handler.cpp.sed;
sed -n '2282,2317p' banano_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
sed '1,2281d' bandaid_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
mv bandaid_build/nano/node/json_handler.cpp.sed bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2481 { print "\t\t\ttree.put (\"amount_decimal\", convert_raw_to_dec (amount));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2487 { print "\t\t\ttree.put (\"balance_decimal\", convert_raw_to_dec (block_a.hashables.balance.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2504 { print "\t\t\ttree.put (\"amount_decimal\", convert_raw_to_dec (amount));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2538 { print "\t\t\t\ttree.put (\"amount_decimal\", convert_raw_to_dec (amount));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2545 { print "\t\t\ttree.put (\"amount_decimal\", convert_raw_to_dec (nano::dev::constants.genesis_amount.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2565 { print "\t\t\ttree.put (\"balance_decimal\", convert_raw_to_dec (block_a.hashables.balance.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2599 { print "\t\t\ttree.put (\"amount_decimal\", convert_raw_to_dec ((previous_balance - balance).convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2639 { print "\t\t\t\ttree.put (\"amount_decimal\", convert_raw_to_dec ((balance - previous_balance).convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2863 { print "\t\t\t\t\t\tresponse_a.put (\"pending_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2865 { print "\t\t\t\t\t\tresponse_a.put (\"receivable_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2873 { print "\t\t\t\t\tresponse_a.put (\"balance_decimal\", convert_raw_to_dec (balance));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2884 { print "\t\t\t\t\t\tresponse_a.put (\"weight_decimal\", convert_raw_to_dec (account_weight.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2920 { print "\t\t\t\t\t\tresponse_a.put (\"pending_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2922 { print "\t\t\t\t\t\tresponse_a.put (\"receivable_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2930 { print "\t\t\t\t\tresponse_a.put (\"balance_decimal\", convert_raw_to_dec (balance));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2941 { print "\t\t\t\t\t\tresponse_a.put (\"weight_decimal\", convert_raw_to_dec (account_weight.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==2988 { sub("Mxrb_ratio", "MBAN_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

sed -n '1,3000p' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.sed;
  # echo '// INSERT HERE' >> bandaid_build/nano/node/json_handler.cpp.sed;
sed -n '3001,3010p' banano_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
sed '1,3000d' bandaid_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
mv bandaid_build/nano/node/json_handler.cpp.sed bandaid_build/nano/node/json_handler.cpp;

awk  'NR==3016 { sub("Mxrb_ratio", "MBAN_ratio") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==3195 { print "\t\t\t\t\t\t\tpending_tree.put (\"amount_decimal\", convert_raw_to_dec (info.amount.number ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

sed -n '1,3624p' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.sed;
  # echo '// INSERT HERE' >> bandaid_build/nano/node/json_handler.cpp.sed;
sed -n '3625,3669p' banano_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
sed '1,3624d' bandaid_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
mv bandaid_build/nano/node/json_handler.cpp.sed bandaid_build/nano/node/json_handler.cpp;

sed -n '1,3673p' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.sed;
  # echo '// INSERT HERE' >> bandaid_build/nano/node/json_handler.cpp.sed;
sed -n '3674,3674p' banano_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
sed '1,3674d' bandaid_build/nano/node/json_handler.cpp >> bandaid_build/nano/node/json_handler.cpp.sed;
mv bandaid_build/nano/node/json_handler.cpp.sed bandaid_build/nano/node/json_handler.cpp;

awk  'NR==3751 { print "\t\t\t\tweight_node.put (\"weight_decimal\", convert_raw_to_dec (account_weight.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4468 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4598 { print "\t\tresponse_l.put (\"balance_decimal\", convert_raw_to_dec (balance.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4600 { print "\t\tresponse_l.put (\"pending_decimal\", convert_raw_to_dec (receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4602 { print "\t\tresponse_l.put (\"receivable_decimal\", convert_raw_to_dec (receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4632 { print "\t\t\t\tentry.put (\"balance_decimal\", convert_raw_to_dec (balance.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4634 { print "\t\t\t\tentry.put (\"pending_decimal\", convert_raw_to_dec (receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  ' NR==4636 { print "\t\t\t\tentry.put (\"receivable_decimal\", convert_raw_to_dec (receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4897 { print "\t\t\t\t\tentry.put (\"balance_decimal\", convert_raw_to_dec (balance));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4908 { print "\t\t\t\t\t\tentry.put (\"weight_decimal\", convert_raw_to_dec (account_weight.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4914 { print "\t\t\t\t\t\tentry.put (\"pending_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4916 { print "\t\t\t\t\t\tentry.put (\"receivable_decimal\", convert_raw_to_dec (account_receivable.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==4985 { print "\t\t\t\t\t\t\t\tpending_tree.put (\"amount_decimal\", convert_raw_to_dec (info.amount.number ().convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

awk  'NR==5553 { print "\tno_arg_funcs.emplace (\"raw_to_dec\", &nano::json_handler::raw_to_dec);" }; { print $0 }' bandaid_build/nano/node/json_handler.cpp > bandaid_build/nano/node/json_handler.cpp.awk
mv bandaid_build/nano/node/json_handler.cpp.awk bandaid_build/nano/node/json_handler.cpp;

#nano/node/network.cpp
awk  'NR==1016 || NR==1018 || NR==1020 || NR==1022 { sub(":nano", ":banano") }; { print $0 }' bandaid_build/nano/node/network.cpp > bandaid_build/nano/node/network.cpp.awk
mv bandaid_build/nano/node/network.cpp.awk bandaid_build/nano/node/network.cpp;

#nano/node/logging.cpp
awk  'NR==42 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/logging.cpp > bandaid_build/nano/node/logging.cpp.awk
mv bandaid_build/nano/node/logging.cpp.awk bandaid_build/nano/node/logging.cpp;

awk  'NR==42 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/logging.cpp > bandaid_build/nano/node/logging.cpp.awk
mv bandaid_build/nano/node/logging.cpp.awk bandaid_build/nano/node/logging.cpp;

#nano/node/node.cpp
awk  'NR==1 { print "#include <nano/lib/convert.hpp>" }; { print $0 }' bandaid_build/nano/node/node.cpp > bandaid_build/nano/node/node.cpp.awk
mv bandaid_build/nano/node/node.cpp.awk bandaid_build/nano/node/node.cpp;

awk  'NR==11 { print "#include <nano/rpc/rpc.hpp>" }; { print $0 }' bandaid_build/nano/node/node.cpp > bandaid_build/nano/node/node.cpp.awk
mv bandaid_build/nano/node/node.cpp.awk bandaid_build/nano/node/node.cpp;

awk  'NR==13 { print "#include <nano/test_common/system.hpp>" }; { print $0 }' bandaid_build/nano/node/node.cpp > bandaid_build/nano/node/node.cpp.awk
mv bandaid_build/nano/node/node.cpp.awk bandaid_build/nano/node/node.cpp;

awk  'NR==268 { print "\t\t\t\t\t\tevent.add (\"amount_decimal\", convert_raw_to_dec (amount_a.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/node.cpp > bandaid_build/nano/node/node.cpp.awk
mv bandaid_build/nano/node/node.cpp.awk bandaid_build/nano/node/node.cpp;

awk  'NR==399 { sub("XRB", "BAN") }; { print $0 }' bandaid_build/nano/node/node.cpp > bandaid_build/nano/node/node.cpp.awk
mv bandaid_build/nano/node/node.cpp.awk bandaid_build/nano/node/node.cpp;

#nano/qt/qt.cpp
awk  'NR==62 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/qt/qt.cpp > bandaid_build/nano/qt/qt.cpp.awk
mv bandaid_build/nano/qt/qt.cpp.awk bandaid_build/nano/qt/qt.cpp;

awk  'NR==1835 || NR==1009 { sub("Mxrb_ratio", "BAN_ratio") }; { print $0 }' bandaid_build/nano/qt/qt.cpp > bandaid_build/nano/qt/qt.cpp.awk
mv bandaid_build/nano/qt/qt.cpp.awk bandaid_build/nano/qt/qt.cpp;

#nano/rpc/CMakeLists.txt


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

awk  'NR==61 { sub("60000", "900") }; { print $0 }' bandaid_build/nano/node/nodeconfig.hpp > bandaid_build/nano/node/nodeconfig.hpp.awk
mv bandaid_build/nano/node/nodeconfig.hpp.awk bandaid_build/nano/node/nodeconfig.hpp;

awk  'NR==93 { sub("10 \\* 1024", "2 * 1024") }; { print $0 }' bandaid_build/nano/node/nodeconfig.hpp > bandaid_build/nano/node/nodeconfig.hpp.awk
mv bandaid_build/nano/node/nodeconfig.hpp.awk bandaid_build/nano/node/nodeconfig.hpp;

#nano/node/portmapping.cpp
awk  'NR==109 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nano/node/portmapping.cpp > bandaid_build/nano/node/portmapping.cpp.awk
mv bandaid_build/nano/node/portmapping.cpp.awk bandaid_build/nano/node/portmapping.cpp;

#nano/node/websocket.cpp
awk  'NR==4 { print "#include <nano/lib/convert.hpp>" }; { print $0 }' bandaid_build/nano/node/websocket.cpp > bandaid_build/nano/node/websocket.cpp.awk
mv bandaid_build/nano/node/websocket.cpp.awk bandaid_build/nano/node/websocket.cpp;

awk  'NR==736 { print "\tmessage_node_l.add (\"amount_decimal\", convert_raw_to_dec (amount_a.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/websocket.cpp > bandaid_build/nano/node/websocket.cpp.awk
mv bandaid_build/nano/node/websocket.cpp.awk bandaid_build/nano/node/websocket.cpp;

awk  'NR==762 { print "\t\telection_node_l.add (\"tally_decimal\", convert_raw_to_dec (election_status_a.tally.to_string_dec ()));" }; { print $0 }' bandaid_build/nano/node/websocket.cpp > bandaid_build/nano/node/websocket.cpp.awk
mv bandaid_build/nano/node/websocket.cpp.awk bandaid_build/nano/node/websocket.cpp;

awk  'NR==777 { print "\t\t\t\tentry.put (\"weight\", convert_raw_to_dec (vote_l.weight.convert_to<std::string> ()));" }; { print $0 }' bandaid_build/nano/node/websocket.cpp > bandaid_build/nano/node/websocket.cpp.awk
mv bandaid_build/nano/node/websocket.cpp.awk bandaid_build/nano/node/websocket.cpp;

#nano/secure/common.cpp
awk  'NR==29 || NR==36 || NR==37 || NR==45 { sub("xrb", "ban") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==31 { sub("E89208DD038FBB269987689621D52292AE9C35941A7484756ECCED92A65093BA", "2514452A978F08D1CF76BB40B6AD064183CF275D3CC5D3E0515DC96E2112AD4E") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==31 { sub("xrb_3t6k35gi95xu6tergt6p69ck76ogmitsa8mnijtpxm9fkcm736xtoncuohr3", "ban_1bananobh5rat99qfgt1ptpieie5swmoth87thi74qgbfrij7dcgjiij94xr") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==45 || NR==46 { sub("nano_1betagoxpxwykx4kw86dnhosc8t3s7ix8eeentwkcg1hbpez1outjrcyg4n1", "bano_1betagoxpxwykx4kw86dnhosc8t3s7ix8eeentwkcg1hbpez1outjrcyg4n1") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==53 { sub("E89208DD038FBB269987689621D52292AE9C35941A7484756ECCED92A65093BA", "2514452A978F08D1CF76BB40B6AD064183CF275D3CC5D3E0515DC96E2112AD4E") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==54 || NR==55 { sub("xrb_3t6k35gi95xu6tergt6p69ck76ogmitsa8mnijtpxm9fkcm736xtoncuohr3", "ban_1bananobh5rat99qfgt1ptpieie5swmoth87thi74qgbfrij7dcgjiij94xr") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==56 { sub("62f05417dd3fb691", "fa055f79fa56abcf") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==57 { sub("9F0C933C8ADE004D808EA1985FA746A7E95BA2A38F867640F53EC8F180BDFE9E2C1268DEAD7C2664F356E37ABA362BC58E46DBA03E523A7B5A19E4B6EB12BB02", "533DCAB343547B93C4128E779848DEA5877D3278CB5EA948BB3A9AA1AE0DB293DE6D9DA4F69E8D1DDFA385F9B4C5E4F38DFA42C00D7B183560435D07AFA18900") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==63 || NR==64 { sub("nano_1jg8zygjg3pp5w644emqcbmjqpnzmubfni3kfe1s8pooeuxsw49fdq1mco9j", "bano_1jg8zygjg3pp5w644emqcbmjqpnzmubfni3kfe1s8pooeuxsw49fdq1mco9j") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==77 { sub("868C6A9F79D4506E029B378262B91538C5CB26D7C346B63902FFEB365F1C1947", "B61453D27E843EB30B8288E37D5E7C64447F9202E589AB9E573DA4460DF7B21B") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==77 { sub("nano_33nefchqmo4ifr3bpfw4ecwjcg87semfhit8prwi7zzd8shjr8c9qdxeqmnx", "ban_3finchb9x33ype7r7495hoh9rs46hyb17sebogh7ghf6ar8zheiucm87mfha") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==78 { sub("7CBAF192A3763DAEC9F9BAC1B2CDF665D8369F8400B4BC5AB4BA31C00BAA4404", "B61453D27E843EB30B8288E37D5E7C64447F9202E589AB9E573DA4460DF7B21B") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==78 { sub("nano_1z7ty8bc8xjxou6zmgp3pd8zesgr8thra17nqjfdbgjjr17tnj16fjntfqfn", "ban_3finchb9x33ype7r7495hoh9rs46hyb17sebogh7ghf6ar8zheiucm87mfha") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==79 { sub("3BAD2C554ACE05F5E528FBBCE79D51E552C55FA765CCFD89B289C4835DE5F04A", "B61453D27E843EB30B8288E37D5E7C64447F9202E589AB9E573DA4460DF7B21B") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==79 { sub("nano_1gxf7jcnomi7yqkkjyxwwygo5sckrohtgsgezp6u74g6ifgydw4cajwbk8bf", "ban_3finchb9x33ype7r7495hoh9rs46hyb17sebogh7ghf6ar8zheiucm87mfha") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==83 || NR==88 || NR==89 || NR==113 || NR==114 || NR==122 || NR==123 || NR==129 || NR==147 { sub(":nano", ":banano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==88 || NR==113 || NR==122 || NR==129 || NR==130 || NR==147 || NR==148 { sub(":nano", ":banano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==89 || NR==114 || NR==123 || NR==130 || NR==148 { sub("\\? nano", "  ? nano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==90 { sub(": nano", "\t: nano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==115 { sub("   : nano", "\t   : nano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==124 { sub("\t : nano", "\t\t : nano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==131 { sub("\t   : nano", "\t\t   : nano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==149 { sub("\t  : nano", "\t\t  : nano") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==94 { sub("\047R\047, \047A\047", "\047B\047, \047Z\047") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==94 { sub("\047R\047, \047B\047", "\047B\047, \047Y\047") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==94 { sub("\047R\047, \047C\047", "\047B\047, \047X\047") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
mv bandaid_build/nano/secure/common.cpp.awk bandaid_build/nano/secure/common.cpp;

awk  'NR==145 { sub("nano_3qb6o6i1tkzr6jwr5s7eehfxwg9x6eemitdinbpi7u8bjjwsgqfj4wzser3x", "bano_3qb6o6i1tkzr6jwr5s7eehfxwg9x6eemitdinbpi7u8bjjwsgqfj4wzser3x") }; { print $0 }' bandaid_build/nano/secure/common.cpp > bandaid_build/nano/secure/common.cpp.awk
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

#nano/slow_test/node.cpp
# awk  'NR==613 { sub("MBAN_ratio", "Gxrb_ratio") }; { print $0 }' bandaid_build/nano/slow_test/node.cpp > bandaid_build/nano/slow_test/node.cpp.awk
# mv bandaid_build/nano/slow_test/node.cpp.awk bandaid_build/nano/slow_test/node.cpp;

#nanocurrency-beta.spec.in
awk  'NR==1 || NR==13 || NR==45 || NR==60 || NR==61 || NR==62 || NR==66 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==45 || NR==54 || NR==58 || NR==59 || NR==60 || NR==61 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==51 || NR==55 || NR==56 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==56 || NR==57 || NR==58 || NR==60 || NR==63 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==57 || NR==58 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==57 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==57 { sub("nanocurrency", "bananocoin") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==4 || NR==13 || NR==55 || NR==57 || NR==60 { sub("Nano", "Banano") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==32 || NR==39 || NR==49 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
mv bandaid_build/nanocurrency-beta.spec.in.awk bandaid_build/nanocurrency-beta.spec.in;

awk  'NR==39 { sub("nano_node", "bananode") }; { print $0 }' bandaid_build/nanocurrency-beta.spec.in > bandaid_build/nanocurrency-beta.spec.in.awk
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
