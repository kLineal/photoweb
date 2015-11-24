class CreateCollectionTagsViewsJoinTable < ActiveRecord::Migration
  
  # This migration has been created manually.
  # See the API 
  #(http://apidock.com/rails/ActiveRecord/Associations/ClassMethods/has_and_belongs_to_many)

  def change
    create_table :collection_tags_views, id: false do |t|
      t.integer :collection_tag_id
      t.integer :collection_view_id
    end
  end

end
