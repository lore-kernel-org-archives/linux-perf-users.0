Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF2296BD2;
	Fri, 10 Jul 2026 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672975; cv=none; b=ANCnorP7VBjbVR+7yCnN6/oFg4hYDJAgVOpoSZ+FLuHUcmsZShJoJRrwtW3UjbQpjfTRZzBQRLkkHHZcp2pfZAdqq8qvF0k7nT+04WgHkqNBo+2oIjTMylXVzu+8eLT2uGsE/SPbKvvit95pTF/RB1Rx5Sy0Xae6Cohut+RYZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672975; c=relaxed/simple;
	bh=aCOVCEKNtoWzYGR9+mlkMjzBTHh42oLszM4HeGaR9wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdWqak8ua2xZwiCDewJSZ5s6TsuXSZ0UB2B1DhrTwTUJgRTkXFv9AHcKtCbCKPC79ElXs5xFi934yaS1JJ8bgrGGjauFIEZZVbAVyvHVee7sDGzUC547HOuX2hhK3dUbGG+OkZ4V8M2mc3/q0QaG4XydNOkY7duB86vybudZZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sscq2Rxm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sscq2Rxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783672972; x=1815208972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aCOVCEKNtoWzYGR9+mlkMjzBTHh42oLszM4HeGaR9wE=;
  b=Sscq2RxmQsk3PkuGvBDXXK0QlnWkKuw1G4RCjf8fr8rSJzjP8Arg6AOe
   TQpD7IEnKpepGXHNNCAIMQaSRXgtVx0fOmhgAT0opkoDWtipri7dqQVoF
   bP8X50i30w5JErKaJzDbe+uMs2hLO0BRlV/X5aPSrjCKaiySob0JleaQP
   lE4pe+w8vuxmDFjFlGKeMz370x67hWrJqkqLlvfbRqfQM3t0i//sgNll8
   4yPWqo1aVPJiC8bXHzUXI7Ud+G511GZ9kUYz9b8+D6m4EGB7/XeYYVcDP
   tUDIMZ8bgNaoMKk1hE2J9ZXuVxyO4DyzxaAHzFtOrfraXsVj7+P4zCLIM
   Q==;
X-CSE-ConnectionGUID: +K53cpsuQbSEBTFRmhJYNg==
X-CSE-MsgGUID: HOLZ2qerSl2OjrQnNggNFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390814"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390814"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:42:52 -0700
X-CSE-ConnectionGUID: amRU1MFvRZOElXwSY83IAA==
X-CSE-MsgGUID: mtAk58O4Tv6AF3x6m0x4sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435344"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:42:47 -0700
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
Subject: [PATCH v2 04/14] perf c2c: add column format infrastructure for function view
Date: Fri, 10 Jul 2026 16:42:37 +0800
Message-ID: <20260710084247.3576706-5-jiebin.sun@intel.com>
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
index dbc912a4a242..d718cab6537d 100644
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

