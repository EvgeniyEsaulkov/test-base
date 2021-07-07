require "tasks/support/remove_invalid_accounts"

namespace :accounts do
  desc "Remove invalid accounts having no owner"
  task remove_invalid: :environment do
    RemoveInvalidAccounts.new.perform
  end
end
