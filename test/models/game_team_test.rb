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

require 'test_helper'

class GameTeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
