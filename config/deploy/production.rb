# デプロイに使用するbranch
set :branch, 'master'

#　デプロイ先のip
server '' , user: 'ec2-user', roles: %w{ app db web}