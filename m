From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: deducing CPU clock rate over time from cycle samples
Date: Sun, 18 Jun 2017 21:53:05 +0200
Message-ID: <1654509.hqsMC4Q0uj@agathebauer>
References: <2900948.aeNJFYEL58@agathebauer> <87efuivsas.fsf@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:54208 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbdFRTxJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 18 Jun 2017 15:53:09 -0400
In-Reply-To: <87efuivsas.fsf@firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On Sonntag, 18. Juni 2017 06:22:19 CEST Andi Kleen wrote:
> Milian Wolff <milian.wolff@kdab.com> writes:
> > But when I look at the naively calculated first derivative, to visualize
> > CPU load, i.e. CPU clock rate in Hz, then things start to become somewhat
> > confusing:
> > 
> > ~~~~
> > perf script -F time,period | awk 'BEGIN {lastTime = -1;} { time = $1 +
> > 0.0; if (lastTime != -1) {printf("%.6f\t%f\n", time, $2 / (time -
> > lastTime));} lastTime = time; }' | gnuplot -p -e "plot '-' with
> > linespoints"
> > ~~~~
> 
> The perf time stamps approach the maximum precision of double (12 vs
> 15 digits). Likely the division loses too many digits, which may cause
> the bogus results. I've ran into similar problems before.

I don't think so, just look at the raw values:

$ perf script -F time,period --ns  
71789.438122347:          1 
71789.438127160:          1 
71789.438129599:          7 
71789.438131844:         94 
71789.438134282:       1391 
71789.438139871:      19106 
71789.438156426:     123336
...

$ qalc '123336/(71789.438156426s - 71789.438139871s) to Hz'
123336 / ((71789.438 * second) - (71789.438 * second)) = approx. 7.4500755E9 
Hz

> One way around is is to normalize the time stamps first that they
> start with 0, but this only works for shorter traces.
> Or use some bignum float library

I take the time delta between two samples, so a normalization of the 
individual times to 0 would not affect my calculations - the delta stays the 
same after all.

Also, using bignum in my calculations wouldn't change anything either. If perf 
tells me that 123336 cycles have been executed in 16.555 us, then it will 
always be larger than any expected value. At 3.2GHz it should be maximally 
52976 cycles in such a short timeframe...

> Also at the beginning of frequency the periods are very small, and
> the default us resolution will give big jumps for such a calculation.

OK, but who/what measures the large cycle values then? Is this a PMU 
limitation? Or is this an issue with the interaction with the kernel, when the 
algorithm tries to find a good frequency at the beginning?

> It's better to use the script --ns option then, but that makes the
> double precision problem event worse.

See above, using `--ns` doesn't change anything. And qalc e.g. already uses 
bignum internally.

> In generally you get better results by avoiding frequency mode,
> but always specify a fixed period.

This indeed removes the spikes at the beginning:

perf record --switch-events --call-graph dwarf -P -c 500000

The value is chosen to give a similar sample count to frequency mode. 

Thanks

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
