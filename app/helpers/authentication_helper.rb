module AuthenticationHelper
  SECRET_KEY = Rails.application.secret_key_base.to_s

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    begin
      decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })
      decoded.first
    rescue JWT::DecodeError => e
      render json: { error: "JWT Decode Error: #{e.message}" }, status: :unauthorized
    end
  end
end
