//  import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
// import { schema } from '@ioc:Adonis/Core/Validator';
// import Staff from 'App/Models/Staff';

// export default class staffsController {
    
//     public async getAll(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//     var result = await Staff.query().preload("addressId");

//     return result;
//     }

//     public async getById(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);

//         var id = ctx.params.id;
//         var result = await Staff.findOrFail(id);
//         return result;
//     }

//     public async create(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);

//         const newSchema = schema.create({
//             first_name: schema.string(),
//             last_name: schema.string(),
//             address_id: schema.number(),
//             email: schema.string(),
//             active: schema.number(),
//             username: schema.string(),
//             password: schema.string(),



//         });
//         const fields = await ctx.request.validate({ schema: newSchema })
//         var staff = new Staff();
//         staff.first_name = fields.first_name;
//         staff.last_name = fields.last_name;
//         staff.address_id = fields.address_id;
//         staff.active = fields.active;
//         staff.username = fields.username;
//         staff.password = fields.password;



//         var result = await staff.save();
//         return result;

//     }

//     public async update(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//         const newSchema = schema.create({
//             first_name: schema.string(),
//             last_name: schema.string(),
//             address_id: schema.number(),
//             email: schema.string(),
//             active: schema.number(),
//             username: schema.string(),
//             password: schema.string(),

//             id: schema.number(),
//         });
//         const fields = await ctx.request.validate({ schema: newSchema })
//         var id = fields.id;
//         var staff = await Staff.findOrFail(id);
//         staff.first_name = fields.first_name;
//         staff.last_name = fields.last_name;
//         staff.address_id = fields.address_id;
//         staff.email = fields.email;
//         staff.active = fields.active;
//         staff.username = fields.username;
//         staff.password = fields.password;



//         var result = await staff.save();
//         return result;
//     }

//     public async destory(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//         var id = ctx.params.id;
//         var staff = await Staff.findOrFail(id);
//         await staff.delete();
//         return { message: "The staff has been deleted!" };
//     }
// }