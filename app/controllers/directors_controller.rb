class DirectorsController < ApplicationController
 
 def create
  d = Director.new
  
  d.name = params.fetch("direc_name")
  d.dob = params.fetch("direc_dob")
  d.bio = params.fetch("direc_bio")
  d.image = params.fetch("direc_image")

  d.save

 redirect_to("/directors")
 end
  
  
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end


  def destroy
    the_id = params.fetch("an_id")
    
    matching_records = Director.where ({:id => the_id})
    
    the_director = matching_records.at(0)
    
    the_director.destroy
    
    redirect_to("/directors")
  
  end


   def update 
    a_id = params.fetch("the_id")

    matching_records= Director.where({ :id => a_id})
    
    the_direc = matching_records.at(0)
    
    
       the_direc.name = params.fetch("direc_name")
       the_direc.dob = params.fetch("direc_dob")
       the_direc.bio = params.fetch("direc_bio")
       the_direc.image = params.fetch("direc_image")
      
       the_direc.save
        
    
    redirect_to("/directors/#{the_direc.id}")
  end
end
