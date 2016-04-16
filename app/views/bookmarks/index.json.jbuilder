json.array!(@bookmarks) do |bookmark|
  json.extract! bookmark, :id, :url, :title, :description, :clicks
  json.url bookmark_url(bookmark, format: :json)
end
