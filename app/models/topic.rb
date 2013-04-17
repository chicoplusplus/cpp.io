class Topic < ActiveRecord::Base
  # Relationships
  belongs_to :user
  has_many :votes

  # Validations
  validates :name, :presence => true

  def refresh_vote_count
    self.num_votes = self.votes.sum(:value)
    self.save
  end
end
