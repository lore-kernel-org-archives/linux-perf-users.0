Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E43F1AB9;
	Fri, 10 Jul 2026 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672964; cv=none; b=EWFT8rTXA6Q6Za0kEMygmkAt9z7Iw8Z6dcdfgByqc8ov4OC5KtpEbVsoo+TgdNUzIPhUONJZbSBg2YTg815ZNcu6zqgBbzCOI9yCi+R54R0KW4PGF+gTSKngPaV/5Lz29AtLmaapyx93OswNhcF8KT/iNVulw4CYM2GPXpkfpCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672964; c=relaxed/simple;
	bh=7ARFCtiyQ0mdwUlF4qKBVojXRwHPX9YvqZCwKOLJ/hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kvit7XZ9+jutghJkmkT1e8ZgD5KJ3eHKgfbyHJNoJqgD0AAvdhkx8taYJ0pLczxgX137SgyXyPvch/73ykHG+uPdACdVpWKaNH5i2Bwav8NK6ScbupVsA/EDICERn2+NXGqCG/DJ84g44Mp3NGnsVmrlo2aOV3eUdU6ifEkSNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJT1e0T8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJT1e0T8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783672963; x=1815208963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ARFCtiyQ0mdwUlF4qKBVojXRwHPX9YvqZCwKOLJ/hg=;
  b=GJT1e0T8kSWTRbNf5piKPQ/uMmo4pb4Skl8uMHTJY5Fgfk0q47YzUa33
   7C5hucmHgeqxoUtOyq690TBqWlORhUmic6DgXgEDFIn7ROHQ80RtTHsi/
   rsDAa1EZhoPQKkIJnDFr4I7n2eBRhzwuO5+B86V5jggcFZwQkl8tjjYbu
   J40m4XgyKOgUwr4YFgchDQn8qgqn7+/u0F+YodlSL6jM3j2QRiJeSvd8S
   jNe+Q/mXHhnXHhEKftUW+l5N02zQAq+FohSbk2QjO1ddSWdQNR/Xn9EdY
   an7S39BoKwh3vLKCprd86zmRF1+aIzdDv7YlWYHpyMc1JBiXEPav5sPVO
   g==;
X-CSE-ConnectionGUID: ODITmqKZS+mj/KlSxHIPAg==
X-CSE-MsgGUID: ZvSp0ublT9Sb4+aZwD+lsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390794"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390794"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:42:42 -0700
X-CSE-ConnectionGUID: gN2mKdjsQnywqDhRZPw/Hw==
X-CSE-MsgGUID: tze00yY2SMmytnZ7ffunLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435318"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:42:38 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>
Subject: [PATCH v2 02/14] perf c2c: add function view browser skeleton
Date: Fri, 10 Jul 2026 16:42:35 +0800
Message-ID: <20260710084247.3576706-3-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260710084247.3576706-1-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260710084247.3576706-1-jiebin.sun@intel.com>
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
index 5c3f6ae633ea..ffcd43d4c903 100644
--- a/tools/perf/c2c.h
+++ b/tools/perf/c2c.h
@@ -142,6 +142,7 @@ bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
 
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

