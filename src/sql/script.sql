-- Données d'exemple: Utilisateur 1 (Alice)
WITH new_user AS (
  INSERT INTO Users(email, password_hash, first_name, last_name)
  VALUES ('alice@example.com',
          '$2a$10$CwTycUXWue0Thq9StjUM0uJ8K0lWuzWq5e5F8kFVHK.Y7z7Yw8Q4u',
          'Alice', 'Martin')
  RETURNING user_id
), cat_income AS (
  INSERT INTO Categories(user_id, name, is_default)
  SELECT user_id, 'Revenus', TRUE FROM new_user
  RETURNING category_id, user_id
), cat_food AS (
  INSERT INTO Categories(user_id, name, is_default)
  SELECT user_id, 'Alimentation', FALSE FROM new_user
  RETURNING category_id, user_id
), cat_rent AS (
  INSERT INTO Categories(user_id, name, is_default)
  SELECT user_id, 'Loyer', FALSE FROM new_user
  RETURNING category_id, user_id
), b_food AS (
  INSERT INTO Budgets(user_id, category_id, amount, month)
  SELECT new_user.user_id, cat_food.category_id, 300.00, DATE '2025-09-01'
  FROM new_user, cat_food
  RETURNING budget_id, user_id
), b_rent AS (
  INSERT INTO Budgets(user_id, category_id, amount, month)
  SELECT new_user.user_id, cat_rent.category_id, 800.00, DATE '2025-09-01'
  FROM new_user, cat_rent