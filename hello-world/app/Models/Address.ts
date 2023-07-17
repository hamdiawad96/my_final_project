// import { DateTime } from 'luxon'
// import { BaseModel, belongsTo, BelongsTo, column } from '@ioc:Adonis/Lucid/Orm'
// import City from './City';

// export default class Address extends BaseModel {
//   public static table = "staffs";

//   @column({ isPrimary: true })
//   public id: number

//   @column({ serializeAs: "address", })
//   public address: string;

//   @column({ serializeAs: "city", })
//   public city: string;

//   @column({ serializeAs: "country", })
//   public country: string;


//   // @column({ serializeAs: "city_id", })
//   // public city_id: number;

//   @column({ serializeAs: "phone", })
//   public phone: string;

//   @column.dateTime({ autoCreate: true })
//   public createdAt: DateTime

//   @column.dateTime({ autoCreate: true, autoUpdate: true })
//   public updatedAt: DateTime

//   // @belongsTo(() => City, {
//   //   foreignKey: 'cityId',
//   // })
//   // public cityName: BelongsTo<typeof City>
// }