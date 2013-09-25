class CreateCimuDbi18 < ActiveRecord::Migration
  def change
    create_table(:cimu_dbi18s) do |t|
      t.integer :class_id
      t.string  :class_name
      t.string  :property
      t.text  :hash_content
      t.timestamps
    end

    add_index(:cimu_dbi18s, :class_id)
    add_index(:cimu_dbi18s, :class_name)
    add_index(:cimu_dbi18s, :property)
    add_index(:cimu_dbi18s, :hash_content)
  end
end
