# M1 Python command

## Conda Environment
Create an empty Conda Environment and named "tf24", then activate it and install python 3.8.
conda create --name tf24

```
conda activate tf24
conda install -y python==3.8.6
conda install -y pandas matplotlib scikit-learn jupyterlab
```

## VirtualEnv Environment 
Create an empty VirtualEnv Environment and named "virtual", then activate it.

```
virtualenv -p python3 env 				#Create with lastest python version
virtualenv --python=python3.8 env 	#Create with python 3.8
```


## For Anaconda 
User just this instead of pip

```
conda install -c menpo opencv
```



## Install Torch

[Instrument Video](https://www.youtube.com/watch?v=pD_mKNeHwFs)
[Instrument Get-started](https://pytorch.org/get-started/previous-versions/)

```
conda create --name pytorch_env
conda install pytorch -c isuruf/label/pytorch -c conda-forge
conda install typing-extensions
conda install -c conda-forge torchvision
```

## Install keras-contrib

```
git clone https://www.github.com/keras-team/keras-contrib.git \
    && cd keras-contrib \
    && python convert_to_tf_keras.py \
    && USE_TF_KERAS=1 python setup.py install
    
conda install scikit-image
https://www.jimbobbennett.io/installing-scikit-learn-on-an-apple-m1/
```

# Check-List

- [x] Miniforge: https://github.com/conda-forge/miniforge
  * brew install miniforge
- [x] TF 2.4: https://github.com/apple/tensorflow_macos
- [x] Numpy: https://numpy.org/install/
  * pip install numpy
- [x] Python-math
  * pip install python-math
- [x] PyTorch: https://pytorch.org/
  * pip install torch torchvision torchaudio
- [x] Pyplot: https://matplotlib.org/stable/tutorials/introductory/pyplot.html

