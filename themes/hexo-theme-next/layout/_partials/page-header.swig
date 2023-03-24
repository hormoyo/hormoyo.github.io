<header class="post-header">
<script async src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
<{% if theme.seo %}h2{% else %}h1{% endif %} class="post-title" itemprop="name headline">{{ page.title }}</{% if theme.seo %}h2{% else %}h1{% endif %}>

<div class="post-meta">
  {% if page.description %}
    <div class="post-description">{{ page.description }}</div>
  {% endif %}
  {% include 'breadcrumb.swig' %}
  <span id="busuanzi_container_page_pv">
  本文总阅读量<span id="busuanzi_value_page_pv"></span>次
</span>
</div>

</header>

