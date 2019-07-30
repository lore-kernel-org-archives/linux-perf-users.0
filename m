From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 038/107] perf evsel: Rename perf_evsel__new() to evsel__new()
Date: Mon, 29 Jul 2019 23:55:01 -0300
Message-ID: <20190730025610.22603-39-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename perf_evsel__new() to evsel__new(), so we don't have a name clash
when we add perf_evsel__new() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c     | 2 +-
 tools/perf/tests/sw-clock.c    | 2 +-
 tools/perf/util/evsel.c        | 2 +-
 tools/perf/util/evsel.h        | 2 +-
 tools/perf/util/header.c       | 4 ++--
 tools/perf/util/parse-events.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0f7d1859a2d1..c5eb47f4e42e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2657,7 +2657,7 @@ static struct evsel *perf_evsel__new_pgfault(u64 config)
 
 	event_attr_init(&attr);
 
-	evsel = perf_evsel__new(&attr);
+	evsel = evsel__new(&attr);
 	if (evsel)
 		evsel->handler = trace__pgfault;
 
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 1c7d8adb43d0..247d3734686e 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -49,7 +49,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		return -1;
 	}
 
-	evsel = perf_evsel__new(&attr);
+	evsel = evsel__new(&attr);
 	if (evsel == NULL) {
 		pr_debug("perf_evsel__new\n");
 		goto out_delete_evlist;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index de379b63f1ce..c9723c2d57c9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -301,7 +301,7 @@ struct evsel *perf_evsel__new_cycles(bool precise)
 	 * to kick in when we return and before perf_evsel__open() is called.
 	 */
 new_event:
-	evsel = perf_evsel__new(&attr);
+	evsel = evsel__new(&attr);
 	if (evsel == NULL)
 		goto out;
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 20b4e31b63a9..ecea51a918e0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -219,7 +219,7 @@ int perf_evsel__object_config(size_t object_size,
 
 struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
 
-static inline struct evsel *perf_evsel__new(struct perf_event_attr *attr)
+static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 {
 	return perf_evsel__new_idx(attr, 0);
 }
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 29bbfd699226..7760ddc4bc18 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3583,7 +3583,7 @@ int perf_session__read_header(struct perf_session *session)
 		}
 
 		tmp = lseek(fd, 0, SEEK_CUR);
-		evsel = perf_evsel__new(&f_attr.attr);
+		evsel = evsel__new(&f_attr.attr);
 
 		if (evsel == NULL)
 			goto out_delete_evlist;
@@ -4021,7 +4021,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 			return -ENOMEM;
 	}
 
-	evsel = perf_evsel__new(&event->attr.attr);
+	evsel = evsel__new(&event->attr.attr);
 	if (evsel == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cc63367f6e45..40087cf74dd1 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2318,7 +2318,7 @@ static bool is_event_supported(u8 type, unsigned config)
 	if (tmap == NULL)
 		return false;
 
-	evsel = perf_evsel__new(&attr);
+	evsel = evsel__new(&attr);
 	if (evsel) {
 		open_return = perf_evsel__open(evsel, NULL, tmap);
 		ret = open_return >= 0;
-- 
2.21.0
