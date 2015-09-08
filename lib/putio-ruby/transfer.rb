module Putio
  class Transfer < Putio::Api::Object
    attribute :callback_url,         String
    attribute :created_at,           DateTime
    attribute :current_ratio,        Float
    attribute :down_speed,           Integer
    attribute :downloaded,           Integer
    attribute :error_message,        String
    attribute :estimated_time,       Integer
    attribute :extract,              Boolean
    attribute :file_id,              Integer
    attribute :finished_at,          DateTime
    attribute :id,                   Integer
    attribute :is_private,           Boolean
    attribute :name,                 String
    attribute :peers_connected,      Integer
    attribute :peers_sending_to_us,  Integer
    attribute :percent_done,         Integer
    attribute :save_parent_id,       Integer
    attribute :seconds_seeding,      Integer
    attribute :size,                 Integer
    attribute :source,               String
    attribute :status,               String
    attribute :status_message,       String
    attribute :subscription_id,      Integer
    attribute :tracker_message,      String
    attribute :type,                 String
    attribute :up_speed,             Integer
    attribute :uploaded,             Integer

    def self.list
      res = client.get("transfers/list")
      res.body.map { |t| self.new t }
    end

    def self.transfer(id)
      self.new client.get("transfers/#{id}").body
    end

    def self.add(url)
      self.new client.post("transfers/add", :url => url).body
    end

    def fetch
      self.class.transfer(id)
    end
  end
end
