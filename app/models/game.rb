# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  game_time  :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Game < ActiveRecord::Base
  has_many :game_teams
  has_many :picks
  has_one  :score

  def home_team
    return self.home_game_team.team
  end

  def home_game_team
    return game_teams.order("home_team DESC").take
  end

  def away_team
    return self.away_game_team.team
  end

  def away_game_team
    return game_teams.order("home_team ASC").take
  end

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

  def get_user_pick(user)
    if user.is_a?(User)
      user_id = user.id
    elsif user.is_a?(Integer)
      user_id = user
    else
      raise "Expected User or Integer. Received #{user.class.name}"
    end

    return Pick.where(user_id: user_id, game_team_id: self.game_teams).first
  end

  def fullname
    return "#{self.away_team.fullname.titleize} @ #{self.home_team.fullname.titleize}"
  end

  def city_name
    return "#{self.away_team.city.titleize} @ #{self.home_team.city.titleize}"
  end

  def name
    return "#{self.away_team.name.titleize} @ #{self.home_team.name.titleize}"
  end

  def short_name
    return "#{self.away_team.short.upcase} @ #{self.home_team.short.upcase}"
  end
end
