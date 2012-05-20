module PicturesHelper
  def picture_caption(picture)
    picture.caption? ? picture.caption : 'No caption'
  end

  def new_picture_link
    link_to new_picture_path, :class => 'btn btn-small' do
      raw(
        content_tag(:span, '', :class => get_black_icon_class(:new_picture)) +
        content_tag(:span, 'New Picture')
      )
    end
  end
end
