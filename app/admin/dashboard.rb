ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Artists" do
          ul do
            Artist.last(5).map do |artist|
              li link_to(artist.name, admin_artist_path(artist))
            end
          end
        end
        panel "Recent Users" do
          ul do
            User.last(5).map do |user|
              li link_to(user.email, admin_user_path(user))
            end
          end
        end
      end

      column do
        panel "Graph #1 - Artists by number of records" do
          pie_chart Artist.joins(:records).group(:name).count(:title)
        end
        panel "Graph #2 - Created records per day" do
          line_chart Record.group_by_day(:created_at).count
        end
      end
    end
  end
end
# content title: proc { I18n.t("active_admin.dashboard") } do
#  div class: "blank_slate_container", id: "dashboard_default_message" do
#    span class: "blank_slate" do
#      span I18n.t("active_admin.dashboard_welcome.welcome")
#      small I18n.t("active_admin.dashboard_welcome.call_to_action")
#    end
#  end
