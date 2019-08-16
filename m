From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/17] perf evswitch: Add hint when not finding specified on/off events
Date: Fri, 16 Aug 2019 17:16:47 -0300
Message-ID: <20190816201653.19332-12-acme@kernel.org>
References: <20190816201653.19332-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816201653.19332-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Florian Weimer <fweimer@redhat.com>, William Cohen <wcohen@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If the user specifies a on or off switch event and it isn't in the
perf.data file, provide a hint about how to see the events in the
perf.data evlist:

  # perf script --switch-on=syscall:sys_enter_nanosleep --switch-off=syscalls:sys_exit_nanosleep
  ERROR: event_on event not found (syscall:sys_enter_nanosleep)
  HINT:  use 'perf evlist' to see the available event names
  #
  # perf evlist
  sched:sched_kthread_stop
  sched:sched_kthread_stop_ret
  sched:sched_waking
  sched:sched_wakeup
  sched:sched_wakeup_new
  sched:sched_switch
  sched:sched_migrate_task
  sched:sched_process_free
  sched:sched_process_exit
  sched:sched_wait_task
  sched:sched_process_wait
  sched:sched_process_fork
  sched:sched_process_exec
  sched:sched_stat_wait
  sched:sched_stat_sleep
  sched:sched_stat_iowait
  sched:sched_stat_blocked
  sched:sched_stat_runtime
  sched:sched_pi_setprio
  sched:sched_move_numa
  sched:sched_stick_numa
  sched:sched_swap_numa
  sched:sched_wake_idle_without_ipi
  syscalls:sys_enter_clock_nanosleep
  syscalls:sys_exit_clock_nanosleep
  syscalls:sys_enter_nanosleep
  syscalls:sys_exit_nanosleep
  # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
  #
  # perf script --switch-on=syscalls:sys_enter_nanosleep --switch-off=syscalls:sys_exit_nanosleep
       sleep 20919 [001] 109866.144411:  sched:sched_stat_runtime: comm=sleep pid=20919 runtime=521249 [ns] vruntime=202919398131 [ns]
       sleep 20919 [001] 109866.144412:        sched:sched_switch: sleep:20919 [120] S ==> swapper/1:0 [120]
     swapper     0 [001] 109867.144568:        sched:sched_waking: comm=sleep pid=20919 prio=120 target_cpu=001
     swapper     0 [001] 109867.144586:        sched:sched_wakeup: sleep:20919 [120] success=1 CPU:001
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-iijjvdlyad973oskdq8gmi5w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evswitch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evswitch.c b/tools/perf/util/evswitch.c
index 71daed615a2c..3ba72f743d3c 100644
--- a/tools/perf/util/evswitch.c
+++ b/tools/perf/util/evswitch.c
@@ -33,7 +33,9 @@ bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel)
 
 static int evswitch__fprintf_enoent(FILE *fp, const char *evtype, const char *evname)
 {
-	return fprintf(fp, "ERROR: switch-%s event not found (%s)\n", evtype, evname);
+	int printed = fprintf(fp, "ERROR: switch-%s event not found (%s)\n", evtype, evname);
+
+	return printed += fprintf(fp, "HINT:  use 'perf evlist' to see the available event names\n");
 }
 
 int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp)
-- 
2.21.0
