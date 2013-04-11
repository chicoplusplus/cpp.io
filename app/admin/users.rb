ActiveAdmin.register User do
  # Filterable attributes on the index screen
  filter :first_name
  filter :last_name
  filter :email

  # Customize columns displayed on the index screen in the table
  index do
    column :first_name
    column :last_name
    column :email
    default_actions
  end

  # Custom form that handles roles
  form :partial => "form"
end
