From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 78/91] perf kmem: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date: Wed,  6 May 2020 12:22:21 -0300
Message-ID: <20200506152234.21977-79-acme@kernel.org>
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

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kmem.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 0a296fbf9194..38a5ab683ebc 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -169,8 +169,7 @@ static int insert_caller_stat(unsigned long call_site,
 	return 0;
 }
 
-static int perf_evsel__process_alloc_event(struct evsel *evsel,
-					   struct perf_sample *sample)
+static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *sample)
 {
 	unsigned long ptr = evsel__intval(evsel, sample, "ptr"),
 		      call_site = evsel__intval(evsel, sample, "call_site");
@@ -188,10 +187,9 @@ static int perf_evsel__process_alloc_event(struct evsel *evsel,
 	return 0;
 }
 
-static int perf_evsel__process_alloc_node_event(struct evsel *evsel,
-						struct perf_sample *sample)
+static int evsel__process_alloc_node_event(struct evsel *evsel, struct perf_sample *sample)
 {
-	int ret = perf_evsel__process_alloc_event(evsel, sample);
+	int ret = evsel__process_alloc_event(evsel, sample);
 
 	if (!ret) {
 		int node1 = cpu__get_node(sample->cpu),
@@ -232,8 +230,7 @@ static struct alloc_stat *search_alloc_stat(unsigned long ptr,
 	return NULL;
 }
 
-static int perf_evsel__process_free_event(struct evsel *evsel,
-					  struct perf_sample *sample)
+static int evsel__process_free_event(struct evsel *evsel, struct perf_sample *sample)
 {
 	unsigned long ptr = evsel__intval(evsel, sample, "ptr");
 	struct alloc_stat *s_alloc, *s_caller;
@@ -784,8 +781,7 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 	return 0;
 }
 
-static int perf_evsel__process_page_alloc_event(struct evsel *evsel,
-						struct perf_sample *sample)
+static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = evsel__intval(evsel, sample, "order");
@@ -857,8 +853,7 @@ static int perf_evsel__process_page_alloc_event(struct evsel *evsel,
 	return 0;
 }
 
-static int perf_evsel__process_page_free_event(struct evsel *evsel,
-						struct perf_sample *sample)
+static int evsel__process_page_free_event(struct evsel *evsel, struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = evsel__intval(evsel, sample, "order");
@@ -1371,15 +1366,15 @@ static int __cmd_kmem(struct perf_session *session)
 	struct evsel *evsel;
 	const struct evsel_str_handler kmem_tracepoints[] = {
 		/* slab allocator */
-		{ "kmem:kmalloc",		perf_evsel__process_alloc_event, },
-    		{ "kmem:kmem_cache_alloc",	perf_evsel__process_alloc_event, },
-		{ "kmem:kmalloc_node",		perf_evsel__process_alloc_node_event, },
-    		{ "kmem:kmem_cache_alloc_node", perf_evsel__process_alloc_node_event, },
-		{ "kmem:kfree",			perf_evsel__process_free_event, },
-    		{ "kmem:kmem_cache_free",	perf_evsel__process_free_event, },
+		{ "kmem:kmalloc",		evsel__process_alloc_event, },
+		{ "kmem:kmem_cache_alloc",	evsel__process_alloc_event, },
+		{ "kmem:kmalloc_node",		evsel__process_alloc_node_event, },
+		{ "kmem:kmem_cache_alloc_node", evsel__process_alloc_node_event, },
+		{ "kmem:kfree",			evsel__process_free_event, },
+		{ "kmem:kmem_cache_free",	evsel__process_free_event, },
 		/* page allocator */
-		{ "kmem:mm_page_alloc",		perf_evsel__process_page_alloc_event, },
-		{ "kmem:mm_page_free",		perf_evsel__process_page_free_event, },
+		{ "kmem:mm_page_alloc",		evsel__process_page_alloc_event, },
+		{ "kmem:mm_page_free",		evsel__process_page_free_event, },
 	};
 
 	if (!perf_session__has_traces(session, "kmem record"))
-- 
2.21.1
