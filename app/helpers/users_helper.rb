module UsersHelper
    def user_icon(size)
        if !@current_user.image
            image_tag @current_user.image, style: "#{image_style(size)}"
        else
            image_tag "/images/user_icon.png", style: "#{image_style(size)}"
        end
    end
end
