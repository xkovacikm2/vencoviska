module CitiesHelper
  def cities_names
    lol=[]
    City.all.each do |c|
      lol.append [c.name, c.id]
    end
    lol
  end
end
