## Venv 
Create a virtual environment with system packages:
```shell
python -m venv --system-site-packages .venv 
source .venv/bin/activate
pip install -r requirements
```

Create a virtual environment with specific Python version: 
```shell
virtualenv --path='/usr/bin/python3.12' .venv
```


## Jupyter 

Link your virtual environment with Jupyter: 
```shell
source .venv/bin/activate
pip install ipykernel
python -m ipykernel install --user --name=supervenv --display-name="Super Venv!"
```
