#!/bin/bash
# Check Dependencies - Check for outdated npm packages

PROJECT_DIR="${1:-.}"
cd "$PROJECT_DIR" || exit 1

echo "📦 Dependency Check: $(basename $PROJECT_DIR)"
echo "================================"
echo ""

if [ ! -f "package.json" ]; then
    echo "❌ No package.json found"
    exit 1
fi

# Check if npm is available
if ! command -v npm &> /dev/null; then
    echo "⚠️  npm not available"
    exit 1
fi

# Show current dependencies
echo "📋 Current dependencies:"
cat package.json | grep -A20 '"dependencies"' | head -15
echo ""

# Check for outdated packages (if node_modules exists)
if [ -d "node_modules" ]; then
    echo "🔍 Checking for outdated packages..."
    npm outdated 2>/dev/null || echo "✅ All packages up to date (or check manually with 'npm outdated')"
else
    echo "⚠️  node_modules not found - run 'npm install' first"
fi

echo ""
echo "💡 Tips:"
echo "  - Run 'npm update' to update packages"
echo "  - Run 'npm audit' to check for security issues"
echo "  - Check package.json for deprecated packages"
