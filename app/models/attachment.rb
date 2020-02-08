class Attachment
  MS_OFFICE_TYPES = [
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    "application/vnd.openxmlformats-officedocument.presentationml.presentation",
    "application/msword",
    "application/vnd.ms-excel",
    "application/vnd.ms-powerpoint"
  ].freeze

  attr_reader :attachment_content_type, :locked_until

  def initialize(attachment_content_type, locked_until = nil)
    @attachment_content_type = attachment_content_type
    @locked_until = locked_until
  end

  def editable?
    MS_OFFICE_TYPES.include?(attachment_content_type)
  end

  def locked?
    locked_until && locked_until > Time.zone.now
  end
end
