module CategoriesHelper
  def total_amount(category)
    category.payments.sum(:amount)
  end

  def check_url(url)
    default = 'category.svg'
    if (File.extname(url) =~ /^(.png|.gif|.jpg)$/) || (url =~ /^#{URI::DEFAULT_PARSER.make_regexp}$/)
      url
    else
      default
    end
  end
end
