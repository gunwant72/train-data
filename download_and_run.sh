#!/bin/bash
# Array of file keys
file_keys=( smoke_final )
# Download files from S3
for key in "${file_keys[@]}"; do
    aws s3 cp "s3://unstudio-product-photoshoots/dataset/Lora-Categories/$key" "./data/$key" --recursive
done

# Run main.py (replace 'main.py' with the actual name of your Python script)
pip install -r requirements.txt
python caption.py

for key in "${file_keys[@]}"; do
    zip -r "./result/$key.zip" "./data/$key"
done

# delete the content of the data folder
rm -r ./data/*

# git
git add .
git commit -m "Add result images"
git push origin master

echo "All done!"


 