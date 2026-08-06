Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739243D4123;
	Thu,  6 Aug 2026 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001744; cv=none; b=EGlnNYInL8pNIR3kk2TT8CQAa3IcuJf996H99m2LOD9Kn8HSL8rrsNvJQBvo5NR0OFoUO1sxOg9LXQ22cYlOktvDAR+oTd0u05+VgpByQ6y06ClXTVC5v9yYehaFqKuMvObS/3HO5aB8NaTwa5adqpGNtWDY44nwdh5yL2K0VhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001744; c=relaxed/simple;
	bh=6e5bBOv5joGiouv/qD8GBwzDQczdqBvsdDnHneMOJhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/zAshsi2kd15ZvKfHvgiHhVn1Znypan2x7K7LX47tTNM/CfiHud4cxhBZ1qoc5of8rKuRW3M38xmGYQy808713MquS/nexGaie+FhwcOp1oHQbX0Hb+mrsqujPp8hb7Ymn0cVACai0ncx5pq+H5UV8AgdliBUvndxXaslKXF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KC9AI6bA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KC9AI6bA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786001742; x=1817537742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6e5bBOv5joGiouv/qD8GBwzDQczdqBvsdDnHneMOJhY=;
  b=KC9AI6bAmMxqMaCsTknPlTTcoxVxpewW6XvCC8N3snaZYuwt2+uI192m
   9+BQvTrid31/z8YotIWSwbvC9cWFrFNWFdostiK0KsSz6Lr+70GotT/8F
   0hFICWdDUzw8wKgP5OdECw5lLreZiesUdJqkcV0B9uxpSGmwojddTZF53
   yamSg0CuJaFHiXwjBsLPT1fEz6wCI9mt0E1c9zpZXbLItr43nPgk1DXGg
   onCwQqk44lkI3+RK9XyRES8KJUWSq9BDSlL3YCiDg4MU1dIDzDkWntQ+S
   0oyr32I2DsvtT9xvbWW9bAGiY6E4Ua1a5dZ7j3rHIh58Bp7expFOAqKUN
   w==;
X-CSE-ConnectionGUID: VDS58oW9R8aXVrKzxC2fCQ==
X-CSE-MsgGUID: YT2VtaxpQaOvfbjKSy0I7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86440472"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86440472"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 00:35:41 -0700
X-CSE-ConnectionGUID: JXjpJI5sQMCMIeVGYsh5nQ==
X-CSE-MsgGUID: AFkn0Ov3S725D7eR/hvNpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="300245465"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa001.jf.intel.com with ESMTP; 06 Aug 2026 00:35:38 -0700
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
Subject: [PATCH v7 2/9] perf c2c: add function view browser skeleton
Date: Thu,  6 Aug 2026 15:42:10 +0800
Message-ID: <20260806074217.2846596-3-jiebin.sun@intel.com>
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

Add the skeleton of the c2c function view: a new TUI browser in
tools/perf/ui/browsers/c2c-function.c reached by pressing TAB in the
cacheline view. This commit wires up the entry point (a stub that will be
filled in by later patches), declares perf_c2c__browse_function_view() in
c2c.h, and adds the TAB key handler and help text to the cacheline browser.

Link c2c-function.o directly into perf rather than libperf-ui.a. The
browser is part of the c2c command and later patches make it depend on
state and callbacks provided by builtin-c2c.o. libperf-ui.a is also linked
into python/perf.so under --whole-archive, without the builtin command
objects, which would leave those command-private symbols unresolved.
Build the browser only with CONFIG_SLANG, matching its TUI-only entry
point.

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
 tools/perf/Build                      |  1 +
 tools/perf/builtin-c2c.c              |  4 ++
 tools/perf/c2c.h                      | 12 +++--
 tools/perf/ui/browsers/c2c-function.c | 77 +++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/ui/browsers/c2c-function.c

diff --git a/tools/perf/Build b/tools/perf/Build
index e18c80a5c1bc..21b509f3a23d 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -21,6 +21,7 @@ perf-y += builtin-mem.o
 perf-y += builtin-data.o
 perf-y += builtin-version.o
 perf-y += builtin-c2c.o
+perf-$(CONFIG_SLANG) += ui/browsers/c2c-function.o
 perf-y += builtin-daemon.o
 
 perf-$(CONFIG_LIBTRACEEVENT) += builtin-kmem.o
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 4a3cf8c906f9..12b18208d3dd 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2737,6 +2737,7 @@ static int perf_c2c__hists_browse(struct hists *hists)
 	static const char help[] =
 	" d             Display cacheline details \n"
 	" ENTER         Toggle callchains (if present) \n"
+	" TAB           Switch to function view\n"
 	" q             Quit \n";
 
 	browser = perf_c2c_browser__new(hists);
@@ -2758,6 +2759,9 @@ static int perf_c2c__hists_browse(struct hists *hists)
 		case 'd':
 			perf_c2c__browse_cacheline(browser->he_selection);
 			break;
+		case '\t':
+			perf_c2c__browse_function_view();
+			break;
 		case '?':
 			ui_browser__help_window(&browser->b, help);
 			break;
diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
index aac01d4f6760..704b452aa390 100644
--- a/tools/perf/c2c.h
+++ b/tools/perf/c2c.h
@@ -132,18 +132,24 @@ void c2c_fmt_free(struct perf_hpp_fmt *fmt);
 bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
 
 /*
- * The TUI browser is only built with SLANG support. The stub below keeps the
- * header self-contained for NO_SLANG builds, as util/hist.h does for its own
- * TUI entry points.
+ * The TUI browsers are only built with SLANG support. The stubs below keep
+ * the header self-contained for NO_SLANG builds, as util/hist.h does for its
+ * own TUI entry points.
  */
 #ifdef HAVE_SLANG_SUPPORT
 int perf_c2c__browse_cacheline(struct hist_entry *he);
+int perf_c2c__browse_function_view(void);
 #else
 static inline int
 perf_c2c__browse_cacheline(struct hist_entry *he __maybe_unused)
 {
 	return 0;
 }
+
+static inline int perf_c2c__browse_function_view(void)
+{
+	return 0;
+}
 #endif
 
 #endif /* _PERF_C2C_H_ */
diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
new file mode 100644
index 000000000000..c0fd7799e4f8
--- /dev/null
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -0,0 +1,77 @@
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
+#include "../../c2c.h"
+#include "hists.h"
+
+struct perf_c2c_ext {
+	struct c2c_hists	function_hists;
+	/* Total estimated cycles across all level-1 entries. */
+	u64			total_cycles;
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
+int perf_c2c__browse_function_view(void)
+{
+	ui__warning("C2C function view is not implemented yet.\n");
+	return 0;
+}
-- 
2.52.0

