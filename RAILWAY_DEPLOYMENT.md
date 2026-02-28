# Railway Deployment Guide - Landing Page

Deploy your ReconcileBot landing page to Railway as a separate static site service.

## Prerequisites

- Railway account (https://railway.app)
- Railway CLI installed (optional, but recommended)

## Method 1: Railway CLI (Recommended)

### Install Railway CLI

```bash
# Install via Homebrew
brew install railway

# Or via npm
npm install -g @railway/cli
```

### Authenticate

```bash
railway login
```

### Deploy Landing Page

```bash
cd /Users/aidan/src/reconcile-ai-pro/landing

# Link to your Railway project
railway link

# Create a new service for the landing page
railway up --service landing-page

# Set custom domain (optional)
railway domain
```

The CLI will:
- ✅ Detect the Dockerfile
- ✅ Build the nginx container
- ✅ Deploy to Railway
- ✅ Provide a public URL

## Method 2: GitHub Integration (Easier)

### Step 1: Create Separate Git Repo

Create a new repository just for the landing page:

```bash
cd /Users/aidan/src/reconcile-ai-pro/landing

# Initialize git
git init
git add .
git commit -m "Initial landing page"

# Create GitHub repo
gh repo create reconcilebot-landing --public --source=. --push
```

### Step 2: Deploy to Railway

1. Go to Railway dashboard: https://railway.app/dashboard
2. Click **"New Project"**
3. Select **"Deploy from GitHub repo"**
4. Choose **"reconcilebot-landing"**
5. Railway will auto-detect the Dockerfile
6. Click **"Deploy"**

### Step 3: Configure Domain

1. In Railway dashboard, click on your landing page service
2. Go to **"Settings"** tab
3. Under **"Domains"**, click **"Generate Domain"** (you'll get a railway.app URL)
4. Click **"Custom Domain"**
5. Enter: `reconcilebot.io`
6. Railway will show you the DNS records to add

## Method 3: Manual Deployment (No Git)

### Step 1: Create a New Service

1. Go to Railway dashboard
2. Click **"New Project"** → **"Empty Project"**
3. Click **"New"** → **"Empty Service"**
4. Name it: `landing-page`

### Step 2: Deploy via Railway CLI

```bash
cd /Users/aidan/src/reconcile-ai-pro/landing

# Initialize if needed
railway init

# Deploy
railway up
```

## DNS Configuration

After deployment, Railway will give you instructions to point your domain. Typically:

### If Using Railway's DNS:

Railway will provide CNAME records like:

```
Type: CNAME
Name: reconcilebot.io
Value: some-name.up.railway.app
```

### Full Setup with Subdomain:

```
reconcilebot.io          → Landing page service (CNAME to Railway)
app.reconcilebot.io      → Streamlit app service (CNAME to Railway)
```

In Railway dashboard:
1. Landing page service → Settings → Domains → Add `reconcilebot.io`
2. Streamlit app service → Settings → Domains → Add `app.reconcilebot.io`

## Environment Variables

The landing page doesn't need any environment variables. It's pure static HTML.

## Cost

**Estimated**: $1-2/month
- Static nginx container is very lightweight
- Minimal CPU and memory usage
- Covered by your $5 Hobby plan credit

Your total Railway bill:
- Streamlit app: ~$3-4/month
- Landing page: ~$1-2/month
- **Total: ~$4-6/month** (within $5 Hobby credit + small overage)

## Architecture

```
┌─────────────────────────┐
│   reconcilebot.io       │
│   (Landing Page)        │
│   nginx serving HTML    │
└─────────────────────────┘
           │
           │ CNAME
           ▼
    Railway Service 1
    (landing-page)


┌─────────────────────────┐
│  app.reconcilebot.io    │
│  (Streamlit App)        │
│  Full application       │
└─────────────────────────┘
           │
           │ CNAME
           ▼
    Railway Service 2
    (reconcilebot-pro)
```

## Testing

After deployment:

1. **Railway URL** (immediate):
   ```
   https://your-service.up.railway.app/
   ```

2. **Custom domain** (after DNS propagation):
   ```
   https://reconcilebot.io
   ```

3. **Health check**:
   ```
   https://reconcilebot.io/health
   ```
   Should return: "OK"

## Updating the Landing Page

### Via GitHub (if using GitHub integration):

```bash
cd landing
# Edit index.html
git add .
git commit -m "Update landing page"
git push
```

Railway auto-deploys on push.

### Via Railway CLI:

```bash
cd landing
# Edit index.html
railway up
```

## Troubleshooting

### Build Fails

Check Railway logs:
```bash
railway logs
```

### Port Issues

Railway automatically sets PORT. Nginx is configured for port 80 (standard).

### Domain Not Working

1. Verify DNS records in your domain registrar
2. Wait 5-30 minutes for DNS propagation
3. Check Railway domain settings
4. Test with `dig reconcilebot.io`

## Next Steps

1. **Deploy landing page** (use Method 2 - GitHub integration)
2. **Configure custom domains** in Railway dashboard
3. **Update DNS** in your domain registrar
4. **Test both URLs**: reconcilebot.io and app.reconcilebot.io
5. **Enable HTTPS** (Railway handles this automatically)
6. **Submit sitemap** to Google Search Console

## Support

- Railway Docs: https://docs.railway.app
- Railway Discord: https://discord.gg/railway
- Railway Status: https://status.railway.app
