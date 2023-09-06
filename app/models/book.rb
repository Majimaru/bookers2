class Book < ApplicationRecord
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  has_many :tag_relationships, dependent: :destroy
  has_many :tags, through: :tag_relationships, source: :tag
  
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
  
  validates :star, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5
  }, presence: true
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%' + content)
    else
      Book.where('title LIKE ?', '%' + content + '%')
    end
  end
  
  def save_tags(tags)
    tags.each do |tag|
      # tag_relationshipsがthroughしているのでtagsでアソシエーションを指定すると中間テーブルを通過した際に保存される
      # find_or_create_by : Tagテーブルにnameカラムがブロック変数tagの値が無ければレコードを作成
      self.tags.find_or_create_by(name: tag)
    end
  end
  
end
