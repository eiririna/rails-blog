json.article do
  if @articles&.empty?
    json.error("There is no article")
  else
    json.title(@article[:title])
    json.description(@article[:description])
  end
end