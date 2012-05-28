class CreateGoogleAds < ActiveRecord::Migration

    def self.up
        create_table :google_ads do |t|
            t.column :hook,      :string, :null => false
            t.column :html_code, :text,   :null => false
        end
        add_index :google_ads, :hook, :name => :google_ads_hook
    end

    def self.down
        drop_table :google_ads
    end

end
