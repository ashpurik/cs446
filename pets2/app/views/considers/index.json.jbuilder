json.array!(@considers) do |consider|
  json.extract! consider, :id
  json.url consider_url(consider, format: :json)
end
