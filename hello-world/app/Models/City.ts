// import { BaseModel, belongsTo, BelongsTo, column } from '@ioc:Adonis/Lucid/Orm'
// import { DateTime } from 'luxon'
// import Country from './Country';

// export default class City extends BaseModel {
//   public static table = "cities";

//   @column({ isPrimary: true })
//   public id: number

//   @column({ serializeAs: "city", })
//   public city: string;

//   @column({ serializeAs: "country_id", })
//   public country_id: number;

//   @column.dateTime({ autoCreate: true })
//   public createdAt: DateTime

//   @column.dateTime({ autoCreate: true, autoUpdate: true })
//   public updatedAt: DateTime

//   @belongsTo(() => Country, {
//     foreignKey: 'country_id',
//   })
//   public countryId: BelongsTo<typeof Country>
// }