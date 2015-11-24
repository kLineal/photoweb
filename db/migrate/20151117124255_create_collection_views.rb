class CreateCollectionViews < ActiveRecord::Migration
  def change
    create_table :collection_views do |t|
      t.string :name
      t.string :view_type

      t.timestamps null: false
    end
  end
end
