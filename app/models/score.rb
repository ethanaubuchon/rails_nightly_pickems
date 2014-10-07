# == Schema Information
#
# Table name: scores
#
#  id         :integer          not null, primary key
#  home       :integer
#  away       :integer
#  created_at :datetime
#  updated_at :datetime
#

class Score < ActiveRecord::Base
end
