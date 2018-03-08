From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 45/54] perf c2c: Use mem_info refcnt logic
Date: Thu,  8 Mar 2018 16:50:20 -0300
Message-ID: <20180308195029.14991-46-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Switch to refcnt logic instead of duplicating mem_info objects. No
functional change, just saving some memory.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 539c3d460158..98d243fa0c06 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -237,9 +237,12 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 	if (mi == NULL)
 		return -ENOMEM;
 
-	mi_dup = memdup(mi, sizeof(*mi));
-	if (!mi_dup)
-		goto free_mi;
+	/*
+	 * The mi object is released in hists__add_entry_ops,
+	 * if it gets sorted out into existing data, so we need
+	 * to take the copy now.
+	 */
+	mi_dup = mem_info__get(mi);
 
 	c2c_decode_stats(&stats, mi);
 
@@ -247,7 +250,7 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 				  &al, NULL, NULL, mi,
 				  sample, true);
 	if (he == NULL)
-		goto free_mi_dup;
+		goto free_mi;
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 	c2c_add_stats(&c2c_he->stats, &stats);
@@ -272,19 +275,15 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 
 		mi = mi_dup;
 
-		mi_dup = memdup(mi, sizeof(*mi));
-		if (!mi_dup)
-			goto free_mi;
-
 		c2c_hists = he__get_c2c_hists(he, c2c.cl_sort, 2);
 		if (!c2c_hists)
-			goto free_mi_dup;
+			goto free_mi;
 
 		he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
 					  &al, NULL, NULL, mi,
 					  sample, true);
 		if (he == NULL)
-			goto free_mi_dup;
+			goto free_mi;
 
 		c2c_he = container_of(he, struct c2c_hist_entry, he);
 		c2c_add_stats(&c2c_he->stats, &stats);
@@ -303,10 +302,9 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 	addr_location__put(&al);
 	return ret;
 
-free_mi_dup:
-	free(mi_dup);
 free_mi:
-	free(mi);
+	mem_info__put(mi_dup);
+	mem_info__put(mi);
 	ret = -ENOMEM;
 	goto out;
 }
-- 
2.14.3
