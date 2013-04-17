class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  after_create :update_topic
  after_update :update_topic
  after_destroy :update_topic

  def update_topic
    self.topic.refresh_vote_count
  end
end
