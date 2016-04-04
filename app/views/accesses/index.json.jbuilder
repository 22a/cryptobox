json.array!(@accesses) do |access|
  json.extract! access, :id, :user_id, :upload_id, :type
  json.url access_url(access, format: :json)
end
