Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5D35B634;
	Tue, 22 Sep 2026 01:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039554; cv=none; b=k81F+MBIni159GdKtuB80e14+4A5g1PsKoz0fUbm5IORGZUelm0PDUZyfRqx7dyiUXYMbyCdEp3vjhgyozIsjU8TmUFrprDBMv82c/0pAvoZ1EjPFIIUEhV5pOzoZ8QGgoq165/tdTpEhZwtv/omGt/j6t6Dtc4AZnSl7GGQXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039554; c=relaxed/simple;
	bh=el/2oNpxxyuKIiQQ8+XS2LZbACkONbqHoZm+IahNn5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/EywXuqcHACEWNN4hcdxPSK2tjjYnUkHdDiNtIsumEm0Ns6yIxf8WkaxXIk0gC/rQc3cKU5RsQSyhKTTBcuOWnBzifPGMlN0fIMPcWe3P+LT560LyYT2OOj6GfSHtEGbVPdM/Rvk4nHjDZNKr7iE4AXYnDkZF3N6JLAXMnSQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgiU2/bK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgiU2/bK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790039552; x=1821575552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=el/2oNpxxyuKIiQQ8+XS2LZbACkONbqHoZm+IahNn5U=;
  b=JgiU2/bKXhkTYgJKfPNU2eTNAMcSpgSqZZMaPqbSJk9tAh26ZyROkkae
   NV2qYjGjg6ObtXdADs+oKUNeJ1SgCcDhXmfZ6Mn7s2FBiP5CEQ2+kj9qo
   txkGz45DemGx6amdZYuf/RllPCM9jZJC35086Wn70M9ivEc5w+dpyN2YM
   PYTeQgyGY8zXBeZV30eU5QYp8StRi9/UZZVo1XyoT8BCQlGOq3jTWzla9
   vmlfN3ABgPWMZorT68w7KRXoCBm1dwbXg/Bq8V+zt/3R0pXfVT7vo/LTf
   E6LcOUjgxdpgOvrv+bFOnverhY9OHKH+LRU6mVL2b/Ln8x82uqCSvrGm1
   w==;
X-CSE-ConnectionGUID: ANuhdmDvTSmVIILgzrHKxQ==
X-CSE-MsgGUID: qA7EJoiNSVqkLGEzP5WFAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101264233"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="101264233"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 18:12:32 -0700
X-CSE-ConnectionGUID: EJ/ClNDzQTmckpggAC3nTg==
X-CSE-MsgGUID: qZSaGdqETpeku5tcxpQNjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="269436311"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 21 Sep 2026 18:12:29 -0700
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
Subject: [Patch v2 2/2] perf util: Explicitly include required headers
Date: Tue, 22 Sep 2026 09:05:31 +0800
Message-Id: <20260922010531.1933320-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922010531.1933320-1-dapeng1.mi@linux.intel.com>
References: <20260922010531.1933320-1-dapeng1.mi@linux.intel.com>
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
Reviewed-by: Ian Rogers <irogers@google.com>
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

