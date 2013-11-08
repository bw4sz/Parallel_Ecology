#Hello World Script.

require(doSNOW)
require(foreach)

cluster<-makeCluster(4,"SOCK")

# Print the hostname for each cluster member
sayhello <- function()
{
  info <- Sys.info()[c("nodename", "machine")]
  paste("Hello from", info[1], "with CPU type", info[2])
  Sys.sleep(1)
  return(Sys.time())
}

foreach(cluster) %dopar% sayhello()


  ```{r Intro, message=FALSE,results='hide',warning=FALSE}
#install libraries if you don't have them already
#install.packages(c("foreach","doSNOW"))

#Bring in require libraries
require(foreach)
require(doSNOW)
require(ggplot2)
require(dismo)
require(reshape)
```

As you have seen today, R can perform many wonderful statistical functions, like finding the square root of a number

```{r }
sqrt(7)
```
But what if i want to find the square root of 100 numbers, it would be very laborious to write sqrt(1) sqrt(2) sqrt(3) etc.

The for loop
-----------------------------------
  ```{r forloop}
#Let's start by creating a simple for loop
#The basic structure for loop commands is: for(x in 1:n){stuff to do}, where n is the number of times the loop will execute
#here we say print the square root of x for 1,2,3,4,5,6,7,8,9,10...100

for (x in 1:20){
  print(sqrt(x))
}
```
That works fine for small numbers and small operations, but let's pretend the fucntions inside the loop take a long time
What would you do, if, like me, you found yourself looking at a for loop that would take 219 years?
You would start researching parallel loops!
Foreach Loops
----------------------------------------------
```{r foreach}
## Step 2: The foreach loop (package foreach), a special operater that at first looks just like a for loop
dat<-foreach(x=1:20) %do%{
print(sqrt(x))
}
#Notice how the foreach loop convienant can be saved as a output object, and doesn't need to place data into a list or matrix, alot of different outputs can be specific see ?foreach (.combine=)
head(dat)
```
These two setups work the same way, with only slightly different output classes, and take about the same amount of time.
So the added benefit here is, the foreach loop automatically makes a place holder for each item in the loop
To harness the computing power, let's turn that foreach loop into a parallel loop

Foreach loops in parallel
----------------
```{r foreach parallel}
#We have to make a cluster, specifying how many nodes we want, and what type
#If you are working locally, you are using a "SOCK" cluster
#Let's start with 4 nodes
cl<-makeCluster(4,"SOCK")
registerDoSNOW(cl)
foreach(x=1:20) %dopar% {
  print(sqrt(x))
}
```

