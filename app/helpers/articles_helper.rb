module ArticlesHelper
  def creation_date(datetime)
    datetime.strftime('%B %e, %Y')
  end
end
