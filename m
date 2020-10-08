From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf/core: Fix hung issue on perf stat command during
 cpu hotplug
Date: Thu, 8 Oct 2020 15:15:20 +0200
Message-ID: <20201008131520.GY2628@hirez.programming.kicks-ass.net>
References: <20200827064732.20860-1-kjain@linux.ibm.com>
 <931cf8fd-79e9-3cbd-0943-63abea31ee8d@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <931cf8fd-79e9-3cbd-0943-63abea31ee8d@linux.ibm.com>
To: kajoljain <kjain@linux.ibm.com>
Cc: acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, namhyung@kernel.org, daniel@iogearbox.net, brho@google.com, srikar@linux.vnet.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, Oct 08, 2020 at 05:55:35PM +0530, kajoljain wrote:
> 
> 
> On 8/27/20 12:17 PM, Kajol Jain wrote:
> > Commit 2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
> > added assignment of ret value as -EAGAIN in case function
> > call to 'smp_call_function_single' fails.
> > For non-zero ret value, it did
> > 'ret = !ret ? data.ret : -EAGAIN;', which always
> > assign -EAGAIN to ret and make second if condition useless.
> > 
> > In scenarios like when executing a perf stat with --per-thread option, and
> > if any of the monitoring cpu goes offline, the 'smp_call_function_single'
> > function could return -ENXIO, and with the above check,
> > task_function_call hung and increases CPU
> > usage (because of repeated 'smp_call_function_single()')
> > 
> > Recration scenario:
> > 	# perf stat -a --per-thread && (offline a CPU )
> > 
> > Patch here removes the tertiary condition added as part of that
> > commit and added a check for NULL and -EAGAIN.
> 
> Hi Peter,
>      Please let me know if you have any comment on this patch.

Yes, sorry. I've got it now. Thanks!

---
Subject: perf: Fix task_function_call() error handling
From: Kajol Jain <kjain@linux.ibm.com>
Date: Thu, 27 Aug 2020 12:17:32 +0530

From: Kajol Jain <kjain@linux.ibm.com>

The error handling introduced by commit:

  2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")

looses any return value from smp_call_function_single() that is not
{0, -EINVAL}. This is a problem because it will return -EXNIO when the
target CPU is offline. Worse, in that case it'll turn into an infinite
loop.

Fixes: 2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Barret Rhoden <brho@google.com>
Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/r/20200827064732.20860-1-kjain@linux.ibm.com
---
 kernel/events/core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -99,7 +99,7 @@ static void remote_function(void *data)
  * retry due to any failures in smp_call_function_single(), such as if the
  * task_cpu() goes offline concurrently.
  *
- * returns @func return value or -ESRCH when the process isn't running
+ * returns @func return value or -ESRCH or -ENXIO when the process isn't running
  */
 static int
 task_function_call(struct task_struct *p, remote_function_f func, void *info)
@@ -115,7 +115,8 @@ task_function_call(struct task_struct *p
 	for (;;) {
 		ret = smp_call_function_single(task_cpu(p), remote_function,
 					       &data, 1);
-		ret = !ret ? data.ret : -EAGAIN;
+		if (!ret)
+			ret = data.ret;
 
 		if (ret != -EAGAIN)
 			break;
