module ErrorIndexer
  module ErrorIndexerEngine
    module InstanceMethods
      def validate_collection_association(reflection)
        if (!reflection.options[:index_errors])
          super
        else
          if association = association_instance_get(reflection.name)
            if records = associated_records_to_validate_or_save(association, new_record?, reflection.options[:autosave])
              records.each_with_index { |record, index| association_valid?(reflection, record, index) }
            end
          end
        end
      end

      def association_valid?(reflection, record, index = nil)
        if index.nil? || (!reflection.options[:index_errors])
          super(reflection, record)
        else
          return true if record.destroyed? || record.marked_for_destruction?

          validation_context = self.validation_context unless [:create, :update].include?(self.validation_context)
          unless valid = record.valid?(validation_context)
            if reflection.options[:autosave]
              record.errors.each do |attribute, message|
                attribute = "#{reflection.name}.#{index}.#{attribute}"
                errors[attribute] << message
                errors[attribute].uniq!
              end
            else
              errors.add(reflection.name)
            end
          end
          valid
        end
      end
    end
  end
end
