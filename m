From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH] perf/core: Fix hung issue on perf stat command during cpu hotplug
Date: Thu, 27 Aug 2020 12:17:32 +0530
Message-ID: <20200827064732.20860-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, peterz@infradead.org
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, namhyung@kernel.org, daniel@iogearbox.net, brho@google.com, srikar@linux.vnet.ibm.com, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Commit 2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
added assignment of ret value as -EAGAIN in case function
call to 'smp_call_function_single' fails.
For non-zero ret value, it did
'ret = !ret ? data.ret : -EAGAIN;', which always
assign -EAGAIN to ret and make second if condition useless.

In scenarios like when executing a perf stat with --per-thread option, and
if any of the monitoring cpu goes offline, the 'smp_call_function_single'
function could return -ENXIO, and with the above check,
task_function_call hung and increases CPU
usage (because of repeated 'smp_call_function_single()')

Recration scenario:
	# perf stat -a --per-thread && (offline a CPU )

Patch here removes the tertiary condition added as part of that
commit and added a check for NULL and -EAGAIN.

Fixes: 2ed6edd33a21("perf: Add cond_resched() to task_function_call()")
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reviewed-by: Barret Rhoden <brho@google.com>
Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/events/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Changelog:
- Remove RFC tag
- Resolve some nits issues like space after if and
  added -ENXIO in comment msg of function 'task_function_call'
  as suggested by Barret Rhoden.

Link to the RFC: https://lkml.org/lkml/2020/8/26/896

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5bfe8e3c6e44..cef646084198 100644
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
@@ -115,7 +115,8 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 	for (;;) {
 		ret = smp_call_function_single(task_cpu(p), remote_function,
 					       &data, 1);
-		ret = !ret ? data.ret : -EAGAIN;
+		if (!ret)
+			ret = data.ret;
 
 		if (ret != -EAGAIN)
 			break;
-- 
2.26.2
