vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO luxonis/XLink
    REF "e9eb1ef38030176ad70cddd3b545d5e6c509f1e1"
    SHA512 0ad314d3818c68097f3d39f57954e3fdf3204ccbbf8e2f8333f274fac789868fa7cd277659a6e2127e4fc549aa9a91e49a9554dcc37612b944fc458e8a412d68
    HEAD_REF master
    #PATCHES fix_libusb_include_dir.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DHUNTER_ENABLE:BOOL=OFF
        -DHUNTER_USE_CACHE_SERVERS:BOOL=NO
        # Avoid that we pollute the global state of the system
        # and to accidentally access cache, this is required
        # as even if HUNTER_ENABLE is set to OFF, Hunter still
        # by default pollutes directories outside of the build dir
        -DHUNTER_ROOT:PATH=${CURRENT_PACKAGES_DIR}/hunter_root/
        # Workaround for forcing Hunter not to add anything to CMAKE_MODULE_PATH
        -DHUNTER_CMAKE_HUNTER_:BOOL=ON
        # Use vcpkg's libusb
        -DXLINK_LIBUSB_SYSTEM:BOOL=ON

)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME XLink CONFIG_PATH "lib/cmake/XLink")
vcpkg_copy_pdbs()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/hunter_root"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
