Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB213FADE0;
	Fri, 24 Jul 2026 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886735; cv=none; b=gewhA0cMWuLSTlKGdA+1nQjS5ok6uhspkXjRmjQea7Nu+0zZ9vArBG9XhtG6DawHeY1b3485XkZnW6pXJvk/Ku7Jgz+YODGGt3LLaVnjXaVBwVnU5KFusrk0UnBgcOI7i7S8n6OWd+4iuuwhaYEuRFVXDCfyBHpTFD5QdhQI9fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886735; c=relaxed/simple;
	bh=OCf1/DcdK+MXBkgOVMm78D6bheZ7CJt5ApGl4fAmQN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCOSo5HIM2dNVgW+JpQxoIqzGY9nhONTRrhuEH8MKTTzaoUB/7HCM7yEfEzL2auhI86geZYN1qmTzH47+1A3S6UlhcL5kxhzdmkoGK+TXIYyaQixwb2AwSUArsf9M2OyMZj2VO0KaX950rVxTkMfORNMFWO3Z4rqS9+vaYxZtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKjA0ala; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKjA0ala"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784886734; x=1816422734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OCf1/DcdK+MXBkgOVMm78D6bheZ7CJt5ApGl4fAmQN4=;
  b=SKjA0alaK7WX4Pr8n887y8wX5A82aVFF9VwSZBdCItFmCUH8G/xRCD38
   BI50lNM127M3Z0U8BqZyo+weBwxkwS/Mk0JCyyW1H7lO6Cop9epnxa/Dr
   vNG8n5Nbw/68pXUCoxSnio5LwAIPylFIh3APZz7q3mpYioYbIBpel9Lur
   7TQQbLEYBGqN9CyniDvEP5qUJXh9sWtj6NqmaPMjW4oAiLAQkkIHN0TY6
   kmLjMvcJOGDQKtpVxU+vAYqskzgQaj87uE7oKaAbOYuativ1UgOZGM5W5
   qpq2KQ3u9aQejlVkLEm4AgL1ZlCJJ6xOZPMQhjLd3WwnMn3xUFtPvxm4s
   g==;
X-CSE-ConnectionGUID: c5XpFpJBSNe9rik3V84Lng==
X-CSE-MsgGUID: N8oquUFrT7+CDKsr/sst/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="95907596"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="95907596"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 02:52:14 -0700
X-CSE-ConnectionGUID: UqBZDpdyRH2dqjs7CZ3MLA==
X-CSE-MsgGUID: a7YGhuBvSJCi4pPGdEjgOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="256018444"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa008.fm.intel.com with ESMTP; 24 Jul 2026 02:52:08 -0700
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
Subject: [PATCH v4 3/9] perf c2c: add column rendering for function view
Date: Fri, 24 Jul 2026 17:58:36 +0800
Message-ID: <20260724095842.995920-4-jiebin.sun@intel.com>
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

Add the function view's column renderers: the Cycles %, Store count and
the single indented identity column (function / cacheline) with per-level
indentation, the width/header helpers, the per-function estimated-cycles
computation, and the dimension table tying each column to its renderer and
comparator.

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
 tools/perf/ui/browsers/c2c-function.c | 335 ++++++++++++++++++++++++++
 1 file changed, 335 insertions(+)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 3f6822f61600..4eda97894d1d 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -72,6 +72,341 @@ static inline __maybe_unused u64 hist_entry__iaddr(struct hist_entry *he)
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
+	 * Cap long symbol names as the cacheline view does, but never below
+	 * what a level-3 cacheline address needs (deepest indent + folded sign
+	 * + "0x" + 16 hex digits), so the address is not truncated when the
+	 * level-1 function names happen to be short.
+	 */
+	if (!c2c.symbol_full && width > SYMBOL_WIDTH) {
+		int cl_min = 2 * C2C_FUNC_INDENT + C2C_FUNC_FOLD_WIDTH + 2 + 16;
+
+		width = max(SYMBOL_WIDTH, cl_min);
+	}
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
+		      struct hists *hists, int line, int *span)
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
+	if (text == NULL)
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
+ * Sum of the writer store counts under a level-1 function or level-2 writing
+ * function. Read from the cache populated by the hierarchy builder, so this is
+ * O(1) and safe to call from the sort comparator.
+ */
+static u64 hist_entry__child_stores(struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he = container_of(he, struct c2c_hist_entry, he);
+
+	return c2c_he->child_stores;
+}
+
+/*
+ * Store count shown in the column: the level-3 cacheline leaves show the store
+ * count on that line; the level-1 function and level-2 writing function show
+ * the sum of their writer descendants.
+ */
+static u64 hist_entry__displayed_stores(struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he = container_of(he, struct c2c_hist_entry, he);
+
+	return hist_entry__is_cacheline(he) ? (u64)c2c_he->stats.store :
+					      hist_entry__child_stores(he);
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
+ * a pure function view -- no code addresses:
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
+		size_t cell_size = min_t(size_t, hpp->size - ret, text_width + 1);
+		int len;
+
+		len = sort_sym.se_snprintf(he, hpp->buf + ret, cell_size,
+					   text_width);
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
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

