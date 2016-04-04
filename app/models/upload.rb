class Upload < ActiveRecord::Base
  has_many :accesses
  has_many :users, through: :accesses
  has_attached_file :data
  validates_attachment_presence :data
  do_not_validate_attachment_file_type :data
end
