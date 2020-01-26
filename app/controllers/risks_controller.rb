class RisksController
  def update_from_origin
    SourceTrackableUpdater.new(trackable_resource).update_from_origin

    redirect_to trackable_resource
  end
end
