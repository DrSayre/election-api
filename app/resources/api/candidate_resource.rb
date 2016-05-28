module Api
  # app/resources/api/candidate_resource.rb
  class CandidateResource < JSONAPI::Resource
    has_many :mean_samples
    attributes :name, :probability, :magic_8_ball
  end
end
