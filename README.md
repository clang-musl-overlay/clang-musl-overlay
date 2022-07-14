# `clang-musl` overlay
Overlay containing experimental clang-musl profile and related ebuilds.

### Prequisite
  - A working gentoo/musl system.
  - Self-hosted [clang](https://wiki.gentoo.org/wiki/Clang#Bootstrapping_the_Clang_toolchain) compiler, with the default-libcxx USE flag enabled.
  - Some knowledge of compilers, linkers and gentoo's package manager `portage`.

### Installation
  - Create a new file `/etc/portage/repos.conf/clang-musl.conf` with the following contents:
```
[clang-musl]
sync-uri = https://github.com/clang-musl-overlay/clang-musl-overlay.git
sync-type = git
location = /var/db/repos/clang-musl
sync-depth = 1
```
  - Sync this new repo using `emaint sync -r clang-musl` or `emerge --sync`

### Profiles
`clang-musl` overlay provides `clang-musl` and `clang-musl/hardened` profiles

Switching to `clang-musl` profile:
  - Use `eselect` to list all the profiles. Note the new profile and select the profile
```
eselect profile set --force <profile>
```

### Setting clang and llvm binutils as default
  - Switch to `clang-musl` profile 
  - Unmerge gcc, binutils and their dependencies with a --depclean. `emerge -c`
  - Merge `sys-devel/llvm-conf`. This should automatically set latest llvm/clang as your default toolchain.
    - Or you can run `llvm-conf --enable-native-links --enable-clang-wrappers --enable-binutils-wrappers llvm-14`
  - Now you can run `emerge -1euDN @world` to rebuild everything with clang/llvm.

### Issues
  - Programs may fail to build when using clang. There are already patches for known issues at [gentoo-patchset](https://github.com/leonardohn/gentoo-patchset.git).
  - LTO and other optimization may lead to build issues for some pkgs. Please report if you find any issue.
