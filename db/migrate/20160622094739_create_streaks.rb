class CreateStreaks < ActiveRecord::Migration
  def change
    create_table :streaks do |t|
      t.boolean :completed
      t.references :obstacle, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
