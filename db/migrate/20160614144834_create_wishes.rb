class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.text :wish_text
      t.text :outcome_text
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :wishes, :user_id
  end
end
