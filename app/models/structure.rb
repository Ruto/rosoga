class Structure < ApplicationRecord
  has_ancestry
  belongs_to :user
  belongs_to :structurable, polymorphic: true

end
