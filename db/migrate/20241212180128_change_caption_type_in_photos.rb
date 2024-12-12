class ChangeCaptionTypeInPhotos < ActiveRecord::Migration[6.1]
  def change
    change_column :photos, :caption, :text
  end
end
