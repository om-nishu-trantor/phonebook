json.array!(@phone_lists) do |phone_list|
  json.extract! phone_list, :id, :name, :phone
  json.url phone_list_url(phone_list, format: :json)
end
