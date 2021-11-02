# frozen_string_literal: true

module ListsHelper
  def owner_of_list?(id)
    id == current_user.id
  end
end
