Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35B3D1CB2;
	Fri, 26 Jun 2026 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457401; cv=none; b=Isqi+tiOgXj1qgDeygk7FjiW3tU/82qddpfOVS5cI/BHbt5IR31RO+C/8OwCpUaBej46LKMyz/elCH6V8jRNJ7s6Z1i+c9t5Ur9AVvYhOwv71qSqMVGWPhlUH/OXq2OB7xx93FZqslza9rDhNj4TiNJUVj4/okLtszYOhqyCeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457401; c=relaxed/simple;
	bh=uVpC83W7TvJg9IaRH8cNHuIDWDNFOFc6GKsSlzHbgkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXStflabXJOABJ2Gbqo8uRDH9A5vVZIWXbeBBd70U3mIqwm9hkVw1gnw0DMA/QOKcTfuwQxWz1ZAlR+Q8fahXoCeilAJ2axjAjgnKz+q0aY192OtFpFniIBDtYsbdedGrxuHCqtjS7YYpbr+1zHR4OrMUBvSbWkOxtzlIjLNx2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jln27uFU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jln27uFU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782457401; x=1813993401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uVpC83W7TvJg9IaRH8cNHuIDWDNFOFc6GKsSlzHbgkM=;
  b=Jln27uFUlYNjYiqLk6rjd2MJwoc4q1p0f/GZ3GGYmbXfHwGrufGbP9PV
   xY4SvcE2zwGus9fEK8tk1bpr7voUHF4KKYzAE7F5GPlplU0LHb2IaG6fI
   RiJUXzVEgqT7MCHxy7UHBIqY4cWIuLmaYrmb2OTJNtGF6IiqzQ6IOcV94
   kxkNOL/MgE2FvgCA5d82zi8Q9Iw5wSRS3IpL9DuBsSzbUHGd43Ljl+KFu
   U69PI9/V+x15SfRXEJwQN5JDjul1JP2QtZ1UWhKEQzUn8NFTwi+tUlOPq
   fj6+GFn5J2N7sxS4Du2msqOZJQd6kaC/D0TpB96wyBtd+ohrZvHXrxbLv
   A==;
X-CSE-ConnectionGUID: rWNJRpbtS/+GJeyOq97z3A==
X-CSE-MsgGUID: cOnA//R9SfmD/sDVXiSqHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94397340"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="94397340"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 00:03:21 -0700
X-CSE-ConnectionGUID: L5MlqM7fTm6D4wDsAvETmw==
X-CSE-MsgGUID: CRcWVc49QTeRM/lGG4Pinw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247893420"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa007.fm.intel.com with ESMTP; 26 Jun 2026 00:03:16 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH 02/14] perf c2c: add function view browser skeleton
Date: Fri, 26 Jun 2026 15:03:43 +0800
Message-ID: <20260626070355.1556721-3-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260626070355.1556721-1-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
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
index 3e974dd1d7ee..385709536a1a 100644
--- a/tools/perf/c2c.h
+++ b/tools/perf/c2c.h
@@ -134,6 +134,7 @@ bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
 
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
index 000000000000..040266288be3
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
+	return -ENOSYS;
+}
-- 
2.52.0

