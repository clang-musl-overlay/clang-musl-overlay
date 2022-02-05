# `clang-musl` overlay
Overlay containing experimental clang/musl profile and related ebuilds.

### Goal
The primary goal of this overlay is to provide ebuilds, modified for building programs using the clang compiler.
The `clang/musl` profile is a combined version of gentoo's musl and clang profile. There is also a `clang/musl/hardened` profile available.
Keep in mind that these are experimental profiles and may require manual intervention at times.

### Prequisite
  - Some knowledge of compilers, linkers and gentoo's package manager `portage`.
  - A working gentoo/musl system.
  - Self-hosted [clang](https://wiki.gentoo.org/wiki/Clang#Bootstrapping_the_Clang_toolchain) compiler

### Installation
  - Create a new file `/etc/portage/repos.conf/clang-musl.conf` with the following contents:
```
[clang-musl]
sync-uri = https://github.com/dacyberduck/clang-musl-overlay.git
sync-type = git
location = /var/db/repos/clang-musl
```
  - Sync this new repo using `emaint sync -r clang-musl` or `emerge --sync`
  - Use `eselect` to list all the profiles. Note the new profile and select the profile
```
eselect profile set --force <profile>
```
  - Now you can rebuild your `@world` set. This will rebuild everything using clang
```
emerge -e1 @world
```
