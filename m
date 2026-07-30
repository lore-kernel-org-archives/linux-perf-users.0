Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB23F4825;
	Thu, 30 Jul 2026 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402061; cv=none; b=IcleyojJO95L+xY31EuE0eKWn5TWMlN1RB+yrO7lw3Tb9UEk/734jIqsQ9BNPxsjKm7279YD7AeTyTXcinGesbCxsRmvYNF+r+c8PLMPOF6uiWg1qig4EfKCflVf2WMFd5WOc2bX3ssXohAhV7MJI+c5cBpLvJmgYf/l2PBQRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402061; c=relaxed/simple;
	bh=gBZs2LbcDznYNV7Siiu4WLaGTD6DKskzdxyEvGVjjqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms8j4iNOLDeBAL74pk3A3mvpxnnqBOKmEIfucQONuSofA80PXF0Tg6NVkCgCE6m81XHbCJ9jskRl2jkt7uoPsZj9cP4R91vTQulNubfV3O7dTzbb8cF7KjFJ9KltaxBOjeZJyj3Wl5ooVd3IwlbnPDB4g5rGI6zt681W+pPFCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncn/7yf5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncn/7yf5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785402059; x=1816938059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gBZs2LbcDznYNV7Siiu4WLaGTD6DKskzdxyEvGVjjqU=;
  b=ncn/7yf5pK+G4iplVEl2WLBOG02mixPD/63ln2kgp1wbRGwfkX/Uvds3
   C5M7kn3pGFsFsBdVTxiaVvDr1LljCaXiUwohkEOEAV8eguUHxfiqhvL+D
   HnTqi4gp5iSWv/pBz1WVFvNl5fmU7U/9b1/fwTKx9DTpQy4gorgwQMrXV
   6xde2659qdA45WQOWKPz4KGUwEuZvWqswfNgywFLcU1xvf2i+oL+E8xzv
   xYjtVQPrDQGmwVM6DRN01q/3TsFnC4efuO/EkHiAFE3hIVownbfDRX4tT
   cAwPp+WBz/ap7BLbka1mdJ08Lfx5smwNcv3oLnq2/OpNxhMVamRPXp883
   Q==;
X-CSE-ConnectionGUID: idY69/nCTc2ROYXq21Sfxg==
X-CSE-MsgGUID: TXC5i4LgRQynjHOPCUV34g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="111563527"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="111563527"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 02:00:59 -0700
X-CSE-ConnectionGUID: uTfUOwGGRFe/Ae69O2LF6w==
X-CSE-MsgGUID: webRGrJ7RZ269nF+jiDokQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="260846520"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa009.jf.intel.com with ESMTP; 30 Jul 2026 02:00:55 -0700
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
Subject: [PATCH v5 v5 7/9] perf c2c: build and finalize the function view hierarchy
Date: Thu, 30 Jul 2026 17:05:19 +0800
Message-ID: <20260730090521.2206375-8-jiebin.sun@intel.com>
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

Add the builder that walks the top-level cacheline entries and, for each
read-side function, correlates the functions that write the same lines
(level 2) and the specific cachelines they contend over (level 3) within
each retained detail histogram. Aggregate the write traffic per contending
function, resort by store count, and prune writers/functions with no
contention. The finalize pass computes the global cycle total used as the
Cycles % denominator.

build_function_view_hierarchy() is wired into the browser entry point by
the next patch and is marked __maybe_unused until then.

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
 tools/perf/ui/browsers/c2c-function.c | 476 +++++++++++++++++++++++++-
 1 file changed, 462 insertions(+), 14 deletions(-)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index b3528edb387a..9a95355eedf5 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -45,13 +45,13 @@ struct perf_c2c_ext {
 	u64			total_cycles;
 };
 
-static struct perf_c2c_ext c2c_ext __maybe_unused;
+static struct perf_c2c_ext c2c_ext;
 
 struct c2c_function_browser {
 	struct hist_browser	hb;
 };
 
-static inline __maybe_unused u64 c2c_hitm_count(const struct c2c_stats *stats)
+static inline u64 c2c_hitm_count(const struct c2c_stats *stats)
 {
 	return stats->tot_hitm;
 }
@@ -86,7 +86,7 @@ static int64_t c2c_function_cmp(const struct map_symbol *left,
 	return _sort__sym_cmp(left->sym, right->sym);
 }
 
-static inline __maybe_unused u64 hist_entry__iaddr(struct hist_entry *he)
+static inline u64 hist_entry__iaddr(struct hist_entry *he)
 {
 	if (he->mem_info)
 		return mem_info__iaddr(he->mem_info)->addr;
@@ -219,7 +219,7 @@ static u64 c2c_hist_entry__cycles(struct c2c_hist_entry *c2c_he)
 }
 
 /* Sum c2c_hist_entry__cycles() across all level-1 entries. */
-static u64 __maybe_unused c2c_ext__total_cycles(void)
+static u64 c2c_ext__total_cycles(void)
 {
 	struct rb_node *nd;
 	u64 total = 0;
@@ -662,7 +662,7 @@ function_hpp_list__parse(struct perf_hpp_list *hpp_list,
 	return ret;
 }
 
-static int __maybe_unused
+static int
 c2c_function_hists__init(struct c2c_hists *hists,
 			 const char *sort,
 			 int nr_header_lines,
@@ -677,7 +677,7 @@ c2c_function_hists__init(struct c2c_hists *hists,
 	return function_hpp_list__parse(&hists->list, /*output=*/NULL, sort, env);
 }
 
-static int __maybe_unused
+static int
 c2c_function_hists__reinit(struct c2c_hists *c2c_hists,
 			   const char *output,
 			   const char *sort,
@@ -726,8 +726,8 @@ static void c2c_stats_merge(struct stats *dest, const struct stats *src)
 }
 
 /* Merge compute_stats during function aggregation. */
-static void __maybe_unused c2c_add_cstats(struct compute_stats *dest,
-					  const struct compute_stats *src)
+static void c2c_add_cstats(struct compute_stats *dest,
+			   const struct compute_stats *src)
 {
 	c2c_stats_merge(&dest->rmt_hitm, &src->rmt_hitm);
 	c2c_stats_merge(&dest->lcl_hitm, &src->lcl_hitm);
@@ -736,8 +736,8 @@ static void __maybe_unused c2c_add_cstats(struct compute_stats *dest,
 	c2c_stats_merge(&dest->load, &src->load);
 }
 
-static bool __maybe_unused hist_entry__add_c2c_stats(struct hist_entry *he,
-						     const struct c2c_stats *stats)
+static bool hist_entry__add_c2c_stats(struct hist_entry *he,
+				      const struct c2c_stats *stats)
 {
 	u64 nr_events = c2c_hitm_count(stats) + stats->rmt_peer + stats->lcl_peer;
 	u64 weight1 = c2c_hitm_count(stats);
@@ -859,7 +859,7 @@ static void c2c_he__free_hierarchy(struct hist_entry *he)
  * line, so this is mainly a safety net. Returns the number of surviving
  * writers.
  */
-static int __maybe_unused c2c_he__prune_empty_writers(struct hist_entry *l1_he)
+static int c2c_he__prune_empty_writers(struct hist_entry *l1_he)
 {
 	struct rb_node *nd;
 	int surviving = 0;
@@ -981,7 +981,7 @@ c2c_child_entry__insert(struct hist_entry *parent_he, struct hist_entry *child_h
 	parent_he->leaf = false;
 }
 
-static __maybe_unused struct hist_entry *
+static struct hist_entry *
 c2c_function_hists__level1_entry(struct symbol *sym,
 				 struct hist_entry *detail_he,
 				 struct thread *synthetic_thread)
@@ -1057,7 +1057,7 @@ c2c_function_hists__level1_entry(struct symbol *sym,
  * sort semantics. All code addresses and cachelines for the same writer
  * function aggregate into one row.
  */
-static __maybe_unused struct c2c_hist_entry *
+static struct c2c_hist_entry *
 c2c_function_hists__level2_entry(struct c2c_hist_entry *level1_c2c,
 				 struct symbol *sym, struct hist_entry *detail_he)
 {
@@ -1105,7 +1105,7 @@ c2c_function_hists__level2_entry(struct c2c_hist_entry *level1_c2c,
 }
 
 /* Level 3: one source cacheline where the L1/L2 functions contend. */
-static __maybe_unused struct c2c_hist_entry *
+static struct c2c_hist_entry *
 c2c_function_hists__level3_entry(struct c2c_hist_entry *level2_c2c,
 				 struct c2c_hist_entry *cacheline_src_he)
 {
@@ -1143,6 +1143,454 @@ c2c_function_hists__level3_entry(struct c2c_hist_entry *level2_c2c,
 	return level3_c2c;
 }
 
+/*
+ * Re-sort child entries of @parent_he by total store count, descending.
+ */
+static void c2c_he__resort_by_stores(struct hist_entry *parent_he)
+{
+	struct rb_root_cached new_root = RB_ROOT_CACHED;
+	struct rb_node *nd;
+
+	if (!parent_he->has_children)
+		return;
+
+	/* Extract all nodes and re-insert sorted by displayed store count */
+	while ((nd = rb_first_cached(&parent_he->hroot_out))) {
+		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
+		u64 he_store = hist_entry__displayed_stores(he);
+		struct rb_node **p = &new_root.rb_root.rb_node;
+		struct rb_node *parent = NULL;
+		bool leftmost = true;
+		int cmp;
+
+		/* Remove from current tree */
+		rb_erase_cached(&he->rb_node, &parent_he->hroot_out);
+
+		/*
+		 * Insert sorted by store count, descending. Use the displayed
+		 * store count so a level-1 function and level-2 writer (whose own
+		 * stats.store is 0 / partial) sort by the aggregated write traffic
+		 * beneath them, not by their own store field.
+		 */
+		while (*p) {
+			struct hist_entry *iter = rb_entry(*p, struct hist_entry, rb_node);
+			u64 iter_store = hist_entry__displayed_stores(iter);
+
+			parent = *p;
+			if (he_store != iter_store) {
+				cmp = he_store > iter_store ? -1 : 1;
+			} else {
+				/* Stable tie-break: instruction address, name, then cacheline. */
+				u64 a = hist_entry__iaddr(he), b = hist_entry__iaddr(iter);
+
+				if (a != b)
+					cmp = a < b ? -1 : 1;
+				else if (he->ms.sym && iter->ms.sym)
+					cmp = strcmp(he->ms.sym->name,
+						     iter->ms.sym->name);
+				else
+					cmp = (iter->ms.sym ? 1 : 0) - (he->ms.sym ? 1 : 0);
+
+				if (!cmp) {
+					struct c2c_hist_entry *he_c2c;
+					struct c2c_hist_entry *iter_c2c;
+
+					he_c2c = container_of(he, struct c2c_hist_entry, he);
+					iter_c2c = container_of(iter, struct c2c_hist_entry, he);
+					if (he_c2c->cacheline_idx != iter_c2c->cacheline_idx)
+						cmp = he_c2c->cacheline_idx <
+						      iter_c2c->cacheline_idx ? -1 : 1;
+				}
+			}
+
+			if (cmp < 0) {
+				p = &parent->rb_left;
+			} else {
+				p = &parent->rb_right;
+				leftmost = false;
+			}
+		}
+
+		rb_link_node(&he->rb_node, parent, p);
+		rb_insert_color_cached(&he->rb_node, &new_root, leftmost);
+	}
+
+	parent_he->hroot_out = new_root;
+}
+
+/* Initial per-cacheline capacity for the seen[] set; grown on demand. */
+#define DEFAULT_SYMBOLS_PER_CL 64
+
+struct function_seen {
+	struct map_symbol ms;
+};
+
+static bool function_seen__find(const struct function_seen *seen, int nr,
+				const struct map_symbol *ms)
+{
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		if (!c2c_function_cmp(&seen[i].ms, ms))
+			return true;
+	}
+	return false;
+}
+
+/* Aggregate stats from the cacheline-side entry @c2c_b into level 2/3 @dst. */
+static bool c2c_he__add_sharing(struct c2c_hist_entry *dst, struct c2c_hist_entry *src)
+{
+	/* Do the fallible update first so a failure leaves dst unmodified. */
+	if (!hist_entry__add_c2c_stats(&dst->he, &src->stats))
+		return false;
+
+	c2c_add_stats(&dst->stats, &src->stats);
+	c2c_add_cstats(&dst->cstats, &src->cstats);
+	return true;
+}
+
+/*
+ * Process one cacheline: for every function reading it, create/update its
+ * level-1 function entry, then for each function that writes the line
+ * add it as a level-2 writer and add this cacheline as a level-3 child.
+ */
+static int c2c_function__process_cl(struct c2c_hist_entry *cacheline_he,
+				    struct thread *synthetic_thread)
+{
+	struct rb_node *nd_a, *nd_b;
+	struct function_seen *seen = NULL;
+	int nr_seen = 0, nr_alloc = 0;
+	int ret = 0;
+
+	for (nd_a = rb_first_cached(&cacheline_he->hists->hists.entries); nd_a;
+	     nd_a = rb_next(nd_a)) {
+		struct hist_entry *he_a = rb_entry(nd_a, struct hist_entry, rb_node);
+		struct c2c_hist_entry *c2c_a;
+		struct hist_entry *level1_he;
+		struct c2c_hist_entry *level1_c2c;
+
+		if (!he_a->ms.sym || he_a->filtered)
+			continue;
+
+		c2c_a = container_of(he_a, struct c2c_hist_entry, he);
+		if (c2c_a->stats.load == 0)
+			continue;
+
+		level1_he = c2c_function_hists__level1_entry(he_a->ms.sym,
+							     he_a, synthetic_thread);
+		if (!level1_he) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		level1_c2c = container_of(level1_he, struct c2c_hist_entry, he);
+
+		/*
+		 * Aggregate every source entry into its level-1 function parent.
+		 * level1_he is keyed by symbol, so all code addresses inside the
+		 * same function collapse into one parent. When the cacheline view
+		 * splits a function into siblings (different code addresses, or
+		 * --coalesce pid/tid/dso), each sibling holds a DISJOINT slice of the
+		 * traffic, so summing them here is correct accumulation, not
+		 * double counting. The seen[] set below therefore guards only the
+		 * subtree build (to avoid building a function's level-2/3 subtree
+		 * twice for the same cacheline), never this L1 update. Update
+		 * he->stat first; on failure leave the aggregates untouched.
+		 */
+		if (!hist_entry__add_c2c_stats(level1_he, &c2c_a->stats)) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		c2c_add_stats(&level1_c2c->stats, &c2c_a->stats);
+		c2c_add_cstats(&level1_c2c->cstats, &c2c_a->cstats);
+		c2c_add_stats(&c2c_ext.function_hists.stats, &c2c_a->stats);
+
+		/* Build this function's subtree for this cacheline only once. */
+		if (function_seen__find(seen, nr_seen, &he_a->ms))
+			continue;
+
+		if (nr_seen == nr_alloc) {
+			struct function_seen *tmp;
+			int new_alloc = nr_alloc ? nr_alloc * 2 : DEFAULT_SYMBOLS_PER_CL;
+
+			tmp = reallocarray(seen, new_alloc, sizeof(*seen));
+			if (!tmp) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			seen = tmp;
+			nr_alloc = new_alloc;
+		}
+		seen[nr_seen].ms = he_a->ms;
+		nr_seen++;
+
+		for (nd_b = rb_first_cached(&cacheline_he->hists->hists.entries); nd_b;
+		     nd_b = rb_next(nd_b)) {
+			struct hist_entry *he_b = rb_entry(nd_b, struct hist_entry, rb_node);
+			struct c2c_hist_entry *c2c_b, *level2_c2c, *level3_c2c;
+
+			if (!he_b->ms.sym || he_b->filtered)
+				continue;
+
+			c2c_b = container_of(he_b, struct c2c_hist_entry, he);
+
+			/*
+			 * The level-1 function contributes read-side load weight for this
+			 * cacheline. Associate it with functions sampled storing to the
+			 * same line.
+			 * The writer can be the same function; after detail coalescing and
+			 * function-level grouping there is not enough identity to attribute
+			 * that case to a specific thread.
+			 * Only writers are contending functions, so keep the ones
+			 * that actually store into the line.
+			 */
+			if (c2c_b->stats.store == 0)
+				continue;
+
+			/* Level 2: the writing function (aggregated across cachelines). */
+			level2_c2c = c2c_function_hists__level2_entry(level1_c2c, he_b->ms.sym,
+								      he_b);
+			if (!level2_c2c || !c2c_he__add_sharing(level2_c2c, c2c_b)) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			/* Level 3: the specific cacheline they contend over. */
+			level3_c2c = c2c_function_hists__level3_entry(level2_c2c,
+								      cacheline_he);
+			if (!level3_c2c || !c2c_he__add_sharing(level3_c2c, c2c_b)) {
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+	}
+
+out:
+	free(seen);
+	return ret;
+}
+
+/*
+ * Remove a level-1 function that has no contended cachelines left. It is a
+ * normal (owned) hist_entry in function_hists, so mirror hists__delete_entry()
+ * for the no-collapse case: unlink from both trees, fix the counters, then
+ * delete. report_hierarchy is never set and its hroot_out is already empty, so
+ * hist_entry__delete() will not recurse into borrowed children.
+ */
+static void c2c_function__drop_level1(struct hist_entry *he)
+{
+	struct hists *hists = &c2c_ext.function_hists.hists;
+
+	rb_erase_cached(&he->rb_node_in, hists->entries_in);
+	rb_erase_cached(&he->rb_node, &hists->entries);
+
+	--hists->nr_entries;
+	if (!he->filtered)
+		--hists->nr_non_filtered_entries;
+
+	hist_entry__delete(he);
+}
+
+/* Length of the identity text (symbol name or cacheline address) at @he. */
+static int c2c_function__ident_len(struct hist_entry *he)
+{
+	char buf[512];
+	char *symbuf;
+	size_t size;
+	int len;
+
+	if (hist_entry__is_cacheline(he)) {
+		u64 addr = he->mem_info ?
+			cl_address(mem_info__daddr(he->mem_info)->addr, chk_double_cl) : 0;
+
+		return scnprintf(buf, sizeof(buf), "0x%" PRIx64, addr);
+	}
+
+	if (!he->ms.sym)
+		return 0;
+
+	/*
+	 * Match symbol_view_entry(): sort_sym adds the cpumode prefix and, in
+	 * verbose mode, the address and DSO origin before the symbol name.
+	 */
+	size = strlen(he->ms.sym->name) + 64;
+	symbuf = malloc(size);
+	if (!symbuf)
+		return size - 1;
+
+	len = sort_sym.se_snprintf(he, symbuf, size, size - 1);
+	free(symbuf);
+	return len;
+}
+
+/*
+ * Grow the symbol column so the deepest, longest identity cell fits. The
+ * generic hists__calc_col_len() only measures the top-level (L1) entries; the
+ * hand-linked L2 writers and L3 cacheline addresses live in hroot_out and are
+ * never measured, so with a short L1 name the indented L2/L3 text would be
+ * truncated. Account for the per-level indent and the folded-sign prefix.
+ */
+static void c2c_function__update_symbol_width(struct hist_entry *he)
+{
+	struct hists *hists = &c2c_ext.function_hists.hists;
+	int need = he->depth * C2C_FUNC_INDENT + C2C_FUNC_FOLD_WIDTH +
+		   c2c_function__ident_len(he);
+
+	if (need > hists__col_len(hists, HISTC_SYMBOL))
+		hists__set_col_len(hists, HISTC_SYMBOL, need);
+}
+
+/*
+ * Prune writers with no stores, drop functions left with no contending
+ * writer, sort the survivors by store count, then compute the global total.
+ */
+static void c2c_function__finalize(void)
+{
+	struct rb_node *nd_l1;
+
+	nd_l1 = rb_first_cached(&c2c_ext.function_hists.hists.entries);
+	while (nd_l1) {
+		struct hist_entry *he_l1 = rb_entry(nd_l1, struct hist_entry, rb_node);
+		struct rb_node *next_l1 = rb_next(nd_l1);
+		struct rb_node *nd_l2;
+
+		/* Drop writers with no stores before sorting. */
+		if (!he_l1->has_children || !c2c_he__prune_empty_writers(he_l1)) {
+			/* No contending writer: this function is not shared. */
+			c2c_function__drop_level1(he_l1);
+			nd_l1 = next_l1;
+			continue;
+		}
+
+		c2c_he__resort_by_stores(he_l1);
+		c2c_function__update_symbol_width(he_l1);
+
+		for (nd_l2 = rb_first_cached(&he_l1->hroot_out); nd_l2;
+		     nd_l2 = rb_next(nd_l2)) {
+			struct hist_entry *he_l2 = rb_entry(nd_l2, struct hist_entry, rb_node);
+			struct rb_node *nd_l3;
+
+			c2c_function__update_symbol_width(he_l2);
+
+			if (he_l2->has_children)
+				c2c_he__resort_by_stores(he_l2);
+
+			for (nd_l3 = rb_first_cached(&he_l2->hroot_out); nd_l3;
+			     nd_l3 = rb_next(nd_l3)) {
+				struct hist_entry *he_l3 = rb_entry(nd_l3, struct hist_entry,
+								    rb_node);
+
+				c2c_function__update_symbol_width(he_l3);
+			}
+		}
+
+		nd_l1 = next_l1;
+	}
+
+	c2c_ext.total_cycles = c2c_ext__total_cycles();
+}
+
+/*
+ * Release all per-visit function-view state. Keep the hists object itself
+ * initialized so its mutex is initialized exactly once across TAB re-entry.
+ */
+static void c2c_function_hists__reset(void)
+{
+	hists__delete_all_entries(&c2c_ext.function_hists.hists);
+	if (c2c_ext.function_hists.list.fields.next)
+		perf_hpp__reset_output_field(&c2c_ext.function_hists.list);
+
+	memset(&c2c_ext.function_hists.stats, 0,
+	       sizeof(c2c_ext.function_hists.stats));
+	c2c_ext.total_cycles = 0;
+}
+
+/*
+ * Build the three-level function view in a single pass over the cacheline
+ * entries:
+ *   L1: read-side functions (aggregated across all their code addresses)
+ *   L2: writing functions contending with each level-1 function
+ *   L3: shared cachelines for each function pair
+ */
+static int __maybe_unused build_function_view_hierarchy(void)
+{
+	static const char output_fields[] =
+		"cycles_percent,total_stores,symbol_view";
+	static bool hists_initialized;
+	struct rb_node *nd_cl;
+	int ret;
+
+	c2c_function_hists__reset();
+
+	/*
+	 * __hists__init() (called by c2c_function_hists__init()) also
+	 * mutex_init()s the hists lock, so only run it once for this static
+	 * hists; on re-entry just re-parse the columns via reinit().
+	 */
+	if (!hists_initialized) {
+		ret = c2c_function_hists__init(&c2c_ext.function_hists,
+					       "symbol_view", 2, NULL);
+		hists_initialized = true;
+	} else {
+		ret = c2c_function_hists__reinit(&c2c_ext.function_hists,
+						 /*output=*/NULL, "symbol_view", NULL);
+	}
+	if (ret)
+		return ret;
+
+	nd_cl = rb_first_cached(&c2c.hists.hists.entries);
+
+	/* An empty C2C report yields an empty (but valid) function view. */
+	for (; nd_cl; nd_cl = rb_next(nd_cl)) {
+		struct hist_entry *he_cl = rb_entry(nd_cl, struct hist_entry, rb_node);
+		struct c2c_hist_entry *cacheline_he = container_of(he_cl,
+								   struct c2c_hist_entry, he);
+		struct thread *synthetic_thread = he_cl->thread;
+
+		/*
+		 * Detail hists are finalized only for cachelines retained by the
+		 * top-level C2C filter. Among those, include any line with sharing
+		 * activity, not just HITM.
+		 */
+		if (he_cl->filtered ||
+		    (c2c_hitm_count(&cacheline_he->stats) == 0 &&
+		     cacheline_he->stats.tot_peer == 0 &&
+		     cacheline_he->stats.store == 0 &&
+		     cacheline_he->stats.load == 0) ||
+		    !cacheline_he->hists ||
+		    RB_EMPTY_ROOT(&cacheline_he->hists->hists.entries.rb_root) ||
+		    !he_cl->mem_info || !synthetic_thread)
+			continue;
+
+		ret = c2c_function__process_cl(cacheline_he, synthetic_thread);
+		if (ret)
+			goto out_err;
+	}
+
+	ret = c2c_function_hists__reinit(&c2c_ext.function_hists, output_fields,
+					 "cycles_percent", NULL);
+	if (ret)
+		goto out_err;
+
+	hists__collapse_resort(&c2c_ext.function_hists.hists, NULL);
+	hists__output_resort(&c2c_ext.function_hists.hists, NULL);
+
+	c2c_function__finalize();
+
+	return 0;
+
+out_err:
+	/*
+	 * On error, migrate any entries still in entries_in to entries and
+	 * delete them, so a later rebuild does not strand them (the top-level
+	 * __hists__init() memset would otherwise lose the pointers).
+	 */
+	hists__collapse_resort(&c2c_ext.function_hists.hists, NULL);
+	hists__output_resort(&c2c_ext.function_hists.hists, NULL);
+	c2c_function_hists__reset();
+	return ret;
+}
+
 int perf_c2c__browse_function_view(void)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

