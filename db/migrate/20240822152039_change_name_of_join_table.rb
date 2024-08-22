# frozen_string_literal: true

class ChangeNameOfJoinTable < ActiveRecord::Migration[7.1]
  def change
    rename_table :members_projects_joins, :members_projects
  end
end
