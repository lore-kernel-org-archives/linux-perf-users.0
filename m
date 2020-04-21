From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: kernel/perf: Sample data being lost
Date: Tue, 21 Apr 2020 12:59:46 -0300
Message-ID: <20200421155946.GB12295@kernel.org>
References: <f09e62d0-af40-683a-648f-3c3b7137369b@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f09e62d0-af40-683a-648f-3c3b7137369b@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Apr 21, 2020 at 05:54:29PM +0200, Thomas Richter escreveu:
> Since a couple of days I see this warning popping up very often:
> 
> [root@m35lp76 perf]# ./perf record --call-graph dwarf -e rb0000 -- find /
> [ perf record: Woken up 282 times to write data ]
> Warning:
> Processed 16999 events and lost 382 chunks!
> 
> Check IO/CPU overload!
> 
> [ perf record: Captured and wrote 125.730 MB perf.data (16219 samples) ]
> [root@m35lp76 perf]#
> 
> The machine is idle, its my development system, so not much going on.
> It also happens using a software event, for example cycles. It shows
> up more often, the larger the sample size is. So for example:
> 
> [root@m35lp76 perf]# pwd
> /root/linux/tools/perf
> [root@m35lp76 perf]#  ./perf record  --call-graph dwarf -- find
> [ perf record: Woken up 2 times to write data ]
> Warning:
> Processed 231 events and lost 7 chunks!
> 
> Check IO/CPU overload!
> 
> [ perf record: Captured and wrote 1.000 MB perf.data (130 samples) ]
> [root@m35lp76 perf]#
> 
> I have very seldom observed this before, only in extremely rare cases with
> a heavily loaded machine. I am wondering what has changed, I haven't
> changed anything in the s390 PMU device drivers.
> It could be
>  - common kernel code when writing into the ringbuffer.
>  - the perf tool too slow to read data from the mapped buffer.
>    However I have not come across changes in this area.
> 
> Has anybody observed similar issue?
> 
> PS: I have added some printk messages into my PMU devices drivers.
> I have seen messages that the 16384 pages for auxilary buffers are full
> and that samples have been dropped.

Can you try to bisect tools/perf?

Something like:

git checkout v5.4

build it, no problems? Use it as the 'git bisect good' starting point.

- Arnaldo
