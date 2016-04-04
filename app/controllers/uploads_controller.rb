class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :update, :destroy, :decrypt]

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  def decrypt
    if @upload.users.include? current_user
      parsed = URI::parse(@upload.data.url)
      parsed.fragment = parsed.query = nil
      enc = File.read("public" + parsed.to_s)
      dec = SymmetricEncryption.decrypt enc
      send_data dec, :filename => @upload.data_file_name, :type => @upload.data_content_type
    else
      redirect_to root_path, notice: "Nice try"
    end
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(upload_params)

    respond_to do |format|
      if @upload.save
        @access = Access.new(user: current_user, upload: @upload, kind: :owner)
        if @access.save
          @upload.accesses << @access
          if @upload.save
            format.html { redirect_to root_path, notice: 'Upload was successfully created.' }
            format.json { render :show, status: :created, location: root_path }
          else
            format.html { render :new }
            format.json { render json: @upload.errors, status: :unprocessable_entity }
          end
        else
          format.html { render :new }
          format.json { render json: @upload.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    respond_to do |format|
      if @upload.update(upload_params)
        format.html { redirect_to root_path, notice: 'Upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @upload }
      else
        format.html { render :edit }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url, notice: 'Upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
      if params[:upload]
        puts "trying?????????????????????????????????????????????????????????"
        params.require(:upload).permit(:question_id, :data)
      else
        nil
      end
    end
end
