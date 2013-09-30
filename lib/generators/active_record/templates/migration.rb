class Create<%= class_name %>< ActiveRecord::Migration
  def change
    create_table(:<%= table_name %>) do |t|
      t.integer :classtable_id
      t.string  :classtable_type
      t.string  :locale
      t.text    :hash_content
      t.timestamps
    end

    add_index(:<%= table_name %>, :classtable_id)
    add_index(:<%= table_name %>, :classtable_type)
    add_index(:<%= table_name %>, :locale)
    add_index(:<%= table_name %>, :hash_content)
  end
end
