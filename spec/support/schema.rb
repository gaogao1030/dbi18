ActiveRecord::Schema.define do

  create_table(:sub1s) do |t|
  end

  create_table(:sub2s) do |t|
    t.string :name
  end

  create_table(:sub3s) do |t|
  end

  create_table(:cimus) do |t|
      t.integer :class_id
      t.string  :class_name
      t.string  :language_type
      t.text    :hash_content
      t.timestamps
    end

    add_index(:cimus, :class_id)
    add_index(:cimus, :class_name)
    add_index(:cimus, :language_type)
    add_index(:cimus, :hash_content)

end
