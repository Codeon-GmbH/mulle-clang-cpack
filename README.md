# Creating a mulle-clang redistributable from binaries using CPack

Wrap mulle-clang files in opt into an install package.
As a bonus a symbolic link is also generated and packaged.

## Create a fresh debian VM (if needed)

Here we are installing into a fresh "buster" VM  of the same name:

```
scp ~/.ssh/id_rsa_vm.pub buster:
ssh buster
mkdir .ssh
mv id_rsa_vm.pub .ssh/authorized_keys
chmod 400 .ssh/authorized_keys
chmod 700 .ssh
```


## Prerequisites

* sudo
* git

On debian, install **git** and get **sudo** happening

```
su
apt-get install git sudo
/sbin/usermod -aG sudo <loginname> # or your login
sudo /sbin/visudo
# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) NOPASSWD: ALL
# log off now, so sudo group change takes effect
```

Install **cmake** and such things:

```
wget 'https://raw.githubusercontent.com/mulle-objc/mulle-clang-project/mulle/14.0.6/clang/bin/install-prerequisites'
chmod 755 install-prerequisites
./install-prerequisites --no-lldb
```

## One script does all

On the VM Host (!) run

```
VERSION=14.0.6.1 RC=1 ./create-deb "bullseye"
```


## Semi-manual Usage

On the VM guest run

```
VERSION=14.0.6.1 package-build
```


## Manual Usage

### Get git happening and clone cpack-mulle-clang:

```
sudo apt-get install git sudo
git clone https://github.com/mulle-objc/mulle-clang-cpack.git
```

### Build mulle-clang into a local opt folder:

Set `VERSION` appropriately:

```
VERSION="13"
RC="" # e.g. -RC1
mkdir mono
cd mono
wget -O - "https://github.com/mulle-objc/mulle-clang-project/archive/${VERSION}.0.0.1${RC}.tar.gz" | tar xfz -
mv "mulle-clang-project-${VERSION}.0.0.1${RC}" mulle-clang-project
mkdir opt/mulle-clang-project
sudo ln -s "$PWD/opt/mulle-clang-project" "/opt/mulle-clang-project"
```

####  Build normally

```
PREFIX="/opt" NAME="${VERSION}.0.0.1" ./mulle-clang-project/clang/bin/cmake-ninja.linux
```


### Create .deb package and upload:

```
cp ../cpack-mulle-clang/* .
chmod 755 generate-package
./generate-package
# scp x.deb codeon@www262.your-server.de:/public_html/_site/bottles/
```
