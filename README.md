# undocker

## Build Docker Image

Build Docker image with remote context.
```
docker build -t crunos/undocker https://github.com/crunos/undocker.git#main
```

## Usage

Use undocker in current directory. Default CMD is `--help`
```
docker run --rm -ti -v $(pwd):$(pwd) -w $(pwd) crunos/undocker 
```
