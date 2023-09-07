class Tag < ApplicationRecord
  
  has_many :tag_relationships, dependent: :destroy
  has_many :books, through: :tag_relationships, source: :book
  
  def self.search_for(content, method)
    
    if method == 'perfect'
      tags = Tag.where(name: content)
    end
    
    return tags.inject(init = []) {|result, tag| result + tag.books}
    
  end
  
end
