class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.references :recording, index: true
      t.timestamps null: false
      t.text :c_text
    end
  end
end
