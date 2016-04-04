class Upload < ActiveRecord::Base
  has_many :users, through: :accesses
end
