vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO luxonis/depthai-core
    REF "v${VERSION}"
    SHA512 05032653a3843acd6fb0fc158e7eea42560f0578c7d6c738d63633dbf9bdbc6df436dae10360514a13e236099775a446ff69468ef0b9eaed7c655b698fd514b3
    HEAD_REF master
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
        -DHUNTER_ENABLE:BOOL=OFF
        -DDEPTHAI_ENABLE_BACKWARD:BOOL=OFF
        -DHUNTER_USE_CACHE_SERVERS:BOOL=NO
        # Avoid that we pollute the global state of the system
        # and to accidentally access cache, this is required
        # as even if HUNTER_ENABLE is set to OFF, Hunter still
        # by default pollutes directories outside of the build dir
        -DHUNTER_ROOT:PATH=${CURRENT_PACKAGES_DIR}/hunter_root/
        # Workaround for forcing Hunter not to add anything to CMAKE_MODULE_PATH
        -DHUNTER_CMAKE_HUNTER_:BOOL=ON
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
