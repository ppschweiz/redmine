class GoogleAd < ActiveRecord::Base
    validates_presence_of :hook, :html_code
    validates_uniqueness_of :hook
    validates_length_of :hook, :maximum => 255
    validates_format_of :hook, :with => /^[a-z]+(_[a-z]+)+$/
end
