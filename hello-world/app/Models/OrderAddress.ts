import { DateTime } from 'luxon'
import Hash from '@ioc:Adonis/Core/Hash'
import { column, beforeSave, BaseModel } from '@ioc:Adonis/Lucid/Orm'

export default class OrderAddress extends BaseModel {
    @column({ isPrimary: true })
    public id: number

    @column({ serializeAs: "order_id" })
    public orderId: number

    @column({ serializeAs: "longitude" })
    public longitude: number

    @column({ serializeAs: "latitude" })
    public latitude: number

    @column({ serializeAs: "city" })
    public city: String

    @column({ serializeAs: "country" })
    public country: String

    @column({ serializeAs: "area" })
    public area: String

    @column({ serializeAs: "street" })
    public street: String

    @column({ serializeAs: "building_no" })
    public buildingNo: String

    @column.dateTime({ autoCreate: true })
    public createdAt: DateTime

    @column.dateTime({ autoCreate: true, autoUpdate: true })
    public updatedAt: DateTime

}