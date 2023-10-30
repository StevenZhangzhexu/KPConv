import logging
import open3d as o3d
import open3d.ml.torch as ml3d  # just switch to open3d.ml.tf for tf usage
import numpy as np
import os
from os.path import join
from plyfile import PlyData, PlyElement

log = logging.getLogger(__name__)


def prepare_custom_data(pc_names, test_path):
    print("Loading orchard evaluation data...")

    pc_data = []

    for _, name in enumerate(pc_names):
        test_ply_path = join(test_path, name+'.ply')
        #train_ply_path = join(train_path, name+'.ply')

        test = PlyData.read(test_ply_path)
        #train = PlyData.read(train_ply_path)

        points = np.vstack((test['vertex']['x'], test['vertex']['y'], test['vertex']['z'])).transpose() 

        data = {
            'name': "OrchardRoad_KPConv",
            'points': points,
            #'feat': train['vertex']['intensity'], 
            'labels': test['vertex']['class'],  
            'pred':  test['vertex']['preds'],  
         }
        pc_data.append(data)

    return pc_data


# ------------------------------


def main():
    orchard_labels = {
                        0: 'Bollard',
                        1: 'Building',
                        2: 'Bus Stop',
                        3: 'Control Box',
                        4: 'Ground',
                        5: 'Lamp Post',
                        6: 'Pole',
                        7: 'Railing',
                        8: 'Road',
                        9: 'Shrub',
                        10: 'Sign',
                        11: 'Solar Panel',
                        12: 'Tree'
                    }
    v = ml3d.vis.Visualizer()
    lut = ml3d.vis.LabelLUT()
    for val in sorted(orchard_labels.keys()):
        lut.add_label(orchard_labels[val], val)
    v.set_lut("labels", lut)
    v.set_lut("pred", lut)

    # logs = np.sort([os.path.join('test', f) for f in os.listdir('test') if f.startswith('Log')])
    # chosen_folder = logs[-1]
    # pred_path = os.path.join(chosen_folder, 'predictions')
    # pred_path = 'results/Log_2023-10-27_03-43-46/val_preds_500'
    pred_path = 'results/Log_2023-10-26_09-30-29/val_preds_500'

    pc_names = ["Orchard_0913_labelled_E"]
    pcs_with_pred = prepare_custom_data(pc_names, pred_path)

    print("Visualizing predictions...")
    v.visualize(pcs_with_pred)


if __name__ == "__main__":

    logging.basicConfig(
        level=logging.INFO,
        format="%(levelname)s - %(asctime)s - %(module)s - %(message)s",
    )

    main()