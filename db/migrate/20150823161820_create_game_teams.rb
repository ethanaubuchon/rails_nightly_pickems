class CreateGameTeams < ActiveRecord::Migration
  def change
    create_table :game_teams do |t|
      t.integer :game_id
      t.integer :team_id
      t.boolean :home_team

      t.timestamps null: false
    end
  end
end
