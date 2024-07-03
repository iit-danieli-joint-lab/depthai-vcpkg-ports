vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO luxonis/XLink
    REF "e9eb1ef38030176ad70cddd3b545d5e6c509f1e1"
    SHA512 0ad314d3818c68097f3d39f57954e3fdf3204ccbbf8e2f8333f274fac789868fa7cd277659a6e2127e4fc549aa9a91e49a9554dcc37612b944fc458e8a412d68
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DHUNTER_ENABLE:BOOL=OFF
        -DXLINK_LIBUSB_SYSTEM:BOOL=NO
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME XLink CONFIG_PATH "lib/cmake/XLink")
vcpkg_copy_pdbs()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
