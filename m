Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9267332909;
	Fri, 17 Jul 2026 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253942; cv=none; b=JmU26X9T17UGtITpICi5jx7nLqOehlKzJ/uSxcK2Z/MjmTKd2uy75huetM1EB1m3G97OnNlCjajoJyWNBQo5RNSvd+6OdTnwxbBWis3htEGVkZtA1P2CgTfrPbQa3Hr9pWCzcb1O7UC57Dd1WlyfNcaFpV3VxIIG1r9ANo7nkbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253942; c=relaxed/simple;
	bh=O+pc0eKofkHxpCHKLWDrDTMDDylWJRrpM5TzaSPkn6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDi+m9cu2PWlnHhLAVApJdHLf+jWlaEzCcF3eS3UfBxcf83wuaGFFxlIOhnKptQcuzt8o5PbC90omTLmNkmtICGPUSEQMbyWnw1safRoqYHVVSiDdaHFkVNQDLWjLF430YNNcnvrKqarg4nf8HCTTrlLbYQN8+khfZi7eCTH56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/e8gxYH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/e8gxYH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784253938; x=1815789938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O+pc0eKofkHxpCHKLWDrDTMDDylWJRrpM5TzaSPkn6w=;
  b=g/e8gxYHk/cfsaVmrRxrfhWaxV6VWqGpGjUIda+8PzbEVY8y0Rsd2paL
   4ShMoN3z0+D8pJKgkHNP6jOg6t+Uwl67/9juQnvcDjJZ/likyuNqt/a0/
   AswrVd1fp5UGON+ywG8/pZKqTq8qhBnhYElyUmGFehPc9e7IamPsK1eMq
   0QhgI+ulxRn/DfAlkocPPDJpcTESx8IVAn79kgRj4qrZ0+1a50ZbfRtbb
   UsN2uy3z+e9MeTQVKxZREp2OCFUPsKOsmL8vUmWFvQSdpYG7ZD7WG7UZR
   9KYuzUBXW8uR8opbTiNNYfm2XUu5XXi2Knuh7Mce1240wLGilswSrGACf
   A==;
X-CSE-ConnectionGUID: DoPusM8kTwik8vS5vUN3jQ==
X-CSE-MsgGUID: Ve7UVwzdQWmXYVxhO7yu3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="107719984"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="107719984"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 19:05:35 -0700
X-CSE-ConnectionGUID: SSGxH8qJTg6xv346l1kwpw==
X-CSE-MsgGUID: in5qTazOSMmE5gcDYPrQSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="279952731"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jul 2026 19:05:27 -0700
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
Subject: [PATCH v3 01/14] perf c2c: extract shared data structures into c2c.h
Date: Fri, 17 Jul 2026 10:05:17 +0800
Message-ID: <20260717020530.1645123-2-jiebin.sun@intel.com>
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

Move c2c_hists, compute_stats, c2c_hist_entry, and perf_c2c structure
definitions from builtin-c2c.c into a new shared header c2c.h. This
allows the upcoming function view browser (c2c-function.c) to reuse these
types.

Make the global perf_c2c instance 'c2c' non-static and export
perf_c2c__browse_cacheline() so they can be accessed from the new
function view module.

No functional change.

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
 tools/perf/builtin-c2c.c | 128 +++-------------------------------
 tools/perf/c2c.h         | 147 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 120 deletions(-)
 create mode 100644 tools/perf/c2c.h

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c9584dbedf77..f1dd9d8699cb 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -38,6 +38,7 @@
 #include "mem-events.h"
 #include "mem-info.h"
 #include "mem2node.h"
+#include "c2c.h"
 #include "pmus.h"
 #include "session.h"
 #include "sort.h"
@@ -52,75 +53,9 @@
 #include "util/symbol.h"
 #include "util/util.h"
 
-struct c2c_hists {
-	struct hists		hists;
-	struct perf_hpp_list	list;
-	struct c2c_stats	stats;
-};
-
-struct compute_stats {
-	struct stats		 lcl_hitm;
-	struct stats		 rmt_hitm;
-	struct stats		 lcl_peer;
-	struct stats		 rmt_peer;
-	struct stats		 load;
-};
-
-struct c2c_hist_entry {
-	struct c2c_hists	*hists;
-	struct evsel		*evsel;
-	struct c2c_stats	 stats;
-	unsigned long		*cpuset;
-	unsigned long		*nodeset;
-	struct c2c_stats	*node_stats;
-	unsigned int		 cacheline_idx;
-
-	struct compute_stats	 cstats;
-
-	unsigned long		 paddr;
-	unsigned long		 paddr_cnt;
-	bool			 paddr_zero;
-	char			*nodestr;
-
-	/*
-	 * must be at the end,
-	 * because of its callchain dynamic entry
-	 */
-	struct hist_entry	he;
-};
 
 static char const *coalesce_default = "iaddr";
 
-struct perf_c2c {
-	struct perf_tool	tool;
-	struct c2c_hists	hists;
-	struct mem2node		mem2node;
-
-	unsigned long		**nodes;
-	int			 nodes_cnt;
-	int			 cpus_cnt;
-	int			*cpu2node;
-	int			 node_info;
-
-	bool			 show_src;
-	bool			 show_all;
-	bool			 use_stdio;
-	bool			 stats_only;
-	bool			 symbol_full;
-	bool			 stitch_lbr;
-
-	/* Shared cache line stats */
-	struct c2c_stats	shared_clines_stats;
-	int			shared_clines;
-
-	int			 display;
-
-	const char		*coalesce;
-	char			*cl_sort;
-	char			*cl_resort;
-	char			*cl_output;
-};
-
 enum {
 	DISPLAY_LCL_HITM,
 	DISPLAY_RMT_HITM,
@@ -141,9 +76,9 @@ static const struct option c2c_options[] = {
 	OPT_END()
 };
 
-static struct perf_c2c c2c;
+struct perf_c2c c2c;
 
-static void *c2c_he_zalloc(size_t size)
+void *c2c_he_zalloc(size_t size)
 {
 	struct c2c_hist_entry *c2c_he;
 
@@ -458,36 +393,6 @@ static const char * const __usage_report[] = {
 
 static const char * const *report_c2c_usage = __usage_report;
 
-#define C2C_HEADER_MAX 2
-
-struct c2c_header {
-	struct {
-		const char *text;
-		int	    span;
-	} line[C2C_HEADER_MAX];
-};
-
-struct c2c_dimension {
-	struct c2c_header	 header;
-	const char		*name;
-	int			 width;
-	struct sort_entry	*se;
-
-	int64_t (*cmp)(struct perf_hpp_fmt *fmt,
-		       struct hist_entry *, struct hist_entry *);
-	int   (*entry)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
-		       struct hist_entry *he);
-	int   (*color)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
-		       struct hist_entry *he);
-};
-
-struct c2c_fmt {
-	struct perf_hpp_fmt	 fmt;
-	struct c2c_dimension	*dim;
-};
-
-#define SYMBOL_WIDTH 30
-
 static struct c2c_dimension dim_symbol;
 static struct c2c_dimension dim_srcline;
 
@@ -1389,23 +1294,6 @@ cl_idx_empty_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, "");
 }
 
-#define HEADER_LOW(__h)			\
-	{				\
-		.line[1] = {		\
-			.text = __h,	\
-		},			\
-	}
-
-#define HEADER_BOTH(__h0, __h1)		\
-	{				\
-		.line[0] = {		\
-			.text = __h0,	\
-		},			\
-		.line[1] = {		\
-			.text = __h1,	\
-		},			\
-	}
-
 #define HEADER_SPAN(__h0, __h1, __s)	\
 	{				\
 		.line[0] = {		\
@@ -1928,7 +1816,7 @@ static struct c2c_dimension *dimensions[] = {
 	NULL,
 };
 
-static void fmt_free(struct perf_hpp_fmt *fmt)
+void c2c_fmt_free(struct perf_hpp_fmt *fmt)
 {
 	struct c2c_fmt *c2c_fmt;
 
@@ -1936,7 +1824,7 @@ static void fmt_free(struct perf_hpp_fmt *fmt)
 	free(c2c_fmt);
 }
 
-static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
+bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
 {
 	struct c2c_fmt *c2c_a = container_of(a, struct c2c_fmt, fmt);
 	struct c2c_fmt *c2c_b = container_of(b, struct c2c_fmt, fmt);
@@ -2021,8 +1909,8 @@ static struct c2c_fmt *get_format(const char *name)
 	fmt->header	= c2c_header;
 	fmt->width	= c2c_width;
 	fmt->collapse	= dim->se ? c2c_se_collapse : dim->cmp;
-	fmt->equal	= fmt_equal;
-	fmt->free	= fmt_free;
+	fmt->equal	= c2c_fmt_equal;
+	fmt->free	= c2c_fmt_free;
 
 	return c2c_fmt;
 }
@@ -2710,7 +2598,7 @@ c2c_cacheline_browser__new(struct hists *hists, struct hist_entry *he)
 	return browser;
 }
 
-static int perf_c2c__browse_cacheline(struct hist_entry *he)
+int perf_c2c__browse_cacheline(struct hist_entry *he)
 {
 	struct c2c_hist_entry *c2c_he;
 	struct c2c_hists *c2c_hists;
diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
new file mode 100644
index 000000000000..79dbd35184ed
--- /dev/null
+++ b/tools/perf/c2c.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _PERF_C2C_H_
+#define _PERF_C2C_H_ 1
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <linux/types.h>
+#include "util/stat.h"
+#include "util/hist.h"
+#include "util/mem-events.h"
+#include "util/mem2node.h"
+#include "util/tool.h"
+
+struct sort_entry;
+
+struct compute_stats {
+	struct stats		 lcl_hitm;
+	struct stats		 rmt_hitm;
+	struct stats		 lcl_peer;
+	struct stats		 rmt_peer;
+	struct stats		 load;
+};
+
+struct c2c_hists {
+	struct hists		hists;
+	struct perf_hpp_list	list;
+	struct c2c_stats	stats;
+};
+
+struct c2c_hist_entry {
+	struct c2c_hists	*hists;
+	struct evsel		*evsel;
+	struct c2c_stats	 stats;
+	unsigned long		*cpuset;
+	unsigned long		*nodeset;
+	struct c2c_stats	*node_stats;
+	unsigned int		 cacheline_idx;
+
+	struct compute_stats	 cstats;
+
+	unsigned long		 paddr;
+	unsigned long		 paddr_cnt;
+	bool			 paddr_zero;
+	char			*nodestr;
+
+	/*
+	 * Function view only: cached sum of the level-2 children's store
+	 * counts, accumulated while the hierarchy is built. Lets the
+	 * total-stores column and its sort comparator avoid an O(children)
+	 * walk on every access. Unused by the cacheline view.
+	 */
+	u64			 child_stores;
+
+	/*
+	 * must be at the end,
+	 * because of its callchain dynamic entry
+	 */
+	struct hist_entry	he;
+};
+
+struct perf_c2c {
+	struct perf_tool	tool;
+	struct c2c_hists	hists;
+	struct mem2node		mem2node;
+
+	unsigned long		**nodes;
+	int			 nodes_cnt;
+	int			 cpus_cnt;
+	int			*cpu2node;
+	int			 node_info;
+
+	bool			 show_src;
+	bool			 show_all;
+	bool			 use_stdio;
+	bool			 stats_only;
+	bool			 symbol_full;
+	bool			 stitch_lbr;
+
+	/* Shared cache line stats */
+	struct c2c_stats	shared_clines_stats;
+	int			shared_clines;
+
+	int			 display;
+
+	const char		*coalesce;
+	char			*cl_sort;
+	char			*cl_resort;
+	char			*cl_output;
+};
+
+extern struct perf_c2c c2c;
+
+#define C2C_HEADER_MAX 2
+#define SYMBOL_WIDTH 30
+
+#define HEADER_LOW(__h)			\
+	{				\
+		.line[1] = {		\
+			.text = __h,	\
+		},			\
+	}
+
+#define HEADER_BOTH(__h0, __h1)		\
+	{				\
+		.line[0] = {		\
+			.text = __h0,	\
+		},			\
+		.line[1] = {		\
+			.text = __h1,	\
+		},			\
+	}
+
+struct c2c_header {
+	struct {
+		const char *text;
+		int	    span;
+	} line[C2C_HEADER_MAX];
+};
+
+struct c2c_dimension {
+	struct c2c_header	 header;
+	const char		*name;
+	int			 width;
+	struct sort_entry	*se;
+
+	int64_t	(*cmp)(struct perf_hpp_fmt *fmt,
+		       struct hist_entry *left, struct hist_entry *right);
+	int	(*entry)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			 struct hist_entry *he);
+	int	(*color)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			 struct hist_entry *he);
+};
+
+struct c2c_fmt {
+	struct perf_hpp_fmt	 fmt;
+	struct c2c_dimension	*dim;
+};
+
+void *c2c_he_zalloc(size_t size);
+void c2c_fmt_free(struct perf_hpp_fmt *fmt);
+bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
+
+#ifdef HAVE_SLANG_SUPPORT
+int perf_c2c__browse_cacheline(struct hist_entry *he);
+#endif
+
+#endif /* _PERF_C2C_H_ */
-- 
2.52.0

