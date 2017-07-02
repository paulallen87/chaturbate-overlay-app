cd $(dirname "${0}")
cd ..

export NODE_ENV="production"
export FRONTEND_BUNDLE="es6-bundled"
export DEBUG="chaturbate:*"

cd build
yarn start
