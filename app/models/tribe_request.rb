class TribeRequest < ApplicationRecord
  belongs_to :user
  belongs_to :tribe

  def accepted
    self.status = 'accepted'
    self.save
  end

  def declined
    self.status = 'declined'
    self.save
  end
end
