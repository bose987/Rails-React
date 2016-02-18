class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new

    if user.role == "admin"
        can :manage, :all
    elsif user.role == "engineer"
       can [ :create, :my_profile ], UsersController
       can [ :index, :create, :permitted_params, :expense_rules, :notify_manager, :view_user_expenses ], ExpensesController
    elsif user.role == "lead"
        can [ :create, :my_profile ], UsersController
        can [ :index, :notify_manager, :expense_rules, :view_expenses ], ExpensesController
        can [ :index, :approve_expense, :reject_approval ], NotificationsController
    else
        #can :manage, :all
    end


    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end

    def role?(role)
        return !!self.roles.find_by_name(role.to_s.camelize)
    end
end
