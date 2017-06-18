From: Andi Kleen <andi@firstfloor.org>
Subject: Re: deducing CPU clock rate over time from cycle samples
Date: Sat, 17 Jun 2017 21:22:19 -0700
Message-ID: <87efuivsas.fsf@firstfloor.org>
References: <2900948.aeNJFYEL58@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:62764 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbdFREWV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 18 Jun 2017 00:22:21 -0400
In-Reply-To: <2900948.aeNJFYEL58@agathebauer> (Milian Wolff's message of "Sat,
        17 Jun 2017 21:07:36 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Milian Wolff <milian.wolff@kdab.com> writes:
>
> But when I look at the naively calculated first derivative, to visualize CPU 
> load, i.e. CPU clock rate in Hz, then things start to become somewhat 
> confusing:
>
> ~~~~
> perf script -F time,period | awk 'BEGIN {lastTime = -1;} { time = $1 + 0.0; if 
> (lastTime != -1) {printf("%.6f\t%f\n", time, $2 / (time - lastTime));} 
> lastTime = time; }' | gnuplot -p -e "plot '-' with linespoints"
> ~~~~

The perf time stamps approach the maximum precision of double (12 vs
15 digits). Likely the division loses too many digits, which may cause
the bogus results. I've ran into similar problems before.

One way around is is to normalize the time stamps first that they
start with 0, but this only works for shorter traces.
Or use some bignum float library

Also at the beginning of frequency the periods are very small, and
the default us resolution will give big jumps for such a calculation.
It's better to use the script --ns option then, but that makes the
double precision problem event worse.

In generally you get better results by avoiding frequency mode,
but always specify a fixed period. 

-Andi
