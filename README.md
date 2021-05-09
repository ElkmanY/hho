# Harris Hawks Optimization (HHO)
This repository contains the Harris Hawks Optimization code (matlab M-file) for optimizing the benchmark function:

```
.
├── img
|   ├── convergence-2d.png
|   ├── convergence-50d.png
|   ├── logo.jpg 
|   ├── schwefel_222.gif
|   └── trajectory.png
├── _config.yml
├── hho.m —— [function of harris hawks optimization]
├── LICENSE
├── README.md
└── test.m —— [a test for 'hho.m']
```

## Usage

```matlab
[fbst, xbst, performance] = hho ( objective, d, lmt, n, T, S )
```
where
 - `objective` is the function handle of the objective function
 - `d` is the dimension of the design variable
 - `lmt` is the limit of the design variable; is a matrix with `d` rows and 2 column, and the first column contains lower limits of all dimension while the second upper ones.
 - `n` is the population size of the particle swarm
 - `T` is the maximum iteration times.
 - `fbst` is the fitness of the optimal solution
 - `xbst` is the optimal solution
 - `performance` is contains the best fitness value, the average fitness value and the standard deviation.

## Test

For instance, a benchmark *[Schwefel 2.22](http://benchmarkfcns.xyz/benchmarkfcns/schwefel222fcn.html)* is chosen for a test: 

![benchmark](/img/schwefel_222.gif)

Here, this benchmark is coded as a function handle
```matlab
schwefel_222 = @(x) sum(abs(x))+prod(abs(x));
```
where `x` is a `d`-by-`n` matrix.

To run the test by executing
```matlab 
test.m
```
The test including two runs:
 - 30-`d` benchmark
    
    The results includes an optimal solution, its fitness and an execution time. 
    Also, a plot of the convergence curve of fitness is shown. 

    ![convergence-30d](/img/convergence-30d.png#pic_center)

 - 2-`d` benchmark
    
    The results includes an optimal solution, its fitness and an execution time. 
    Also, a plot of the convergence curve of fitness, a plot of the trajectory of global optimal are shown. 

    ![convergence-2d](/img/convergence-2d.png#pic_center)

    ![trajectory](/img/trajectory.png#pic_center)


## Reference:

[1] Article: *[Harris hawks optimization: Algorithm and applications](https://www.sciencedirect.com/science/article/pii/S0167739X18313530)*

[2] Repo: *[BenchmarkFcns](https://github.com/mazhar-ansari-ardeh/BenchmarkFcns)*