class Pet < ActiveRecord::Base
  has_many :line_pets
  STATUS_TYPES = [ "Available", "Fostered" ]

  before_destroy :ensure_not_referenced_by_any_line_pet

  validates :name, :breed, :age, :habits, :status, :presence  => true
  validates :age, :numericality => {:greater_than => 0.00, :less_than => 30.00}
  validates :image_url, allow_blank: true, :format => {
    :with => %r{.(gif|jpg|png)\z}i,
    :message => 'must be a .gif, .jpg, or .png format.'
  }
  validates :status, inclusion: STATUS_TYPES

  def self.latest
    Pet.order(:updated_at).last
  end


  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_pet
      if line_pets.empty?
        return true
      else
        errors.add(:base, 'Line Pets present')
        return false
      end
    end
end
