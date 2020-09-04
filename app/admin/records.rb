ActiveAdmin.register Record do
  # belongs_to :user, optional: true
  permit_params :title, :year, user_id: [], artist_id: []
  actions :all, except: [:new]

  config.create_another = true

  index do
    selectable_column
    id_column
    column :title
    column :year
    column "Artist" do |a|
      art = Artist.find(a.artist_id) unless a.artist_id.nil?
      link_to art.name, admin_artist_path(a.artist_id) unless a.artist_id.nil?
    end
    column :user
    column :created_at
    column :updated_at
    actions
  end

  filter :title
  filter :year
  filter :artist
  filter :user
  filter :artist_id, label: "Artist", as: :select, collection: -> {
    Artist.all.map { |art| [art.name, art.id] }
  }

  form do |f|
    f.inputs do
      f.input :user_id, label: "User", as: :select, collection: User.all
      f.input :artist_id, label: "Artist", as: :select, collection: Artist.all
      f.input :title
      f.input :year
    end
    f.actions
  end
end
