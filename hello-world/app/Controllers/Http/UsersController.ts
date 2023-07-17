import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { schema, rules } from '@ioc:Adonis/Core/Validator'
import User from 'App/Models/User';
import I18n from '@ioc:Adonis/Addons/I18n'
import Address from 'App/Models/Address';
import AddressesController from './AddressController';

export default class UsersController {

    




//     public async login(ctx: HttpContextContract) {
        


//         var object = ctx.request.all();
//         var email = object.email;
//         var password = object.password;

//         var result = await ctx.auth.attempt(email, password);
//         return result;
//     }


//     public async logout(ctx: HttpContextContract) {
//         var object = await ctx.auth.authenticate();
//         await ctx.auth.logout();
//         return { message: "Logout" }
//     }

//     public async create(ctx: HttpContextContract) {

//         const newSchema = schema.create({
//             email: schema.string({}, [
//                 rules.email(),
//                 // rules.unique({
//                 //     table: 'users',
//                 //     column: 'email',
//                 // })
//             ]),
//             password: schema.string(),
//             // first_name: schema.string(),
//         },);


//         var languageFromHeader = ctx.request.header('language');
//         var langauge: string = languageFromHeader != null ? languageFromHeader : "ar";

//         console.log("Language", langauge);
//         const fields = await ctx.request.validate({
//             schema: newSchema,
//             messages: {
//                 required: 'The {{ field }} is required to create a new account',
//                 // 'email.unique': 'Email not available',
                
//                 'email.required': I18n
//                     .locale(langauge)
//                     .formatMessage('users.required', { field: "email" }),
//                 'email.email': 'Email must be an email format',
//             }
//         });


//         var user = new User();

//         // user.firstName = fields.first_name;
//         user.email = fields.email;
//         user.password = fields.password;
//         var newUser = await user.save();
//         return newUser;

//     }
// }

// async create({ auth, request, response }: HttpContextContract) {

//     const createSchema = schema.create({
//         email: schema.string([
//             rules.email(),
//             rules.unique({ table: 'users', column: 'email' })
//         ]),
//         password: schema.string([
//             rules.minLength(8)
//         ]),
//         username: schema.string([
//             rules.minLength(2)
//         ]),
//         first_name: schema.string([
//             rules.minLength(2)
//         ]),
//         last_name: schema.string([
//             rules.minLength(2)
    
//         ]),
//         address_id: schema.number([
        
//         ])
//     });

//     const payload = await request.validate({ schema: createSchema });

//     const user = new User();
//     user.firstName = payload.first_name;
//     user.lastName = payload.last_name;
//     user.addressId=payload.address_id;


//     user.username = payload.username;
//     user.password = payload.password;
//     user.email = payload.email;
//     var newUser = await user.save();
//     const token = await auth.use('api').attempt(payload.email, payload.password);
//     return token;
//     // return { message: "Your account has been created!" };
// }

async getMe({ auth }: HttpContextContract) {
    var authObject = await auth.authenticate();
    var user = await User.findOrFail(authObject.id);
    return user;
}
async update({ auth, request, response }: HttpContextContract) {

    try {
        var authObject = await auth.authenticate();

        const createSchema = schema.create({
            email: schema.string([
                rules.email(),
            ]),
            username: schema.string([
                rules.minLength(2)
                
            ]),
            first_name: schema.string([
                rules.minLength(2)
                
            ]),

            last_name: schema.string([
                rules.minLength(2)
                
            ]),

            city: schema.string([
                rules.minLength(2)
                
            ]),

            country: schema.string([
                rules.minLength(2)
                
            ]),

            phone: schema.string([
                rules.minLength(2)
                
            ]),
            password: schema.string([
                rules.minLength(2)
                
            ]),


        });

        const payload = await request.validate({ schema: createSchema });
        const user = await User.findOrFail(authObject.id);
        user.username = payload.username;
        user.email = payload.email;
        user.firstName = payload.first_name;
        user.lastName = payload.last_name;
        user.city = payload.city;
        user.country = payload.country;
        user.phone = payload.phone;


        if (request.input("password") && request.input("password").toString().length > 0) {
            user.password = request.input("password");
        }
        await user.save();
        return user;
    } catch (ex) {
        console.log(ex);
        return response.badRequest({ message: ex.toString() });
    }
}

async create({ auth, request, response }: HttpContextContract) {
    const createSchema = schema.create({
        email: schema.string([
                        rules.email(),
                        rules.unique({ table: 'users', column: 'email' })
                    ]),
                    password: schema.string([
                        rules.minLength(8)
                    ]),
                    username: schema.string([
                        rules.minLength(2)
                    ]),
                    first_name: schema.string([
                        rules.minLength(2)
                    ]),
                    last_name: schema.string([
                        rules.minLength(2)
                
                    ]),

                    city: schema.string([
                        rules.minLength(2)
                
                    ]),

                    country: schema.string([
                        rules.minLength(2)
                
                    ]),

                    phone: schema.string([
                        rules.minLength(2)
                
                    ]),


// address: schema.object().members({
//     city: schema.string(),
//     country: schema.string(),
//     phone: schema.string()
// })
});

const payload = await request.validate({ schema: createSchema });

const user = new User();
user.firstName = payload.first_name;
user.lastName = payload.last_name;
user.username = payload.username;
user.password = payload.password;
user.email = payload.email;
user.city = payload.city;

user.country = payload.country;

user.phone = payload.phone;



// user.address = {} as any;

  // Assign address properties
//   user.address.city = payload.address.city;
//   user.address.country = payload.address.country;
//   user.address.phone = payload.address.phone;

  // Save user to the database
  await user.save();

  const token = await auth.use('api').attempt(payload.email, payload.password,);
  return token;
  // return { message: "Your account has been created!" };
}
async login({ auth, request, response }: HttpContextContract) {
    const email = request.input('email')
    const password = request.input('password')

    try {
        const token = await auth.use('api').attempt(email, password);
        return token
    } catch {
        return response.unauthorized('Invalid credentials')
    }
}};
