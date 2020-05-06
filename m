From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 56/91] perf evsel: Rename __perf_evsel__sample_size() to __evsel__sample_size()
Date: Wed,  6 May 2020 12:21:59 -0300
Message-ID: <20200506152234.21977-57-acme@kernel.org>
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

As it is a 'struct evsel' related method, not part of tools/lib/perf/,
aka libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sample-parsing.c | 2 +-
 tools/perf/util/evsel.c           | 4 ++--
 tools/perf/util/evsel.h           | 2 +-
 tools/perf/util/intel-bts.c       | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 61865699c3f4..ab964db855ac 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -296,7 +296,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		goto out_free;
 	}
 
-	evsel.sample_size = __perf_evsel__sample_size(sample_type);
+	evsel.sample_size = __evsel__sample_size(sample_type);
 
 	err = perf_evsel__parse_sample(&evsel, event, &sample_out);
 	if (err) {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 896b0b9798d8..3a16728074a9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -102,7 +102,7 @@ int perf_evsel__object_config(size_t object_size,
 
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 
-int __perf_evsel__sample_size(u64 sample_type)
+int __evsel__sample_size(u64 sample_type)
 {
 	u64 mask = sample_type & PERF_SAMPLE_MASK;
 	int size = 0;
@@ -249,7 +249,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->bpf_fd	   = -1;
 	INIT_LIST_HEAD(&evsel->config_terms);
 	perf_evsel__object.init(evsel);
-	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
+	evsel->sample_size = __evsel__sample_size(attr->sample_type);
 	evsel__calc_id_pos(evsel);
 	evsel->cmdline_group_boundary = false;
 	evsel->metric_expr   = NULL;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 35ad62807eaf..580975c7086a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -193,7 +193,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
 			     struct callchain_param *callchain);
 
-int __perf_evsel__sample_size(u64 sample_type);
+int __evsel__sample_size(u64 sample_type);
 void evsel__calc_id_pos(struct evsel *evsel);
 
 bool perf_evsel__is_cache_op_valid(u8 type, u8 op);
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 506112f52619..af1e78d76228 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -825,10 +825,10 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 		bts->branches_id = id;
 		/*
 		 * We only use sample types from PERF_SAMPLE_MASK so we can use
-		 * __perf_evsel__sample_size() here.
+		 * __evsel__sample_size() here.
 		 */
 		bts->branches_event_size = sizeof(struct perf_record_sample) +
-				__perf_evsel__sample_size(attr.sample_type);
+					   __evsel__sample_size(attr.sample_type);
 	}
 
 	return 0;
-- 
2.21.1
