class Category < ApplicationRecord
  has_many :notices

  validates :name, presence: true
end
