# app/models/source.rb
class Source < ApplicationRecord
	has_many :samples
end
