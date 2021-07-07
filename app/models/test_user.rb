class TestUser < TestExample
  before_validation :set_access_token

  def date_format
    super.presence || "%d.%m.%Y"
  end

  private

  def set_access_token
    self.access_token ||= SecureRandom.uuid
  end
end
