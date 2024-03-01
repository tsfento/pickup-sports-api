set -o errexit
bundle install
bunde exec rake db:migrate