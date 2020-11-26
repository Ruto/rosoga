class Organization < ApplicationRecord

  belongs_to :user
  has_many :structures, as: :structurable
  
end
