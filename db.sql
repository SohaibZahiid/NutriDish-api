-- Create or use the database
DROP DATABASE IF EXISTS db_nutridish;
CREATE DATABASE IF NOT EXISTS db_nutridish;
USE db_nutridish;

-- Create the user table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,-- Create or use the database
DROP DATABASE IF EXISTS db_nutridish;
CREATE DATABASE IF NOT EXISTS db_nutridish;
USE db_nutridish;

-- Create the user table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    UNIQUE (username)
);


-- Create tags Table
CREATE TABLE IF NOT EXISTS tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Create User Tags Table
CREATE TABLE IF NOT EXISTS user_tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id)
);

-- Create recipes Table
CREATE TABLE IF NOT EXISTS recipes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    meal_type VARCHAR(50) NOT NULL,
    created_by VARCHAR(255),
    total_time INT,
    servings INT,
    image VARCHAR(255),
    featured BOOLEAN DEFAULT 0,
    dietary_type VARCHAR(50) DEFAULT 'Non-vegetarian'
);

-- Create Recipe Tags Table
CREATE TABLE IF NOT EXISTS recipe_tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id)
);

-- Create Ingredients Table
CREATE TABLE IF NOT EXISTS ingredients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    unit VARCHAR(50),
    UNIQUE (name)
);

-- Create Recipe Ingredients Table
CREATE TABLE IF NOT EXISTS recipes_ingredients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity DECIMAL(10, 2),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id)
);

-- Insert sample data into users table
INSERT INTO users (name, username, password)
VALUES
    ('Michael Johnson', 'michaelj', 'securepassword'),
    ('Emily Brown', 'emilyb', 'safepass123');


-- Insert sample data into tags table
INSERT INTO tags (name)
VALUES
	('Gluten-Free'),
    ('Keto'),
    ('Paleo'),
    ('Dessert'),
    ('Quick & Easy'),
    ('Comfort Food'),
    ('Low Calorie'),
    ('Asian'),
    ('Mediterranean'),
    ('Mexican');

INSERT INTO user_tags (user_id, tag_id)
VALUES
    (1, 2), -- User 1 selected Vegetarian tag
    (1, 5); -- User 1 selected Low Carb tag


-- Insert sample data into recipes table
INSERT INTO recipes (name, description, created_by, total_time, servings, image, meal_type, featured, dietary_type)
VALUES
('Vegetable Omelette', 'Delicious omelette filled with vegetables', 'Alice Johnson', 15, 1, 'image_url', 'breakfast', 0, 'vegetarian'),
('Banana Pancakes', 'Fluffy banana pancakes', 'John Smith', 20, 4, 'image_url', 'breakfast', 0, 'paleo'),
('Smoked Salmon Bagel', 'Bagel with smoked salmon and cream cheese', 'Emily Davis', 10, 1, 'image_url', 'breakfast', 0, 'pescatarian'),
('Greek Yogurt Bowl', 'Yogurt with honey, nuts, and fruits', 'James Walker', 5, 1, 'image_url', 'breakfast', 0, 'vegetarian'),
('Ham and Cheese Sandwich', 'Quick ham and cheese sandwich', 'Sandra Lee', 10, 1, 'image_url', 'breakfast', 0, 'non vegetarian'),
('Berry Smoothie', 'Healthy berry smoothie', 'Brian Adams', 5, 1, 'image_url', 'breakfast', 0, 'paleo'),
('Mushroom Scramble', 'Mushroom and egg scramble', 'Laura Clark', 10, 2, 'image_url', 'breakfast', 0, 'vegetarian'),
('Bacon and Eggs', 'Classic bacon and eggs breakfast', 'Kevin Miller', 15, 1, 'image_url', 'breakfast', 0, 'non vegetarian'),
('Avocado Toast', 'Whole grain toast with mashed avocado', 'Karen Wilson', 10, 1, 'image_url', 'breakfast', 0, 'vegetarian'),
('Salmon Frittata', 'Baked frittata with smoked salmon', 'Samuel Lewis', 20, 4, 'image_url', 'breakfast', 0, 'pescatarian'),
('Chicken Sausage Skillet', 'Skillet with chicken sausage and vegetables', 'Nancy Harris', 15, 2, 'image_url', 'breakfast', 0, 'non vegetarian'),
('Vegan Oatmeal', 'Creamy oatmeal with almond milk and berries', 'Peter Thompson', 15, 2, 'image_url', 'breakfast', 0, 'vegetarian'),
('Shrimp and Grits', 'Southern style shrimp and grits', 'Rebecca White', 30, 4, 'image_url', 'breakfast', 0, 'pescatarian'),
('Egg White Muffins', 'Baked egg white muffins with spinach', 'Kathleen Anderson', 20, 4, 'image_url', 'breakfast', 0, 'vegetarian'),
('Pork Breakfast Burrito', 'Breakfast burrito with pork sausage', 'Timothy Taylor', 20, 2, 'image_url', 'breakfast', 0, 'non vegetarian'),
('Chia Seed Pudding', 'Healthy chia seed pudding with fruit', 'Melissa Hall', 120, 4, 'image_url', 'breakfast', 0, 'paleo'),
('Tofu Scramble', 'Vegan tofu scramble with vegetables', 'George Young', 15, 2, 'image_url', 'breakfast', 0, 'vegetarian'),
('Grilled Mackerel', 'Grilled mackerel with lemon', 'Patricia Allen', 15, 1, 'image_url', 'breakfast', 0, 'pescatarian'),
('Beef Breakfast Sausage', 'Homemade beef breakfast sausage', 'Joseph Wright', 20, 4, 'image_url', 'breakfast', 0, 'non vegetarian'),
('Coconut Pancakes', 'Fluffy coconut flour pancakes', 'Angela Scott', 20, 4, 'image_url', 'breakfast', 0, 'paleo'),


-- Lunch
('Grilled Chicken Salad', 'Healthy salad with grilled chicken', 'Michael Johnson', 20, 2, 'image_url', 'lunch', 0, 'non vegetarian'),
('Vegan Burger', 'Delicious vegan burger with fries', 'Sara Lee', 30, 1, 'image_url', 'lunch', 0, 'vegetarian'),
('Shrimp Salad', 'Fresh salad with shrimp and avocado', 'David Kim', 15, 2, 'image_url', 'lunch', 0, 'pescatarian'),
('Chicken Caesar Salad', 'Crispy romaine with chicken and Caesar dressing', 'Luisa Hernandez', 15, 1, 'image_url', 'lunch', 0, 'non vegetarian'),
('Vegetable Stir Fry', 'Mixed vegetable stir fry with soy sauce', 'Diego Sanchez', 20, 2, 'image_url', 'lunch', 0, 'vegetarian'),
('Salmon Poke Bowl', 'Salmon, rice, and veggies with poke sauce', 'Antonio Gomez', 20, 1, 'image_url', 'lunch', 0, 'pescatarian'),
('Lamb Gyros', 'Sliced lamb with tzatziki in pita bread', 'Maria Torres', 30, 2, 'image_url', 'lunch', 0, 'non vegetarian'),
('Chickpea Curry', 'Spicy chickpea and tomato curry', 'Jose Ramos', 30, 4, 'image_url', 'lunch', 0, 'vegetarian'),
('Shrimp Tacos', 'Shrimp with slaw in soft tortilla', 'Laura Garcia', 20, 2, 'image_url', 'lunch', 0, 'pescatarian'),
('Grilled Chicken Wrap', 'Grilled chicken with veggies in a wrap', 'Daniel Fernandez', 15, 1, 'image_url', 'lunch', 0, 'non vegetarian'),
('Vegan Pasta Salad', 'Pasta with veggies and vegan dressing', 'Isabel Castro', 20, 4, 'image_url', 'lunch', 0, 'vegetarian'),
('Fish and Chips', 'Battered fish with crispy fries', 'Gabriel Jimenez', 30, 2, 'image_url', 'lunch', 0, 'pescatarian'),
('Beef Burger', 'Juicy beef burger with cheese and lettuce', 'Roberto Morales', 20, 1, 'image_url', 'lunch', 0, 'non vegetarian'),
('Roasted Veggie Salad', 'Roasted veggies on a bed of greens', 'Carmen Ruiz', 30, 2, 'image_url', 'lunch', 0, 'paleo'),
('Spicy Tuna Roll', 'Sushi roll with spicy tuna filling', 'Sergio Perez', 20, 2, 'image_url', 'lunch', 0, 'pescatarian'),
('Chicken Noodle Soup', 'Warm soup with chicken, noodles, and veggies', 'Alicia Aguilar', 40, 4, 'image_url', 'lunch', 0, 'non vegetarian'),
('Vegan Falafel Wrap', 'Falafel with hummus and veggies in a wrap', 'Elena Ortiz', 25, 2, 'image_url', 'lunch', 0, 'vegetarian'),
('Grilled Sea Bass', 'Sea bass fillet with lemon and herbs', 'Oscar Delgado', 20, 1, 'image_url', 'lunch', 0, 'pescatarian'),
('Mushroom Risotto', 'Creamy risotto with sautéed mushrooms', 'Ricardo Guerrero', 45, 4, 'image_url', 'lunch', 0, 'vegetarian'),
('Bacon Avocado Salad', 'Greens with bacon, avocado, and vinaigrette', 'Marta Vazquez', 15, 2, 'image_url', 'lunch', 0, 'paleo'),

-- Dinner
('Steak with Vegetables', 'Grilled steak with roasted vegetables', 'Chris Williams', 40, 2, 'image_url', 'dinner', 0, 'non vegetarian'),
('Stuffed Bell Peppers', 'Bell peppers stuffed with quinoa and vegetables', 'Jennifer Taylor', 45, 4, 'image_url', 'dinner', 0, 'vegetarian'),
('Grilled Tuna Steak', 'Grilled tuna steak with lemon butter', 'Robert Brown', 30, 2, 'image_url', 'dinner', 0, 'pescatarian'),
('Beef Stir Fry', 'Beef with vegetables in a savory sauce', 'Lorenzo Navarro', 30, 2, 'image_url', 'dinner', 0, 'non vegetarian'),
('Vegan Tofu Curry', 'Tofu with vegetables in a curry sauce', 'Rosa Soto', 35, 4, 'image_url', 'dinner', 0, 'vegetarian'),
('Shrimp Alfredo Pasta', 'Creamy Alfredo pasta with sautéed shrimp', 'Carlos Vargas', 30, 2, 'image_url', 'dinner', 0, 'pescatarian'),
('Grilled Steak', 'Juicy grilled steak with pepper sauce', 'Emilio Paredes', 25, 1, 'image_url', 'dinner', 0, 'non vegetarian'),
('Vegetable Lasagna', 'Layered lasagna with vegetables and cheese', 'Sofia Duarte', 60, 6, 'image_url', 'dinner', 0, 'vegetarian'),
('Seafood Paella', 'Rice dish with mixed seafood', 'Juan Cordero', 45, 4, 'image_url', 'dinner', 0, 'pescatarian'),
('BBQ Chicken', 'Grilled chicken with BBQ sauce', 'Pedro Espinosa', 40, 4, 'image_url', 'dinner', 0, 'non vegetarian'),
('Vegan Buddha Bowl', 'Quinoa, veggies, and tahini dressing', 'Valentina Rios', 25, 2, 'image_url', 'dinner', 0, 'vegetarian'),
('Cod with Lemon Butter', 'Baked cod with lemon butter sauce', 'Rodrigo Palma', 30, 2, 'image_url', 'dinner', 0, 'pescatarian'),
('Lamb Chops', 'Grilled lamb chops with mint sauce', 'Adriana Guzman', 30, 2, 'image_url', 'dinner', 0, 'non vegetarian'),
('Vegan Potato Soup', 'Creamy potato soup with almond milk', 'Miguel Mendoza', 40, 4, 'image_url', 'dinner', 0, 'vegetarian'),
('Grilled Tilapia', 'Tilapia fillet with olive oil and herbs', 'Sara Castro', 25, 2, 'image_url', 'dinner', 0, 'pescatarian'),
('Balsamic Glazed Chicken', 'Chicken with balsamic glaze', 'Daniel Molina', 30, 4, 'image_url', 'dinner', 0, 'non vegetarian'),
('Eggplant Parmesan', 'Baked eggplant with marinara and cheese', 'Carla Medina', 45, 4, 'image_url', 'dinner', 0, 'vegetarian'),
('Lobster Thermidor', 'Lobster with cheese and brandy sauce', 'Javier Rodriguez', 50, 2, 'image_url', 'dinner', 0, 'pescatarian'),
('Turkey Meatloaf', 'Homemade turkey meatloaf', 'Andrea Fernandez', 60, 6, 'image_url', 'dinner', 0, 'non vegetarian'),
('Zucchini Noodles', 'Zucchini noodles with pesto sauce', 'David Romero', 20, 2, 'image_url', 'dinner', 0, 'paleo');

-- Insert sample data into ingredients table
INSERT INTO ingredients (name, unit)
VALUES
    ('Salmon', 'fillet'),
    ('Chicken', 'breast'),
    ('Quinoa', 'cups'),
    ('Chocolate', 'grams'),
    ('Ground Beef', 'grams'),
    ('Tomato', 'medium'),
    ('Avocado', 'pieces'),
    ('Rice', 'cups'),
    ('Lettuce', 'head'),
    ('Raspberries', 'cups');

-- Insert sample data into recipes_ingredients table
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity)
VALUES
    (1, 1, 1.0),   -- Grilled Salmon - Salmon
    (1, 6, 2.0),   -- Grilled Salmon - Tomato
    (1, 7, 1.0),   -- Grilled Salmon - Avocado
    (2, 2, 2.0),   -- Chicken Tikka Masala - Chicken
    (2, 6, 1.0),   -- Chicken Tikka Masala - Tomato
    (2, 8, 2.0),   -- Chicken Tikka Masala - Rice
    (3, 3, 1.0),   -- Quinoa Salad - Quinoa
    (3, 5, 0.5),   -- Quinoa Salad - Ground Beef
    (3, 6, 1.0),   -- Quinoa Salad - Tomato
    (4, 4, 150.0), -- Chocolate Brownies - Chocolate
    (4, 8, 1.0),   -- Chocolate Brownies - Rice
    (4, 9, 1.0),   -- Chocolate Brownies - Lettuce
    (5, 5, 250.0), -- Spaghetti Bolognese - Ground Beef
    (5, 6, 2.0),   -- Spaghetti Bolognese - Tomato
    (5, 7, 0.5),   -- Spaghetti Bolognese - Avocado
    (6, 6, 2.0),   -- Greek Salad - Tomato
    (6, 9, 1.0),   -- Greek Salad - Lettuce
    (6, 10, 1.0),  -- Greek Salad - Raspberries
    (7, 1, 0.5),   -- Sushi Rolls - Salmon
    (7, 6, 1.0),   -- Sushi Rolls - Tomato
    (7, 7, 1.0),   -- Sushi Rolls - Avocado
    (8, 7, 2.0),   -- Guacamole - Avocado
    (8, 6, 1.0),   -- Guacamole - Tomato
    (8, 5, 0.5),   -- Guacamole - Ground Beef
    (9, 5, 200.0), -- Beef Stir-Fry - Ground Beef
    (9, 6, 1.5),   -- Beef Stir-Fry - Tomato
    (9, 10, 0.5);  -- Beef Stir-Fry - Raspberries

-- Insert sample data into recipe_tags table
INSERT INTO recipe_tags (recipe_id, tag_id)
VALUES
    (1, 7), -- Grilled Salmon - Pescatarian
    (2, 8), -- Chicken Tikka Masala - Asian
    (3, 6), -- Quinoa Salad - Comfort Food
    (4, 4), -- Chocolate Brownies - Dessert
    (5, 8), -- Spaghetti Bolognese - Asian
    (6, 9), -- Greek Salad - Mediterranean
    (7, 8), -- Sushi Rolls - Asian
    (8, 2), -- Guacamole - Keto
    (9, 5), -- Beef Stir-Fry - Quick & Easy
    (10, 4); -- Raspberry Sorbet - Dessert


SELECT r.name, t.name FROM recipes r
JOIN recipe_tags rt ON rt.id = r.id
JOIN tags t ON t.id = rt.tag_id;

SELECT * FROM recipes;
SELECT * FROM recipe_tags;
SELECT * FROM tags;