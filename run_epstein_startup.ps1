# Always start in the user's home directory
cd $HOME

# Path to repo inside the user's home folder
$RepoPath = Join-Path $HOME "epstein_crawler_docs"

# --- Ensure repo exists or update it ---
if (!(Test-Path $RepoPath)) {
    git clone https://github.com/brocchirodrigo/epstein_crawler_docs.git $RepoPath
} else {
    cd $RepoPath
    git pull
}

# Move into repo folder (safe even if freshly cloned)
cd $RepoPath

# --- Ensure downloads folder exists ---
if (!(Test-Path "downloads")) {
    mkdir downloads -Force
}

# --- Ensure uv is installed ---
pip install uv

# --- Sync dependencies (self-heals missing venv) ---
uv sync

# --- Ensure Playwright + Chromium installed ---
uv run playwright install chromium

# --- Run main script (always last) ---
uv run python main.py
