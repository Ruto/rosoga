module V1
  class StructuresController < ApplicationController
    before_action :set_structure, only: [:show, :update, :destroy]
    before_action :authenticate_user!

    # GET /structures
    # GET /structures.json
    def index
      @structures = Structure.all
    end

    # GET /structures/1
    # GET /structures/1.json
    def show
    end

    # POST /structures
    # POST /structures.json
    def create
      @structure = Structure.new(structure_params)
      @structure.user_id = @current_user.id

      if @structure.save
        render :show, status: :created, location: @structure
      else
        render json: @structure.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /structures/1
    # PATCH/PUT /structures/1.json
    def update
      if @structure.update(structure_params)
        render :show, status: :ok, location: @structure
      else
        render json: @structure.errors, status: :unprocessable_entity
      end
    end

    # DELETE /structures/1
    # DELETE /structures/1.json
    def destroy
      @structure.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_structure
        @structure = Structure.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def structure_params
        params.permit(:name, :alias, :type, :ancestry, :category, :active, :structure_id, :structurable_id, :structurable_type, :user_id)
      end
  end
end
