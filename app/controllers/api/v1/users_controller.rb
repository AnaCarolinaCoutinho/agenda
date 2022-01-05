class Api::V1::UsersController < Api::V1::ApiController
 
    before_action :set_user, only: [ :show, :update, :destroy]
    
    # before_action :require_authorization!, only: [:show, :update, :destroy]
    
    # GET /api/v1/users
    
    def index
      if current_user.role
        @users = User.all
        render json: @users
        return
      else
        render json: {errors: ["Você não tem permissão para visualizar a lista de usuários."]}, status: 401 
      end 
    end
    
    # GET /api/v1/users/1
    
    def show
      if current_user.role
        render json: @user
        return
      end
      render json: {errors: ["Você não tem permissão para visualizar usuários."]}, status: 401  
    end
    
    # POST /api/v1/users
    def create
      if current_user.role
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
        return 
      end 
      render json: {errors: ["Você não tem permissão para criar usuário."]}, status: 401
    end
    
    # PATCH/PUT /api/v1/user/1
    
    def update
      if current_user.role
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
        return
      end
      render json: {errors: ["Você não tem permissão para alterar usuário."]}, status: 401
    end
    
    # DELETE /api/v1/users/1
    
    def destroy
      if current_user.role
        @user.destroy
        return
      end
      render json: {errors: ["Você não tem permissão para deletar usuário."]}, status: 401
    end
    
    private
    
      # Use callbacks to share common setup or constraints between actions.
    
    def set_user
      @user = User.find(params[:id])
    end
  
    # Only allow a trusted parameter "white list" through.
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :role)
    end
  
    def require_authorization!
      unless current_user == @user.user
        render json: {}, status: :forbidden
      end
    end
end