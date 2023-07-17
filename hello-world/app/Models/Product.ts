import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import Brand from './Brand';
import Category from './Category';

export default class Product extends BaseModel {
  @column({ isPrimary: true })
  public id: number

 
  @column({ serializeAs: "product_title", })
  public product_title: string;

   
  @column({ serializeAs: "description", })
  public description: string;


  
  // @column({ serializeAs: "brand_id", })
  // public brandId: number;

  
  @column({ serializeAs: "category_id", })
  public categoryId: number;

    
  @column({ serializeAs: "image", })
  public image: string;

  
  @column({ serializeAs: "price", })
  public price: number;

  
  @column({ serializeAs: "active" })
  public active: boolean

  
  @column({ serializeAs: "current_qty" })
  public currentQty: number
  
  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  
  // @belongsTo(() => Brand, {
  //   // foreignKey: 'brand_id',
  // })
  // public brand: BelongsTo<typeof Brand>

  @belongsTo(() => Category)
  public category: BelongsTo<typeof Category>
}