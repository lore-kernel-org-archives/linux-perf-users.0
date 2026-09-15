Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6583471433;
	Tue, 15 Sep 2026 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463892; cv=none; b=Y+O3xOVn+wzMZoOWvp/dQJOWS0IPZW/AkuSX5Yx9O6fZNoE+EpeGnYWmYh/3/1v1UoUrlS0Hkfo40O2AHwYb5OP2omn+N65tCqLcvm5EWz/mUL3oZx2rMWnJX0/GtlJb1HgwsFkPcjMHKiMM00SKvQw5rKtPD+Raz7SqwURpC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463892; c=relaxed/simple;
	bh=NJR/YFnG3nCHmRWuIGy4vDfAuJQJv1crHeOH6rcQtH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=heu5nKRAjZfdG96Gj//6tdt11bLSayeT2CN02HHj7BEN0nJUIjhNoDTCvceRjBVGFfF18LWXjdnhoRJ96argI1nGKSj7Xueg/wSpqxqfAWm3ZBJftNJs1i4y/VYby+6jaqACbavKLyoJGlWh7dMXXwzP/G3gglqOo++CwVWC0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcQ/fG5T; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcQ/fG5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789463891; x=1820999891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NJR/YFnG3nCHmRWuIGy4vDfAuJQJv1crHeOH6rcQtH4=;
  b=TcQ/fG5T1LcDDDfmkvJY3rlN1o1z51fHOfbEGVJrhbDvn+KNkm/MOwNE
   Z222DLqO6xo/900kjrlaYmv9sVp2s014a56aqekEcsY5k2cbF4aGJ1ppM
   3k8wHExTuhqIblARS+HF+50cxSGCESyDj2C+3DNMNcHbFFB2vRWMuRSCC
   XpQKvzcvweYaanZkZZwN7OgYOMQZuy6s6Hxc4s9ww8l4iXoYpn+1exqgi
   CUY0kmFcgBEhHTCGdmMwYjIRUd/g2d3B+v7bNIvLfhLhVZFjwdDLV/C7Z
   o4wcsh2EUUPChho6OxZUJPmPlwnl5ZBLoGFELnHjiIXhLb+KOH6n0sRqK
   Q==;
X-CSE-ConnectionGUID: VwCAfZWxRD6geelyS2GSHw==
X-CSE-MsgGUID: UwIyp2MKRL+QjHukt0PcSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89580982"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89580982"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:18:11 -0700
X-CSE-ConnectionGUID: nClRT9zTRAqtDTy+hBzULw==
X-CSE-MsgGUID: ++ZO7y5wQ2ysROlcQCYbSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1115325"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 02:18:08 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 2/2] perf util: Explicitly include required headers
Date: Tue, 15 Sep 2026 17:11:12 +0800
Message-Id: <20260915091112.333308-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915091112.333308-1-dapeng1.mi@linux.intel.com>
References: <20260915091112.333308-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko complains "the perf tool can be compiled with musl libc, which
enforces strict POSIX namespace separation and does not implicitly
include headers. Relying on implicit header inclusion can cause build
failures under musl."

Include the required headers explicitly to avoid such failures.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/util/parse-regs-options.c           | 1 +
 tools/perf/util/perf-regs-arch/perf_regs_x86.c | 2 ++
 tools/perf/util/session.c                      | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index 709fcfb077a2..e70393388fae 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -3,6 +3,7 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <string.h>
+#include <strings.h>
 #include <stdio.h>
 #include "util/debug.h"
 #include <dwarf-regs.h>
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index fb6cf34f42f2..ea1d402b0893 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -3,6 +3,8 @@
 #include <errno.h>
 #include <string.h>
 #include <regex.h>
+#include <unistd.h>
+#include <stdbool.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a5b596cd14be..04fba6fb02e8 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <assert.h>
 #include <errno.h>
 #include <signal.h>
 #include <inttypes.h>
-- 
2.34.1

