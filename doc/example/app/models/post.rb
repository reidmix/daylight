class Post < ActiveRecord::Base
  scope :published, -> { where(published: true) }
  scope :recent,    -> { where('published_at > ?', 1.day.ago) }

  belongs_to :blog
  belongs_to :author, class_name: 'User'

  has_many :comments
  has_many :commenters, -> { uniq }, through: :comments, class_name: 'User'
  has_many :suppressed_comments, -> { where(spam: true) }, class_name: 'Comment'

  has_one :company, through: :blog

  accepts_nested_attributes_for :comments

  before_create do
    self.slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def published?
    published_at.present?
  end

  def top_comments
    comments.order_by(:like_count)
  end
end
