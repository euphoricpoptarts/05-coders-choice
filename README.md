# Coder's Choice

#Premise and Usage

This project implements a simple web-based calculator app.

The app can add, subtract, divide and multiple, and uses PEMDAS to determine order of operations.

In addition, sin(x), cos(x), and tan(x) (x in radians) are available.

pow(a,b) and log(a,b) (a is the base) are also available.

I decided not to implement the functions myself using Taylor/Maclaurin Series as I
couldn't find a good way to find the floating point modulus of a number with respect to 2*pi

Queries can consist of any combination of the basic operators and math functions,
but be sure each query follows PEMDAS, and do not include extraneous whitespace.

Variables can be set using the format "x <- 23*5" where the left side of the arrow
can be only a single variable, and the right side can be any valid query.

White-space is okay immediately around the arrow.

Here are some valid query examples:

log(2,8*4)

8*sin(2*-4)

4*sin(7+(3-(5)-(2)/(9 *-6)))

x <- log(2,8*4)

y <- 7*x

-1*-2--3+-4

Note however that -tan(some input resulting in a negative value of tan(x)) will produce unexpected results
If you wish to negate the value of a function that is at the beginning of a query, use -1*tan/sin/cos/pow/log

In the case of a variable assignment, the app will display the value that was assigned.

Do not use a variable unless you have already assigned a value to it, or you will get an error.

In order to run the app, run

>mix phx.server

inside the proj_5 folder.