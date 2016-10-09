class Course < ActiveRecord::Base
  validates :name, presence: true, length: { minimum:3 }
  belongs_to :instructor
  has_many :modulos
  has_and_belongs_to_many :categories
  has_many :registries
  has_many :users, through: :registries

end
