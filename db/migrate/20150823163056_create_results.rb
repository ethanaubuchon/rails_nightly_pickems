class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :game_team
      t.boolean :win
      t.boolean :overtime

      t.timestamps null: false
    end
  end
end
