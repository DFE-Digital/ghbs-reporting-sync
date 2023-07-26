require "redis"
require_relative "redis_migration"

source = Redis.new(url: ENV["SOURCE_REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })
destination = Redis.new(url: ENV["DESTINATION_REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })

redis_migration = RedisMigration.new(source:, destination:)
redis_migration.perform_migration
