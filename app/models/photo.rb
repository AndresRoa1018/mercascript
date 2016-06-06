class Photo < ActiveRecord::Base
  belongs_to :searches 
  belongs_to :result_products
end
