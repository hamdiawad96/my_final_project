import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext';
import Order from 'App/Models/Order';
import OrderAddress from 'App/Models/OrderAddress';
import OrderItem from 'App/Models/OrderItem';
import User from 'App/Models/User';

export default class OrdersController {


    // async getAll({ request }: HttpContextContract) {
    //     var query = Order.query().preload("user", (subQry) => {
    //         // subQry.where("active", true);
    //     })
    //     // .where("active", true)
    //     ;
    //     if (request.input("userId")) {
    //         query.where("userId", request.input("userId"));
    //     }
    //     var result = await query;
    //     var orders: Order[] = [];
    //     result.map((order) => {
    //         if (order.user) {
    //             orders.push(order);
    //         }
    //     });
    //     return orders;



    // }

    // public async getById(ctx: HttpContextContract) {
    //     const id = ctx.params.id;
      
    //     const result = await Order.query().preload('user').where('id', id).firstOrFail();
      
    //     return result;
    //   }

    //   public async fetchOrdersByuserId({ params }: HttpContextContract) {
    //     try {
    //       const { userId } = params;
    //       const orders = await Order.query().where('user_id', userId);
    
    //       return orders;
    //     } catch (error) {
    //       throw new Error('Error fetching products by user ID');
    //     }
    //   }









    async create({ request, response, auth }: HttpContextContract) {
        try {

            var authObject = await auth.authenticate();
            var data = request.all();
            var order = new Order();
            order.userId = authObject.id;
            order.taxAmount = data.tax_amount;
            order.subTotal = data.sub_total;
            order.total = data.total;
            order.paymentMethodId = data.payment_method_id;
            var newOrder = await order.save();




            var address = new OrderAddress();
            address.country = data.address.country;
            address.city = data.address.city;
            address.area = data.address.area;
            address.street = data.address.street;
            address.buildingNo = data.address.building_no;
            address.longitude = data.address.longitude;
            address.latitude = data.address.latitude;
            address.orderId = newOrder.id;
            await address.save();


            var orderItems: OrderItem[] = data.products.map((product) => {
                var orderItem = new OrderItem();
                orderItem.orderId = newOrder.id;
                orderItem.productId = product.product_id;
                orderItem.qty = product.qty;
                orderItem.price = product.price;
                return orderItem;
            });

            await OrderItem.createMany(orderItems);
            return newOrder.toJSON();
        } catch (ex) {
            console.log(ex);
            return response.badRequest({ message: ex });
        }
    }



}