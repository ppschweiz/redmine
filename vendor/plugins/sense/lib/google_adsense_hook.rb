class GoogleAdsenseHook  < Redmine::Hook::ViewListener

    def view_layouts_base_html_head(context = {})
        stylesheet_link_tag('google', :plugin => 'sense')
    end

    def respond_to?(method)
        if Google::AdSense::Placeholders[method.to_s]
            true
        else
            super
        end
    end

    def method_missing(sym, *args, &block)
        if Google::AdSense::Placeholders[sym.to_s]
            google_ad = GoogleAd.find_by_hook(sym.to_s)
            if google_ad
                return google_ad.html_code
            end
        end
        return ''
    end

end
