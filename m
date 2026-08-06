Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E705C3DA5BB;
	Thu,  6 Aug 2026 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001740; cv=none; b=LhAoJZIbzZRyYYjEXa3jSQFT+otkOFyo4iD2EQKX0Zy4fmvWQhrfQebtORhYxnqgH803YdR0Cv4nEdtSqTR7ZPZefhh8DC8P4NBl79zCo4ZjXDQmmUnCOtC/pkac9JX26bxy+UQfDJmrDYRae1q4Vy/SG3/tXiAGWV8jlLqPYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001740; c=relaxed/simple;
	bh=6rak8QGQtEyncjsuASMLYYyO1j6guEbwWIayVTnmmxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRiZNxHtvuesTP50W9kAs3wJHQb0j0WysfXZHCnYSAX+owWX+ei0BjD5VpZbh0WJBCZ+nOlVLltgC47HMi6QEqWnW8OdsuL/QzldQpADZoGdbe/6AvX08swyP1qFLmL2LB7a+0sd2l8T7iUdGYq7d+/8PoGHb3x38Cnf9aMKP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRGmEjAZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRGmEjAZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786001738; x=1817537738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6rak8QGQtEyncjsuASMLYYyO1j6guEbwWIayVTnmmxg=;
  b=ZRGmEjAZegEAH/OVetvPth245NN1FuxoisBxYrpGlNc3kDF4ZaXqBKHG
   a1yc+ox0Z4Ii7sjlPGD/hHwBfQ5e/Ye6f24NFqfOJWGWUUPY6sc2rDXcY
   R9iLjKxoFLcc73h++s7FYQYjXJVAURHQKIn634kiD0396woKoE+suKSt6
   PfqZ6IidLX215t3JQqf7wT2DGkqzjQNaKhwmDdOJAd6VUnQqLkQU0i57g
   cL9bx8E5dt7fj+9FbZrmbisNH4PO99BWoUzO/ixZp4ZB7/uQDCdNg9HJu
   pPyakWgP4kZmcs45mv9VeqrqTu0xs1sfztMS3Bo6n7a8WCflWsdOdj7uK
   A==;
X-CSE-ConnectionGUID: wC03+OOwSBGGpr+ikXr6kA==
X-CSE-MsgGUID: nfhOa6AZT9W5fw6jmOQvRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86440463"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86440463"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 00:35:38 -0700
X-CSE-ConnectionGUID: f+3U9ljrQ9SGmDm3uZnPAw==
X-CSE-MsgGUID: 1zLlVUPEQp2kQ1S55tlZmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="300245435"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa001.jf.intel.com with ESMTP; 06 Aug 2026 00:35:35 -0700
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
Subject: [PATCH v7 1/9] perf c2c: extract shared data structures into c2c.h
Date: Thu,  6 Aug 2026 15:42:09 +0800
Message-ID: <20260806074217.2846596-2-jiebin.sun@intel.com>
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

Move c2c_hists, compute_stats, c2c_hist_entry, perf_c2c, and the shared
column-formatting structures and macros from builtin-c2c.c into a new
shared header c2c.h. This allows the upcoming function view browser
(c2c-function.c) to reuse these types and formatting definitions.

Make the global perf_c2c instance 'c2c' non-static, export
perf_c2c__browse_cacheline(), and export c2c_fmt_free() and
c2c_fmt_equal() for use by the new function view module.

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
 tools/perf/builtin-c2c.c | 126 ++-------------------------------
 tools/perf/c2c.h         | 149 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+), 119 deletions(-)
 create mode 100644 tools/perf/c2c.h

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index bc16a57e0927..4a3cf8c906f9 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -41,6 +41,7 @@
 #include "mem-events.h"
 #include "mem-info.h"
 #include "mem2node.h"
+#include "c2c.h"
 #include "pmus.h"
 #include "session.h"
 #include "sort.h"
@@ -55,75 +56,9 @@
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
@@ -144,7 +79,7 @@ static const struct option c2c_options[] = {
 	OPT_END()
 };
 
-static struct perf_c2c c2c;
+struct perf_c2c c2c;
 
 static void *c2c_he_zalloc(size_t size)
 {
@@ -460,36 +395,6 @@ static const char * const __usage_report[] = {
 
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
 
@@ -1391,23 +1296,6 @@ cl_idx_empty_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
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
@@ -1930,7 +1818,7 @@ static struct c2c_dimension *dimensions[] = {
 	NULL,
 };
 
-static void fmt_free(struct perf_hpp_fmt *fmt)
+void c2c_fmt_free(struct perf_hpp_fmt *fmt)
 {
 	struct c2c_fmt *c2c_fmt;
 
@@ -1938,7 +1826,7 @@ static void fmt_free(struct perf_hpp_fmt *fmt)
 	free(c2c_fmt);
 }
 
-static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
+bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
 {
 	struct c2c_fmt *c2c_a = container_of(a, struct c2c_fmt, fmt);
 	struct c2c_fmt *c2c_b = container_of(b, struct c2c_fmt, fmt);
@@ -2023,8 +1911,8 @@ static struct c2c_fmt *get_format(const char *name)
 	fmt->header	= c2c_header;
 	fmt->width	= c2c_width;
 	fmt->collapse	= dim->se ? c2c_se_collapse : dim->cmp;
-	fmt->equal	= fmt_equal;
-	fmt->free	= fmt_free;
+	fmt->equal	= c2c_fmt_equal;
+	fmt->free	= c2c_fmt_free;
 
 	return c2c_fmt;
 }
@@ -2754,7 +2642,7 @@ c2c_cacheline_browser__new(struct hists *hists, struct hist_entry *he)
 	return browser;
 }
 
-static int perf_c2c__browse_cacheline(struct hist_entry *he)
+int perf_c2c__browse_cacheline(struct hist_entry *he)
 {
 	struct c2c_hist_entry *c2c_he;
 	struct c2c_hists *c2c_hists;
diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
new file mode 100644
index 000000000000..aac01d4f6760
--- /dev/null
+++ b/tools/perf/c2c.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _PERF_C2C_H_
+#define _PERF_C2C_H_ 1
+
+#include <stdbool.h>
+#include <linux/types.h>
+#include "util/stat.h"
+#include "util/hist.h"
+#include "util/mem-events.h"
+#include "util/mem2node.h"
+#include "util/tool.h"
+
+struct sort_entry;
+
+struct c2c_hists {
+	struct hists		hists;
+	struct perf_hpp_list	list;
+	struct c2c_stats	stats;
+};
+
+struct compute_stats {
+	struct stats		 lcl_hitm;
+	struct stats		 rmt_hitm;
+	struct stats		 lcl_peer;
+	struct stats		 rmt_peer;
+	struct stats		 load;
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
+	int64_t (*cmp)(struct perf_hpp_fmt *fmt,
+		       struct hist_entry *left, struct hist_entry *right);
+	int   (*entry)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he);
+	int   (*color)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he);
+};
+
+struct c2c_fmt {
+	struct perf_hpp_fmt	 fmt;
+	struct c2c_dimension	*dim;
+};
+
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
+void c2c_fmt_free(struct perf_hpp_fmt *fmt);
+bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
+
+/*
+ * The TUI browser is only built with SLANG support. The stub below keeps the
+ * header self-contained for NO_SLANG builds, as util/hist.h does for its own
+ * TUI entry points.
+ */
+#ifdef HAVE_SLANG_SUPPORT
+int perf_c2c__browse_cacheline(struct hist_entry *he);
+#else
+static inline int
+perf_c2c__browse_cacheline(struct hist_entry *he __maybe_unused)
+{
+	return 0;
+}
+#endif
+
+#endif /* _PERF_C2C_H_ */
-- 
2.52.0

