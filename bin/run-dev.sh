cd $(dirname "${0}")
cd ..

export FRONTEND_BUNDLE="."
export DEBUG="chaturbate:*"

yarn start