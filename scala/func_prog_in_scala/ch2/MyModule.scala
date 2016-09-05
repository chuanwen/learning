/** MyModule demo a simple scala program **/
object MyModule {
    def abs(n: Int): Int = {
        if (n < 0) -n
        else n
    }

    def factorial(n: Int): Int = {
        @annotation.tailrec
        def go(n: Int, acc: Int): Int = {
            if (n <= 0) acc
            else go(n-1, n*acc)
        }
        go(n, 1)
    }

    def fib(n: Int): Int = {
        @annotation.tailrec
        def loop(n: Int, acc:(Int, Int)): Int = {
            if (n == 2) acc._1 + acc._2
            else loop(n-1, (acc._2, acc._1 + acc._2))
        }
        if (n == 0) 0
        else if (n == 1) 1
        else loop(n, (0, 1))
    }

    def findFirst[A](arr: Array[A], p: A => Boolean): Int = {
        @annotation.tailrec
        def loop(n: Int): Int = {
            if (n >= arr.length) -1
            else if (p(arr(n))) n
            else loop(n+1)
        }
        loop(0)
    }

    def isSorted[A](arr: Array[A], ordered: (A,A) => Boolean): Boolean = {
        @annotation.tailrec
        def loop(n: Int): Boolean = {
            if (n == arr.length) true
            else if (!ordered(arr(n-1), arr(n))) false
            else loop(n+1)
        }
        if (arr.length == 0) true
        else loop(1)
    }

    private def formatResult(name: String, x: Int, fn: Int => Int): String = {
        val msg = "The %s value of %d is %d"
        msg.format(name, x, fn(x))
    }

    def main(args: Array[String] = Array()): Unit = {
        println(formatResult("abs", -42, abs))
        println(formatResult("factorial", 10, factorial))
        println(formatResult("fib", 10, fib))
    }
}
