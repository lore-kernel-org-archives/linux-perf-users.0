From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Problems with -b, and confusing error messages
Date: Thu, 6 Oct 2016 13:18:10 -0300
Message-ID: <20161006161810.GA4809@kernel.org>
References: <CAMRJFfLVEHrJ3zqExY=SMzuw8TS7V5A4sy5N2vW9moL=uYvYvg@mail.gmail.com>
 <20161005111131.GO7143@kernel.org>
 <CAMRJFfJeM8XGeNVzzhDom7zoB6fAsFgZrYY69UnW0H2C8Bu0tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752677AbcJFQS2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2016 12:18:28 -0400
Content-Disposition: inline
In-Reply-To: <CAMRJFfJeM8XGeNVzzhDom7zoB6fAsFgZrYY69UnW0H2C8Bu0tw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jonas Wagner <jonas.wagner@epfl.ch>
Cc: linux-perf-users@vger.kernel.org

Em Wed, Oct 05, 2016 at 02:24:53PM +0200, Jonas Wagner escreveu:
> Hi,
> 
> Thanks a lot Arnaldo for your help!
> 
> Unfortunately the problem persists, even with generous permissions and
> when running as root :( Here are some more examples:
> 
> ---
> 
> jowagner@kirk3[~] % sudo perf record -b /bin/true
> Error: 'precise' request may not be supported. Try removing 'p' modifier.
> 
> jowagner@kirk3[~] % sudo perf record -b -e cycles /bin/true
> Error: No hardware sampling interrupt available.
> No APIC? If so then you can boot the kernel with the "lapic" boot
> parameter to force-enable it.

This smells like a problem that could have been fixed, in the kernel, at
a later version, would it be possible to grab a clone of Linus's tree:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Build it using your current kernel config as a start, install, build and
check if the problem persists?

Or you could look at the git log for the Intel PMU code from the kernel
where it works to the current HEAD to see if there are any changesets
that looks related.

- Arnaldo
 
> jowagner@kirk3[~] % perf evlist -v
> zero-sized file (perf.data), nothing to do!
> 
> jowagner@kirk3[~] % sudo perf record /bin/true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.014 MB perf.data (9 samples) ]
> 
> jowagner@kirk3[~] % perf evlist -v
> cycles:pp: size: 112, { sample_period, sample_freq }: 4000,
> sample_type: IP|TID|TIME|PERIOD, disabled: 1, inherit: 1, mmap: 1,
> comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 2,
> sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1
> 
> ---
> 
> Here are my settings in /proc/sys/kernel:
> /proc/sys/kernel/perf_cpu_time_max_percent         25
> /proc/sys/kernel/perf_event_max_sample_rate        100000
> /proc/sys/kernel/perf_event_mlock_kb               516
> /proc/sys/kernel/perf_event_paranoid               0
> /proc/sys/kernel/kptr_restrict                     0
> 
> And these are the CPU flags:
> model name      : Intel(R) Xeon(R) CPU E5-2697 v3 @ 2.60GHz
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
> dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm
> pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer xsave
> avx f16c rdrand lahf_lm abm epb tpr_shadow vnmi flexpriority ept vpid
> fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm xsaveopt
> cqm_llc cqm_occup_llc dtherm ida arat pln pts
> 
> Any other idea about the problem, or hints as to how I could debug it?
> 
> Best,
> Jonas
> 
> On Wed, Oct 5, 2016 at 1:11 PM, Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > Em Tue, Oct 04, 2016 at 05:02:58PM +0200, Jonas Wagner escreveu:
> >> I would like to ask for help, because perf stopped working when I
> >> enable taken branch stack sampling (with the -b option). Here are a
> >> few examples:
> >>
> >> $ perf record -b /bin/true
> >> Error:
> >> 'precise' request may not be supported. Try removing 'p' modifier.
> >>
> >> $ perf record -b -e cycles /bin/true
> >> Error:
> >> No hardware sampling interrupt available.
> >> No APIC? If so then you can boot the kernel with the "lapic" boot
> >> parameter to force-enable it.
> >>
> >> $ perf record -e cycles /bin/true
> >> [ perf record: Woken up 1 times to write data ]
> >> [ perf record: Captured and wrote 0.014 MB perf.data (8 samples) ]
> >>
> >> $ perf record -e cycles:p /bin/true
> >> [ perf record: Woken up 1 times to write data ]
> >> [ perf record: Captured and wrote 0.014 MB perf.data (9 samples) ]
> >>
> >> $ cat /proc/cmdline
> >> BOOT_IMAGE=/boot/vmlinuz-4.4.0-38-generic
> >> root=UUID=a5440a73-d559-4b61-808c-2430cd67ba25 ro quiet lapic
> >>
> >> I have a couple questions about this:
> >>
> >> 1. What's wrong? Branch stack sampling used to work on this machine...
> >> how can I make it work again?
> >> 2. Apparently, the problem is not related to the precise modifier, or
> >> the lapic boot parameter. Could we make these error messages more
> >> meaningful?
> >>
> >> Note regarding (1): I recently upgraded the kernel on this machine
> >> from 4.4.0-36-generic to 4.4.0-38-generic, on Ubuntu Xenial. Using the
> >> previous kernel, perf worked fine. It's tricky for me to undo the
> >> update though :(
> >>
> >> Help would be appreciated. Happy to provide more logs if needed. Thanks!
> >
> > So the message needs to be improved, no question about it, but can you
> > try running as root or tweaking perf_event_paranoid, as here I have:
> >
> > [root@jouet ~]# perf record -b /bin/true
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.024 MB perf.data (9 samples) ]
> > [root@jouet ~]# uname -a
> > Linux jouet 4.7.3-200.fc24.x86_64 #1 SMP Wed Sep 7 17:31:21 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
> > [root@jouet ~]# perf record -b /bin/true
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.024 MB perf.data (8 samples) ]
> > [root@jouet ~]# perf evlist -v
> > cycles:ppp: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|BRANCH_STACK, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, branch_sample_type: ANY
> > [root@jouet ~]#
> >
> >
> > And, as user:
> >
> > [acme@jouet linux]$ perf record -b /bin/true
> > Error:
> > You may not have permission to collect stats.
> >
> > Consider tweaking /proc/sys/kernel/perf_event_paranoid,
> > which controls use of the performance events system by
> > unprivileged users (without CAP_SYS_ADMIN).
> >
> > The current value is 2:
> >
> >   -1: Allow use of (almost) all events by all users
> >>= 0: Disallow raw tracepoint access by users without CAP_IOC_LOCK
> >>= 1: Disallow CPU event access by users without CAP_SYS_ADMIN
> >>= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN
> > [acme@jouet linux]$
> >
> > If I tweak /proc/sys/kernel/perf_event_paranoid, changing it from 2 to 1, say:
> >
> > [acme@jouet linux]$ perf record -b /bin/true
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.024 MB perf.data (9 samples) ]
> > [acme@jouet linux]$ perf evlist -v
> > cycles:ppp: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|BRANCH_STACK, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, branch_sample_type: ANY
> > [acme@jouet linux]$
> >
> > It seems to work.
> >
> > IIRC there was a change in the default of /proc/sys/kernel/perf_event_paranoid
> > in Ubuntu recently, I bet this is the case.
> >
> > Probably they did that but forgot to update the tool, that would get better
> > error messages, but still not that good wrt branch stack support :-\
> >
> > - Arnaldo
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
