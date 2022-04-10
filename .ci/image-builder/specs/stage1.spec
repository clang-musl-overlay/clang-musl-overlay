subarch: amd64
target: stage1
version_stamp: musl-llvm-@TIMESTAMP@
rel_type: musl-llvm
profile: default/linux/amd64/17.0/musl/llvm-toolchain
snapshot: @TIMESTAMP@
source_subpath: musl-llvm/stage3-amd64-musl-llvm-latest
chost: x86_64-gentoo-linux-musl
portage_confdir: @REPO_DIR@/releases/portage/stages
portage_prefix: clang-musl
update_seed: yes
update_seed_command: --update --deep --newuse @world
compression_mode: pixz
