ActiveAdmin.register Post do
  permit_params :title, :description, :user_id

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  index do
    selectable_column
    id_column
    column :title
    column :description
    actions
  end

  filter :name
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :title
      f.input :description
    end
    f.actions
  end


end
