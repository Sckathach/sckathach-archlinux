# Dune 

## Install Dune 
```sh
opam install dune 
eval $(opam env)
```

## Usage 
Check [Makefile](Makefile).

## Initialisation
```sh
dune init proj <proj_name>
```

## With a single file 
Init the dune file (`dune`):
```
(executable
  (name <your_proj>))
```

## Warning are non-fatal
```
(env
  (dev
    (flags (:standard -warn-error -A))))
```
