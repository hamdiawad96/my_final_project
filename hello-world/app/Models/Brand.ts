import { DateTime } from 'luxon'
import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'

export default class Brand extends BaseModel {

  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs: "name", })
  public name: string;

  
  @column({ serializeAs: "image" })
  public image: String

  
}