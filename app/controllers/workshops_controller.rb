class WorkshopsController < ApplicationController
  # GET /workshops
  # GET /workshops.json
  before_filter :authenticate_user!
  def index
    @workshops = Workshop.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workshops }
    end
  end

  # GET /workshops/1
  # GET /workshops/1.json
  def show
    @workshop = Workshop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workshop }
    end
  end

  # GET /workshops/new
  # GET /workshops/new.json
  def new
    @workshop = Workshop.new
    @repairs = Repair.all
    @repairs.each do |r|
      if r.model_id != nil
        @modelName = Model.find(r.model_id).name
        r.name = r.name + '(' + @modelName + ')'
      end 
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workshop }
    end
  end

  # GET /workshops/1/edit
  def edit
    @workshop = Workshop.find(params[:id])
    @allRepair = Repair.all
    @selectedRepairs = findRepairByWorkshopId(params[:id])
    #@repairsms2side__dx = @selectedRepairs
    ### selected id
    @rr = findAvailableAndSelectedRepair @allRepair,@selectedRepairs

    #@rr = "<select class='multiselect'><option value='3' selected> test </option> <option value='4'>test3</option></select>"
  end

  # POST /workshops
  # POST /workshops.json
  def create
    #@workshop = Workshop.new(params[:workshop][:name])
    req = params[:workshop]
    @workshop = Workshop.new(:name => req[:name] , :address => req[:address] , :contact_numbers => req[:contact_numbers],
                             :contact_person => req[:contact_person], :is_premium => req[:is_premium],
                             :opening_hours => req[:opening_hours], :website => req[:website] )
    #puts req[:repairs].split(',').size
    #@repairs = Repair.find(req[:repairs])
    #
    #puts params[:workshop][:name]
    respond_to do |format|
      Workshop.transaction do
        begin
          if @workshop.save 
             #@repairs = Repair.find(req[:repairs])
             if params[:repairs] != nil
                params[:repairs].each {|x| 
                  logger.info(x)
                  @repairs = Repair.find(x)
                  @repairWorkshop = RepairWorkshop.new(:repair => @repairs, :workshop => @workshop)
                  @repairWorkshop.save
                }
             end
             format.html { redirect_to @workshop, notice: 'Workshop was successfully created.' }
             format.json { render json: @workshop, status: :created, location: @workshop }
          else

            @repairs = Repair.all
            @repairs.each do |r|
              if r.model_id != nil
                @modelName = Model.find(r.model_id).name
                r.name = r.name + '(' + @modelName + ')'
              end 
            end
             format.html { render action: "new" }
             format.json { render json: @workshop.errors, status: :unprocessable_entity }
          end
        rescue Exception => e
          logger.debug(e.message)
          #puts @repairs
          @repairs = Repair.all
          raise ActiveRecord::Rollback, "Call tech support!"
          format.html { render action: "index", notice:e.message}
        end
      end
      
    end
  end

  #rescue_from ActiveRecord::Rollback, :with => :throw_404
  # PUT /workshops/1
  # PUT /workshops/1.json
  def update
    @workshop = Workshop.find(params[:id])
    @repairs = params[:repairs]
    respond_to do |format|
      Workshop.transaction do
        begin
          if @workshop.update_attributes(params[:workshop])
             @repairWorkshop = RepairWorkshop.delete_all(:workshop_id => @workshop.id)
            if params[:repairs] != nil
                params[:repairs].each {|x| 
                  logger.info(x)
                  @repairs = Repair.find(x)
                  @repairWorkshop = RepairWorkshop.new(:repair => @repairs, :workshop => @workshop)
                  @repairWorkshop.save
                  #throw Exception
                }
            end
            format.html { redirect_to @workshop, notice: 'Workshop was successfully updated.' }
            format.json { head :no_content }
          else
            #format.html { render action: "edit" }
            #flash[:errors] = clone_with_errors(@workshop)
            #logger.info(@workshop.errors.to_a)
            #flash[:alert] = @workshop.errors.to_a
            #format.html { redirect_to edit_workshop_url}
            logger.info('$$$$$')
            @allRepair = Repair.all
            @selectedRepairs = findRepairByWorkshopId(params[:id])
     
            ### selected id
            @rr = findAvailableAndSelectedRepair @allRepair,@selectedRepairs
            format.html { render action: "edit" }
            format.json { render json: @workshop.errors, status: :unprocessable_entity }
          end

        rescue Exception => e
            logger.debug(e.message)
            #puts @repairs
            #@repairs = Repair.all
            raise ActiveRecord::Rollback, "Call tech support!"
            #format.html { redirect_to edit_workshop_url, :alert => 'Workshop update fail!'}
        end 
      end
        format.html { redirect_to edit_workshop_url, :alert => 'Workshop update fail!'}
    end
  end

  # DELETE /workshops/1
  # DELETE /workshops/1.json
  def destroy

    respond_to do |format|
      Workshop.transaction do
      begin
        # delete workshop
        @workshop = Workshop.find(params[:id])
        @workshop.destroy

        #delete mapping in repair_workshops
        RepairWorkshop.delete_all(:workshop_id => params[:id])
        #@repairWorkshops.destroy_all
        
      rescue Exception => e
        logger.error(e.message)
        raise ActiveRecord::Rollback, "Delete workshop fail!"
        
      end
    end
      format.html { redirect_to workshops_url}
      format.json { head :no_content }
    end
  end

  private 
  def findRepairByWorkshopId(workshopId)
    Repair.joins('INNER JOIN repair_workshops rw ON repairs.id=rw.repair_id where rw.workshop_id = ' + workshopId)
  end

  def findAvailableAndSelectedRepair(allRepair,selectedRepairs)
    @allRepair = allRepair
    @selectedRepairs = selectedRepairs
    @selectedRepairIds = []
    if @selectedRepairs.size != 0
      @selectedRepairs.each do |sr|
          @selectedRepairIds << sr.id
      end
    end

    @rr = "<select class='multiselect' name='repairs[]' size='10' multiple>"
    if @allRepair.size != 0
      
      @allRepair.each do |r|
        if @selectedRepairIds.include? r.id
          @rr  = @rr + "<option value = '" + (r.id).to_s() + "' selected>" + r.name + "</option>"
        else
          @rr  = @rr + "<option value = '" + (r.id).to_s() + "'>" + r.name + "</option>"
        end
      end
    else
    end
    @rr = @rr + "</select>"
  end
end
