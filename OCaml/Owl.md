# Install OWL

Archlinux packages:
```sh
pacman -S lapacke openblas 
yay -S plplot
```

Using opam:
```sh
opam install owl=1.0.2
opam install owl-jupyter
opam pin add git+https://github.com/owlbarn/owl-pyplot.git
```

Install jupyter notebook compatibility:
```sh
opam install jupyter 
ocaml-jupyter-opam-genspec
jupyter kernelspec install --name ocaml-jupyter --user "$(opam config var share)/jupyter"
echo '#use "topfind";;' >> ~/.ocamlinit
```
