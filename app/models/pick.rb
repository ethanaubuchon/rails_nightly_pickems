# == Schema Information
#
# Table name: picks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  game_id    :integer
#  pick       :integer
#  created_at :datetime
#  updated_at :datetime
#

class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
end
