cd $(dirname "${0}")
cd ..

echo "========================================================================="
echo "Building Frontend"
echo "========================================================================="

yarn install --production=false || exit 1
yarn install_deps_prod || exit 1
yarn build || exit 1

echo "========================================================================="
echo "Building Server"
echo "========================================================================="

export NODE_ENV="production"
mkdir -p certs config
cp yarn.lock build/
cp index.js build/
cp package.json build/
cp -R config build/
cp -R certs build/
cd build
yarn install --production --unsafe-perm || exit 1
