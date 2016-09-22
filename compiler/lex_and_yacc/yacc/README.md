# Calculator

### Compile
```sh
$ make
```

### Example run:
(NEW)
```
$ make all
$ ./calc p0.ca
10.500000
$ ./calc p1.ca
2
3
4
5
6
7
8
9
10
11

$./calcc p1.ca
$./p1
2.000000
3.000000
4.000000
5.000000
6.000000
7.000000
8.000000
9.000000
10.000000
11.000000
```

OLD
```
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
