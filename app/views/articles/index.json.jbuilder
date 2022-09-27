json.articles do
  if @articles&.empty?
    json.error("There is no article")
  else
    json.array! @articles do |article|
      json.title(article[:title])
      json.description(article[:description])
    end
  end
end