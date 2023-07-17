//  import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
// import { schema } from '@ioc:Adonis/Core/Validator';
// import Database from '@ioc:Adonis/Lucid/Database';
// import Country from 'App/Models/Country';

// export default class CountriesController {
//     public async getAll(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//         var result = await Country.all();
//         return result;
//     }

//     public async getById(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//         var id = ctx.params.id;
//         var result = await Country.findOrFail(id);
//         return result;
//     }

//     public async create(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//         // var fields = ctx.request.all();
//         // var country = new Country();
//         // country.country = fields.country;
//         // var result = await country.save();
//         // return result;
//         const newSchema = schema.create({
//             country: schema.string(),
//             id: schema.number(),
//         });
//         const fields = await ctx.request.validate({ schema: newSchema })
//         var id = fields.id;
//         var country = await Country.findOrFail(id);
//         country.country = fields.country;
//         var result = await country.save();
//         return result;

//     }

//     public async update(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//         const newSchema = schema.create({
//             country: schema.string(),
//             id: schema.number(),
//         });
//         const fields = await ctx.request.validate({ schema: newSchema })
//         var id = fields.id;
//         var country = await Country.findOrFail(id);
//         country.country = fields.country;
//         var result = await country.save();
//         return result;
//     }


//     public async destory(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//         var id = ctx.params.id;
//         var country = await Country.findOrFail(id);
//         await country.delete();
//         return { message: "The country has been deleted!" };
//     }
    
//     public async index ({ request }: HttpContextContract) {
//         const page = request.input('page', 1)
//         const limit = 10
    
//         const posts = await Database.from('countries').paginate(page, limit)
    
//         // Changes the baseURL for the pagination links
//         posts.baseUrl('/countries')
    
//     }
// }