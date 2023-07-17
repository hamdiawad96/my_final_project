 import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { schema } from '@ioc:Adonis/Core/Validator';
import Database from '@ioc:Adonis/Lucid/Database';
import OrderItem from 'App/Models/OrderItem';

export default class OrderItemsController {
    public async getAll(ctx: HttpContextContract) {

        var object = await ctx.auth.authenticate();
        console.log(object);
        
    }
    public async getById(ctx: HttpContextContract) {

        var object = await ctx.auth.authenticate();
        console.log(object);

        var id = ctx.params.id;
        var result = await OrderItem.findOrFail(id);
        return result;
    }

    public async create(ctx: HttpContextContract) {

        var object = await ctx.auth.authenticate();
        console.log(object);

        const newSchema = schema.create({
            order_id: schema.number(),
            product_id: schema.number(),
            qty: schema.number(),
            price: schema.number(),


        });
        const fields = await ctx.request.validate({ schema: newSchema })
        var orderItem = new OrderItem();
        orderItem.orderId = fields.order_id;
        orderItem.productId = fields.product_id;
        orderItem.qty = fields.qty;
        orderItem.price = fields.price;


        var result = await orderItem.save();
        return result;

    }

    public async update(ctx: HttpContextContract) {

        var object = await ctx.auth.authenticate();
        console.log(object);
        const newSchema = schema.create({
            order_id: schema.number(),
            product_id: schema.number(),
            qty: schema.number(),
            price: schema.number(),
            id: schema.number(),
        });
        const fields = await ctx.request.validate({ schema: newSchema })
        var id = fields.id;
        var orderItem = await OrderItem.findOrFail(id);
        orderItem.orderId = fields.order_id;
        orderItem.productId = fields.product_id;
        orderItem.qty = fields.qty;
        orderItem.price = fields.price;


        var result = await orderItem.save();
        return result;
    }

    public async destory(ctx: HttpContextContract) {

        var object = await ctx.auth.authenticate();
        console.log(object);

        var id = ctx.params.id;
        var orderItem = await OrderItem.findOrFail(id);
        await orderItem.delete();
        return { message: "The orderItem has been deleted!" };
    }
    public async index ({ request }: HttpContextContract) {
        const page = request.input('page', 1)
        const limit = 10
    
        const posts = await Database.from('order_items').paginate(page, limit)
    
        // Changes the baseURL for the pagination links
        posts.baseUrl('/order_items')
    
    }
}
