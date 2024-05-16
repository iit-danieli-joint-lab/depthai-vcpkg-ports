vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO robotology/icub-main
    REF "v${VERSION}"
    SHA512 279e3cb7ce07dc9664cafd0aa9ac3273be606bd4888c77b482758de9a5733457d9a177581892470702f23917b5ee2ee45638d4061cbc418738d18e6ccde3e13c
    HEAD_REF master
    PATCHES fix1021.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        "opencv" DEPTHAI_OPENCV_SUPPORT
        "pcl" DEPTHAI_PCL_SUPPORT 
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DHUNTER_SKIP_PACKAGE_nlohmann_json:BOOL=ON
        -DHUNTER_SKIP_PACKAGE_BZip2:BOOL=ON
        -DHUNTER_SKIP_PACKAGE_spdlog:BOOL=ON
        -DHUNTER_SKIP_PACKAGE_ZLIB:BOOL=ON
        -DHUNTER_SKIP_PACKAGE_jsoncpp:BOOL=ON
        -DHUNTER_STATUS_DEBUG:BOOL=ON
        -DHUNTER_USE_CACHE_SERVERS:BOOL=NO
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(
    PACKAGE_NAME ICUB
    CONFIG_PATH lib/cmake/ICUB)
vcpkg_copy_pdbs()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
