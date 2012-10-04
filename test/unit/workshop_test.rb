# == Schema Information
#
# Table name: workshops
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  address         :string(255)
#  contact_person  :string(255)
#  contact_numbers :string(255)
#  website         :string(255)
#  opening_hours   :string(255)
#  is_premium      :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class WorkshopTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
