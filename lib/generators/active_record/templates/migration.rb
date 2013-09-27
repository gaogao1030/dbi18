class CreateCimuDbi18 < ActiveRecord::Migration
  def change
    create_table(:<%= table_name %>) do |t|
      t.integer :class_id
      t.string  :class_name
      t.string  :language_type
      t.text    :hash_content
      t.timestamps
    end

    add_index(:<%= table_name %>, :class_id)
    add_index(:<%= table_name %>, :class_name)
    add_index(:<%= table_name %>, :language_type)
    add_index(:<%= table_name %>, :hash_content)
  end
end
