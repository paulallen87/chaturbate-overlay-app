cd $(dirname "${0}")
BASEDIR=$(pwd -L)
cd -

docker run \
  -t \
  -i \
  --volume=/tmp/awscli:/home/aws/.aws/ \
  --volume=${BASEDIR}/../..:/src \
  fstab/aws-cli \
  /home/aws/aws/env/bin/aws \
  ${@}