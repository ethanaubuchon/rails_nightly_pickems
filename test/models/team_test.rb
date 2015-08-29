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

require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
