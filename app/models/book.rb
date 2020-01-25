class Book
  attr_accessor :filename, :file_destroyed_at

  def file_url
    "/system/#{path_prefix}/#{filename}"
  end

  def delete_file
    self.filename = nil
    self.file_destroyed_at = Time.zone.now
    save
  end

  private

  def path_prefix
    filename[0..1].downcase
  end
end
