{% extends '_layout.swig' %}
{% import '_macro/post-collapse.swig' as post_template %}
{% import '_macro/sidebar.swig' as sidebar_template %}

{% block title %}{{ __('title.archive') }} | {{ title }}{% endblock %}

{% block page_class %}page-archive{% endblock %}

{% block content %}

  {#####################}
  {### ARCHIVE BLOCK ###}
  {#####################}
  <div id="posts" class="posts-expand">
  <div class="post-block page"> 
    <div class="post-body">
      <h2 class="post-title" style=" border-left:none;padding-left:0;text-align:center;padding-top:0;">专栏分类</h2><br>
      <div class="category-all-page">
        <div class="category-all-title">
          {% set visibleCategories = 0 %}
          {% for cat in site.categories %}
            {% if cat.length %}
              {% set visibleCategories += 1 %}
            {% endif %}
          {% endfor %}
          {{ _p('counter.categories', visibleCategories) }}
        </div>
        <div class="category-all">
          {{ list_categories() }}
        </div>
      </div>
      <hr>
      <div class="tag-cloud">
        <div class="tag-cloud-title">
          {% set visibleTags = 0 %}
          {% for tag in site.tags %}
            {% if tag.length %}
              {% set visibleTags += 1 %}
            {% endif %}
          {% endfor %}
          {{ _p('counter.tag_cloud', visibleTags) }}
        </div><br>
        <div class="tag-cloud-tags">
          {{ tagcloud({min_font: 12, max_font: 30, amount: 300, color: true, start_color: '#ccc', end_color: '#111'}) }}
        </div>
      </div>
    </div>
  </div>
</div>
  
  <div class="post-block archive">
    <div id="posts" class="posts-collapse">
      <span class="archive-move-on"></span>

      {% if theme.cheers_enabled %}
      <span class="archive-page-counter">
        {% set cheers %}
        {% set posts_length = site.posts.length %}
        {% if posts_length > 210 %} {% set cheers = 'excellent' %}
          {% elif posts_length > 130 %} {% set cheers = 'great' %}
          {% elif posts_length > 80 %} {% set cheers = 'good' %}
          {% elif posts_length > 50 %} {% set cheers = 'nice' %}
          {% elif posts_length > 30 %} {% set cheers = 'ok' %}
        {% else %}
          {% set cheers = 'um' %}
        {% endif %}
        {{ __('cheers.' + cheers) }}! {{ _p("counter.archive_posts", site.posts.length) }} {{ __('keep_on') }}
      </span>
      {% endif %}

      {% for post in page.posts %}

        {# Show year #}
        {% set year %}
        {% set post.year = date(post.date, 'YYYY') %}

        {% if post.year !== year %}
          {% set year = post.year %}
          <div class="collection-title">
            <{% if theme.seo %}h2{% else %}h1{% endif %} class="archive-year" id="archive-year-{{ year }}">{{ year }}</{% if theme.seo %}h2{% else %}h1{% endif %}>
          </div>
        {% endif %}
        {# endshow #}

        {{ post_template.render(post) }}

      {% endfor %}

    </div>
  </div>
  {#########################}
  {### END ARCHIVE BLOCK ###}
  {#########################}

  {% include '_partials/pagination.swig' %}

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}
