From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/7] perf core: Fix perf_proc_update_handler() bug
Date: Mon, 21 Jan 2019 15:35:03 -0300
Message-ID: <20190121183507.23490-4-acme@kernel.org>
References: <20190121183507.23490-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121183507.23490-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Stephane Eranian <eranian@google.com>

The perf_proc_update_handler() handles /proc/sys/kernel/perf_event_max_sample_rate
syctl variable.  When the PMU IRQ handler timing monitoring is disabled, i.e,
when /proc/sys/kernel/perf_cpu_time_max_percent is equal to 0 or 100,
then no modification to sysctl_perf_event_sample_rate is allowed to prevent
possible hang from wrong values.

The problem is that the test to prevent modification is made after the
sysctl variable is modified in perf_proc_update_handler().

You get an error:

  $ echo 10001 >/proc/sys/kernel/perf_event_max_sample_rate
  echo: write error: invalid argument

But the value is still modified causing all sorts of inconsistencies:

  $ cat /proc/sys/kernel/perf_event_max_sample_rate
  10001

This patch fixes the problem by moving the parsing of the value after
the test.

Committer testing:

  # echo 100 > /proc/sys/kernel/perf_cpu_time_max_percent
  # echo 10001 > /proc/sys/kernel/perf_event_max_sample_rate
  -bash: echo: write error: Invalid argument
  # cat /proc/sys/kernel/perf_event_max_sample_rate
  10001
  #

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1547169436-6266-1-git-send-email-eranian@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cd13a30f732..e5ede6918050 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -436,18 +436,18 @@ int perf_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos)
 {
-	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-
-	if (ret || !write)
-		return ret;
-
+	int ret;
+	int perf_cpu = sysctl_perf_cpu_time_max_percent;
 	/*
 	 * If throttling is disabled don't allow the write:
 	 */
-	if (sysctl_perf_cpu_time_max_percent == 100 ||
-	    sysctl_perf_cpu_time_max_percent == 0)
+	if (write && (perf_cpu == 100 || perf_cpu == 0))
 		return -EINVAL;
 
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret || !write)
+		return ret;
+
 	max_samples_per_tick = DIV_ROUND_UP(sysctl_perf_event_sample_rate, HZ);
 	perf_sample_period_ns = NSEC_PER_SEC / sysctl_perf_event_sample_rate;
 	update_perf_cpu_limits();
-- 
2.20.1
