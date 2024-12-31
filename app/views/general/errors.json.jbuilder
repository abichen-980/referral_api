json.errors do
  json.array!(@resource.errors) do |error|
    json.field error.attribute
    json.message error.message
  end
end
