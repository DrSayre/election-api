class UpdateMeanSampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Candidate.all.each do |candidate|
      candidate.mean_samples.create(probability: candidate.probability, sample_date: Date.today)
    end
    UpdateMeanSampleJob.set(wait: 1.day).perform_later
  end
end
