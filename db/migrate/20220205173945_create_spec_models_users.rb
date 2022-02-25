class CreateSpecModelsUsers < ActiveRecord::Migration
  def change
    create_table :spec_models_users do |t|

      t.timestamps null: false
    end
  end
end