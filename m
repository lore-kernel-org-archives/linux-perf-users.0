Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D03F1AD3;
	Fri, 10 Jul 2026 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673008; cv=none; b=LVT8zK6eJrBxV0Y7KrV1HPVm9CMPGYegPzun4xqdi/7N9z4+mNQ9yH8/xcMJJwPXM3ootd+KlIbrOOg81DXDoCWWOKBUxhiArFiRZbEel31uF41ACDQTskP+oGrtjIyJAPxNJALlLneKJlvO3KRLr6SPOz4MH/a0F9RTmigv8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673008; c=relaxed/simple;
	bh=bjAW978TZziWCNCdY4GRXx5+wARYRW24uxSfANqv9wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIA3zMvbWhPmTX8eMk49eM93YURgch0H5kplFkv/iA9tusWCG/gZR61kOnItFN+q2UuHrqSiNI59qfU6GrxZFK7coQXBjV3wl92fiHUlFbOkxIABsTfP381xEridPY/mENnFyQWLV4AAlfr4lGgWq3aqfSwSnFrOxsqEg7jxHK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QY2iLuw3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QY2iLuw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783673007; x=1815209007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bjAW978TZziWCNCdY4GRXx5+wARYRW24uxSfANqv9wg=;
  b=QY2iLuw3HXjWSNpLUkZ0TIeknkeYbh/xLyoPyKomxF5tFoNyMGrlnzah
   LYbT6uUJud1+7uQOVwd/j2GwN7CHOT0NP3Jt2vawCkjUmZIyI3Q2klH/R
   OvRVLwRlRQzEfC1IvNfv0VDNGNaZyEmaKVFELpDGeIbANjgINBUlQY4sQ
   n22Pa5Jej7rctAYCA7YzF8Amm/XRM8cNk1beHM8kjfb3n5rwNibw2k3me
   sDEMW7tzyqlJgDYzrTK+k6clVOUVQiCHksm0lCOLxIqPFYGW05jK3Akep
   37ZqbLYaY+uvdSOB/87nXK681VzGp7hfb9Jv41WHMPxBPO2DsIoltLW5R
   A==;
X-CSE-ConnectionGUID: cUW8XOWaQjSEv+kcojf56w==
X-CSE-MsgGUID: JkXpXXshTRenaRM+9aZmxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390877"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390877"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:43:26 -0700
X-CSE-ConnectionGUID: ACfqkGSuRfW+kV1xDYn3lQ==
X-CSE-MsgGUID: 9Sz+b3hsTqy73aF1JM9FBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435445"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:43:21 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>
Subject: [PATCH v2 11/14] perf c2c: add function view hierarchy builder
Date: Fri, 10 Jul 2026 16:42:44 +0800
Message-ID: <20260710084247.3576706-12-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260710084247.3576706-1-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260710084247.3576706-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the core algorithm that constructs the 3-level function view:

- c2c_he__resort_by_stores(): re-sort children by store count
- build_function_view_hierarchy(): single-pass hierarchy construction

The builder traverses all cacheline entries and for each pair of
functions (A, B) sharing a cacheline:
  1. Creates/finds Level 1 entry for function A
  2. Creates/finds Level 2 entry for function B under A
  3. Creates/finds Level 3 cacheline entry under B
  4. Aggregates C2C stats at all levels

After construction, it configures output columns, sorts Level 1
by cycles percentage, and re-sorts Level 2/3 by store count.

A per-cacheline set (function_seen[], heap-allocated and grown on
demand) tracks already-processed functions to prevent duplicate parent
processing when the same function appears multiple times within a
single cacheline.

Remove __maybe_unused from all helper functions now called by
the hierarchy builder.

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
 tools/perf/ui/browsers/c2c-function.c | 375 ++++++++++++++++++++++++--
 1 file changed, 357 insertions(+), 18 deletions(-)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 47d6fdf66b47..80e032d5e31c 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <stdlib.h>
+#include <tools/libc_compat.h> /* reallocarray */
 #include <string.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
@@ -49,17 +50,17 @@ struct c2c_function_browser {
 	struct hist_browser	hb;
 };
 
-static __maybe_unused inline u64 c2c_hitm_count(const struct c2c_stats *stats)
+static inline u64 c2c_hitm_count(const struct c2c_stats *stats)
 {
 	return stats->tot_hitm;
 }
 
-static __maybe_unused inline bool symbol_name_equal(struct symbol *a, struct symbol *b)
+static inline bool symbol_name_equal(struct symbol *a, struct symbol *b)
 {
 	return a && b && arch__compare_symbol_names(a->name, b->name) == 0;
 }
 
-static __maybe_unused inline u64 hist_entry__iaddr(struct hist_entry *he)
+static inline u64 hist_entry__iaddr(struct hist_entry *he)
 {
 	if (he->mem_info)
 		return mem_info__iaddr(he->mem_info)->addr;
@@ -137,22 +138,34 @@ static int c2c_header(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
  * Return the estimated total cycles for a c2c_hist_entry
  * (rmt_hitm + lcl_hitm + rmt_peer + lcl_peer + other loads).
  */
-static __maybe_unused u64 c2c_hist_entry__cycles(struct c2c_hist_entry *c2c_he)
+static u64 c2c_hist_entry__cycles(struct c2c_hist_entry *c2c_he)
 {
-	double cycles_rmt, cycles_lcl, cycles_load;
-	u64 other_load, total_hitm;
+	double cycles_rmt, cycles_lcl, cycles_rmt_peer, cycles_lcl_peer, cycles_load;
+	u64 categorized, other_load;
 
+	/*
+	 * compute_stats() in builtin-c2c.c assigns each load sample to exactly
+	 * one cstats bucket (rmt_hitm, lcl_hitm, rmt_peer, lcl_peer or load),
+	 * while stats.load counts every load. Weight each category by its own
+	 * average and treat only the uncategorized remainder as plain loads, so
+	 * peer-snoop cycles are neither dropped nor charged the load average.
+	 */
 	cycles_rmt = avg_stats(&c2c_he->cstats.rmt_hitm) * c2c_he->stats.rmt_hitm;
 	cycles_lcl = avg_stats(&c2c_he->cstats.lcl_hitm) * c2c_he->stats.lcl_hitm;
-	total_hitm = c2c_he->stats.tot_hitm;
-	other_load = (c2c_he->stats.load >= total_hitm) ? c2c_he->stats.load - total_hitm : 0;
+	cycles_rmt_peer = avg_stats(&c2c_he->cstats.rmt_peer) * c2c_he->stats.rmt_peer;
+	cycles_lcl_peer = avg_stats(&c2c_he->cstats.lcl_peer) * c2c_he->stats.lcl_peer;
+
+	categorized = (u64)c2c_he->stats.tot_hitm + c2c_he->stats.tot_peer;
+	other_load = (c2c_he->stats.load >= categorized) ?
+		     c2c_he->stats.load - categorized : 0;
 	cycles_load = avg_stats(&c2c_he->cstats.load) * other_load;
 
-	return (u64)(cycles_rmt + cycles_lcl + cycles_load);
+	return (u64)(cycles_rmt + cycles_lcl + cycles_rmt_peer +
+		     cycles_lcl_peer + cycles_load);
 }
 
 /* Sum c2c_hist_entry__cycles() across all level-1 entries. */
-static __maybe_unused u64 c2c_ext__total_cycles(void)
+static u64 c2c_ext__total_cycles(void)
 {
 	struct rb_node *nd;
 	u64 total = 0;
@@ -172,7 +185,7 @@ static __maybe_unused u64 c2c_ext__total_cycles(void)
  * Read from the cache populated by the hierarchy builder, so this is O(1)
  * and safe to call from the sort comparator.
  */
-static __maybe_unused u64 hist_entry__child_stores(struct hist_entry *he)
+static u64 hist_entry__child_stores(struct hist_entry *he)
 {
 	struct c2c_hist_entry *c2c_he = container_of(he, struct c2c_hist_entry, he);
 
@@ -625,7 +638,7 @@ function_hpp_list__parse(struct perf_hpp_list *hpp_list,
 	return ret;
 }
 
-static __maybe_unused int
+static int
 c2c_function_hists__init(struct c2c_hists *hists,
 			 const char *sort,
 			 int nr_header_lines,
@@ -640,7 +653,7 @@ c2c_function_hists__init(struct c2c_hists *hists,
 	return function_hpp_list__parse(&hists->list, /*output=*/NULL, sort, env);
 }
 
-static __maybe_unused int
+static int
 c2c_function_hists__reinit(struct c2c_hists *c2c_hists,
 			   const char *output,
 			   const char *sort,
@@ -691,7 +704,7 @@ static void c2c_stats_merge(struct stats *dest, const struct stats *src)
 }
 
 /* Merge compute_stats during function aggregation. */
-static __maybe_unused void c2c_add_cstats(struct compute_stats *dest,
+static void c2c_add_cstats(struct compute_stats *dest,
 			   const struct compute_stats *src)
 {
 	c2c_stats_merge(&dest->rmt_hitm, &src->rmt_hitm);
@@ -701,7 +714,7 @@ static __maybe_unused void c2c_add_cstats(struct compute_stats *dest,
 	c2c_stats_merge(&dest->load, &src->load);
 }
 
-static __maybe_unused bool hist_entry__add_c2c_stats(struct hist_entry *he,
+static bool hist_entry__add_c2c_stats(struct hist_entry *he,
 				      const struct c2c_stats *stats)
 {
 	u64 nr_events = c2c_hitm_count(stats) + stats->rmt_peer + stats->lcl_peer;
@@ -901,7 +914,7 @@ c2c_child_entry__insert(struct hist_entry *parent_he, struct hist_entry *child_h
 	parent_he->leaf = false;
 }
 
-static __maybe_unused struct hist_entry *
+static struct hist_entry *
 c2c_function_hists__level1_entry(struct symbol *sym, u64 iaddr,
 				 struct hist_entry *detail_he,
 				 struct thread *synthetic_thread)
@@ -963,7 +976,7 @@ c2c_function_hists__level1_entry(struct symbol *sym, u64 iaddr,
 	return he;
 }
 
-static __maybe_unused struct c2c_hist_entry *
+static struct c2c_hist_entry *
 c2c_function_hists__level2_entry(struct c2c_hist_entry *level1_c2c,
 				 struct symbol *sym, u64 iaddr,
 				 struct hist_entry *detail_he)
@@ -1029,7 +1042,7 @@ c2c_function_hists__level2_entry(struct c2c_hist_entry *level1_c2c,
 	return level2_c2c;
 }
 
-static __maybe_unused struct c2c_hist_entry *
+static struct c2c_hist_entry *
 c2c_function_hists__level3_entry(struct c2c_hist_entry *level2_c2c, u64 cl_addr,
 				 struct c2c_hist_entry *cacheline_src_he)
 {
@@ -1070,6 +1083,332 @@ c2c_function_hists__level3_entry(struct c2c_hist_entry *level2_c2c, u64 cl_addr,
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
+	/* Extract all nodes and re-insert sorted by total_stores */
+	while ((nd = rb_first_cached(&parent_he->hroot_out))) {
+		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
+		struct c2c_hist_entry *c2c_he = container_of(he, struct c2c_hist_entry, he);
+		struct rb_node **p = &new_root.rb_root.rb_node;
+		struct rb_node *parent = NULL;
+		bool leftmost = true;
+		int cmp;
+
+		/* Remove from current tree */
+		rb_erase_cached(&he->rb_node, &parent_he->hroot_out);
+
+		/* Insert sorted by store count, descending. */
+		while (*p) {
+			struct hist_entry *iter = rb_entry(*p, struct hist_entry, rb_node);
+			struct c2c_hist_entry *c2c_iter = container_of(iter,
+								       struct c2c_hist_entry,
+								       he);
+
+			parent = *p;
+			if (c2c_he->stats.store != c2c_iter->stats.store) {
+				cmp = c2c_he->stats.store > c2c_iter->stats.store ? -1 : 1;
+			} else {
+				/* Stable tie-break: instruction address, then name. */
+				u64 a = hist_entry__iaddr(he), b = hist_entry__iaddr(iter);
+
+				if (a != b)
+					cmp = a < b ? -1 : 1;
+				else if (he->ms.sym && iter->ms.sym)
+					cmp = arch__compare_symbol_names(he->ms.sym->name,
+									 iter->ms.sym->name);
+				else
+					cmp = (iter->ms.sym ? 1 : 0) - (he->ms.sym ? 1 : 0);
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
+	struct symbol	*sym;
+	u64		 iaddr;
+};
+
+static bool function_seen__find(const struct function_seen *seen, int nr,
+				struct symbol *sym, u64 iaddr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		if (seen[i].iaddr == iaddr &&
+		    symbol_name_equal(seen[i].sym, sym))
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
+ * Process one cacheline and create/update the level-1/2/3 hierarchy entries
+ * for every pair of functions sharing it.
+ */
+static int c2c_function__process_cl(struct c2c_hist_entry *cacheline_he, u64 cl_addr,
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
+		u64 iaddr_a;
+
+		if (!he_a->ms.sym || he_a->filtered)
+			continue;
+
+		c2c_a = container_of(he_a, struct c2c_hist_entry, he);
+		iaddr_a = hist_entry__iaddr(he_a);
+
+		level1_he = c2c_function_hists__level1_entry(he_a->ms.sym, iaddr_a,
+							     he_a, synthetic_thread);
+		if (!level1_he) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		level1_c2c = container_of(level1_he, struct c2c_hist_entry, he);
+
+		/*
+		 * Aggregate every source entry into its level-1 (sym, iaddr)
+		 * parent. level1_he is keyed by (sym, iaddr), so all siblings
+		 * collapse into the same parent. When the cacheline view splits
+		 * one (sym, iaddr) into siblings (only under -d pid/tid/dso),
+		 * each sibling holds a DISJOINT slice of the traffic, so summing
+		 * them here is correct accumulation, not double counting. The
+		 * seen[] set below therefore guards only the inner B-loop (to
+		 * avoid building a level-2 subtree twice), never this L1 update.
+		 * Update he->stat first; on failure leave the aggregates untouched.
+		 */
+		if (!hist_entry__add_c2c_stats(level1_he, &c2c_a->stats)) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		c2c_add_stats(&level1_c2c->stats, &c2c_a->stats);
+		c2c_add_cstats(&level1_c2c->cstats, &c2c_a->cstats);
+		c2c_add_stats(&c2c_ext.function_hists.stats, &c2c_a->stats);
+
+		/* Skip the inner loop when this (symbol, iaddr) is already a parent. */
+		if (function_seen__find(seen, nr_seen, he_a->ms.sym, iaddr_a))
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
+		seen[nr_seen].sym = he_a->ms.sym;
+		seen[nr_seen].iaddr = iaddr_a;
+		nr_seen++;
+
+		for (nd_b = rb_first_cached(&cacheline_he->hists->hists.entries); nd_b;
+		     nd_b = rb_next(nd_b)) {
+			struct hist_entry *he_b = rb_entry(nd_b, struct hist_entry, rb_node);
+			struct c2c_hist_entry *c2c_b, *level2_c2c, *level3_c2c;
+			u64 iaddr_b;
+
+			if (!he_b->ms.sym || he_b->filtered)
+				continue;
+
+			c2c_b = container_of(he_b, struct c2c_hist_entry, he);
+			iaddr_b = hist_entry__iaddr(he_b);
+
+			/* Skip self. */
+			if (iaddr_a == iaddr_b &&
+			    symbol_name_equal(he_a->ms.sym, he_b->ms.sym))
+				continue;
+
+			level2_c2c = c2c_function_hists__level2_entry(level1_c2c, he_b->ms.sym,
+								      iaddr_b, he_b);
+			if (!level2_c2c || !c2c_he__add_sharing(level2_c2c, c2c_b)) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			/*
+			 * Cache the running sum of level-2 store counts on the
+			 * level-1 parent, mirroring c2c_he__add_sharing() above,
+			 * so hist_entry__child_stores() stays O(1).
+			 */
+			level1_c2c->child_stores += c2c_b->stats.store;
+
+			level3_c2c = c2c_function_hists__level3_entry(level2_c2c, cl_addr,
+								      cacheline_he);
+			if (!level3_c2c) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			if (!c2c_he__add_sharing(level3_c2c, c2c_b)) {
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
+/* Sort level-2/3 children by store count, then compute the global total. */
+static void c2c_function__finalize(void)
+{
+	struct rb_node *nd_l1;
+
+	for (nd_l1 = rb_first_cached(&c2c_ext.function_hists.hists.entries); nd_l1;
+	     nd_l1 = rb_next(nd_l1)) {
+		struct hist_entry *he_l1 = rb_entry(nd_l1, struct hist_entry, rb_node);
+		struct rb_node *nd_l2;
+
+		if (!he_l1->has_children)
+			continue;
+
+		c2c_he__resort_by_stores(he_l1);
+
+		for (nd_l2 = rb_first_cached(&he_l1->hroot_out); nd_l2;
+		     nd_l2 = rb_next(nd_l2)) {
+			struct hist_entry *he_l2 = rb_entry(nd_l2, struct hist_entry, rb_node);
+
+			if (he_l2->has_children)
+				c2c_he__resort_by_stores(he_l2);
+		}
+	}
+
+	c2c_ext.total_cycles = c2c_ext__total_cycles();
+}
+
+/*
+ * Build the three-level function view in a single pass over the cacheline
+ * entries:
+ *   L1: aggregate stats per primary function
+ *   L2: sharing functions referenced from each L1 function
+ *   L3: cachelines that pair L1 with L2
+ */
+static __maybe_unused int build_function_view_hierarchy(void)
+{
+	static const char output_fields[] =
+		"cycles_percent,total_stores,iaddr_symbol,symbol_view,cacheline_symbol";
+	struct rb_node *nd_cl;
+	int ret;
+
+	c2c_ext.total_cycles = 0;
+	memset(&c2c_ext.function_hists.stats, 0,
+	       sizeof(c2c_ext.function_hists.stats));
+
+	hists__delete_entries(&c2c_ext.function_hists.hists);
+	if (c2c_ext.function_hists.list.fields.next)
+		perf_hpp__reset_output_field(&c2c_ext.function_hists.list);
+
+	ret = c2c_function_hists__init(&c2c_ext.function_hists,
+				       "iaddr_symbol,symbol_view", 2, NULL);
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
+		u64 cl_addr;
+
+		/*
+		 * Include any cacheline with sharing activity (HITM, peer,
+		 * stores or loads), not just HITM, so totals/sorting reflect
+		 * all aggregated traffic surfaced by the function view.
+		 */
+		if ((c2c_hitm_count(&cacheline_he->stats) == 0 &&
+		     cacheline_he->stats.tot_peer == 0 &&
+		     cacheline_he->stats.store == 0 &&
+		     cacheline_he->stats.load == 0) ||
+		    !cacheline_he->hists ||
+		    RB_EMPTY_ROOT(&cacheline_he->hists->hists.entries.rb_root) ||
+		    !he_cl->mem_info || !synthetic_thread)
+			continue;
+
+		cl_addr = cl_address(mem_info__daddr(he_cl->mem_info)->addr, chk_double_cl);
+		ret = c2c_function__process_cl(cacheline_he, cl_addr, synthetic_thread);
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
+	hists__delete_entries(&c2c_ext.function_hists.hists);
+	return ret;
+}
+
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

