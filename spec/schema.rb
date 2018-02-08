ActiveRecord::Schema.define do
  self.verbose = false

  create_table :double_hamburgers, :force => true do |t|
    t.string :name
  end

   create_table :patties, :force => true do |t|
   	t.integer :double_hamburger_id,   null: false
    t.string  :meat_type,             null: false
  end
end