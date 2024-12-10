cat << EOF > cors-config.json
[
  {
    "origin": ["http://example.com"],
    "method": ["GET"],
    "responseHeader": ["Content-Type"],
    "maxAgeSeconds": 3600
  }
]
EOF

# Step 2: Fetch the first bucket name from the project
echo "${BOLD}${YELLOW}Fetching bucket name${RESET}"
export BUCKET_NAME=$(gcloud storage buckets list --format="value(name)" --limit=1)

# Step 3: Update the bucket's CORS configuration
echo "${BOLD}${MAGENTA}Updating CORS configuration for the bucket${RESET}"
gcloud storage buckets update gs://$BUCKET_NAME --cors-file=cors-config.json

echo

echo -e "\n"  # Adding one blank line

cd

remove_files() {
    # Loop through all files in the current directory
    for file in *; do
        # Check if the file name starts with "gsp", "arc", or "shell"
        if [[ "$file" == gsp* || "$file" == arc* || "$file" == shell* ]]; then
            # Check if it's a regular file (not a directory)
            if [[ -f "$file" ]]; then
                # Remove the file and echo the file name
                rm "$file"
                echo "File removed: $file"
            fi
        fi
    done
}

remove_files
