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

if [ -d "package" ]
then
   rm -rf package || exit 1
fi

mkdir package || exit 1
cd package
cmake ${CMAKE_FLAGS} ..
make ${MAKE_FLAGS}
cpack ${CPACK_FLAGS} -G "${GENERATOR}" ..

