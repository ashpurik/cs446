class LinePet < ActiveRecord::Base
  belongs_to :pet
  belongs_to :consider
end
