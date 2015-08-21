module Putio
  class File < Putio::Api::Object
    def self.list(parent_id=nil)
      res = client.get "files/list", ( parent_id ? {:parent_id => parent_id} : nil )
      parse_collection res.body if res.success?
    end

    def self.get(id)
      res = client.get "files/#{id}"
      parse_object res.body if res.success?
    end

    def download_url
      res = client.get "files/#{id}/download"
      res.headers[:location] if res.success?
    end

    def delete
      client.post "files/delete", :file_ids => id
    end
  end
end
