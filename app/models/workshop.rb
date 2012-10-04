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

class Workshop < ActiveRecord::Base
  attr_accessible :id, :address, :contact_numbers, :contact_person, :is_premium, :name, :opening_hours, :website 
  has_many :repair_workshops
  has_many :repairs, :through => :repair_workshops
  validates :name, :presence => true
  validates :address, :presence => true
end
