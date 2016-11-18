#! /bin/sh

case "`uname`" in
   Darwin*)
      GENERATOR="productbuild"
   ;;
   Linux*)
      GENERATOR="DEB"
   ;;
   Win*|Min*)
      GENERATOR="NSIS"
   ;;
   *)
      GENERATOR="TGZ"
   ;;
esac


GENERATOR="${1:-${GENERATOR}}"

if [ -d "build" ]
then
   rm -rf build || exit 1
fi

mkdir build || exit 1
cd build
cmake ${CMAKE_FLAGS} ..
make ${MAKE_FLAGS}
cpack ${CPACK_FLAGS} -G "${GENERATOR}" ..

