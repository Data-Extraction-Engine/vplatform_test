module Api
    module Partners
      module V1
        class RadarController < Api::Partners::V1::BaseController
          def index


            @radius = params[:radius]
            @near = params[:lat]+","+params[:lon]
            @response = RestClient.get 'https://api.radar.io/v1/search/users', {:Authorization => 'prj_live_sk_97250f7af7c1ed7c165e7cd596d058346cb379c8', :params => {:near => @near, :radius => @radius, :limit => "10"}}
            
            render json: @response

          end

         
        end
      end
    end
  end
  
  
