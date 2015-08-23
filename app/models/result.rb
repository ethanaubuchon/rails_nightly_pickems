# == Schema Information
#
# Table name: results
#
#  id           :integer          not null, primary key
#  game_team_id :integer
#  win          :boolean
#  overtime     :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Result < ActiveRecord::Base
end
