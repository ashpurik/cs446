Pet.delete_all

Pet.create(:name => 'Vasya',
  :breed => 'Calico',
  :image_url => '/images/calico_kitten.jpg',
  :age => 0.25,
  :habits => 'enjoys playing with yarn, loves cuddling, shy around strangers, likes to sleep with owners, will only eat when other people are eating',
  :status => 'Available')

Pet.create(:name => 'Moosya', 
  :breed => 'Orange Tabby',
  :image_url => '/images/orange_tabby.jpg',
  :age => 0.33,
  :habits => 'hates the smell of vanilla, enjoys playing in the yard, is terrified of dogs, adores tuna',
  :status => 'Available')

Pet.create(:name => 'Sasha',
  :breed => 'German Shepherd',
  :image_url => '/images/german_shepherd.jpg',
  :age => 0.40,
  :habits => 'loves chasing mice, enjoys swimming, prefers to eat food off of human plates, does not like to be left alone for long',
  :status => 'Available')
