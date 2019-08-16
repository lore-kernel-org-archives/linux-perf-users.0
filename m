From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/17] perf evswitch: Move switch logic to use in other tools
Date: Fri, 16 Aug 2019 17:16:42 -0300
Message-ID: <20190816201653.19332-7-acme@kernel.org>
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

Now other tools that want switching can use an evswitch for that, just
set it up and add it to the PERF_RECORD_SAMPLE processing function.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-b1trj1q97qwfv251l66q3noj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 23 ++---------------------
 tools/perf/util/Build       |  1 +
 tools/perf/util/evswitch.c  | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/evswitch.h  |  2 ++
 4 files changed, 36 insertions(+), 21 deletions(-)
 create mode 100644 tools/perf/util/evswitch.c

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fff02e0d70c4..e7b950e977a9 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1807,28 +1807,9 @@ static void process_event(struct perf_script *script,
 	if (!show_event(sample, evsel, thread, al))
 		return;
 
-	if (script->evswitch.on && script->evswitch.discarding) {
-		if (script->evswitch.on != evsel)
-			return;
-
-		script->evswitch.discarding = false;
-
-		if (!script->evswitch.show_on_off_events)
-			return;
-
-		goto print_it;
-	}
-
-	if (script->evswitch.off && !script->evswitch.discarding) {
-		if (script->evswitch.off != evsel)
-			goto print_it;
-
-		script->evswitch.discarding = true;
+	if (evswitch__discard(&script->evswitch, evsel))
+		return;
 
-		if (!script->evswitch.show_on_off_events)
-			return;
-	}
-print_it:
 	++es->samples;
 
 	perf_sample__fprintf_start(sample, thread, evsel,
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 7cda749059a9..b922c8c297ca 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -9,6 +9,7 @@ perf-y += event.o
 perf-y += evlist.o
 perf-y += evsel.o
 perf-y += evsel_fprintf.o
+perf-y += evswitch.o
 perf-y += find_bit.o
 perf-y += get_current_dir_name.o
 perf-y += kallsyms.o
diff --git a/tools/perf/util/evswitch.c b/tools/perf/util/evswitch.c
new file mode 100644
index 000000000000..c87f988d81c8
--- /dev/null
+++ b/tools/perf/util/evswitch.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+
+#include "evswitch.h"
+
+bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel)
+{
+	if (evswitch->on && evswitch->discarding) {
+		if (evswitch->on != evsel)
+			return true;
+
+		evswitch->discarding = false;
+
+		if (!evswitch->show_on_off_events)
+			return true;
+
+		return false;
+	}
+
+	if (evswitch->off && !evswitch->discarding) {
+		if (evswitch->off != evsel)
+			return false;
+
+		evswitch->discarding = true;
+
+		if (!evswitch->show_on_off_events)
+			return true;
+	}
+
+	return false;
+}
diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
index bb88e8002f39..bae3a22ad719 100644
--- a/tools/perf/util/evswitch.h
+++ b/tools/perf/util/evswitch.h
@@ -13,4 +13,6 @@ struct evswitch {
 	bool	     show_on_off_events;
 };
 
+bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel);
+
 #endif /* __PERF_EVSWITCH_H */
-- 
2.21.0
