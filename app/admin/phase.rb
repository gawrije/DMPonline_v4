ActiveAdmin.register Phase do	

	menu :priority => 1, :label => proc{I18n.t('admin.phase')}, :parent => "Templates management"
	
	# :description, :number, :title, :dmptemplate_id, :external_guidance_url
	index do   
        column :title, :sortable => :title do |ph|
            if !ph.title.nil? then
                link_to ph.title, [:admin, ph]
            end  
        end
        column :number
        column I18n.t('admin.template'), :sortable => :dmptemplate_id do |temp_title|
            if !temp_title.nil? then
                link_to temp_title.dmptemplate.title, [:admin, temp_title.dmptemplate]
            end	
        end
        
        default_actions
    end
  
    #show details of a phase
    show do 
		attributes_table do
			row :title
	 		row	:number
	 		row :description do |descr|
                if !descr.description.nil? then
                    descr.description.html_safe
                end
            end	
            row I18n.t('admin.template'), :sortable => :dmptemplate_id do |temp_title|
                link_to temp_title.dmptemplate.title, [:admin, temp_title.dmptemplate]
            end
            row :external_guidance_url
            row :created_at
            row :updated_at
		end
		 
	end 
  
    #versions sidebar
 	sidebar I18n.t('admin.version'), :only => :show, :if => proc { phase.versions.count >= 1}  do
 	 	table_for phase.versions.order("number asc") do |temp_phases|
 	 		column :number
 	 		column :title do |row|
                link_to row.title, [:admin, row]
            end	
            column :published
		end
    end
 		
 		
 	#form 	
 	form do |f|
        f.inputs "Details" do
            f.input :title
            f.input :number
            f.input :description
            f.input :dmptemplate_id, :label => I18n.t('admin.template'), 
                    :as => :select, 
                    :collection => Dmptemplate.find(:all, :order => 'title ASC').map{|temp|[temp.title, temp.id]}

        end
        f.actions  
    end		
      
end
