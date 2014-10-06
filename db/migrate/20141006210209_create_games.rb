class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :game_time
      t.references :home_team, index: true
      t.references :away_team, index: true

      t.timestamps
    end
  end
end
