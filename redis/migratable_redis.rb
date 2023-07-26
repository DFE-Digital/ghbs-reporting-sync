class MigratableRedis < SimpleDelegator
  def migratable_keys
    @migratable_keys ||= keys("*").map do |key|
      MigratableKey.factory(key, ttl: ttl(key), type: type(key))
    end
  end

  def migrate_key(migratable_key, source:)
    migratable_key.migrate(source:, destination: self)
  end

  def remove_all_keys
    keys("*").each do |key|
      del(key)
    end
  end

  def expire(key, ttl)
    super unless ttl < 0
  end
end
