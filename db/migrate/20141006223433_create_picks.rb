class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.references :user, index: true
      t.references :game, index: true
      t.integer :pick

      t.timestamps
    end
  end
end
