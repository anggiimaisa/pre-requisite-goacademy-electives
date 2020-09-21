class Product
	attr_accessor :name, :price, :tags

	def initialize(name, price, tags)
		@name = name
		@price = price
		@tags = tags
	end

	def filtering_flavor(products, type, filter) 
		filtered_products = []
		last_idx = 0
		drink = 2
		food = 3

		if type == "food"
			last_idx = food
		else
			last_idx = drink
		end

		products.each {
			|product|

			if product.tags[0..(product.tags.size-last_idx)].include? filter
				filtered_products.push(product)
			end
		}

		filtered_products
	end

	def filtering_healthy_product(products, filter)
		filtered_products = []

		products.each {
			|product|
			if product.tags[tags.size-2].include? filter
				filtered_products.push(product)
			end
		}

		filtered_products
	end

	def filtering_originality(products, filter)
		filtered_products = []

		products.each {
			|product|
			if product.tags[tags.size-1].include? filter
				filtered_products.push(product)
			end
		}

		filtered_products
	end

	def filtering_price_range(products, min, max)
		filtered_products = []

		products.each {
			|product|
			if product.price >= min and product.price <= max
				filtered_products.push(product)
			end
		}

		filtered_products
	end
end

class Food < Product
	attr_accessor :type

	def initialize(name = "", price = 0, type = "", tags = [])
		super(name, price, tags)
		@type = type
	end

	def get
		puts "#{@name} Rp#{@price} #{@type} tags: #{@tags.join(", ")}"
	end

	def filtering_vegan(products, filter)
		filtered_products = []

		products.each {
			|product|
			if product.type.include? filter
				filtered_products.push(product)
			end
		}

		filtered_products
	end

end

class Drink < Product
	attr_accessor :size, :temp, :type

	def initialize(name = "", price = 0, size = "", temp = "", type = "", tags = [])
		super(name, price, tags)
		@size = size
		@temp = temp
		@type = type
	end

	def get
		# without using coma like Food because the example say so
		# but if you want to use coma for each tags you can un-comment loc number 90 and comment loc number 91
		# puts "#{@name} Rp#{@price} size: #{@size} #{@temp} #{@type} tags: #{@tags.join(", ")}"
		puts "#{@name} Rp#{@price} size: #{@size} #{@temp} #{@type} tags: #{@tags.join(" ")}"
	end

	def filtering_size(products, filter)
		filtered_products = []

		products.each {
			|product|
			if product.size.include? filter
				filtered_products.push(product)
			end
		}

		filtered_products
	end

	def filtering_temperature(products, filter)
		filtered_products = []

		products.each {
			|product|
			if product.temp.include? filter
				filtered_products.push(product)
			end
		}

		filtered_products
	end

	def filtering_caffeine_product(products, filter)
		filtered_products = []

		products.each {
			|product|
			if product.type.include? filter
				filtered_products.push(product)
			end
		}

		filtered_products
	end

end

def new_line
	25.times{ puts "" }
end

def insert(n)

	new_products = $products

	n.to_i.times do
		new_line()
		puts "What is the menu that you wanna add?"
		command = gets.chomp.split(" ")
		case command[0]
		when "add_food"
			food = Food.new(command[1], command[2], command[3], command[4..(command.size-1)])
			new_products.push(food)
			puts "#{command[1]} added"
		when "add_drink"
			drink = Drink.new(command[1], command[2], command[3], command[4], command[5], command[6..(command.size-1)])
			new_products.push(drink)
			puts "#{command[1]} added"
		else
		end	
				
	end

	print "created #{n} menu\nClick enter to back to main menu" 
	gets

	new_products
end

def get_products_per_type(type) 

		products_per_type = []
		
		$products.each {
			|product|
			if type == "drink" and product.is_a? Drink
				products_per_type.push(product)
			elsif type == "food" and product.is_a? Food
				products_per_type.push(product)
			end
		}
		

	products_per_type
end

def food_recommendation(products)
	food = Food.new
	tag = ""
	budget = ""
	is_vegan = ""
	is_healthy = ""
	originality = ""
	filtered_products = products

	loop do
		print "What flavour do you prefer (sweet, salty, sour, bitter, spicy, umami)? "
		tag = gets.chomp

		if tag == "sweet" or tag == "salty" or tag == "sour" or tag == "bitter" or tag == "spicy" or tag == "umami"
			filtered_products = food.filtering_flavor(filtered_products, "food", tag)
			break
		else
			puts "Oops! Please choose one of the flavour"
		end
	end

	loop do
		print "How many budgets do you have per person (range, min_budget-max_budget)? "
		budget = gets.chomp.split("-")
		if budget.size < 2
			puts "Oops! Please input with the right format"
		elsif budget[1].to_i < budget[0].to_i
			puts "Oops! Your maximum budget should be higher than your minimum budget"
		else
			filtered_products = food.filtering_price_range(filtered_products, budget[0], budget[1])
			break
		end
	end

	loop do
		print "Are your vegan (no/yes)? "
		is_vegan = gets.chomp
		if is_vegan == "no" 
			is_vegan = "non-vegan"
			filtered_products = food.filtering_vegan(filtered_products, is_vegan)
			break
		elsif is_vegan == "yes"
			is_vegan = "vegan"
			filtered_products = food.filtering_vegan(filtered_products, is_vegan)
			break
		else
			puts "Oops! Please input either \"no\" or \"yes\""
		end
	end

	loop do
		print "Do you prefer healthy food or junk food (healthy/junk_food)? "
		is_healthy = gets.chomp

		if is_healthy == "healthy" or is_healthy == "junk_food"
			filtered_products = food.filtering_healthy_product(filtered_products, is_healthy)
			break
		else
			puts "Oops! Please choose either the food is healthy or junk_food"
		end
	end

	loop do
		print "originality (italy, japan, indonesia, china)? "
		originality = gets.chomp

		if originality == "any"
			originality = ""
			break
		elsif originality == "italy" or originality == "japan" or originality == "indonesia" or originality == "china"
			filtered_products = food.filtering_originality(filtered_products, originality)
			break
		else
			puts "Oops! Please choose one of the originality or you can choose \"any\""
		end
	end

	puts "Recommendations for you:"
	if filtered_products.size != 0	
		filtered_products.each{
			|food|
			puts "- #{food.name}"
		}
	else
		puts "Sorry! No recommendation suits your taste :("
	end
	puts "Click enter to go back to main menu"
	gets
end

def drink_recommendation(products)
	drink = Drink.new
	tag = ""
	budget = ""
	size = ""
	temp = ""
	caffein = ""
	originality = ""
	filtered_products = products

	loop do
		print "What flavour do you prefer (sweet, salty, sour, bitter, spicy, umami)? "
		tag = gets.chomp

		if tag == "sweet" or tag == "salty" or tag == "sour" or tag == "bitter" or tag == "spicy" or tag == "umami"
			filtered_products = drink.filtering_flavor(filtered_products, "drink", tag)
			break
		else
			puts "Oops! Please choose one of the flavour"
		end
	end

	loop do
		print "How many budgets do you have per person (range, min_budget-max_budget)? "
		budget = gets.chomp.split("-")
		if budget.size < 2
			puts "Oops! Please input with the right format"
		elsif budget[1].to_i < budget[0].to_i
			puts "Oops! Your maximum budget should be higher than your minimum budget"
		else
			filtered_products = drink.filtering_price_range(filtered_products, budget[0], budget[1])
			break
		end
	end

	loop do
		print "Which size do you want (S/M/L)? "
		size = gets.chomp
		if size == "S" or size == "M" or size == "L"
			filtered_products = drink.filtering_size(filtered_products, size)
			break
		else
			puts "Oops! Please input with one of the size"
		end
	end

	loop do
		print "Which temperature do you want (hot/cold)? "
		temp = gets.chomp

		if temp == "hot" or temp == "cold"
			filtered_products = drink.filtering_temperature(filtered_products, temp)
			break
		else
			puts "Oops! Please choose either the drink temperature is hot or cold"
		end
	end

	loop do
		print "Do you want caffein (yes/no)? "
		caffein = gets.chomp

		if caffein == "no"
			caffein = "non-caffein"
			filtered_products = drink.filtering_caffeine_product(filtered_products, caffein)
			break
		elsif caffein == "yes"
			caffein = "caffein"
			filtered_products = drink.filtering_caffeine_product(filtered_products, caffein)
			break
		else
			puts "Oops! Please choose either the drink contains caffein or not"
		end
	end

	loop do
		print "originality (italy, japan, indonesia, china)? "
		originality = gets.chomp

		if originality == "any"
			originality = ""
			break
		elsif originality == "italy" or originality == "japan" or originality == "indonesia" or originality == "china"
			filtered_products = drink.filtering_originality(filtered_products, originality)
			break
		else
			puts "Oops! Please choose one of the originality or you can choose \"any\""
		end
	end

	puts "Recommendations for you:"
	if filtered_products.size != 0	
		filtered_products.each{
			|drink|
			puts "- #{drink.name}"
		}
	else
		puts "Sorry! No recommendation suits your taste :("
	end
	puts "Click enter to go back to main menu"
	gets
end

def get_recommendation
	loop do
		new_line()
		print "Do you want to drink/eat?"
		menu = gets.chomp
		case menu
		when "drink"
			drink_recommendation(get_products_per_type("drink"))
			break
		when "eat"
			food_recommendation(get_products_per_type("food"))
			break
		end
	end
end

$products = []

loop do
	new_line()
	puts "Input your command down here: "
	command = gets.chomp.split(" ")
	case command[0]
	when "create_menu"
		$products = insert(command[1])
	when "list_menu"
		new_line()	
		if $products.size == 0
			print "Sorry! There is no menu that we can show you yet" 
		else
			puts "MENU\n========="
			$products.each {
				|product|
				product.get
			}
		end
		puts "\nClick enter to back to main menu"
		gets
	when "give_recommendations"
		get_recommendation()
	when "exit"
		break
	else
		print "Oops! you input the wrong command, click \"enter\" button to re-input" 
		gets
	end
end


# insert(3)
# a = get_products_per_type("drink")
# puts a

# a = [1,2,3,4,5,6,7]
# puts a[0..a.size-3]

# add_drink coffeee 1000 M cold cafeine sweet bitter italy
# add_food mie 10000 vegan salty sour healthy indonesia
# add_food bihun 22000 vegan salty sour healthy japan
# add_food bakmie 15000 non-vegan sweet sour healthy china
# add_food nasgor 20000 vegan salty sour healthy indonesia
# add_food pizza 180000 non-vegan salty sour junk_food italy