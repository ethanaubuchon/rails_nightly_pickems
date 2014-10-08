# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  city       :string(255)
#  short      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  conference :string(255)
#  division   :string(255)
#

class Team < ActiveRecord::Base
  has_many :games
  has_many :picks
end
