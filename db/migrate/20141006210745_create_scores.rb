class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :home
      t.integer :away

      t.timestamps
    end
  end
end
