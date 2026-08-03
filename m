Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D939383312;
	Mon,  3 Aug 2026 03:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728741; cv=none; b=MpxHmQtLZ6N2EhETwAW/1ybZMlg8fZUN6Y4i8b762XNxHzKUmoS6m2MPXGGLp35GHp0eU+j2Gpajr+QWoDAv4e8PUuR9Gz819H4oNUUWFH3aMxnvk6+RYVPgXvdvZ7JAreH4DngM/dcIynzvtiifaw6snc4yU0j+ChVptBKNsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728741; c=relaxed/simple;
	bh=n73mG7ZValrAk+ples/QrCNMYRMrkhso2G12lL7ZV34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+85W7pf1t2z/V6AXJQ5jDqVqL7XxcYZl2TeG/y96jwxoc66CHTCIbIJ6KrCkg44Nz4qLDTOeG57VPNwsXfnigaaJGo05JCX9GqfWP2orjCSta7sVKaRRzVDWu2Iyehf0ojWkpgHkYImd8DCmU2W5IzJZtoKPmD+ds/XkZN/iuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqNVFbY5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqNVFbY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785728740; x=1817264740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n73mG7ZValrAk+ples/QrCNMYRMrkhso2G12lL7ZV34=;
  b=IqNVFbY5Ii/DkMrGAR15wJ25LOd/jPxX/vFINun2gm7oivg4jBMJFxe+
   lhIlcMFdYnUa1KJA6KbQ/ICzTaFy5Ol3vyJ3mTFw7ZBVNEQYg3lhXGkj0
   55XQV563Zowm60cbxmsqCDeHDN+DQlXAOzORAW7e5AcXcr3TGe7AqDvQD
   SBxKruD0GRHl2BwWLt3cB+pubU8DRUrH1GyN0bee0fzKxBUy9r3xMzW91
   +qFnsnUBI+mkPpfGPNV7ojLzHk3bhiOmVRgIEE9TghhLhTG7GznByqHMC
   IW5gnPNLa6CeIaxb4zvE+nQh9gA7zyO8Lh9Z2qoHjhz7MiWcZswxCZl4k
   A==;
X-CSE-ConnectionGUID: vyXk1sm4TCKFPnndhmcetQ==
X-CSE-MsgGUID: EsimItggQxW6Ln/12DmEHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="86210173"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="86210173"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 20:45:40 -0700
X-CSE-ConnectionGUID: GUeiZpWBS8qPmkAPVyXf4A==
X-CSE-MsgGUID: lG2dgdTlRJmhubKcwyqKcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="261719158"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa009.jf.intel.com with ESMTP; 02 Aug 2026 20:45:36 -0700
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
Subject: [PATCH v6 2/9] perf c2c: add function view browser skeleton
Date: Mon,  3 Aug 2026 11:52:13 +0800
Message-ID: <20260803035220.172022-3-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260803035220.172022-1-jiebin.sun@intel.com>
References: <20260803035220.172022-1-jiebin.sun@intel.com>
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
filled in by later patches), registers the file in the build, declares
perf_c2c__browse_function_view() in c2c.h, and adds the TAB key handler
and help text to the cacheline browser.

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
 tools/perf/builtin-c2c.c              |  4 ++
 tools/perf/c2c.h                      | 12 +++--
 tools/perf/ui/browsers/Build          |  1 +
 tools/perf/ui/browsers/c2c-function.c | 77 +++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/ui/browsers/c2c-function.c

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 39f70ef6597b..92e276eea85c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2693,6 +2693,7 @@ static int perf_c2c__hists_browse(struct hists *hists)
 	static const char help[] =
 	" d             Display cacheline details \n"
 	" ENTER         Toggle callchains (if present) \n"
+	" TAB           Switch to function view\n"
 	" q             Quit \n";
 
 	browser = perf_c2c_browser__new(hists);
@@ -2714,6 +2715,9 @@ static int perf_c2c__hists_browse(struct hists *hists)
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

