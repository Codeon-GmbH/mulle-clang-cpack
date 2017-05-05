# Creating a mulle-clang redistributable from binaries using CPack

Wrap mulle-clang files in opt into an install package.
As a bonus a symbolic link is also generated and packaged.

## Usage

Edit CMakeLists.txt for proper project version then:

```
mkdir -p opt/mulle-clang/4.0.0.0
./install-mulle-clang.sh --prefix `pwd`/opt/mulle-clang/4.0.0.0
./generate-package.sh 
```

