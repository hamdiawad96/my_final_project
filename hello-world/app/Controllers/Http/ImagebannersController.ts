import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext';
import Database from '@ioc:Adonis/Lucid/Database';
import Imagebanner from 'App/Models/Imagebanner';

export default class ImagebannarsController {
    
    public async index ({ request }: HttpContextContract) {
        const page = request.input('page', 1)
        const limit = 10
    
        const posts = await Database.from('imagebannars').paginate(page, limit)
    
        // Changes the baseURL for the pagination links
        posts.baseUrl('/imagebannars')
    
    }




    public async getAll(ctx: HttpContextContract) {

        // var object = await ctx.auth.authenticate();
        // console.log(object);

        var result = await Imagebanner.all();

        return result;
    }

    public async getById(ctx: HttpContextContract) {
        var object = await ctx.auth.authenticate();
        console.log(object);

        var id = ctx.params.id;
        var result = await Imagebanner.findOrFail(id);

        return result;
    }
}

