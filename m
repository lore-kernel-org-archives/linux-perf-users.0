Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F43C4552;
	Mon, 17 Aug 2026 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959621; cv=none; b=c0066XW/M/cnc0h0gbo+xYPQIvBRilqw+QbU9fC/p4icEP8QzUBcnzpuQfQ2Nl+kPniAoi3npvrlcnZlloXvzfZ+J+n81YsxT9MdNrecxWvoqHH9hw7xC3C6HTJ/ncGINLEYCFQXSJadBy8OIBcmHfWUHZA7gPtGn6ws4GiJvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959621; c=relaxed/simple;
	bh=q8xiA3/Vsjdl+UyKTRCQZwGVTiUqD0wpFEHZfZZdBmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYEaQWIsewyFYv4lCre9+HcC9Yu1ypJXYYo6ZT6KHcs93dPci5PSxZ0ko2YWghh1+ve6lg0OGca0C01F/FBhStdveHMAkmRCqVJeyJ2SPxLWXgMXYQ4gvFMmIf38krcVmiN9d0BzYqOzSjhLpZbKWNyG704tNTxZsioK3Vj0OM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqwkv7Sf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqwkv7Sf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786959617; x=1818495617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q8xiA3/Vsjdl+UyKTRCQZwGVTiUqD0wpFEHZfZZdBmA=;
  b=cqwkv7SfCD52D3N9qYzM1g8Jtt4hExlsWQNqQKiTqxgpcbBYBNLTG0xH
   G+hVsMdEKiatbGJblrUHGtjuD3raeBiNwo1DszKjDeKLslml8KGkmKNiF
   ImVIYdVxD+n1cf+SudMUzJrZ5ckBDuw4bWtLHB0wI1EiodnpvtdNyuwIj
   qKwxVoKLA8jaDb5g6S+yHe1jMMnB9LnT2QEFsP3A+wkUuGcKQWUTGXy4i
   gXwgvW42e4hKPrfqg5e/Gzx53cp/4x9dN37xED2Lq70UzQfEmsmbPrGN2
   KEHKYqIqcL9tnWiKDF7/CTkCXcngxgzDyTUhgmYhbk2y9fDJpEzLUwKxZ
   Q==;
X-CSE-ConnectionGUID: R1FeGiqHQlCvacyyKR9kcA==
X-CSE-MsgGUID: gN7keeWXQmKg1llhz6ZIVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98948146"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="98948146"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 02:40:16 -0700
X-CSE-ConnectionGUID: TZ7bV4IWQ1K1s7/F6WaY+g==
X-CSE-MsgGUID: GrXjgWNDRnmF+JbrS6GRoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="288337159"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 17 Aug 2026 02:40:11 -0700
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
	jiebin.sun@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/9] perf c2c: add function view model skeleton
Date: Mon, 17 Aug 2026 17:46:16 +0800
Message-ID: <20260817094623.3288456-3-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260817094623.3288456-1-jiebin.sun@intel.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the initial common model for the c2c function view: model state and
small helpers shared by the hierarchy construction and formatting added
in later patches.

Build the model from util/ so it remains independent of the TUI and
command-private symbols.

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
 tools/perf/util/Build          |  1 +
 tools/perf/util/c2c-function.c | 66 ++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 tools/perf/util/c2c-function.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 1dfd92cbe3b7..b26a0b1ddfa3 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -12,6 +12,7 @@ perf-util-y += block-info.o
 perf-util-y += block-range.o
 perf-util-y += build-id.o
 perf-util-y += c2c.o
+perf-util-y += c2c-function.o
 perf-util-y += cacheline.o
 perf-util-$(CONFIG_LIBCAPSTONE) += capstone.o
 perf-util-y += config.o
diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-function.c
new file mode 100644
index 000000000000..ca82425a28dc
--- /dev/null
+++ b/tools/perf/util/c2c-function.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C2C function model - function-level cacheline sharing analysis
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
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/zalloc.h>
+
+#include "addr_location.h"
+#include "c2c.h"
+#include "cacheline.h"
+#include "hist.h"
+#include "map.h"
+#include "mem-events.h"
+#include "mem-info.h"
+#include "sort.h"
+#include "symbol.h"
+#include "thread.h"
+
+struct c2c_function_model {
+	struct c2c_hists	function_hists;
+	/* Total estimated cycles across all level-1 entries. */
+	u64			total_cycles;
+	/* Source cacheline histograms; not owned here. */
+	struct c2c_hists	*cl_hists;
+	/* --coalesce field list, used to require iaddr. */
+	const char		*cl_sort;
+	/* Do not cap long symbol names. */
+	bool			 symbol_full;
+};
+
+static struct c2c_function_model c2c_ext __maybe_unused;
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
-- 
2.52.0

