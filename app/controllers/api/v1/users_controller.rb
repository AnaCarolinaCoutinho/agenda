class Api::V1::UsersController < Api::V1::ApiController
 
    before_action :set_user, only: [:show, :update, :destroy]
    
    # before_action :require_authorization!, only: [:show, :update, :destroy]
    
    # GET /api/v1/users
    
    # def index
    
    #   @users = current_user.users
    
    #   render json: @users
    
    # end
    
    # GET /api/v1/users/1
    
    def show
    
      render json: @user
    
    end
    
    # POST /api/v1/users
    def create
    
      #@user = User.new(user_params.merge(user: current_user))
      @user = User.new(user_params)
      if @user.save
    
        render json: @user, status: :created
    
      else
    
        render json: @user.errors, status: :unprocessable_entity
    
      end
    
    end
    
    # PATCH/PUT /api/v1/user/1
    
    def update
    
      if @user.update(user_params)
    
        render json: @user
    
      else
    
        render json: @user.errors, status: :unprocessable_entity
    
      end
    
    end
    
    # DELETE /api/v1/users/1
    
    def destroy
    
      @user.destroy
    
    end
    
    private
    
      # Use callbacks to share common setup or constraints between actions.
    
      def set_user
    
        @user = User.find(params[:id])
    
      end
    
      # Only allow a trusted parameter "white list" through.
    
      def user_params

        params.require(:user).permit(:name, :email, :password)
    
      end
    
      def require_authorization!
    
        unless current_user == @user.user
    
          render json: {}, status: :forbidden
    
        end
    
      end
    
   end