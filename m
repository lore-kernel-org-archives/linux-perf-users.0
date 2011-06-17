From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/6] trace: add tracepoints to timekeeping code - xtime
 changes
Date: Fri, 17 Jun 2011 16:19:15 +0200
Message-ID: <20110617141913.GF25197@somewhere.redhat.com>
References: <1307490806-24548-1-git-send-email-dsahern@gmail.com>
 <1307490903-24600-1-git-send-email-dsahern@gmail.com>
 <20110617132322.GB25197@somewhere.redhat.com>
 <4DFB60FF.1080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40642 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab1FQOTV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 17 Jun 2011 10:19:21 -0400
Content-Disposition: inline
In-Reply-To: <4DFB60FF.1080500@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, paulus@samba.org, johnstul@us.ibm.com, rostedt@goodmis.org

On Fri, Jun 17, 2011 at 08:13:19AM -0600, David Ahern wrote:
> 
> 
> On 06/17/2011 07:23 AM, Frederic Weisbecker wrote:
> > On Tue, Jun 07, 2011 at 05:55:03PM -0600, David Ahern wrote:
> >> Trace points in timekeeping.c where xtime is modified by a user
> >> or ntp.
> >>
> >> Signed-off-by: David Ahern <dsahern@gmail.com>
> >> ---
> >>  include/trace/events/timekeeping.h |   43 ++++++++++++++++++++++++++++++++++++
> >>  kernel/time/timekeeping.c          |    8 ++++++
> >>  2 files changed, 51 insertions(+), 0 deletions(-)
> >>  create mode 100644 include/trace/events/timekeeping.h
> >>
> >> diff --git a/include/trace/events/timekeeping.h b/include/trace/events/timekeeping.h
> >> new file mode 100644
> >> index 0000000..3d5d083
> >> --- /dev/null
> >> +++ b/include/trace/events/timekeeping.h
> >> @@ -0,0 +1,43 @@
> >> +#undef TRACE_SYSTEM
> >> +#define TRACE_SYSTEM timekeeping
> >> +
> >> +#if !defined(_TRACE_TIMEKEEP_H) || defined(TRACE_HEADER_MULTI_READ)
> >> +#define _TRACE_TIMEKEEP_H
> >> +
> >> +#include <linux/tracepoint.h>
> >> +#include <linux/time.h>
> >> +
> >> +DECLARE_EVENT_CLASS(tod_template,
> >> +
> >> +	TP_PROTO(const struct timespec *tv),
> >> +
> >> +	TP_ARGS(tv),
> >> +
> >> +	TP_STRUCT__entry(
> >> +		__field( __kernel_time_t,	tv_sec)
> >> +		__field( long,			tv_nsec)
> >> +	),
> >> +
> >> +	TP_fast_assign(
> >> +		__entry->tv_sec  = tv->tv_sec;
> >> +		__entry->tv_nsec = tv->tv_nsec;
> >> +	),
> >> +
> >> +	TP_printk("tv_sec=%ld tv_nsec=%ld", __entry->tv_sec, __entry->tv_nsec)
> >> +);
> >> +
> >> +DEFINE_EVENT(tod_template, settimeofday,
> >> +	TP_PROTO(const struct timespec *tv),
> >> +	TP_ARGS(tv));
> >> +
> >> +DEFINE_EVENT(tod_template, timekeeping_inject_offset,
> >> +	TP_PROTO(const struct timespec *tv),
> >> +	TP_ARGS(tv));
> >> +
> >> +DEFINE_EVENT(tod_template, timekeeping_inject_sleeptime,
> >> +	TP_PROTO(const struct timespec *tv),
> >> +	TP_ARGS(tv));
> > 
> > Does the fact it's any of the three way of updating xtime make any
> > difference from the user point of view?
> 
> This use case only cares that xtime is updated.
> 
> > 
> > If not can we rather factorize that in a single settimeofday tracepoint?
> > Or update_time_of_day if we don't want to confuse the user with the
> > syscall.
> 
> Peter and Thomas expressed interest in timekeeping tracepoints. How the
> update happens might be wanted. If desired I can consolidate xtime = *tv
> into a single update function and put the trace point there.

Peter, Thomas, any opinion about that?
