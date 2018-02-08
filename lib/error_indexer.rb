require "active_record"
require "error_indexer/version"
require "error_indexer/index_errors_option_definer"
require "error_indexer/error_indexer_engine"

unless ActiveRecord::Associations::Builder::HasMany.included_modules.include? ErrorIndexer::IndexErrorsOptionDefiner
  ActiveRecord::Associations::Builder::HasMany.send(:include, ErrorIndexer::IndexErrorsOptionDefiner)
end

ActiveSupport.on_load :active_record do
  include ErrorIndexer::ErrorIndexerEngine::InstanceMethods
end
