class SessionsController < ApplicationController
   #POST /login
    def create
      user = User.find_by(username:params[:username]) #First fmind the uer who has the same username
      session[:user_id] = user.id#Then set a session for the user
      render json: user #Return the user information
    end

    #GET /me
    def show
        logged_user = User.find(session[:user_id]) #Find the user who has the same Id as the current.
        if logged_user
            render json: logged_user
        else
            render json: {error:"You are not authorised coz you are not logged in!"}, status: :unauthorized
        end
    end

    #DELETE /logout
    def destroy
        session.delete :user_id #clear the sessio cookie that carries the logged in information.
        head :no_content
    end
end
