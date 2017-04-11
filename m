From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf sampling frequency drops after some record rounds?
Date: Tue, 11 Apr 2017 11:49:52 -0300
Message-ID: <20170411144952.GA16317@kernel.org>
References: <14226027.icvnRACTdJ@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753169AbdDKOuD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Apr 2017 10:50:03 -0400
Content-Disposition: inline
In-Reply-To: <14226027.icvnRACTdJ@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Perf Users <linux-perf-users@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Nate Rogers <nate.rogers@kdab.com>

Em Tue, Apr 11, 2017 at 03:49:06PM +0200, Milian Wolff escreveu:
> Hello all,
> 
> a colleague of mine (CC'ed) is encountering a strange issue with perf from 
> Ubuntu 16.04 running on a Thinkpad P50 with Intel(R) Core(TM) i7-6700HQ CPU @ 
> 2.60GHz on 4.4.0-72-generic with perf version 4.4.49.
> 
> For him, the sampling frequency drops dramatically after some successful 
> records, making perf record essentially unusable afterwards:
> 
> First, everything is nice and peachy:
> 
> Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
> 6.66491e+16
> [ perf record: Woken up 20 times to write data ]
> [ perf record: Captured and wrote 4.926 MB perf.data (613 samples) ]
> Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
> 6.66491e+16
> [ perf record: Woken up 19 times to write data ]
> [ perf record: Captured and wrote 4.734 MB perf.data (591 samples) ]
> Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
> 6.66491e+16
> [ perf record: Woken up 19 times to write data ]
> [ perf record: Captured and wrote 4.750 MB perf.data (591 samples) ]
> Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
> 6.66491e+16
> [ perf record: Woken up 20 times to write data ]
> [ perf record: Captured and wrote 4.766 MB perf.data (593 samples) ]
> Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
> 6.66491e+16
> [ perf record: Woken up 19 times to write data ]
> [ perf record: Captured and wrote 4.750 MB perf.data (591 samples) ]
> 
> But then, suddenly:
> 
> Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
> 6.66491e+16
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.082 MB perf.data (10 samples) ]
> Tr0g@PC:~$ perf record --call-graph dwarf -F 999 ./cpp-inlining
> 6.66491e+16
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.082 MB perf.data (10 samples) ]
> 
> dmesg only shows:
> 
> [28449.132447] perf interrupt took too long (2510 > 2500), lowering 
> kernel.perf_event_max_sample_rate to 50000
> 
> But that should still be large enough to encompass the above. Also, increasing 
> that value to, say, 100000 does not help this situation. The only known 
> workaround is to restart the machine to make it work again.
> 
> Is this a known kernel bug in that version? Anything he can try out to fix 
> this situation? Anything he could do, other than restarting this machine, to 
> bring back the usable sampling frequency?

I don't recall any specific patch, but a quick look showed a few patches
fixing the auto throttling of that max_sample_rate knob.

In such cases you guys could help by trying to build the latest kernel
using the config you have, and see if the problem persists. A bisection
would then point what is the problem, else that would help in pointing
out a bug in the current code.

Or you could try to workaround that a bit by reducing the size of the
stack dump collected via --call-graph dwarf, to reduce the time spent in
NMI that leads to the auto-throttling of the sample rate.

Also there are some other knobs that could be tweaked somehow to see if
they help:

[acme@jouet linux]$ ls -la /proc/sys/kernel/*perf*
-rw-r--r--. 1 root root 0 Apr 11 11:49 /proc/sys/kernel/perf_cpu_time_max_percent
-rw-r--r--. 1 root root 0 Apr 10 12:18 /proc/sys/kernel/perf_event_max_contexts_per_stack
-rw-r--r--. 1 root root 0 Apr 11 10:09 /proc/sys/kernel/perf_event_max_sample_rate
-rw-r--r--. 1 root root 0 Apr 10 12:18 /proc/sys/kernel/perf_event_max_stack
-rw-r--r--. 1 root root 0 Apr 11 08:43 /proc/sys/kernel/perf_event_mlock_kb
-rw-r--r--. 1 root root 0 Apr 10 12:18 /proc/sys/kernel/perf_event_paranoid
[acme@jouet linux]$

- Arnaldo
