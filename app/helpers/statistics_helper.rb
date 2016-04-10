module StatisticsHelper
  #TODO delete later!!!
  def get_statistics_avg_cities_users
    sql="
      select c.name as city_name, avg(age(current_date, u.birthday)) as avg_user_age, count(u.id) as users_count
      from cities c
      left join users u on c.id=u.city_id
      group by c.name;
    "

    ActiveRecord::Base.connection.execute sql
  end
end
