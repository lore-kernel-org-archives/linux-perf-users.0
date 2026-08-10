Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072CA31D757;
	Mon, 10 Aug 2026 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339232; cv=none; b=ipK4o1IcYsOUigVyeO8u1R6HawIqjHanaYRVFhJsa4pApIkMI2oICti0HvXoWysZrV4BNjuDyjlJUFZM+wrYIRjZ+xli9B4Intf7Qrbc5lZbHvtGCfk4FsNdVmp31l3+JBDN92vo6qHSkkWgk4ZI+BBvMebkjLL6uwrFZCoRBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339232; c=relaxed/simple;
	bh=aGccxa/C7KZwPmaAGR556pf1Jootp0yE71Q7urZLG1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4s/KVH8jD2gRqHWqkf/3M8TlGfL554J3pECRCoca2sGAdOk+hssWdkmYUZuEr00u7iXTtZYulKAWWQLFAgxCfmsXH//PO59poYVaC9K6c2hc3BEXSBUo/uRpnZY/vFHu97hksON2/PSZQHj6x4fUX/e9nLBx0/HI2O4nT8l6uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNVV/686; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNVV/686"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786339228; x=1817875228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aGccxa/C7KZwPmaAGR556pf1Jootp0yE71Q7urZLG1s=;
  b=PNVV/686+M45ildPW1OhJN5lEQ3q+a3RjrWaG1PObDKKtSAQuz11fVJs
   g7TkuaTh/VqRA2ghSn4rovHfKjDXg5a8uNqEp3TjSxVJ4PhzIGjpVA227
   OvmzLu/EqLK1iAAKNmGhM14bjrj0PijCx2Ej/8c8V8d8CVpIIPd1PCBfB
   v3rFtzavsQ+3QDLbQQxsxZkOj+iN0dK2gei7fXLflpl5cGAI64IjMVEX+
   B4rDD2VH2/zwskuycT63o5KfT/ZH6IBnpstZ2ncPQcCgaSm3KfJ0zyVmr
   eSb0XRffe0XMhS15z5oThPvMM+FsIhxLbxAG5eb/5hx5Eo4Ul1C5jOh6K
   g==;
X-CSE-ConnectionGUID: iyAH+WhkTKOUuUXFuN13qw==
X-CSE-MsgGUID: GB2PBB6GRo+YCDuIyl3CYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86784987"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86784987"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 22:20:27 -0700
X-CSE-ConnectionGUID: /EUjJVcvTG+MWxNNUA+Cnw==
X-CSE-MsgGUID: trDCj/WGSP6aQAz2+YaOfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="262421455"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa008.jf.intel.com with ESMTP; 09 Aug 2026 22:20:25 -0700
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
Subject: [PATCH v8 2/9] perf c2c: add function view browser skeleton
Date: Mon, 10 Aug 2026 13:26:40 +0800
Message-ID: <20260810052647.588867-3-jiebin.sun@intel.com>
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

Introduce the TUI entry point for the c2c function view and connect it to
the cacheline browser through the TAB key. Add the browser object, its
Build entry, the public declaration, and the corresponding help text.
Later patches fill in the browser implementation.

The browser needs the cacheline histograms, the --coalesce field list,
symbol_full, and the cacheline detail entry point. Pass them through
struct c2c_function_view_args instead of referencing builtin-c2c.c state
directly. This keeps c2c-function.o free of command-private references, so
it can remain in libperf-ui.a even though that archive is also linked into
python/perf.so without the builtin command objects.

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
 tools/perf/builtin-c2c.c              | 10 ++++
 tools/perf/ui/browsers/Build          |  1 +
 tools/perf/ui/browsers/c2c-function.c | 81 +++++++++++++++++++++++++++
 tools/perf/util/c2c.h                 | 30 ++++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 tools/perf/ui/browsers/c2c-function.c

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 16b00a36fdfc..715b75d42f2a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2745,11 +2745,18 @@ perf_c2c_browser__new(struct hists *hists)
 
 static int perf_c2c__hists_browse(struct hists *hists)
 {
+	struct c2c_function_view_args func_args = {
+		.cl_hists	  = &c2c.hists,
+		.cl_sort	  = c2c.cl_sort,
+		.symbol_full	  = c2c.symbol_full,
+		.browse_cacheline = perf_c2c__browse_cacheline,
+	};
 	struct hist_browser *browser;
 	int key = -1;
 	static const char help[] =
 	" d             Display cacheline details \n"
 	" ENTER         Toggle callchains (if present) \n"
+	" TAB           Switch to function view\n"
 	" q             Quit \n";
 
 	browser = perf_c2c_browser__new(hists);
@@ -2771,6 +2778,9 @@ static int perf_c2c__hists_browse(struct hists *hists)
 		case 'd':
 			perf_c2c__browse_cacheline(browser->he_selection);
 			break;
+		case '\t':
+			perf_c2c__browse_function_view(&func_args);
+			break;
 		case '?':
 			ui_browser__help_window(&browser->b, help);
 			break;
diff --git a/tools/perf/ui/browsers/Build b/tools/perf/ui/browsers/Build
index a07489e44765..ae67a2161f7d 100644
--- a/tools/perf/ui/browsers/Build
+++ b/tools/perf/ui/browsers/Build
@@ -5,3 +5,4 @@ perf-ui-y += map.o
 perf-ui-y += scripts.o
 perf-ui-y += header.o
 perf-ui-y += res_sample.o
+perf-ui-y += c2c-function.o
diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
new file mode 100644
index 000000000000..387175a9a90c
--- /dev/null
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C2C Function Browser - function-level cacheline sharing analysis
+ *
+ * Displays a 3-level hierarchy showing which functions share cachelines:
+ *   Level 1: Read-side functions sorted by Cycles % (estimated load cycles)
+ *   Level 2: Functions sampled writing the shared lines read by level 1
+ *   Level 3: The specific cachelines where the two functions contend
+ *
+ * Builds the hierarchy from the existing cacheline histograms
+ * (c2c_hist_entry->hists), reusing the shared c2c data structures.
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdlib.h>
+#include <string.h>
+#include <tools/libc_compat.h> /* reallocarray */
+#include <asm/bug.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/zalloc.h>
+
+#include "../browser.h"
+#include "../keysyms.h"
+#include "../libslang.h"
+#include "../ui.h"
+#include "../../util/addr_location.h"
+#include "../../util/cacheline.h"
+#include "../../util/debug.h"
+#include "../../util/hist.h"
+#include "../../util/map.h"
+#include "../../util/mem-events.h"
+#include "../../util/mem-info.h"
+#include "../../util/sort.h"
+#include "../../util/symbol.h"
+#include "../../util/thread.h"
+#include "../../util/c2c.h"
+#include "hists.h"
+
+struct perf_c2c_ext {
+	struct c2c_hists	function_hists;
+	/* Total estimated cycles across all level-1 entries. */
+	u64			total_cycles;
+	/* What the c2c command passed in; not owned here. */
+	struct c2c_function_view_args *args;
+};
+
+static struct perf_c2c_ext c2c_ext __maybe_unused;
+
+struct c2c_function_browser {
+	struct hist_browser	hb;
+};
+
+static inline __maybe_unused u64 c2c_hitm_count(const struct c2c_stats *stats)
+{
+	return stats->tot_hitm;
+}
+
+static inline __maybe_unused bool symbol_name_equal(struct symbol *a, struct symbol *b)
+{
+	/* Two unknown symbols compare equal, matching cmp_null() in util/sort.c. */
+	if (!a || !b)
+		return a == b;
+	return arch__compare_symbol_names(a->name, b->name) == 0;
+}
+
+static inline __maybe_unused u64 hist_entry__iaddr(struct hist_entry *he)
+{
+	if (he->mem_info)
+		return mem_info__iaddr(he->mem_info)->addr;
+	return he->ip;
+}
+
+int perf_c2c__browse_function_view(struct c2c_function_view_args *args)
+{
+	c2c_ext.args = args;
+
+	ui__warning("C2C function view is not implemented yet.\n");
+	return 0;
+}
diff --git a/tools/perf/util/c2c.h b/tools/perf/util/c2c.h
index bd0c9d1c9a1a..a80be07eaa83 100644
--- a/tools/perf/util/c2c.h
+++ b/tools/perf/util/c2c.h
@@ -98,4 +98,34 @@ struct c2c_fmt {
 void c2c_fmt_free(struct perf_hpp_fmt *fmt);
 bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
 
+/*
+ * Everything the function view browser needs from the c2c command, passed in
+ * by the caller so the browser does not reference command-private state.
+ */
+struct c2c_function_view_args {
+	/* Source cacheline histograms to build the hierarchy from. */
+	struct c2c_hists	*cl_hists;
+	/* --coalesce field list, used to require iaddr. */
+	const char		*cl_sort;
+	/* Do not cap long symbol names. */
+	bool			 symbol_full;
+	/* Open the cacheline detail view for @he. */
+	int			(*browse_cacheline)(struct hist_entry *he);
+};
+
+/*
+ * The TUI browser is only built with SLANG support. The stub below keeps the
+ * header self-contained for NO_SLANG builds, as util/hist.h does for its own
+ * TUI entry points.
+ */
+#ifdef HAVE_SLANG_SUPPORT
+int perf_c2c__browse_function_view(struct c2c_function_view_args *args);
+#else
+static inline int
+perf_c2c__browse_function_view(struct c2c_function_view_args *args __maybe_unused)
+{
+	return 0;
+}
+#endif
+
 #endif /* __PERF_UTIL_C2C_H */
-- 
2.52.0

