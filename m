From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 55/91] perf evsel: Rename perf_evsel__calc_id_pos() to evsel__calc_id_pos()
Date: Wed,  6 May 2020 12:21:58 -0300
Message-ID: <20200506152234.21977-56-acme@kernel.org>
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

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 +-
 tools/perf/util/evsel.c  | 8 ++++----
 tools/perf/util/evsel.h  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6d902c02fd95..8b691151bae3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -119,7 +119,7 @@ static void perf_evlist__update_id_pos(struct evlist *evlist)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel)
-		perf_evsel__calc_id_pos(evsel);
+		evsel__calc_id_pos(evsel);
 
 	perf_evlist__set_id_pos(evlist);
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f88cf7961d49..896b0b9798d8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -178,7 +178,7 @@ static int __perf_evsel__calc_is_pos(u64 sample_type)
 	return idx;
 }
 
-void perf_evsel__calc_id_pos(struct evsel *evsel)
+void evsel__calc_id_pos(struct evsel *evsel)
 {
 	evsel->id_pos = __perf_evsel__calc_id_pos(evsel->core.attr.sample_type);
 	evsel->is_pos = __perf_evsel__calc_is_pos(evsel->core.attr.sample_type);
@@ -190,7 +190,7 @@ void __perf_evsel__set_sample_bit(struct evsel *evsel,
 	if (!(evsel->core.attr.sample_type & bit)) {
 		evsel->core.attr.sample_type |= bit;
 		evsel->sample_size += sizeof(u64);
-		perf_evsel__calc_id_pos(evsel);
+		evsel__calc_id_pos(evsel);
 	}
 }
 
@@ -200,7 +200,7 @@ void __perf_evsel__reset_sample_bit(struct evsel *evsel,
 	if (evsel->core.attr.sample_type & bit) {
 		evsel->core.attr.sample_type &= ~bit;
 		evsel->sample_size -= sizeof(u64);
-		perf_evsel__calc_id_pos(evsel);
+		evsel__calc_id_pos(evsel);
 	}
 }
 
@@ -250,7 +250,7 @@ void evsel__init(struct evsel *evsel,
 	INIT_LIST_HEAD(&evsel->config_terms);
 	perf_evsel__object.init(evsel);
 	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
-	perf_evsel__calc_id_pos(evsel);
+	evsel__calc_id_pos(evsel);
 	evsel->cmdline_group_boundary = false;
 	evsel->metric_expr   = NULL;
 	evsel->metric_name   = NULL;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 617cb3fa0353..35ad62807eaf 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -194,7 +194,7 @@ void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
 			     struct callchain_param *callchain);
 
 int __perf_evsel__sample_size(u64 sample_type);
-void perf_evsel__calc_id_pos(struct evsel *evsel);
+void evsel__calc_id_pos(struct evsel *evsel);
 
 bool perf_evsel__is_cache_op_valid(u8 type, u8 op);
 
-- 
2.21.1
