xml.rss do
  xml.page_title('All articles: ')

  if @articles&.empty?
    xml.error('There is no articles')
  else
    @articles.each do |article|
      xml.article('type' => 'article') do
        xml.title(article[:title], 'type' => 'article_title')
        xml.tag!('description', article[:description])
      end
    end
  end
end