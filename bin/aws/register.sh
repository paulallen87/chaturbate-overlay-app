cd $(dirname "${0}")
BASEDIR=$(pwd -L)
cd -

sh cli.sh configure
sh cli.sh ecs register-task-definition --cli-input-json "file:///src/aws.task.json"
sh cli.sh ecs run-task --task-definition chaturbate