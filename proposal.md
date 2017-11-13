Name: Michael Gilbert           ID:   44823653

## Proposed Project

My project will be an online calculator where a user can enter
a mathematical query in plaintext such as x*sin(x)*exp(x,5.6).
The request will be processed by the application backend and
the mathematical solution will be returned. In addition, a user
can save a value to a variable will a syntax like x <- 6
The backend will maintain a per-user state that tracks the value
of their set variables and the answer to their previous query.
The calculator will support the 4 basic mathematical operators,
the three trigonometric functions, and the exponential function.
I will be implementing the trigonometric and exponential functions using Taylor-Series
polynomials.

## Outline Structure

My module structure will likely be 
>one module to parse the query
>one module to maintain the state
>one module to run a genserver that interacts with the state
>one module to implement the mathematical functions

I will have a supervised agent that maintains a map of variables and values
(including the previous answer), and a supervised server that interacts with that agent
to fetch/set values.
They will both use a one_for_one strategy because each component will be dependent on the other.

> replace all the ">" lines with your content, then push this to
> github and issue a merge request.
