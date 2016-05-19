module Api
  # app/resources/mean_sample_resource.rb
  class MeanSampleResource < JSONAPI::Resource
    attributes :sample_date, :probability
  end
end
