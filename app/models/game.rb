# == Schema Information
#
# Table name: games
#
#  id           :integer          not null, primary key
#  game_time    :datetime
#  home_team_id :integer
#  away_team_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Game < ActiveRecord::Base
  belongs_to :home_team, :class_name => :user, :foreign_key => "user_id"
  belongs_to :away_team, :class_name => :user, :foreign_key => "user_id"
end
