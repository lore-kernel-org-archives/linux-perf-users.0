Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98051395ACA;
	Mon, 10 Aug 2026 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339228; cv=none; b=RvlKbrOskPp7gSDQxrc99E8rYqgGh85ahaWNUwfVlKXAx3zYuqTKqB2soKP9GVDnPuZcr6Oo9mZRkwmH0TlvwdXvd6pK+FP+5WrqoKdXf8Oea1DESKHRWIbEi+6ATv8r8niyGzjAExTk9XeSRH87mEsDUd0q6YWVc3px9KUaLUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339228; c=relaxed/simple;
	bh=S0DMSeXdY68SdtNAzrj1EzQtUUnR26fwGLAGZ+lq3wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJg6ZLyRUiFi8xUWcwauQA9xgOr8sEiZxm83jtm7uOeOdCSZ6X6S5+54C06yxKwI0epSzHu3rDxJTSEMCJW81xCCIXWsiSeyYIBHTc/1cgTNcnPtOZo1SitZpqcBRd3A9oPMPdMtQ1WKiVqUyKAOLxnFAAmhisa216ZYtU9H3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1MmWmbJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1MmWmbJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786339225; x=1817875225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S0DMSeXdY68SdtNAzrj1EzQtUUnR26fwGLAGZ+lq3wg=;
  b=E1MmWmbJOROaZtTwasvrGUN6jx4GndKLfdLIfC1Jg/+Dx+E0Or25aA3W
   N6lGnepBNGVU3IDLLP7OtJvWCYaeRmF+ITu5ak+6ngyuvy+T6V8yYxDU/
   nfmUgQN8k1KF20sGUZ4o+Ppp0IC4wNxvN7/2AumhxnbGsQX548p9qhRT4
   mfxNeI3pioP77ERhOI1ihSkwAShm+RLb4kDtHqQDj3czQSB6PmwPioKRc
   dP/c0fBscylJARHfkT3tG6Zyiea50gXAv0pS53AkvTpMgUtlY6k3FCwMT
   3v/GgvsX/JIWfNC6sOlUeMqmrDaL+pcLKukPnLwvZr2lbVpmeVEyXCRHv
   g==;
X-CSE-ConnectionGUID: ozG9a7hTQrCnAm4zx8wCsw==
X-CSE-MsgGUID: o6B3w35vRWaDwRbGmGc6Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86784980"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86784980"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 22:20:24 -0700
X-CSE-ConnectionGUID: pwGKs6PzQGa//VUJagCBLQ==
X-CSE-MsgGUID: R7PEwtuzT3Cxb4zNVBm33g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="262421446"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa008.jf.intel.com with ESMTP; 09 Aug 2026 22:20:21 -0700
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
Subject: [PATCH v8 1/9] perf c2c: extract shared data structures into util/c2c.h
Date: Mon, 10 Aug 2026 13:26:39 +0800
Message-ID: <20260810052647.588867-2-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260810052647.588867-1-jiebin.sun@intel.com>
References: <20260810052647.588867-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function browser belongs in libperf-ui.a, but that archive is also
linked into python/perf.so, where builtin command objects are unavailable.
The browser therefore cannot depend on types or callbacks owned by
builtin-c2c.c.

Move c2c_hists, compute_stats, c2c_hist_entry, and the shared column
formatting definitions from builtin-c2c.c to a new util/c2c.h. Move
c2c_fmt_free() and c2c_fmt_equal() to a new util/c2c.c.

Keep struct perf_c2c, the command instance, and
perf_c2c__browse_cacheline() private to builtin-c2c.c.

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
 tools/perf/builtin-c2c.c | 105 ++-------------------------------------
 tools/perf/util/Build    |   1 +
 tools/perf/util/c2c.c    |  21 ++++++++
 tools/perf/util/c2c.h    | 101 +++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+), 102 deletions(-)
 create mode 100644 tools/perf/util/c2c.c
 create mode 100644 tools/perf/util/c2c.h

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index bc16a57e0927..16b00a36fdfc 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -52,46 +52,10 @@
 #include "ui/progress.h"
 #include "ui/ui.h"
 #include "util/annotate.h"
+#include "util/c2c.h"
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
-
 static char const *coalesce_default = "iaddr";
 
 struct perf_c2c {
@@ -460,36 +424,6 @@ static const char * const __usage_report[] = {
 
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
 
@@ -1391,23 +1325,6 @@ cl_idx_empty_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
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
@@ -1930,22 +1847,6 @@ static struct c2c_dimension *dimensions[] = {
 	NULL,
 };
 
-static void fmt_free(struct perf_hpp_fmt *fmt)
-{
-	struct c2c_fmt *c2c_fmt;
-
-	c2c_fmt = container_of(fmt, struct c2c_fmt, fmt);
-	free(c2c_fmt);
-}
-
-static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
-{
-	struct c2c_fmt *c2c_a = container_of(a, struct c2c_fmt, fmt);
-	struct c2c_fmt *c2c_b = container_of(b, struct c2c_fmt, fmt);
-
-	return c2c_a->dim == c2c_b->dim;
-}
-
 static struct c2c_dimension *get_dimension(const char *name)
 {
 	unsigned int i;
@@ -2023,8 +1924,8 @@ static struct c2c_fmt *get_format(const char *name)
 	fmt->header	= c2c_header;
 	fmt->width	= c2c_width;
 	fmt->collapse	= dim->se ? c2c_se_collapse : dim->cmp;
-	fmt->equal	= fmt_equal;
-	fmt->free	= fmt_free;
+	fmt->equal	= c2c_fmt_equal;
+	fmt->free	= c2c_fmt_free;
 
 	return c2c_fmt;
 }
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 330311cac550..1dfd92cbe3b7 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -11,6 +11,7 @@ perf-util-y += blake2s.o
 perf-util-y += block-info.o
 perf-util-y += block-range.o
 perf-util-y += build-id.o
+perf-util-y += c2c.o
 perf-util-y += cacheline.o
 perf-util-$(CONFIG_LIBCAPSTONE) += capstone.o
 perf-util-y += config.o
diff --git a/tools/perf/util/c2c.c b/tools/perf/util/c2c.c
new file mode 100644
index 000000000000..58c7342dff46
--- /dev/null
+++ b/tools/perf/util/c2c.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <linux/kernel.h>
+#include "hist.h"
+#include "c2c.h"
+
+void c2c_fmt_free(struct perf_hpp_fmt *fmt)
+{
+	struct c2c_fmt *c2c_fmt;
+
+	c2c_fmt = container_of(fmt, struct c2c_fmt, fmt);
+	free(c2c_fmt);
+}
+
+bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
+{
+	struct c2c_fmt *c2c_a = container_of(a, struct c2c_fmt, fmt);
+	struct c2c_fmt *c2c_b = container_of(b, struct c2c_fmt, fmt);
+
+	return c2c_a->dim == c2c_b->dim;
+}
diff --git a/tools/perf/util/c2c.h b/tools/perf/util/c2c.h
new file mode 100644
index 000000000000..bd0c9d1c9a1a
--- /dev/null
+++ b/tools/perf/util/c2c.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_UTIL_C2C_H
+#define __PERF_UTIL_C2C_H
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <linux/types.h>
+#include "hist.h"
+#include "mem-events.h"
+#include "stat.h"
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
+#endif /* __PERF_UTIL_C2C_H */
-- 
2.52.0

