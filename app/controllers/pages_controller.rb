class PagesController < ApplicationController
	
  def landing
  	if user_signed_in?
  		# хелпер devise (проверяет авторизован ли пользователь?)
  		redirect_to "/photos"
  		# если авторизован то перенаправляет на страницу фотос
  	end
  end

  def about
  end

end
