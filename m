Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D84A3DB63A;
	Thu,  6 Aug 2026 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001756; cv=none; b=gjhg8ziZ3i/JUEDx/s4qQk2S+amEHoQCjcujCS5jawfNNGWccf8x0Jfy+MIYCTJ2o7NK0Xc02XFJi7XXjXS6XQ+XcVySCmG+vfjDYRzM+YR3/lbDTxQPGV2t8T6YTMaqthi2fr/RC3+AyCVA1l78OVB87WIuzqV94V/QKT1rc/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001756; c=relaxed/simple;
	bh=p2Mrr9HYCdtACzpaqq2BIyEfN0rdN4lZqBxILuaD6Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzxYyZyA5sRSm8fhRgj0jyX3vioqC7nU4HaYCg9sUHpH+bNspDIEoGRnXywVtCi23ltJsOM4p81nYSOrWFfiCszQhkW06NBpqvOpnSFp44Bp2HesG4ODE9CcsN+o4aWA3ImE8DUoz/rRcfi2+Bl1pPD9mXrdyimqcMFdhzpd/y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPyXM+Cm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPyXM+Cm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786001753; x=1817537753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p2Mrr9HYCdtACzpaqq2BIyEfN0rdN4lZqBxILuaD6Rk=;
  b=jPyXM+CmZKbC+1NtqdIpcTLggxXu7pMwBob1rajJQ3NFq18kUYjpqSZU
   IyCGqwpYYBf0DvnE48eXkK+ZfmjYQuo0pveI1cs4i9UqaT4JEN0N28ZG7
   PjpGVkkmFocnSR9+OKoaq2l/wHRsjH0AWHcVYf/WUIpWgYbDDrmGSlzLe
   nekoWoKAV01kXjqLi9wiOhNHhu6nI/EuKgDGy+bOvqEArFD58ki9S95o0
   PQ1gJKiKjkda6WlxpnZ8bH5y41r+Tv4zfB0687O2EeR2pU++ooMGmSUY6
   FO0R9/4H9+pQwHD/ML+DJ003PIul2hkXUDDW845LGK+GhjgJoRYGD/4x5
   A==;
X-CSE-ConnectionGUID: 5qAjrbC5QV+UUFkIf6EFnw==
X-CSE-MsgGUID: LKywXAfbTu6UXjt4rO3qjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86440504"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86440504"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 00:35:52 -0700
X-CSE-ConnectionGUID: 1UeHfSNRSUC9SkVcUbxBPQ==
X-CSE-MsgGUID: Uba7GrTEQIO3RXwEP/pcpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="300245516"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa001.jf.intel.com with ESMTP; 06 Aug 2026 00:35:49 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/9] perf c2c: add function view stats merge and memory management
Date: Thu,  6 Aug 2026 15:42:13 +0800
Message-ID: <20260806074217.2846596-6-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260806074217.2846596-1-jiebin.sun@intel.com>
References: <20260806074217.2846596-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the per-entry stats/cstats aggregation helpers and hierarchy teardown.
Child common fields are released through hist_entry__delete(), while the
function-view free callback handles the private child tree and containing
allocation. Also add a helper for pruning writer entries with no stores or
cacheline children.

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
 tools/perf/ui/browsers/c2c-function.c | 162 ++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 7e26c4d1147f..fc9a4c4bcb03 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -683,6 +683,168 @@ c2c_function_hists__reinit(struct c2c_hists *c2c_hists,
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
+					  const struct compute_stats *src)
+{
+	c2c_stats_merge(&dest->rmt_hitm, &src->rmt_hitm);
+	c2c_stats_merge(&dest->lcl_hitm, &src->lcl_hitm);
+	c2c_stats_merge(&dest->rmt_peer, &src->rmt_peer);
+	c2c_stats_merge(&dest->lcl_peer, &src->lcl_peer);
+	c2c_stats_merge(&dest->load, &src->load);
+}
+
+static bool __maybe_unused hist_entry__add_c2c_stats(struct hist_entry *he,
+						     const struct c2c_stats *stats)
+{
+	u64 nr_events = c2c_hitm_count(stats) + stats->rmt_peer + stats->lcl_peer;
+	u64 weight1 = c2c_hitm_count(stats);
+
+	/*
+	 * Allocate before touching he->stat, so a failure here leaves the
+	 * entry unmodified and the caller can bail out without having
+	 * half-updated the statistics.
+	 */
+	if (symbol_conf.cumulate_callchain && !he->stat_acc) {
+		he->stat_acc = calloc(1, sizeof(struct he_stat));
+		if (!he->stat_acc)
+			return false;
+	}
+
+	he->stat.nr_events += nr_events;
+	he->stat.period += nr_events;
+	he->stat.weight1 += weight1;
+
+	if (!symbol_conf.cumulate_callchain)
+		return true;
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
+static void c2c_he__free_hierarchy(struct hist_entry *he)
+{
+	struct rb_node *nd;
+	struct hist_entry *child_he;
+
+	/*
+	 * A leaf entry stores its callchains in the sorted_chain member, which
+	 * shares a union with the hroot_in/hroot_out child trees, so its
+	 * hroot_out is not a valid subtree to walk. Leaf entries never have a
+	 * child hierarchy here, so stop before touching hroot_out.
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
+		hist_entry__delete(child_he);
+
+		nd = next;
+	}
+
+	/* All children erased; clear the tree (and its cached leftmost). */
+	he->hroot_out = RB_ROOT_CACHED;
+}
+
+/*
+ * Drop level-2 writing functions that carry no stores or
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
+		if (l2_he->has_children && hist_entry__displayed_stores(l2_he) > 0) {
+			surviving++;
+		} else {
+			rb_erase_cached(&l2_he->rb_node, &l1_he->hroot_out);
+			hist_entry__delete(l2_he);
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
 int perf_c2c__browse_function_view(void)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

