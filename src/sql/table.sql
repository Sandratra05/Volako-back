-- Table Users
CREATE TABLE Users (
       user_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
       email VARCHAR(255) UNIQUE NOT NULL,
       password_hash VARCHAR(255) NOT NULL,
       first_name VARCHAR(50),
       last_name VARCHAR(50),
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP
);

-- Table Categories
CREATE TABLE Categories (
        category_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        user_id BIGINT REFERENCES Users(user_id) ON DELETE CASCADE,
        name VARCHAR(50) NOT NULL,
        is_default BOOLEAN DEFAULT FALSE
);

-- Table Transactions
CREATE TABLE Transactions (
          transaction_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
          user_id BIGINT REFERENCES Users(user_id) ON DELETE CASCADE NOT NULL,
          category_id BIGINT REFERENCES Categories(category_id) ON DELETE RESTRICT NOT NULL,
          amount DECIMAL(10,2) NOT NULL,
          transaction_type VARCHAR(10) NOT NULL CHECK (transaction_type IN ('INCOME', 'EXPENSE')),
          description TEXT,
          transaction_date DATE NOT NULL,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          updated_at TIMESTAMP
);

-- Table Budgets
CREATE TABLE Budgets (
         budget_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
         user_id BIGINT REFERENCES Users(user_id) ON DELETE CASCADE NOT NULL,
         category_id BIGINT REFERENCES Categories(category_id) ON DELETE RESTRICT NOT NULL,
         amount DECIMAL(10,2) NOT NULL,
         month DATE NOT NULL,
         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
         updated_at TIMESTAMP,
         CONSTRAINT unique_budget UNIQUE (user_id, category_id, month)
);

-- Table Alerts
CREATE TABLE Alerts (
        alert_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        user_id BIGINT REFERENCES Users(user_id) ON DELETE CASCADE NOT NULL,
        budget_id BIGINT REFERENCES Budgets(budget_id) ON DELETE CASCADE,
        message TEXT NOT NULL,
        is_read BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);