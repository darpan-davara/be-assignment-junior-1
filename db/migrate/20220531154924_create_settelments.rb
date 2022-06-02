class CreateSettelments < ActiveRecord::Migration[6.1]
  def change
    create_table :settelments do |t|
      t.float :amount
      t.bigint :paid_to_id
      t.bigint :paid_by_id
      t.date :paid_date
      t.text :description

      t.timestamps
    end
  end
end
