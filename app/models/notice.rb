class Notice < ApplicationRecord
  has_one_attached :image
  belongs_to :category
  belongs_to :user

  validates :title, :text, presence: true
end
