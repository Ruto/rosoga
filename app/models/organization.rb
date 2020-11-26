class Organization < ApplicationRecord
  belongs_to :organizable, polymorphic: true
  belongs_to :user
end
