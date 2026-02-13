# ==============================================
# 一键操作：降级Hexo+修复依赖+解决版本冲突
# ==============================================
# 1. 进入Hexo根目录（替换成你的实际路径，务必修改！）
cd /Users/hormoyo/Library/Mobile\ Documents/com~apple~CloudDocs/bendi_blog/hormoyo.github.io

# 2. 备份核心配置（防止丢失）
cp package.json package.json.bak
cp _config.yml _config.yml.bak

# 3. 卸载当前不兼容的Hexo版本
npm uninstall hexo hexo-cli --save

# 4. 安装兼容的Hexo 7.1.1（适配hexo-related-posts）
npm install hexo@7.1.1 hexo-cli@4.3.0 --save --legacy-peer-deps

# 5. 降级strip-ansi到CommonJS版本（解决ESM冲突）
npm install strip-ansi@5 --save

# 6. 自动修复依赖漏洞（无破坏性）
npm audit fix --legacy-peer-deps

# 7. 验证Hexo版本和依赖
echo "✅ Hexo版本验证："
hexo version

# 8. 清理缓存+生成博客（验证是否正常）
hexo clean && hexo generate

echo "🎉 操作完成！如果无报错，执行 hexo s 即可本地预览博客"