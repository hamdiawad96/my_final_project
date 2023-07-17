// import { DateTime } from 'luxon'
// import { BaseModel, BelongsTo, belongsTo, column, } from '@ioc:Adonis/Lucid/Orm'
// import Staff from './Staff';
// import User from './User';

// export default class Payment extends BaseModel {
//   @column({ isPrimary: true })
//   public id: number

//   public static table = 'users';

//   @column({ serializeAs: "user_id", })
//   public userId: number;

   
//   @column({ serializeAs: "stuff_id", })
//   public stuffId: number;

   
//   @column({ serializeAs: "payment_date", })
//   public paymentDate: DateTime;

    
//   @column({ serializeAs: "amount", })
//   public amount: number;


//   @column.dateTime({ autoCreate: true })
//   public createdAt: DateTime

//   @column.dateTime({ autoCreate: true, autoUpdate: true })
//   public updatedAt: DateTime

  
//   @belongsTo(() => User, {
//     foreignKey: 'userId',
//   })
//   public userName: BelongsTo<typeof User>

//   @belongsTo(() => Staff, {
//     foreignKey: 'staffId',
//   })
//   public staffName: BelongsTo<typeof Staff>
//     payment: DateTime;

// }
