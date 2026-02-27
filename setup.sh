#!/bin/bash

# Setup script to initialize GitHub repo

set -e

echo "🚀 Setting up network-lab repo..."

# Initialize git if not already done
if [ ! -d ".git" ]; then
    git init
    echo "✅ Git initialized"
else
    echo "ℹ️  Git already initialized"
fi

# Add all files
git add .
echo "✅ Files staged"

# Create initial commit
git commit -m "Initial commit: Network lab with containerlab, Netbox, and pyATS"
echo "✅ Initial commit created"

echo ""
echo "📝 Next steps:"
echo "1. Create a new repository on GitHub (make it empty, no README)"
echo "2. Run: git remote add origin <your-repo-url>"
echo "3. Run: git push -u origin main"
echo "4. Go to GitHub → Code → Codespaces → Create codespace on main"
echo ""
echo "That's it! Your network lab will be ready in ~2 minutes."
