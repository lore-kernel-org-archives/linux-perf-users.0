From: Vince Weaver <vincent.weaver-e7X0jjDqjFGHXe+LvDLADg@public.gmane.org>
Subject: Re: [RFC] perf: proposed perf_event_open() manpage
Date: Wed, 24 Oct 2012 13:51:41 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1210241238270.1411@vincent-weaver-1.um.maine.edu>
References: <alpine.DEB.2.02.1210221623340.19390@pianoman.cluster.toy> <alpine.DEB.2.02.1210221629560.29528@vincent-weaver-1.um.maine.edu> <CAKgNAkjKFiu2CPxq_eT5C_a2H0WKT_u_jX940=2xS9Smfkmgqg@mail.gmail.com> <alpine.DEB.2.02.1210222325200.23913@atom-power>
 <CAKgNAkjW5tp+f7Ai3FMtWcbUWhztoROCQ1=WM=3okFQLCDY3+Q@mail.gmail.com> <alpine.DEB.2.02.1210231127550.24986@vincent-weaver-1.um.maine.edu> <878vaw9x6x.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <878vaw9x6x.fsf-vfBCOVm4yAnB69T4xOojN9BPR1lH4CV8@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Namhyung Kim <namhyung-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vince Weaver <vincent.weaver-e7X0jjDqjFGHXe+LvDLADg@public.gmane.org>, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-perf-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephane Eranian <eranian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
List-Id: linux-perf-users.vger.kernel.org

On Wed, 24 Oct 2012, Namhyung Kim wrote:

> > .BI "int perf_event_open(struct perf_event_attr *" hw_event ,
> 
> hw_event?  Looks unusual.. how about 'attr'?

this (and some of the other stuff) is because the manpage used the 
somewhat out of date "tools/perf/design.txt" as a reference.

It looks like the perf tool uses "attr" here, so I'll make that change.

> > is measured, and if
> > .I pid
> > is less than 0, all processes are counted.
> 
> Is that true?  Shouldn't pid be -1?

tools/perf/design.txt claims less than 0, but you're right, in
kernel/events/core.c there are a lot of explicit checks for pid==-1

I'll fix this.

> > Note that the combination of
> > .IR pid " == \-1"
> > and
> > .IR cpu " == \-1"
> > is not valid.
> > .P
> > A
> > .IR pid " > 0"
> 
> s/>/>=/ ?

Again, from tools/perf/design.txt
Is it meaningful to monitor pid 0?
I tried using perf stat to measure pid 0 and it just reports
"Problems finding threads of monitor"

> > Per-CPU events need the
> > .B CAP_SYS_ADMIN
> > capability.
> 
> Or value of perf_event_paranoid is less than 1.

I'll add that.

> > .TP
> > .RB "dynamic PMU"
> > Since Linux 2.6.39,
> > .BR perf_event_open()
> > can support multiple PMUs.
> > To enable this, a value exported by the kernel can be used in the
> > .I type
> > field to indicate which PMU to use.
> > The value to use can be found in the sysfs filesystem:
> > there is a subdirectory per PMU instance under
> > .IR /sys/devices .
> 
> /sys/bus/event_source/devices will be the right place.

I'll update that.

> > In each sub-directory there is a
> > .I type
> > file whose content is an integer that can be used in the
> > .I type
> > field.
> > For instance,
> > .I /sys/devices/cpu/type
> 
> /sys/bus/event_source/devices/cpu/type

Well, the former works too, but I guess the latter is more clear.

> > .TP
> > .IR sample_period ", " sample_freq
> > A "sampling" counter is one that generates an interrupt
> > every N events, where N is given by
> > .IR sample_period .
> > A sampling counter has
> > .IR sample_period " > 0."
> 
> How about adding this here:
> 
> "When an (overflow) interrupt generated, requested data (sample) would
> be recorded."

OK.


> > The kernel will adjust the sampling period
> > to try and achieve the desired rate.
> > The rate of adjustment is a
> > timer tick.
> 
> Is that true?  I thought it'd be adjusted whenever overflow occures.

I was told that during an e-mail discussion I was having once about why 
IOC_REFRESH as used by PAPI gives weird results.  I can't seem to find the 
exact reference though.  It would be nice to have an official 
clarification.

> > .TP
> > .I "sample_type"
> > The various bits in this field specify which values to include
> > in the overflow packets.
> 
> I guess the overflow packets here means samples.  It'd be better if we
> use a consistent word for specifying a thing.

I'll try to make things more consistent.

> > .TP
> > .B PERF_SAMPLE_READ
> > [To be documented]
> 
> It's for an event group to sample leader only.  Values of other members
> will be read when an interrupt occurred on the leader.

I'll add that.

> > .TP
> > .B PERF_SAMPLE_CALLCHAIN
> > [To be documented]
> 
> callchain (or stack backtrace)

are the values stored in the sample buffer for all of these documented 
somewhere?

> > .TP
> > .B PERF_SAMPLE_ID
> > [To be documented]
> 
> unique(?) id for the opened event.

Is this the same ID as that when using PERF_FORMAT_ID?

> > .TP
> > .B PERF_SAMPLE_CPU
> > [To be documented]
> 
> cpu number

OK

> > .TP
> > .B PERF_SAMPLE_PERIOD
> > [To be documented]
> 
> event count

What event count?  The count that caused the sample to happen?

> > .TP
> > .B PERF_SAMPLE_RAW
> > [To be documented]
> 
> additional data - usually for tracepoint events

What type of additional data?

> > .TP
> > .BR PERF_SAMPLE_BRANCH_STACK " (Since Linux 3.4)"
> > [To be documented]
> 
> requested branch stack - only supported on intel machines which has LBR
> feature(?).  See branch_sample_type.

I'll add.
 
> > .RE
> [snip]
> > .SS /proc/sys/kernel/perf_event_paranoid
> >
> > The
> > .I /proc/sys/kernel/perf_event_paranoid
> > file can be set to restrict access to the performance counters.
> > 2
> > means no measurements allowed,
> 
> This is not true.  It only allows user mode measurements.

Interesting.  Is there some way to totally disable perf_events?
It is a security hole, and it's not easy to configure an x86 kernel
w/o perf_event support.

I'll update with expanded descriptions.

In addition, would it be useful to include documentation on the files in
/sys/bus/event_source/devices/
 such as
   type
   format/
   uevent
   rdpmc
or would these get documented elsewhere?

Thanks for the valuable feedback!

Vince Weaver
vincent.weaver-e7X0jjDqjFGHXe+LvDLADg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-man" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
