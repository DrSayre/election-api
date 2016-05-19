# app/models/candidate.rb
class Candidate < ApplicationRecord
  has_many :samples
  has_many :mean_samples

  def set_probability
    last_samples = []
    Source.all.each do |source|
      foo = source.samples.where(candidate_id: id)
      last_samples << foo.last.probability unless foo.blank?
    end
    self.probability = average_samples(last_samples)
    save
  end

  def average_samples(samples)
    return 0 if samples.empty?
    samples.inject{ |sum, el| sum + el }.to_f / samples.size
  end
end
