module Putio
  class Transfer < Putio::Api::Object
    def self.list
      res = client.get "transfers/list"
      parse_collection res.body if res.success?
    end

    def self.get(id)
      res = client.get "transfers/#{id}"
      parse_object res.body if res.success?
    end

    def self.add(url)
      res = client.post "transfers/add", :url => url
      parse_object res.body
    end

    def fetch
      self.class.find(id)
    end
  end
end
