Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F8331A48;
	Fri, 17 Jul 2026 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253952; cv=none; b=kIJdbhX76wk9RkbJTNSI3xPBxorb/aPxsjVCVhkQMzuVYogXjtSBwidjmgBZ54JqZcGkahILsd8RndWS0JW3s0MO9/d2LLfH9Uorps11DRypG/stwV8mbva3Dh2YW8l/eJBB8PpfDyq7J9QAop3sUNEN4fbo4aO5hHz7AJ35VG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253952; c=relaxed/simple;
	bh=dzpqP9yppOzeSTqgR5R7a0x7rcylJY76yHgWAl2tHP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQtIwitdh6vO//dvcofImLEjmXiwh+R41XB+aqfRsGKUPWbhGvoADH9Nw2yHcxd4JG/2SNM0+zG0TfvjDU1cEkyKzAH+t8QXeirIUQaR7zlmgIPRICkLkt8fm+G48xWVhM2P0HpAWAQoHo7eANP1yvSquKK9M3EPFabV61s1KJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lqu1Nu+q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lqu1Nu+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784253949; x=1815789949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dzpqP9yppOzeSTqgR5R7a0x7rcylJY76yHgWAl2tHP0=;
  b=Lqu1Nu+qNCYPmPA+JibU8+ptYd/RRNKzU9OoDyjDWYlIkvpPfM0X2Bfj
   Zm5+H6wvVmej9cRmi0LWjSq7AgwtzRfEMaxj4kWSe3+U9zTJa0i7phG59
   yq33IUYOqAjkk5+/lvTuGg4uQ5WGnvWcC47sXVDiuGM6jt3+sNNuLd4i6
   ojYsbYaf6z441O/cVPfsLL72e426t4v9P1yu9acaEDfirRprGB9lZfmMh
   sxrc69mXwXysT5Fmbjboz0rjGG60DdCGle8BigPxK3HVK6FMg0KAQibFN
   vtM8isjQBKjF6ZWh+YyF91PubHufNt3r9wwmjwZEcgzIA/24OoE4dlX5a
   Q==;
X-CSE-ConnectionGUID: 2HcO9TDHTgK+cKFzfrKTEg==
X-CSE-MsgGUID: n+pyzjGDReuZl5YqdVbCWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="107720022"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="107720022"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 19:05:49 -0700
X-CSE-ConnectionGUID: CA4i0GPYSBON9xUnrkLQPQ==
X-CSE-MsgGUID: ba//qIrYTrOsyB0wLFK0lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="279952804"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jul 2026 19:05:44 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org,
	acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH v3 05/14] perf c2c: add column entry functions for function view
Date: Fri, 17 Jul 2026 10:05:21 +0800
Message-ID: <20260717020530.1645123-6-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717020530.1645123-1-jiebin.sun@intel.com>
References: <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260717020530.1645123-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add rendering functions for each column in the function view:

- total_stores_entry(): render store count, summing children for L1
- cacheline_symbol_entry(): render cacheline address for L3 entries
- iaddr_symbol_entry(): render code address with fold indicators
- symbol_view_entry(): render symbol name with fold indicators
- cycles_percent_entry(): render estimated load-cycle percentage for L1
  (HITM, peer-snoop and other-load cycles)

Each entry function handles the 3-level hierarchy by checking
parent_he depth to decide what to display.

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
 tools/perf/ui/browsers/c2c-function.c | 148 ++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 10 deletions(-)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index ace7e3f27b55..a9add0ba4cda 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -167,20 +167,148 @@ static __maybe_unused u64 c2c_ext__total_cycles(void)
 	return total;
 }
 
-/* Sum child entries' store counts under a level-1 hist_entry. */
+/*
+ * Sum of the level-2 children's store counts under a level-1 hist_entry.
+ * Read from the cache populated by the hierarchy builder, so this is O(1)
+ * and safe to call from the sort comparator.
+ */
 static __maybe_unused u64 hist_entry__child_stores(struct hist_entry *he)
 {
-	struct rb_node *nd;
-	u64 sum = 0;
+	struct c2c_hist_entry *c2c_he = container_of(he, struct c2c_hist_entry, he);
 
-	for (nd = rb_first_cached(&he->hroot_out); nd; nd = rb_next(nd)) {
-		struct hist_entry *child = rb_entry(nd, struct hist_entry, rb_node);
-		struct c2c_hist_entry *c2c_child =
-			container_of(child, struct c2c_hist_entry, he);
+	return c2c_he->child_stores;
+}
 
-		sum += (u64)c2c_child->stats.store;
-	}
-	return sum;
+static __maybe_unused int
+total_stores_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		   struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he = container_of(he, struct c2c_hist_entry, he);
+	int width = c2c_width(fmt, hpp, he->hists);
+	u64 total;
+
+	/* L1 shows the sum of sharing-function stores; L2/L3 show their own. */
+	total = he->parent_he ? (u64)c2c_he->stats.store : hist_entry__child_stores(he);
+
+	return scnprintf(hpp->buf, hpp->size, "%*" PRIu64, width, total);
+}
+
+/*
+ * cacheline_symbol_entry - Render cacheline address for function view
+ */
+static __maybe_unused int
+cacheline_symbol_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	char buf[24];
+	u64 addr;
+
+	/* Only show the address on level-3 cacheline entries. */
+	if (!he->parent_he || !he->parent_he->parent_he || !he->mem_info)
+		return scnprintf(hpp->buf, hpp->size, "%*s", width, "");
+
+	addr = cl_address(mem_info__daddr(he->mem_info)->addr, chk_double_cl);
+	scnprintf(buf, sizeof(buf), "0x%" PRIx64, addr);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
+}
+
+/* Render the code (instruction) address for level-1 and level-2 entries. */
+static __maybe_unused int
+iaddr_symbol_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		   struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	int iaddr_width, ret;
+	char buf[24];
+	u64 addr;
+	char folded_sign;
+
+	/* Hide for cacheline (level-3) entries. */
+	if (he->parent_he && he->parent_he->parent_he)
+		return scnprintf(hpp->buf, hpp->size, "%*s", width, "");
+
+	addr = hist_entry__iaddr(he);
+
+	folded_sign = he->has_children ? (he->unfolded ? '-' : '+') : ' ';
+	ret = scnprintf(hpp->buf, hpp->size, "%c ", folded_sign);
+
+	iaddr_width = width - ret;
+	if (iaddr_width <= 0)
+		return ret;
+
+	scnprintf(buf, sizeof(buf), "0x%" PRIx64, addr);
+	ret += scnprintf(hpp->buf + ret, hpp->size - ret, "%*.*s", iaddr_width, iaddr_width, buf);
+	return ret;
+}
+
+/*
+ * symbol_view_entry - Render symbol name for function view with expansion indicators
+ */
+static __maybe_unused int
+symbol_view_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		  struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	int sym_width;
+	int ret;
+	char symbuf[512];
+	char folded_sign;
+
+	/* Hide Symbol for cacheline entries */
+	if (he->parent_he && he->parent_he->parent_he)
+		return scnprintf(hpp->buf, hpp->size, "%*s", width, "");
+
+	folded_sign = he->has_children ? (he->unfolded ? '-' : '+') : ' ';
+
+	ret = scnprintf(hpp->buf, hpp->size, "%c ", folded_sign);
+
+	sym_width = width - ret;
+
+	if (sym_width <= 0)
+		return ret;
+
+	/* sort_sym.se_snprintf is statically set and never cleared. */
+	sort_sym.se_snprintf(he, symbuf, sizeof(symbuf), sym_width);
+
+	ret += scnprintf(hpp->buf + ret, hpp->size - ret, "%-*.*s", sym_width, sym_width, symbuf);
+	return ret;
+}
+
+/*
+ * cycles_percent_entry - Render cycles percentage column
+ */
+static __maybe_unused int
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
 }
 
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
-- 
2.52.0

