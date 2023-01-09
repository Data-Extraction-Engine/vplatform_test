module Api
  module V1
    class QrController < Api::V1::BaseController

      def index

        vista_id = "Vista ID "+current_user.member_id

        qrcode = RQRCode::QRCode.new(vista_id)

        png = qrcode.as_png(
          bit_depth: 1,
          border_modules: 4,
          color_mode: ChunkyPNG::COLOR_GRAYSCALE,
          color: "black",
          file: nil,
          fill: "white",
          module_px_size: 6,
          resize_exactly_to: false,
          resize_gte_to: false,
          size: 240,
        )
        

        render json: Base64.encode64(png.to_s)

      end
    end
  end
end
