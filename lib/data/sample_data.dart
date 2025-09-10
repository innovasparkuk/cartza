// lib/data/sample_data.dart

const List<Map<String, dynamic>> categories = [
  // 1. Beauty & Cosmetics
  {
    "name": "Beauty & Cosmetics",
    "image": "assets/images/category_1.png",
    "subcategories": [
      {
        "name": "Skin Care",
        "image": "assets/images/subcategory_1_1.png",
        "tags": ["Popular", "Budget Picks"],

        "price": 25,
        "stock": 50,
        "description": "Skin care products enriched with natural oils and vitamins for glowing, healthy skin.",
        "related": ["Nail Polish","Lipsticks","Foundation","Handmade Jewelry"]
      },
      {
        "name": "Makeup",
        "image": "assets/images/subcategory_1_2.png",
        "price": 30,
        "stock": 40,
        "description": "High-quality makeup essentials including foundation, blush, and more for every occasion.",
        "related": ["Lipsticks","Eye Liner","Foundation","Tattoo Kits"]
      },
      {
        "name": "Perfume",
        "image": "assets/images/subcategory_1_3.png",
        "price": 50,
        "stock": 30,
        "description": "Fragrances with long-lasting freshness crafted from premium ingredients.",
        "related": ["Lip Gloss","Moisturizer Cream","Face Masks","Henna Cones"]
      },
      {
        "name": "Hair Care",
        "image": "assets/images/subcategory_1_4.png",
        "price": 20,
        "stock": 60,
        "description": "Shampoos, conditioners, and serums enriched with natural oils for strong and shiny hair.",
        "related": ["Skin Care","Face Masks","Hair Oil","Clay Pots"]
      },
      {
        "name": "Lipsticks",
        "image": "assets/images/subcategory_1_5.png",
        "price": 15,
        "stock": 70,
        "description": "Matte and glossy lipsticks available in vibrant shades to suit all skin tones.",
        "related": ["Makeup","Eye Liner","Lip Gloss","Handmade Jewelry"]
      },
      {
        "name": "Nail Polish",
        "image": "assets/images/subcategory_1_6.png",
        "price": 10,
        "stock": 100,
        "description": "Quick-dry nail polish in multiple trendy colors with long-lasting shine.",
        "related": ["Lipsticks","Beauty Tools","Foundation","Tattoo Ink"]
      },
      {
        "name": "Face Masks",
        "image": "assets/images/subcategory_1_7.png",
        "price": 12,
        "stock": 80,
        "description": "Hydrating and detoxifying face masks to rejuvenate and refresh your skin.",
        "related": ["Skin Care","Hair Care","Moisturizer Cream","Handmade Soaps"]
      },
      {
        "name": "Foundation",
        "image": "assets/images/subcategory_1_8.png",
        "price": 35,
        "stock": 40,
        "description": "Lightweight foundation with full coverage for a flawless natural finish.",
        "related": ["Makeup","Eye Liner","Lipsticks","Tattoo Cones"]
      },
      {
        "name": "Eye Liner",
        "image": "assets/images/subcategory_1_9.png",
        "price": 18,
        "tags": ["Popular", "Budget Picks", "Gift Ideas"],

        "stock": 90,
        "description": "Smudge-proof eyeliner for precise application and long-lasting wear.",
        "related": ["Makeup","Foundation","Lip Gloss","Henna Powder"]
      },
      {
        "name": "Beauty Tools",
        "image": "assets/images/subcategory_1_10.png",
        "price": 22,
        "stock": 60,
        "description": "Essential beauty tools including brushes, sponges, and applicators.",
        "related": ["Makeup","Lipsticks","Face Masks","Handmade Bags"]
      }
    ]
  },

  // 2. Handmade Products
  {
    "name": "Handmade Products",
    "image": "assets/images/category_2.png",
    "subcategories": [
      {
        "name": "Handmade Jewelry",
        "image": "assets/images/subcategory_2_1.png",
        "price": 45,
        "stock": 20,
        "description": "Unique handmade jewelry crafted with care and creativity.",
        "related": ["Clay Pots","Handwoven Baskets","Handmade Bags","Perfume"]
      },
      {
        "name": "Clay Pots",
        "image": "assets/images/subcategory_2_2.png",
        "tags": [ "Gift Ideas"],

        "price": 15,
        "stock": 50,
        "description": "Durable and stylish clay pots for home decoration and gardening.",
        "related": ["Handmade Soaps","Handwoven Baskets","Handmade Jewelry","Skin Care"]
      },
      {
        "name": "Handwoven Baskets",
        "image": "assets/images/subcategory_2_3.png",
        "price": 30,
        "stock": 25,
        "description": "Beautifully handwoven baskets for storage and decor.",
        "related": ["Clay Pots","Handmade Jewelry","Handmade Bags","Face Masks"]
      },
      {
        "name": "Handmade Soaps",
        "image": "assets/images/subcategory_2_4.png",
        "price": 12,
        "stock": 60,
        "description": "Natural handmade soaps for gentle cleansing and moisturizing.",
        "related": ["Handmade Jewelry","Clay Pots","Lipsticks","Tattoo Kits"]
      },
      {
        "name": "Hand-Painted Cups",
        "image": "assets/images/subcategory_2_5.png",
        "price": 25,
        "stock": 40,
        "description": "Artistic hand-painted cups to add charm to your kitchen.",
        "related": ["Decor Items","Handmade Jewelry","Skin Care","Face Masks"]
      },
      {
        "name": "Decor Items",
        "image": "assets/images/subcategory_2_6.png",
        "price": 35,
        "stock": 30,
        "description": "Decorative handmade items for home and office.",
        "related": ["Handmade Jewelry","Handwoven Baskets","Foundation","Lip Gloss"]
      },
      {
        "name": "Handmade Bags",
        "image": "assets/images/subcategory_2_7.png",
        "price": 55,
        "stock": 15,
        "description": "Handmade bags crafted with high-quality materials and attention to detail.",
        "related": ["Handmade Jewelry","Clay Pots","Face Masks","Tattoo Ink"]
      },
      {
        "name": "Wood Crafts",
        "image": "assets/images/subcategory_2_8.png",
        "price": 50,
        "stock": 10,
        "description": "Handcrafted wood items for home decoration.",
        "related": ["Handmade Bags","Hand-Painted Cups","Lipsticks","Henna Powder"]
      },
      {
        "name": "Custom Gifts",
        "image": "assets/images/subcategory_2_9.png",
        "price": 40,
        "stock": 35,
        "description": "Customized handmade gifts for special occasions.",
        "related": ["Handmade Bags","Decor Items","Face Masks","Tattoo Kits"]
      },
      {
        "name": "Handmade Shoes",
        "image": "assets/images/subcategory_2_10.png",
        "price": 70,
        "stock": 12,
        "description": "Stylish handmade shoes for casual and formal wear.",
        "related": ["Handmade Bags","Clay Pots","Foundation","Henna Powder"]
      }
    ]
  },

  // 3. Mehndi & Tattooing
  {
    "name": "Mehndi & Tattooing",
    "image": "assets/images/category_3.png",
    "tags": ["Popular", "New Arrivals",  "Budget Picks",  "Flash Deals", "Gift Ideas"],


    "subcategories": [
      {
        "name": "Mehndi Cones",
        "image": "assets/images/subcategory_3_1.png",
        "price": 5,
        "stock": 200,
        "description": "Natural henna cones for intricate mehndi designs.",
        "related": ["Henna Powder","Tattoo Ink","Tattoo Kits","Lipsticks"]
      },
      {
        "name": "Henna Powder",
        "image": "assets/images/subcategory_3_2.png",
        "price": 8,
        "stock": 150,
        "description": "Fine henna powder for rich color and long-lasting mehndi.",
        "related": ["Mehndi Cones","Tattoo Ink","Tattoo Kits","Face Masks"]
      },
      {
        "name": "Tattoo Ink",
        "image": "assets/images/subcategory_3_3.png",
        "tags": [ "Budget Picks", "Gift Ideas"],

        "price": 20,
        "stock": 80,
        "description": "Premium tattoo inks for professional-quality designs.",
        "related": ["Tattoo Kits","Henna Powder","Face Masks","Foundation"]
      },
      {
        "name": "Tattoo Kits",
        "image": "assets/images/subcategory_3_4.png",
        "price": 100,
        "tags": [ "New Arrivals",  "Budget Picks",  "Flash Deals", "Gift Ideas"],

        "stock": 20,
        "description": "Complete tattoo kits including ink, needles, and accessories.",
        "related": ["Tattoo Ink","Henna Powder","Face Masks","Handmade Bags"]
      },
      {
        "name": "Henna Oil",
        "image": "assets/images/subcategory_3_5.png",
        "price": 12,
        "stock": 90,
        "description": "Essential henna oil for hair and skin care.",
        "related": ["Mehndi Cones","Henna Powder","Tattoo Kits","Lip Gloss"]
      },
      {
        "name": "Tattoo Stencils",
        "image": "assets/images/subcategory_3_6.png",
        "price": 15,
        "stock": 60,
        "description": "Tattoo stencils for precise designs.",
        "related": ["Tattoo Ink","Tattoo Kits","Foundation","Handmade Jewelry"]
      },
      {
        "name": "Body Paints",
        "image": "assets/images/subcategory_3_7.png",
        "price": 25,
        "stock": 40,
        "description": "Non-toxic body paints for temporary tattoos and designs.",
        "related": ["Tattoo Ink","Tattoo Kits","Handmade Soaps","Lipsticks"]
      },
      {
        "name": "Tattoo Needles",
        "image": "assets/images/subcategory_3_8.png",
        "tags": ["Popular", "New Arrivals",  "Budget Picks",  "Flash Deals", "Gift Ideas"],

        "price": 30,
        "stock": 50,
        "description": "High-quality needles for professional tattoo application.",
        "related": ["Tattoo Kits","Tattoo Ink","Henna Powder","Handmade Bags"]
      },
      {
        "name": "Temporary Tattoos",
        "image": "assets/images/subcategory_3_9.png",
        "price": 10,
        "stock": 120,
        "description": "Fun temporary tattoos suitable for kids and adults.",
        "related": ["Body Paints","Tattoo Ink","Face Masks","Lipsticks"]
      },
      {
        "name": "Tattoo Machines",
        "image": "assets/images/subcategory_3_10.png",
        "price": 150,
        "stock": 10,
        "description": "Professional tattoo machines for precise application.",
        "related": ["Tattoo Kits","Tattoo Ink","Tattoo Needles","Henna Powder"]
      }
    ]
  },
  // 4. Kids
  {
    "name": "Kids",
    "image": "assets/images/category_4.png",

    "subcategories": [
      {"name": "Toys", "image": "assets/images/subcategory_4_1.png", "price": 15, "stock": 120, "description": "Fun and safe toys for kids of all ages.", "related": ["Kids Clothing", "Books", "Handmade Toys", "Lip Gloss"]},
      {"name": "Kids Clothing", "image": "assets/images/subcategory_4_2.png", "price": 25, "stock": 80, "description": "Comfortable and stylish clothing for children of all ages.", "related": ["Toys", "Books", "Handmade Shoes", "Foundation"]},
      {"name": "Baby Care", "image": "assets/images/subcategory_4_3.png", "price": 20, "stock": 60, "description": "Baby care essentials including lotions, shampoos, and wipes.", "related": ["Kids Clothing", "Toys", "Skin Care", "Lipsticks"]},
      {"name": "School Supplies", "image": "assets/images/subcategory_4_4.png", "price": 10, "stock": 100, "description": "Notebooks, pens, backpacks, and other school essentials.", "related": ["Books", "Toys", "Handmade Bags", "Face Masks"]},
      {"name": "Kids Shoes", "image": "assets/images/subcategory_4_5.png", "price": 30, "stock": 70, "description": "Comfortable and durable shoes for kids.", "related": ["Kids Clothing", "Toys", "Handmade Shoes", "Foundation"]},
      {"name": "Educational Games", "image": "assets/images/subcategory_4_6.png", "price": 18, "stock": 90, "description": "Fun educational games to enhance learning and creativity.", "related": ["Toys", "Books", "Handmade Toys", "Moisturizer Cream"]},
      {"name": "Art & Craft", "image": "assets/images/subcategory_4_7.png", "price": 22, "stock": 80, "description": "Craft kits and art supplies to boost creativity.", "related": ["Educational Games", "Toys", "Handmade Soaps", "Lip Gloss"]},
      {"name": "Kids Furniture", "image": "assets/images/subcategory_4_8.png", "price": 100, "stock": 20, "description": "Ergonomic and colorful furniture for kids' rooms.", "related": ["Toys", "Kids Clothing", "Decor Items", "Face Masks"]},
      {"name": "Baby Feeding", "image": "assets/images/subcategory_4_9.png", "price": 25, "stock": 50, "description": "High-quality bottles, sippy cups, and feeding accessories.", "related": ["Baby Care", "Kids Clothing", "Foundation", "Lipsticks"]},
      {"name": "Outdoor Play", "image": "assets/images/subcategory_4_10.png", "price": 35, "stock": 40, "description": "Slides, swings, and outdoor toys for fun playtime.", "related": ["Toys", "Kids Clothing", "Handmade Shoes", "Tattoo Ink"]}
    ]
  },

// 5. Electronics
  {
    "name": "Electronics",
    "image": "assets/images/category_5.png",
    "tags": ["Popular",  "Gift Ideas"],

    "subcategories": [
      {"name": "Smartphones",
        "tags": ["Popular", "New Arrivals",  "Budget Picks",  "Flash Deals", "Gift Ideas"],
        "image": "assets/images/subcategory_5_1.png", "price": 300, "stock": 50, "description": "Latest smartphones with advanced features.", "related": ["Laptops", "Headphones", "Smart Watches", "Tablet"]},

      {"name": "Laptops", "image": "assets/images/subcategory_5_2.png", "price": 800, "stock": 30, "description": "High-performance laptops for work and gaming.", "related": ["Smartphones", "Tablet", "Headphones", "Camera"]},
      {"name": "Headphones", "image": "assets/images/subcategory_5_3.png", "price": 50, "stock": 70, "description": "Noise-cancelling and wireless headphones.", "related": ["Smartphones", "Laptops", "Speakers", "Smart Watches"]},
      {"name": "Smart Watches", "image": "assets/images/subcategory_5_4.png", "price": 150, "stock": 40, "description": "Feature-packed smart watches for fitness and notifications.", "related": ["Smartphones", "Headphones", "Laptops", "Tablet"]},
      {"name": "Tablets", "image": "assets/images/subcategory_5_5.png", "price": 200, "stock": 60, "description": "Portable and powerful tablets for work and play.", "related": ["Laptops", "Smartphones", "Smart Watches", "Speakers"]},
      {"name": "Cameras", "image": "assets/images/subcategory_5_6.png", "price": 400, "stock": 25, "description": "High-resolution cameras for photography enthusiasts.", "related": ["Tripods", "Lenses", "Smartphones", "Headphones"]},
      {"name": "Speakers", "image": "assets/images/subcategory_5_7.png", "price": 60, "stock": 80, "description": "Portable and home speakers for high-quality sound.", "related": ["Headphones", "Smartphones", "Smart Watches", "Tablet"]},
      {"name": "Gaming Consoles", "image": "assets/images/subcategory_5_8.png", "price": 350, "stock": 30, "description": "Latest gaming consoles for immersive gameplay.", "related": ["Laptops", "Smartphones", "Tablets", "Headphones"]},
      {"name": "TVs", "image": "assets/images/subcategory_5_9.png", "price": 500, "stock": 20, "description": "Smart TVs with 4K resolution and smart features.", "related": ["Speakers", "Gaming Consoles", "Laptops", "Cameras"]},
      {"name": "Drones", "image": "assets/images/subcategory_5_10.png", "price": 300, "stock": 15, "description": "High-quality drones for aerial photography and fun.", "related": ["Cameras", "Smartphones", "Gaming Consoles", "Tablet"]}
    ]
  },

// 6. Clothing
  {
    "name": "Clothing",
    "image": "assets/images/category_6.png",
    "subcategories": [
      {"name": "Men's Shirts", "image": "assets/images/subcategory_6_1.png", "price": 30, "stock": 50, "description": "Stylish and comfortable shirts for men.", "related": ["Men's Jeans","T-Shirts","Women’s Dresses","Kids Clothing"]},
      {"name": "Men's Jeans", "image": "assets/images/subcategory_6_2.png", "price": 40, "stock": 40, "description": "Classic and durable jeans for men.", "related": ["Men's Shirts","T-Shirts","Shoes","Women’s Jeans"]},
      {"name": "Women's Dresses", "image": "assets/images/subcategory_6_3.png", "price": 50, "stock": 30, "description": "Elegant and fashionable dresses for women.", "related": ["Women's Tops","Women's Jeans","Men's Shirts","Handmade Jewelry"]},
      {"name": "Women's Tops", "image": "assets/images/subcategory_6_4.png", "price": 25, "stock": 70, "description": "Casual and stylish tops for everyday wear.", "related": ["Women's Dresses","Women's Jeans","T-Shirts","Men's Shirts"]},
      {"name": "T-Shirts", "image": "assets/images/subcategory_6_5.png", "price": 20, "stock": 90, "description": "Comfortable t-shirts available in multiple colors.", "related": ["Men's Shirts","Women's Tops","Jeans","Shoes"]},
      {"name": "Women's Jeans", "image": "assets/images/subcategory_6_6.png", "price": 45, "stock": 40, "description": "Trendy jeans for women with perfect fit.", "related": ["Women's Dresses","Women's Tops","T-Shirts","Shoes"]},
      {"name": "Jackets", "image": "assets/images/subcategory_6_7.png", "price": 60, "stock": 25, "description": "Warm and stylish jackets for men and women.", "related": ["Men's Shirts","Women's Dresses","T-Shirts","Shoes"]},
      {"name": "Shoes", "image": "assets/images/subcategory_6_8.png", "price": 35, "stock": 60, "description": "Comfortable shoes for daily wear.", "related": ["Men's Shirts","Women's Dresses","Men's Jeans","T-Shirts"]},
      {"name": "Accessories", "image": "assets/images/subcategory_6_9.png", "price": 15, "stock": 80, "description": "Belts, scarves, hats and other fashion accessories.", "related": ["T-Shirts","Shoes","Women's Dresses","Men's Shirts"]},
      {"name": "Handbags", "image": "assets/images/subcategory_6_10.png", "price": 50, "stock": 30, "description": "Trendy handbags for women for all occasions.", "related": ["Accessories","Women's Dresses","Women's Tops","Shoes"]}
    ]
  },

// 7. Home Appliances
  {
    "name": "Home Appliances",
    "image": "assets/images/category_7.png",
    "subcategories": [
      {"name": "Refrigerators", "image": "assets/images/subcategory_7_1.png", "price": 500, "stock": 15, "description": "Energy-efficient refrigerators for fresh food storage.", "related": ["Microwave","Washing Machine","Air Conditioner","Vacuum Cleaner"]},
      {"name": "Microwave", "image": "assets/images/subcategory_7_2.png", "price": 120, "stock": 30, "description": "High-performance microwave ovens for quick cooking.", "related": ["Refrigerators","Ovens","Air Conditioner","Blenders"]},
      {"name": "Washing Machine", "image": "assets/images/subcategory_7_3.png", "price": 400, "stock": 20, "description": "Efficient washing machines for hassle-free laundry.", "related": ["Dryers","Refrigerators","Microwave","Vacuum Cleaner"]},
      {"name": "Air Conditioner", "image": "assets/images/subcategory_7_4.png", "price": 350, "stock": 25, "description": "Keep your home cool and comfortable with AC units.", "related": ["Refrigerators","Fans","Heaters","Microwave"]},
      {"name": "Vacuum Cleaner", "image": "assets/images/subcategory_7_5.png", "price": 150, "stock": 40, "description": "High-power vacuum cleaners for easy cleaning.", "related": ["Washing Machine","Microwave","Air Conditioner","Blenders"]},
      {"name": "Blender", "image": "assets/images/subcategory_7_6.png", "price": 60, "stock": 50, "description": "Blenders for smoothies, shakes, and cooking.", "related": ["Juicer","Microwave","Refrigerators","Vacuum Cleaner"]},
      {"name": "Oven", "image": "assets/images/subcategory_7_7.png", "price": 200, "stock": 30, "description": "Electric ovens for baking and cooking.", "related": ["Microwave","Blender","Air Conditioner","Refrigerators"]},
      {"name": "Fans", "image": "assets/images/subcategory_7_8.png", "price": 50, "stock": 60, "description": "Ceiling and table fans to keep your home cool.", "related": ["Air Conditioner","Refrigerators","Blender","Microwave"]},
      {"name": "Heaters", "image": "assets/images/subcategory_7_9.png", "price": 70, "stock": 40, "description": "Electric heaters for warm and cozy rooms.", "related": ["Air Conditioner","Blender","Microwave","Refrigerators"]},
      {"name": "Dishwasher", "image": "assets/images/subcategory_7_10.png", "price": 300, "stock": 25, "description": "Automatic dishwashers for quick and clean dishwashing.", "related": ["Oven","Microwave","Refrigerators","Blender"]}
    ]
  },

// 8. Sports
  {
    "name": "Sports",
    "image": "assets/images/category_8.png",
    "subcategories": [
      {"name": "Football", "image": "assets/images/subcategory_8_1.png", "price": 25, "stock": 50, "description": "Official size footballs for training and matches.", "related": ["Basketball","Tennis Racket","Yoga Mat","T-Shirts"]},
      {"name": "Basketball", "image": "assets/images/subcategory_8_2.png", "price": 30, "stock": 40, "description": "High-quality basketballs suitable for indoor and outdoor play.", "related": ["Football","Tennis Racket","Sports Shoes","Yoga Mat"]},
      {"name": "Tennis Racket", "image": "assets/images/subcategory_8_3.png", "price": 50, "stock": 30, "description": "Professional-grade tennis rackets for all skill levels.", "related": ["Football","Basketball","Yoga Mat","Sports Shoes"]},
      {"name": "Yoga Mat", "image": "assets/images/subcategory_8_4.png", "price": 20, "stock": 60, "description": "Comfortable and non-slip yoga mats for all practices.", "related": ["Sports Shoes","Tennis Racket","Dumbbells","Football"]},
      {"name": "Sports Shoes", "image": "assets/images/subcategory_8_5.png", "price": 60, "stock": 70, "description": "Durable sports shoes for running, training, and games.", "related": ["Yoga Mat","Football","Basketball","Tennis Racket"]},
      {"name": "Dumbbells", "image": "assets/images/subcategory_8_6.png", "price": 40, "stock": 50, "description": "Weight training dumbbells for home workouts.", "related": ["Yoga Mat","Sports Shoes","Tennis Racket","Basketball"]},
      {"name": "Cricket Bat", "image": "assets/images/subcategory_8_7.png", "price": 35, "stock": 25, "description": "Premium cricket bats for practice and matches.", "related": ["Football","Sports Shoes","Cricket Ball","Tennis Racket"]},
      {"name": "Cricket Ball", "image": "assets/images/subcategory_8_8.png", "price": 10, "stock": 60, "description": "Durable cricket balls suitable for training and games.", "related": ["Cricket Bat","Football","Sports Shoes","Tennis Racket"]},
      {"name": "Badminton Racket", "image": "assets/images/subcategory_8_9.png", "price": 25, "stock": 45, "description": "Lightweight badminton rackets for players of all levels.", "related": ["Shuttlecock","Tennis Racket","Sports Shoes","Yoga Mat"]},
      {"name": "Shuttlecock", "image": "assets/images/subcategory_8_10.png", "price": 5, "stock": 100, "description": "High-quality shuttlecocks for indoor and outdoor badminton.", "related": ["Badminton Racket","Tennis Racket","Yoga Mat","Sports Shoes"]}
    ]
  },

// 9. Books
  {
    "name": "Books",
    "image": "assets/images/category_9.png",
    "subcategories": [
      {"name": "Fiction", "image": "assets/images/subcategory_9_1.png", "price": 15, "stock": 100, "description": "Engaging fiction books across various genres.", "related": ["Non-Fiction","Comics","Science","Children's Books"]},
      {"name": "Non-Fiction", "image": "assets/images/subcategory_9_2.png", "price": 20, "stock": 80, "description": "Informative books including biographies, history, and more.", "related": ["Fiction","Science","Self-Help","Comics"]},
      {"name": "Science", "image": "assets/images/subcategory_9_3.png", "price": 25, "stock": 50, "description": "Books covering various science topics and discoveries.", "related": ["Fiction","Non-Fiction","Technology","Comics"]},
      {"name": "Self-Help", "image": "assets/images/subcategory_9_4.png", "price": 18, "stock": 60, "description": "Books to improve personal development and skills.", "related": ["Non-Fiction","Fiction","Technology","Science"]},
      {"name": "Children's Books", "image": "assets/images/subcategory_9_5.png", "price": 12, "stock": 120, "description": "Illustrated books and stories for children.", "related": ["Comics","Fiction","Self-Help","Non-Fiction"]},
      {"name": "Comics", "image": "assets/images/subcategory_9_6.png", "price": 10, "stock": 90, "description": "Comic books featuring superheroes and adventure stories.", "related": ["Fiction","Children's Books","Science","Non-Fiction"]},
      {"name": "Technology", "image": "assets/images/subcategory_9_7.png", "price": 30, "stock": 40, "description": "Books on latest technology, programming, and gadgets.", "related": ["Science","Self-Help","Non-Fiction","Fiction"]},
      {"name": "History", "image": "assets/images/subcategory_9_8.png", "price": 22, "stock": 70, "description": "Books covering historical events and biographies.", "related": ["Non-Fiction","Science","Self-Help","Fiction"]},
      {"name": "Art & Design", "image": "assets/images/subcategory_9_9.png", "price": 28, "stock": 50, "description": "Books on art, design, and creative techniques.", "related": ["Fiction","Comics","Children's Books","Non-Fiction"]},
      {"name": "Cookbooks", "image": "assets/images/subcategory_9_10.png", "price": 18, "stock": 60, "description": "Recipe books for delicious meals and baking.", "related": ["Self-Help","Science","Fiction","Children's Books"]}
    ]
  },

// 10. Grocery
  {
    "name": "Grocery",
    "image": "assets/images/category_10.png",
    "subcategories": [
      {"name": "Fruits", "image": "assets/images/subcategory_10_1.png", "price": 3, "stock": 200, "description": "Fresh seasonal fruits sourced locally.", "related": ["Vegetables","Dairy","Snacks","Juices"]},
      {"name": "Vegetables", "image": "assets/images/subcategory_10_2.png", "price": 2, "stock": 180, "description": "Fresh vegetables for daily cooking needs.", "related": ["Fruits","Dairy","Snacks","Juices"]},
      {"name": "Dairy", "image": "assets/images/subcategory_10_3.png", "price": 5, "stock": 150, "description": "Milk, cheese, butter, and other dairy products.", "related": ["Fruits","Vegetables","Bakery","Juices"]},
      {"name": "Bakery", "image": "assets/images/subcategory_10_4.png", "price": 7, "stock": 100, "description": "Freshly baked bread, cakes, and pastries.", "related": ["Dairy","Snacks","Juices","Fruits"]},
      {"name": "Snacks", "image": "assets/images/subcategory_10_5.png", "price": 4, "stock": 200, "description": "Chips, cookies, and other packaged snacks.", "related": ["Fruits","Vegetables","Bakery","Dairy"]},
      {"name": "Juices", "image": "assets/images/subcategory_10_6.png", "price": 6, "stock": 150, "description": "Natural fruit juices and smoothies.", "related": ["Fruits","Snacks","Dairy","Bakery"]},
      {"name": "Rice & Grains", "image": "assets/images/subcategory_10_7.png", "price": 10, "stock": 100, "description": "High-quality rice, wheat, and grains for cooking.", "related": ["Pulses","Vegetables","Dairy","Fruits"]},
      {"name": "Pulses", "image": "assets/images/subcategory_10_8.png", "price": 8, "stock": 120, "description": "Lentils, beans, and other healthy pulses.", "related": ["Rice & Grains","Vegetables","Dairy","Fruits"]},
      {"name": "Spices", "image": "assets/images/subcategory_10_9.png", "price": 3, "stock": 180, "description": "Essential spices to enhance the flavor of your dishes.", "related": ["Rice & Grains","Vegetables","Dairy","Fruits"]},
      {"name": "Oils", "image": "assets/images/subcategory_10_10.png", "price": 5, "stock": 160, "description": "Cooking oils including olive, sunflower, and vegetable oils.", "related": ["Rice & Grains","Vegetables","Dairy","Snacks"]}
    ]
  },

  // Remaining categories (Kids, Electronics, Clothing, Home Appliances, Sports, Books, Grocery)
  // ... I can continue filling all 10 categories fully if you want.
];

