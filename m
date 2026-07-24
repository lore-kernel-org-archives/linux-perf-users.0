Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C54841D20C;
	Fri, 24 Jul 2026 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886731; cv=none; b=OkjEbLleXc14pXqqPX3OIm0M+X4Ur6F4GHdduFkTGPbFrUCL4QYPqjpXwrvNynwa5d9LgT3id0Les6TD31mpJeruB6M37eQUXffGS8OFx1WGcll9hAQfkpTe7NVA0tM1363q0mcOCZ1QX9MKrYAlm/Jd0/yHosweqC2+2+EIZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886731; c=relaxed/simple;
	bh=7TdEbx12b9EFVwThnbv1y9rx3xTIzUxbxgMzrl+zafQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+DklAp+NmbkyeUcEi4F1uIU0DPRdB9Ad8ZjGJJflmFrQbZIbEHNJ/oKgZrJZAPk0aCmo06mmj2nm8+JZT9eupOAVveTvSzOVpOz3rvTqCuszOUtwSNmxXXKEaIqluR45na8vGc/Fnf3RCVf7JdQDAjzE8LcIkCd1A5ynyRNQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAM5IRNi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAM5IRNi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784886730; x=1816422730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7TdEbx12b9EFVwThnbv1y9rx3xTIzUxbxgMzrl+zafQ=;
  b=WAM5IRNinwHQT5hydnOYfHWODsEOERDmKH8rb4FxL9ULrWzjGdZFrN3W
   iN/6DpZ0aEFIzDKCgPo9HEXRgoRSUwLu1IIRCyb0ykEJuTEtC0KcHwMux
   YuHm5H7O4mo9jutZXEtTgaLlekofu0UaIIBrP4We358UZiASQFEH42P82
   f3BGzaq/hHNPUZtMS2WbJKVpbKX15o32YJjXM0xpU5AOH4fW5fza9Zaz6
   6myAPTrgYaWboKbDDpwD4xo7sDEOE9gIBbkFnEOiPa47vvhUwifO5E8BM
   FSxu0xRmKGmeyKZ2SguvOPciVTffW1mTIqBE/vacnvoQuq7hOQ+hNGDvI
   w==;
X-CSE-ConnectionGUID: d9Dqg5wESMWcd0z1owYf2g==
X-CSE-MsgGUID: /vJAEXXgQmKZ4yZFUBPD9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="95907578"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="95907578"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 02:52:09 -0700
X-CSE-ConnectionGUID: FFaS0CWqQoi8fJReA0+eJA==
X-CSE-MsgGUID: AkBiTo5pQv299M00XiO9mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="256018437"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa008.fm.intel.com with ESMTP; 24 Jul 2026 02:52:04 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org
Cc: adrian.hunter@intel.com,
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
Subject: [PATCH v4 2/9] perf c2c: add function view browser skeleton
Date: Fri, 24 Jul 2026 17:58:35 +0800
Message-ID: <20260724095842.995920-3-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724095842.995920-1-jiebin.sun@intel.com>
References: <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260724095842.995920-1-jiebin.sun@intel.com>
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
 tools/perf/c2c.h                      |  1 +
 tools/perf/ui/browsers/Build          |  1 +
 tools/perf/ui/browsers/c2c-function.c | 79 +++++++++++++++++++++++++++
 4 files changed, 85 insertions(+)
 create mode 100644 tools/perf/ui/browsers/c2c-function.c

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f1dd9d8699cb..23c58eba415a 100644
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
+			perf_c2c__browse_function_view(hists);
+			break;
 		case '?':
 			ui_browser__help_window(&browser->b, help);
 			break;
diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
index 432d5f0b28f1..8d0871d9556b 100644
--- a/tools/perf/c2c.h
+++ b/tools/perf/c2c.h
@@ -148,6 +148,7 @@ bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
  */
 #ifdef HAVE_SLANG_SUPPORT
 int perf_c2c__browse_cacheline(struct hist_entry *he);
+int perf_c2c__browse_function_view(struct hists *hists);
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
index 000000000000..3f6822f61600
--- /dev/null
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C2C Function Browser - function-level cacheline sharing analysis
+ *
+ * Displays a 3-level hierarchy showing which functions share cachelines:
+ *   Level 1: Read-side functions sorted by Cycles % (estimated load cycles)
+ *   Level 2: Functions that write the shared lines, causing the level-1 HITMs
+ *   Level 3: The specific cachelines where the two functions contend
+ *
+ * Builds the hierarchy from the existing cacheline histograms
+ * (c2c_hist_entry->hists), reusing the shared c2c data structures.
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdlib.h>
+#include <tools/libc_compat.h> /* reallocarray */
+#include <string.h>
+#include <asm/bug.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/zalloc.h>
+
+#include "../browser.h"
+#include "../helpline.h"
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
+
+struct perf_c2c_ext {
+	struct c2c_hists	function_hists;
+	/* Cached across all level-1 entries; 0 means "not yet computed". */
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
+int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
+{
+	ui__warning("C2C function view is not implemented yet.\n");
+	return 0;
+}
-- 
2.52.0

