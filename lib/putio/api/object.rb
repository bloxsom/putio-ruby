module Putio
  module Api
    class Object
      extend Putio::Api::Client

      def self.plural_name
        singular_name.pluralize
      end

      def self.singular_name
        self.name.demodulize.underscore.downcase
      end

      def self.parse_collection(hash)
        objects = hash[plural_name.to_sym]
        objects.map do |obj|
          instantiate_object obj
        end
      end

      def self.parse_object(hash)
        object = hash[singular_name.to_sym]
        instantiate_object object
      end

      def self.instantiate_object(hash)
        obj = self.new
        hash.each do |k,v|
          obj.set_attribute(k.to_s, v)
        end
        obj
      end

      def client
        self.class.client
      end

      def set_attribute(attr, value)
        return unless attr.present?
        self.singleton_class.instance_eval { attr_reader "#{attr}".to_sym }
        self.instance_variable_set("@#{attr}", value)
      end
    end
  end
end
