import Hash from '@ioc:Adonis/Core/Hash';
import { BaseModel, HasOne, beforeSave, column, hasOne } from '@ioc:Adonis/Lucid/Orm';
import { DateTime } from 'luxon';
import Address from './Address';



export default class User extends BaseModel {
  @column({ isPrimary: true })
  public id: number;
 
  @column({ serializeAs: "first_name", })
  public firstName: string;

  @column({ serializeAs: "last_name", })
  public lastName: string;

  @column({ serializeAs: "username", })
  public username: string;

  @column({ serializeAs: "password", })
  public password: string;

  @column({ serializeAs: "email", })
  public email: string;

  @column({ serializeAs: "city", })
  public city: string;

  @column({ serializeAs: "country", })
  public country: string;

  @column({ serializeAs: "phone", })
  public phone: string;





  // @column({ serializeAs: "address_id", })
  // public addressId: number;

  

  @column()
  public rememberMeToken: string | null
  

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @beforeSave()
  public static async hashPassword (user: User) {
    if (user.$dirty.password) {
      user.password = await Hash.make(user.password)
    }
  }

  
  // @hasOne(() => Address, {
  //   localKey: 'addressId',
  //   foreignKey: 'id',
  // })
  // public address: HasOne<typeof Address>;

  // ...
}  
  