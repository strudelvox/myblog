class CreateWebimages < ActiveRecord::Migration
  def change
    create_table :webimages do |t|
      t.references :recording, index: true
      t.references :user, index: true
      t.references :comment, index: true
      t.timestamps null: false
      t.string :wi_type
      t.string :wi_name
    end    
  end
end
