From: Milian Wolff <milian.wolff@kdab.com>
Subject: deducing CPU clock rate over time from cycle samples
Date: Sat, 17 Jun 2017 21:07:36 +0200
Message-ID: <2900948.aeNJFYEL58@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:59514 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752125AbdFQTHj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 17 Jun 2017 15:07:39 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hey all,

I would like to graph the CPU load based on a perf.data file that contains 
cycles measurement. I.e. take the following example code:

~~~~~
#include <complex>
#include <cmath>
#include <random>
#include <iostream>

using namespace std;

int main()
{
    uniform_real_distribution<double> uniform(-1E5, 1E5);
    default_random_engine engine;
    double s = 0;
    for (int i = 0; i < 10000000; ++i) {
        s += norm(complex<double>(uniform(engine), uniform(engine)));
    }
    cout << s << '\n';
    return 0;
}
~~~~~

Then compile and measure it:

~~~~~
g++ -O2 -g -std=c++11 test.cpp
perf record --call-graph dwarf ./a.out
~~~~~

Now let's graph the sample period, i.e. cycles, over time:

~~~~~
perf script -F time,period | gnuplot -p -e "plot '-' with linespoints"
~~~~~

Looks pretty good, you can see my result here:

http://milianw.de/files/perf/plot-cpu-load/cycles-over-time.svg

But when I look at the naively calculated first derivative, to visualize CPU 
load, i.e. CPU clock rate in Hz, then things start to become somewhat 
confusing:

~~~~
perf script -F time,period | awk 'BEGIN {lastTime = -1;} { time = $1 + 0.0; if 
(lastTime != -1) {printf("%.6f\t%f\n", time, $2 / (time - lastTime));} 
lastTime = time; }' | gnuplot -p -e "plot '-' with linespoints"
~~~~

Result is here:

http://milianw.de/files/perf/plot-cpu-load/clockrate-over-time.svg

My laptop contains a Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz. According to 
[1] it can go up to 3.20 GHZ for turbo mode. So the tableau at around 3GHz in 
the graph is fine, but the initial spike at around 4.4GHz is pretty excessive, 
no? 

[1]: https://ark.intel.com/products/85215/Intel-Core-i7-5600U-Processor-4M-Cache-up-to-3_20-GHz

Looking at the start of the perf script file, we see this:

~~~~
$ perf script -F time,period | awk 'BEGIN {lastTime = -1;} { time = $1 + 0.0; 
if (lastTime != -1) {printf("%.6f\t%u\t%f\t%g\n", time, $2, (time - lastTime), 
$2 / (time - lastTime));} lastTime = time; }' | head
# time          cycles  time delta      clock rate
65096.173387    1       0.000006        166667
65096.173391    6       0.000004        1.5e+06
65096.173394    56      0.000003        1.86667e+07
65096.173398    579     0.000004        1.4475e+08
65096.173401    6044    0.000003        2.01467e+09
65096.173415    61418   0.000014        4.387e+09
65096.173533    188856  0.000118        1.60047e+09
65096.173706    215504  0.000173        1.24569e+09
65096.173811    227382  0.000105        2.16554e+09
65096.173892    266808  0.000081        3.29393e+09
~~~~

When I repeat this measurement, or look at different applications, I can 
sometimes observe values as large as 10GHz. So clearly something is wrong, 
somewhere...

But what? Can someone tell me what I'm seeing here? Is the time measurement 
too inaccurate (i.e. the delta too low)? Is the PMU cycle counter inaccurate 
(i.e. too high)? Is my naive derivative simply not a good idea (why)?

Thanks

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
