class UpdateGameFields < ActiveRecord::Migration
  def change
    remove_column :games, :home_team_id
    remove_column :games, :away_team_id
  end
end
