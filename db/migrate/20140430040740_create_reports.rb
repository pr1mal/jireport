class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.datetime :generated_at

      t.timestamps
    end
  end
end
