module PicturesHelper
  def picture_caption(picture)
    picture.caption? ? picture.caption : 'No caption'
  end

  def new_picture_link
    link_to new_picture_path, class: 'btn' do
      raw(
        content_tag(:span, '', class: get_black_icon_class(:new_picture)) +
        content_tag(:span, 'New Picture')
      )
    end
  end

  def picture_action_links(picture)
    content_tag :p do
      raw(
        edit_link(edit_picture_path(picture)) +
        destroy_link(picture)
      )
    end
  end
end
