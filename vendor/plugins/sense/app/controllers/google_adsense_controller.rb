class GoogleAdsenseController < ApplicationController
    layout 'admin'

    before_filter :require_admin

    def index
        @placeholders = placeholders
        @placeholder = params[:hook] ? Google::AdSense::Placeholders[params[:hook]] : @placeholders.first
        @google_ad = GoogleAd.find_by_hook(@placeholder['hook'])
    end

    def load
        if params[:hook]
            @placeholders = placeholders
            @placeholder = Google::AdSense::Placeholders[params[:hook]]
            @google_ad = GoogleAd.find_by_hook(params[:hook])
            render(:layout => !request.xhr?)
        else
            redirect_to(:action => 'index')
        end
    end

    def update
        @placeholders = placeholders
        @placeholder = Google::AdSense::Placeholders[params[:hook]]
        @google_ad = GoogleAd.find_by_hook(params[:hook])
        if @google_ad
            if params[:html_code].blank?
                if @google_ad.destroy
                    flash[:notice] = l(:notice_successful_delete)
                    @google_ad = nil
                end
            else
                if @google_ad.update_attributes(:html_code => params[:html_code])
                    flash[:notice] = l(:notice_successful_update)
                end
            end
        else
            @google_ad = GoogleAd.new(:hook => params[:hook], :html_code => params[:html_code])
            if @google_ad.save
                flash[:notice] = l(:notice_successful_create)
            end
        end
        render(:action => 'index')
    end

private

    def placeholders
        google_ads = GoogleAd.find(:all)
        google_ads.each do |google_ad|
            if Google::AdSense::Placeholders[google_ad.hook]
                Google::AdSense::Placeholders[google_ad.hook]['html_code'] = google_ad.html_code
            end
        end
        Google::AdSense::Placeholders.sort{ |a,b|
            a_desc = a[1]['description'][current_language.to_s] ? a[1]['description'][current_language.to_s] : a[1]['description']['en']
            b_desc = b[1]['description'][current_language.to_s] ? b[1]['description'][current_language.to_s] : b[1]['description']['en']
            a_desc <=> b_desc
        }.collect{ |item| item[1] }
    end

end
