class ChangeGameTeamsIdToGameTeamId < ActiveRecord::Migration
  def change
    remove_column :picks, :game_teams_id
    add_column    :picks, :game_team_id, :integer, index: true
  end
end
