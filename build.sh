#! /bin/sh

VERSION="5.0.0.2"
DIST="`lsb_release -sc`"


verify()
{
   if ! fgrep "${VERSION}" cpack-mulle-clang/CMakeLists.txt
   then
      echo "cpack-mulle-clang has the wrong version" >&2
      exit 1
   fi
}


clean()
{
   if [ -d mulle-clang-lldb ]
   then
      rm -rf mulle-clang-lldb
   fi
   mkdir mulle-clang-lldb
}


download()
{
   (
      cd mulle-clang-lldb &&
      curl -L -O "https://raw.githubusercontent.com/Codeon-GmbH/mulle-clang/mulle_objclang_50/install-mulle-clang.sh" &&
      chmod 755 install-mulle-clang.sh 
   )
}


build()
{
   (
      cd mulle-clang-lldb &&
      mkdir -p opt/mulle-clang/${VERSION} &&
      case "${DIST}" in
         precise)
            CC=clang-3.6 CXX=clang++-3.6 ./install-mulle-clang.sh --prefix `pwd`/opt/mulle-clang/${VERSION} --with-lldb
         ;;

         *)
            ./install-mulle-clang.sh --prefix `pwd`/opt/mulle-clang/${VERSION} --with-lldb
         ;;
      esac
   )
}


verpack()
{
   cp cpack-mulle-clang/* mulle-clang-lldb/ &&

   (  
      cd mulle-clang-lldb && 
      chmod 755 generate-package.sh && 
      ./generate-package.sh 
   )
}


upload()
{
   scp mulle-clang-lldb/package/mulle-clang-${VERSION}-Linux.deb \
       oswald:debian-software/dists/${DIST}/main/binary-amd64/mulle-clang-${VERSION}-${DIST}-amd64.deb
}


main()
{
   while [ $# -ne 0 ]
   do
      echo "====== $1 ======" >&2
      "$1" || exit 1
      shift
   done
}


if [ $# -eq 0 ]
then
   main verify clean download build verpack upload
else
   main "$@"
fi

