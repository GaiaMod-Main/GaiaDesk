clear
echo "Clearing packages"
rm -rf packager-app
rm -rf app/build
rm -rf windows-base
rm -rf GaiaMod-windows.zip
rm -rf gaiamod-main.github.io

echo "Downloading Electron - Windows"
#Windows
curl -L https://github.com/electron/electron/releases/download/v31.3.1/electron-v31.3.1-win32-ia32.zip > windows.zip
unzip windows.zip -d windows-base
rm -rf windows.zip
rm -rf windows-base/resources/default_app.asar

#PM base
echo "Downloading GaiaMod"
export NODE_OPTIONS=--openssl-legacy-provider
git clone https://github.com/GaiaMod-Main/gaiamod-main.github.io.git
cd gaiamod-main.github.io
git pull
npm install --force

#VM
echo "Adding VM"
git clone https://github.com/GaiaMod-Main/GaiaMod-Vm.git
cd GaiaMod-Vm
git pull
npm install --force
cd ..
cp -R GaiaMod-Vm node_modules
rm -rf node_modules/scratch-vm
mv node_modules/GaiaMod-Vm node_modules/scratch-vm

#BLOCKS
echo "Adding Blocks"
git clone https://github.com/GaiaMod-Main/GaiaMod-Blocks.git
cd GaiaMod-Blocks
git pull
npm install --force
cd ..
cp -R GaiaMod-Blocks node_modules
rm -rf node_modules/scratch-blocks
mv node_modules/GaiaMod-Blocks node_modules/scratch-blocks

#RENDERER
echo "Adding Renderer"
git clone https://github.com/GaiaMod-Main/GaiaMod-Render.git
cd GaiaMod-Render
git pull
npm install --force
cd ..
cp -R GaiaMod-Render node_modules
rm -rf node_modules/scratch-render
mv node_modules/GaiaMod-Render node_modules/scratch-render

#PAINT
echo "Adding Paint"
git clone https://github.com/GaiaMod-Main/GaiaMod-Paint.git
cd GaiaMod-Paint
git pull
npm install --force
cd ..
cp -R GaiaMod-Paint node_modules
rm -rf node_modules/scratch-paint
mv node_modules/GaiaMod-Paint node_modules/scratch-paint

echo "Building GaiaMod"
npm run --silent build
sleep 5s
cp -R build ../app
git clone https://github.com/GaiaMod-Main/GaiaMod-Packager.git
cd GaiaMod-Packager
git pull
npm install --force
cd ..
#vm
cp -R GaiaMod-Vm GaiaMod-Packager/node_modules
rm -rf GaiaMod-Packager/node_modules/scratch-vm
mv GaiaMod-Packager/node_modules/GaiaMod-Vm GaiaMod-Packager/node_modules/scratch-vm
#blocks
cp -R GaiaMod-Blocks GaiaMod-Packager/node_modules
rm -rf GaiaMod-Packager/node_modules/scratch-blocks
mv GaiaMod-Packager/node_modules/GaiaMod-Blocks GaiaMod-Packager/node_modules/scratch-blocks
#renderer
cp -R GaiaMod-Render GaiaMod-Packager/node_modules
rm -rf GaiaMod-Packager/node_modules/scratch-render
mv GaiaMod-Packager/node_modules/GaiaMod-Render GaiaMod-Packager/node_modules/scratch-render
#paint
cp -R GaiaMod-Paint GaiaMod-Packager/node_modules
rm -rf GaiaMod-Packager/node_modules/scratch-paint
mv GaiaMod-Packager/node_modules/GaiaMod-Paint GaiaMod-Packager/node_modules/scratch-paint
cd GaiaMod-Packager
npm run --silent build
cd ..
cd ..
cp -R gaiamod-main.github.io/GaiaMod-Packager/dist app/build/packager-app
cp -R app windows-base/resources/
mv windows-base/electron.exe windows-base/GaiaMod-desktop.exe
    zip -r GaiaMod-windows.zip windows-base
