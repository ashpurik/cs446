json.array!(@line_pets) do |line_pet|
  json.extract! line_pet, :id, :pet_id, :consider_id
  json.url line_pet_url(line_pet, format: :json)
end
