 import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Database from '@ioc:Adonis/Lucid/Database'
import Brand from 'App/Models/Brand'

export default class BrandsController {
    public async index ({ request }: HttpContextContract) {
        const page = request.input('page', 1)
        const limit = 10
    
        const posts = await Database.from('brands').paginate(page, limit)
    
        // Changes the baseURL for the pagination links
        posts.baseUrl('/brands')
    
    }

    
    public async getAll(ctx: HttpContextContract) {
        // var object = await ctx.auth.authenticate();

        // console.log(object);
        var result = await Brand.all();
        return result;



    }

    public async getById(ctx: HttpContextContract) {
        // var object = await ctx.auth.authenticate();
        // console.log(object);

        var id = ctx.params.id;
        var result = await Brand.findOrFail(id);

        return result;
    }
}