# Create 10 categories
categories = ["Food", "Travel", "Technology", "Fashion", "Sports", "Art", "Music", "Health", "Science", "Education"]

categories.each do |category_name|
  Category.create(name: category_name)
end

# Create "Others" category
Category.create(name: "Others")
# 