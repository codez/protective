ActiveRecord::Schema.define(:version => 0) do
  create_table :subjects, :force => true do |t|
    t.string :name
    t.boolean :marked
  end
  create_table :attachments, :force => true do |t|
    t.string :name
    t.integer :subject_id
  end
end