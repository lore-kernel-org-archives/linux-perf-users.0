Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52C37DAD0;
	Mon,  3 Aug 2026 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728746; cv=none; b=MaTRxJzeQisN08l9ef0tpB/PFIwbLeysJwF4JVqFriY8QQuvc6SRt8RGpoxOUDZ321frKzZ30BEndBfPuG0enEjnb2KWL2Ux9xmVfguXFwgEU4RD5IKysIUHdUm6E+MBxHQO3Bt5jQMYWdItjLUe1ogSYUhF95asfSakgV/ka58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728746; c=relaxed/simple;
	bh=N6FOC39XErsiMc739+eAnGBTbyGgnJODo4PMgIBZb+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoG0EfyWn/s1MufC4qIXbdf2NYDb3bP3BTPeZXp0rSpOatEwFZua+1mVrwRoFcDz0wFoYGYNcHweQNQNrh7qxl5q0fgvBxvHEm5ETMQBqjlprWvePKbl7zA4AY2ICNU2V3qB/Pije0q+Mu/jwaSb0dqIJXN0CPQh5gXUA/k+olA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrnxPz+3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrnxPz+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785728744; x=1817264744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N6FOC39XErsiMc739+eAnGBTbyGgnJODo4PMgIBZb+s=;
  b=WrnxPz+3/XqMdKuAIj44yLFckbpvcInJfhf2RjSS1dD5VfI6FqaNjrW8
   BmG8FgMUIIll9Gl5i+qySWpjgT8maPyCJw0+/9wJo56vHMZQ3B3Ml4jdx
   4PQCRmJjOZO/bH4KuTnFnMAACeY0kFRpLM15Hvo1BDj8S5OppQM1I6wzR
   A7VEP849dpuHlczSiw0LHhhwjumHIzJ3iptt1N5Xst+J7WlVwCBwfkcB0
   4pkaCJ2a0GP6c2NVQiB2QEtDjw80Kdqcl/WPlYy6PrUBdF3PSL4KS3ds7
   324lN9FE2o4FaUeqnpiJB/Co92PkiGVU74jYO3pGk3+3JPvDGluG2zlDC
   A==;
X-CSE-ConnectionGUID: xn3FAOMMSFSow0GUsYAF8w==
X-CSE-MsgGUID: b8kK3vzKR9WfCt7zVXQPjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="86210191"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="86210191"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 20:45:44 -0700
X-CSE-ConnectionGUID: l8oSglwfQWKgwWgWSlEH+w==
X-CSE-MsgGUID: aK0VBBwiRFKDu5A3u7JmZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="261719169"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa009.jf.intel.com with ESMTP; 02 Aug 2026 20:45:40 -0700
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
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH v6 3/9] perf c2c: add column rendering for function view
Date: Mon,  3 Aug 2026 11:52:14 +0800
Message-ID: <20260803035220.172022-4-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260803035220.172022-1-jiebin.sun@intel.com>
References: <20260803035220.172022-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the function view's column renderers: the Cycles %, Store count and
the single indented identity column (function / cacheline) with per-level
indentation, the width/header helpers, the per-function estimated-cycles
computation, and the dimension table tying each column to its renderer and
comparator.

Clamp the symbol renderer's returned length to its local cell buffer before
using it in subsequent pointer and padding calculations. This keeps the
buffer arithmetic safe if the renderer returns snprintf's would-have-been
length, without changing the normal rendered output.

The HPP list parsing that turns a column string into these dimensions is
added by the next patch; symbols consumed only later are __maybe_unused
for now.

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
 tools/perf/ui/browsers/c2c-function.c | 351 ++++++++++++++++++++++++++
 1 file changed, 351 insertions(+)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index c0fd7799e4f8..89e4e65022b5 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -70,6 +70,357 @@ static inline __maybe_unused u64 hist_entry__iaddr(struct hist_entry *he)
 	return he->ip;
 }
 
+static inline bool hist_entry__is_cacheline(struct hist_entry *he)
+{
+	return he->parent_he && he->parent_he->parent_he;	/* level 3: cacheline */
+}
+
+/* Spaces of indent per hierarchy level, like the normal report view. */
+#define C2C_FUNC_INDENT 2
+
+/* Width of the folded-sign prefix ("%c ") each identity cell emits. */
+#define C2C_FUNC_FOLD_WIDTH 2
+
+/*
+ * Write he->depth levels of leading indentation into @buf, so lower-level
+ * entries are visually nested under their parent. Returns bytes written.
+ */
+static int hist_entry__indent(struct hist_entry *he, char *buf, size_t size)
+{
+	int indent = he->depth * C2C_FUNC_INDENT;
+
+	if (indent <= 0 || (size_t)indent >= size)
+		return 0;
+
+	return scnprintf(buf, size, "%*s", indent, "");
+}
+
+static int symbol_width(struct hists *hists, struct sort_entry *se)
+{
+	int width = hists__col_len(hists, se->se_width_idx);
+
+	/*
+	 * Cap long symbol names as the cacheline view does. The stored column
+	 * length is grown up front to fit the deepest, longest identity cell
+	 * (including a level-3 cacheline address), so this cap never shrinks the
+	 * column below what the cacheline address needs.
+	 */
+	if (!c2c.symbol_full && width > SYMBOL_WIDTH)
+		width = SYMBOL_WIDTH;
+
+	return width;
+}
+
+static struct c2c_dimension dim_symbol_view;
+
+/*
+ * c2c_width - Calculate width for a C2C column in function view
+ */
+static int c2c_width(struct perf_hpp_fmt *fmt,
+		     struct perf_hpp *hpp __maybe_unused,
+		     struct hists *hists)
+{
+	struct c2c_fmt *c2c_fmt;
+	struct c2c_dimension *dim;
+
+	c2c_fmt = container_of(fmt, struct c2c_fmt, fmt);
+	dim = c2c_fmt->dim;
+
+	if (dim == &dim_symbol_view)
+		return symbol_width(hists, dim->se);
+
+	return dim->se ? hists__col_len(hists, dim->se->se_width_idx) :
+			 dim->width;
+}
+
+static int __maybe_unused c2c_header(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+				     struct hists *hists, int line, int *span)
+{
+	struct c2c_fmt *c2c_fmt;
+	struct c2c_dimension *dim;
+	const char *text = NULL;
+	int width = c2c_width(fmt, hpp, hists);
+
+	c2c_fmt = container_of(fmt, struct c2c_fmt, fmt);
+	dim = c2c_fmt->dim;
+
+	if (dim->se) {
+		text = dim->header.line[line].text;
+		/* Use the last line from sort_entry if not defined. */
+		if (!text && line == hists->hpp_list->nr_header_lines - 1)
+			text = dim->se->se_header;
+	} else {
+		text = dim->header.line[line].text;
+
+		if (span) {
+			if (*span) {
+				(*span)--;
+				return 0;
+			}
+
+			*span = dim->header.line[line].span;
+		}
+	}
+
+	if (!text)
+		text = "";
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, text);
+}
+
+/*
+ * Return the estimated total cycles for a c2c_hist_entry
+ * (rmt_hitm + lcl_hitm + rmt_peer + lcl_peer + other loads).
+ */
+static u64 c2c_hist_entry__cycles(struct c2c_hist_entry *c2c_he)
+{
+	struct compute_stats *cs = &c2c_he->cstats;
+	double cycles = 0;
+
+	/*
+	 * compute_stats() in builtin-c2c.c routes each load sample into exactly
+	 * one cstats bucket (rmt_hitm, lcl_hitm, rmt_peer, lcl_peer or plain
+	 * load), so each bucket's cycle total is its mean times its own sample
+	 * count. Summing the per-bucket totals avoids both dropping peer-snoop
+	 * cycles and double counting a sample that carries several data-source
+	 * flags (e.g. Arm SPE sets HITM and PEER on the same load), which would
+	 * happen if the mean were multiplied by the non-exclusive stats counts.
+	 */
+	cycles += avg_stats(&cs->rmt_hitm) * cs->rmt_hitm.n;
+	cycles += avg_stats(&cs->lcl_hitm) * cs->lcl_hitm.n;
+	cycles += avg_stats(&cs->rmt_peer) * cs->rmt_peer.n;
+	cycles += avg_stats(&cs->lcl_peer) * cs->lcl_peer.n;
+	cycles += avg_stats(&cs->load)     * cs->load.n;
+
+	return (u64)cycles;
+}
+
+/* Sum c2c_hist_entry__cycles() across all level-1 entries. */
+static u64 __maybe_unused c2c_ext__total_cycles(void)
+{
+	struct rb_node *nd;
+	u64 total = 0;
+
+	for (nd = rb_first_cached(&c2c_ext.function_hists.hists.entries); nd;
+	     nd = rb_next(nd)) {
+		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
+		struct c2c_hist_entry *c2c_he = container_of(he, struct c2c_hist_entry, he);
+
+		total += c2c_hist_entry__cycles(c2c_he);
+	}
+	return total;
+}
+
+/*
+ * Store count shown in the column: a level-3 cacheline leaf shows its parent
+ * level-2 writer's stores on that line, not all stores on the line. A level-2
+ * writer shows the sum across its level-3 cachelines. A level-1 reader shows
+ * the sum across all included writers on the cachelines it reads; this is not
+ * the reader function's own store count and is not additive across readers.
+ */
+static u64 hist_entry__displayed_stores(struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he = container_of(he, struct c2c_hist_entry, he);
+	struct rb_node *nd;
+	u64 stores = 0;
+
+	/* Level-2/3 entries already aggregate the stores they represent. */
+	if (he->parent_he)
+		return c2c_he->stats.store;
+
+	for (nd = rb_first_cached(&he->hroot_out); nd; nd = rb_next(nd)) {
+		struct hist_entry *child = rb_entry(nd, struct hist_entry, rb_node);
+		struct c2c_hist_entry *child_c2c;
+
+		child_c2c = container_of(child, struct c2c_hist_entry, he);
+		stores += child_c2c->stats.store;
+	}
+	return stores;
+}
+
+static int
+total_stores_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		   struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	u64 total = hist_entry__displayed_stores(he);
+
+	return scnprintf(hpp->buf, hpp->size, "%*" PRIu64, width, total);
+}
+
+/*
+ * symbol_view_entry - Render the unified, indented identity column.
+ *
+ * All three levels share this single column so the hierarchy reads top-down
+ * with progressive indentation, like the normal report hierarchy view. It is
+ * a function-centric view with no dedicated code-address column. Verbose
+ * function rows can still include a representative address:
+ *   L1 read-side function: "- [k] cpupri_set"
+ *   L2 writing function:   "  - [k] pull_rt_task"
+ *   L3 shared cacheline:   "      0xff2d0082809da080"
+ */
+static int
+symbol_view_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		  struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	int text_width;
+	int ret;
+	char folded_sign;
+
+	ret = hist_entry__indent(he, hpp->buf, hpp->size);
+
+	folded_sign = he->has_children ? (he->unfolded ? '-' : '+') : ' ';
+	ret += scnprintf(hpp->buf + ret, hpp->size - ret, "%c ", folded_sign);
+
+	text_width = width - ret;
+	if (text_width <= 0)
+		return ret;
+
+	if (hist_entry__is_cacheline(he)) {
+		/* Level 3: the shared cacheline address. */
+		u64 addr = he->mem_info ?
+			cl_address(mem_info__daddr(he->mem_info)->addr, chk_double_cl) : 0;
+		char symbuf[32];
+
+		scnprintf(symbuf, sizeof(symbuf), "0x%" PRIx64, addr);
+		ret += scnprintf(hpp->buf + ret, hpp->size - ret, "%-*.*s",
+				 text_width, text_width, symbuf);
+	} else {
+		/* Level 1 and level 2 are both functions. */
+		size_t cell_size;
+		int len;
+
+		if ((size_t)ret >= hpp->size)
+			return ret;
+
+		cell_size = min_t(size_t, hpp->size - ret,
+				  (size_t)text_width + 1);
+		len = sort_sym.se_snprintf(he, hpp->buf + ret, cell_size,
+					   text_width);
+		/*
+		 * se_snprintf() accumulates repsep_snprintf() calls, which cap
+		 * their return at the remaining size - 1 rather than reporting
+		 * what the format would have needed, so len stays below
+		 * cell_size. Clamp anyway so ret cannot leave hpp->buf.
+		 */
+		if (len < 0)
+			len = 0;
+		else
+			len = min_t(size_t, len, cell_size - 1);
+
+		ret += len;
+		if (len < text_width)
+			ret += scnprintf(hpp->buf + ret, hpp->size - ret, "%*s",
+					 text_width - len, "");
+	}
+
+	return ret;
+}
+
+/*
+ * cycles_percent_entry - Render cycles percentage column
+ */
+static int
+cycles_percent_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		     struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he;
+	int width = c2c_width(fmt, hpp, he->hists);
+	u64 fn_cycles, total_cycles;
+	char folded_sign;
+	double pct;
+	int ret, pct_width;
+
+	/* Hide Cycles Percent for child functions and cachelines. */
+	if (he->parent_he)
+		return scnprintf(hpp->buf, hpp->size, "%*s", width, "");
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	fn_cycles = c2c_hist_entry__cycles(c2c_he);
+	/* Populated by build_function_view_hierarchy() once the L1 tree is built. */
+	total_cycles = c2c_ext.total_cycles;
+	pct = total_cycles > 0 ? (double)fn_cycles / total_cycles * 100.0 : 0.0;
+
+	/* Add folded sign only for level-1 entries */
+	folded_sign = he->has_children ? (he->unfolded ? '-' : '+') : ' ';
+	ret = scnprintf(hpp->buf, hpp->size, "%c ", folded_sign);
+
+	pct_width = width - ret;
+	if (pct_width <= 0)
+		return ret;
+	ret += scnprintf(hpp->buf + ret, hpp->size - ret, "%*.2f%%", pct_width - 1, pct);
+	return ret;
+}
+
+/*
+ * cycles_percent_cmp - Comparison function for cycles percentage sorting
+ */
+static int64_t
+cycles_percent_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		   struct hist_entry *left, struct hist_entry *right)
+{
+	struct c2c_hist_entry *c2c_left = container_of(left, struct c2c_hist_entry, he);
+	struct c2c_hist_entry *c2c_right = container_of(right, struct c2c_hist_entry, he);
+	u64 cycles_left, cycles_right;
+
+	/* Cycles Percent is only shown for level-1 entries; others compare equal. */
+	if (left->parent_he || right->parent_he)
+		return 0;
+
+	cycles_left = c2c_hist_entry__cycles(c2c_left);
+	cycles_right = c2c_hist_entry__cycles(c2c_right);
+
+	return (cycles_left > cycles_right) - (cycles_left < cycles_right);
+}
+
+/*
+ * total_stores_cmp - Comparison function for total stores sorting
+ */
+static int64_t
+total_stores_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		 struct hist_entry *left, struct hist_entry *right)
+{
+	u64 left_store = hist_entry__displayed_stores(left);
+	u64 right_store = hist_entry__displayed_stores(right);
+
+	return (left_store > right_store) - (left_store < right_store);
+}
+
+/*
+ * Function view dimensions
+ */
+static struct c2c_dimension dim_cycles_percent = {
+	.header		= HEADER_BOTH("Cycles", "%"),
+	.name		= "cycles_percent",
+	.cmp		= cycles_percent_cmp,
+	.entry		= cycles_percent_entry,
+	.width		= 9,
+};
+
+static struct c2c_dimension dim_total_stores = {
+	.header		= HEADER_BOTH("Store", "count"),
+	.name		= "total_stores",
+	.cmp		= total_stores_cmp,
+	.entry		= total_stores_entry,
+	.width		= 7,
+};
+
+static struct c2c_dimension dim_symbol_view = {
+	.header		= HEADER_LOW("Function / Contending function / Cacheline"),
+	.name		= "symbol_view",
+	.se		= &sort_sym,
+	.entry		= symbol_view_entry,
+	.width		= SYMBOL_WIDTH,
+};
+
+static struct c2c_dimension *function_view_dimensions[] __maybe_unused = {
+	&dim_cycles_percent,
+	&dim_total_stores,
+	&dim_symbol_view,
+	NULL,
+};
+
 int perf_c2c__browse_function_view(void)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

