# README

## Prerequisites
The setup steps expect following tools installed on the system.

* Node version `16.20.2` or check in the **package.json** file
* Ruby version `3.0.0`
* Yarn version `1.22.22`
* Bundler

## Setup steps
  - Clone application from github.
  - Run the following commands in terminal

  ```bash
  $ bundle install
  $ yarn install
  $ rails s
  ```

## Testing
 Run the following command on the terminal to execute test suit.
  ```bash
  $ rspec test/
  $ rspec test test/path_to_file # for single file
  ```

And now you can visit the site with the URL http://localhost:3000

# API Endpoints Documentation

This section provides a list of available API endpoints in the application.

## Authentication Endpoints

### 1. **POST /login**
- **Description**: This endpoint allows a user to log in and receive a JWT token for authentication.

## Order Endpoints

### 1. **POST /orders**
- **Description**: This endpoint allows a user to place an order by providing pizza details, toppings, and sides.

## Inventory Endpoints

### 1. **GET /inventory/index**
- **Description**: This endpoint retrieves the list of available items in the inventory (pizzas, crusts, toppings, and sides).

### 2. **GET /inventory/show**
- **Description**: This endpoint retrieves the quantity of a specific item in the inventory based on its type (pizza, crust, topping, or side).

### 3. **POST /inventory/restock**
- **Description**: This endpoint allows restocking of a specific item (pizza, crust, topping, or side) in the inventory.

### 4. **POST /inventory/check_availability**
- **Description**: This endpoint checks if a specific item (pizza, crust, topping, or side) is available in the required quantity in the inventory.

## Pizza Endpoints

### 1. **GET /pizzas**
- **Description**: This endpoint retrieves a list of available pizzas in the store.

### 2. **POST /pizzas/add_topping**
- **Description**: This endpoint allows a user to add a topping to a specific pizza.

---
