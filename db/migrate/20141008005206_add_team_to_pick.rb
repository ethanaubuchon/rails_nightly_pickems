class AddTeamToPick < ActiveRecord::Migration
  def change
    add_reference :picks, :team, index: true
  end
end
