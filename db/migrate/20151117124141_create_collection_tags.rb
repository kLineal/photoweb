class CreateCollectionTags < ActiveRecord::Migration
  def change
    create_table :collection_tags do |t|
      t.string :keyword

      t.timestamps null: false
    end
  end
end
