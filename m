Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E2282F1;
	Fri, 16 May 2025 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422601; cv=none; b=ngCvsl5F2kVhkE/J6rUoekguT+ZaakxrqLdlm0muTShGsAljnG4XUgsmfqhkUHmCZ/bkmvOYyvzeqJhtCXv0pkZcz/rFLSfOrsJjasjO5xo7qBJexw8uVjUYmF1QFD3dM3qGpDSp3yndW9crLzEE8+mPKYUmSPVP0e/R9a35kz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422601; c=relaxed/simple;
	bh=T9pQlklBqEb3dr3bCWujpWdBMx+KwCjwxio6EbFWcu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0Jv7CJiTtvKBHYw6HUHMg2rGTKIPOAKM2xDR2uX27ZIwZ5/bcbVgmCSaELauV/C6qTMwcxjZPIVZS0m8LBxYQjTyCqJOgCIBSMYKdtRao0aX/nm4GQLzB5pKy6oMJ/jIg2nDNQS5q/AJ6zz9Fsr2Eo7iG85HBfw3PXpKcYSTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P79X9h6e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P79X9h6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00429C4CEE4;
	Fri, 16 May 2025 19:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747422600;
	bh=T9pQlklBqEb3dr3bCWujpWdBMx+KwCjwxio6EbFWcu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P79X9h6ewzj1agY3zPSvYA+BsoQl7SgFxBjr7it9X6I+bs2GLwkbyeSZi3Bmf45GA
	 NTNUqV6fuDZEO1tIEuKBmiwwHYLkhBemJCpQU9ZdMV5pV9ST+tRaLOQaoYgVEJWwEm
	 HbyGA3qQmOiwQpBeSR5pVqnXN/L3MossIUzX4y0b8iEf2lgbUcvKC0VhkeSWu9wjZ9
	 Atq4njOrxMIBlH1ofcA2IkirwcHJ/tv23j7cuwz13ixVe2uDHpoJpAcBAtySPkLAX/
	 PQxm/ZXV7uH5pOTsYG/2/Zu4CGiRfmJJLt6donxK4jlNj1HZLfdyLo10ulgvdQYm41
	 P72QFckfDvumg==
Date: Fri, 16 May 2025 16:09:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux390-list@tuxmaker.boeblingen.de.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf ftrace: Use process/session specific trace settings
Message-ID: <aCeNhagT1CFny8r5@x1>
References: <20250516131023.357458-1-tmricht@linux.ibm.com>
 <aCeJcsJnbi7jfVdK@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCeJcsJnbi7jfVdK@x1>

CCing Steven,

On Fri, May 16, 2025 at 03:52:38PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, May 16, 2025 at 03:10:23PM +0200, Thomas Richter wrote:
> > Executing perf ftrace commands ftrace, profile and latency
> > leave tracing disabled as can seen in this output:
> 
> You forgot to CC lkml and linux-perf-users mailing list, I'm doing it
> now, noticed when b4 didn't manage to find it.
> 
> Thanks for working on this! From a quick glance it looks great, I'm
> testing it now.

So, you create the instance, configure it, and at the end you do a rmdir
that will trow it away, since we don't need it anymore, but then you're
writing to its tunables right before trowing it away, i.e. restoring
previous values? I think you can remove that when using instances,
right?

For instance, at the start you do:

openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-gWVKWs/tracing_on", O_WRONLY|O_TRUNC) = 4
write(4, "1\n", 2) 

And then at the end:

openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-gWVKWs/tracing_on", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2) 

Is that a requirement for "tracing_on", could we do away with that, i.e.
a rmdir would implicitely stop tracing on that instance?

Lemme check:

root@number:~# mkdir /sys/kernel/tracing/instances/perf-ftrace-LX75Yk
root@number:~# echo function_graph > /sys/kernel/tracing/instances/perf-ftrace-LX75Yk/current_tracer 
root@number:~# head -5 /sys/kernel/tracing/instances/perf-ftrace-LX75Yk/trace
# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
  6)   1.924 us    |                        } /* enqueue_entity */
root@number:~# head -10 /sys/kernel/tracing/instances/perf-ftrace-LX75Yk/trace
# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 18)   0.140 us    |                            } /* get_nohz_timer_target */
 18)   0.060 us    |                            enqueue_hrtimer();
 18)   0.041 us    |                            _raw_spin_unlock_irqrestore();
 18)   0.632 us    |                          } /* hrtimer_start_range_ns */
 18)   0.802 us    |                        } /* task_non_contending */
 18)               |                        hrtimer_try_to_cancel() {
root@number:~# head -10 /sys/kernel/tracing/instances/perf-ftrace-LX75Yk/trace
# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 17)   0.090 us    |                  __update_load_avg_se();
 17)   0.051 us    |                  __update_load_avg_cfs_rq();
 17)               |                  update_cfs_group() {
 17)   0.050 us    |                    reweight_entity();
 17)   0.260 us    |                  }
 17)               |                  place_entity() {
root@number:~# rmdir /sys/kernel/tracing/instances/perf-ftrace-LX75Yk
root@number:~# ls -la /sys/kernel/tracing/instances/perf-ftrace-LX75Yk
ls: cannot access '/sys/kernel/tracing/instances/perf-ftrace-LX75Yk': No such file or directory
root@number:~#

Yeah, you can just call rmdir and be done with it :-)

- Arnaldo

mkdir("/sys/kernel/tracing/instances/perf-ftrace-LX75Yk", 0700) = 0
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/tracing_on", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/current_tracer", O_WRONLY|O_TRUNC) = 3
write(3, "nop\n", 4)                    = 4
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
write(3, " \n", 2)                      = 2
openat(AT_FDCWD, "/sys/devices/system/cpu/online", O_RDONLY) = 3
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/tracing_cpumask", O_WRONLY|O_TRUNC) = 3
write(3, "ffffffff\n", 9)               = 9
openat(AT_FDCWD, "/sys/kernel/tracing/max_graph_depth", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/tracing_thresh", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/set_ftrace_filter", O_WRONLY|O_TRUNC) = 3
write(3, " \n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/set_ftrace_notrace", O_WRONLY|O_TRUNC) = 3
write(3, " \n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/set_graph_function", O_WRONLY|O_TRUNC) = 3
write(3, " \n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/set_graph_notrace", O_WRONLY|O_TRUNC) = 3
write(3, " \n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/function-fork", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/func_stack_trace", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/sleep-time", O_WRONLY|O_TRUNC) = 3
write(3, "1\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/funcgraph-irqs", O_WRONLY|O_TRUNC) = 3
write(3, "1\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/funcgraph-proc", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/funcgraph-abstime", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/funcgraph-tail", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/latency-format", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/irq-info", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/trace", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/set_ftrace_pid", O_WRONLY|O_APPEND) = 3
write(3, "1277499\n", 8)                = 8
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/set_ftrace_filter", O_WRONLY|O_APPEND) = 3
write(3, "schedule\n", 9)               = 9
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/current_tracer", O_WRONLY|O_TRUNC) = 3
write(3, "function_graph\n", 15)        = 15
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/trace_pipe", O_RDONLY) = 3
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/tracing_on", O_WRONLY|O_TRUNC) = 4
write(4, "1\n", 2)                      = 2
write(6, "\0", 1)                       = 1
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=1277499, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/tracing_on", O_WRONLY|O_TRUNC) = 4
write(4, "0\n", 2)                      = 2
write(1, "#   DURATION     |      COUNT | "..., 81#   DURATION     |      COUNT | GRAPH                                          |
) = 81
write(1, "     0 -    1 us |          0 | "..., 81     0 -    1 us |          0 |                                                |
) = 81
write(1, "     1 -    2 us |          0 | "..., 81     1 -    2 us |          0 |                                                |
) = 81
write(1, "     2 -    4 us |          0 | "..., 81     2 -    4 us |          0 |                                                |
) = 81
write(1, "     4 -    8 us |          0 | "..., 81     4 -    8 us |          0 |                                                |
) = 81
write(1, "     8 -   16 us |          0 | "..., 81     8 -   16 us |          0 |                                                |
) = 81
write(1, "    16 -   32 us |          0 | "..., 81    16 -   32 us |          0 |                                                |
) = 81
write(1, "    32 -   64 us |          0 | "..., 81    32 -   64 us |          0 |                                                |
) = 81
write(1, "    64 -  128 us |          0 | "..., 81    64 -  128 us |          0 |                                                |
) = 81
write(1, "   128 -  256 us |          0 | "..., 81   128 -  256 us |          0 |                                                |
) = 81
write(1, "   256 -  512 us |          0 | "..., 81   256 -  512 us |          0 |                                                |
) = 81
write(1, "   512 - 1024 us |          0 | "..., 81   512 - 1024 us |          0 |                                                |
) = 81
write(1, "     1 -    2 ms |          0 | "..., 81     1 -    2 ms |          0 |                                                |
) = 81
write(1, "     2 -    4 ms |          0 | "..., 81     2 -    4 ms |          0 |                                                |
) = 81
write(1, "     4 -    8 ms |          0 | "..., 81     4 -    8 ms |          0 |                                                |
) = 81
write(1, "     8 -   16 ms |          0 | "..., 81     8 -   16 ms |          0 |                                                |
) = 81
write(1, "    16 -   32 ms |          0 | "..., 81    16 -   32 ms |          0 |                                                |
) = 81
write(1, "    32 -   64 ms |          0 | "..., 81    32 -   64 ms |          0 |                                                |
) = 81
write(1, "    64 -  128 ms |          0 | "..., 81    64 -  128 ms |          0 |                                                |
) = 81
write(1, "   128 -  256 ms |          0 | "..., 81   128 -  256 ms |          0 |                                                |
) = 81
write(1, "   256 -  512 ms |          1 | "..., 81   256 -  512 ms |          1 | ############################################## |
) = 81
write(1, "   512 - 1024 ms |          0 | "..., 81   512 - 1024 ms |          0 |                                                |
) = 81
write(1, "     1 - ...  s  |          0 | "..., 81     1 - ...  s  |          0 |                                                |
) = 81
write(1, "\n# statistics  (in usec)\n", 25
# statistics  (in usec)
) = 25
write(1, "  total time:              10000"..., 35  total time:              1000044
) = 35
write(1, "    avg time:              10000"..., 35    avg time:              1000044
) = 35
write(1, "    max time:              10000"..., 35    max time:              1000044
) = 35
write(1, "    min time:              10000"..., 35    min time:              1000044
) = 35
write(1, "       count:                   "..., 35       count:                    1
) = 35
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/tracing_on", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/current_tracer", O_WRONLY|O_TRUNC) = 3
write(3, "nop\n", 4)                    = 4
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
write(3, " \n", 2)                      = 2
openat(AT_FDCWD, "/sys/devices/system/cpu/online", O_RDONLY) = 3
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/tracing_cpumask", O_WRONLY|O_TRUNC) = 3
write(3, "ffffffff\n", 9)               = 9
openat(AT_FDCWD, "/sys/kernel/tracing/max_graph_depth", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/tracing_thresh", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/set_ftrace_filter", O_WRONLY|O_TRUNC) = 3
write(3, " \n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/set_ftrace_notrace", O_WRONLY|O_TRUNC) = 3
write(3, " \n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/set_graph_function", O_WRONLY|O_TRUNC) = 3
write(3, " \n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/set_graph_notrace", O_WRONLY|O_TRUNC) = 3
write(3, " \n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/function-fork", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/func_stack_trace", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/sleep-time", O_WRONLY|O_TRUNC) = 3
write(3, "1\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/funcgraph-irqs", O_WRONLY|O_TRUNC) = 3
write(3, "1\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/funcgraph-proc", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/funcgraph-abstime", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/funcgraph-tail", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/latency-format", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
openat(AT_FDCWD, "/sys/kernel/tracing/instances/perf-ftrace-LX75Yk/options/irq-info", O_WRONLY|O_TRUNC) = 3
write(3, "0\n", 2)                      = 2
rmdir("/sys/kernel/tracing/instances/perf-ftrace-LX75Yk") = 0
+++ exited with 0 +++
root@number:~# 

> >  # echo 1 > /sys/kernel/debug/tracing/tracing_on
> >  # cat /sys/kernel/debug/tracing/tracing_on
> >  1
> >  # perf ftrace trace --graph-opts depth=5 sleep 0.1 > /dev/null
> >  # cat /sys/kernel/debug/tracing/tracing_on
> >  0
> >  #
> > 
> > The tracing_on file is not restored to its value before the command.
> > Fix this behavior and restore the trace setting to what
> > is was before the invocation of the command.
> > On Fedora 41 and 42 tracing is turned on by default.
> > 
> > This patch use the .../tracing/instances/XXX subdirectory feature.
> > Each perf ftrace invocation creates its own session/process
> > specific subdirectory and does not change the global state
> > in the .../tracing directory itself.
> > 
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 79 ++++++++++++++++++++++++++++++++++---
> >  1 file changed, 73 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 7caa18d5ffc3..f523039c585f 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -38,6 +38,8 @@
> >  #include "util/units.h"
> >  #include "util/parse-sublevel-options.h"
> >  
> > +#include <sys/stat.h>
> > +
> >  #define DEFAULT_TRACER  "function_graph"
> >  
> >  static volatile sig_atomic_t workload_exec_errno;
> > @@ -45,6 +47,8 @@ static volatile sig_atomic_t done;
> >  
> >  static struct stats latency_stats;  /* for tracepoints */
> >  
> > +static char tracing_instance[PATH_MAX];	/* Trace instance directory */
> > +
> >  static void sig_handler(int sig __maybe_unused)
> >  {
> >  	done = true;
> > @@ -100,6 +104,34 @@ static bool is_ftrace_supported(void)
> >  	return supported;
> >  }
> >  
> > +/*
> > + * Wrapper to test if a file in directory .../tracing/instances/XXX
> > + * exists. If so return the .../tracing/instances/XXX file for use.
> > + * Otherwise the file exists only in directory .../tracing and
> > + * is applicable to all instances, for example file available_filter_functions.
> > + * Return that file name in this case.
> > + *
> > + * This functions works similar to get_tracing_file() and expects its caller
> > + * to free the returned file name.
> > + *
> > + * The global variable tracing_instance is set in init_tracing_instance()
> > + * called a the  beginning to a process specific tracing subdirectory.
> > + */
> > +static char *get_tracing_instance_file(const char *name)
> > +{
> > +	char *file;
> > +
> > +	if (asprintf(&file, "%s/%s", tracing_instance, name) < 0)
> > +		return NULL;
> > +
> > +	if (!access(file, F_OK))
> > +		return file;
> > +
> > +	put_tracing_file(file);
> > +	file = get_tracing_file(name);
> > +	return file;
> > +}
> > +
> >  static int __write_tracing_file(const char *name, const char *val, bool append)
> >  {
> >  	char *file;
> > @@ -109,7 +141,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
> >  	char errbuf[512];
> >  	char *val_copy;
> >  
> > -	file = get_tracing_file(name);
> > +	file = get_tracing_instance_file(name);
> >  	if (!file) {
> >  		pr_debug("cannot get tracing file: %s\n", name);
> >  		return -1;
> > @@ -167,7 +199,7 @@ static int read_tracing_file_to_stdout(const char *name)
> >  	int fd;
> >  	int ret = -1;
> >  
> > -	file = get_tracing_file(name);
> > +	file = get_tracing_instance_file(name);
> >  	if (!file) {
> >  		pr_debug("cannot get tracing file: %s\n", name);
> >  		return -1;
> > @@ -209,7 +241,7 @@ static int read_tracing_file_by_line(const char *name,
> >  	char *file;
> >  	FILE *fp;
> >  
> > -	file = get_tracing_file(name);
> > +	file = get_tracing_instance_file(name);
> >  	if (!file) {
> >  		pr_debug("cannot get tracing file: %s\n", name);
> >  		return -1;
> > @@ -299,6 +331,36 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> >  	return 0;
> >  }
> >  
> > +/* Remove .../tracing/instances/XXX subdirectory created with
> > + * init_tracing_instance().
> > + */
> > +static void exit_tracing_instance(void)
> > +{
> > +	rmdir(tracing_instance);
> > +}
> > +
> > +/* Create subdirectory within .../tracing/instances/XXX to have session
> > + * or process specific setup. To delete this setup, simply remove the
> > + * subdirectory.
> > + */
> > +static int init_tracing_instance(void)
> > +{
> > +	char dirname[] = "instances/perf-ftrace-XXXXXX";
> > +	char *path;
> > +
> > +	path = get_tracing_file(dirname);
> > +	if (!path)
> > +		return -1;
> > +	strcpy(tracing_instance, path);
> > +	put_tracing_file(path);
> > +	path = mkdtemp(tracing_instance);
> > +	if (!path) {
> > +		pr_err("failed to create tracing/instances directory\n");
> > +		return -1;
> > +	}
> > +	return 0;
> > +}
> > +
> >  static int set_tracing_pid(struct perf_ftrace *ftrace)
> >  {
> >  	int i;
> > @@ -648,7 +710,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
> >  
> >  	setup_pager();
> >  
> > -	trace_file = get_tracing_file("trace_pipe");
> > +	trace_file = get_tracing_instance_file("trace_pipe");
> >  	if (!trace_file) {
> >  		pr_err("failed to open trace_pipe\n");
> >  		goto out_reset;
> > @@ -942,7 +1004,7 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
> >  		return -1;
> >  	}
> >  
> > -	trace_file = get_tracing_file("trace_pipe");
> > +	trace_file = get_tracing_instance_file("trace_pipe");
> >  	if (!trace_file) {
> >  		pr_err("failed to open trace_pipe\n");
> >  		return -1;
> > @@ -1323,7 +1385,7 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
> >  
> >  	setup_pager();
> >  
> > -	trace_file = get_tracing_file("trace_pipe");
> > +	trace_file = get_tracing_instance_file("trace_pipe");
> >  	if (!trace_file) {
> >  		pr_err("failed to open trace_pipe\n");
> >  		goto out_reset;
> > @@ -1740,6 +1802,9 @@ int cmd_ftrace(int argc, const char **argv)
> >  	if (!argc && target__none(&ftrace.target))
> >  		ftrace.target.system_wide = true;
> >  
> > +	if (init_tracing_instance())
> > +		goto out_delete_filters;
> > +
> >  	switch (subcmd) {
> >  	case PERF_FTRACE_TRACE:
> >  		cmd_func = __cmd_ftrace;
> > @@ -1839,5 +1904,7 @@ int cmd_ftrace(int argc, const char **argv)
> >  	delete_filter_func(&ftrace.graph_funcs);
> >  	delete_filter_func(&ftrace.nograph_funcs);
> >  
> > +	exit_tracing_instance();
> > +
> >  	return ret;
> >  }
> > -- 
> > 2.49.0
