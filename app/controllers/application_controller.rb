class ApplicationController < ActionController::Base
    before_action :get_params
    add_breadcrumb "Home", :root_path

    def get_params
        @q = Article.ransack(params[:q])
        @paramsFromUrl = "#{params[:id]}"  # '/categories/sharing'  => @paramsFromUrl = sharing
    end

    # def default_url_options(options={})
    #     logger.debug "default_url_options is passed options: #{options.inspect}\n"
    #     { :locale => I18n.locale }
    # end
end
