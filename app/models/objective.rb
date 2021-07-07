class Objective
  include ActiveModel::AttributeAssignment

  LOCK_STATUSES = {
    unlocked: 0,
    uploading: 1,
    locked: 2
  }.freeze

  attr_accessor :locked_by, :locked_on_name, :locked_on_id, :lock_status

  def locked?
    locked_by.present? &&
      [LOCK_STATUSES[:uploading], LOCK_STATUSES[:locked]].include?(lock_status)
  end

  def release_lock
    assign_attributes(
      locked_by: nil,
      locked_on_name: nil,
      locked_on_id: nil,
      lock_status: LOCK_STATUSES[:unlocked]
    )
  end
end
