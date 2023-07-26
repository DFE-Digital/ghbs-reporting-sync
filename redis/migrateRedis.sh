# load your chosen environment
export $(cat "$1.env"|xargs)

set -v

bundle exec ruby migrate_redis.rb
