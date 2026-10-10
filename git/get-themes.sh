#!/usr/bin/env bash

themes=(
  "theme-github-base"
  "theme-github-extra-pink"
)
target="./gitea/gitea/public/assets/css"
mkdir -p "$target"
GITEA_VERSION=$(cat ./.env | grep GITEA_VERSION | cut -d '=' -f2)
if [ -z "$GITEA_VERSION" ]; then
  echo "GITEA_VERSION is not set in .env file."
  exit 1
fi

temp=$(mktemp -d)
mkdir -p "$temp"
THEMES=(
  "gitea-auto" "gitea-light" "gitea-dark"
)

for theme in "${themes[@]}"; do
  echo "Downloading $theme..."
  archive_name="$theme.tar.gz"
  archive_path="$temp/$archive_name"
  curl -sSL "https://github.com/lutinglt/gitea-github-theme/releases/download/v$GITEA_VERSION/$archive_name" -o "$archive_path"
  extract_dir="$temp/$theme"
  mkdir -p "$extract_dir"
  tar -xzf "$archive_path" -C "$extract_dir"
  rm "$archive_path"  # Remove the archive after extraction
  # Loop over all theme file extracted
  for file in "$extract_dir/dist/"*; do
    if [ -f "$file" ]; then
      # get the theme name `*` from the file name : "theme-(*).css
      theme_name=$(basename "$file" | sed -E 's/theme-(.*)\.css/\1/')
      mv "$file" "$target/"
      THEMES+=("$theme_name")
    fi
  done
done

function join_by {
  local d=${1-} f=${2-}
  if shift 2; then
    printf %s "$f" "${@/#/$d}"
  fi
}


THEMES=$(join_by , "${THEMES[@]}")
# Replace (if exists) the line starting with "GITEA__ui__THEME=" in .env file with the new THEMES value
if grep -q "^GITEA__ui__THEME=" ./.env; then
  sed -i "s/^GITEA__ui__THEME=.*/GITEA__ui__THEME=$THEMES/" ./.env
else
  echo "GITEA__ui__THEME=$THEMES" >> ./.env
fi
# Replace (if exists) the line starting with "GITEA__ui__DEFAULT_THEME=" in .env file with the new default theme : github-auto
if grep -q "^GITEA__ui__DEFAULT_THEME=" ./.env; then
  sed -i "s/^GITEA__ui__DEFAULT_THEME=.*/GITEA__ui__DEFAULT_THEME=github-auto/" ./.env
else
  echo "GITEA__ui__DEFAULT_THEME=github-auto" >> ./.env
fi

echo "Themes downloaded and .env updated successfully."