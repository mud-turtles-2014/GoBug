module CategoriesHelper
  def category_image(category)
    if category == "Food"
      @image = "plate.png"
    elsif category == "Transportation"
      @image = "air.png"
    elsif category == "Housing"
      @image = "dwelling.png"
    elsif category == "Shopping"
      @image = "shopping.png"
    elsif category == "Activities"
      @image = "small.png"
    else
      @image = "tool.png"
    end
  end
end