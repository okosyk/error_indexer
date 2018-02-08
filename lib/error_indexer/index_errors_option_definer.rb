module ErrorIndexer
  module IndexErrorsOptionDefiner
    def self.included(base)
      base.send(:include, InstanceMethods)
    end 

    module InstanceMethods
      def valid_options
        super + [:index_errors]
      end
    end
  end
end
