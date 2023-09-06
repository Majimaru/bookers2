class Tag < ApplicationRecord
  
  has_many :tag_relationships, dependent: :destroy
  has_many :tagged, through: :tag_relationships, source: :book
  
end
