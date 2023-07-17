// import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
// import { schema } from '@ioc:Adonis/Core/Validator';
// import Database from '@ioc:Adonis/Lucid/Database';
// import Payment from 'App/Models/Payment';

// export default class PaymentsController {
//     public async getAll(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);

//         // var result = await Payment.query().preload("userId");
//         // var result = await Payment.query().preload("staffId");



      
//         // return result;
//     }

//     public async getById(ctx: HttpContextContract) {
// var object = await ctx.auth.authenticate();
//         console.log(object);
//         var id = ctx.params.id;
//         var result = await Payment.findOrFail(id);
//         return result;
//     }

//     public async create(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);

//         const newSchema = schema.create({
//             user_id: schema.number(),
//             staff_id: schema.number(),
//             amount: schema.number(),
//             payment_date: schema.date(),


//         });
//         const fields = await ctx.request.validate({ schema: newSchema })
//         var payment = new Payment();
//         payment.userId = fields.user_id;
//         payment.stuffId = fields.staff_id;
//         payment.amount = fields.amount;
//         payment.paymentDate = fields.payment_date;

//         var result = await payment.save();
//         return result;

//     }

//     public async update(ctx: HttpContextContract) {

//         var object = await ctx.auth.authenticate();
//         console.log(object);

//         const newSchema = schema.create({
//             user_id: schema.number(),
//             staff_id: schema.number(),
//             amount: schema.number(),
//             payment_date: schema.date(),
//             id: schema.number(),
//         });
//         const fields = await ctx.request.validate({ schema: newSchema })
//         var id = fields.id;
//         var payment = await Payment.findOrFail(id);
//         payment.userId = fields.user_id;
//         payment.stuffId = fields.staff_id;
//         payment.amount = fields.amount;
//         payment.paymentDate = fields.payment_date;

//         var result = await payment.save();
//         return result;
//     }

//     public async destory(ctx: HttpContextContract) {
// var object = await ctx.auth.authenticate();
//         console.log(object);
        
//         var id = ctx.params.id;
//         var payment = await Payment.findOrFail(id);
//         await payment.delete();
//         return { message: "The Payment has been deleted!" };
//     }
//     public async index ({ request }: HttpContextContract) {
//         const page = request.input('page', 1)
//         const limit = 10
    
//         const posts = await Database.from('payments').paginate(page, limit)
    
//         // Changes the baseURL for the pagination links
//         posts.baseUrl('/payments')
    
//     }
// }