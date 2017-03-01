module Helpers

  def html_title(current_article, current_resource)
    if current_article
      current_article.title
    else
      data.site.name
    end
  end
end

