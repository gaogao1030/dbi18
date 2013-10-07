# -*- encoding : utf-8 -*-
class Create<%= class_name %>< ActiveRecord::Migration
  def change
    create_table(:<%= table_name %>) do |t|
      t.integer :class_id
      t.string  :class_name
      t.string  :locale
      t.text    :hash_content
      t.timestamps
    end

    add_index(:<%= table_name %>, :class_id)
    add_index(:<%= table_name %>, :class_name)
    add_index(:<%= table_name %>, :locale)
    add_index(:<%= table_name %>, :hash_content)
  end
end
