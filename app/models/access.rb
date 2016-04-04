class Access < ActiveRecord::Base
  belongs_to :user
  belongs_to :upload
  enum kind: [ :owner, :shared ]
end
