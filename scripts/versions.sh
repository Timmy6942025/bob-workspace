#!/bin/bash
# Versions - Check versions of installed tools

echo "🔢 Version Check"
echo "==============="
echo ""

# System
echo "🖥️  System:"
echo "  OS: $(uname -o)"
echo "  Kernel: $(uname -r)"
echo "  Arch: $(uname -m)"
echo ""

# OpenClaw
if command -v openclaw &> /dev/null; then
    echo "🔌 OpenClaw:"
    openclaw --version 2>/dev/null || echo "  Version check failed"
    echo ""
fi

# Node.js
if command -v node &> /dev/null; then
    echo "📦 Node.js:"
    echo "  $(node --version)"
    echo ""
fi

# Git
echo "📝 Git:"
echo "  $(git --version)"
echo ""

# GitHub CLI
if command -v gh &> /dev/null; then
    echo "🐙 GitHub CLI:"
    gh --version | head -1
    echo ""
fi

# Docker
if command -v docker &> /dev/null; then
    echo "🐳 Docker:"
    docker --version
    echo ""
fi

# Clawhub
if command -v clawhub &> /dev/null; then
    echo "🛠️  Clawhub:"
    clawhub --version 2>/dev/null || echo "  Version check failed"
    echo ""
fi

echo "Checked: $(date '+%H:%M:%S')"
