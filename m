From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/63] perf inject: Make --strip keep evsels
Date: Thu,  7 Nov 2019 15:59:48 -0300
Message-ID: <20191107190011.23924-41-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

create_gcov (refer to the autofdo example in tools/perf/Documentation/intel-pt.txt)
now needs the evsels to read the perf.data file. So don't strip them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191105100057.21465-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 54 -------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 372ecb3e2c06..1e5d28311e14 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -578,58 +578,6 @@ static void strip_init(struct perf_inject *inject)
 		evsel->handler = drop_sample;
 }
 
-static bool has_tracking(struct evsel *evsel)
-{
-	return evsel->core.attr.mmap || evsel->core.attr.mmap2 || evsel->core.attr.comm ||
-	       evsel->core.attr.task;
-}
-
-#define COMPAT_MASK (PERF_SAMPLE_ID | PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
-		     PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_IDENTIFIER)
-
-/*
- * In order that the perf.data file is parsable, tracking events like MMAP need
- * their selected event to exist, except if there is only 1 selected event left
- * and it has a compatible sample type.
- */
-static bool ok_to_remove(struct evlist *evlist,
-			 struct evsel *evsel_to_remove)
-{
-	struct evsel *evsel;
-	int cnt = 0;
-	bool ok = false;
-
-	if (!has_tracking(evsel_to_remove))
-		return true;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->handler != drop_sample) {
-			cnt += 1;
-			if ((evsel->core.attr.sample_type & COMPAT_MASK) ==
-			    (evsel_to_remove->core.attr.sample_type & COMPAT_MASK))
-				ok = true;
-		}
-	}
-
-	return ok && cnt == 1;
-}
-
-static void strip_fini(struct perf_inject *inject)
-{
-	struct evlist *evlist = inject->session->evlist;
-	struct evsel *evsel, *tmp;
-
-	/* Remove non-synthesized evsels if possible */
-	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		if (evsel->handler == drop_sample &&
-		    ok_to_remove(evlist, evsel)) {
-			pr_debug("Deleting %s\n", perf_evsel__name(evsel));
-			evlist__remove(evlist, evsel);
-			evsel__delete(evsel);
-		}
-	}
-}
-
 static int __cmd_inject(struct perf_inject *inject)
 {
 	int ret = -EINVAL;
@@ -729,8 +677,6 @@ static int __cmd_inject(struct perf_inject *inject)
 				evlist__remove(session->evlist, evsel);
 				evsel__delete(evsel);
 			}
-			if (inject->strip)
-				strip_fini(inject);
 		}
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
-- 
2.21.0
