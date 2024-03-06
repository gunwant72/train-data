import os
import pandas as pd
import zipfile
from PIL import Image

image_num = {}
for i in os.listdir('./data'):
    image_num[i] = len(os.listdir('./data/' + i))
    if os.path.isdir('./data/' + i):
        data = {'image_file':[], 'caption':[]}
        for j in os.listdir('./data/' + i):
           
            if j.endswith(('.webp')):
                im = Image.open('./data/' + i + '/' + j)
                im.save('./data/' + i + '/' + j.split('.')[0] + '.png')
                os.remove('./data/' + i + '/' + j)
                data['image_file'].append(j.split('.')[0] + '.png')
                data['caption'].append(j.split('_')[0])

            if j.endswith(('.png')):
                data['image_file'].append(j)
                data['caption'].append(j.rsplit('_', 1)[0].replace('_', ' '))

        df = pd.DataFrame.from_dict(data)
        df.to_csv('./data/' + i + '/caption.csv', index=None)
        zipf = zipfile.ZipFile('./result/' + i + '.zip', 'w', zipfile.ZIP_DEFLATED)
    else:
        print('not a directory')
print(image_num)
