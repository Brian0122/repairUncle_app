# == Schema Information
#
# Table name: repairs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  parts      :string(255)
#  terms      :string(255)
#  price      :float
#  model_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RepairTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
