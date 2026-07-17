Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739643271FD;
	Fri, 17 Jul 2026 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253944; cv=none; b=Xmk9sKx6Px/VgUAp+QLLHEvFvqQ/sXv5gQJ1jbzLIvuL/+To9RBdAqGi/T2zSSbff9q1OKNqBaY2YJhWTRnGLdtzgBxU02+IyZp9xc0YPz+JWJNHkQUQW7BVjXnJetm+0Guw2mViDZBd4KB/pZiL0YjVLzeIh6uM5e482A22NLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253944; c=relaxed/simple;
	bh=SVTH4lvkuQDkOiwt+MperC8LbMMI/0PCO+ivJQcBkyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3rTymTVs3DXwOJvrBDMVlkE7HgZg3ul3lde6YiRpBfGOWXAGT7Yjqs0cQixCuHAy7895r5HTV9TPWBfN+iFmEGUATPDD0ky69ytb6VTXHW14iAWJowye/GkB/Dnm28RNtlmrAwdJ9Al00N3k227pv/KDIDVney0X0+JOL8XsUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWuBXZVH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWuBXZVH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784253939; x=1815789939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVTH4lvkuQDkOiwt+MperC8LbMMI/0PCO+ivJQcBkyc=;
  b=OWuBXZVHFqoNKCdofEoFMn0o4fMYKpT6+h0pm3Z/WOUhNVRxAzFORkxq
   LtyPSHqm2uWpPq/Lqg5Q3iqJgIGOOYgO8+2C8W42ubOWF76bNVFxlMdvy
   C8EdbXMqIl0B3jjxiPyGyFRhGCU6SS57Pjz6t5YHLDmSYrepcbBZxVjJl
   g9Fd2XvGxMkXj6uinBVGViEq1iTh8llTnoEDSj+dBIdHzI0hzdSwOWo9U
   snmIBmMhX4mUgnfV0RxdD0jJ4qM44iSY+H386vz0i9s6GFHwXOcDqTLMT
   KgdU/BvfGfOFq3pBqOcDhsyMhNkjZNiBY3isPf9ISPYSc2w6mmmY6rOp2
   A==;
X-CSE-ConnectionGUID: PawUhYSYTr6+4PcX7OSFzw==
X-CSE-MsgGUID: 8jb70teUQlqrD4SGNLEejw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="107719993"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="107719993"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 19:05:36 -0700
X-CSE-ConnectionGUID: 0/AWS3IkTn2ynMna5QJAJQ==
X-CSE-MsgGUID: QiXC+gkTQ0ixKX8XvpkUlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="279952747"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jul 2026 19:05:32 -0700
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
Subject: [PATCH v3 02/14] perf c2c: add function view browser skeleton
Date: Fri, 17 Jul 2026 10:05:18 +0800
Message-ID: <20260717020530.1645123-3-jiebin.sun@intel.com>
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

Add c2c-function.c with a stub perf_c2c__browse_function_view() entry
point and register it in the build system. Declare the function
prototype in c2c.h.

This lays the groundwork for the function-level cacheline sharing
analysis browser that will be implemented in subsequent patches.

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
 tools/perf/c2c.h                      |  1 +
 tools/perf/ui/browsers/Build          |  1 +
 tools/perf/ui/browsers/c2c-function.c | 44 +++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 tools/perf/ui/browsers/c2c-function.c

diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
index 79dbd35184ed..6fc3fda40fb6 100644
--- a/tools/perf/c2c.h
+++ b/tools/perf/c2c.h
@@ -142,6 +142,7 @@ bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
 
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
index 000000000000..c50c8ca825c1
--- /dev/null
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C2C Function Browser - function-level cacheline sharing analysis
+ *
+ * Planned UI: 3-level hierarchy showing which functions share cachelines (not implemented yet):
+ *   Level 1: Primary functions sorted by Cycles % (estimated load cycles)
+ *   Level 2: Other functions sharing cachelines with the level-1 function
+ *   Level 3: Specific shared cachelines between each pair of functions
+ *
+ * Uses c2c_hist_entry->hists to build the hierarchy without adding any
+ * per-entry state to the existing c2c data structures.
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdlib.h>
+#include <string.h>
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
+int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
+{
+	ui__warning("C2C function view is not implemented yet.\n");
+	return 0;
+}
-- 
2.52.0

