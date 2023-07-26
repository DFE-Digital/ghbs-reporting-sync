require_relative "migratable_key"
require_relative "migratable_redis"

class RedisMigration
  attr_reader :source, :destination
  def initialize(source:, destination:)
    @source = MigratableRedis.new(source)
    @destination = MigratableRedis.new(destination)
  end

  def perform_migration
    puts "Removing all keys on destination redis"
    destination.remove_all_keys

    puts "Beginning migration..."
    migratable_keys = source.migratable_keys
    migratable_keys.each {|key| destination.migrate_key(key, source:) }
    puts "Migrated #{migratable_keys.count} keys"
  end
end
