# app/models/sample.rb
class Sample < ApplicationRecord
  belongs_to :source
  belongs_to :candidate
  after_create :update_candidate_average

  def update_candidate_average
    candidate.set_probability
  end
end
