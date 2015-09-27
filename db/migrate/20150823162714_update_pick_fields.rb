class UpdatePickFields < ActiveRecord::Migration
  def change
#    remove_column :picks, :game
#    remove_column :picks, :team
    add_reference :picks, :game_teams, index: true
  end
end
