module ApplicationHelper
  def page_title
    title = "Ariake"
    title = @page_title + " - " + title if @page_title
    title
  end
end
