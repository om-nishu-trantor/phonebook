class PhoneListsController < ApplicationController
  before_action :set_phone_list, only: [:show, :edit, :update, :destroy]

  # GET /phone_lists
  # GET /phone_lists.json
  def index
    @phone_lists = PhoneList.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /phone_lists/1
  # GET /phone_lists/1.json
  def show
  end

  # GET /phone_lists/new
  def new
    @phone_list = PhoneList.new

    respond_to do |format|
      format.html
      format.js { render :new_or_edit }
    end
  end

  # GET /phone_lists/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js { render :new_or_edit }
    end
  end

  # POST /phone_lists
  # POST /phone_lists.json
  def create
    @phone_list = PhoneList.new(phone_list_params)

    respond_to do |format|
      if @phone_list.save
        format.html { redirect_to @phone_list, notice: 'Phone list was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @phone_list }
      else
        format.html { render :new }
        format.js
        format.json { render json: @phone_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone_lists/1
  # PATCH/PUT /phone_lists/1.json
  def update
    respond_to do |format|
      if @phone_list.update(phone_list_params)
        format.html { redirect_to @phone_list, notice: 'Contact was successfully updated.' }
        format.js { render 'create' }
        format.json { render :show, status: :ok, location: @phone_list }
      else
        format.html { render :edit }
        format.js { render 'create' }
        format.json { render json: @phone_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_lists/1
  # DELETE /phone_lists/1.json
  def destroy
    @phone_list.destroy
    respond_to do |format|
      format.html { redirect_to phone_lists_url, notice: 'Contact was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def destroy_all
    PhoneList.delete_all
    respond_to do |format|
      format.html { redirect_to phone_lists_url, notice: 'Contacts were successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # Prepares the file on the fly and delete after download is finished
  def download_text_file
    phone_list_file_path=prepare_file_and_send(Time.now.to_i)
    File.open(phone_list_file_path, 'r') do |f|
      send_data f.read, type: "text/plain", filename: "phone_list_till_#{Time.now}.txt"
    end
    File.delete(phone_list_file_path)
  end

  def upload
    fio = params[:upload][:datafile]
    if fio.content_type == 'text/plain'
      begin
        rows = fio.tempfile.read.split(/\r?\n/)
        rows.each do |r|
          vals = r.split(',')
          id = vals[0].sub('(', '').sub(')', '').squish
          name = vals[1].squish
          phone = vals[2].squish
          phone_list = PhoneList.find_by_id(id) || PhoneList.new
          phone_list.update_attributes!(:name => name, :phone => phone)
        end
        flash[:success] = "Contacts has been uploaded successfully"
      rescue Exception => e
        flash[:error] = (e.message.include?('Validation failed') ? e.message : 'Something went wrong. Kindly check file data.')
      end
    else
      flash[:error] = 'Invalid file extention. It must be .txt'
    end

    redirect_to root_path
  end

  private
    # Prepare phone_list as a text
    def prepare_file_and_send(file_name)
      file_path_name=Rails.root.join('public', "#{file_name}.txt")
      f = File.new(file_path_name.to_s,  "w+")

      PhoneList.pluck(:id, :name, :phone).map do |a|
        f<<"(#{a.first}), #{a.second}, #{a.last} \n"
      end

      f.close
      file_path_name
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_phone_list
      @phone_list = PhoneList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_list_params
      params.require(:phone_list).permit(:name, :phone, :phone_list_file)
    end
end
