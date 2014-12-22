json.array!(@recherches) do |recherch|
  json.extract! recherch, :id
  json.url recherch_url(recherch, format: :json)
end
