class AddDifferentialToResult < ActiveRecord::Migration
  def change
    add_column :results, :differential, :integer
  end
end
