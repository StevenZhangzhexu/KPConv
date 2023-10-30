from plyfile import PlyData, PlyElement

#train = PlyData.read('/home/steven/Data/Orchard/train/Orchard_0913_labelled_E.ply')
test =  PlyData.read('results/Log_2023-10-26_09-30-29/val_preds_500/Orchard_0913_labelled_E.ply')
s=0
total=len(test['vertex']['preds'])
for i in range(total):
    if test['vertex']['preds'][i] == test['vertex']['class'][i]:
        s+=1

print(f'accuracy is {100 * s/total}%')