# == Schema Information
#
# Table name: models
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  make_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Model < ActiveRecord::Base
  attr_accessible :make_id, :name
  belongs_to :make
  has_many :repairs
  validates :name, presence: true
end
