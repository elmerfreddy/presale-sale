module ApplicationHelper
  # These are called “base errors.” For example, a model might set an error like this:
  # errors.add :base, "Credit card declined". SimpleForm does not provide a helper to
  # display base errors; if your application sets base errors, you’ll need to add the
  # following view helper.
  #
  # <%= simple_form_for ... %>
  #   <%= f.error_notification %>
  #   <%= display_base_errors resource %>
  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def destroy_link_to(title, url)
    link_to url, :method => :delete, :data => { :confirm => 'Are you sure?' }, class: 'btn btn-mini btn-danger' do
      content_tag(:i, nil, class: 'icon-remove icon-white') + title
    end
  end

  def edit_link_to(title, url)
    link_to url, class: 'btn btn-mini' do
      content_tag(:i, nil, class: 'icon-edit') + title
    end
  end

  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    target.active_model_serializer.new(target, options).to_json
  end

  def new_item_path(name, url, options = {})
    link_to url, options.merge!({ class: 'btn btn-primary' }) do
      content_tag(:i, nil, class: 'icon-plus icon-white') +
      name
    end
  end

  def show_title(title, title_desc)
    content_tag :div, class: 'page-header' do
      content_tag :h2 do
        content_tag(:span, title, class: 'muted') + ' ' +
        title_desc
      end
    end
  end
end
