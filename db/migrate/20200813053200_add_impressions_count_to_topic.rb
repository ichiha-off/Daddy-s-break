class AddImpressionsCountToTopic < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :impressions_count, :integer, null: false, default: 0
  end
end
