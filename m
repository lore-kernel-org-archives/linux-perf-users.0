Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309BA3FADE0;
	Fri, 24 Jul 2026 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886744; cv=none; b=U1HKHalEPDnFz+I3ldrWSLdIQgRDlj3EgAagVA+GzlSlTivGslwssxQKRGWQLyGky5FBEEkO5AfQhxS2CGjouebmMWqnuWSYlmc+Wa6gVwSbVfJvXbdeHvVmzO2IQWrk/inbLr3sGDwNG3yDGkFjCSY7QtoldiHe7vciad97dvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886744; c=relaxed/simple;
	bh=CIDMAFHYlr59s82yhXhANsAdtCPzJ8b3nMa11+26oFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jReUsbwMcfgUGlQ1PGxHah0L/g5DthD8Qu3nwWXIDLP3wQqsvatqAtwvm0d2Z2NWTc2eubUuyGnqJAsPNsvcU4sEzyBFF9DH16JUlfVwBTObCqSGJz7aus68wjvXFbUAewnF5wArR/2aN3ma3QtoXuiGjW9hx19TM39LqsWqOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5E1fET4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5E1fET4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784886744; x=1816422744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIDMAFHYlr59s82yhXhANsAdtCPzJ8b3nMa11+26oFo=;
  b=j5E1fET4C/E4mGwrmwEU/5kHYWarDu0tsfDL+9ZedfvyKKPAV6VZ15ck
   aXZL0fg9x8THxp+Un0HN65Yz5Q4uxY/h0HwmSZa3CkO2XBjMyqvaO/mwd
   KtNKo0K/nQNV+A1H3xYBw/DwKT6x+RxUs3CCLuGK6KlJZp2JcMMzCWwBl
   KHgzChQNCkElMTGMyPz6kF7henHX95ah6Ewl/FrZf7li2uQ4MuzPQRj2y
   bK9jPrbEWwJ5hXvPIgkrUc4xuX2KrbOnG44SH485WonVN0UGFKUmwQH7I
   wNcW4HRg2ARhoX0ZgjMN2uGWTNFhxALgAUp3kOv3CVxpdkwIcUTrpvTDa
   A==;
X-CSE-ConnectionGUID: BU+PJpNES8C05ezlve+GWQ==
X-CSE-MsgGUID: guXU3l0vS9qs8btTT4hUug==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="95907617"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="95907617"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 02:52:23 -0700
X-CSE-ConnectionGUID: 8dXMjCEuQYmJcM02jtVTog==
X-CSE-MsgGUID: v+rIlqF7T9ir9Gbif1LmLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="256018475"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa008.fm.intel.com with ESMTP; 24 Jul 2026 02:52:18 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org
Cc: adrian.hunter@intel.com,
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
Subject: [PATCH v4 5/9] perf c2c: add function view stats merge and memory management
Date: Fri, 24 Jul 2026 17:58:38 +0800
Message-ID: <20260724095842.995920-6-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724095842.995920-1-jiebin.sun@intel.com>
References: <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260724095842.995920-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the per-entry stats/cstats aggregation helpers, the borrowed-reference
teardown for hierarchy children (which frees only the owned resources and
never the borrowed thread/ms), and the pruning of cachelines/functions
with no contention.

These are used by the entry-creation and builder patches that follow and
are __maybe_unused until then.

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
 tools/perf/ui/browsers/c2c-function.c | 196 ++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 21e156bbbef3..1bddc6bdc073 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -671,6 +671,202 @@ c2c_function_hists__reinit(struct c2c_hists *c2c_hists,
 	return function_hpp_list__parse(&c2c_hists->list, output, sort, env);
 }
 
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
+static void __maybe_unused c2c_add_cstats(struct compute_stats *dest,
+			   const struct compute_stats *src)
+{
+	c2c_stats_merge(&dest->rmt_hitm, &src->rmt_hitm);
+	c2c_stats_merge(&dest->lcl_hitm, &src->lcl_hitm);
+	c2c_stats_merge(&dest->rmt_peer, &src->rmt_peer);
+	c2c_stats_merge(&dest->lcl_peer, &src->lcl_peer);
+	c2c_stats_merge(&dest->load, &src->load);
+}
+
+static bool __maybe_unused hist_entry__add_c2c_stats(struct hist_entry *he,
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
+static void __maybe_unused c2c_function_he_free(void *ptr)
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
+/*
+ * Free one child entry @child_he and everything below it. Frees exactly the
+ * resources c2c_child_entry__alloc() owns (mem_info clone, stat_acc, hists and
+ * the c2c-specific arrays); the borrowed thread/ms are left untouched.
+ */
+static void c2c_child_he__free(struct hist_entry *child_he)
+{
+	struct c2c_hist_entry *child_c2c = container_of(child_he, struct c2c_hist_entry, he);
+
+	if (child_he->stat_acc)
+		zfree(&child_he->stat_acc);
+
+	if (child_he->mem_info)
+		mem_info__put(child_he->mem_info);
+
+	if (child_c2c->hists) {
+		perf_hpp__reset_output_field(&child_c2c->hists->list);
+		hists__delete_all_entries(&child_c2c->hists->hists);
+		zfree(&child_c2c->hists);
+	}
+
+	zfree(&child_c2c->cpuset);
+	zfree(&child_c2c->nodeset);
+	zfree(&child_c2c->nodestr);
+	zfree(&child_c2c->node_stats);
+
+	c2c_he__free_hierarchy(child_he);
+
+	free(child_c2c);
+}
+
+static void c2c_he__free_hierarchy(struct hist_entry *he)
+{
+	struct rb_node *nd;
+	struct hist_entry *child_he;
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
+		rb_erase_cached(&child_he->rb_node, &he->hroot_out);
+		c2c_child_he__free(child_he);
+
+		nd = next;
+	}
+
+	/* All children erased; clear the tree (and its cached leftmost). */
+	he->hroot_out = RB_ROOT_CACHED;
+}
+
+/*
+ * Drop level-2 writing functions that carry no stores (child_stores == 0) or
+ * no cacheline children. Writers are only added when they store into a shared
+ * line, so this is mainly a safety net. Returns the number of surviving
+ * writers.
+ */
+static int __maybe_unused c2c_he__prune_empty_writers(struct hist_entry *l1_he)
+{
+	struct rb_node *nd;
+	int surviving = 0;
+
+	if (!l1_he->has_children)
+		return 0;
+
+	nd = rb_first_cached(&l1_he->hroot_out);
+	while (nd) {
+		struct rb_node *next = rb_next(nd);
+		struct hist_entry *l2_he = rb_entry(nd, struct hist_entry, rb_node);
+
+		if (l2_he->has_children && hist_entry__child_stores(l2_he) > 0)
+			surviving++;
+		else {
+			rb_erase_cached(&l2_he->rb_node, &l1_he->hroot_out);
+			c2c_child_he__free(l2_he);
+		}
+		nd = next;
+	}
+
+	if (!surviving) {
+		l1_he->hroot_out = RB_ROOT_CACHED;
+		l1_he->has_children = false;
+		l1_he->unfolded = false;
+	}
+	return surviving;
+}
+
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

