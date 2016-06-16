class CreateObstacles < ActiveRecord::Migration
  def change
    create_table :obstacles do |t|
      t.references :wish
      t.text :obstacle_text
      t.text :plan_text

      t.timestamps null: false
    end
  end
end
