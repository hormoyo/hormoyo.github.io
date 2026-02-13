#!/bin/bash
# Hexo post_link 批量修复脚本（适配 Obsidian 路径）
# 适用：Mac/Linux 系统，Hexo source 指向 Obsidian 文件夹的场景

# ====================== 请手动修改这部分 ======================
# 替换成你的 Obsidian 文件夹实际路径（Hexo source 配置的地址）
# 示例：OBSIDIAN_DIR="/Users/你的用户名/Documents/Obsidian/我的笔记"
# 路径有空格必须加引号！
OBSIDIAN_DIR="/Users/hormoyo/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian-note/06 post"


# 可选：如果只修复 Obsidian 里的 posts 子目录，取消下面注释并修改
# OBSIDIAN_DIR="/Users/你的用户名/Documents/Obsidian/我的笔记/posts"
# =============================================================

# 检查 Obsidian 目录是否存在
if [ ! -d "$OBSIDIAN_DIR" ]; then
    echo -e "\033[31m❌ 错误：找不到 Obsidian 目录 $OBSIDIAN_DIR\033[0m"
    echo "   请检查脚本里的 OBSIDIAN_DIR 路径是否正确！"
    exit 1
fi

# 定义颜色输出（美化日志）
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
NC='\033[0m' # 重置颜色

echo -e "\033[34m🚀 开始批量修复 post_link 格式\033[0m"
echo -e "📁 目标目录：$OBSIDIAN_DIR"
echo "=============================================="

# 统计修复数量
FIXED_COUNT=0
UNCHANGED_COUNT=0

# 遍历所有 .md 文件（-print0 和 read -d '' 处理含空格/特殊字符的文件名）
find "$OBSIDIAN_DIR" -type f -name "*.md" -print0 | while IFS= read -r -d '' FILE; do
    # 创建备份文件（后缀 .bak，修复完成后可手动删除）
    cp "$FILE" "$FILE.bak"
    
    # 核心正则替换：给 post_link 参数加引号
    # 匹配：{% post_link 标识 文本 %} → 替换：{% post_link "标识" "文本" %}
    sed -i '' -E 's/{%\s*post_link\s+([^[:space:]]+)\s+(.*?)\s*%}/{% post_link "\1" "\2" %}/g' "$FILE"
    
    # 对比原文件和新文件，判断是否修改
    if ! cmp -s "$FILE" "$FILE.bak"; then
        echo -e "${GREEN}✅ 已修复：${NC}$FILE"
        ((FIXED_COUNT++))
    else
        echo -e "${YELLOW}ℹ️ 无需修改：${NC}$FILE"
        ((UNCHANGED_COUNT++))
        # 删除无变化的备份文件
        rm "$FILE.bak"
    fi
done

echo "=============================================="
echo -e "\033[34m🎉 修复完成！\033[0m"
echo -e "✅ 修复文件数：$FIXED_COUNT"
echo -e "ℹ️ 未修改文件数：$UNCHANGED_COUNT"
echo -e "\033[33m提示：备份文件后缀为 .bak，确认修复无误后可手动删除\033[0m"