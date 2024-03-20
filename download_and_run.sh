#!/bin/bash
# Array of file keys
file_keys=(illusions
old_paintings
fantasy_forest
ancient_greek
trunk
plant_patterns
moon_set
glacier_planet
red_brick
)
# Download files from S3
for key in "${file_keys[@]}"; do
    aws s3 cp "s3://unstudio-product-photoshoots/dataset/Lora-Categories/$key" "./data/$key" --recursive
done

# Run main.py (replace 'main.py' with the actual name of your Python script)
pip install -r requirements.txt
python caption.py

for key in "${file_keys[@]}"; do
    zip -r "./result/$key.zip" "./data/$key" > /dev/null 2>&1

done

# delete the content of the data folder
rm -r ./data/*

# git push
git add .
git commit -m "update result"
git pull origin master --rebase
git push origin master

echo "Job done"
 