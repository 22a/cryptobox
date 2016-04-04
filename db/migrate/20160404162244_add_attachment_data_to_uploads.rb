class AddAttachmentDataToUploads < ActiveRecord::Migration
  def self.up
    change_table :uploads do |t|
      t.attachment :data
    end
  end

  def self.down
    remove_attachment :uploads, :data
  end
end
