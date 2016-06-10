class ResultProduct < ActiveRecord::Base
  belongs_to :search
  has_many :photos
end
