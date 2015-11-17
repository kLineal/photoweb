class CreateCollectionPhotos < ActiveRecord::Migration
  def change
    create_table :collection_photos do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
