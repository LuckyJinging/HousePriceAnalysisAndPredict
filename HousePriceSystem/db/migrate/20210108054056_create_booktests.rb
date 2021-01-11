class CreateBooktests < ActiveRecord::Migration[6.0]
  def change
    create_table :booktests do |t|

      t.timestamps
    end
  end
end
