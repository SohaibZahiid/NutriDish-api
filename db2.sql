-- Create or use the database
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

CREATE TABLE IF NOT EXISTS favorites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    recipe_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id)
);


-- Create Nutrition Information Table
CREATE TABLE IF NOT EXISTS nutritions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    calories INT,
    protein DECIMAL(10, 2),
    carbohydrates DECIMAL(10, 2),
    fats DECIMAL(10, 2),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id)
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
('Vegetable Omelette', 'Delicious omelette filled with vegetables', 'Alice Johnson', 15, 1, 'Receta56.jpg', 'breakfast', 0, 'vegetarian'),
('Banana Pancakes', 'Fluffy banana pancakes', 'John Smith', 20, 4, 'Receta4.jpg', 'breakfast', 0, 'paleo'),
('Smoked Salmon Bagel', 'Bagel with smoked salmon and cream cheese', 'Emily Davis', 10, 1, 'Receta41.jpg', 'breakfast', 0, 'pescatarian'),
('Greek Yogurt Bowl', 'Yogurt with honey, nuts, and fruits', 'James Walker', 5, 1, 'Receta25.jpg', 'breakfast', 0, 'vegetarian'),
('Ham and Cheese Sandwich', 'Quick ham and cheese sandwich', 'Sandra Lee', 10, 1, 'Receta26.jpg', 'breakfast', 0, 'non vegetarian'),
('Berry Smoothie', 'Healthy berry smoothie', 'Brian Adams', 5, 1, 'Receta8.jpg', 'breakfast', 0, 'paleo'),
('Mushroom Scramble', 'Mushroom and egg scramble', 'Laura Clark', 10, 2, 'Receta31.jpg', 'breakfast', 0, 'vegetarian'),
('Bacon and Eggs', 'Classic bacon and eggs breakfast', 'Kevin Miller', 15, 1, 'Receta1.jpg', 'breakfast', 0, 'non vegetarian'),
('Avocado Toast', 'Whole grain toast with mashed avocado', 'Karen Wilson', 10, 1, 'Receta57.jpg', 'breakfast', 0, 'vegetarian'),
('Salmon Frittata', 'Baked frittata with smoked salmon', 'Samuel Lewis', 20, 4, 'Receta34.jpg', 'breakfast', 0, 'pescatarian'),
('Chicken Sausage Skillet', 'Skillet with chicken sausage and vegetables', 'Nancy Harris', 15, 2, 'Receta11.jpg', 'breakfast', 0, 'non vegetarian'),
('Vegan Oatmeal', 'Creamy oatmeal with almond milk and berries', 'Peter Thompson', 15, 2, 'Receta49.jpg', 'breakfast', 0, 'vegetarian'),
('Shrimp and Grits', 'Southern style shrimp and grits', 'Rebecca White', 30, 4, 'Receta38.jpg', 'breakfast', 0, 'pescatarian'),
('Egg White Muffins', 'Baked egg white muffins with spinach', 'Kathleen Anderson', 20, 4, 'Receta18.jpg', 'breakfast', 0, 'vegetarian'),
('Pork Breakfast Burrito', 'Breakfast burrito with pork sausage', 'Timothy Taylor', 20, 2, 'Receta32.jpg', 'breakfast', 0, 'non vegetarian'),
('Chia Seed Pudding', 'Healthy chia seed pudding with fruit', 'Melissa Hall', 120, 4, 'Receta13.jpg', 'breakfast', 0, 'paleo'),
('Tofu Scramble', 'Vegan tofu scramble with vegetables', 'George Young', 15, 2, 'Receta45.jpg', 'breakfast', 0, 'vegetarian'),
('Grilled Mackerel', 'Grilled mackerel with lemon', 'Patricia Allen', 15, 1, 'Receta58.jpg', 'breakfast', 0, 'pescatarian'),
('Beef Breakfast Sausage', 'Homemade beef breakfast sausage', 'Joseph Wright', 20, 4, 'Receta5.jpg', 'breakfast', 0, 'non vegetarian'),
('Coconut Pancakes', 'Fluffy coconut flour pancakes', 'Angela Scott', 20, 4, 'Receta15.jpg', 'breakfast', 0, 'paleo'),


-- Lunch
('Grilled Chicken Salad', 'Healthy salad with grilled chicken', 'Michael Johnson', 20, 2, 'Receta20.jpg', 'lunch', 0, 'non vegetarian'),
('Vegan Burger', 'Delicious vegan burger with fries', 'Sara Lee', 30, 1, 'Receta47.jpg', 'lunch', 0, 'vegetarian'),
('Shrimp Salad', 'Fresh salad with shrimp and avocado', 'David Kim', 15, 2, 'Receta39.jpg', 'lunch', 0, 'pescatarian'),
('Chicken Caesar Salad', 'Crispy romaine with chicken and Caesar dressing', 'Luisa Hernandez', 15, 1, 'Receta9.jpg', 'lunch', 0, 'non vegetarian'),
('Vegetable Stir Fry', 'Mixed vegetable stir fry with soy sauce', 'Diego Sanchez', 20, 2, 'Receta54.jpg', 'lunch', 0, 'vegetarian'),
('Salmon Poke Bowl', 'Salmon, rice, and veggies with poke sauce', 'Antonio Gomez', 20, 1, 'Receta35.jpg', 'lunch', 0, 'pescatarian'),
('Lamb Gyros', 'Sliced lamb with tzatziki in pita bread', 'Maria Torres', 30, 2, 'Receta28.jpg', 'lunch', 0, 'non vegetarian'),
('Chickpea Curry', 'Spicy chickpea and tomato curry', 'Jose Ramos', 30, 4, 'Receta12.jpg', 'lunch', 0, 'vegetarian'),
('Shrimp Tacos', 'Shrimp with slaw in soft tortilla', 'Laura Garcia', 20, 2, 'Receta40.jpg', 'lunch', 0, 'pescatarian'),
('Grilled Chicken Wrap', 'Grilled chicken with veggies in a wrap', 'Daniel Fernandez', 15, 1, 'Receta21.jpg', 'lunch', 0, 'non vegetarian'),
('Vegan Pasta Salad', 'Pasta with veggies and vegan dressing', 'Isabel Castro', 20, 4, 'Receta50.jpg', 'lunch', 0, 'vegetarian'),
('Fish and Chips', 'Battered fish with crispy fries', 'Gabriel Jimenez', 30, 2, 'Receta19.jpg', 'lunch', 0, 'pescatarian'),
('Beef Burger', 'Juicy beef burger with cheese and lettuce', 'Roberto Morales', 20, 1, 'Receta6.jpg', 'lunch', 0, 'non vegetarian'),
('Roasted Veggie Salad', 'Roasted veggies on a bed of greens', 'Carmen Ruiz', 30, 2, 'Receta33.jpg', 'lunch', 0, 'paleo'),
('Spicy Tuna Roll', 'Sushi roll with spicy tuna filling', 'Sergio Perez', 20, 2, 'Receta42.jpg', 'lunch', 0, 'pescatarian'),
('Chicken Noodle Soup', 'Warm soup with chicken, noodles, and veggies', 'Alicia Aguilar', 40, 4, 'Receta10.jpg', 'lunch', 0, 'non vegetarian'),
('Vegan Falafel Wrap', 'Falafel with hummus and veggies in a wrap', 'Elena Ortiz', 25, 2, 'Receta48.jpg', 'lunch', 0, 'vegetarian'),
('Grilled Sea Bass', 'Sea bass fillet with lemon and herbs', 'Oscar Delgado', 20, 1, 'Receta22.jpg', 'lunch', 0, 'pescatarian'),
('Mushroom Risotto', 'Creamy risotto with sautéed mushrooms', 'Ricardo Guerrero', 45, 4, 'Receta30.jpg', 'lunch', 0, 'vegetarian'),
('Bacon Avocado Salad', 'Greens with bacon, avocado, and vinaigrette', 'Marta Vazquez', 15, 2, 'Receta2.jpg', 'lunch', 0, 'paleo'),

-- Dinner
('Steak with Vegetables', 'Grilled steak with roasted vegetables', 'Chris Williams', 40, 2, 'Receta43.jpg', 'dinner', 0, 'non vegetarian'),
('Stuffed Bell Peppers', 'Bell peppers stuffed with quinoa and vegetables', 'Jennifer Taylor', 45, 4, 'Receta44.jpg', 'dinner', 0, 'vegetarian'),
('Grilled Tuna Steak', 'Grilled tuna steak with lemon butter', 'Robert Brown', 30, 2, 'Receta24.jpg', 'dinner', 0, 'pescatarian'),
('Beef Stir Fry', 'Beef with vegetables in a savory sauce', 'Lorenzo Navarro', 30, 2, 'Receta7.jpg', 'dinner', 0, 'non vegetarian'),
('Vegan Tofu Curry', 'Tofu with vegetables in a curry sauce', 'Rosa Soto', 35, 4, 'Receta52.jpg', 'dinner', 0, 'vegetarian'),
('Shrimp Alfredo Pasta', 'Creamy Alfredo pasta with sautéed shrimp', 'Carlos Vargas', 30, 2, 'Receta37.jpg', 'dinner', 0, 'pescatarian'),
('Grilled Steak', 'Juicy grilled steak with pepper sauce', 'Emilio Paredes', 25, 1, 'Receta23.jpg', 'dinner', 1, 'non vegetarian'),
('Vegetable Lasagna', 'Layered lasagna with vegetables and cheese', 'Sofia Duarte', 60, 6, 'Receta53.jpg', 'dinner', 1, 'vegetarian'),
('Seafood Paella', 'Rice dish with mixed seafood', 'Juan Cordero', 45, 4, 'Receta36.jpg', 'dinner', 0, 'pescatarian'),
('BBQ Chicken', 'Grilled chicken with BBQ sauce', 'Pedro Espinosa', 40, 4, 'Receta59.jpg', 'dinner', 0, 'non vegetarian'),
('Vegan Buddha Bowl', 'Quinoa, veggies, and tahini dressing', 'Valentina Rios', 25, 2, 'Receta46.jpg', 'dinner', 1, 'vegetarian'),
('Cod with Lemon Butter', 'Baked cod with lemon butter sauce', 'Rodrigo Palma', 30, 2, 'Receta16.jpg', 'dinner', 1, 'pescatarian'),
('Lamb Chops', 'Grilled lamb chops with mint sauce', 'Adriana Guzman', 30, 2, 'Receta27.jpg', 'dinner', 0, 'non vegetarian'),
('Vegan Potato Soup', 'Creamy potato soup with almond milk', 'Miguel Mendoza', 40, 4, 'Receta51.jpg', 'dinner', 0, 'vegetarian'),
('Grilled Tilapia', 'Tilapia fillet with olive oil and herbs', 'Sara Castro', 25, 2, 'Receta60.jpg', 'dinner', 0, 'pescatarian'),
('Balsamic Glazed Chicken', 'Chicken with balsamic glaze', 'Daniel Molina', 30, 4, 'Receta3.jpg', 'dinner', 1, 'non vegetarian'),
('Eggplant Parmesan', 'Baked eggplant with marinara and cheese', 'Carla Medina', 45, 4, 'Receta17.jpg', 'dinner', 0, 'vegetarian'),
('Lobster Thermidor', 'Lobster with cheese and brandy sauce', 'Javier Rodriguez', 50, 2, 'Receta29.jpg', 'dinner', 0, 'pescatarian'),
('Turkey Meatloaf', 'Homemade turkey meatloaf', 'Andrea Fernandez', 60, 6, 'Receta61.jpg', 'dinner', 0, 'non vegetarian'),
('Zucchini Noodles', 'Zucchini noodles with pesto sauce', 'David Romero', 20, 2, 'Receta55.jpg', 'dinner', 0, 'paleo');


-- Insert nutrition information for breakfast recipes
INSERT INTO nutritions (recipe_id, calories, protein, carbohydrates, fats)
VALUES
(1, 300, 15.0, 12.0, 20.0),    -- Vegetable Omelette
(2, 350, 6.0, 40.0, 18.0),     -- Banana Pancakes
(3, 250, 10.0, 25.0, 15.0),    -- Smoked Salmon Bagel
(4, 180, 8.0, 20.0, 8.0),
(5, 300, 14.0, 28.0, 15.0),   -- Ham and Cheese Sandwich
(6, 220, 5.0, 40.0, 4.0),     -- Berry Smoothie
(7, 150, 7.0, 5.0, 10.0),     -- Mushroom Scramble
(8, 250, 12.0, 15.0, 18.0),   -- Bacon and Eggs
(9, 180, 4.0, 20.0, 10.0),    -- Avocado Toast
(10, 280, 20.0, 15.0, 18.0),  -- Salmon Frittata
(11, 300, 16.0, 25.0, 15.0),  -- Chicken Sausage Skillet
(12, 220, 8.0, 40.0, 5.0),    -- Vegan Oatmeal
(13, 350, 18.0, 30.0, 18.0),  -- Shrimp and Grits
(14, 140, 10.0, 15.0, 6.0),   -- Egg White Muffins
(15, 350, 14.0, 30.0, 20.0),  -- Pork Breakfast Burrito
(16, 200, 8.0, 25.0, 8.0),    -- Chia Seed Pudding
(17, 280, 12.0, 20.0, 18.0),  -- Tofu Scramble
(18, 180, 20.0, 5.0, 9.0),    -- Grilled Mackerel
(19, 350, 16.0, 30.0, 20.0),  -- Beef Breakfast Sausage
(20, 220, 10.0, 25.0, 8.0);   -- Coconut Pancakes

-- Insert nutrition information for lunch recipes
INSERT INTO nutritions (recipe_id, calories, protein, carbohydrates, fats)
VALUES
(21, 400, 25.0, 20.0, 22.0),   -- Grilled Chicken Salad
(22, 350, 15.0, 40.0, 16.0),   -- Vegan Burger
(23, 200, 10.0, 15.0, 12.0),   -- Shrimp Salad
(24, 320, 28.0, 15.0, 16.0),  -- Grilled Chicken Salad
(25, 420, 18.0, 40.0, 20.0),  -- Vegan Burger
(26, 280, 15.0, 20.0, 18.0),  -- Shrimp Salad
(27, 380, 22.0, 15.0, 25.0),  -- Chicken Caesar Salad
(28, 250, 8.0, 35.0, 10.0),   -- Vegetable Stir Fry
(29, 400, 20.0, 40.0, 20.0),  -- Salmon Poke Bowl
(30, 450, 28.0, 25.0, 30.0),  -- Lamb Gyros
(31, 300, 10.0, 35.0, 15.0),  -- Chickpea Curry
(32, 280, 14.0, 25.0, 15.0),  -- Shrimp Tacos
(33, 330, 18.0, 30.0, 15.0),  -- Grilled Chicken Wrap
(34, 280, 10.0, 35.0, 12.0),  -- Vegan Pasta Salad
(35, 500, 22.0, 45.0, 25.0),  -- Fish and Chips
(36, 450, 25.0, 30.0, 28.0),  -- Beef Burger
(37, 300, 12.0, 35.0, 12.0),  -- Roasted Veggie Salad
(38, 320, 16.0, 40.0, 15.0),  -- Spicy Tuna Roll
(39, 350, 18.0, 25.0, 20.0),  -- Chicken Noodle Soup
(40, 280, 12.0, 30.0, 14.0),  -- Vegan Falafel Wrap
(41, 280, 22.0, 25.0, 12.0),  -- Grilled Sea Bass
(42, 380, 15.0, 40.0, 18.0),  -- Mushroom Risotto
(43, 330, 18.0, 20.0, 22.0);  -- Bacon Avocado Salad

-- Insert nutrition information for dinner recipes
INSERT INTO nutritions (recipe_id, calories, protein, carbohydrates, fats)
VALUES
(44, 500, 28.0, 20.0, 32.0),  -- Steak with Vegetables
(45, 300, 12.0, 40.0, 10.0),  -- Stuffed Bell Peppers
(46, 350, 30.0, 15.0, 18.0),  -- Grilled Tuna Steak
(47, 400, 18.0, 35.0, 25.0),  -- Beef Stir Fry
(48, 280, 20.0, 25.0, 14.0),  -- Vegan Tofu Curry
(49, 450, 20.0, 30.0, 28.0),  -- Shrimp Alfredo Pasta
(50, 550, 30.0, 35.0, 32.0),  -- Grilled Steak
(51, 400, 18.0, 30.0, 22.0),  -- Vegetable Lasagna
(52, 600, 35.0, 45.0, 28.0),  -- Seafood Paella
(53, 420, 25.0, 25.0, 28.0),  -- BBQ Chicken
(54, 380, 18.0, 40.0, 18.0),  -- Vegan Buddha Bowl
(55, 350, 30.0, 10.0, 20.0),  -- Cod with Lemon Butter
(56, 480, 30.0, 25.0, 30.0),  -- Lamb Chops
(57, 320, 12.0, 30.0, 18.0),  -- Vegan Potato Soup
(58, 420, 20.0, 35.0, 22.0),  -- Grilled Tilapia
(59, 350, 25.0, 25.0, 18.0),  -- Balsamic Glazed Chicken
(60, 280, 15.0, 30.0, 14.0),  -- Eggplant Parmesan
(61, 500, 35.0, 15.0, 32.0);  -- Lobster Thermidor





-- Insertar ingredientes de Vegetable Omelette
INSERT IGNORE INTO ingredients (name, unit)
VALUES
('large eggs', 'unit'),
('chopped fresh spinach', 'cup'),
('sliced mushrooms', 'cup'),
('chopped red pepper', 'cup'),
('chopped onion', 'cup'),
('chopped tomato', 'cup'),
('Salt and pepper', 'to taste'),
('olive oil or butter', 'tablespoon');

-- Insert ingredients for Banana Pancakes
INSERT IGNORE INTO ingredients (name, unit)
VALUES
('ripe banana', 'unit'),
('whole wheat flour', 'cup'),
('milk', 'cup'),
('baking powder', 'teaspoon'),
('salt', 'pinch'),
('oil or butter for frying', 'tablespoon'),
('Honey or maple syrup for serving', 'optional');

-- Ingredients for Smoked Salmon Bagel
INSERT IGNORE INTO ingredients (name, unit) VALUES
('Bagel', 'unit'),
('Smoked salmon', 'gram'),
('Cream cheese', 'tablespoon'),
('Red onion', 'slices'),
('Fresh dill', 'sprig'),
('Capers', 'teaspoon'),
('Lemon wedge', 'unit'),
('Black pepper', 'to taste');

-- Ingredients for Greek Yogurt Bowl
INSERT IGNORE INTO ingredients (name, unit) VALUES
('Greek yogurt', 'cup'),
('Honey or maple syrup', 'tablespoon'),
('Fresh berries', 'cup'),
('Granola', 'tablespoon'),
('Chia seeds', 'teaspoon'),
('Sliced almonds', 'tablespoon');

-- Ingredients for Ham and Cheese Sandwich
INSERT IGNORE INTO ingredients (name, unit) VALUES
('Bread slices', 'unit'),
('Ham slices', 'unit'),
('Cheese slices', 'unit'),
('Lettuce', 'leaves'),
('Tomato', 'slices'),
('Mayonnaise or mustard', 'tablespoon'),
('Butter', 'tablespoon');

-- Ingredients for Grilled Chicken Salad
INSERT IGNORE INTO ingredients (name, unit)
VALUES
('Boneless chicken breasts', 'unit'),
('Olive oil', 'tablespoon'),
('Salt and pepper', 'to taste'),
('Mixed salad greens', 'cup'),
('Cherry tomatoes', 'cup'),
('Cucumber slices', 'cup'),
('Red onion slices', 'cup'),
('Feta cheese', 'cup'),
('Balsamic vinaigrette', 'tablespoon');

-- Ingredients for Vegan Burger:
INSERT IGNORE INTO ingredients (name, unit)
VALUES
('Black beans (canned)', 'can'),
('Bread crumbs', 'cup'),
('Olive oil', 'tablespoon'),
('Garlic cloves (minced)', 'clove'),
('Salt and pepper', 'to taste'),
('Cumin', 'teaspoon'),
('Vegan burger buns', 'unit'),
('Lettuce', 'leaf'),
('Tomato slices', 'slice'),
('Onion slices', 'slice'),
('Vegan mayo', 'tablespoon'),
('Ketchup', 'tablespoon');

-- Ingredients for Shrimp Salad
INSERT IGNORE INTO ingredients (name, unit)
VALUES
('Shrimps (peeled and deveined)', 'unit'),
('Olive oil', 'tablespoon'),
('Salt and pepper', 'to taste'),
('Mixed salad greens', 'cup'),
('Cherry tomatoes', 'cup'),
('Cucumber slices', 'cup'),
('Red onion slices', 'cup'),
('Lemon juice', 'tablespoon'),
('Fresh dill (chopped)', 'tablespoon');

-- Ingredients for Chicken Caesar Salad:
INSERT IGNORE INTO ingredients (name, unit)
VALUES
('Boneless chicken breasts', 'unit'),
('Olive oil', 'tablespoon'),
('Salt and pepper', 'to taste'),
('Romaine lettuce (chopped)', 'cup'),
('Croutons', 'cup'),
('Grated parmesan cheese', 'tablespoon'),
('Caesar dressing', 'tablespoon'),
('Lemon wedges', 'wedge');

-- Ingredients for Steak with Vegetables:
INSERT IGNORE INTO ingredients (name, unit)
VALUES
('Beef steak', 'unit'),
('Olive oil', 'tablespoon'),
('Salt and pepper', 'to taste'),
('Garlic cloves (minced)', 'clove'),
('Broccoli florets', 'cup'),
('Carrots (sliced)', 'cup'),
('Green beans', 'cup'),
('Red bell pepper (sliced)', 'cup'),
('Onion (sliced)', 'cup'),
('Soy sauce', 'tablespoon');

-- Ingredients for Stuffed Bell Peppers:
INSERT IGNORE INTO ingredients (name, unit)
VALUES
('Bell peppers', 'unit'),
('Ground beef or turkey', 'pound'),
('Cooked rice', 'cup'),
('Olive oil', 'tablespoon'),
('Onion (chopped)', 'cup'),
('Garlic cloves (minced)', 'clove'),
('Tomato sauce', 'cup'),
('Salt and pepper', 'to taste'),
('Grated cheddar cheese', 'cup'),
('Fresh parsley (chopped)', 'tablespoon');

-- Ingredients for Grilled Tuna Steak:
INSERT IGNORE INTO ingredients (name, unit)
VALUES
('Tuna steaks', 'unit'),
('Olive oil', 'tablespoon'),
('Lemon juice', 'tablespoon'),
('Garlic cloves (minced)', 'clove'),
('Soy sauce', 'tablespoon'),
('Fresh ginger (grated)', 'teaspoon'),
('Salt and pepper', 'to taste'),
('Sesame seeds', 'teaspoon'),
('Fresh parsley or cilantro (chopped)', 'tablespoon');

-- Ingredients for Beef Stir Fry:
INSERT IGNORE INTO ingredients (name, unit)
VALUES
('Beef strips', 'pound'),
('Olive oil', 'tablespoon'),
('Soy sauce', 'tablespoon'),
('Garlic cloves (minced)', 'clove'),
('Fresh ginger (grated)', 'teaspoon'),
('Broccoli florets', 'cup'),
('Red bell pepper (sliced)', 'cup'),
('Carrots (sliced)', 'cup'),
('Snow peas', 'cup'),
('Green onions (sliced)', 'stalk'),
('Sesame oil', 'teaspoon'),
('Salt and pepper', 'to taste');

-- Ingredients for Vegan Tofu Curry:
INSERT IGNORE INTO ingredients (name, unit)
VALUES
('Firm tofu (cubed)', 'cup'),
('Coconut milk', 'can'),
('Curry powder', 'tablespoon'),
('Turmeric', 'teaspoon'),
('Olive oil or coconut oil', 'tablespoon'),
('Garlic cloves (minced)', 'clove'),
('Fresh ginger (grated)', 'teaspoon'),
('Red bell pepper (sliced)', 'cup'),
('Carrots (sliced)', 'cup'),
('Broccoli florets', 'cup'),
('Snow peas', 'cup'),
('Red onion (sliced)', 'cup'),
('Fresh cilantro', 'tablespoon'),
('Salt and pepper', 'to taste');

SELECT * FROM ingredients;

-- Associate ingredients for Vegetable Omelette
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(1, (SELECT id FROM ingredients WHERE name = 'large eggs'), 2),
(1, (SELECT id FROM ingredients WHERE name = 'chopped fresh spinach'), 0.25),
(1, (SELECT id FROM ingredients WHERE name = 'sliced mushrooms'), 0.25),
(1, (SELECT id FROM ingredients WHERE name = 'chopped red pepper'), 0.25),
(1, (SELECT id FROM ingredients WHERE name = 'chopped onion'), 0.25),
(1, (SELECT id FROM ingredients WHERE name = 'chopped tomato'), 0.25),
(1, (SELECT id FROM ingredients WHERE name = 'olive oil or butter'), 1);
-- Consider 'Salt and pepper' as an ingredient without a specific amount.

-- Associate ingredients for Banana Pancakes
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(2, (SELECT id FROM ingredients WHERE name = 'ripe banana'), 1),
(2, (SELECT id FROM ingredients WHERE name = 'large eggs'), 2),
(2, (SELECT id FROM ingredients WHERE name = 'whole wheat flour'), 1),
(2, (SELECT id FROM ingredients WHERE name = 'milk'), 0.5),
(2, (SELECT id FROM ingredients WHERE name = 'baking powder'), 1),
(2, (SELECT id FROM ingredients WHERE name = 'oil or butter for frying'), 1);
-- We omitted 'Honey or maple syrup for serving' since it's optional.

-- Asociating ingredients for Smoked Salmon Bagel
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity) VALUES
(3, (SELECT id FROM ingredients WHERE name = 'Bagel'), 1),
(3, (SELECT id FROM ingredients WHERE name = 'Smoked salmon'), 100),
(3, (SELECT id FROM ingredients WHERE name = 'Cream cheese'), 2),
(3, (SELECT id FROM ingredients WHERE name = 'Red onion'), 2),
(3, (SELECT id FROM ingredients WHERE name = 'Fresh dill'), 1),
(3, (SELECT id FROM ingredients WHERE name = 'Capers'), 1),
(3, (SELECT id FROM ingredients WHERE name = 'Lemon wedge'), 1),
(3, (SELECT id FROM ingredients WHERE name = 'Black pepper'), 1);

-- Asociating ingredients for Greek Yogurt Bowl
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity) VALUES
(4, (SELECT id FROM ingredients WHERE name = 'Greek yogurt'), 1),
(4, (SELECT id FROM ingredients WHERE name = 'Honey or maple syrup'), 1),
(4, (SELECT id FROM ingredients WHERE name = 'Fresh berries'), 1),
(4, (SELECT id FROM ingredients WHERE name = 'Granola'), 1),
(4, (SELECT id FROM ingredients WHERE name = 'Chia seeds'), 1),
(4, (SELECT id FROM ingredients WHERE name = 'Sliced almonds'), 1);

-- Asociating ingredients for Ham and Cheese Sandwich
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity) VALUES
(5, (SELECT id FROM ingredients WHERE name = 'Bread slices'), 2),
(5, (SELECT id FROM ingredients WHERE name = 'Ham slices'), 2),
(5, (SELECT id FROM ingredients WHERE name = 'Cheese slices'), 1),
(5, (SELECT id FROM ingredients WHERE name = 'Lettuce'), 2),
(5, (SELECT id FROM ingredients WHERE name = 'Tomato'), 2),
(5, (SELECT id FROM ingredients WHERE name = 'Mayonnaise or mustard'), 1),
(5, (SELECT id FROM ingredients WHERE name = 'Butter'), 1);

-- Asociating ingredients Grilled Chicken Salad:
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(21, (SELECT id FROM ingredients WHERE name = 'Boneless chicken breasts'), 1),
(21, (SELECT id FROM ingredients WHERE name = 'Olive oil'), 1),
(21, (SELECT id FROM ingredients WHERE name = 'Mixed salad greens'), 2),
(21, (SELECT id FROM ingredients WHERE name = 'Cherry tomatoes'), 0.5),
(21, (SELECT id FROM ingredients WHERE name = 'Cucumber slices'), 1),
(21, (SELECT id FROM ingredients WHERE name = 'Red onion slices'), 0.5),
(21, (SELECT id FROM ingredients WHERE name = 'Feta cheese'), 0.25),
(21, (SELECT id FROM ingredients WHERE name = 'Balsamic vinaigrette'), 2);
-- Consider 'Salt and pepper' as an ingredient without a specific amount.

-- Asociating ingredients vegan burger
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(22, (SELECT id FROM ingredients WHERE name = 'Black beans (canned)'), 1),
(22, (SELECT id FROM ingredients WHERE name = 'Bread crumbs'), 0.5),
(22, (SELECT id FROM ingredients WHERE name = 'Olive oil'), 1),
(22, (SELECT id FROM ingredients WHERE name = 'Garlic cloves (minced)'), 2),
(22, (SELECT id FROM ingredients WHERE name = 'Cumin'), 0.5),
(22, (SELECT id FROM ingredients WHERE name = 'Vegan burger buns'), 1),
(22, (SELECT id FROM ingredients WHERE name = 'Lettuce'), 1),
(22, (SELECT id FROM ingredients WHERE name = 'Tomato slices'), 2),
(22, (SELECT id FROM ingredients WHERE name = 'Onion slices'), 2);
-- Consider 'Salt and pepper', 'Vegan mayo', and 'Ketchup' as ingredients without a specific amount.

-- Asociating ingredients shrimp salad
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(23, (SELECT id FROM ingredients WHERE name = 'Shrimps (peeled and deveined)'), 8),
(23, (SELECT id FROM ingredients WHERE name = 'Olive oil'), 1),
(23, (SELECT id FROM ingredients WHERE name = 'Mixed salad greens'), 2),
(23, (SELECT id FROM ingredients WHERE name = 'Cherry tomatoes'), 0.5),
(23, (SELECT id FROM ingredients WHERE name = 'Cucumber slices'), 1),
(23, (SELECT id FROM ingredients WHERE name = 'Red onion slices'), 0.5),
(23, (SELECT id FROM ingredients WHERE name = 'Lemon juice'), 1),
(23, (SELECT id FROM ingredients WHERE name = 'Fresh dill (chopped)'), 1);
-- Consider 'Salt and pepper' as an ingredi

-- Associate ingredients with Chicken Caesar Salad:
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(24, (SELECT id FROM ingredients WHERE name = 'Boneless chicken breasts'), 1),
(24, (SELECT id FROM ingredients WHERE name = 'Olive oil'), 1),
(24, (SELECT id FROM ingredients WHERE name = 'Romaine lettuce (chopped)'), 2),
(24, (SELECT id FROM ingredients WHERE name = 'Croutons'), 1),
(24, (SELECT id FROM ingredients WHERE name = 'Grated parmesan cheese'), 1),
(24, (SELECT id FROM ingredients WHERE name = 'Caesar dressing'), 2),
(24, (SELECT id FROM ingredients WHERE name = 'Lemon wedges'), 2);
-- Consider 'Salt and pepper' as an ingredient without a specific amount.

-- Associate ingredients with Steak with Vegetables:
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(41, (SELECT id FROM ingredients WHERE name = 'Beef steak'), 1),
(41, (SELECT id FROM ingredients WHERE name = 'Olive oil'), 2),
(41, (SELECT id FROM ingredients WHERE name = 'Garlic cloves (minced)'), 2),
(41, (SELECT id FROM ingredients WHERE name = 'Broccoli florets'), 1),
(41, (SELECT id FROM ingredients WHERE name = 'Carrots (sliced)'), 1),
(41, (SELECT id FROM ingredients WHERE name = 'Green beans'), 1),
(41, (SELECT id FROM ingredients WHERE name = 'Red bell pepper (sliced)'), 0.5),
(41, (SELECT id FROM ingredients WHERE name = 'Onion (sliced)'), 0.5),
(41, (SELECT id FROM ingredients WHERE name = 'Soy sauce'), 2);
-- Consider 'Salt and pepper' as an ingredient without a specific amount.

-- Associate ingredients with Stuffed Bell Peppers:
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(42, (SELECT id FROM ingredients WHERE name = 'Bell peppers'), 4),
(42, (SELECT id FROM ingredients WHERE name = 'Ground beef or turkey'), 0.5),
(42, (SELECT id FROM ingredients WHERE name = 'Cooked rice'), 2),
(42, (SELECT id FROM ingredients WHERE name = 'Olive oil'), 1),
(42, (SELECT id FROM ingredients WHERE name = 'Onion (chopped)'), 1),
(42, (SELECT id FROM ingredients WHERE name = 'Garlic cloves (minced)'), 2),
(42, (SELECT id FROM ingredients WHERE name = 'Tomato sauce'), 1),
(42, (SELECT id FROM ingredients WHERE name = 'Grated cheddar cheese'), 1),
(42, (SELECT id FROM ingredients WHERE name = 'Fresh parsley (chopped)'), 1);
-- Consider 'Salt and pepper' as an ingredient without a specific amount.

-- Associate ingredients with Grilled Tuna Steak:
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(43, (SELECT id FROM ingredients WHERE name = 'Tuna steaks'), 2),
(43, (SELECT id FROM ingredients WHERE name = 'Olive oil'), 2),
(43, (SELECT id FROM ingredients WHERE name = 'Lemon juice'), 1),
(43, (SELECT id FROM ingredients WHERE name = 'Garlic cloves (minced)'), 2),
(43, (SELECT id FROM ingredients WHERE name = 'Soy sauce'), 1),
(43, (SELECT id FROM ingredients WHERE name = 'Fresh ginger (grated)'), 1),
(43, (SELECT id FROM ingredients WHERE name = 'Sesame seeds'), 1),
(43, (SELECT id FROM ingredients WHERE name = 'Fresh parsley or cilantro (chopped)'), 1);
-- Consider 'Salt and pepper' as an ingredient without a specific amount.

-- Associate ingredients with Beef Stir Fry:
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(44, (SELECT id FROM ingredients WHERE name = 'Beef strips'), 1),
(44, (SELECT id FROM ingredients WHERE name = 'Olive oil'), 2),
(44, (SELECT id FROM ingredients WHERE name = 'Soy sauce'), 2),
(44, (SELECT id FROM ingredients WHERE name = 'Garlic cloves (minced)'), 2),
(44, (SELECT id FROM ingredients WHERE name = 'Fresh ginger (grated)'), 1),
(44, (SELECT id FROM ingredients WHERE name = 'Broccoli florets'), 1),
(44, (SELECT id FROM ingredients WHERE name = 'Red bell pepper (sliced)'), 1),
(44, (SELECT id FROM ingredients WHERE name = 'Carrots (sliced)'), 1),
(44, (SELECT id FROM ingredients WHERE name = 'Snow peas'), 0.5),
(44, (SELECT id FROM ingredients WHERE name = 'Green onions (sliced)'), 2),
(44, (SELECT id FROM ingredients WHERE name = 'Sesame oil'), 1);
-- Consider 'Salt and pepper' as an ingredient without a specific amount.

-- Associate ingredients with Vegan Tofu Curry:
INSERT INTO recipes_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(45, (SELECT id FROM ingredients WHERE name = 'Firm tofu (cubed)'), 2),
(45, (SELECT id FROM ingredients WHERE name = 'Coconut milk'), 1),
(45, (SELECT id FROM ingredients WHERE name = 'Curry powder'), 1),
(45, (SELECT id FROM ingredients WHERE name = 'Turmeric'), 0.5),
(45, (SELECT id FROM ingredients WHERE name = 'Olive oil or coconut oil'), 2),
(45, (SELECT id FROM ingredients WHERE name = 'Garlic cloves (minced)'), 2),
(45, (SELECT id FROM ingredients WHERE name = 'Fresh ginger (grated)'), 1),
(45, (SELECT id FROM ingredients WHERE name = 'Red bell pepper (sliced)'), 1),
(45, (SELECT id FROM ingredients WHERE name = 'Carrots (sliced)'), 1),
(45, (SELECT id FROM ingredients WHERE name = 'Broccoli florets'), 1),
(45, (SELECT id FROM ingredients WHERE name = 'Snow peas'), 0.5),
(45, (SELECT id FROM ingredients WHERE name = 'Red onion (sliced)'), 0.5),
(45, (SELECT id FROM ingredients WHERE name = 'Fresh cilantro'), 1);
-- Consider 'Salt and pepper' as an ingredient without a specific amount.


ALTER TABLE recipes ADD instructions TEXT;

-- Instructions for Vegetable Omelette
UPDATE recipes
SET instructions = 'In a bowl, beat the eggs and season with salt and pepper. Heat the oil or butter in a pan over medium heat. Add the vegetables and sauté until tender. Pour the beaten eggs over the vegetables in the pan. Cook until the egg is almost set, then fold the omelette in half. Cook for an additional minute on each side or until fully set. Serve hot.'
WHERE id = 1;

-- Instructions for Banana Pancakes
UPDATE recipes
SET instructions = 'In a bowl, mash the banana with a fork. Add the eggs and mix well. Incorporate the flour, baking powder, and salt. Mix until you get a homogeneous batter. Gradually add the milk to achieve the right consistency for pancakes. Heat the oil or butter in a pan over medium heat. Pour portions of the batter into the pan and cook until bubbles appear on the surface. Then, flip and cook until golden brown. Serve hot with honey or maple syrup.'
WHERE id = 2;

-- Instructions for Smoked Salmon Bagel
UPDATE recipes
SET instructions = '1. Slice the bagel in half and toast it until golden brown. 2. Spread a generous amount of cream cheese on each half. 3. Lay slices of smoked salmon over the cream cheese. 4. Sprinkle some capers and add some slices of red onion. 5. Garnish with fresh dill and a squeeze of lemon. 6. Season with black pepper to taste. 7. Serve immediately.'
WHERE id = 3;

-- Instructions for Greek Yogurt Bowl
UPDATE recipes
SET instructions = '1. Pour Greek yogurt into a bowl. 2. Drizzle honey or maple syrup over the yogurt. 3. Top with a mix of fresh berries. 4. Sprinkle granola over the berries. 5. Add a sprinkle of chia seeds and sliced almonds for crunch. 6. Mix slightly if desired or enjoy layered.'
WHERE id = 4;

-- Instructions for Ham and Cheese Sandwich
UPDATE recipes
SET instructions = '1. Lay out two slices of bread on a clean surface. 2. Spread mayonnaise or mustard on one slice. 3. Layer ham and cheese slices on the other slice. 4. Add slices of tomato and lettuce. 5. Close the sandwich by placing the slices of bread together. 6. Optionally, butter the outside of the sandwich and grill until golden brown and the cheese has melted. 7. Serve with a side of chips or a salad.'
WHERE id = 5;

-- Instructions Grilled Chicken Salad:
UPDATE recipes
SET instructions = 'Preheat the grill on medium-high heat. Rub the chicken breasts with olive oil, salt, and pepper. Grill the chicken for 5-7 minutes on each side or until fully cooked. Let the chicken rest for a few minutes before slicing. In a large bowl, mix the salad greens, cherry tomatoes, cucumber, and red onion. Add the sliced chicken on top. Sprinkle with feta cheese if desired. Drizzle with balsamic vinaigrette and serve.'
WHERE id = 21;

-- Instructions vegan burger
UPDATE recipes
SET instructions = 'Drain and rinse the black beans. Mash them in a bowl until mostly smooth. Add bread crumbs, minced garlic, salt, pepper, and cumin to the mashed beans and mix well. Form the mixture into burger patties. Heat olive oil in a pan over medium heat. Cook the patties for 4-5 minutes on each side or until they are crispy and heated through. Toast the vegan burger buns. Assemble the burgers with lettuce, tomato slices, onion slices, and vegan mayo or ketchup if desired.'
WHERE id = 22;

-- Instructions for Shrimp Salad:
UPDATE recipes
SET instructions = 'In a pan, heat olive oil over medium-high heat. Season shrimps with salt and pepper. Sauté shrimps for 2-3 minutes on each side or until they turn pink and are cooked through. In a large bowl, mix the salad greens, cherry tomatoes, cucumber, and red onion. Add the cooked shrimps on top. Drizzle with lemon juice and sprinkle with fresh dill. Toss everything together and serve.'
WHERE id = 23;

-- Instructions for Chicken Caesar Salad:
UPDATE recipes
SET instructions = 'Preheat a grill or pan over medium-high heat. Season chicken breasts with olive oil, salt, and pepper. Grill or pan-sear the chicken for 6-8 minutes on each side or until fully cooked. Let the chicken rest for a few minutes before slicing. In a large bowl, combine the romaine lettuce, croutons, and grated parmesan. Add the sliced chicken on top. Drizzle with Caesar dressing and toss to coat. Serve the salad with lemon wedges on the side.'
WHERE id = 24;

-- Instructions for Steak with Vegetables:
UPDATE recipes
SET instructions = 'Season the beef steak with salt, pepper, and minced garlic. Heat olive oil in a pan over medium-high heat. Sear the steak for 4-6 minutes on each side or until desired doneness. Remove the steak and let it rest. In the same pan, add a bit more olive oil and sauté the vegetables until tender. Add soy sauce to the pan and stir well. Slice the steak and serve with the sautéed vegetables.'
WHERE id = 41;

-- Instructions for Stuffed Bell Peppers:
UPDATE recipes
SET instructions = 'Preheat the oven to 375°F (190°C). Cut off the tops of the bell peppers and remove the seeds. In a pan, heat olive oil over medium heat. Add the chopped onion and minced garlic and sauté until translucent. Add the ground beef or turkey to the pan and cook until browned. Stir in the cooked rice and tomato sauce. Season with salt and pepper. Stuff each bell pepper with the mixture. Place the stuffed bell peppers in a baking dish and cover with aluminum foil. Bake in the preheated oven for 25-30 minutes. Remove the foil and sprinkle each pepper with grated cheddar cheese. Return to the oven and bake until the cheese is melted and bubbly. Garnish with fresh parsley before serving.'
WHERE id = 42;

-- Instructions for Grilled Tuna Steak:
UPDATE recipes
SET instructions = 'In a bowl, mix together olive oil, lemon juice, minced garlic, soy sauce, and grated ginger. Season the tuna steaks with salt and pepper, then marinate them in the mixture for at least 30 minutes. Preheat a grill or grill pan over medium-high heat. Grill the tuna steaks for 2-3 minutes on each side or until desired doneness. Garnish with sesame seeds and fresh parsley or cilantro. Serve immediately.'
WHERE id = 43;

-- Instructions for Beef Stir Fry:
UPDATE recipes
SET instructions = 'In a bowl, mix together soy sauce, minced garlic, and grated ginger. Marinate the beef strips in the mixture for at least 15 minutes. Heat olive oil in a wok or large frying pan over high heat. Add the beef strips and stir fry until browned. Remove and set aside. In the same wok, add a bit more olive oil and stir fry the vegetables until tender. Return the beef to the wok and mix well. Drizzle with sesame oil and season with salt and pepper. Garnish with sliced green onions. Serve immediately with steamed rice if desired.'
WHERE id = 44;

-- Instructions for Vegan Tofu Curry:
UPDATE recipes
SET instructions = 'Press the tofu to remove excess water and then cube it. In a large pan or wok, heat olive oil or coconut oil over medium heat. Add the minced garlic and grated ginger, and sauté for 1-2 minutes. Add the sliced red bell pepper, carrots, broccoli florets, snow peas, and red onion. Stir fry for 5-7 minutes or until vegetables are slightly tender. Add the tofu cubes to the pan and stir gently. Pour in the coconut milk and add curry powder and turmeric. Mix well. Let the curry simmer for 10-15 minutes, allowing flavors to meld. Season with salt and pepper to taste. Garnish with fresh cilantro before serving. Serve with steamed rice or quinoa.'
WHERE id = 45;

SELECT * FROM users;
SELECT * FROM favorites;


SELECT 
    r.name AS 'Receta',
    i.name AS 'Ingrediente',
    ri.quantity AS 'Cantidad',
    i.unit AS 'Unidad'
FROM 
    recipes r
JOIN 
    recipes_ingredients ri ON r.id = ri.recipe_id
JOIN 
    ingredients i ON ri.ingredient_id = i.id
ORDER BY
    r.name, i.name;


SELECT r.id, r.name, r.description, r.meal_type, r.image,
       CASE WHEN uf.user_id IS NOT NULL THEN 1 ELSE 0 END AS is_favorite
FROM recipes r
LEFT JOIN favorites uf ON r.id = uf.recipe_id AND uf.user_id = 1;

SELECT * FROM nutritions;

-- Parameters
SET @user_calories = 200; -- Replace with the user's calorie requirement

-- Retrieve 1 breakfast recipe
SELECT
    B.id AS breakfast_recipe_id, B.name AS breakfast_recipe_name,
    (SELECT calories FROM nutritions WHERE recipe_id = B.id) AS breakfast_calories
FROM recipes B
WHERE B.meal_type = 'breakfast' AND (SELECT calories FROM nutritions WHERE recipe_id = B.id) <= @user_calories
ORDER BY RAND()
LIMIT 1;

-- Retrieve 1 lunch recipe
SELECT
    L.id AS lunch_recipe_id, L.name AS lunch_recipe_name,
    (SELECT calories FROM nutritions WHERE recipe_id = L.id) AS lunch_calories
FROM recipes L
WHERE L.meal_type = 'lunch' AND (SELECT calories FROM nutritions WHERE recipe_id = L.id) <= @user_calories
ORDER BY RAND()
LIMIT 1;

-- Retrieve 1 dinner recipe
SELECT
    D.id AS dinner_recipe_id, D.name AS dinner_recipe_name,
    (SELECT calories FROM nutritions WHERE recipe_id = D.id) AS dinner_calories
FROM recipes D
WHERE D.meal_type = 'dinner' AND (SELECT calories FROM nutritions WHERE recipe_id = D.id) <= @user_calories
ORDER BY RAND()
LIMIT 1;