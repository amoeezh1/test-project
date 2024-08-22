# frozen_string_literal: true

class CreateMembersProjectsJoin < ActiveRecord::Migration[7.1]
  def change
    create_table :members_projects_joins do |t|
      t.column :member_id, :integer
      t.column :project_id, :integer
      t.timestamps
    end
  end
end
