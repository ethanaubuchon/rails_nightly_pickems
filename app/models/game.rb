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
  belongs_to :home_team, :class_name => :Team
  belongs_to :away_team, :class_name => :Team
  has_many   :picks
  has_one    :score

  def started?
    if (0.days.ago.in_time_zone("Eastern Time (US & Canada)") > self.game_time.in_time_zone("Eastern Time (US & Canada)"))
      return true
    end
  end

  def has_team?(team)
    if team.is_a?(Team)
      team_id = team.id
    elsif team.is_a?(Integer)
      team_id = team
    else
      raise "Expected Team or Integer. Received #{team.class.name}"
    end

    return (home_team_id == team_id || away_team_id == team_id)
  end
end
