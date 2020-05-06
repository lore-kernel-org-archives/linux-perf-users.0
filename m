From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/91] perf evlist: Move the sideband thread routines to separate object
Date: Wed,  6 May 2020 12:21:30 -0300
Message-ID: <20200506152234.21977-28-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To avoid dragging more stuff into the perf python binding in the
following csets.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build             |   1 +
 tools/perf/util/evlist.c          | 117 ----------------------------
 tools/perf/util/sideband_evlist.c | 125 ++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+), 117 deletions(-)
 create mode 100644 tools/perf/util/sideband_evlist.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 229abefed59a..ca07a162d602 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -10,6 +10,7 @@ perf-y += db-export.o
 perf-y += env.o
 perf-y += event.o
 perf-y += evlist.o
+perf-y += sideband_evlist.o
 perf-y += evsel.o
 perf-y += evsel_fprintf.o
 perf-y += perf_event_attr_fprintf.o
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6fe11f4d856a..6d902c02fd95 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1704,120 +1704,3 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 	}
 	return leader;
 }
-
-int perf_evlist__add_sb_event(struct evlist *evlist,
-			      struct perf_event_attr *attr,
-			      perf_evsel__sb_cb_t cb,
-			      void *data)
-{
-	struct evsel *evsel;
-
-	if (!attr->sample_id_all) {
-		pr_warning("enabling sample_id_all for all side band events\n");
-		attr->sample_id_all = 1;
-	}
-
-	evsel = perf_evsel__new_idx(attr, evlist->core.nr_entries);
-	if (!evsel)
-		return -1;
-
-	evsel->side_band.cb = cb;
-	evsel->side_band.data = data;
-	evlist__add(evlist, evsel);
-	return 0;
-}
-
-static void *perf_evlist__poll_thread(void *arg)
-{
-	struct evlist *evlist = arg;
-	bool draining = false;
-	int i, done = 0;
-	/*
-	 * In order to read symbols from other namespaces perf to needs to call
-	 * setns(2).  This isn't permitted if the struct_fs has multiple users.
-	 * unshare(2) the fs so that we may continue to setns into namespaces
-	 * that we're observing when, for instance, reading the build-ids at
-	 * the end of a 'perf record' session.
-	 */
-	unshare(CLONE_FS);
-
-	while (!done) {
-		bool got_data = false;
-
-		if (evlist->thread.done)
-			draining = true;
-
-		if (!draining)
-			evlist__poll(evlist, 1000);
-
-		for (i = 0; i < evlist->core.nr_mmaps; i++) {
-			struct mmap *map = &evlist->mmap[i];
-			union perf_event *event;
-
-			if (perf_mmap__read_init(&map->core))
-				continue;
-			while ((event = perf_mmap__read_event(&map->core)) != NULL) {
-				struct evsel *evsel = perf_evlist__event2evsel(evlist, event);
-
-				if (evsel && evsel->side_band.cb)
-					evsel->side_band.cb(event, evsel->side_band.data);
-				else
-					pr_warning("cannot locate proper evsel for the side band event\n");
-
-				perf_mmap__consume(&map->core);
-				got_data = true;
-			}
-			perf_mmap__read_done(&map->core);
-		}
-
-		if (draining && !got_data)
-			break;
-	}
-	return NULL;
-}
-
-int perf_evlist__start_sb_thread(struct evlist *evlist,
-				 struct target *target)
-{
-	struct evsel *counter;
-
-	if (!evlist)
-		return 0;
-
-	if (perf_evlist__create_maps(evlist, target))
-		goto out_delete_evlist;
-
-	evlist__for_each_entry(evlist, counter) {
-		if (evsel__open(counter, evlist->core.cpus,
-				     evlist->core.threads) < 0)
-			goto out_delete_evlist;
-	}
-
-	if (evlist__mmap(evlist, UINT_MAX))
-		goto out_delete_evlist;
-
-	evlist__for_each_entry(evlist, counter) {
-		if (evsel__enable(counter))
-			goto out_delete_evlist;
-	}
-
-	evlist->thread.done = 0;
-	if (pthread_create(&evlist->thread.th, NULL, perf_evlist__poll_thread, evlist))
-		goto out_delete_evlist;
-
-	return 0;
-
-out_delete_evlist:
-	evlist__delete(evlist);
-	evlist = NULL;
-	return -1;
-}
-
-void perf_evlist__stop_sb_thread(struct evlist *evlist)
-{
-	if (!evlist)
-		return;
-	evlist->thread.done = 1;
-	pthread_join(evlist->thread.th, NULL);
-	evlist__delete(evlist);
-}
diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/sideband_evlist.c
new file mode 100644
index 000000000000..073d201bb6ea
--- /dev/null
+++ b/tools/perf/util/sideband_evlist.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "util/debug.h"
+#include "util/evlist.h"
+#include "util/evsel.h"
+#include "util/mmap.h"
+#include <perf/mmap.h>
+#include <linux/perf_event.h>
+#include <limits.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdbool.h>
+
+int perf_evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
+			      perf_evsel__sb_cb_t cb, void *data)
+{
+	struct evsel *evsel;
+
+	if (!attr->sample_id_all) {
+		pr_warning("enabling sample_id_all for all side band events\n");
+		attr->sample_id_all = 1;
+	}
+
+	evsel = perf_evsel__new_idx(attr, evlist->core.nr_entries);
+	if (!evsel)
+		return -1;
+
+	evsel->side_band.cb = cb;
+	evsel->side_band.data = data;
+	evlist__add(evlist, evsel);
+	return 0;
+}
+
+static void *perf_evlist__poll_thread(void *arg)
+{
+	struct evlist *evlist = arg;
+	bool draining = false;
+	int i, done = 0;
+	/*
+	 * In order to read symbols from other namespaces perf to needs to call
+	 * setns(2).  This isn't permitted if the struct_fs has multiple users.
+	 * unshare(2) the fs so that we may continue to setns into namespaces
+	 * that we're observing when, for instance, reading the build-ids at
+	 * the end of a 'perf record' session.
+	 */
+	unshare(CLONE_FS);
+
+	while (!done) {
+		bool got_data = false;
+
+		if (evlist->thread.done)
+			draining = true;
+
+		if (!draining)
+			evlist__poll(evlist, 1000);
+
+		for (i = 0; i < evlist->core.nr_mmaps; i++) {
+			struct mmap *map = &evlist->mmap[i];
+			union perf_event *event;
+
+			if (perf_mmap__read_init(&map->core))
+				continue;
+			while ((event = perf_mmap__read_event(&map->core)) != NULL) {
+				struct evsel *evsel = perf_evlist__event2evsel(evlist, event);
+
+				if (evsel && evsel->side_band.cb)
+					evsel->side_band.cb(event, evsel->side_band.data);
+				else
+					pr_warning("cannot locate proper evsel for the side band event\n");
+
+				perf_mmap__consume(&map->core);
+				got_data = true;
+			}
+			perf_mmap__read_done(&map->core);
+		}
+
+		if (draining && !got_data)
+			break;
+	}
+	return NULL;
+}
+
+int perf_evlist__start_sb_thread(struct evlist *evlist, struct target *target)
+{
+	struct evsel *counter;
+
+	if (!evlist)
+		return 0;
+
+	if (perf_evlist__create_maps(evlist, target))
+		goto out_delete_evlist;
+
+	evlist__for_each_entry(evlist, counter) {
+		if (evsel__open(counter, evlist->core.cpus, evlist->core.threads) < 0)
+			goto out_delete_evlist;
+	}
+
+	if (evlist__mmap(evlist, UINT_MAX))
+		goto out_delete_evlist;
+
+	evlist__for_each_entry(evlist, counter) {
+		if (evsel__enable(counter))
+			goto out_delete_evlist;
+	}
+
+	evlist->thread.done = 0;
+	if (pthread_create(&evlist->thread.th, NULL, perf_evlist__poll_thread, evlist))
+		goto out_delete_evlist;
+
+	return 0;
+
+out_delete_evlist:
+	evlist__delete(evlist);
+	evlist = NULL;
+	return -1;
+}
+
+void perf_evlist__stop_sb_thread(struct evlist *evlist)
+{
+	if (!evlist)
+		return;
+	evlist->thread.done = 1;
+	pthread_join(evlist->thread.th, NULL);
+	evlist__delete(evlist);
+}
-- 
2.21.1
