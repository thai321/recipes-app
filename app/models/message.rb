class Message < ApplicationRecord
  belongs_to :chef
  validates :content, presence: true
  validates :chef_id, presence: true

  def self.most_recent
    order(:created_at).last(20)
    # only get the last 20 messages to chatrooms
  end
end
