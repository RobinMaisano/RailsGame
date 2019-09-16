class CreateParticipatings < ActiveRecord::Migration[5.2]
  def change
    create_table :participatings do |t|
      t.references :user, foreign_key: true
      t.references :tournament, foreign_key: true
    end

    # New column in order to limit the number of participants
    add_column :tournaments, :max_players, :integer

  end
end
