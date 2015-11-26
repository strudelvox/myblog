class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.references :user, index: true
      t.timestamps null: false
      t.string :rec_header
      t.text :rec_teaser, :rec_text
      t.integer :rec_approved, index: true, null: false, default: 0
      t.integer :rec_hits, index: true, null: false, default: 0
    end
    add_index :recordings, :created_at
  end
end
