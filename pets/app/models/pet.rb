class Pet < ActiveRecord::Base
  default_scope :order => 'name'

  validates :name, :breed, :age, :habits, :presence => true
  validates :age, :numericality => {:greater_than => 0.00, :less_than => 30.00}
  validates :image_url, allow_blank: true, :format => {
    :with => %r{.(gif|jpg|png)\z}i,
    :message => 'must be a .gif, .jpg, or .png format.'
  }
end
