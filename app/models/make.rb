# == Schema Information
#
# Table name: makes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Make < ActiveRecord::Base
  attr_accessible :name
  has_many :models
  validates :name, presence: true
end
