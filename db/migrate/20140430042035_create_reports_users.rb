class CreateReportsUsers < ActiveRecord::Migration
  def change
    create_table :reports_users do |t|
      t.references :report, index: true
      t.references :user, index: true
      t.string :vac
      t.boolean :on_track
      t.string :delay_details
      t.string :recovery_plan
      t.text :comments
      t.boolean :user_report_ready

      t.timestamps
    end
  end
end
