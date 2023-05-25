class Ability
  include CanCan::Ability
  def initialize(user)
    return unless user.present?

    can :read, :all
    can :create, :all
    can :destroy, Recipe do |recipe|
      recipe.user == user
    end

    can :update, Recipe do |recipe|
      recipe.user == user
    end
  end
end
