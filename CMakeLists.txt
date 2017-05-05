cmake_minimum_required (VERSION 3.0)

project ( cpack-mulle-clang VERSION 4.0.0.0)

#
# just some libraries
#
install( DIRECTORY "opt/mulle-clang/${PROJECT_VERSION}" DESTINATION "/opt/mulle-clang" USE_SOURCE_PERMISSIONS)

#
# create a symlink for binary
#
if(CMAKE_HOST_UNIX)
execute_process(COMMAND ln -s ../../opt/mulle-clang/${PROJECT_VERSION}/bin/clang mulle-clang)
install( FILES ${CMAKE_BINARY_DIR}/mulle-clang DESTINATION "/usr/bin")
endif(CMAKE_HOST_UNIX)

#
# CPack and project specific stuff
#
######
set( CPACK_PACKAGE_NAME "mulle-clang")
set( CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
set( CPACK_STRIP_FILES true)

# stuff needed for Debian
# memo: its impossible to check for chosen generator here 

set( CPACK_PACKAGE_CONTACT "Nat! <nat@codeon.de>")

set( CPACK_DEBIAN_PACKAGE_HOMEPAGE "https://github.com/codeon-gmbh/mulle-clang")
set( CPACK_DEBIAN_PACKAGE_DESCRIPTION "mulle-clang, the mulle-objc compiler based on clang")

set( CPACK_RPM_PACKAGE_VENDOR "Codeon GmbH")
set( CPACK_RPM_PACKAGE_DESCRIPTION "${CPACK_DEBIAN_PACKAGE_DESCRIPTION}")
 
######
#
# must be after CPACK_PACKAGE_VERSION
include( CPack)

