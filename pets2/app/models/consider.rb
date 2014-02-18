class Consider < ActiveRecord::Base
  has_many :line_pets, dependent: :destroy
end

