class Game < ActiveRecord::Base
  belongs_to :home_team, :class_name => :user, :user_id
  belongs_to :away_team, :class_name => :user, :user_id
end
