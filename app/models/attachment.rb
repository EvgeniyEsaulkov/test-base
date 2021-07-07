class Attachment < ActiveRecord::Base
  MAX_ATTACHMENT_SIZE = 1.gigabyte

  validate :file_size_is_limited

  private

  def file_size_is_limited
    if attachment_size > MAX_ATTACHMENT_SIZE
      errors.add(:attachment, "size is limited to 1GB per attachment")
    end
  end
end
