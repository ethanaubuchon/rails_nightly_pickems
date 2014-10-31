# == Schema Information
#
# Table name: scores
#
#  id         :integer          not null, primary key
#  home       :integer
#  away       :integer
#  created_at :datetime
#  updated_at :datetime
#  game_id    :integer
#

class Score < ActiveRecord::Base
    belongs_to :game
end
