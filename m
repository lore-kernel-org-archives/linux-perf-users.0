Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79EE3F0757;
	Thu, 30 Jul 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402053; cv=none; b=QP9urd7/qrHfLMIx+4y5cNaR3bwqMZMwOyM86dnWVLExCDufcpR6u6x8TUrmXhW0p575Y0PCIJfq/b7W6JJhBkmYh2zgdNvfluKIXStMTrDzrNkl142GSmrbS9jpUZNJ+dtNRke08gfpsBBn3NIwJ+/i8QgtJhdE0lFUgCKxU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402053; c=relaxed/simple;
	bh=wpLWnnbE1LblXMD31rs9j9idW/ytQDAxWeXNkcE1ksk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAbej2VO1+RTPj+EieQP1sNvyjhxIv01YsxTSKRQbe1A91X+4Ae1UKe/sSdFRI6psOtvsT5018G4PsyG/IxkogHnHP2nv9qST1zrEcUcFUUO7v90yEZrSGKV+iPt4zaOhNo0sQZzoTvUhG1c2ZREH/r0gTFP0chFJlTw9nD2ZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYbYFo7m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYbYFo7m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785402052; x=1816938052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wpLWnnbE1LblXMD31rs9j9idW/ytQDAxWeXNkcE1ksk=;
  b=DYbYFo7mYtrSkIrQMP6knYF4w48xLPoX3MLvj1mqPCd3k+CuN+WlILjs
   LvMPiz56OfQxzGam4i6EPiFhMTUosm7Ki5dhCL5y264yq7uxH+R8w49p/
   oUeHKIpa/cDmcjDRL8dWuSattr6mw629iHn89yJX+ugfJu2vBYwSgGUQF
   2+CeRLIHcBJNLTTe+o4IPXoufhNLWNOYPCXfeijfLuKNHvF1UpwOiH3jr
   I3rdy/VBt4muRXGNKXMrGCCckSHEuZDM2grQsCzfmLJ3Vq7cW2pXADDox
   fKxYtejuARfEvLGqOjmN+CH2xez1fX7+wckjPTNATrWjK7NF3aJykIf4s
   A==;
X-CSE-ConnectionGUID: MfOfWRcNR/mmto2DHxO4dw==
X-CSE-MsgGUID: pDD6/c8BTgOhCE1ucRD59g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="111563498"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="111563498"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 02:00:51 -0700
X-CSE-ConnectionGUID: GUQp4sN6SSSABJ4g84VXNQ==
X-CSE-MsgGUID: 6Pp3MtleQQmNr/9JZefOpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="260846494"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa009.jf.intel.com with ESMTP; 30 Jul 2026 02:00:48 -0700
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
Subject: [PATCH v5 v5 5/9] perf c2c: add function view stats merge and memory management
Date: Thu, 30 Jul 2026 17:05:17 +0800
Message-ID: <20260730090521.2206375-6-jiebin.sun@intel.com>
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

Add the per-entry stats/cstats aggregation helpers and the
borrowed-reference teardown for hierarchy children, which frees only the
owned resources and never the borrowed thread/ms. Also add a helper for
pruning writer entries with no stores or cacheline children.

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
 tools/perf/ui/browsers/c2c-function.c | 198 ++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index caccb20f0ef4..051c38697edd 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -678,6 +678,204 @@ c2c_function_hists__reinit(struct c2c_hists *c2c_hists,
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
+	 * Children borrow thread and ms from the main cacheline entries, which
+	 * outlive this temporary hierarchy. Do not use hist_entry__delete() here:
+	 * it would put those borrowed references. Free only the resources owned by
+	 * c2c_child_entry__alloc().
+	 *
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
 int perf_c2c__browse_function_view(void)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

