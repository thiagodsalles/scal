Jbuilder.key_format camelize: :lower

json.notices @notices do |notice|
  json.id notice.id
  json.title notice.title
  json.text notice.text
  json.user notice.user.name
  json.category notice.category.name
  json.image_url notice.image.attached? ? url_for(notice.image) : nil
end
