Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55382D1111;
	Wed, 30 Apr 2025 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046553; cv=none; b=asnHo31EcKIC/kNvLBoXvUYWsKJLHvqnJN73bvZPn+1ZSwHlO28H+VuXPEIGIl7+EbqJpBUweo3J7As7lGSdWqTKyK/Ue93KtFb7yjDUlASR/98V0GgTrD8BkPuYm0o/MwepXuv2RYrBttu/klgqtNojoAthO0gktKRq/R4BQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046553; c=relaxed/simple;
	bh=7sXQXwPPQhlYweuVtPWicgFAno3L7sNHip2o4AI7mXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAR/gfh5E1GAeKdgeP/04lxKi/RwwHOFQvmFO7NvU1gvp/a9T89zhhc6+uElg8Ch8fCgRjYE2aCDCZbm0ugC5LccyfFv2BTmrAm0CpcLBd1b90EXw32ilqD1PzyZpfuqq9B6LPr//Pk4lwIuqA22zdVreyxS3OXscFCXkYQ3NG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMcOS4AD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMcOS4AD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02291C4CEEA;
	Wed, 30 Apr 2025 20:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046553;
	bh=7sXQXwPPQhlYweuVtPWicgFAno3L7sNHip2o4AI7mXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RMcOS4AD+GQlbBi2e2q67OHhvg/felLZ/Et4kTFhrsq1lkA2vS1vLhTEUmt3mFKwg
	 LKhF+TFPtY4gGLq2Z+ZDrP8NFxMATdrgqfoUNNDKSHBFpuXQEpORUU2FbinQCjX4rT
	 qZvLIwgg2uSqpo1IuJwj0rlhDadPKv+mcL0BM0/EWc4fwkG44IlwY/R0vSmq3f0Aiq
	 ipzzWu/pLmD0VeZfIGJtUxUjfonzg9WAVTgAGFXjLu/mEPHEmt7RJyeSTQ3JE+SuhH
	 M2D4lQGq+75B1TZhfx9bWLAF3meDrRyVIbKzXixYeCbHhwfo/ojB2ph1RTS4/I844V
	 G1VXJGqgQfEOw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Leo Yan <leo.yan@arm.com>
Subject: [PATCH 05/11] perf hist: Basic support for mem_stat accounting
Date: Wed, 30 Apr 2025 13:55:42 -0700
Message-ID: <20250430205548.789750-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430205548.789750-1-namhyung@kernel.org>
References: <20250430205548.789750-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a logic to account he->mem_stat based on mem_stat_type in hists.
Each mem_stat entry will have different meaning based on the type so the
index in the array is calculated at runtime using the corresponding
value in the sample.data_src.

Still hists has no mem_stat_types yet so this code won't work for now.
Later hists->mem_stat_types will be allocated based on what users want
in the output actually.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/hist.c         | 39 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/hist.c       |  6 ++++--
 tools/perf/util/hist.h       |  4 ++++
 tools/perf/util/mem-events.c | 18 +++++++++++++++++
 tools/perf/util/mem-events.h |  6 ++++++
 tools/perf/util/sort.c       |  4 ++++
 6 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index ec44633207aa3aba..2aad46bbd2ed4d93 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -11,6 +11,7 @@
 #include "../util/sort.h"
 #include "../util/evsel.h"
 #include "../util/evlist.h"
+#include "../util/mem-events.h"
 #include "../util/thread.h"
 #include "../util/util.h"
 
@@ -500,6 +501,12 @@ static int64_t hpp__nop_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return 0;
 }
 
+static bool perf_hpp__is_mem_stat_entry(struct perf_hpp_fmt *fmt)
+{
+	(void)fmt;
+	return false;
+}
+
 static bool perf_hpp__is_hpp_entry(struct perf_hpp_fmt *a)
 {
 	return a->header == hpp__header_fn;
@@ -1022,3 +1029,35 @@ int perf_hpp__setup_hists_formats(struct perf_hpp_list *list,
 
 	return 0;
 }
+
+int perf_hpp__alloc_mem_stats(struct perf_hpp_list *list, struct evlist *evlist)
+{
+	struct perf_hpp_fmt *fmt;
+	struct evsel *evsel;
+	enum mem_stat_type mst[16];
+	unsigned nr_mem_stats = 0;
+
+	perf_hpp_list__for_each_format(list, fmt) {
+		if (!perf_hpp__is_mem_stat_entry(fmt))
+			continue;
+
+		assert(nr_mem_stats < ARRAY_SIZE(mst));
+		mst[nr_mem_stats++] = PERF_MEM_STAT_UNKNOWN;
+	}
+
+	if (nr_mem_stats == 0)
+		return 0;
+
+	evlist__for_each_entry(evlist, evsel) {
+		struct hists *hists = evsel__hists(evsel);
+
+		hists->mem_stat_types = calloc(nr_mem_stats,
+					       sizeof(*hists->mem_stat_types));
+		if (hists->mem_stat_types == NULL)
+			return -ENOMEM;
+
+		memcpy(hists->mem_stat_types, mst, nr_mem_stats * sizeof(*mst));
+		hists->nr_mem_stats = nr_mem_stats;
+	}
+	return 0;
+}
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fcb9f0db0c92a229..7759c1818c1ad168 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -349,9 +349,10 @@ static int hists__update_mem_stat(struct hists *hists, struct hist_entry *he,
 	}
 
 	for (int i = 0; i < hists->nr_mem_stats; i++) {
-		int idx = 0; /* TODO: get correct index from mem info */
+		int idx = mem_stat_index(hists->mem_stat_types[i],
+					 mem_info__const_data_src(mi)->val);
 
-		(void)mi;
+		assert(0 <= idx && idx < MEM_STAT_LEN);
 		he->mem_stat[i].entries[idx] += period;
 	}
 	return 0;
@@ -3052,6 +3053,7 @@ static void hists_evsel__exit(struct evsel *evsel)
 	struct perf_hpp_list_node *node, *tmp;
 
 	hists__delete_all_entries(hists);
+	zfree(&hists->mem_stat_types);
 
 	list_for_each_entry_safe(node, tmp, &hists->hpp_formats, list) {
 		perf_hpp_list__for_each_format_safe(&node->hpp, fmt, pos) {
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index aba1d84ca074f27b..509af09691b84e10 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -9,6 +9,7 @@
 #include "events_stats.h"
 #include "evsel.h"
 #include "map_symbol.h"
+#include "mem-events.h"
 #include "mutex.h"
 #include "sample.h"
 #include "spark.h"
@@ -133,6 +134,7 @@ struct hists {
 	struct list_head	hpp_formats;
 	int			nr_hpp_node;
 	int			nr_mem_stats;
+	enum mem_stat_type	*mem_stat_types;
 };
 
 #define hists__has(__h, __f) (__h)->hpp_list->__f
@@ -597,6 +599,8 @@ void perf_hpp__reset_output_field(struct perf_hpp_list *list);
 void perf_hpp__append_sort_keys(struct perf_hpp_list *list);
 int perf_hpp__setup_hists_formats(struct perf_hpp_list *list,
 				  struct evlist *evlist);
+int perf_hpp__alloc_mem_stats(struct perf_hpp_list *list,
+			      struct evlist *evlist);
 
 
 bool perf_hpp__is_sort_entry(struct perf_hpp_fmt *format);
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 884d9aebce9199c0..1bc60ad3dc312542 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -799,3 +799,21 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add)
 	stats->nomap		+= add->nomap;
 	stats->noparse		+= add->noparse;
 }
+
+/*
+ * It returns an index in hist_entry->mem_stat array for the given val which
+ * represents a data-src based on the mem_stat_type.
+ *
+ * For example, when mst is about cache level, the index can be 1 for L1, 2 for
+ * L2 and so on.
+ */
+int mem_stat_index(const enum mem_stat_type mst, const u64 val)
+{
+	switch (mst) {
+	case PERF_MEM_STAT_UNKNOWN:  /* placeholder */
+	default:
+		break;
+	}
+	(void)val;
+	return -1;
+}
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index a5c19d39ee37147b..2604464f985815f6 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -89,4 +89,10 @@ struct hist_entry;
 int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi);
 void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add);
 
+enum mem_stat_type {
+	PERF_MEM_STAT_UNKNOWN,  /* placeholder */
+};
+
+int mem_stat_index(const enum mem_stat_type mst, const u64 data_src);
+
 #endif /* __PERF_MEM_EVENTS_H */
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index ae8b8ceb82f3d00b..6024f588f66f3156 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -4163,6 +4163,10 @@ int setup_sorting(struct evlist *evlist)
 	if (err < 0)
 		return err;
 
+	err = perf_hpp__alloc_mem_stats(&perf_hpp_list, evlist);
+	if (err < 0)
+		return err;
+
 	/* copy sort keys to output fields */
 	perf_hpp__setup_output_field(&perf_hpp_list);
 	/* and then copy output fields to sort keys */
-- 
2.49.0.906.g1f30a19c02-goog

