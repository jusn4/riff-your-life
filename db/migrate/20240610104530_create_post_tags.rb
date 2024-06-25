class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.references :post, foreign_key: true, null: false
      t.references :tag, foreign_key: true, null: false

      t.timestamps
    end
    #同じタグは2回保存できない
    add_index :tags, :name, unique:true
  end
end
