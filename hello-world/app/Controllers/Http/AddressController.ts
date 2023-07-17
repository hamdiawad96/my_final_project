//  import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
// import { schema } from '@ioc:Adonis/Core/Validator';
// import Database from '@ioc:Adonis/Lucid/Database';
// import Address from 'App/Models/Address';

// export default class AddressesController {
//     public async getAll(ctx: HttpContextContract) {

//         // var object = await ctx.auth.authenticate();
        
//         // console.log(object);
//         // var result = await Address.query().preload("cityName");
//         // return result;  

        
//         // var cityId = ctx.request.input("cityId");
        
//         //         var query = Address.query();
        
//         //         if (cityId) {
//         //             query.where("city_id", cityId);
//         //         }
               
        
//         //         var result = await query;
//         //         return result;


//             }



//     public async index ({ request }: HttpContextContract) {
//         const page = request.input('page', 1)
//         const limit = 10
    
//         const posts = await Database.from('address').paginate(page, limit)
    
//         // Changes the baseURL for the pagination links
//         posts.baseUrl('/address')
    
//     }

//     public async getById(ctx: HttpContextContract) {
//         // var object = await ctx.auth.authenticate();
//         // console.log(object);
//         var id = ctx.params.id;
//         var result = await Address.findOrFail(id);
//         return result;
//     }

//     public async create(ctx: HttpContextContract) {
//         // var object = await ctx.auth.authenticate();
//         // console.log(object);
//         const newSchema = schema.create({
//             // address: schema.string(),
//             // city_id: schema.number(),
//             city: schema.string(),
//             country:schema.string(),

//             phone : schema.string(),




//         });
//         const fields = await ctx.request.validate({ schema: newSchema })
//         var addres = new Address();
//         addres.city = fields.city;
//         addres.country = fields.country;

//         // addres.address = fields.address;
//         // addres.city_id = fields.city_id;
//         addres.phone = fields.phone;


//         var result = await addres.save();
//         return result;

//     }

//     public async update(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//         const newSchema = schema.create({
//             address: schema.string(),
//             city_id: schema.number(),
//             phone : schema.string(),
//             id: schema.number(),
//         });
//         const fields = await ctx.request.validate({ schema: newSchema })
//         var id = fields.id;
//         var addres = await Address.findOrFail(id);
//         addres.address = fields.address;
//         // addres.city_id = fields.city_id;
//         addres.phone = fields.phone;
//         var result = await addres.save();
//         return result;
//     }

//     public async destory(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//         var id = ctx.params.id;
//         var addres = await Address.findOrFail(id);
//         await addres.delete();
//         return { message: "The Address has been deleted!" };
//     }
// }