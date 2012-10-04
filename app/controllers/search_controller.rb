class SearchController < ApplicationController
	def index
	    @makes = Make.all
	    logger.info('%%%%%%')
	    respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @makes }
        end 
	end

	def query
		logger.info('@@@@@')
		logger.info(params[:make_id])
		logger.info(params[:model_id])
		logger.info(params[:repair])
		qryRepair = params[:repair]
        
		if qryRepair != nil
            repairList = qryRepair.split(" ")
		end
        
        baseSqlStr = 'select r.* from repairs r, models m where r.model_id = m.id and r.model_id = ' + params[:model_id];

        sqlStr = "";
		if repairList.length != 0
			sqlStr = " and (";
            repairList.each_with_index do |r,index|
			    sqlStr = sqlStr + "r.name like '%" + r + "%'" 
            
			    if index != repairList.length-1
				    sqlStr = sqlStr + " or "
			    else
                    sqlStr = sqlStr + " )"
			    end
			    logger.info(sqlStr);
		    end
		end

		executeSql = baseSqlStr + sqlStr;
		@repairs = Repair.find_by_sql(executeSql)
        #search = Repair.search do
            #fulltext params[:repair]
        #    with :model_id, 1
        #end
        #@repairs = search.results
        #logger.info(@repairs)
        #@repairs.each do |result|
        #    logger.info("*****")
        #    logger.info(result.body)
        #end
        @makes = Make.all
        respond_to do |format|
            format.html {render action:'index'}
        end 
	end

	def queryModelByMakeId
		@models = Model.find_all_by_make_id(params[:make_id])
		@optionStr = '<select name="model_id" id="model">'
		@models.each { |m|  
            @optionStr = @optionStr + '<option value=\'' + m.id.to_s + '\'>' + m.name + ' </option>'
		}
		@optionStr = @optionStr + '</select>'
		logger.info(@optionStr)
		respond_to	do |format|
			format.text { render text: @optionStr}
		end
	end

	def queryWorkshopByRepair
		@repair_id = params[:repair_id]
		logger.info('$$$$$')
		
		if @repair_id != nil
		   logger.info(@repair_id)
		   @workshops = Workshop.joins('INNER JOIN repair_workshops rw ON workshops.id=rw.workshop_id').where('rw.repair_id = ?', @repair_id)	
		end
	end
end
