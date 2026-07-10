Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7C43F44C1;
	Fri, 10 Jul 2026 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673002; cv=none; b=c3ZsDVuKzZoYvkXqMP9zvUrWoBsQbPMPh8YYOCxLhwYrGFRKzQ1KHWiZRiEE6WbEmOLBuSww+NydqaTtZjfyhscxGCdrxF0HJCuO4JbIdOCegR/Jy2gc9bm/I5IVBykbFD6/MFpvtBTHoT93SDi5YPatXOa5N0Ad+bo1I4+MJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673002; c=relaxed/simple;
	bh=A0n/6tlwU+bqztkNZJt6ZEMPvNNRJCRlrShHtyygwro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQTRzCZQNi0oWae1hAbCaWpo0XwLgbKOfM3u7bxLUpAlEQt0FyTz+LEChqm0e+s6ApFugo56Vi1SNmb5YqKQfcXLs4FM91Rnq2m8HFnE64YWstS9fS8q2glNcPs+5OetlI7iNyLnN0f31In6U1SWYdRHN6ygNEhXOt9rJ7iQGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Culil1s9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Culil1s9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783673001; x=1815209001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A0n/6tlwU+bqztkNZJt6ZEMPvNNRJCRlrShHtyygwro=;
  b=Culil1s9FE0KAH1f7H+x+Z4DeDaCNxu31xSgoR6k+K9ge16wrCsNFMAf
   AKE52tIcgMP123VAi9lu2E7q/yVNaSAorGONjYp+desecl5lwbCDnSSgf
   tJSliPv0/Z2sJxlng+Em1cYLcPdKewHt3j61m7PmE1O2s1U2vuJQPQuhO
   gRdK6JoNPvZQc8nSC+awPmiu3AwOA7J6n0yVEc3Vmg5OyEBRNojKDn4os
   TPMuFgA9EiR7mVMhj8ITo8BmC7u83flMbRVueIdKtqf674tRUsb/uEBUJ
   dSI2qpzDDdy6KWGC/+ZAz+R/5RBU3SOsZaVkAy+7LNir4S8k+gZxV2sLx
   Q==;
X-CSE-ConnectionGUID: 8/vkIhKsQT2Z2y6FhETXDg==
X-CSE-MsgGUID: KIlwACA9T9yEbZaL33w2Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390867"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390867"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:43:21 -0700
X-CSE-ConnectionGUID: IKTs24WoSrGbuiwIdgyNUQ==
X-CSE-MsgGUID: g3yzDyJ4SJeUnNyjJOnIjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435419"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:43:16 -0700
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
Subject: [PATCH v2 10/14] perf c2c: add hierarchy entry creation and lookup functions
Date: Fri, 10 Jul 2026 16:42:43 +0800
Message-ID: <20260710084247.3576706-11-jiebin.sun@intel.com>
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

Add functions for creating and finding entries at each level of
the 3-level function view hierarchy:

- c2c_child_entry__alloc(): allocate a child hist_entry with all
  fields initialized from a source entry
- c2c_child_entry__insert(): insert a child into the parent's
  hroot_out tree
- c2c_function_hists__level1_entry(): find/create primary function entry
  using hists__add_entry_ops() for automatic deduplication
- c2c_function_hists__level2_entry(): find/create sharing function entry
  as child of level 1, keyed by (iaddr, symbol)
- c2c_function_hists__level3_entry(): find/create cacheline entry as
  child of level 2, keyed by cacheline address

Also add c2c_function_entry_ops binding the custom allocator/free
functions for function view histogram entries.

These helpers are introduced with __maybe_unused; the annotation is
removed in the following patch once the hierarchy builder calls them.

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
 tools/perf/ui/browsers/c2c-function.c | 249 +++++++++++++++++++++++++-
 1 file changed, 248 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 6afcb1e156c6..47d6fdf66b47 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -818,11 +818,258 @@ static void c2c_he__free_hierarchy(struct hist_entry *he)
 }
 
 /* Entry operations for function view */
-static struct hist_entry_ops c2c_function_entry_ops __maybe_unused = {
+static struct hist_entry_ops c2c_function_entry_ops = {
 	.new	= c2c_he_zalloc,
 	.free	= c2c_function_he_free,
 };
 
+static struct c2c_hist_entry *
+c2c_child_entry__alloc(struct hist_entry *parent_he, struct hist_entry *src_he,
+		       int depth, u64 ip)
+{
+	struct c2c_hist_entry *child_c2c;
+	struct hist_entry *child_he;
+	size_t callchain_size;
+
+	callchain_size = symbol_conf.use_callchain ? sizeof(struct callchain_root) : 0;
+	child_he = c2c_he_zalloc(callchain_size);
+	if (!child_he)
+		return NULL;
+
+	child_c2c = container_of(child_he, struct c2c_hist_entry, he);
+	child_he->callchain_size = callchain_size;
+	if (callchain_size)
+		callchain_init(child_he->callchain);
+
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
+	zfree(&child_c2c->cpuset);
+	zfree(&child_c2c->nodeset);
+	zfree(&child_c2c->node_stats);
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
+c2c_function_hists__level1_entry(struct symbol *sym, u64 iaddr,
+				 struct hist_entry *detail_he,
+				 struct thread *synthetic_thread)
+{
+	struct addr_location al;
+	struct perf_sample sample = {};
+	struct mem_info *mi;
+	struct hist_entry *he;
+
+	mi = mem_info__new();
+	if (mi) {
+		mem_info__iaddr(mi)->addr = iaddr;
+		/* mem_info__put() will map_symbol__exit() these, so take refs. */
+		mem_info__iaddr(mi)->ms.thread = thread__get(detail_he->ms.thread);
+		mem_info__iaddr(mi)->ms.map = map__get(detail_he->ms.map);
+		mem_info__iaddr(mi)->ms.sym = sym;
+		mem_info__daddr(mi)->addr = 0;
+	}
+
+	addr_location__init(&al);
+	al.thread = thread__get(synthetic_thread);
+	al.map = map__get(detail_he->ms.map);
+	al.sym = sym;
+	al.addr = iaddr;
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
+	sample.ip = iaddr;
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
+	if (mi)
+		mem_info__put(mi);
+
+	if (he)
+		he->hpp_list = &c2c_ext.function_hists.list;
+
+	return he;
+}
+
+static __maybe_unused struct c2c_hist_entry *
+c2c_function_hists__level2_entry(struct c2c_hist_entry *level1_c2c,
+				 struct symbol *sym, u64 iaddr,
+				 struct hist_entry *detail_he)
+{
+	struct hist_entry *level1_he = &level1_c2c->he;
+	struct rb_node **p = &level1_he->hroot_out.rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	struct c2c_hist_entry *level2_c2c;
+	bool leftmost = true;
+
+	/*
+	 * Order by (iaddr, symbol name). Symbols are looked up by name to
+	 * coalesce identically-named symbols from different DSO/JIT copies,
+	 * which matches the dedup policy used when building the hierarchy.
+	 */
+	while (*p) {
+		struct hist_entry *iter = rb_entry(*p, struct hist_entry, rb_node);
+		u64 iter_iaddr = hist_entry__iaddr(iter);
+		int cmp;
+
+		parent = *p;
+		if (iaddr < iter_iaddr) {
+			p = &parent->rb_left;
+			continue;
+		}
+		if (iaddr > iter_iaddr) {
+			p = &parent->rb_right;
+			leftmost = false;
+			continue;
+		}
+
+		if (!sym || !iter->ms.sym)
+			/* Order NULL-symbol entries deterministically (NULL last). */
+			cmp = (iter->ms.sym ? 1 : 0) - (sym ? 1 : 0);
+		else
+			cmp = arch__compare_symbol_names(sym->name, iter->ms.sym->name);
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
+	level2_c2c = c2c_child_entry__alloc(level1_he, detail_he, 1, iaddr);
+	if (!level2_c2c)
+		return NULL;
+
+	/* Key this level by the looked-up symbol, not detail_he's. */
+	level2_c2c->he.ms.sym = sym;
+
+	/* Override iaddr (and symbol) in cloned mem_info for level 2 */
+	if (level2_c2c->he.mem_info) {
+		mem_info__iaddr(level2_c2c->he.mem_info)->addr = iaddr;
+		mem_info__iaddr(level2_c2c->he.mem_info)->ms.sym = sym;
+	}
+
+	c2c_child_entry__insert(level1_he, &level2_c2c->he, p, parent, leftmost);
+
+	return level2_c2c;
+}
+
+static __maybe_unused struct c2c_hist_entry *
+c2c_function_hists__level3_entry(struct c2c_hist_entry *level2_c2c, u64 cl_addr,
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
+		u64 iter_addr = 0;
+
+		if (iter->mem_info) {
+			u64 daddr = mem_info__daddr(iter->mem_info)->addr;
+
+			iter_addr = cl_address(daddr, chk_double_cl);
+		}
+
+		parent = *p;
+		if (cl_addr < iter_addr) {
+			p = &parent->rb_left;
+		} else if (cl_addr > iter_addr) {
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
+
+	c2c_child_entry__insert(level2_he, &level3_c2c->he, p, parent, leftmost);
+
+	return level3_c2c;
+}
+
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

