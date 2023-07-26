class MigratableKey
  def self.factory(key, type:, ttl:)
    klass =
      case type
      when "string" then MigratableKey::String
      when "set"    then MigratableKey::Set
      when "zset"   then MigratableKey::ZSet
      when "list"   then MigratableKey::List
      when "hash"   then MigratableKey::Hash
      when "none"   then MigratableKey::IgnoreKey
      else
        raise StandardError, "Unhandled type \"#{type}\""
      end

    klass.new(key, ttl:)
  end

  attr_reader :key, :ttl
  def initialize(key, ttl:)
    @key = key
    @ttl = ttl
  end

  def migrate(source:, destination:)
    raise StandardError, "Base class #migrate called"
  end

  class MigratableKey::Hash < MigratableKey
    def migrate(source:, destination:)
      destination.hset(key, source.hgetall(key))
      destination.expire(key, ttl)
    end
  end

  class MigratableKey::List < MigratableKey
    def migrate(source:, destination:)
      destination.rpush(key, source.lrange(key, 0, -1))
      destination.expire(key, ttl)
    end
  end

  class MigratableKey::Set < MigratableKey
    def migrate(source:, destination:)
      destination.sadd(key, source.smembers(key))
      destination.expire(key, ttl)
    end
  end

  class MigratableKey::String < MigratableKey
    def migrate(source:, destination:)
      destination.set(key, destination.get(key))
      destination.expire(key, ttl)
    end
  end

  class MigratableKey::ZSet < MigratableKey
    def migrate(source:, destination:)
      scores_and_keys = Array(source.zrange(key, 0, -1, with_scores: true)).map(&:reverse)
      destination.zadd(key, scores_and_keys)
      destination.expire(key, ttl)
    end
  end

  class MigratableKey::IgnoreKey < MigratableKey
    def migrate(source:, destination:)
      puts "IGNORING #{key} due to type none"
    end
  end
end
