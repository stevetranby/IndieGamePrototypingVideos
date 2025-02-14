echo "Building Mooselutions"

APP_NAME="Mooselutions"
APP_BUNDLE_NAME="Mooselutions.app"

# pushd moves us into a directory where we will exectue commands
pushd ../../build/mac_os/

# This is the mac platform layer path from inside of the build directory for mac.
MAC_PLATFORM_LAYER_PATH=../../code/mac_platform

MAC_FRAMEWORKS="-framework AppKit 
                -framework MetalKit 
                -framework Metal"

xcrun -sdk macosx metal -gline-tables-only -MO -g -c "${MAC_PLATFORM_LAYER_PATH}/Shaders.metal" -o Shaders.air
xcrun -sdk macosx metallib Shaders.air -o Shaders.metallib

# clang will be invoked from inside of the build directory
clang -g $MAC_FRAMEWORKS -lstdc++ -o $APP_NAME ${MAC_PLATFORM_LAYER_PATH}/mac_os_main.mm
              


rm -rf $APP_BUNDLE_NAME
mkdir -p ${APP_BUNDLE_NAME}/Contents/Resources

cp $APP_NAME ${APP_BUNDLE_NAME}/${APP_NAME}
cp ${MAC_PLATFORM_LAYER_PATH}/resources/Info.plist ${APP_BUNDLE_NAME}/Contents/Info.plist
cp ./Shaders.metallib ${APP_BUNDLE_NAME}/Contents/Resources/Shaders.metallib

popd

echo "Finished Building Mooselutions"
