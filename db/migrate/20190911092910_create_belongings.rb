class CreateBelongings < ActiveRecord::Migration[5.2]
  def change
    create_table :belongings do |t|
      t.references :game, foreign_key: true
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
