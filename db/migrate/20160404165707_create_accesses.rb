class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :upload, index: true, foreign_key: true
      t.integer :kind

      t.timestamps null: false
    end
  end
end
