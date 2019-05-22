#! /bin/sh

VERSION="8.0.0.0"
BRANCH="mulle_objclang_80"
DIST="`lsb_release -sc`"


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
      curl -L -O "https://raw.githubusercontent.com/Codeon-GmbH/mulle-clang/${BRANCH}/bin/install-mulle-clang" &&
      chmod 755 install-mulle-clang 
   )
}


build()
{
   (
      cd mulle-clang-lldb &&
      mkdir -p opt/mulle-clang/${VERSION} &&
      case "${DIST}" in
         precise)
            CC=clang-3.6 CXX=clang++-3.6 ./install-mulle-clang --prefix `pwd`/opt/mulle-clang/${VERSION} --with-lldb
         ;;

         *)
            ./install-mulle-clang --prefix `pwd`/opt/mulle-clang/${VERSION} --with-lldb
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
      VERSION="${VERSION}" ./generate-package.sh 
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
   main clean download build verpack upload
else
   main "$@"
fi

