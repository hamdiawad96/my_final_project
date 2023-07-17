import { BaseModel, belongsTo, BelongsTo, column } from '@ioc:Adonis/Lucid/Orm';
import { DateTime } from 'luxon';
import Order from './Order';
import Product from './Product';

export default class OrderItem extends BaseModel {
  @column({ isPrimary: true })
  public id: number


  @column({ serializeAs: "order_id" })
  public orderId: number

  @column({ serializeAs: "product_id" })
  public productId: number

  @column({ serializeAs: "qty" })
  public qty: number

  @column({ serializeAs: "price" })
  public price: number




  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime



  @belongsTo(() => Order, {
    foreignKey: 'orderId',
  })
  public orderName: BelongsTo<typeof Order>

  @belongsTo(() => Product, {
    foreignKey: 'productId',
  })
  public productName: BelongsTo<typeof Product>

}
