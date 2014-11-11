class User < ActiveRecord::Base
  has_many :sites, dependent: :destroy
  has_many :products, dependent: :destroy
  validates :name, presence: true, 
                      uniqueness: true, 
                      length: {minimum: 1}
                      
  validates :password, presence: true,
                      length: {minimum: 1},
                      confirmation: true
  validates :email, presence: true
end