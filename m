From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Mixed group of sw/hw counters are not started if sw counter is
 group leader
Date: Tue, 29 Jan 2013 15:01:10 +0100
Message-ID: <20130129140110.GF8339@krava.brq.redhat.com>
References: <CAGz0_-0ti+_3cXQhYUAb_-zKqHBcPVYjFtQ86ZGr8utXF13Rag@mail.gmail.com>
 <20130129123908.GC8339@krava.brq.redhat.com>
 <CAGz0_-2O+7a5Bkeu3vgNFYrsGGYJxrqECKQUJJTwSDQZBktLjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64494 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756503Ab3A2OBS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Jan 2013 09:01:18 -0500
Content-Disposition: inline
In-Reply-To: <CAGz0_-2O+7a5Bkeu3vgNFYrsGGYJxrqECKQUJJTwSDQZBktLjw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andreas Hollmann <hollmann@in.tum.de>
Cc: linux-perf-users@vger.kernel.org

On Tue, Jan 29, 2013 at 02:43:34PM +0100, Andreas Hollmann wrote:
> > hm, I'm getting following stats when running perf stat in similar scenario:
> >
> > [jolsa@dhcp-26-214 perf]$ ./perf stat -e '{task-clock,cpu-clock,instructions}' kill
> > usage: kill [ -s signal | -p ] [ -a ] pid ...
> >        kill -l [ signal ]
> >
> >  Performance counter stats for 'kill':
> >
> >           1.039561 task-clock                #    0.479 CPUs utilized
> >      <not counted> cpu-clock
> >          2,281,726 instructions              #    0.00  insns per cycle
> >
> >        0.002168502 seconds time elapsed
> > ...
> >
> > seems wrong ;-) will check
> >
> > thanks,
> > jirka
> 
> creating groups with perf stat is new for me and not documented ?

there's following switch for stat:
    -g, --group           put the counters into a counter group
and for record:
        --group           put the counters into a counter group

that will make all the '-e events' act as group

and there's {} syntax wich creates groups out of any events you enclose

and yep it's not in any man page so far.. it's been on my TODO list for
some time now ;-)

jirka

> 
> running the same works for me:
> 
> [capjo@e6410 ~]$ perf stat -v -e '{task-clock,cpu-clock,instructions}' kill
> usage: kill [ -s signal | -p ] [ -a ] pid ...
>        kill -l [ signal ]
> task-clock: 884808 884808 884808
> cpu-clock: 885924 884808 884808
> instructions: 735287 884808 884808
> 
>  Performance counter stats for 'kill':
> 
>           0.884808 task-clock                #    0.687 CPUs utilized
>           0.885924 cpu-clock
>            735,287 instructions              #    0.00  insns per cycle
> 
>        0.001287584 seconds time elapsed

hum, mine's not working.. seems like some event scheduling
issue fox mixed events group

> 
> [capjo@e6410 ~]$ perf --version
> perf version 3.7-5
> [capjo@e6410 ~]$ uname -a
> Linux e6410 3.7.4-1-ARCH #1 SMP PREEMPT Mon Jan 21 23:05:29 CET 2013
> x86_64 GNU/Linux
