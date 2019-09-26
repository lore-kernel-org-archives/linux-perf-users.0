From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 54/66] libperf: Add perf_evlist__poll() function
Date: Wed, 25 Sep 2019 21:32:32 -0300
Message-ID: <20190926003244.13962-55-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move perf_evlist__poll() from tools/perf to libperf, it will be used in
the following patches.

And rename the existing perf's function to evlist__poll().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-39-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c                 | 2 +-
 tools/perf/builtin-top.c                    | 4 ++--
 tools/perf/builtin-trace.c                  | 2 +-
 tools/perf/lib/evlist.c                     | 5 +++++
 tools/perf/lib/include/perf/evlist.h        | 1 +
 tools/perf/lib/libperf.map                  | 1 +
 tools/perf/tests/openat-syscall-tp-fields.c | 2 +-
 tools/perf/tests/perf-record.c              | 2 +-
 tools/perf/tests/task-exit.c                | 2 +-
 tools/perf/util/evlist.c                    | 6 +++---
 tools/perf/util/evlist.h                    | 2 +-
 tools/perf/util/python.c                    | 2 +-
 12 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d6daaad348b5..23332861de6e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1615,7 +1615,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (hits == rec->samples) {
 			if (done || draining)
 				break;
-			err = perf_evlist__poll(rec->evlist, -1);
+			err = evlist__poll(rec->evlist, -1);
 			/*
 			 * Propagate error, only if there's any. Ignore positive
 			 * number of returned events and interrupt error.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 73bf79053ae3..30d8eb614377 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1307,7 +1307,7 @@ static int __cmd_top(struct perf_top *top)
 	}
 
 	/* Wait for a minimal set of events before starting the snapshot */
-	perf_evlist__poll(top->evlist, 100);
+	evlist__poll(top->evlist, 100);
 
 	perf_top__mmap_read(top);
 
@@ -1317,7 +1317,7 @@ static int __cmd_top(struct perf_top *top)
 		perf_top__mmap_read(top);
 
 		if (opts->overwrite || (hits == top->samples))
-			ret = perf_evlist__poll(top->evlist, 100);
+			ret = evlist__poll(top->evlist, 100);
 
 		if (resize) {
 			perf_top__resize(top);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8d9784b5d028..c52c3120a811 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3474,7 +3474,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (trace->nr_events == before) {
 		int timeout = done ? 100 : -1;
 
-		if (!draining && perf_evlist__poll(evlist, timeout) > 0) {
+		if (!draining && evlist__poll(evlist, timeout) > 0) {
 			if (evlist__filter_pollfd(evlist, POLLERR | POLLHUP | POLLNVAL) == 0)
 				draining = true;
 
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index e4d8b3b7b8fc..d1496fee810c 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -276,3 +276,8 @@ int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
 
 	return pos;
 }
+
+int perf_evlist__poll(struct perf_evlist *evlist, int timeout)
+{
+	return fdarray__poll(&evlist->pollfd, timeout);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 38365f8f3fba..8a2ce0757ab2 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -31,5 +31,6 @@ LIBPERF_API void perf_evlist__disable(struct perf_evlist *evlist);
 LIBPERF_API void perf_evlist__set_maps(struct perf_evlist *evlist,
 				       struct perf_cpu_map *cpus,
 				       struct perf_thread_map *threads);
+LIBPERF_API int perf_evlist__poll(struct perf_evlist *evlist, int timeout);
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 5eb0150ccdc6..ab8dbde1136c 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -39,6 +39,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__remove;
 		perf_evlist__next;
 		perf_evlist__set_maps;
+		perf_evlist__poll;
 	local:
 		*;
 };
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 4629fa33c8ad..2b5c46813053 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -127,7 +127,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 		}
 
 		if (nr_events == before)
-			perf_evlist__poll(evlist, 10);
+			evlist__poll(evlist, 10);
 
 		if (++nr_polls > 5) {
 			pr_debug("%s: no events!\n", __func__);
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 401e8d11427b..437426be29e9 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -287,7 +287,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 		 * perf_event_attr.wakeup_events, just PERF_EVENT_SAMPLE does.
 		 */
 		if (total_events == before && false)
-			perf_evlist__poll(evlist, -1);
+			evlist__poll(evlist, -1);
 
 		sleep(1);
 		if (++wakeups > 5) {
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 24565f83e07d..bce3a4cb4c89 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -130,7 +130,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 
 out_init:
 	if (!exited || !nr_exit) {
-		perf_evlist__poll(evlist, -1);
+		evlist__poll(evlist, -1);
 		goto retry;
 	}
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 051be9a31db9..d4c7fd125ce9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -418,9 +418,9 @@ int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
 			       perf_evlist__munmap_filtered, NULL);
 }
 
-int perf_evlist__poll(struct evlist *evlist, int timeout)
+int evlist__poll(struct evlist *evlist, int timeout)
 {
-	return fdarray__poll(&evlist->core.pollfd, timeout);
+	return perf_evlist__poll(&evlist->core, timeout);
 }
 
 static void perf_evlist__set_sid_idx(struct evlist *evlist,
@@ -1736,7 +1736,7 @@ static void *perf_evlist__poll_thread(void *arg)
 			draining = true;
 
 		if (!draining)
-			perf_evlist__poll(evlist, 1000);
+			evlist__poll(evlist, 1000);
 
 		for (i = 0; i < evlist->core.nr_mmaps; i++) {
 			struct mmap *map = &evlist->mmap[i];
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 2eac8aab24a3..130d44d691b8 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -144,7 +144,7 @@ perf_evlist__find_tracepoint_by_name(struct evlist *evlist,
 int evlist__add_pollfd(struct evlist *evlist, int fd);
 int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
 
-int perf_evlist__poll(struct evlist *evlist, int timeout);
+int evlist__poll(struct evlist *evlist, int timeout);
 
 struct evsel *perf_evlist__id2evsel(struct evlist *evlist, u64 id);
 struct evsel *perf_evlist__id2evsel_strict(struct evlist *evlist,
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6c46d7dbd263..53f31053a27a 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -918,7 +918,7 @@ static PyObject *pyrf_evlist__poll(struct pyrf_evlist *pevlist,
 	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|i", kwlist, &timeout))
 		return NULL;
 
-	n = perf_evlist__poll(evlist, timeout);
+	n = evlist__poll(evlist, timeout);
 	if (n < 0) {
 		PyErr_SetFromErrno(PyExc_OSError);
 		return NULL;
-- 
2.21.0
