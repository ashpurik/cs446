require 'test_helper'

class PetTest < ActiveSupport::TestCase
  fixtures :pets

  test "pet attributes should not be empty" do
    pet = Pet.new
    assert pet.invalid?
    assert pet.errors[:name].any?
    assert pet.errors[:breed].any?
    assert pet.errors[:age].any?
    assert pet.errors[:habits].any?
  end

  test "pet age must be valid" do
    pet = Pet.new(:name => "Pet Name", 
		  :breed => "A Breed",
		  :habits => "Likes to do things")
    pet.age = -2
    assert pet.invalid?
    assert_equal "must be greater than 0.0",
      pet.errors[:age].join('; ')

    pet.age = 0
    assert pet.invalid?
    assert_equal "must be greater than 0.0",
      pet.errors[:age].join('; ')

    pet.age = 40
    assert pet.invalid?
    assert_equal "must be less than 30.0",
      pet.errors[:age].join('; ')
   
    pet.age = 10
    assert pet.valid?
  end

  def new_pet(image_url)
    Pet.new(:name => "Pet Name",
    	    :breed => "A Breed",
	    :habits => "Likes to do things",
	    :age => 10.0,
	    :image_url => image_url)
  end

  test "image url" do
    good = %w{ tabby.jpg black_kitty.png calico.gif http://google.com/image.gif }
    bad = %w{ tabby.doc black_kitty.gif.stuff calico.png/url }

    good.each do |url|
      assert new_pet(url).valid?, "#{url} shouldn't be invalid"
    end

    bad.each do |url|
      assert new_pet(url).invalid?, "#{url} shouldn't be valid"
    end
  end

  test "find" do
    assert_equal "Ruby", pets(:ruby).name
  end
end
