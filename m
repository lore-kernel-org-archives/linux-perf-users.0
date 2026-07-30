Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F333F39EF;
	Thu, 30 Jul 2026 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402057; cv=none; b=RKf1fRT5w8B2YMpyJ8yajkowoA9LQMtxuFKbQaUSSBpDVL/Vxr7qS3cnj4lEogTEHw6bSJ/i/bmwhBBKSa2IBTZcAv7nBArwIFy+QSUtVVGZvuGhZ55Ir12X1NdmK+qJT5K0H90kkcf+S68qDVB2ItDpu1LUmTeOtRMWfxE/0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402057; c=relaxed/simple;
	bh=1zSg5i/ETu8zxrTi62tjtikPNEeiZ+aYOd4B0fhCOqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYNvXVy1M9NsjKQqwrflupb4uEPu5XrwBYBTQdar9SDVARmw1ILY3ji3bk1SJKlq1BxzxI0kI+hcnphqh5805FAzMlqToPGJQPikaNMi2ziZ5kI0Rs9aZNm0WgfXQpnLmu8ld5x3LjnrMAiIm+9Pz/RdJAsItzt2kqUUJQpBEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GzSEI9Hm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GzSEI9Hm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785402055; x=1816938055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1zSg5i/ETu8zxrTi62tjtikPNEeiZ+aYOd4B0fhCOqU=;
  b=GzSEI9Hm+VZffnmdqY5ufqvWGe6vk7Kiv9OiwP9zFkumOv3bUzzbOLj+
   GWEj6Bf96bbTBcZ4Lu2BE+xHmegRT3FiPvDoc0jgIa64AxNpfKVvCroo3
   rbSUflBnM25qveYYKRsVe/zud3mlSCoTdWdIdVDwJrHnV2q60W+vDFqG3
   hZTXOr+qX5xswafnQHcimB1u0HL+08X1/cEOuuwjd4TPhD50dkMWwrrHK
   HqODLX7E1fhyivFFK8FvQLM7Cs6OQUN7D1WkAVs2WzTY0TI7L8O5/DLUe
   rQq5jgL7lFuHbqIEHr59nJBkUvzQq768ZuXLWi6mwjnIVAHSyVKQNhinn
   w==;
X-CSE-ConnectionGUID: nXeQxhO4Th6RApbpJx4CNw==
X-CSE-MsgGUID: m2mllWzWRwKxtrf2gdZdrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="111563510"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="111563510"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 02:00:55 -0700
X-CSE-ConnectionGUID: bF9wvUQTQXKOMYC9ezERBA==
X-CSE-MsgGUID: ggPooxHvSziBXpXaB++sqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="260846503"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa009.jf.intel.com with ESMTP; 30 Jul 2026 02:00:51 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH v5 v5 6/9] perf c2c: add function view hierarchy entry creation
Date: Thu, 30 Jul 2026 17:05:18 +0800
Message-ID: <20260730090521.2206375-7-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260730090521.2206375-1-jiebin.sun@intel.com>
References: <20260730090521.2206375-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the entry-creation layer: the borrowed-reference child allocation and
insertion, and the level-1/2/3 lookup-or-create functions keyed by
function symbol (level 1 read-side, level 2 writer) and by the source
cacheline's existing index (level 3).

Reuse cacheline_idx to preserve the source entry identity without adding
function-view-only state. The browser can later use the same index to find
the original cacheline entry.

These are driven by the hierarchy builder in the next patch and are
__maybe_unused until then.

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/ui/browsers/c2c-function.c | 303 ++++++++++++++++++++++++--
 1 file changed, 285 insertions(+), 18 deletions(-)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 051c38697edd..b3528edb387a 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -28,6 +28,7 @@
 #include "../../util/addr_location.h"
 #include "../../util/cacheline.h"
 #include "../../util/debug.h"
+#include "../../util/dso.h"
 #include "../../util/hist.h"
 #include "../../util/map.h"
 #include "../../util/mem-events.h"
@@ -55,12 +56,34 @@ static inline __maybe_unused u64 c2c_hitm_count(const struct c2c_stats *stats)
 	return stats->tot_hitm;
 }
 
-static inline __maybe_unused bool symbol_name_equal(struct symbol *a, struct symbol *b)
+static int64_t c2c_function_cmp(const struct map_symbol *left,
+				const struct map_symbol *right)
 {
-	/* Two unknown symbols compare equal, matching cmp_null() in util/sort.c. */
-	if (!a || !b)
-		return a == b;
-	return arch__compare_symbol_names(a->name, b->name) == 0;
+	const struct dso *left_dso = left->map ? map__dso(left->map) : NULL;
+	const struct dso *right_dso = right->map ? map__dso(right->map) : NULL;
+	int ret;
+
+	if (!left_dso || !right_dso) {
+		if (left_dso != right_dso)
+			return left_dso ? 1 : -1;
+	} else {
+		/*
+		 * Use the same DSO name as _sort__dso_cmp() (short name unless
+		 * verbose), so this matches the DSO comparison the level-1
+		 * entries are deduplicated by; otherwise same-basename DSOs
+		 * could be split or merged inconsistently across levels.
+		 */
+		const char *left_name = verbose > 0 ?
+			dso__long_name(left_dso) : dso__short_name(left_dso);
+		const char *right_name = verbose > 0 ?
+			dso__long_name(right_dso) : dso__short_name(right_dso);
+
+		ret = strcmp(left_name, right_name);
+		if (ret)
+			return ret;
+	}
+
+	return _sort__sym_cmp(left->sym, right->sym);
 }
 
 static inline __maybe_unused u64 hist_entry__iaddr(struct hist_entry *he)
@@ -749,7 +772,7 @@ static void c2c_he__free_hierarchy(struct hist_entry *he);
 /*
  * Free a function-view histogram entry (hist_entry_ops::free).
  */
-static void __maybe_unused c2c_function_he_free(void *ptr)
+static void c2c_function_he_free(void *ptr)
 {
 	struct hist_entry *he = ptr;
 	struct c2c_hist_entry *c2c_he;
@@ -764,18 +787,13 @@ static void __maybe_unused c2c_function_he_free(void *ptr)
 
 	c2c_he__free_hierarchy(he);
 
-	zfree(&c2c_he->nodeset);
-	zfree(&c2c_he->cpuset);
-	zfree(&c2c_he->nodestr);
-	zfree(&c2c_he->node_stats);
-
 	free(c2c_he);
 }
 
 /*
  * Free one child entry @child_he and everything below it. Frees exactly the
- * resources c2c_child_entry__alloc() owns (mem_info clone, stat_acc, hists and
- * the c2c-specific arrays); the borrowed thread/ms are left untouched.
+ * resources c2c_child_entry__alloc() owns; the borrowed thread/ms are left
+ * untouched.
  */
 static void c2c_child_he__free(struct hist_entry *child_he)
 {
@@ -793,11 +811,6 @@ static void c2c_child_he__free(struct hist_entry *child_he)
 		zfree(&child_c2c->hists);
 	}
 
-	zfree(&child_c2c->cpuset);
-	zfree(&child_c2c->nodeset);
-	zfree(&child_c2c->nodestr);
-	zfree(&child_c2c->node_stats);
-
 	c2c_he__free_hierarchy(child_he);
 
 	free(child_c2c);
@@ -876,6 +889,260 @@ static int __maybe_unused c2c_he__prune_empty_writers(struct hist_entry *l1_he)
 	return surviving;
 }
 
+static void *c2c_function_he_zalloc(size_t size)
+{
+	struct c2c_hist_entry *c2c_he = zalloc(sizeof(*c2c_he) + size);
+
+	if (!c2c_he)
+		return NULL;
+
+	init_stats(&c2c_he->cstats.lcl_hitm);
+	init_stats(&c2c_he->cstats.rmt_hitm);
+	init_stats(&c2c_he->cstats.lcl_peer);
+	init_stats(&c2c_he->cstats.rmt_peer);
+	init_stats(&c2c_he->cstats.load);
+
+	return &c2c_he->he;
+}
+
+/* Entry operations for function view */
+static struct hist_entry_ops c2c_function_entry_ops = {
+	.new	= c2c_function_he_zalloc,
+	.free	= c2c_function_he_free,
+};
+
+static struct c2c_hist_entry *
+c2c_child_entry__alloc(struct hist_entry *parent_he, struct hist_entry *src_he,
+		       int depth, u64 ip)
+{
+	struct c2c_hist_entry *child_c2c;
+	struct hist_entry *child_he;
+
+	/* Function-view children never own or display callchains. */
+	child_he = c2c_function_he_zalloc(0);
+	if (!child_he)
+		return NULL;
+
+	child_c2c = container_of(child_he, struct c2c_hist_entry, he);
+	memcpy(&child_he->ms, &src_he->ms, sizeof(struct map_symbol));
+
+	if (src_he->mem_info) {
+		child_he->mem_info = mem_info__clone(src_he->mem_info);
+		if (!child_he->mem_info)
+			goto out_free;
+	}
+
+	child_he->thread = src_he->thread;
+	child_he->cpumode = src_he->cpumode;
+	child_he->cpu = src_he->cpu;
+	child_he->socket = src_he->socket;
+	child_he->level = src_he->level;
+	child_he->ip = ip;
+
+	child_he->parent_he = parent_he;
+	child_he->depth = depth;
+	child_he->leaf = (depth >= 2);
+	child_he->hists = &c2c_ext.function_hists.hists;
+	child_he->filtered = false;
+	child_he->unfolded = false;
+	child_he->has_children = false;
+	child_he->has_no_entry = false;
+	child_he->nr_rows = 0;
+	child_he->row_offset = 0;
+
+	memset(&child_he->stat, 0, sizeof(child_he->stat));
+	child_he->hroot_in = RB_ROOT_CACHED;
+	child_he->hroot_out = RB_ROOT_CACHED;
+	INIT_LIST_HEAD(&child_he->pairs.node);
+	child_he->hpp_list = &c2c_ext.function_hists.list;
+	if (symbol_conf.cumulate_callchain) {
+		child_he->stat_acc = calloc(1, sizeof(struct he_stat));
+		if (!child_he->stat_acc)
+			goto out_free;
+	}
+
+	return child_c2c;
+
+out_free:
+	if (child_he->mem_info)
+		mem_info__put(child_he->mem_info);
+	free(child_c2c);
+	return NULL;
+}
+
+static void
+c2c_child_entry__insert(struct hist_entry *parent_he, struct hist_entry *child_he,
+			struct rb_node **p, struct rb_node *rb_parent, bool leftmost)
+{
+	rb_link_node(&child_he->rb_node, rb_parent, p);
+	rb_insert_color_cached(&child_he->rb_node, &parent_he->hroot_out, leftmost);
+
+	parent_he->has_children = true;
+	parent_he->leaf = false;
+}
+
+static __maybe_unused struct hist_entry *
+c2c_function_hists__level1_entry(struct symbol *sym,
+				 struct hist_entry *detail_he,
+				 struct thread *synthetic_thread)
+{
+	struct addr_location al;
+	struct perf_sample sample = {};
+	struct mem_info *mi;
+	struct hist_entry *he;
+	/*
+	 * Key the level-1 entry by the function, not by a specific code
+	 * address: use the symbol start so every instruction address inside
+	 * the same function collapses into one entry. This makes level 1 a
+	 * true "function view" rather than a per-code-address view.
+	 */
+	u64 sym_start = (sym && detail_he->ms.map) ?
+			map__unmap_ip(detail_he->ms.map, sym->start) : detail_he->ip;
+
+	mi = mem_info__new();
+	if (!mi)
+		return NULL;
+
+	mem_info__iaddr(mi)->addr = sym_start;
+	/* mem_info__put() will map_symbol__exit() these, so take refs. */
+	mem_info__iaddr(mi)->ms.thread = thread__get(detail_he->ms.thread);
+	mem_info__iaddr(mi)->ms.map = map__get(detail_he->ms.map);
+	mem_info__iaddr(mi)->ms.sym = sym;
+	mem_info__daddr(mi)->addr = 0;
+
+	addr_location__init(&al);
+	al.thread = thread__get(synthetic_thread);
+	al.map = map__get(detail_he->ms.map);
+	al.sym = sym;
+	al.addr = sym_start;
+	al.level = detail_he->level;
+	al.cpumode = detail_he->cpumode;
+	al.cpu = 0;
+	al.socket = 0;
+	al.filtered = 0;
+	al.latency = 0;
+
+	/*
+	 * Synthetic sample: period/weight are placeholders only. The real
+	 * c2c counters live in c2c_hist_entry::stats and are added via
+	 * hist_entry__add_c2c_stats(); no function-view column or sort key
+	 * reads he->stat.period/nr_events, so the +1 that __hists__add_entry()
+	 * accrues on each dedup hit has no effect on what is displayed.
+	 */
+	sample.period = 1;
+	sample.weight = 1;
+	sample.ip = sym_start;
+	sample.pid = thread__pid(synthetic_thread);
+	sample.tid = thread__tid(synthetic_thread);
+	sample.cpu = 0;
+
+	/* Add entry - histogram handles dedup */
+	he = hists__add_entry_ops(&c2c_ext.function_hists.hists,
+				  &c2c_function_entry_ops,
+				  &al, NULL, NULL, mi,
+				  NULL, &sample, true);
+
+	addr_location__exit(&al);
+	mem_info__put(mi);
+
+	if (he)
+		he->hpp_list = &c2c_ext.function_hists.list;
+
+	return he;
+}
+
+/*
+ * Level 2: a function that writes a cacheline the level-1 function reads,
+ * keyed by the DSO display name and symbol, consistently with perf's symbol
+ * sort semantics. All code addresses and cachelines for the same writer
+ * function aggregate into one row.
+ */
+static __maybe_unused struct c2c_hist_entry *
+c2c_function_hists__level2_entry(struct c2c_hist_entry *level1_c2c,
+				 struct symbol *sym, struct hist_entry *detail_he)
+{
+	struct hist_entry *level1_he = &level1_c2c->he;
+	struct rb_node **p = &level1_he->hroot_out.rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	struct c2c_hist_entry *level2_c2c;
+	bool leftmost = true;
+
+	while (*p) {
+		struct hist_entry *iter = rb_entry(*p, struct hist_entry, rb_node);
+		struct map_symbol key = detail_he->ms;
+		int64_t cmp;
+
+		key.sym = sym;
+		parent = *p;
+		cmp = c2c_function_cmp(&key, &iter->ms);
+
+		if (cmp < 0) {
+			p = &parent->rb_left;
+		} else if (cmp > 0) {
+			p = &parent->rb_right;
+			leftmost = false;
+		} else {
+			return container_of(iter, struct c2c_hist_entry, he);
+		}
+	}
+
+	/* Key by the function symbol start so all code addresses collapse. */
+	level2_c2c = c2c_child_entry__alloc(level1_he, detail_he, 1,
+					    (sym && detail_he->ms.map) ?
+						  map__unmap_ip(detail_he->ms.map, sym->start) :
+						  hist_entry__iaddr(detail_he));
+	if (!level2_c2c)
+		return NULL;
+
+	/* Key this level by the looked-up symbol, not detail_he's. */
+	level2_c2c->he.ms.sym = sym;
+	if (level2_c2c->he.mem_info)
+		mem_info__iaddr(level2_c2c->he.mem_info)->ms.sym = sym;
+
+	c2c_child_entry__insert(level1_he, &level2_c2c->he, p, parent, leftmost);
+
+	return level2_c2c;
+}
+
+/* Level 3: one source cacheline where the L1/L2 functions contend. */
+static __maybe_unused struct c2c_hist_entry *
+c2c_function_hists__level3_entry(struct c2c_hist_entry *level2_c2c,
+				 struct c2c_hist_entry *cacheline_src_he)
+{
+	struct hist_entry *level2_he = &level2_c2c->he;
+	struct rb_node **p = &level2_he->hroot_out.rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	struct c2c_hist_entry *level3_c2c;
+	bool leftmost = true;
+
+	while (*p) {
+		struct hist_entry *iter = rb_entry(*p, struct hist_entry, rb_node);
+		struct c2c_hist_entry *iter_c2c;
+
+		iter_c2c = container_of(iter, struct c2c_hist_entry, he);
+
+		parent = *p;
+		if (cacheline_src_he->cacheline_idx < iter_c2c->cacheline_idx) {
+			p = &parent->rb_left;
+		} else if (cacheline_src_he->cacheline_idx > iter_c2c->cacheline_idx) {
+			p = &parent->rb_right;
+			leftmost = false;
+		} else {
+			return container_of(iter, struct c2c_hist_entry, he);
+		}
+	}
+
+	level3_c2c = c2c_child_entry__alloc(level2_he, &cacheline_src_he->he, 2,
+					    hist_entry__iaddr(&cacheline_src_he->he));
+	if (!level3_c2c)
+		return NULL;
+	level3_c2c->cacheline_idx = cacheline_src_he->cacheline_idx;
+
+	c2c_child_entry__insert(level2_he, &level3_c2c->he, p, parent, leftmost);
+
+	return level3_c2c;
+}
+
 int perf_c2c__browse_function_view(void)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

