Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F313F1AC8;
	Fri, 10 Jul 2026 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672998; cv=none; b=AOxzqFIkd/wH7XEA0HSpop283w3ykOR5jbWXDnXZlU6tZsialiNGlPIYV2AuTTydiBeZNj81M8Th/PPNlbAe3yJ+ak6fTDoWCaRgovxFfQkuDoGiHHo1iS/MUEZTWHiwR0/HLt/nb6BEYRjBWtPtQxQiSxspZ6S1HDwF+N9pPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672998; c=relaxed/simple;
	bh=/c03sACpXNnDzjGc0BRBHbnCoiMBhDvHWXmtggqyd18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mltdi4qio/WFVsInfvfRyHcPKLDIJyxzApdFIqoPRjJW2M4yxK3O1jB8dMQOsrmqPbCn0rvVYBi6isvSG7eUAEiARCbxV1gWWARJg/sX5pheOrJ2hkb3jEch8BRCAjFPsiVPhKdqV6b7nev2MnanQ8z7ugeJ+rfdYo7ufUQuLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEbGiYl0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEbGiYl0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783672996; x=1815208996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/c03sACpXNnDzjGc0BRBHbnCoiMBhDvHWXmtggqyd18=;
  b=FEbGiYl0gjEeagx0/KsOvnLo+UkC+TuQKlTcDg0mviY4u8wecDOdLSnk
   zQHrM7YLpkEQlLduMpIHu88UfxB+3gALJn7LKNoauy+QK4YZRxH/+Yfb+
   fBAaP++D61LQ8BZxiPIkSoQ8h9IjVJ9LhXgzMlLxvEZm5h5oQGDSzJR3n
   aP9xvcrP1Yb1T2LLsMeqFz91slYG4LwZQ/JnMCIGe2uF0RmzmxDXOUos5
   3x6J1iIqnTQwS4Epc6Gp3OeKJnC4iEHZ2MJ21BuMS1+xla+JokFcFHpuz
   rVvUMvIZZxASjgxfCIyGNYbEkMxV7kjeX7MtE/AGmMSh4tqui8u4cNAYI
   g==;
X-CSE-ConnectionGUID: SJD7AV9MRYqud5MYwHZEYw==
X-CSE-MsgGUID: cuuzhcgsTqquIauhJoEkgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390859"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390859"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:43:16 -0700
X-CSE-ConnectionGUID: z/F0LUASSdy6k9kj8F2Wdw==
X-CSE-MsgGUID: 3IXcd4ehRJeZBA4hr8xrgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435403"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:43:11 -0700
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
Subject: [PATCH v2 09/14] perf c2c: add stats merging and memory management helpers
Date: Fri, 10 Jul 2026 16:42:42 +0800
Message-ID: <20260710084247.3576706-10-jiebin.sun@intel.com>
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

Add statistics aggregation and memory management functions for
function view histogram entries:

Stats merging:
- c2c_stats_merge(): combine two stats structs (Welford online merge)
- c2c_add_cstats(): merge all compute_stats sub-fields
- hist_entry__add_c2c_stats(): update hist_entry stat counters

Memory management:
- c2c_function_he_free(): free entry and recursively free children
- c2c_he__free_hierarchy(): recursive cleanup of hroot_out tree

Entry allocation reuses c2c_he_zalloc(), which was made shared via
c2c.h in an earlier patch.

These are used during hierarchy construction to allocate entries
and aggregate C2C statistics across cacheline-function pairs.

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
 tools/perf/ui/browsers/c2c-function.c | 158 ++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 0f21cf39f0ce..6afcb1e156c6 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -665,6 +665,164 @@ c2c_function_hists__reinit(struct c2c_hists *c2c_hists,
 	return function_hpp_list__parse(&c2c_hists->list, output, sort, env);
 }
 
+/* Welford online merge of two "stats" (from util/stat.h) accumulators. */
+static void c2c_stats_merge(struct stats *dest, const struct stats *src)
+{
+	double delta;
+
+	if (src->n == 0)
+		return;
+
+	if (dest->n == 0) {
+		*dest = *src;
+		return;
+	}
+
+	delta = src->mean - dest->mean;
+	dest->M2 += src->M2 + delta * delta * dest->n * src->n / (dest->n + src->n);
+	dest->mean = (dest->mean * dest->n + src->mean * src->n) / (dest->n + src->n);
+	dest->n += src->n;
+
+	/* Update min/max */
+	if (src->max > dest->max)
+		dest->max = src->max;
+	if (src->min < dest->min)
+		dest->min = src->min;
+}
+
+/* Merge compute_stats during function aggregation. */
+static __maybe_unused void c2c_add_cstats(struct compute_stats *dest,
+			   const struct compute_stats *src)
+{
+	c2c_stats_merge(&dest->rmt_hitm, &src->rmt_hitm);
+	c2c_stats_merge(&dest->lcl_hitm, &src->lcl_hitm);
+	c2c_stats_merge(&dest->rmt_peer, &src->rmt_peer);
+	c2c_stats_merge(&dest->lcl_peer, &src->lcl_peer);
+	c2c_stats_merge(&dest->load, &src->load);
+}
+
+static __maybe_unused bool hist_entry__add_c2c_stats(struct hist_entry *he,
+				      const struct c2c_stats *stats)
+{
+	u64 nr_events = c2c_hitm_count(stats) + stats->rmt_peer + stats->lcl_peer;
+	u64 weight1 = c2c_hitm_count(stats);
+
+	he->stat.nr_events += nr_events;
+	he->stat.period += nr_events;
+	he->stat.weight1 += weight1;
+
+	if (!symbol_conf.cumulate_callchain)
+		return true;
+
+	if (!he->stat_acc) {
+		he->stat_acc = calloc(1, sizeof(struct he_stat));
+		if (!he->stat_acc)
+			return false;
+	}
+
+	he->stat_acc->nr_events += nr_events;
+	he->stat_acc->period += nr_events;
+	he->stat_acc->weight1 += weight1;
+
+	return true;
+}
+
+static void c2c_he__free_hierarchy(struct hist_entry *he);
+
+/*
+ * Free a function-view histogram entry (hist_entry_ops::free).
+ */
+static void c2c_function_he_free(void *ptr)
+{
+	struct hist_entry *he = ptr;
+	struct c2c_hist_entry *c2c_he;
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+
+	if (c2c_he->hists) {
+		perf_hpp__reset_output_field(&c2c_he->hists->list);
+		hists__delete_all_entries(&c2c_he->hists->hists);
+		zfree(&c2c_he->hists);
+	}
+
+	c2c_he__free_hierarchy(he);
+
+	zfree(&c2c_he->nodeset);
+	zfree(&c2c_he->cpuset);
+	zfree(&c2c_he->nodestr);
+	zfree(&c2c_he->node_stats);
+
+	free(c2c_he);
+}
+
+/*
+ * Free all child entries under @he, recursively (hroot_out sub-tree).
+ *
+ * Children are built by c2c_child_entry__alloc(), which BORROWS thread and
+ * ms (plain copy, no thread__get()/map__get()) and OWNS only mem_info (a
+ * clone), stat_acc and the c2c-specific fields (hists, cpuset, nodeset,
+ * nodestr, node_stats). We therefore must NOT call hist_entry__delete()
+ * here: it would thread__zput()/map_symbol__exit() the borrowed refs and
+ * underflow their refcounts. Free exactly the owned resources instead.
+ */
+static void c2c_he__free_hierarchy(struct hist_entry *he)
+{
+	struct rb_node *nd;
+	struct hist_entry *child_he;
+	struct c2c_hist_entry *child_c2c;
+
+	/*
+	 * Leaf entries alias hroot_out with sorted_chain (callchains) in a
+	 * union, so they have no child hierarchy to free here.
+	 */
+	if (he->leaf)
+		return;
+
+	if (RB_EMPTY_ROOT(&he->hroot_out.rb_root))
+		return;
+
+	nd = rb_first_cached(&he->hroot_out);
+	while (nd) {
+		struct rb_node *next = rb_next(nd);
+
+		child_he = rb_entry(nd, struct hist_entry, rb_node);
+		child_c2c = container_of(child_he, struct c2c_hist_entry, he);
+
+		if (child_he->stat_acc)
+			zfree(&child_he->stat_acc);
+
+		if (child_he->mem_info)
+			mem_info__put(child_he->mem_info);
+
+		if (child_c2c->hists) {
+			perf_hpp__reset_output_field(&child_c2c->hists->list);
+			hists__delete_all_entries(&child_c2c->hists->hists);
+			zfree(&child_c2c->hists);
+		}
+
+		zfree(&child_c2c->cpuset);
+		zfree(&child_c2c->nodeset);
+		zfree(&child_c2c->nodestr);
+		zfree(&child_c2c->node_stats);
+
+		c2c_he__free_hierarchy(child_he);
+
+		rb_erase_cached(&child_he->rb_node, &he->hroot_out);
+		free(child_c2c);
+
+		nd = next;
+	}
+
+	/* All children erased; clear the tree (and its cached leftmost). */
+	he->hroot_out = RB_ROOT_CACHED;
+}
+
+/* Entry operations for function view */
+static struct hist_entry_ops c2c_function_entry_ops __maybe_unused = {
+	.new	= c2c_he_zalloc,
+	.free	= c2c_function_he_free,
+};
+
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

