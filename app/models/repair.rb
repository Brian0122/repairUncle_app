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

class Repair < ActiveRecord::Base
  attr_accessible :model_id, :name, :parts, :price, :terms
  attr_accessor :modelName
  has_many :repair_workshops
  has_many :workshops, :through => :repair_workshops
  belongs_to :model
  validates :name, presence: true
  ## for sunspot search engine
  #searchable do
  #  text :name
  #  integer :model_id
  #end

  public
  def modelName=(value)
    @modelName = value
  end
 
  def modelName
    @modelName
  end
  
end
