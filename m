From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/17] perf evswitch: Introduce init() method to set the on/off evsels from the command line
Date: Fri, 16 Aug 2019 17:16:45 -0300
Message-ID: <20190816201653.19332-10-acme@kernel.org>
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

Another step in having all the boilerplate in just one place to then use
in the other tools.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-snreb1wmwyjei3eefwotxp1l@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 21 +++------------------
 tools/perf/util/evswitch.c  | 23 +++++++++++++++++++++++
 tools/perf/util/evswitch.h  |  4 ++++
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2a5b8af80e6b..1764efd16cd4 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3868,24 +3868,9 @@ int cmd_script(int argc, const char **argv)
 						  script.range_num);
 	}
 
-	if (script.evswitch.on_name) {
-		script.evswitch.on = perf_evlist__find_evsel_by_str(session->evlist, script.evswitch.on_name);
-		if (script.evswitch.on == NULL) {
-			fprintf(stderr, "switch-on event not found (%s)\n", script.evswitch.on_name);
-			err = -ENOENT;
-			goto out_delete;
-		}
-		script.evswitch.discarding = true;
-	}
-
-	if (script.evswitch.off_name) {
-		script.evswitch.off = perf_evlist__find_evsel_by_str(session->evlist, script.evswitch.off_name);
-		if (script.evswitch.off == NULL) {
-			fprintf(stderr, "switch-off event not found (%s)\n", script.evswitch.off_name);
-			err = -ENOENT;
-			goto out_delete;
-		}
-	}
+	err = evswitch__init(&script.evswitch, session->evlist, stderr);
+	if (err)
+		goto out_delete;
 
 	err = __cmd_script(&script);
 
diff --git a/tools/perf/util/evswitch.c b/tools/perf/util/evswitch.c
index c87f988d81c8..b57b5f0816f5 100644
--- a/tools/perf/util/evswitch.c
+++ b/tools/perf/util/evswitch.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 
 #include "evswitch.h"
+#include "evlist.h"
 
 bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel)
 {
@@ -29,3 +30,25 @@ bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel)
 
 	return false;
 }
+
+int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp)
+{
+	if (evswitch->on_name) {
+		evswitch->on = perf_evlist__find_evsel_by_str(evlist, evswitch->on_name);
+		if (evswitch->on == NULL) {
+			fprintf(fp, "switch-on event not found (%s)\n", evswitch->on_name);
+			return -ENOENT;
+		}
+		evswitch->discarding = true;
+	}
+
+	if (evswitch->off_name) {
+		evswitch->off = perf_evlist__find_evsel_by_str(evlist, evswitch->off_name);
+		if (evswitch->off == NULL) {
+			fprintf(fp, "switch-off event not found (%s)\n", evswitch->off_name);
+			return -ENOENT;
+		}
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
index 94220d1bb479..fd30460b6218 100644
--- a/tools/perf/util/evswitch.h
+++ b/tools/perf/util/evswitch.h
@@ -4,8 +4,10 @@
 #define __PERF_EVSWITCH_H 1
 
 #include <stdbool.h>
+#include <stdio.h>
 
 struct evsel;
+struct evlist;
 
 struct evswitch {
 	struct evsel *on, *off;
@@ -14,6 +16,8 @@ struct evswitch {
 	bool	     show_on_off_events;
 };
 
+int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp);
+
 bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel);
 
 #define OPTS_EVSWITCH(evswitch)								  \
-- 
2.21.0
