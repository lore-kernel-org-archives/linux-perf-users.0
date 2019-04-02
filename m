From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/44] tools lib traceevent: Add mono clocks to be parsed in seconds
Date: Tue,  2 Apr 2019 13:05:17 -0300
Message-ID: <20190402160549.13544-13-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The mono clocks can display in seconds instead of whole numbers:

       trace-cmd-521   [001] 99176715281005: sched_waking:         comm=kworker/u16:2 pid=32118 prio=120 target_cpu=002
       trace-cmd-521   [001] 99176715286349: sched_wake_idle_without_ipi: cpu=2
       trace-cmd-521   [001] 99176715288047: sched_wakeup:         kworker/u16:2:32118 [120] success=1 CPU:002
       trace-cmd-521   [001] 99176715290022: sched_waking:         comm=trace-cmd pid=523 prio=120 target_cpu=000
       trace-cmd-521   [001] 99176715292332: sched_wake_idle_without_ipi: cpu=0
       trace-cmd-521   [001] 99176715292855: sched_wakeup:         trace-cmd:523 [120] success=1 CPU:000
       trace-cmd-521   [001] 99176715300697: sched_stat_runtime:   comm=trace-cmd pid=521 runtime=80233 [ns] vruntime=66705540554 [ns

Break it up in seconds:

       trace-cmd-521   [001] 99176.715281: sched_waking:         comm=kworker/u16:2 pid=32118 prio=120 target_cpu=002
       trace-cmd-521   [001] 99176.715286: sched_wake_idle_without_ipi: cpu=2
       trace-cmd-521   [001] 99176.715288: sched_wakeup:         kworker/u16:2:32118 [120] success=1 CPU:002
       trace-cmd-521   [001] 99176.715290: sched_waking:         comm=trace-cmd pid=523 prio=120 target_cpu=000
       trace-cmd-521   [001] 99176.715292: sched_wake_idle_without_ipi: cpu=0
       trace-cmd-521   [001] 99176.715293: sched_wakeup:         trace-cmd:523 [120] success=1 CPU:000
       trace-cmd-521   [001] 99176.715301: sched_stat_runtime:   comm=trace-cmd pid=521 runtime=80233 [ns] vruntime=66705540554 [ns]

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lkml.kernel.org/r/20190401164342.976554023@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 2ebb257ce7ba..666e23ded6ed 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5445,7 +5445,8 @@ static bool is_timestamp_in_us(char *trace_clock, bool use_trace_clock)
 		return true;
 
 	if (!strcmp(trace_clock, "local") || !strcmp(trace_clock, "global")
-	    || !strcmp(trace_clock, "uptime") || !strcmp(trace_clock, "perf"))
+	    || !strcmp(trace_clock, "uptime") || !strcmp(trace_clock, "perf")
+	    || !strncmp(trace_clock, "mono", 4))
 		return true;
 
 	/* trace_clock is setting in tsc or counter mode */
-- 
2.20.1
