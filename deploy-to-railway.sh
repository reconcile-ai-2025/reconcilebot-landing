#!/bin/bash

# Deploy ReconcileBot landing page to Railway
# Simple deployment script

set -e

echo "🚀 Deploying ReconcileBot Landing Page to Railway"
echo "=================================================="

# Check if railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI is not installed."
    echo ""
    echo "Install it with:"
    echo "  brew install railway"
    echo ""
    echo "Or via npm:"
    echo "  npm install -g @railway/cli"
    echo ""
    exit 1
fi

echo "✅ Railway CLI is installed"
echo ""

# Check if logged in
if ! railway whoami &> /dev/null; then
    echo "🔐 Not logged in to Railway. Logging in..."
    railway login
fi

echo "✅ Authenticated with Railway"
echo ""

# Get current directory
LANDING_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$LANDING_DIR"

echo "📁 Current directory: $LANDING_DIR"
echo ""

# Check if already linked to a project
if [ ! -f ".railway/config.json" ]; then
    echo "🔗 Linking to Railway project..."
    echo ""
    echo "Please select your Railway project when prompted."
    railway link
    echo ""
fi

echo "📦 Deploying to Railway..."
echo ""

# Deploy
railway up

echo ""
echo "=================================================="
echo "✅ DEPLOYMENT COMPLETE!"
echo "=================================================="
echo ""
echo "🌐 Your landing page is being deployed to Railway"
echo ""
echo "📍 Next Steps:"
echo ""
echo "1. Check deployment status:"
echo "   railway status"
echo ""
echo "2. View logs:"
echo "   railway logs"
echo ""
echo "3. Open in browser:"
echo "   railway open"
echo ""
echo "4. Configure custom domain:"
echo "   Go to Railway dashboard → Settings → Domains"
echo "   Add: reconcilebot.io"
echo ""
echo "5. Get your Railway URL:"
echo "   railway domain"
echo ""
echo "🎉 Done!"
