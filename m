From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/17] perf top: Add --switch-on/--switch-off events
Date: Fri, 16 Aug 2019 17:16:49 -0300
Message-ID: <20190816201653.19332-14-acme@kernel.org>
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

Just like 'perf trace' and 'perf script', should be useful for instance
to only consider samples after the initialization phase of some
workload.

The man page has some examples and considerations about its current
interface, that still doesn't handle the on/off events in a special way,
behaving just like when multiple events are specified, i.e.:

- In non-group mode (when the event list is not enclosed in {}) show a
  a menu to allow choosing which event the user wants to see in the
  histograms browser

- In group mode, be it using {} or asking for --group, show one column
  per event.

Try for instance:

  # perf top -e '{cycles,instructions,probe:icmp_rcv}' --switch-on=probe:icmp_rcv

Replace probe:icmp_rcv, that I put in place using:

  # perf probe icmp_rcv:59

To hit when broadcast packets arrive, with a probe installed after an
initialization phase is over or after some other point of interest, some
garbage collection, etc, and also use --switch-off, for instance, on a
probe installed after said garbage collection is over.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-c7q7qjeqtyvc9mkeipxza6ne@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 38 +++++++++++++++++++++++++++
 tools/perf/builtin-top.c              | 10 ++++++-
 tools/perf/util/top.h                 |  2 ++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index cfea87c6f38e..5596129a71cf 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -266,6 +266,44 @@ Default is to monitor all CPUS.
 	Record events of type PERF_RECORD_NAMESPACES and display it with the
 	'cgroup_id' sort key.
 
+--switch-on EVENT_NAME::
+	Only consider events after this event is found.
+
+	E.g.:
+
+           Find out where broadcast packets are handled
+
+		perf probe -L icmp_rcv
+
+	   Insert a probe there:
+
+		perf probe icmp_rcv:59
+
+	   Start perf top and ask it to only consider the cycles events when a
+           broadcast packet arrives This will show a menu with two entries and
+           will start counting when a broadcast packet arrives:
+
+		perf top -e cycles,probe:icmp_rcv --switch-on=probe:icmp_rcv
+
+	   Alternatively one can ask for --group and then two overhead columns
+           will appear, the first for cycles and the second for the switch-on event.
+
+		perf top --group -e cycles,probe:icmp_rcv --switch-on=probe:icmp_rcv
+
+	This may be interesting to measure a workload only after some initialization
+	phase is over, i.e. insert a perf probe at that point and use the above
+	examples replacing probe:icmp_rcv with the just-after-init probe.
+
+--switch-off EVENT_NAME::
+	Stop considering events after this event is found.
+
+--show-on-off-events::
+	Show the --switch-on/off events too. This has no effect in 'perf top' now
+	but probably we'll make the default not to show the switch-on/off events
+        on the --group mode and if there is only one event besides the off/on ones,
+	go straight to the histogram browser, just like 'perf top' with no events
+	explicitely specified does.
+
 
 INTERACTIVE PROMPTING KEYS
 --------------------------
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 78e7efc597a6..5970723cd55a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1148,8 +1148,11 @@ static int deliver_event(struct ordered_events *qe,
 	evsel = perf_evlist__id2evsel(session->evlist, sample.id);
 	assert(evsel != NULL);
 
-	if (event->header.type == PERF_RECORD_SAMPLE)
+	if (event->header.type == PERF_RECORD_SAMPLE) {
+		if (evswitch__discard(&top->evswitch, evsel))
+			return 0;
 		++top->samples;
+	}
 
 	switch (sample.cpumode) {
 	case PERF_RECORD_MISC_USER:
@@ -1534,6 +1537,7 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
 		    "Record namespaces events"),
+	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
 	struct evlist *sb_evlist = NULL;
@@ -1567,6 +1571,10 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
+	status = evswitch__init(&top.evswitch, top.evlist, stderr);
+	if (status)
+		goto out_delete_evlist;
+
 	if (symbol_conf.report_hierarchy) {
 		/* disable incompatible options */
 		symbol_conf.event_group = false;
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 2023e0bf6165..dc4bb6e52a83 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -3,6 +3,7 @@
 #define __PERF_TOP_H 1
 
 #include "tool.h"
+#include "evswitch.h"
 #include "annotate.h"
 #include <linux/types.h>
 #include <stddef.h>
@@ -18,6 +19,7 @@ struct perf_top {
 	struct evlist *evlist;
 	struct record_opts record_opts;
 	struct annotation_options annotation_opts;
+	struct evswitch	   evswitch;
 	/*
 	 * Symbols will be added here in perf_event__process_sample and will
 	 * get out after decayed.
-- 
2.21.0
