class Article < ApplicationRecord
  belongs_to :event
  has_one_attached :picture
end
