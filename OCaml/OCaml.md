# OCaml installation on Linux 

## Opam

```shell
pacman -S opam 
opam init
eval $(opam env)
opam install dune merlin ocaml-lsp-server odoc ocamlformat utop dune-release
```

### Specific OCaml switch 
```shell
opam switch create 5.2.0
opam switch list 
evval $(opam env --switch=5.2.0)
```

### Zshrc/ Bashrc
```
# ~/.zshrc

# Opam configuration
[[ ! -r /home/sckathach/.opam/opam-init/init.zsh ]] || source /home/sckathach/.opam/opam-init/init.zsh  > /        dev/    null 2> /dev/null
```
