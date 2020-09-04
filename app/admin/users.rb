ActiveAdmin.register User do
  permit_params :email, artists_ids: [], records_ids: []
  actions :all, except: [:new]

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    column :updated_at
    actions
  end

  filter :email
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
    end
    f.actions
  end
end
