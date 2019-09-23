class AddAddressToTournament < ActiveRecord::Migration[5.2]
  def change

    add_column :tournaments, :address, :string
    add_column :tournaments, :city, :string
    add_column :tournaments, :country, :string

  end
end
