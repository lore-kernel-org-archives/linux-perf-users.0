Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E0332E692;
	Fri, 17 Jul 2026 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253949; cv=none; b=DxTkQpnBUblIHvd53gvxWX1GrOWbiJUF5yhN1nCOvZN0yHS6kTHgNWQjGyRJjkZ3Zg9w4qyax/qon+ZyF78Z4foc/mUpDfd5FYObaKWD7UecQJdMmWGO/SqKr55JU4jYLarp2X/Dc9VXau27mb18Kt3i7Zl1qR7QvceIUp/nMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253949; c=relaxed/simple;
	bh=C4nE69A6b95ym88LWiJH0K1yJS2wEOWkXhNLUfCRMK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQf7XM8HJWd+PbbeZoxov3h2ZtdFLmWz8tcPBLQE+R2N51eRPx8oSSG21YdZK3nFpMj6fO3BiLRAgm39wYWp3q34fPQrE6ynyQX2tkKZA8h+t4KV5dzVIDtM6Um5Ywpknj1M8F7XM1hz9BTHoh5YHLKKz0eGOdZE+jrFbyPJlIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RsIphQ0g; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RsIphQ0g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784253946; x=1815789946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C4nE69A6b95ym88LWiJH0K1yJS2wEOWkXhNLUfCRMK4=;
  b=RsIphQ0gmATgLSEX1fjd/JOVgOrjKZhK9lOVMwS+o2BhOomR2yiMuCwh
   o9aWzl7I5PHT2OfpQzId7vA6fJZ15Yja2nRDJ7yN/TpybNdZ0TRWFU7/n
   SJlL0yNdPViOKDH23S7wDREpOFN7Sdfxm0CtTG8upN81ATQ08xIiQB/pD
   3zPkeQq0V+JQlgyD5T8+DgJHM45yMc7MhwdZa+u93yp0xrA/dj/G2IYid
   iUlAnO/ne40QG5bD/Hnzz70cpC/uIhy4xD2FqYf0vXgf19m8rkuQkBICL
   KnT6JrE4qJGOLR779PNUMRyskI71f44OjehqatdPSSiLpQlhviUGULxUF
   Q==;
X-CSE-ConnectionGUID: KskI98wLRkGc/95EkhKwvQ==
X-CSE-MsgGUID: 8NDHK4HWSw+Gh9M9sy+CBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="107720014"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="107720014"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 19:05:45 -0700
X-CSE-ConnectionGUID: 6E9Oc9M4ShCKKnK+sYuAww==
X-CSE-MsgGUID: Et1n+DJxSK6SIqBCbAKfVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="279952796"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jul 2026 19:05:40 -0700
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
Subject: [PATCH v3 04/14] perf c2c: add column format infrastructure for function view
Date: Fri, 17 Jul 2026 10:05:20 +0800
Message-ID: <20260717020530.1645123-5-jiebin.sun@intel.com>
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

Add the column format plumbing functions used by all function view
dimensions:

- symbol_width(): constrain symbol column width
- c2c_width(): dispatch column width based on dimension type
- c2c_header(): render multi-line column headers

These are referenced by column entry functions and dimension
definitions added in subsequent patches.

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
 tools/perf/ui/browsers/c2c-function.c | 117 ++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 1ef5d08e81c3..ace7e3f27b55 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -66,6 +66,123 @@ static __maybe_unused inline u64 hist_entry__iaddr(struct hist_entry *he)
 	return he->ip;
 }
 
+static __maybe_unused int symbol_width(struct hists *hists, struct sort_entry *se)
+{
+	int width = hists__col_len(hists, se->se_width_idx);
+
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
+static __maybe_unused int c2c_width(struct perf_hpp_fmt *fmt,
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
+static __maybe_unused int c2c_header(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
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
+static __maybe_unused u64 c2c_hist_entry__cycles(struct c2c_hist_entry *c2c_he)
+{
+	double cycles_rmt, cycles_lcl, cycles_load;
+	u64 other_load, total_hitm;
+
+	cycles_rmt = avg_stats(&c2c_he->cstats.rmt_hitm) * c2c_he->stats.rmt_hitm;
+	cycles_lcl = avg_stats(&c2c_he->cstats.lcl_hitm) * c2c_he->stats.lcl_hitm;
+	total_hitm = c2c_he->stats.tot_hitm;
+	other_load = (c2c_he->stats.load >= total_hitm) ? c2c_he->stats.load - total_hitm : 0;
+	cycles_load = avg_stats(&c2c_he->cstats.load) * other_load;
+
+	return (u64)(cycles_rmt + cycles_lcl + cycles_load);
+}
+
+/* Sum c2c_hist_entry__cycles() across all level-1 entries. */
+static __maybe_unused u64 c2c_ext__total_cycles(void)
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
+/* Sum child entries' store counts under a level-1 hist_entry. */
+static __maybe_unused u64 hist_entry__child_stores(struct hist_entry *he)
+{
+	struct rb_node *nd;
+	u64 sum = 0;
+
+	for (nd = rb_first_cached(&he->hroot_out); nd; nd = rb_next(nd)) {
+		struct hist_entry *child = rb_entry(nd, struct hist_entry, rb_node);
+		struct c2c_hist_entry *c2c_child =
+			container_of(child, struct c2c_hist_entry, he);
+
+		sum += (u64)c2c_child->stats.store;
+	}
+	return sum;
+}
+
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

