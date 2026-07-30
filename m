Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36773AAF52;
	Thu, 30 Jul 2026 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402039; cv=none; b=L3Yv+JRPtvOuwGoMHJEyWCEqL0loU7pjyx31aBwvBM/eudWzjI2WCwx8F5VLpy1JIRqZV4gwJf7MPByht81pltIM7Ea0QjTQuxPcIjPLhzK2/4xn4RvPCGBw2x++/VMzcykvymtEOMCfjXwLjpAVzuYd1pu0SfOtKYn+qXHhudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402039; c=relaxed/simple;
	bh=kUdrs87A5e4ns8x2DcaIChQxUdse/sHudbsEtwmDhz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLkyNNPJTBN2L9GRF6TDNeP4f9x8tC7Xku9AUPSzZ897yUZn4xIyRbHQaTIp/jC+fUne25KXt41khqeNetBpy8RSg+cWxOzvN+OlMFDmVFp29gBiBFk3n6WItttyxI9XTij1M8Ja/NIHPXIXv4a7BHlc0wfNBuTATNUMaz8kmaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPNRjL8V; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPNRjL8V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785402037; x=1816938037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kUdrs87A5e4ns8x2DcaIChQxUdse/sHudbsEtwmDhz0=;
  b=MPNRjL8VsiAsYsozTMMcSa6aoLO0CroH20Zt5y+jnQmYOGjLKsJp6ErH
   eFAqJinlkNMnUqm7l9aiHe4XoKDe0E3xIbYv1tqSywUMOxEbMa4gRM1Xv
   F+paSiHbzM8aTTaLJ5Lr3MuFLKqHpRSppLtsZmPEJTn8Ipw1mvCOdyY0s
   DFe6sCPdSPUddcPnZHf2euxeuvilUVOFVHsl20H1m+2S4ee87mw7n7jHm
   /sY3/DLMpwi9hAZlHClzGvg66CMMTfLwTOBzl42ekbzYfQt/GA1fKCLhx
   BMb+uykUQnhTurJ1H/LKh7l5V4i4K3XkphWCGxG85zgaZTL0aJ5I+Hma+
   Q==;
X-CSE-ConnectionGUID: YdoQQFBkR6y/idyUNfcKZA==
X-CSE-MsgGUID: kX9dEqCuR7i7Wbhzp7RdEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="111563449"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="111563449"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 02:00:36 -0700
X-CSE-ConnectionGUID: NJxS4er+SC6MiG7VxfjAIQ==
X-CSE-MsgGUID: c+8Cr3SgRdeqni5CDUSxFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="260846449"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa009.jf.intel.com with ESMTP; 30 Jul 2026 02:00:33 -0700
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
	Jiebin Sun <jiebin.sun@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>
Subject: [PATCH v5 v5 1/9] perf c2c: extract shared data structures into c2c.h
Date: Thu, 30 Jul 2026 17:05:13 +0800
Message-ID: <20260730090521.2206375-2-jiebin.sun@intel.com>
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
Cc: Dapeng Mi <dapeng1.mi@intel.com>
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
 tools/perf/builtin-c2c.c | 126 ++--------------------------------
 tools/perf/c2c.h         | 144 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 119 deletions(-)
 create mode 100644 tools/perf/c2c.h

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c9584dbedf77..39f70ef6597b 100644
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
@@ -141,7 +76,7 @@ static const struct option c2c_options[] = {
 	OPT_END()
 };
 
-static struct perf_c2c c2c;
+struct perf_c2c c2c;
 
 static void *c2c_he_zalloc(size_t size)
 {
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
index 000000000000..ab7adb85d9c0
--- /dev/null
+++ b/tools/perf/c2c.h
@@ -0,0 +1,144 @@
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
+ * The TUI browsers are only built with SLANG support. Their sole callers
+ * live inside HAVE_SLANG_SUPPORT-guarded code in builtin-c2c.c (stdio mode
+ * forces use_browser=0), so no #else stub is needed -- matching the rest of
+ * perf's TUI entry points.
+ */
+#ifdef HAVE_SLANG_SUPPORT
+int perf_c2c__browse_cacheline(struct hist_entry *he);
+#endif
+
+#endif /* _PERF_C2C_H_ */
-- 
2.52.0

