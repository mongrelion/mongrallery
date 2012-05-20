module ApplicationHelper
  def session_links
    content_tag :p, :class => 'session navbar-text pull-right' do
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
      :alert   => 'alert',
      :notice  => 'alert alert-success',
      :error   => 'alert alert-error',
      :success => 'alert alert-success',
      :info    => 'alert alert-info'
    }.map do |key, val|
      content_tag :div, flash[key], :class => val if flash[key]
    end.join.html_safe
  end

  def new_link(url, text = 'New', _options = {})
    options = {
      :class => 'btn btn-small'
    }.merge _options
    link_to url, options do
      raw(
        content_tag(:span, '', :class => get_black_icon_class(:new)) +
        content_tag(:span, text)
      )
    end
  end

  def back_link(url, text = 'Back', _options = {})
    url ||= :back
    options = { :class => 'btn btn-small' }.merge _options
    link_to url, options do
      raw(
        content_tag(:span, '', :class => get_black_icon_class(:back)) +
        content_tag(:span, text)
      )
    end
  end

  def show_link(url, _options = {})
    options = {}.merge _options
  end

  def edit_link(url, text = 'Edit', _options = {})
    options = { :class => 'btn btn-small btn-inverse' }.merge _options
    link_to url, options do
      raw(
        content_tag(:span, '', :class => get_white_icon_class(:edit)) +
        content_tag(:span, text)
      )
    end
  end

  def destroy_link(url, text = 'Destroy', _options = {})
    options = {
      :class   => 'btn btn-small btn-danger',
      :method  => :delete,
      :confirm => 'Are you sure?'
    }.merge _options
    link_to url, options do
      raw(
        content_tag(:span, '', :class => get_white_icon_class(:destroy)) +
        content_tag(:span, text)
      )
    end
  end

  private

    def get_white_icon_class(icon)
      "iconfix icon-white #{get_icon_class icon}"
    end

    def get_black_icon_class(icon)
      "iconfix #{get_icon_class icon}"
    end

    def get_icon_class(icon)
      case icon
      when :new_picture
        'icon-picture'
      when :edit
        'icon-edit'
      when :destroy
        'icon-trash'
      when :back
        'icon-circle-arrow-left'
      when :new
        'icon-file'
      else
        'icon-ban-circle'
      end
    end

end
