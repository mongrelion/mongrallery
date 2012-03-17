module ApplicationHelper
  def session_links
    content_tag :p, class: 'session navbar-text pull-right' do
      if user_signed_in?
        raw(
          link_to(current_user.name, '#') +
          ' | ' +
          link_to('Logout', destroy_user_session_path)
        )
      else
        link_to 'Login', new_user_session_path
      end
    end
  end

  def flash_messages
    {
      alert:  'alert',
      notice:  'alert alert-success',
      error:   'alert alert-error',
      success: 'alert alert-success',
      info:    'alert alert-info'
    }.map do |key, val|
      content_tag :div, flash[key], class: val if flash[key]
    end.join.html_safe
  end

end
