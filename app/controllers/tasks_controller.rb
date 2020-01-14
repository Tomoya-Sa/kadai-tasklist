class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
    def index
        @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(5)
        #@tasks = Tasks.where(user_id: current_user.id).order(id: :desc).page(params[:page]).per(5)
    end
    
    def create
        @task = Task.new(task_params)
        @task.user = current_user
        if @task.save
            flash[:success] = '新しいタスクが入力されました'
            # @msg = '新しいタスクが入力されました'
            redirect_to 
        else
            flash.now[:danger] = '入力に失敗しました'
            render :new
        end
    end
    
    def new
        @task = Task.new
    end
    
    def edit
    end
    
    def show
    end
    
    def update
        
        if @task.update(task_params)
            flash[:success] = 'Taskは正常に更新されました'
            redirect_to @task
        else
            flash.now[:danger] = 'Taskは更新されませんでした'
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = 'Taskは正常に削除されました'
        redirect_to tasks_url
    end
    
    private
    
    def set_task
      @task = Task.find(params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
     unless @task
     redirect_to root_url
     end
    end
    
end
