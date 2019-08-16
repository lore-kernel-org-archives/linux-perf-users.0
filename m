From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/17] perf script: Allow showing the --switch-on event
Date: Fri, 16 Aug 2019 17:16:39 -0300
Message-ID: <20190816201653.19332-4-acme@kernel.org>
References: <20190816201653.19332-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816201653.19332-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, William Cohen <wcohen@redhat.com>, Florian Weimer <fweimer@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One may want to see the --switch-on event as well, allow for that, using
the previous cset example:

  # perf script --switch-on syscalls:sys_enter_nanosleep --show-on-off
        sleep 13638 [001] 108237.582286: syscalls:sys_enter_nanosleep: rqtp: 0x7fff1948ac40, rmtp: 0x00000000
        sleep 13638 [001] 108237.582289:     sched:sched_stat_runtime: comm=sleep pid=13638 runtime=578104 [ns] vruntime=202889459556 [ns]
        sleep 13638 [001] 108237.582291:           sched:sched_switch: sleep:13638 [120] S ==> swapper/1:0 [120]
      swapper     0 [001] 108238.582428:           sched:sched_waking: comm=sleep pid=13638 prio=120 target_cpu=001
      swapper     0 [001] 108238.582458:           sched:sched_wakeup: sleep:13638 [120] success=1 CPU:001
        sleep 13638 [001] 108238.582698:     sched:sched_stat_runtime: comm=sleep pid=13638 runtime=173915 [ns] vruntime=202889633471 [ns]
        sleep 13638 [001] 108238.582782:     sched:sched_process_exit: comm=sleep pid=13638 prio=120
  #
  # perf script --switch-on syscalls:sys_enter_nanosleep
        sleep 13638 [001] 108237.582289:     sched:sched_stat_runtime: comm=sleep pid=13638 runtime=578104 [ns] vruntime=202889459556 [ns]
        sleep 13638 [001] 108237.582291:           sched:sched_switch: sleep:13638 [120] S ==> swapper/1:0 [120]
      swapper     0 [001] 108238.582428:           sched:sched_waking: comm=sleep pid=13638 prio=120 target_cpu=001
      swapper     0 [001] 108238.582458:           sched:sched_wakeup: sleep:13638 [120] success=1 CPU:001
        sleep 13638 [001] 108238.582698:     sched:sched_stat_runtime: comm=sleep pid=13638 runtime=173915 [ns] vruntime=202889633471 [ns]
        sleep 13638 [001] 108238.582782:     sched:sched_process_exit: comm=sleep pid=13638 prio=120
  #

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Cc: Florian Weimer <fweimer@redhat.com>
Link: https://lkml.kernel.org/n/tip-0omwwoywj1v63gu8cz0tr0cy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 3 +++
 tools/perf/builtin-script.c              | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 9936819aae1c..24eea68ee829 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -420,6 +420,9 @@ include::itrace.txt[]
 --switch-on EVENT_NAME::
 	Only consider events after this event is found.
 
+--show-on-off-events::
+	Show the --switch-on event too.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d0bc7ccaf7bf..fa0cc8b0eccc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1619,6 +1619,7 @@ static int perf_sample__fprintf_synth(struct perf_sample *sample,
 struct evswitch {
 	struct evsel *on;
 	bool	     discarding;
+	bool	     show_on_off_events;
 };
 
 struct perf_script {
@@ -1816,6 +1817,9 @@ static void process_event(struct perf_script *script,
 			return;
 
 		script->evswitch.discarding = false;
+
+		if (!script->evswitch.show_on_off_events)
+			return;
 	}
 
 	++es->samples;
@@ -3554,6 +3558,8 @@ int cmd_script(int argc, const char **argv)
 		   "file", "file saving guest os /proc/modules"),
 	OPT_STRING(0, "switch-on", &event_switch_on,
 		   "event", "Consider events from the first ocurrence of this event"),
+	OPT_BOOLEAN(0, "show-on-off-events", &script.evswitch.show_on_off_events,
+		    "Show the on/off switch events, used with --switch-on"),
 	OPT_END()
 	};
 	const char * const script_subcommands[] = { "record", "report", NULL };
-- 
2.21.0
