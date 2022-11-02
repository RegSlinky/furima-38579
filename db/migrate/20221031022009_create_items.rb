class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :item,                    null: false
      t.integer    :price,                   null: false
      t.text       :item_text,               null: false
      t.integer    :category_id,             null: false
      t.integer    :sales_status_id,         null: false
      t.integer    :shipping_fee_status_id , null: false
      t.integer    :prefecture_id ,          null: false
      t.integer    :schedule_delivery_id,    null: false
      t.references :user,                    null: false, foreign_key: true
      t.timestamps
    end
  end
end
