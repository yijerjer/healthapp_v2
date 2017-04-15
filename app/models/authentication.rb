class Authentication < ApplicationRecord
  belongs_to :user

  def self.create_from_omniauth(auth_hash)
    Authentication.create(provider: auth_hash.provider, uid: auth_hash.uid, token: auth_hash.credentials.token)
  end

  def update_token(auth_hash)
    self.update(token: auth_hash.credentials.token)
  end
end
