# `clang-musl` overlay
Overlay containing experimental clang-musl profile and related ebuilds.

### Prequisite
  - A working gentoo/musl system.
  - Self-hosted [clang](https://wiki.gentoo.org/wiki/Clang#Bootstrapping_the_Clang_toolchain) compiler
  - Some knowledge of compilers, linkers and gentoo's package manager `portage`.

### Installation
  - Create a new file `/etc/portage/repos.conf/clang-musl.conf` with the following contents:
```
[clang-musl]
sync-uri = https://github.com/dacyberduck/clang-musl-overlay.git
sync-type = git
location = /var/db/repos/clang-musl
```
  - Sync this new repo using `emaint sync -r clang-musl` or `emerge --sync`

### Profiles
`clang-musl` overlay provides `clang-musl` and `clang-musl/hardened` profiles

Switching to `clang-musl` profile:
  - Use `eselect` to list all the profiles. Note the new profile and select the profile
```
eselect profile set --force <profile>
```

### Setting clang/llvm as primary compiler/binutil
  - Switch to `clang-musl` profile 
  - Unmerge `sys-devel/gcc-config`
  - Merge `sys-devel/cc-config` and `sys-devel/binutils-config` from this ovelay
  - Or you can simply `emerge -uDN @world` which will pull in these pkgs
  - To set latest clang as primary compiler
```
cc-config clang
clang-config latest
```
  - To use llvm provided binutils instead of gnu binutils `binutils-config llvm-latest`
  - To rebuild everything using clang/llvm
```
emerge -euDN1 @world
```

### Issues
  - Programs may fail to build when using clang. There are already patches for known issues at [gentoo-patchset](https://github.com/leonardohn/gentoo-patchset.git).
  - LTO and other optimization may lead to build issues for some pkgs. Consider opening bug reports
