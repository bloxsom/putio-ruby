module Putio
  module Api
    class Object
      include Virtus.model
      extend Putio::Api::Client

      def client
        self.class.client
      end
    end
  end
end
