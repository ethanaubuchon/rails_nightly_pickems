# == Schema Information
#
# Table name: game_teams
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  team_id    :integer
#  home_team  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GameTeam < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  has_many   :picks
  has_one    :result
end
