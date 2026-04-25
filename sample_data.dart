
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
        "related": ["Nail Polish", "Lipsticks", "Foundation", "Handmade Jewelry"]
      },
      {
        "name": "Makeup",
        "image": "assets/images/subcategory_1_2.png",
        "price": 30,
        "stock": 40,
        "description": "High-quality makeup essentials including foundation, blush, and more for every occasion.",
        "related": ["Lipsticks", "Eye Liner", "Foundation", "Tattoo Kits"]
      },
      {
        "name": "Perfume",
        "image": "assets/images/subcategory_1_3.png",
        "price": 50,
        "stock": 30,
        "description": "Fragrances with long-lasting freshness crafted from premium ingredients.",
        "related": ["Lip Gloss", "Moisturizer Cream", "Face Masks", "Henna Cones"]
      },
      {
        "name": "Hair Care",
        "image": "assets/images/subcategory_1_4.png",
        "price": 20,
        "stock": 60,
        "description": "Shampoos, conditioners, and serums enriched with natural oils for strong and shiny hair.",
        "related": ["Skin Care", "Face Masks", "Hair Oil", "Clay Pots"]
      },
      {
        "name": "Lipsticks",
        "image": "assets/images/subcategory_1_5.png",
        "price": 15,
        "stock": 70,
        "description": "Matte and glossy lipsticks available in vibrant shades to suit all skin tones.",
        "related": ["Makeup", "Eye Liner", "Lip Gloss", "Handmade Jewelry"]
      },
      {
        "name": "Nail Polish",
        "image": "assets/images/subcategory_1_6.png",
        "price": 10,
        "stock": 100,
        "description": "Quick-dry nail polish in multiple trendy colors with long-lasting shine.",
        "related": ["Lipsticks", "Beauty Tools", "Foundation", "Tattoo Ink"]
      },
      {
        "name": "Face Masks",
        "image": "assets/images/subcategory_1_7.png",
        "price": 12,
        "stock": 80,
        "description": "Hydrating and detoxifying face masks to rejuvenate and refresh your skin.",
        "related": ["Skin Care", "Hair Care", "Moisturizer Cream", "Handmade Soaps"]
      },
      {
        "name": "Foundation",
        "image": "assets/images/subcategory_1_8.png",
        "price": 35,
        "stock": 40,
        "description": "Lightweight foundation with full coverage for a flawless natural finish.",
        "related": ["Makeup", "Eye Liner", "Lipsticks", "Tattoo Cones"]
      },
      {
        "name": "Eye Liner",
        "image": "assets/images/subcategory_1_9.png",
        "tags": ["Popular", "Budget Picks", "Gift Ideas"],
        "price": 18,
        "stock": 90,
        "description": "Smudge-proof eyeliner for precise application and long-lasting wear.",
        "related": ["Makeup", "Foundation", "Lip Gloss", "Henna Powder"]
      },
      {
        "name": "Beauty Tools",
        "image": "assets/images/subcategory_1_10.png",
        "price": 22,
        "stock": 60,
        "description": "Essential beauty tools including brushes, sponges, and applicators.",
        "related": ["Makeup", "Lipsticks", "Face Masks", "Handmade Bags"]
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
        "related": ["Clay Pots", "Handwoven Baskets", "Handmade Bags", "Perfume"]
      },
      {
        "name": "Clay Pots",
        "image": "assets/images/subcategory_2_2.png",
        "tags": ["Gift Ideas"],
        "price": 15,
        "stock": 50,
        "description": "Durable and stylish clay pots for home decoration and gardening.",
        "related": ["Handmade Soaps", "Handwoven Baskets", "Handmade Jewelry", "Skin Care"]
      },
      {
        "name": "Handwoven Baskets",
        "image": "assets/images/subcategory_2_3.png",
        "price": 30,
        "stock": 25,
        "description": "Beautifully handwoven baskets for storage and decor.",
        "related": ["Clay Pots", "Handmade Jewelry", "Handmade Bags", "Face Masks"]
      },
      {
        "name": "Handmade Soaps",
        "image": "assets/images/subcategory_2_4.png",
        "price": 12,
        "stock": 60,
        "description": "Natural handmade soaps for gentle cleansing and moisturizing.",
        "related": ["Handmade Jewelry", "Clay Pots", "Lipsticks", "Tattoo Kits"]
      },
      {
        "name": "Hand-Painted Cups",
        "image": "assets/images/subcategory_2_5.png",
        "price": 25,
        "stock": 40,
        "description": "Artistic hand-painted cups to add charm to your kitchen.",
        "related": ["Decor Items", "Handmade Jewelry", "Skin Care", "Face Masks"]
      },
      {
        "name": "Decor Items",
        "image": "assets/images/subcategory_2_6.png",
        "price": 35,
        "stock": 30,
        "description": "Decorative handmade items for home and office.",
        "related": ["Handmade Jewelry", "Handwoven Baskets", "Foundation", "Lip Gloss"]
      },
      {
        "name": "Handmade Bags",
        "image": "assets/images/subcategory_2_7.png",
        "price": 55,
        "stock": 15,
        "description": "Handmade bags crafted with high-quality materials and attention to detail.",
        "related": ["Handmade Jewelry", "Clay Pots", "Face Masks", "Tattoo Ink"]
      },
      {
        "name": "Wood Crafts",
        "image": "assets/images/subcategory_2_8.png",
        "price": 50,
        "stock": 10,
        "description": "Handcrafted wood items for home decoration.",
        "related": ["Handmade Bags", "Hand-Painted Cups", "Lipsticks", "Henna Powder"]
      },
      {
        "name": "Custom Gifts",
        "image": "assets/images/subcategory_2_9.png",
        "price": 40,
        "stock": 35,
        "description": "Customized handmade gifts for special occasions.",
        "related": ["Handmade Bags", "Decor Items", "Face Masks", "Tattoo Kits"]
      },
      {
        "name": "Handmade Shoes",
        "image": "assets/images/subcategory_2_10.png",
        "price": 70,
        "stock": 12,
        "description": "Stylish handmade shoes for casual and formal wear.",
        "related": ["Handmade Bags", "Clay Pots", "Foundation", "Henna Powder"]
      }
    ]
  },

  // 3. Mehndi & Tattooing
  {
    "name": "Mehndi & Tattooing",
    "image": "assets/images/category_3.png",
    "tags": ["Popular", "New Arrivals", "Budget Picks", "Flash Deals", "Gift Ideas"],
    "subcategories": [
      {
        "name": "Mehndi Cones",
        "image": "assets/images/subcategory_3_1.png",
        "price": 5,
        "stock": 200,
        "description": "Natural henna cones for intricate mehndi designs.",
        "related": ["Henna Powder", "Tattoo Ink", "Tattoo Kits", "Lipsticks"]
      },
      {
        "name": "Henna Powder",
        "image": "assets/images/subcategory_3_2.png",
        "price": 8,
        "stock": 150,
        "description": "Fine henna powder for rich color and long-lasting mehndi.",
        "related": ["Mehndi Cones", "Tattoo Ink", "Tattoo Kits", "Face Masks"]
      },
      {
        "name": "Tattoo Ink",
        "image": "assets/images/subcategory_3_3.png",
        "tags": ["Budget Picks", "Gift Ideas"],
        "price": 20,
        "stock": 80,
        "description": "Premium tattoo inks for professional-quality designs.",
        "related": ["Tattoo Kits", "Henna Powder", "Face Masks", "Foundation"]
      },
      {
        "name": "Tattoo Kits",
        "image": "assets/images/subcategory_3_4.png",
        "tags": ["New Arrivals", "Budget Picks", "Flash Deals", "Gift Ideas"],
        "price": 100,
        "stock": 20,
        "description": "Complete tattoo kits including ink, needles, and accessories.",
        "related": ["Tattoo Ink", "Henna Powder", "Face Masks", "Handmade Bags"]
      },
      {
        "name": "Henna Oil",
        "image": "assets/images/subcategory_3_5.png",
        "price": 12,
        "stock": 90,
        "description": "Essential henna oil for hair and skin care.",
        "related": ["Mehndi Cones", "Henna Powder", "Tattoo Kits", "Lip Gloss"]
      },
      {
        "name": "Tattoo Stencils",
        "image": "assets/images/subcategory_3_6.png",
        "price": 15,
        "stock": 60,
        "description": "Tattoo stencils for precise designs.",
        "related": ["Tattoo Ink", "Tattoo Kits", "Foundation", "Handmade Jewelry"]
      },
      {
        "name": "Body Paints",
        "image": "assets/images/subcategory_3_7.png",
        "price": 25,
        "stock": 40,
        "description": "Non-toxic body paints for temporary tattoos and designs.",
        "related": ["Tattoo Ink", "Tattoo Kits", "Handmade Soaps", "Lipsticks"]
      },
      {
        "name": "Tattoo Needles",
        "image": "assets/images/subcategory_3_8.png",
        "tags": ["Popular", "New Arrivals", "Budget Picks", "Flash Deals", "Gift Ideas"],
        "price": 30,
        "stock": 50,
        "description": "High-quality needles for professional tattoo application.",
        "related": ["Tattoo Kits", "Tattoo Ink", "Henna Powder", "Handmade Bags"]
      },
      {
        "name": "Temporary Tattoos",
        "image": "assets/images/subcategory_3_9.png",
        "price": 10,
        "stock": 120,
        "description": "Fun temporary tattoos suitable for kids and adults.",
        "related": ["Body Paints", "Tattoo Ink", "Face Masks", "Lipsticks"]
      },
      {
        "name": "Tattoo Machines",
        "image": "assets/images/subcategory_3_10.png",
        "price": 150,
        "stock": 10,
        "description": "Professional tattoo machines for precise application.",
        "related": ["Tattoo Kits", "Tattoo Ink", "Tattoo Needles", "Henna Powder"]
      }
    ]
  },

  // 4. Kids & Baby  ← (from MongoDB: "Kids & Baby")
  {
    "name": "Kids & Baby",
    "image": "assets/images/category_4.png",
    "tags": ["New Arrivals", "Gift Ideas"],
    "subcategories": [
      {
        "name": "Boys Clothing",
        "image": "assets/images/subcategory_4_1.png",
        "price": 25,
        "stock": 80,
        "description": "Comfortable and stylish clothing for boys of all ages.",
        "related": ["Girls Clothing", "Kids Shoes", "School Bags", "Toys & Games"]
      },
      {
        "name": "Girls Clothing",
        "image": "assets/images/subcategory_4_2.png",
        "price": 25,
        "stock": 90,
        "description": "Beautiful and comfortable clothing for girls of all ages.",
        "related": ["Boys Clothing", "Baby Shoes", "School Bags", "Educational Toys"]
      },
      {
        "name": "Baby Clothing (0-2 Years)",
        "image": "assets/images/subcategory_4_3.png",
        "price": 20,
        "stock": 60,
        "description": "Soft and safe clothing for newborns and toddlers.",
        "related": ["Baby Care", "Diapers & Wipes", "Baby Feeding", "Baby Shoes"]
      },
      {
        "name": "Kids Shoes",
        "image": "assets/images/subcategory_4_4.png",
        "price": 30,
        "stock": 70,
        "description": "Comfortable and durable shoes for kids.",
        "related": ["Boys Clothing", "Girls Clothing", "School Bags", "Outdoor Play"]
      },
      {
        "name": "Baby Shoes",
        "image": "assets/images/subcategory_4_5.png",
        "price": 18,
        "stock": 80,
        "description": "Soft and safe shoes for babies and toddlers.",
        "related": ["Baby Clothing (0-2 Years)", "Baby Care", "Baby Feeding", "Diapers & Wipes"]
      },
      {
        "name": "Toys & Games",
        "image": "assets/images/subcategory_4_6.png",
        "price": 15,
        "stock": 120,
        "description": "Fun and safe toys and games for kids of all ages.",
        "related": ["Educational Toys", "Outdoor Play", "Boys Clothing", "School Bags"]
      },
      {
        "name": "Educational Toys",
        "image": "assets/images/subcategory_4_7.png",
        "price": 22,
        "stock": 90,
        "description": "Learning toys that make education fun and creative.",
        "related": ["Toys & Games", "Boys Clothing", "Girls Clothing", "School Bags"]
      },
      {
        "name": "Baby Care",
        "image": "assets/images/subcategory_4_8.png",
        "price": 20,
        "stock": 60,
        "description": "Baby care essentials including lotions, shampoos, and wipes.",
        "related": ["Diapers & Wipes", "Baby Feeding", "Baby Clothing (0-2 Years)", "Baby Shoes"]
      },
      {
        "name": "Diapers & Wipes",
        "image": "assets/images/subcategory_4_9.png",
        "price": 12,
        "stock": 150,
        "description": "High-quality diapers and wipes for your baby's comfort.",
        "related": ["Baby Care", "Baby Feeding", "Baby Clothing (0-2 Years)", "Baby Shoes"]
      },
      {
        "name": "School Bags",
        "image": "assets/images/subcategory_4_10.png",
        "price": 35,
        "stock": 50,
        "description": "Durable and spacious school bags for kids.",
        "related": ["Boys Clothing", "Girls Clothing", "Kids Shoes", "Educational Toys"]
      }
    ]
  },

  // 5. Electronics  ← (original + enhanced from MongoDB)
  {
    "name": "Electronics",
    "image": "assets/images/category_5.png",
    "tags": ["Popular", "Gift Ideas"],
    "subcategories": [
      {
        "name": "Smartphones",
        "image": "assets/images/subcategory_5_1.png",
        "tags": ["Popular", "New Arrivals", "Budget Picks", "Flash Deals", "Gift Ideas"],
        "price": 300,
        "stock": 50,
        "description": "Latest smartphones with advanced features.",
        "related": ["Laptops", "Headphones", "Smart Watches", "Tablet"]
      },
      {
        "name": "Laptops",
        "image": "assets/images/subcategory_5_2.png",
        "price": 800,
        "stock": 30,
        "description": "High-performance laptops for work and gaming.",
        "related": ["Smartphones", "Tablet", "Headphones", "Camera"]
      },
      {
        "name": "Headphones",
        "image": "assets/images/subcategory_5_3.png",
        "price": 50,
        "stock": 70,
        "description": "Noise-cancelling and wireless headphones.",
        "related": ["Smartphones", "Laptops", "Speakers", "Smart Watches"]
      },
      {
        "name": "Smart Watches",
        "image": "assets/images/subcategory_5_4.png",
        "price": 150,
        "stock": 40,
        "description": "Feature-packed smart watches for fitness and notifications.",
        "related": ["Smartphones", "Headphones", "Laptops", "Tablet"]
      },
      {
        "name": "Tablets",
        "image": "assets/images/subcategory_5_5.png",
        "price": 200,
        "stock": 60,
        "description": "Portable and powerful tablets for work and play.",
        "related": ["Laptops", "Smartphones", "Smart Watches", "Speakers"]
      },
      {
        "name": "Cameras",
        "image": "assets/images/subcategory_5_6.png",
        "price": 400,
        "stock": 25,
        "description": "High-resolution cameras for photography enthusiasts.",
        "related": ["Tripods", "Lenses", "Smartphones", "Headphones"]
      },
      {
        "name": "Speakers",
        "image": "assets/images/subcategory_5_7.png",
        "price": 60,
        "stock": 80,
        "description": "Portable and home speakers for high-quality sound.",
        "related": ["Headphones", "Smartphones", "Smart Watches", "Tablet"]
      },
      {
        "name": "Gaming Consoles",
        "image": "assets/images/subcategory_5_8.png",
        "price": 350,
        "stock": 30,
        "description": "Latest gaming consoles for immersive gameplay.",
        "related": ["Laptops", "Smartphones", "Tablets", "Headphones"]
      },
      {
        "name": "TVs",
        "image": "assets/images/subcategory_5_9.png",
        "price": 500,
        "stock": 20,
        "description": "Smart TVs with 4K resolution and smart features.",
        "related": ["Speakers", "Gaming Consoles", "Laptops", "Cameras"]
      },
      {
        "name": "Drones",
        "image": "assets/images/subcategory_5_10.png",
        "price": 300,
        "stock": 15,
        "description": "High-quality drones for aerial photography and fun.",
        "related": ["Cameras", "Smartphones", "Gaming Consoles", "Tablet"]
      }
    ]
  },

  // 6. Fashion  ← (from MongoDB: "Fashion")
  {
    "name": "Fashion",
    "image": "assets/images/category_6.png",
    "tags": ["New Arrivals", "Flash Deals"],
    "subcategories": [
      {
        "name": "Casual Shirts",
        "image": "assets/images/subcategory_6_1.png",
        "price": 30,
        "stock": 90,
        "description": "Stylish and comfortable casual shirts for everyday wear.",
        "related": ["Formal Shirts", "Jeans", "T-Shirts & Polos", "Shalwar Kameez"]
      },
      {
        "name": "Formal Shirts",
        "image": "assets/images/subcategory_6_2.png",
        "price": 45,
        "stock": 60,
        "description": "Elegant formal shirts for office and special occasions.",
        "related": ["Suits & Blazers", "Trousers & Chinos", "Casual Shirts", "Men's Shoes"]
      },
      {
        "name": "T-Shirts & Polos",
        "image": "assets/images/subcategory_6_3.png",
        "price": 20,
        "stock": 100,
        "description": "Comfortable t-shirts and polo shirts in multiple colors.",
        "related": ["Casual Shirts", "Jeans", "Sportswear", "Men's Shoes"]
      },
      {
        "name": "Jeans",
        "image": "assets/images/subcategory_6_4.png",
        "price": 40,
        "stock": 70,
        "description": "Classic and durable jeans for men in various fits.",
        "related": ["Casual Shirts", "T-Shirts & Polos", "Men's Shoes", "Jackets & Coats"]
      },
      {
        "name": "Shalwar Kameez",
        "image": "assets/images/subcategory_6_5.png",
        "price": 35,
        "stock": 80,
        "description": "Traditional and modern shalwar kameez for all occasions.",
        "related": ["Kurtas", "Suits & Blazers", "Casual Shirts", "Men's Sandals"]
      },
      {
        "name": "Suits & Blazers",
        "image": "assets/images/subcategory_6_6.png",
        "price": 120,
        "stock": 30,
        "description": "Premium suits and blazers for formal events.",
        "related": ["Formal Shirts", "Trousers & Chinos", "Men's Shoes", "Men's Watches"]
      },
      {
        "name": "Jackets & Coats",
        "image": "assets/images/subcategory_6_7.png",
        "price": 80,
        "stock": 25,
        "description": "Warm and stylish jackets for every season.",
        "related": ["Casual Shirts", "Jeans", "Sportswear", "Men's Shoes"]
      },
      {
        "name": "Men's Shoes",
        "image": "assets/images/subcategory_6_8.png",
        "price": 60,
        "stock": 55,
        "description": "Comfortable and stylish shoes for men.",
        "related": ["Formal Shirts", "Jeans", "Suits & Blazers", "Men's Accessories"]
      },
      {
        "name": "Men's Watches",
        "image": "assets/images/subcategory_6_9.png",
        "tags": ["Popular", "Gift Ideas"],
        "price": 150,
        "stock": 40,
        "description": "Elegant and durable watches for men.",
        "related": ["Suits & Blazers", "Formal Shirts", "Men's Accessories", "Men's Shoes"]
      },
      {
        "name": "Men's Accessories",
        "image": "assets/images/subcategory_6_10.png",
        "price": 25,
        "stock": 60,
        "description": "Belts, wallets, ties and other accessories for men.",
        "related": ["Men's Watches", "Suits & Blazers", "Formal Shirts", "Men's Shoes"]
      }
    ]
  },

  // 7. Home Appliances  ← (original)
  {
    "name": "Home Appliances",
    "image": "assets/images/category_7.png",
    "subcategories": [
      {
        "name": "Refrigerators",
        "image": "assets/images/subcategory_7_1.png",
        "price": 500,
        "stock": 15,
        "description": "Energy-efficient refrigerators for fresh food storage.",
        "related": ["Microwave", "Washing Machine", "Air Conditioner", "Vacuum Cleaner"]
      },
      {
        "name": "Microwave",
        "image": "assets/images/subcategory_7_2.png",
        "price": 120,
        "stock": 30,
        "description": "High-performance microwave ovens for quick cooking.",
        "related": ["Refrigerators", "Ovens", "Air Conditioner", "Blenders"]
      },
      {
        "name": "Washing Machine",
        "image": "assets/images/subcategory_7_3.png",
        "price": 400,
        "stock": 20,
        "description": "Efficient washing machines for hassle-free laundry.",
        "related": ["Dryers", "Refrigerators", "Microwave", "Vacuum Cleaner"]
      },
      {
        "name": "Air Conditioner",
        "image": "assets/images/subcategory_7_4.png",
        "price": 350,
        "stock": 25,
        "description": "Keep your home cool and comfortable with AC units.",
        "related": ["Refrigerators", "Fans", "Heaters", "Microwave"]
      },
      {
        "name": "Vacuum Cleaner",
        "image": "assets/images/subcategory_7_5.png",
        "price": 150,
        "stock": 40,
        "description": "High-power vacuum cleaners for easy cleaning.",
        "related": ["Washing Machine", "Microwave", "Air Conditioner", "Blenders"]
      },
      {
        "name": "Blender",
        "image": "assets/images/subcategory_7_6.png",
        "price": 60,
        "stock": 50,
        "description": "Blenders for smoothies, shakes, and cooking.",
        "related": ["Juicer", "Microwave", "Refrigerators", "Vacuum Cleaner"]
      },
      {
        "name": "Oven",
        "image": "assets/images/subcategory_7_7.png",
        "price": 200,
        "stock": 30,
        "description": "Electric ovens for baking and cooking.",
        "related": ["Microwave", "Blender", "Air Conditioner", "Refrigerators"]
      },
      {
        "name": "Fans",
        "image": "assets/images/subcategory_7_8.png",
        "price": 50,
        "stock": 60,
        "description": "Ceiling and table fans to keep your home cool.",
        "related": ["Air Conditioner", "Refrigerators", "Blender", "Microwave"]
      },
      {
        "name": "Heaters",
        "image": "assets/images/subcategory_7_9.png",
        "price": 70,
        "stock": 40,
        "description": "Electric heaters for warm and cozy rooms.",
        "related": ["Air Conditioner", "Blender", "Microwave", "Refrigerators"]
      },
      {
        "name": "Dishwasher",
        "image": "assets/images/subcategory_7_10.png",
        "price": 300,
        "stock": 25,
        "description": "Automatic dishwashers for quick and clean dishwashing.",
        "related": ["Oven", "Microwave", "Refrigerators", "Blender"]
      }
    ]
  },

  // 8. Sports & Outdoors  ← (from MongoDB: "Sports & Outdoors")
  {
    "name": "Sports & Outdoors",
    "image": "assets/images/category_8.png",
    "tags": ["Popular", "New Arrivals"],
    "subcategories": [
      {
        "name": "Cricket",
        "image": "assets/images/subcategory_8_1.png",
        "price": 35,
        "stock": 50,
        "description": "Premium cricket bats, balls and equipment for practice and matches.",
        "related": ["Football", "Badminton", "Sports Nutrition", "Sportswear & Shoes"]
      },
      {
        "name": "Football",
        "image": "assets/images/subcategory_8_2.png",
        "price": 25,
        "stock": 60,
        "description": "Official size footballs and accessories for training and matches.",
        "related": ["Basketball", "Cricket", "Sportswear & Shoes", "Gym & Fitness Equipment"]
      },
      {
        "name": "Badminton",
        "image": "assets/images/subcategory_8_3.png",
        "price": 25,
        "stock": 45,
        "description": "Lightweight rackets and shuttlecocks for all levels.",
        "related": ["Tennis", "Cricket", "Yoga & Pilates", "Sportswear & Shoes"]
      },
      {
        "name": "Tennis",
        "image": "assets/images/subcategory_8_4.png",
        "price": 50,
        "stock": 30,
        "description": "Professional tennis rackets and accessories for all skill levels.",
        "related": ["Badminton", "Basketball", "Gym & Fitness Equipment", "Sportswear & Shoes"]
      },
      {
        "name": "Basketball",
        "image": "assets/images/subcategory_8_5.png",
        "price": 30,
        "stock": 40,
        "description": "High-quality basketballs suitable for indoor and outdoor play.",
        "related": ["Football", "Tennis", "Gym & Fitness Equipment", "Sportswear & Shoes"]
      },
      {
        "name": "Gym & Fitness Equipment",
        "image": "assets/images/subcategory_8_6.png",
        "price": 40,
        "stock": 50,
        "description": "Dumbbells, resistance bands and home workout equipment.",
        "related": ["Yoga & Pilates", "Sports Nutrition", "Running & Athletics", "Sportswear & Shoes"]
      },
      {
        "name": "Yoga & Pilates",
        "image": "assets/images/subcategory_8_7.png",
        "price": 20,
        "stock": 60,
        "description": "Comfortable mats and accessories for yoga and pilates.",
        "related": ["Gym & Fitness Equipment", "Running & Athletics", "Sports Nutrition", "Sportswear & Shoes"]
      },
      {
        "name": "Running & Athletics",
        "image": "assets/images/subcategory_8_8.png",
        "price": 60,
        "stock": 55,
        "description": "Shoes, clothing and gear for running and athletics.",
        "related": ["Gym & Fitness Equipment", "Yoga & Pilates", "Sportswear & Shoes", "Sports Nutrition"]
      },
      {
        "name": "Sports Nutrition",
        "image": "assets/images/subcategory_8_9.png",
        "price": 35,
        "stock": 70,
        "description": "Protein supplements and nutrition for athletes.",
        "related": ["Gym & Fitness Equipment", "Running & Athletics", "Yoga & Pilates", "Cycling"]
      },
      {
        "name": "Sportswear & Shoes",
        "image": "assets/images/subcategory_8_10.png",
        "price": 55,
        "stock": 80,
        "description": "High-performance sportswear and shoes for all activities.",
        "related": ["Gym & Fitness Equipment", "Running & Athletics", "Cricket", "Football"]
      }
    ]
  },

  // 9. Health & Beauty  ← (from MongoDB: "Health & Beauty")
  {
    "name": "Health & Beauty",
    "image": "assets/images/category_9.png",
    "tags": ["Popular", "Budget Picks"],
    "subcategories": [
      {
        "name": "Skincare",
        "image": "assets/images/subcategory_9_1.png",
        "price": 30,
        "stock": 80,
        "description": "Complete skincare range for glowing and healthy skin.",
        "related": ["Face Wash & Cleansers", "Moisturizers & Serums", "Sunscreen", "Makeup & Cosmetics"]
      },
      {
        "name": "Face Wash & Cleansers",
        "image": "assets/images/subcategory_9_2.png",
        "price": 18,
        "stock": 100,
        "description": "Gentle and effective face washes for all skin types.",
        "related": ["Skincare", "Moisturizers & Serums", "Sunscreen", "Eye Makeup"]
      },
      {
        "name": "Moisturizers & Serums",
        "image": "assets/images/subcategory_9_3.png",
        "price": 35,
        "stock": 70,
        "description": "Hydrating moisturizers and anti-aging serums.",
        "related": ["Skincare", "Face Wash & Cleansers", "Sunscreen", "Hair Care"]
      },
      {
        "name": "Makeup & Cosmetics",
        "image": "assets/images/subcategory_9_4.png",
        "price": 25,
        "stock": 90,
        "description": "Full range of makeup products for every look.",
        "related": ["Lipsticks & Lip Care", "Foundation & Concealer", "Eye Makeup", "Skincare"]
      },
      {
        "name": "Lipsticks & Lip Care",
        "image": "assets/images/subcategory_9_5.png",
        "price": 15,
        "stock": 120,
        "description": "Matte, glossy and nourishing lip products.",
        "related": ["Makeup & Cosmetics", "Foundation & Concealer", "Eye Makeup", "Skincare"]
      },
      {
        "name": "Hair Care",
        "image": "assets/images/subcategory_9_6.png",
        "price": 22,
        "stock": 85,
        "description": "Shampoos, conditioners and hair treatments for all hair types.",
        "related": ["Shampoos & Conditioners", "Hair Color", "Skincare", "Fragrances & Perfumes"]
      },
      {
        "name": "Fragrances & Perfumes",
        "image": "assets/images/subcategory_9_7.png",
        "price": 55,
        "stock": 50,
        "description": "Long-lasting fragrances for men and women.",
        "related": ["Skincare", "Makeup & Cosmetics", "Oral Care", "Personal Care"]
      },
      {
        "name": "Vitamins & Supplements",
        "image": "assets/images/subcategory_9_8.png",
        "tags": ["New Arrivals", "Budget Picks"],
        "price": 40,
        "stock": 65,
        "description": "Essential vitamins and health supplements for daily wellness.",
        "related": ["Medical Devices", "Personal Care", "Skincare", "Oral Care"]
      },
      {
        "name": "Oral Care",
        "image": "assets/images/subcategory_9_9.png",
        "price": 12,
        "stock": 95,
        "description": "Toothbrushes, toothpaste and complete oral hygiene products.",
        "related": ["Personal Care", "Skincare", "Vitamins & Supplements", "Shaving & Grooming"]
      },
      {
        "name": "Shaving & Grooming",
        "image": "assets/images/subcategory_9_10.png",
        "price": 28,
        "stock": 55,
        "description": "Razors, trimmers and grooming essentials for men.",
        "related": ["Personal Care", "Oral Care", "Fragrances & Perfumes", "Skincare"]
      }
    ]
  },

  // 10. Grocery & Gourmet  ← (from MongoDB: "Grocery & Gourmet")
  {
    "name": "Grocery & Gourmet",
    "image": "assets/images/category_10.png",
    "tags": ["Budget Picks", "Flash Deals"],
    "subcategories": [
      {
        "name": "Rice, Flour & Grains",
        "image": "assets/images/subcategory_10_1.png",
        "price": 10,
        "stock": 200,
        "description": "High-quality rice, wheat flour and grains for everyday cooking.",
        "related": ["Cooking Oil & Ghee", "Spices & Condiments", "Pulses", "Packaged Foods"]
      },
      {
        "name": "Cooking Oil & Ghee",
        "image": "assets/images/subcategory_10_2.png",
        "price": 8,
        "stock": 180,
        "description": "Pure cooking oils and desi ghee for healthy cooking.",
        "related": ["Rice, Flour & Grains", "Spices & Condiments", "Dairy Products", "Packaged Foods"]
      },
      {
        "name": "Spices & Condiments",
        "image": "assets/images/subcategory_10_3.png",
        "price": 5,
        "stock": 220,
        "description": "Fresh and aromatic spices to enhance the flavor of your dishes.",
        "related": ["Rice, Flour & Grains", "Cooking Oil & Ghee", "Packaged Foods", "Tea & Coffee"]
      },
      {
        "name": "Biscuits & Snacks",
        "image": "assets/images/subcategory_10_4.png",
        "price": 4,
        "stock": 200,
        "description": "Chips, biscuits, cookies and other packaged snacks.",
        "related": ["Beverages & Juices", "Tea & Coffee", "Chocolates & Candy", "Packaged Foods"]
      },
      {
        "name": "Tea & Coffee",
        "image": "assets/images/subcategory_10_5.png",
        "price": 12,
        "stock": 150,
        "description": "Premium tea, green tea and coffee for your daily brew.",
        "related": ["Beverages & Juices", "Biscuits & Snacks", "Dairy Products", "Breakfast Cereals"]
      },
      {
        "name": "Beverages & Juices",
        "image": "assets/images/subcategory_10_6.png",
        "price": 6,
        "stock": 160,
        "description": "Soft drinks, juices, energy drinks and flavored beverages.",
        "related": ["Tea & Coffee", "Biscuits & Snacks", "Dairy Products", "Chocolates & Candy"]
      },
      {
        "name": "Dairy Products",
        "image": "assets/images/subcategory_10_7.png",
        "price": 7,
        "stock": 130,
        "description": "Fresh milk, yogurt, cheese, butter and other dairy items.",
        "related": ["Cooking Oil & Ghee", "Tea & Coffee", "Breakfast Cereals", "Beverages & Juices"]
      },
      {
        "name": "Packaged Foods",
        "image": "assets/images/subcategory_10_8.png",
        "price": 9,
        "stock": 140,
        "description": "Ready-to-eat and easy-to-cook packaged food items.",
        "related": ["Rice, Flour & Grains", "Spices & Condiments", "Biscuits & Snacks", "Frozen Foods"]
      },
      {
        "name": "Dry Fruits & Nuts",
        "image": "assets/images/subcategory_10_9.png",
        "tags": ["Popular", "Gift Ideas"],
        "price": 25,
        "stock": 100,
        "description": "Premium almonds, cashews, dates and other dry fruits.",
        "related": ["Chocolates & Candy", "Biscuits & Snacks", "Organic & Natural", "Baby Food"]
      },
      {
        "name": "Chocolates & Candy",
        "image": "assets/images/subcategory_10_10.png",
        "tags": ["Gift Ideas"],
        "price": 8,
        "stock": 170,
        "description": "Delicious chocolates, candies and sweet treats for everyone.",
        "related": ["Dry Fruits & Nuts", "Biscuits & Snacks", "Beverages & Juices", "Baby Food"]
      }
    ]
  },

  // 11. Women's Fashion  ← (from MongoDB: "Women's Fashion")
  {
    "name": "Women's Fashion",
    "image": "assets/images/category_11.png",
    "tags": ["Popular", "New Arrivals", "Flash Deals"],
    "subcategories": [
      {
        "name": "Dresses",
        "image": "assets/images/subcategory_11_1.png",
        "price": 55,
        "stock": 70,
        "description": "Casual and formal dresses for every occasion.",
        "related": ["Tops & Blouses", "Kurtis & Tunics", "Women's Shoes", "Women's Bags & Purses"]
      },
      {
        "name": "Tops & Blouses",
        "image": "assets/images/subcategory_11_2.png",
        "price": 30,
        "stock": 90,
        "description": "Stylish tops and blouses for casual and formal wear.",
        "related": ["Dresses", "Leggings & Tights", "Women's Shoes", "Jackets & Coats"]
      },
      {
        "name": "Kurtis & Tunics",
        "image": "assets/images/subcategory_11_3.png",
        "price": 35,
        "stock": 85,
        "description": "Elegant kurtis and tunics for traditional and modern looks.",
        "related": ["Shalwar Kameez", "Abayas & Hijabs", "Women's Sandals", "Jewellery & Accessories"]
      },
      {
        "name": "Shalwar Kameez",
        "image": "assets/images/subcategory_11_4.png",
        "price": 40,
        "stock": 75,
        "description": "Traditional and stylish shalwar kameez for all occasions.",
        "related": ["Kurtis & Tunics", "Abayas & Hijabs", "Lawn & Fabric Suits", "Scarves & Shawls"]
      },
      {
        "name": "Abayas & Hijabs",
        "image": "assets/images/subcategory_11_5.png",
        "price": 45,
        "stock": 65,
        "description": "Beautiful abayas and hijabs for modest and stylish dressing.",
        "related": ["Shalwar Kameez", "Scarves & Shawls", "Kurtis & Tunics", "Women's Shoes"]
      },
      {
        "name": "Lawn & Fabric Suits",
        "image": "assets/images/subcategory_11_6.png",
        "tags": ["Popular", "Flash Deals"],
        "price": 60,
        "stock": 80,
        "description": "Premium lawn and fabric suits for all seasons.",
        "related": ["Shalwar Kameez", "Kurtis & Tunics", "Abayas & Hijabs", "Scarves & Shawls"]
      }
    ]
  },

  // 12. Home & Living  ← (from MongoDB: "Home & Living")
  {
    "name": "Home & Living",
    "image": "assets/images/category_12.png",
    "tags": ["New Arrivals", "Gift Ideas"],
    "subcategories": [
      {
        "name": "Bedding & Pillows",
        "image": "assets/images/subcategory_12_1.png",
        "price": 45,
        "stock": 70,
        "description": "Comfortable bedsheets, pillows and pillow covers.",
        "related": ["Blankets & Comforters", "Curtains & Blinds", "Carpets & Rugs", "Wall Art & Decor"]
      },
      {
        "name": "Blankets & Comforters",
        "image": "assets/images/subcategory_12_2.png",
        "price": 55,
        "stock": 60,
        "description": "Warm and cozy blankets and comforters for all seasons.",
        "related": ["Bedding & Pillows", "Curtains & Blinds", "Carpets & Rugs", "Clocks"]
      },
      {
        "name": "Curtains & Blinds",
        "image": "assets/images/subcategory_12_3.png",
        "price": 40,
        "stock": 50,
        "description": "Stylish curtains and blinds to transform your space.",
        "related": ["Bedding & Pillows", "Carpets & Rugs", "Wall Art & Decor", "Photo Frames"]
      },
      {
        "name": "Carpets & Rugs",
        "image": "assets/images/subcategory_12_4.png",
        "price": 80,
        "stock": 35,
        "description": "Beautiful carpets and rugs for every room.",
        "related": ["Curtains & Blinds", "Wall Art & Decor", "Clocks", "Photo Frames"]
      },
      {
        "name": "Wall Art & Decor",
        "image": "assets/images/subcategory_12_5.png",
        "price": 30,
        "stock": 80,
        "description": "Paintings, frames and decorative wall items.",
        "related": ["Photo Frames", "Clocks", "Candles & Holders", "Artificial Plants & Flowers"]
      },
      {
        "name": "Candles & Holders",
        "image": "assets/images/subcategory_12_6.png",
        "tags": ["Gift Ideas"],
        "price": 18,
        "stock": 75,
        "description": "Scented candles and decorative holders for ambiance.",
        "related": ["Artificial Plants & Flowers", "Wall Art & Decor", "Photo Frames", "Storage & Organization"]
      }
    ]
  },

];