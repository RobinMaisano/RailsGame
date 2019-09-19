class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.references :player1
      t.references :player2
      t.references :tournament, foreign_key: true
      t.references :game, foreign_key: true
      t.string :winner

      t.timestamps
    end
  end
end
