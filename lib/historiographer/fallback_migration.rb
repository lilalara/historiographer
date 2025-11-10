require_relative "history_migration_fallback"

if defined?(ActiveRecord::ConnectionAdapters::Mysql2Adapter) || defined?(ActiveRecord::ConnectionAdapters::OracleEnhanced)
  class ActiveRecord::ConnectionAdapters::TableDefinition
    include Historiographer::HistoryMigrationFallback
  end
elsif defined?(ActiveRecord::ConnectionAdapters::TableDefinition)
  class ActiveRecord::ConnectionAdapters::TableDefinition
    include Historiographer::HistoryMigration
  end
end
