#!/bin/bash
# Array of file keys
file_keys=(living_room_v1
matte_blue
office_v1
red_velvet
rocky_living_room
simple_orange
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
 