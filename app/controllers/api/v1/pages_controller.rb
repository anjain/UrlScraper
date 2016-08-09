module Api
  module V1
    class PagesController < ApplicationController
      skip_before_filter :verify_authenticity_token, only: [:get_data]
      
      # GET /api/v1/pages
      def index
        @pages = Page.all
        render json: @pages, status: 200
      end

      # GET /api/v1/pages/get_data.json
      def get_data
        @page = Page.find_or_initialize_by(url: params[:url])

        begin
          get_website_details(params[:url])
          if @page.save
            render json: @page, status: 200
          else
            render json: 'Something went wrong'
          end
        rescue HTTParty::Error
          render json: 'Issue with fetching the content'
        rescue Exception => e
          render json: { error: 'Invalid parameters'}, status: 400
        end
      end

      private
        def get_website_details website_url
          response = HTTParty.get(website_url)
          doc = Nokogiri::HTML(response.body)

          header_tags = ['h1', 'h2', 'h3', 'a']
          header_tags.each do |html_tag|
            tag_values = []
            doc.css(html_tag).map do |node|
              tag_values << case html_tag
                            when 'a'
                              node['href']
                            else
                              node.text
                            end
            end
            @page.send "#{html_tag}=".to_sym, tag_values
          end
        end

    end
  end
end