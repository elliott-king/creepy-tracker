class CreateFingerprints < ActiveRecord::Migration[6.0]
  def change
    create_table :fingerprints do |t|
      t.string :width
      t.string :height
      t.string :depth
      t.string :timezone
      
      t.string :user_agent
      t.string :accept_headers
      t.string :accept_encoding
      t.string :accept_language

      t.boolean :cookies_enabled

      t.text :serialized
      t.text :plugins
      t.text :fonts

      t.integer :user_id
      t.timestamps
    end
  end
end
