 import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext';
import Product from 'App/Models/Product';
 // const Product = use('App/Models/Product')
'use strict';

export default class ProdcutsController {
    
    async getAll({ request }: HttpContextContract) {

        var query = Product.query().preload("category", (subQry) => {
            subQry.where("active", true);
        })
        .where("active", true)
        ;
        if (request.input("categoryId")) {
            query.where("categoryId", request.input("categoryId"));
        }
        var result = await query;
        var products: Product[] = [];
        result.map((product) => {
            if (product.category) {
                products.push(product);
            }
        });
        return products;
    }
  
    public async fetchProductsByCategoryId({ params }: HttpContextContract) {
      try {
        const { categoryId } = params;
        const products = await Product.query().where('category_id', categoryId);
  
        return products;
      } catch (error) {
        throw new Error('Error fetching products by category ID');
      }
    }
  }

//     public async create(ctx: HttpContextContract) {
//         // var object = await ctx.auth.authenticate();
//         // console.log(object);

//         const newSchema = schema.create({
//             product_description: schema.string(),
//             product_image:schema.string(),
//             brand_id: schema.number(),
//             category_id: schema.number(),
//             list_price: schema.number(),


//         });
//         const fields = await ctx.request.validate({ schema: newSchema })
//         var product = new Product();
//         product.product_description = fields.product_description;
//         product.productImage=fields.product_image;
//         product.brand_id = fields.brand_id;
//         product.categoryId = fields.category_id;
//         product.list_price = fields.list_price;


//         var result = await product.save();
//         return result;

//     }

//     public async update(ctx: HttpContextContract) {

//         // var object = await ctx.auth.authenticate();
//         // console.log(object);
//         const newSchema = schema.create({
//             product_description: schema.string(),
//             product_image:schema.string(),
//             brand_id: schema.number(),
//             category_id: schema.number(),
//             list_price: schema.number(),
//             id: schema.number(),
//         });
//         const fields = await ctx.request.validate({ schema: newSchema })
//         var id = fields.id;
//         var product = await Product.findOrFail(id);
//         product.product_description = fields.product_description;
//         product.productImage=fields.product_image;
//         product.brand_id = fields.brand_id;
//         product.categoryId = fields.category_id;
//         product.list_price = fields.list_price;
//         var result = await product.save();
//         return result;
//     }

//     public async destory(ctx: HttpContextContract) {

//         // var object = await ctx.auth.authenticate();
//         // console.log(object);

//         var id = ctx.params.id;
//         var product = await Product.findOrFail(id);
//         await product.delete();
//         return { message: "The produt has been deleted!" };
//     }
//     public async index ({ request }: HttpContextContract) {
//         const page = request.input('page', 1)
//         const limit = 10
    
//         const posts = await Database.from('products').paginate(page, limit)
    
//         // Changes the baseURL for the pagination links
//         posts.baseUrl('/products')
    
//     }
// }
