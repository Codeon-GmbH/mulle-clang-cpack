# Creating a mulle-clang redistributable from binaries using CPack

Wrap mulle-clang files in opt into an install package.
As a bonus a symbolic link is also generated and packaged.

## Prerequisites

* sudo
* git


## One script does all

On the VM Host (!) run

```
create-deb "bullseye" "11.0.0.0"
```


## Semi-manual Usage

On the VM guest run

```
VERSION=11.0.0.0 package-build
```


## Manual Usage

### Get git happening and clone cpack-mulle-clang:

```
sudo apt-get install git
git clone https://github.com/Codeon-GmbH/mulle-clang-cpack.git
```

### Build mulle-clang into a local opt folder:

Set `VERSION` appropriately:

```
VERSION="11"
RC="" # e.g. -RC1
mkdir mono
cd mono
wget -O - "https://github.com/Codeon-GmbH/mulle-clang-project/archive/${VERSION}.0.0.0${RC}.tar.gz" | tar xfz -
mv "mulle-clang-project-${VERSION}.0.0.0${RC}" mulle-clang-project
mkdir opt/mulle-clang-project
sudo ln -s "$PWD/opt/mulle-clang-project" "/opt/mulle-clang-project"
```

####  Build normally

```
PREFIX="/opt" NAME="${VERSION}.0.0.0" ./mulle-clang-project/clang/bin/cmake-ninja.linux
```


### Create .deb package and upload:

```
cp ../cpack-mulle-clang/* .
chmod 755 generate-package
./generate-package
scp x.deb codeon@www262.your-server.de:/public_html/_site/bottles/
```
