<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= class_name %>Controller < ApplicationController
  # Cancan authorization
  authorize_resource

<% actions.each do |action| -%>
  def <%= action %>; end
<% end -%>

end
<% end -%>

