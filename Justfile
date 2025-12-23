import './just/podcasts/justfile'
import './just/uv/justfile'
import './just/django/justfile'

default_pattern := "extract_wisdom"

yt video pattern=default_pattern:
	fabric -y "{{video}}" --stream --pattern {{pattern}}
