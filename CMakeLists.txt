cmake_minimum_required(VERSION 3.5)
project(gurobi VERSION 6.0.5 LANGUAGES C)

if(CMAKE_VERSION VERSION_LESS 3.7)
  set(CMAKE_MODULE_PATH
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules/3.7"
    ${CMAKE_MODULE_PATH}
  )
endif()

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE Release CACHE STRING
    "Choose the type of build; options are Debug Release RelWithDebInfo MinSizeRel"
    FORCE
  )
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY
    STRINGS
      Debug
      Release
      RelWithDebInfo
      MinSizeRel
  )
endif()

include(CMakePackageConfigHelpers)
include(CTest)
include(GNUInstallDirs)

if(NOT GUROBI_PLATFORM)
  if(CMAKE_SYSTEM_NAME STREQUAL Darwin)
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
      set(GUROBI_PLATFORM mac64)
    else()
      message(FATAL_ERROR "Gurobi is NOT available for the mac32 platform")
    endif()
  elseif(CMAKE_SYSTEM_NAME STREQUAL Linux)
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
      set(GUROBI_PLATFORM linux64)
    else()
      message(FATAL_ERROR "Gurobi is NOT available for the linux32 platform")
    endif()
  else()
    message(FATAL_ERROR "Gurobi is NOT available for this platform")
  endif()
endif()

set(GUROBI_PLATFORM "${GUROBI_PLATFORM}" CACHE STRING
  "Choose the Gurobi platform; options are mac64 linux64"
)
set_property(CACHE GUROBI_PLATFORM PROPERTY
  STRINGS
    mac64
    linux64
)

message(STATUS "Gurobi platform is ${GUROBI_PLATFORM}")

if(GUROBI_PLATFORM STREQUAL mac64)
  set(GUROBI_EXPECTED_SHA256
    63a6e5b8734b14ad54f2ccc47620e1bd8bbea02a66f88a7fd969278644b8d125
  )
elseif(GUROBI_PLATFORM STREQUAL linux64)
  set(GUROBI_EXPECTED_SHA256
    171e899350353fa012a5c38f8acd3c0ac0482e1e16f973d944535fd3abd5053e
  )
else()
  message(FATAL_ERROR "Gurobi is NOT available for this platform")
endif()

set(GUROBI_DISTRO "$ENV{GUROBI_DISTRO}" CACHE INTERNAL
  "Path to the Gurobi archive"
)

if(NOT GUROBI_DISTRO OR NOT EXISTS "${GUROBI_DISTRO}" OR IS_DIRECTORY "${GUROBI_DISTRO}")
  message(FATAL_ERROR "Please download the Gurobi ${PROJECT_VERSION} archive and set \$GUROBI_DISTRO to its location. See https://git.io/vXVsE.")
endif()

file(SHA256 "${GUROBI_DISTRO}" GUROBI_ACTUAL_SHA256)

if(NOT GUROBI_ACTUAL_SHA256 STREQUAL GUROBI_EXPECTED_SHA256)
  message(FATAL_ERROR "The Gurobi archive SHA256 hash does NOT match")
endif()

set(GUROBI_DISTRO_EXTRACTED
  "${CMAKE_CURRENT_BINARY_DIR}/gurobi${PROJECT_VERSION_MAJOR}${PROJECT_VERSION_MINOR}${PROJECT_VERSION_PATCH}"
)

if(EXISTS "${GUROBI_DISTRO_EXTRACTED}")
  file(TIMESTAMP "${GUROBI_DISTRO}" GUROBI_DISTRO_TIMESTAMP %s)
  file(TIMESTAMP "${GUROBI_DISTRO_EXTRACTED}"
    GUROBI_DISTRO_EXTRACTED_TIMESTAMP %s)

  if(GUROBI_DISTRO_TIMESTAMP GREATER GUROBI_DISTRO_EXTRACTED_TIMESTAMP)
    file(REMOVE_RECURSE "${GUROBI_DISTRO_EXTRACTED}")
  endif()
endif()

if(NOT EXISTS "${GUROBI_DISTRO_EXTRACTED}")
  message(STATUS
    "Extracting Gurobi from archive"
  )

  if(GUROBI_PLATFORM STREQUAL mac64)
    execute_process(
      COMMAND xar -xf "${GUROBI_DISTRO}"
      WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
      RESULT_VARIABLE GUROBI_RESULT_VARIABLE
    )

    if(NOT GUROBI_RESULT_VARIABLE EQUAL 0)
      message(FATAL_ERROR "Could NOT extract Gurobi from archive using xar")
    endif()

    execute_process(
      COMMAND
        "${CMAKE_COMMAND}" -E tar xf "${CMAKE_CURRENT_BINARY_DIR}/gurobi${PROJECT_VERSION_MAJOR}${PROJECT_VERSION_MINOR}${PROJECT_VERSION_PATCH}${GUROBI_PLATFORM}tar.pkg/Payload"
      WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
      RESULT_VARIABLE GUROBI_RESULT_VARIABLE
    )

    if(NOT GUROBI_RESULT_VARIABLE EQUAL 0)
      message(FATAL_ERROR
        "Could NOT extract Gurobi from archive using xar and tar")
    endif()

    execute_process(
      COMMAND
        "${CMAKE_COMMAND}" -E tar xf "${CMAKE_CURRENT_BINARY_DIR}/gurobi${PROJECT_VERSION}_${GUROBI_PLATFORM}.tar.gz"
      WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
      RESULT_VARIABLE GUROBI_RESULT_VARIABLE
    )

    if(NOT GUROBI_RESULT_VARIABLE EQUAL 0)
      message(FATAL_ERROR
        "Could NOT extract Gurobi from archive using xar and tar"
      )
    endif()
  else()
    execute_process(
      COMMAND "${CMAKE_COMMAND}" -E tar xf "${GUROBI_DISTRO}"
      WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
      RESULT_VARIABLE GUROBI_RESULT_VARIABLE
    )

    if(NOT GUROBI_RESULT_VARIABLE EQUAL 0)
      message(FATAL_ERROR "Could NOT extract Gurobi from archive using tar")
    endif()
  endif()

  if(EXISTS "${GUROBI_DISTRO_EXTRACTED}")
    execute_process(
      COMMAND "${CMAKE_COMMAND}" -E touch "${GUROBI_DISTRO_EXTRACTED}"
    )
  else()
    message(FATAL_ERROR
      "Could NOT extract Gurobi from archive"
    )
  endif()
endif()

if(NOT EXISTS "$ENV{HOME}/gurobi.lic")
  message(STATUS
    "Could NOT find Gurobi license file. Please run grbgetkey to install your Gurobi license to \$HOME/gurobi.lic."
  )
endif()

set(GUROBI_PLATFORM_DIR "${GUROBI_DISTRO_EXTRACTED}/${GUROBI_PLATFORM}")

set(GUROBI_BINARY_INCLUDE_DIR "${GUROBI_PLATFORM_DIR}/include")
set(GUROBI_BINARY_LIBRARY_DIR "${GUROBI_PLATFORM_DIR}/lib")

set(GUROBI_LIBRARY gurobi${PROJECT_VERSION_MAJOR}${PROJECT_VERSION_MINOR})

find_library(LIBM_LIBRARY NAMES m)

if(NOT LIBM_LIBRARY)
  message(FATAL_ERROR "LibM NOT found")
endif()

set(GUROBI_INCLUDE_DIR ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})
set(GUROBI_LIBRARY_DIR ${CMAKE_INSTALL_LIBDIR})

install(FILES
  "${GUROBI_BINARY_INCLUDE_DIR}/gurobi_c.h"
  DESTINATION ${GUROBI_INCLUDE_DIR}
)

install(FILES
  "${GUROBI_BINARY_LIBRARY_DIR}/lib${GUROBI_LIBRARY}.so"
  DESTINATION ${GUROBI_LIBRARY_DIR}
)

if(GUROBI_PLATFORM STREQUAL mac64)
  execute_process(
    COMMAND
      "${CMAKE_INSTALL_NAME_TOOL}" -id "${CMAKE_INSTALL_PREFIX}/${GUROBI_LIBRARY_DIR}/lib${GUROBI_LIBRARY}.so" "${GUROBI_BINARY_LIBRARY_DIR}/lib${GUROBI_LIBRARY}.so"
    RESULT_VARIABLE GUROBI_RESULT_VARIABLE
  )

  if(NOT GUROBI_RESULT_VARIABLE EQUAL 0)
    message(FATAL_ERROR "Could NOT change Gurobi dynamic library install name")
  endif()
endif()

if(GUROBI_PLATFORM STREQUAL linux64)
  install(FILES
    "${GUROBI_BINARY_LIBRARY_DIR}/libgurobi.so.${PROJECT_VERSION}"
    DESTINATION ${GUROBI_LIBRARY_DIR}
  )
endif()

install(FILES "${GUROBI_PLATFORM_DIR}/EULA.pdf"
  DESTINATION ${CMAKE_INSTALL_DOCDIR}
)

set(GUROBI_DIR ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

configure_package_config_file(
  gurobi-targets.cmake.in gurobi-targets-install.cmake
  INSTALL_DESTINATION ${GUROBI_DIR}
  PATH_VARS GUROBI_INCLUDE_DIR GUROBI_LIBRARY_DIR
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
  NO_SET_AND_CHECK_MACRO
)

install(FILES
  "${CMAKE_CURRENT_BINARY_DIR}/gurobi-targets-install.cmake"
  DESTINATION ${GUROBI_DIR}
  RENAME gurobi-targets.cmake
)

find_package(PkgConfig MODULE QUIET)

if(PkgConfig_FOUND)
  find_package(Threads MODULE REQUIRED)

  configure_file(gurobi.pc.in gurobi.pc @ONLY)

  install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/gurobi.pc"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
  )
endif()

option(WITH_CPP "Install Gurobi C++ library" OFF)

if(WITH_CPP)
  enable_language(CXX)

  if(GUROBI_PLATFORM STREQUAL mac64)
    set(GUROBI_CPP_LINK_FLAG -stdlib=libstdc++)
  endif()

  install(FILES
    "${GUROBI_BINARY_INCLUDE_DIR}/gurobi_c++.h"
    DESTINATION ${GUROBI_INCLUDE_DIR}
  )

  set(GUROBI_CPP_LIBRARY gurobi_c++)

  install(FILES
    "${GUROBI_BINARY_LIBRARY_DIR}/lib${GUROBI_CPP_LIBRARY}.a"
    "${GUROBI_BINARY_LIBRARY_DIR}/libgurobi_g++4.2.a"
    DESTINATION ${GUROBI_LIBRARY_DIR}
  )

  set(SET_GUROBI_CPP_LIBRARIES
    "set(GUROBI_CPP_LIBRARIES gurobi_c++ ${GUROBI_CPP_LINK_FLAG} \"\${GUROBI_LIBRARIES}\")"
  )

  configure_package_config_file(
    gurobi_c++-targets.cmake.in gurobi_c++-targets-install.cmake
    INSTALL_DESTINATION ${GUROBI_DIR}
    PATH_VARS GUROBI_INCLUDE_DIR GUROBI_LIBRARY_DIR
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
    NO_SET_AND_CHECK_MACRO
  )

  install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/gurobi_c++-targets-install.cmake"
    DESTINATION ${GUROBI_DIR}
    RENAME gurobi_c++-targets.cmake
  )

  set(INCLUDE_GUROBI_CPP_TARGETS
    "include(\"\${CMAKE_CURRENT_LIST_DIR}/gurobi_c++-targets.cmake\")"
  )

  if(PkgConfig_FOUND)
    configure_file(gurobi_c++.pc.in gurobi_c++.pc @ONLY)

    install(FILES
      "${CMAKE_CURRENT_BINARY_DIR}/gurobi_c++.pc"
      DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
    )
  endif()
endif()

option(WITH_JAVA "Install Gurobi Java bindings" OFF)

if(WITH_JAVA)
  find_package(Java 1.6 MODULE REQUIRED)

  if(GUROBI_PLATFORM STREQUAL mac64)
    set(GUROBI_JNI_LIBRARY_SUFFIX .jnilib)
  else()
    set(GUROBI_JNI_LIBRARY_SUFFIX .so)
  endif()

  install(FILES
    "${GUROBI_BINARY_LIBRARY_DIR}/libGurobiJni${PROJECT_VERSION_MAJOR}${PROJECT_VERSION_MINOR}${GUROBI_JNI_LIBRARY_SUFFIX}"
     DESTINATION ${GUROBI_LIBRARY_DIR}
  )

  if(GUROBI_PLATFORM STREQUAL mac64)
    execute_process(
      COMMAND
        "${CMAKE_INSTALL_NAME_TOOL}" -id "${CMAKE_INSTALL_PREFIX}/${GUROBI_LIBRARY_DIR}/libGurobiJni${PROJECT_VERSION_MAJOR}${PROJECT_VERSION_MINOR}${GUROBI_JNI_LIBRARY_SUFFIX}" "${GUROBI_BINARY_LIBRARY_DIR}/libGurobiJni${PROJECT_VERSION_MAJOR}${PROJECT_VERSION_MINOR}${GUROBI_JNI_LIBRARY_SUFFIX}"
      )

    if(NOT GUROBI_RESULT_VARIABLE EQUAL 0)
      message(FATAL_ERROR
        "Could NOT change Gurobi JNI dynamic library install name"
      )
    endif()
  endif()

  set(GUROBI_JAR_DIR ${CMAKE_INSTALL_DATAROOTDIR}/java)

  install(FILES
    "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar"
    DESTINATION ${GUROBI_JAR_DIR}
  )

  configure_package_config_file(
    gurobi_java-targets.cmake.in gurobi_java-targets-install.cmake
    INSTALL_DESTINATION ${GUROBI_DIR}
    PATH_VARS GUROBI_JAR_DIR
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
    NO_SET_AND_CHECK_MACRO
  )

  install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/gurobi_java-targets-install.cmake"
    DESTINATION ${GUROBI_DIR}
    RENAME gurobi_java-targets.cmake
  )

  set(INCLUDE_GUROBI_JAVA_TARGETS
    "include(\"\${CMAKE_CURRENT_LIST_DIR}/gurobi_java-targets.cmake\")"
  )
endif()

option(WITH_PYTHON "Install Gurobi Python bindings" OFF)

if(WITH_PYTHON)
  find_package(PythonInterp 2.7 MODULE REQUIRED)

  add_custom_command(OUTPUT install-python-stamp
    COMMAND
      "${PYTHON_EXECUTABLE}" setup.py install "--prefix=${CMAKE_INSTALL_PREFIX}"
    WORKING_DIRECTORY "${GUROBI_PLATFORM_DIR}"
    COMMENT "Installing Gurobi Python bindings..."
  )
  set_property(SOURCE install-python-stamp PROPERTY SYMBOLIC ON)

  add_custom_target(install-python ALL DEPENDS install-python-stamp)
endif()

option(WITH_MATLAB "Install Gurobi MATLAB bindings" OFF)

if(WITH_MATLAB)
  find_package(Matlab 7.7 MODULE REQUIRED COMPONENTS MAIN_PROGRAM)

  if(GUROBI_PLATFORM STREQUAL mac64)
    execute_process(
      COMMAND
        "${CMAKE_INSTALL_NAME_TOOL}" -change "lib${GUROBI_LIBRARY}.so" "@loader_path/../lib/lib${GUROBI_LIBRARY}.so" gurobi.${Matlab_MEX_EXTENSION}
      WORKING_DIRECTORY "${GUROBI_PLATFORM_DIR}/matlab"
      RESULT_VARIABLE GUROBI_RESULT_VARIABLE
    )

    if(NOT GUROBI_RESULT_VARIABLE EQUAL 0)
      message(FATAL_ERROR
        "Could NOT change Gurobi MEX dynamic library install name"
      )
    endif()
  endif()

  configure_file(addpath_gurobi.m.in addpath_gurobi.m @ONLY)
  configure_file(rmpath_gurobi.m.in rmpath_gurobi.m @ONLY)

  install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/addpath_gurobi.m"
    "${CMAKE_CURRENT_BINARY_DIR}/rmpath_gurobi.m"
    DESTINATION matlab
  )
endif()

configure_package_config_file(gurobi-config.cmake.in gurobi-config.cmake
  INSTALL_DESTINATION ${GUROBI_DIR}
  PATH_VARS GUROBI_INCLUDE_DIR GUROBI_LIBRARY_DIR
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

write_basic_package_version_file(gurobi-config-version.cmake
  COMPATIBILITY SameMajorVersion
)

install(FILES
  "${CMAKE_CURRENT_BINARY_DIR}/gurobi-config.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/gurobi-config-version.cmake"
  DESTINATION ${GUROBI_DIR}
)

add_subdirectory(test)
