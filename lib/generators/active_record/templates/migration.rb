class CreateCimuDbi18 < ActiveRecord::Migration
  def change
    create_table(:cimu_dbi18s) do |t|
      t.integer :class_id
      t.string  :class_name
      t.string  :language_type
      t.text  :hash_content
      t.timestamps
    end

    add_index(:cimu_dbi18s, :class_id)
    add_index(:cimu_dbi18s, :class_name)
    add_index(:cimu_dbi18s, :language_type)
    add_index(:cimu_dbi18s, :hash_content)
  end
end
