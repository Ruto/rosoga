module V1
  class OrganizationsController < ApplicationController
    before_action :set_organization, only: [:show, :update, :destroy]
    before_action :authenticate_user!

    # GET /organizations
    # GET /organizations.json
    def index
      @organizations = Organization.all
    end

    # GET /organizations/1
    # GET /organizations/1.json
    def show
    end

    # POST /organizations
    # POST /organizations.json
    def create
      @organization = Organization.new(organization_params)
      @organization.user_id = @current_user.id
      @organization.type = "Organizations::#{@organization.category}"

      if @organization.save

        @structure = Structure.create(:name => "#{@organization.name} #{@organization.category.pluralize}", :parent => get_parent, :structurable_id => @organization.id, :structurable_type => "Organization", :category => @organization.category, :user_id => @organization.user_id)
        Structure.create(:name => "#{@organization.name} Incomes", :parent => get_income_parent, :type => "Structures::Income", :structurable_id => @organization.id, :structurable_type => "Organization", :category => "Income", :structure_id => @structure.id, :user_id => @organization.user_id, :active => @organization.income)
        Structure.create(:name => "#{@organization.name} DirectExpenses", :parent => get_direct_expense_parent, :type => "Structures::DirectExpense", :structurable_id => @organization.id, :structurable_type => "Organization", :category => "DirectExpense", :structure_id => @structure.id, :user_id => @organization.user_id, :active => @organization.direct_expense)
        Structure.create(:name => "#{@organization.name} IndirectExpenses", :parent => get_indirect_expense_parent, :type => "Structures::IndirectExpense", :structurable_id => @organization.id, :structurable_type => "Organization", :category => "IndirectExpense", :structure_id => @structure.id, :user_id => @organization.user_id, :active => @organization.indirect_expense)
        Structure.create(:name => "#{@organization.name} AdministrativeCost", :parent => get_administrative_cost_parent, :type => "Structures::AdministrativeCost", :structurable_id => @organization.id, :structurable_type => "Organization", :category => "AdministrativeCost", :structure_id => @structure.id, :user_id => @organization.user_id, :active => @organization.administrative_cost)

        render :create, status: :created, locals: { organization: @organization  }
        #render :show, status: :created, location: @organization
      else
        render json: @organization.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /organizations/1
    # PATCH/PUT /organizations/1.json
    def update
      if @organization.update(organization_params)
        render :show, status: :ok, location: @organization
      else
        render json: @organization.errors, status: :unprocessable_entity
      end
    end

    # DELETE /organizations/1
    # DELETE /organizations/1.json
    def destroy
      @organization.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_organization
        @organization = Organization.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def organization_params
        params.permit(:name, :alias, :type, :ancestry, :category, :income, :direct_expense, :indirect_expense, :administrative_cost, :active, :organization_id, :organizable_id, :organizable_type, :user_id)
      end

      def get_parent
          if @organization.parent != nil and @organization.structures.empty? != true
             @organization.parent.structures.first
          else
            return nil
          end
      end

      def get_income_parent
          if @structure.parent != nil
             @organization.parent.structures.find_by_type("Structures::Income")
          else
            return nil
          end
      end
      def get_direct_expense_parent
          if @structure.parent != nil
             @organization.parent.structures.find_by_type("Structures::DirectExpense")
            #Structures::DirectExpense.find_by(:structure_id => @structure.parent.id)
          else
            return nil
          end
      end
      def get_indirect_expense_parent
          if @structure.parent != nil
            @organization.parent.structures.find_by_type("Structures::IndirectExpense")
            # Structures::IndirectExpense.find_by(:structure_id => @structure.parent.id)
          else
            return nil
          end
      end
      def get_adminstrative_cost_parent
          if @structure.parent != nil
            @organization.parent.structures.find_by_type("Structures::AdminstrativeCost")
            # Structures::AdminstrativeCost.find_by(:structure_id => @structure.parent.id)
          else
            return nil
          end
      end
      
  end
end
