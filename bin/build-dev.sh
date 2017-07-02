cd $(dirname "${0}")
cd ..

yarn install || exit 1
yarn install_deps || exit 1