class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :title
      t.string :platform
      t.string :condition
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end
