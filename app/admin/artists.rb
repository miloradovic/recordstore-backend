ActiveAdmin.register Artist do
  permit_params :name, :updated_at, :user_id

  config.create_another = true

  index do
    selectable_column
    column :name
    column "Created by" do |u|
      usr = User.find(u.user_id) unless u.user_id.nil?
      link_to usr.email, admin_user_path(u.user_id) unless u.user_id.nil?
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :user_id, as: :select, collection: -> {
    User.all.map { |usr| [usr.email, usr.id] }
  }
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :user_id, label: "User", as: :select, collection: User.all
    end
    f.actions
  end
end
