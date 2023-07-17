 import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { schema } from '@ioc:Adonis/Core/Validator'
import Database from '@ioc:Adonis/Lucid/Database'
import Category from 'App/Models/Category'

export default class CategoriesController {
    

    public async index ({ request }: HttpContextContract) {
        const page = request.input('page', 1)
        const limit = 10
    
        const posts = await Database.from('categories').paginate(page, limit)
    
        // Changes the baseURL for the pagination links
        posts.baseUrl('/categories')
    
    }

    public async getAll(ctx: HttpContextContract) {

        // var object = await ctx.auth.authenticate();
        // console.log(object);

        var result = await Category.all();

        return result;
    }

    public async getById(ctx: HttpContextContract) {
// var object = await ctx.auth.authenticate();
//         console.log(object);
        var id = ctx.params.id;
        var result = await Category.findOrFail(id);
        return result;
    }

    public async create(ctx: HttpContextContract) {
        var object = await ctx.auth.authenticate();
        console.log(object);
        // var fields = ctx.request.all();
        // var category = new Category();
        // category.name = fields.name;
        // var result = await category.save();
        // return result;
        const newSchema = schema.create({
            name: schema.string(),
            id: schema.number(),
            image: schema.string(),

        });
        const fields = await ctx.request.validate({ schema: newSchema })
        var id = fields.id;
        var category = await Category.findOrFail(id);
        category.name = fields.name;
        category.image = fields.image;


        var result = await category.save();
        return result;
    }

    public async update(ctx: HttpContextContract) {
        var object = await ctx.auth.authenticate();
        console.log(object);
        const newSchema = schema.create({
            name: schema.string(),
            image: schema.string(),

            id: schema.number(),
        });
        const fields = await ctx.request.validate({ schema: newSchema })
        var id = fields.id;
        var category = await Category.findOrFail(id);
        category.name = fields.name;
        category.image = fields.image;


        var result = await category.save();
        return result;
    }


    public async destory(ctx: HttpContextContract) {
        var object = await ctx.auth.authenticate();
        console.log(object);
        var id = ctx.params.id;
        var category = await Category.findOrFail(id);
        await category.delete();
        return { message: "The category has been deleted!" };
    }
}

