# Creating a mulle-clang redistributable from binaries using CPack

Wrap mulle-clang files in opt into an install package.
As a bonus a symbolic link is also generated and packaged.


## One script does all

On the VM Host (!) run

```
create-deb "bionic" "9.0.0.0"
```


## Semi-manual Usage

On the VM guest run

```
VERSION=9.0.0.0 package-build
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
VERSION="9"
mkdir mulle-clang
cd mulle-clang
curl -L -O "https://raw.githubusercontent.com/Codeon-GmbH/mulle-clang/mulle_objclang_${VERSION}0/bin/install-mulle-clang"

chmod 755 install-mulle-clang
mkdir -p opt/mulle-clang/${VERSION}.0.0.0
```

####  Build normally

```
./install-mulle-clang --prefix `pwd`/opt/mulle-clang/${VERSION}.0.0.0
```

####  Build with Precise (it is hard)


Get clang-3.6 unto precise otherwise it's hard. For more modern
Ubuntus you can just use the standard compiler and substitute
with `apt-get install build-essential`.


```
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get update
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install git
sudo apt-get install python-software-properties
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo echo -e "deb http://apt.llvm.org/precise/ llvm-toolchain-precise main\n" "deb-src http://apt.llvm.org/precise/ llvm-toolchain-precise main\n" >> /etc/apt/sources.list
sudo echo -e "# 3.6\n"   "deb http://apt.llvm.org/precise/ llvm-toolchain-precise-3.6 main\n" "deb-src http://apt.llvm.org/precise/ llvm-toolchain-precise-3.6 main\n" >> /etc/apt/sources.list
sudo wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
sudo apt-get update
sudo apt-get install -y clang-3.6 clang++-3.6
```

Build with this instead after having done the usual Usage steps

```
CC=clang-3.6 CXX=clang++-3.6 ./install-mulle-clang --prefix `pwd`/opt/mulle-clang/${VERSION}.0.0.0
```

### Create .deb package and upload:

```
cp ../cpack-mulle-clang/* .
chmod 755 generate-package
./generate-package
scp x.deb codeon@www262.your-server.de:/public_html/_site/bottles/
```
