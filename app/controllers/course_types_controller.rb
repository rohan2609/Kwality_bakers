class CourseTypesController < ApplicationController
  before_action :set_course_type, only: [:show, :edit, :update, :destroy]

  # GET /course_types
  # GET /course_types.json
  def index
    if current_user.role == 'Center'
      @course_types = current_user.center.course_types
      @general_setting = GeneralSetting.first
    else
       @course_types = CourseType.all
       @general_setting = GeneralSetting.first
       @user = User.first
    end
  end

  # GET /course_types/1
  # GET /course_types/1.json
  def show
  end

  # GET /course_types/new
  def new
    @course_type = CourseType.new
    @general_setting = GeneralSetting.first
  end

  # GET /course_types/1/edit
  def edit
  end

  # POST /course_types
  # POST /course_types.json
  def create
    @course_type = CourseType.new(course_type_params)
    if current_user.role == 'Center'
      @course_type.update!(center_id: current_user.center.id)
    end
    respond_to do |format|
      if @course_type.save
        format.html { redirect_to course_types_path, notice: 'Course type was successfully created.' }
        format.json { render :show, status: :created, location: @course_type }
      else
        format.html { render :new }
        format.json { render json: @course_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_types/1
  # PATCH/PUT /course_types/1.json
  def update
    respond_to do |format|
      if @course_type.update(course_type_params)
        format.html { redirect_to @course_type, notice: 'Course type was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_type }
      else
        format.html { render :edit }
        format.json { render json: @course_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_types/1
  # DELETE /course_types/1.json
  def destroy
    @course_type.destroy
    respond_to do |format|
      format.html { redirect_to course_types_url, notice: 'Course type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_type
      @course_type = CourseType.find(params[:id])
       @general_setting = GeneralSetting.first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_type_params
      params.require(:course_type).permit(:course_type_name)
    end
end
