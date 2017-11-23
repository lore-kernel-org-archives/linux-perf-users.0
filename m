From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: measuring system wide CPU usage ignoring idle process
Date: Thu, 23 Nov 2017 15:09:31 +0100
Message-ID: <20171123140931.GA5575@krava>
References: <3344812.IFj9h2T05j@agathebauer>
 <215895928.dRJQAAs51a@agathebauer>
 <20171120234438.GA22397@krava>
 <6754554.PRelPk1P9n@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752940AbdKWOJd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Nov 2017 09:09:33 -0500
Content-Disposition: inline
In-Reply-To: <6754554.PRelPk1P9n@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>

On Thu, Nov 23, 2017 at 02:40:36PM +0100, Milian Wolff wrote:
> On Tuesday, November 21, 2017 12:44:38 AM CET Jiri Olsa wrote:
> > On Mon, Nov 20, 2017 at 09:24:42PM +0100, Milian Wolff wrote:
> > > On Montag, 20. November 2017 15:29:08 CET Jiri Olsa wrote:
> > > > On Mon, Nov 20, 2017 at 03:00:46PM +0100, Milian Wolff wrote:
> > > > > Hey all,
> > > > > 
> > > > > colleagues of mine just brought this inconvenient perf stat behavior
> > > > > to my
> > > > > attention:
> > > > > 
> > > > > $ perf stat -a -e cpu-clock,task-clock,cycles,instructions sleep 1
> > > > > 
> > > > >  Performance counter stats for 'system wide':
> > > > >        4004.501439      cpu-clock (msec)          #    4.000 CPUs
> > > > >        utilized
> > > > >        4004.526474      task-clock (msec)         #    4.000 CPUs
> > > > >        utilized
> > > > >        945,906,029      cycles                    #    0.236 GHz
> > > > >        461,861,241      instructions              #    0.49  insn per
> > > > >        cycle
> > > > >        
> > > > >        1.001247082 seconds time elapsed
> > > > > 
> > > > > This shows that cpu-clock and task-clock are incremented also for the
> > > > > idle
> > > > > processes. Is there some trick to exclude that time, such that the CPU
> > > > > utilization drops below 100% when doing `perf stat -a`?
> > > > 
> > > > I dont think it's the idle process you see, I think it's the managing
> > > > overhead before the 'sleep 1' task goes actualy to sleep
> > > > 
> > > > there's some user space code before it gets into the sleep syscall,
> > > > and there's some possible kernel scheduling/syscall/irq code with
> > > > events already enabled and counting
> > > 
> > > Sorry for being unclear: I was talking about the task-clock and cpu-clock
> > > values which you omitted from your measurements below. My example also
> > > shows that the counts for cycles and instructions are fine. But the
> > > cpu-clock and task-clock are useless as they always sum up to essentially
> > > `$nproc*$runtime`. What I'm hoping for are fractional values for the "N
> > > CPUs utilized".
> > ugh my bad.. anyway by using -a you create cpu counters
> > which never unschedule, so those times will be same
> > as the 'sleep 1' run length
> > 
> > but not sure now how to get the real utilization.. will check
> 
> Hey jirka,
> 
> did you have a chance to check the above? I'd be really interested in knowing 
> whether there is an existing workaround. If not, would it be feasible to patch 
> perf to get the desired behavior? I'd be willing to look into this. This would 
> probably require changes on the kernel side though, or how could this be 
> fixed?

hi,
I haven't found any good way yet.. I ended up with following
patch to allow attach counters to idle process, which got
me the count/behaviour you need (with few tools changes in
my perf/idle branch)

but I'm not sure it's the best idea ;-) there might
be better way.. CC-ing Ingo, Peter and Alexander

thanks
jirka


---
 include/uapi/linux/perf_event.h |  1 +
 kernel/events/core.c            | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 362493a2f950..9e48598d1f1d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -947,6 +947,7 @@ enum perf_callchain_context {
 #define PERF_FLAG_FD_OUTPUT		(1UL << 1)
 #define PERF_FLAG_PID_CGROUP		(1UL << 2) /* pid=cgroup id, per-cpu mode only */
 #define PERF_FLAG_FD_CLOEXEC		(1UL << 3) /* O_CLOEXEC */
+#define PERF_FLAG_PID_IDLE		(1UL << 4) /* attach to idle process */
 
 #if defined(__LITTLE_ENDIAN_BITFIELD)
 union perf_mem_data_src {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 799bb352d99f..529b07aecea7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -346,7 +346,8 @@ static void event_function_local(struct perf_event *event, event_f func, void *d
 #define PERF_FLAG_ALL (PERF_FLAG_FD_NO_GROUP |\
 		       PERF_FLAG_FD_OUTPUT  |\
 		       PERF_FLAG_PID_CGROUP |\
-		       PERF_FLAG_FD_CLOEXEC)
+		       PERF_FLAG_FD_CLOEXEC |\
+		       PERF_FLAG_PID_IDLE)
 
 /*
  * branch priv levels that need permission checks
@@ -9898,6 +9899,9 @@ SYSCALL_DEFINE5(perf_event_open,
 	if ((flags & PERF_FLAG_PID_CGROUP) && (pid == -1 || cpu == -1))
 		return -EINVAL;
 
+	if ((flags & PERF_FLAG_PID_IDLE) && (pid == -1 || cpu == -1))
+		return -EINVAL;
+
 	if (flags & PERF_FLAG_FD_CLOEXEC)
 		f_flags |= O_CLOEXEC;
 
@@ -9917,7 +9921,13 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	if (pid != -1 && !(flags & PERF_FLAG_PID_CGROUP)) {
-		task = find_lively_task_by_vpid(pid);
+		if (flags & PERF_FLAG_PID_IDLE) {
+			task = idle_task(cpu);
+			get_task_struct(task);
+		} else {
+			task = find_lively_task_by_vpid(pid);
+		}
+
 		if (IS_ERR(task)) {
 			err = PTR_ERR(task);
 			goto err_group_fd;
-- 
2.13.6
