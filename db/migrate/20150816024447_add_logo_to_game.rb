class AddLogoToGame < ActiveRecord::Migration
  def change
    add_column :teams, :logo, :string
  end
end
