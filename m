From: Kajol Jain <kjain@linux.ibm.com>
Subject: [RFC v2] perf/core: Fixes hung issue on perf stat command during cpu hotplug
Date: Wed, 26 Aug 2020 20:24:11 +0530
Message-ID: <20200826145411.489169-1-kjain@linux.ibm.com>
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
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Changelog:
- Remove addition of else in the first patch for
  if(ret != -EAGAIN) condition.

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 856d98c36f56..fe104fee097a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -115,8 +115,8 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 	for (;;) {
 		ret = smp_call_function_single(task_cpu(p), remote_function,
 					       &data, 1);
-		ret = !ret ? data.ret : -EAGAIN;
-
+		if(!ret)
+			ret = data.ret;
 		if (ret != -EAGAIN)
 			break;
 
-- 
2.26.2
