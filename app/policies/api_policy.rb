class ApiPolicy < ApplicationPolicy
  class Scope < Scope; end

  def environment_variables?
    # for now only admin can retrieve env-vars
    user.admin?
  end

end
