class Site < ActiveRecord::Base
  belongs_to :user
  has_many :products
  validates :alias, presence: true, 
                      uniqueness: true, 
                      length: {minimum: 1}
  validates :title, presence: true,
                      length: {minimum: 1}
  validates :description, presence: true  

end
