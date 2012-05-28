module GoogleAdsenseHelper

    def placeholders_options_for_select(placeholders, selected)
        s = ''
        placeholders.each do |placeholder|
            tag_options = { :value => placeholder['hook'] }
            tag_options[:selected] = 'selected' if (placeholder['hook'] == selected['hook'])
            tag_options[:class] = 'google-ad' if placeholder['html_code'] # TODO: does not work under e.g. Chrome
            name = placeholder['description'][current_language.to_s] ? placeholder['description'][current_language.to_s] : placeholder['description']['en']
            s << content_tag(:option, name, tag_options)
        end
        s
    end

end
