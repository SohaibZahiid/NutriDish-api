-- Create or use the database
DROP DATABASE IF EXISTS db_nutridish;
CREATE DATABASE IF NOT EXISTS db_nutridish;
USE db_nutridish;

-- Create the user table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    UNIQUE (username),
    UNIQUE (email)
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
    created_by INT NOT NULL,
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
INSERT INTO users (name, username, email, password)
VALUES
    ('Michael Johnson', 'michaelj', 'michael@example.com', 'securepassword'),
    ('Emily Brown', 'emilyb', 'emily@example.com', 'safepass123'),
    ('Daniel Smith', 'daniels', 'daniel@example.com', 'strongpass321'),
    ('Olivia Wilson', 'oliviaw', 'olivia@example.com', 'mypassword567'),
    ('William Davis', 'williamd', 'william@example.com', 'mypw987'),
    ('Sophia Martinez', 'sophiam', 'sophia@example.com', 'goodpassword'),
    ('James Anderson', 'jamesa', 'james@example.com', 'complexpw456'),
    ('Ava Hernandez', 'avah', 'ava@example.com', 'password321'),
    ('Benjamin Taylor', 'benjamint', 'benjamin@example.com', 'secretpass789'),
    ('Emma Moore', 'emmam', 'emma@example.com', 'pass1234');

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
    ('Grilled Salmon', 'Deliciously grilled salmon with a lemon-dill sauce.', 3, 25, 2, 'https://example.com/grilled-salmon.jpg', 'Dinner', 1, 'Pescatarian'),
    ('Chicken Tikka Masala', 'Classic Indian dish with tender chicken in a creamy tomato sauce.', 5, 40, 4, 'https://example.com/chicken-tikka-masala.jpg', 'Dinner', 1, 'Non-vegetarian'),
    ('Quinoa Salad', 'A refreshing salad with quinoa, vegetables, and a zesty vinaigrette.', 1, 20, 3, 'https://example.com/quinoa-salad.jpg', 'Lunch', 0, 'Vegetarian'),
    ('Chocolate Brownies', 'Decadent chocolate brownies with a gooey center.', 7, 60, 12, 'https://example.com/chocolate-brownies.jpg', 'Dessert', 0, 'Dairy-Free'),
    ('Spaghetti Bolognese', 'Classic Italian pasta dish with rich meat sauce.', 2, 50, 4, 'https://example.com/spaghetti-bolognese.jpg', 'Dinner', 1, 'Non-vegetarian'),
    ('Greek Salad', 'A Mediterranean delight with tomatoes, cucumbers, olives, and feta cheese.', 4, 15, 2, 'https://example.com/greek-salad.jpg', 'Lunch', 0, 'Vegetarian'),
    ('Sushi Rolls', 'Homemade sushi rolls with fresh fish and vegetables.', 6, 30, 6, 'https://example.com/sushi-rolls.jpg', 'Dinner', 0, 'Pescatarian'),
    ('Guacamole', 'Creamy avocado dip with tomatoes, onions, and lime juice.', 8, 10, 4, 'https://example.com/guacamole.jpg', 'Snack', 1, 'Vegan'),
    ('Beef Stir-Fry', 'Quick and flavorful beef stir-fry with mixed vegetables.', 9, 35, 3, 'https://example.com/beef-stir-fry.jpg', 'Dinner', 1, 'Non-vegetarian'),
    ('Raspberry Sorbet', 'Refreshing raspberry sorbet, perfect for a hot day.', 10, 15, 4, 'https://example.com/raspberry-sorbet.jpg', 'Dessert', 0, 'Vegan');

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


