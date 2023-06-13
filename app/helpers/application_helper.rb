module ApplicationHelper
  def ingredient_color_class(expiration_date)
    return 'green2' if expiration_date > Date.today + 30
    return 'green1' if expiration_date > Date.today + 15
    return 'orange2' if expiration_date > Date.today + 7
    return 'orange1' if expiration_date > Date.today + 4
    return 'red2' if expiration_date > Date.today + 2
    return 'red1'
  end
end
