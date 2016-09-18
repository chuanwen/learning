# Calculator

### Compile
```sh
$ make
```

### Example run:

```sh
$ ./calculator

print (1+2)*3
9

i = 1
x = 0
y = 0
while (i <= 100) {
	x += i
    y += (i % 3) * i^(-0.5)
    i++
}
print x
5050

print y
18.850364
```