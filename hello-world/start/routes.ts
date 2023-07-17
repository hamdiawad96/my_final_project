/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
|
| This file is dedicated for defining HTTP routes. A single file is enough
| for majority of projects, however you can define routes in different
| files and just make sure to import them inside this file. For example
|
| Define routes in following two files
| ├── start/routes/cart.ts
| ├── start/routes/customer.ts
|
| and then import them inside `start/routes.ts` as follows
|
| import './routes/cart'
| import './routes/customer'
|
*/

import Route from '@ioc:Adonis/Core/Route';

    Route.group(() => {
      Route.post("/login", "UsersController.login");
      Route.post("/logout", "UsersController.logout");
      Route.get('/', "UsersController.getMe");
      Route.put('/', "UsersController.update");

      Route.post("/", "UsersController.create");
    }).prefix("/users");

  Route.group(() => {
    Route.get("/init", "AddressController.getInit");
    Route.get("/", "AddressController.getAll");
    Route.post("/", "AddressController.create");
    Route.put("/", "AddressController.update");
    Route.delete("/", "AddressController.destroy");
  }).prefix("/address");

  Route.group(() => {
    Route.get("/init", "BrandsController.getInit");

    Route.get("/", "BrandsController.getAll");
 
  }).prefix("/brands");

  Route.group(() => {
    Route.get("/init", "CategoriesController.getInit");

    Route.get("/", "CategoriesController.getAll");
    Route.post("/", "CategoriesController.create");
    Route.put("/", "CategoriesController.update");
    Route.delete("/", "CategoriesController.destroy");
  }).prefix("/categories");

  Route.group(() => {
    Route.get("/", "ImagebannarsController.getAll");
  }).prefix("/imagebannars");





  Route.group(() => {
    Route.get("/init", "CitiesController.getInit");

    Route.get("/", "CitiesController.getAll");
    Route.post("/", "CitiesController.create");
    Route.put("/", "CitiesController.update");
    Route.delete("/", "CitiesController.destroy");
  }).prefix("/cities");

  Route.group(() => {
    Route.get("/init", "CountriesController.getInit");
    Route.get("/", "CountriesController.getAll");
    Route.post("/", "CountriesController.create");
    Route.put("/", "CountriesController.update");
    Route.delete("/", "CountriesController.destroy");
  }).prefix("/countries");

  Route.group(() => {
    Route.get("/init", "OrdersController.getInit");

    Route.get("/", "OrdersController.getAll");
    Route.post("/", "OrdersController.create");
    Route.post("/:userId", "OrdersController.fetchOrdersByuserId");

    Route.put("/", "OrdersController.update");
    Route.delete("/", "OrdersController.destroy");
  }).prefix("/orders");

  Route.group(() => {
    Route.get("/init", "OrderItemsController.getInit");

    Route.get("/", "OrderItemsController.getAll");
    Route.post("/", "OrderItemsController.create");
  

    Route.put("/", "OrderItemsController.update");
    Route.delete("/", "OrderItemsController.destroy");
  }).prefix("/order_items");

  Route.group(() => {
    Route.get("/init", "PaymentsController.getInit");

    Route.get("/", "PaymentsController.getAll");
    Route.post("/", "PaymentsController.create");
    Route.put("/", "PaymentsController.update");
    Route.delete("/", "PaymentsController.destroy");
 
  }).prefix("/payments");
  
  Route.group(() => {
    Route.get("/init", "ProdcutsController.getInit");

    Route.get("/", "ProdcutsController.getAll");
    Route.get('/:categoryId', 'ProdcutsController.fetchProductsByCategoryId');

    Route.post("/", "ProdcutsController.create");
    Route.put("/", "ProdcutsController.update");
    Route.delete("/", "ProdcutsController.destroy");
    Route.get('/products/most-requested', 'ProdcutsController.getMostRequested');

  }).prefix("/products");


  Route.group(() => {
    Route.get("/init", "staffsController.getInit");

    Route.get("/", "staffsController.getAll");
    Route.post("/", "staffsController.create");
    Route.put("/", "staffsController.update");
    Route.delete("/", "staffsController.destroy");
  }).prefix("/staffs");

