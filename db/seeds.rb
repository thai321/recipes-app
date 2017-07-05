# main chef
main_chef = Chef.create(name: "thai",
                  email: "thai.nguyen@berkeley.edu",
                  password: "123456",
                  password_confirmation: "123456", admin: true)

# Create chefs and recipes
1.upto(10) do |i|
  chef = Chef.create(name: "thai#{i}",
                    email: "thai#{i}@example.com",
                    password: "123456",
                    password_confirmation: "123456")
  recipe = { name: "chiken#{i}", description: "Just eat it #{i}"}
  chef.recipes.create(recipe)
  main_chef.recipes.create(recipe)
end
