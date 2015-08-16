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
#  logo       :string
#

require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
