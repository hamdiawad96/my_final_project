//  import I18n from '@ioc:Adonis/Addons/I18n';
// import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
// import { schema } from '@ioc:Adonis/Core/Validator';
// import Database from '@ioc:Adonis/Lucid/Database';
// import City from 'App/Models/City';

// export default class CitiesController {

//     public async getAll(ctx: HttpContextContract) {

//         var object = await ctx.auth.authenticate();
//         console.log(object);
       

        
//         var countryId = ctx.request.input("countryId");
        
//                 var query = City.query();
        
//                 if (countryId) {
//                     query.where("country_id", countryId);
//                 }
               
        
//                 var result = await query;
//                 return result;



//     }

//     public async getById(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//         var id = ctx.params.id;
//         var result = await City.findOrFail(id);
        
//         return result;
//     }

//     public async create(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//         const newSchema = schema.create({
//             city: schema.string(),
//             country_id: schema.number(),

//         });

        
//         // var languageFromHeader = ctx.request.header('language');
//         // var langauge: string = languageFromHeader != null ? languageFromHeader : "ar";

//         // console.log("Language", langauge);
//         // const him = await ctx.request.validate({
//         //     schema: newSchema,
//         //     messages: {
//         //         required: 'The {{ field }} is required to create a new account',
//         //         'city_name.unique': 'city_name not available',
//         //         'city_name.required': I18n
//         //             .locale(langauge)
//         //             .formatMessage('cities.required', { field: "city_name" }),
//         //         'city_name.first_name': 'city_name must be an city_name format',
//         //     }
//         // });



//         const fields = await ctx.request.validate({ schema: newSchema })
//         var city = new City();
//         city.city = fields.city;
//         city.country_id = fields.country_id;
//         var result = await city.save();
//         return result;

//     }

//     public async update(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//         const newSchema = schema.create({
//            city: schema.string(),
//             country_id: schema.number(),
//             id: schema.number(),
//         });
//         const fields = await ctx.request.validate({ schema: newSchema })
//         var id = fields.id;
//         var city = await City.findOrFail(id);
//         city.city = fields.city;
//         city.country_id = fields.country_id;
//         var result = await city.save();
//         return result;
//     }

//     public async destory(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         console.log(object);
//         var id = ctx.params.id;
//         var city = await City.findOrFail(id);
//         await city.delete();
//         return { message: "The City has been deleted!" };
//     }

    
//     public async index ({ request }: HttpContextContract) {
//         const page = request.input('page', 1)
//         const limit = 10
    
//         const posts = await Database.from('cities').paginate(page, limit)
    
//         // Changes the baseURL for the pagination links
//         posts.baseUrl('/cities')
    
//     }
// }
