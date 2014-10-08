class DropPickFromPicks < ActiveRecord::Migration
  def change
    remove_column :picks, :pick
  end
end
