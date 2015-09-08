module Putio
  class File < Putio::Api::Object
    attribute :content_type,       String
    attribute :crc32,              String
    attribute :created_at,         DateTime
    attribute :first_accessed_at,  DateTime
    attribute :icon,               String
    attribute :id,                 Integer
    attribute :is_mp4_available,   Boolean
    attribute :is_shared,          Boolean
    attribute :name,               String
    attribute :opensubtitles_hash, String
    attribute :parent_id,          Integer
    attribute :screenshot,         String
    attribute :size,               Integer

    def self.list(parent_id=nil)
      res = client.get "files/list", ( parent_id ? {:parent_id => parent_id} : nil )
      res.body.map { |f| self.new f }
    end

    def self.file(id)
      self.new client.get("files/#{id}").body
    end

    def download_url
      client.get("files/#{id}/download").env.response_headers["location"]
    end

    def delete
      client.post "files/delete", :file_ids => id
      true
    end
  end
end
