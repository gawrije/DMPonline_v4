ActiveAdmin.register Section do 

	menu :priority => 1, :label => proc{I18n.t('admin.section')}, :parent =>  "Templates management"
		
	filter :title
	filter :organisation
	filter :version
	filter :created_at
	filter :updated_at
	 

	index do   # :organisation_id, :description, :number, :title, :version_id
        column :title , :sortable => :title do |section|
            if !section.title.nil? then
            link_to section.title, [:admin, section]
         end
        end
        column I18n.t('admin.version'), :sortable => :version_id do |version_title|
            if !version_title.version_id.nil? then
                link_to version_title.version.title, [:admin, version_title.version]
            end
        end
        column I18n.t('admin.org_title'), :sortable => :organisation_id do |org_title|
           if !org_title.organisation_id.nil? then
                link_to org_title.organisation.name, [:admin, org_title.organisation]
           end
        end
        
        default_actions
    end
  
  #show details of a section
  show do 
	attributes_table do
		row :title
		row	:number
		row :description do |descr|
	  		if !descr.description.nil? then
	  			descr.description.html_safe
	  		end
		end
	  	row I18n.t('admin.version'), :sortable => :version_id do |version_title|
	  		if !version_title.version_id.nil? then
				link_to version_title.version.title, [:admin, version_title.version]
			end		
     	end
     	row I18n.t('admin.org_title'), :sortable => :organisation_id do |org_title|
			if !org_title.organisation_id.nil? then
				link_to org_title.organisation.name, [:admin, org_title.organisation]
			end
   	 	end
     	row :created_at
     	row :updated_at
	end
		 
  end 
  
  
  #questions sidebar(:default_value, :dependency_id, :dependency_text, :guidance, :number, :parent_id, :suggested_answer, :text, :question_type, :section_id)
 		sidebar proc{I18n.t("admin.questions")}, :only => :show, :if => proc { (Question.where("section_id = ?", params[:id])).count >= 1}  do 
 			table_for( Question.where("section_id = ?", params[:id] ).order("number asc")) do
		 				column (:number){|question| question.number} 
	  				column (I18n.t("admin.question")){|question| link_to question.text, [:admin, question]}
		 	end	
	 		
 		end
 		
 	#form 
  form do |f|
  	f.inputs "Details" do
  		f.input :title
  		f.input :number
  		f.input :version, :collection => Version.all.map{ |ver| [ver.title, ver.id] }
  		f.input :organisation, :as => :select, :collection => Organisation.find(:all, :order => 'name ASC').map{|orgp|[orgp.name, orgp.id]}
  		f.input :description
   	end
  	
  	 f.actions 
  end
  
end
