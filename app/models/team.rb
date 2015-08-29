# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  city       :string
#  short      :string
#  created_at :datetime
#  updated_at :datetime
#  conference :string
#  division   :string
#  logo       :string
#

class Team < ActiveRecord::Base
  has_many :game_teams

  def fullname
    return "#{self.city} #{self.name}"
  end
end
