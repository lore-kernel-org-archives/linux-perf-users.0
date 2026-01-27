Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D0D329C74;
	Tue, 27 Jan 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497597; cv=none; b=ZdzuSxE0au5q4hVJIuY8prSw0+d+lW46ltX7Fm1DTyzHlEpyVueevzscKo+g6qKmTnLYwhFdNS3oiBez4sIpaQjt0r/9eAvQ/T36jAS3S2UE292Hv8mIYB4pFeZCvddUbu8SUsMu9BgA4pZzIcqGCluVi1jo8Tn6HZMaGaQ5iXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497597; c=relaxed/simple;
	bh=uUPGYsm0cAYdZb9X1VlXJ8MgjXnOsyQSJSOc0zvoXys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eImSvWWS0gS5/B9gaX6WFBYKoeNdS6BfWDwEsmBBYNmURI9dk733KajrjPrJnMLmfjL3viAs/WXWx9jilL8Ojw9cmcDInQvDJoASo3oLJo78pMohxXO+7uM0KbkV7AHD2l7qthdALJbAJ93F8F707br7XwyrE+1m/n0yyYcgrI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cP6Mb89d; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cP6Mb89d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769497595; x=1801033595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uUPGYsm0cAYdZb9X1VlXJ8MgjXnOsyQSJSOc0zvoXys=;
  b=cP6Mb89dM9pZxzIY8KJgHYZXGFujFW/puMDNZEUk2Yg8NxORj6vZlzoT
   qdZkXYoPlfxiRR0AwIWWsfc+qxxF/MJjN8N4YRV9fj+qKlCAADB/4Hm1S
   VrKsIT0nsZgQzq0azQLk5N0lHI9sprICCnBcSp6MbNl8XeSYVuLy6533v
   ybGRV5rTaEssCLACDZt4voaSsSaerNmZih4EKmbM0p9kw+Wu2nOuEgiJU
   HPAhLkgeKV0nTo9wBrlEfGOQiZebWy8u8ICsY0cULe/OS/z/Dsumam55R
   q2Mm3XaMtcdmUJHabGP/Ue8LChBuRDcBvd2t8U1Q2jQ8CFv+mj1hKMzl5
   g==;
X-CSE-ConnectionGUID: K26E3yzkSOuXt9wByq1fRA==
X-CSE-MsgGUID: XelqwRhJTTenzDvJrz9+yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70742995"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70742995"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 23:06:35 -0800
X-CSE-ConnectionGUID: 4i8/2KLPRUSer92UCoXaAQ==
X-CSE-MsgGUID: b0I21qKSSOKSzsxrvrqI1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="208331263"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 26 Jan 2026 23:06:30 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 1/3] perf arch: Update arch headers to use relative UAPI paths
Date: Tue, 27 Jan 2026 15:02:57 +0800
Message-Id: <20260127070259.2720468-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127070259.2720468-1-dapeng1.mi@linux.intel.com>
References: <20260127070259.2720468-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The architectural specific headers perf_regs.h currently rely on the
host architecture's 'asm/perf_regs.h'. This can lead to compilation
inconsistencies or failures when including and building perf for a
target architecture that differs from the host's architecture.

Explicitly point to the UAPI headers within the tools source tree using
relative paths. This ensures that perf is always built against the
intended architecture.

No functional changes are intended.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/arm/include/perf_regs.h       | 2 +-
 tools/perf/arch/arm64/include/perf_regs.h     | 2 +-
 tools/perf/arch/csky/include/perf_regs.h      | 1 +
 tools/perf/arch/loongarch/include/perf_regs.h | 2 +-
 tools/perf/arch/mips/include/perf_regs.h      | 2 +-
 tools/perf/arch/powerpc/include/perf_regs.h   | 2 +-
 tools/perf/arch/riscv/include/perf_regs.h     | 2 +-
 tools/perf/arch/s390/include/perf_regs.h      | 2 +-
 tools/perf/arch/x86/include/perf_regs.h       | 2 +-
 9 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/arm/include/perf_regs.h b/tools/perf/arch/arm/include/perf_regs.h
index 75ce1c370114..20c54766e3a0 100644
--- a/tools/perf/arch/arm/include/perf_regs.h
+++ b/tools/perf/arch/arm/include/perf_regs.h
@@ -4,7 +4,7 @@
 
 #include <stdlib.h>
 #include <linux/types.h>
-#include <asm/perf_regs.h>
+#include "../../../../arch/arm/include/uapi/asm/perf_regs.h"
 
 void perf_regs_load(u64 *regs);
 
diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arch/arm64/include/perf_regs.h
index 58639ee9f7ea..372f2565a9dd 100644
--- a/tools/perf/arch/arm64/include/perf_regs.h
+++ b/tools/perf/arch/arm64/include/perf_regs.h
@@ -5,7 +5,7 @@
 #include <stdlib.h>
 #include <linux/types.h>
 #define perf_event_arm_regs perf_event_arm64_regs
-#include <asm/perf_regs.h>
+#include "../../../../arch/arm64/include/uapi/asm/perf_regs.h"
 #undef perf_event_arm_regs
 
 void perf_regs_load(u64 *regs);
diff --git a/tools/perf/arch/csky/include/perf_regs.h b/tools/perf/arch/csky/include/perf_regs.h
index 076c7746c8a2..9520e6aa319e 100644
--- a/tools/perf/arch/csky/include/perf_regs.h
+++ b/tools/perf/arch/csky/include/perf_regs.h
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <linux/types.h>
 #include <asm/perf_regs.h>
+#include "../../../../arch/csky/include/uapi/asm/perf_regs.h"
 
 #define PERF_REGS_MASK	((1ULL << PERF_REG_CSKY_MAX) - 1)
 #define PERF_REGS_MAX	PERF_REG_CSKY_MAX
diff --git a/tools/perf/arch/loongarch/include/perf_regs.h b/tools/perf/arch/loongarch/include/perf_regs.h
index 45c799fa5330..b86078a55e90 100644
--- a/tools/perf/arch/loongarch/include/perf_regs.h
+++ b/tools/perf/arch/loongarch/include/perf_regs.h
@@ -4,7 +4,7 @@
 
 #include <stdlib.h>
 #include <linux/types.h>
-#include <asm/perf_regs.h>
+#include "../../../../arch/loongarch/include/uapi/asm/perf_regs.h"
 
 #define PERF_REGS_MAX PERF_REG_LOONGARCH_MAX
 
diff --git a/tools/perf/arch/mips/include/perf_regs.h b/tools/perf/arch/mips/include/perf_regs.h
index 7082e91e0ed1..66655f0c4fea 100644
--- a/tools/perf/arch/mips/include/perf_regs.h
+++ b/tools/perf/arch/mips/include/perf_regs.h
@@ -4,7 +4,7 @@
 
 #include <stdlib.h>
 #include <linux/types.h>
-#include <asm/perf_regs.h>
+#include "../../../../arch/mips/include/uapi/asm/perf_regs.h"
 
 #define PERF_REGS_MAX PERF_REG_MIPS_MAX
 
diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
index 1c66f6ba6773..22b492a3dd58 100644
--- a/tools/perf/arch/powerpc/include/perf_regs.h
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -4,7 +4,7 @@
 
 #include <stdlib.h>
 #include <linux/types.h>
-#include <asm/perf_regs.h>
+#include "../../../../arch/powerpc/include/uapi/asm/perf_regs.h"
 
 void perf_regs_load(u64 *regs);
 
diff --git a/tools/perf/arch/riscv/include/perf_regs.h b/tools/perf/arch/riscv/include/perf_regs.h
index d482edb413e5..89d5bbb8d2b8 100644
--- a/tools/perf/arch/riscv/include/perf_regs.h
+++ b/tools/perf/arch/riscv/include/perf_regs.h
@@ -6,7 +6,7 @@
 
 #include <stdlib.h>
 #include <linux/types.h>
-#include <asm/perf_regs.h>
+#include "../../../../arch/riscv/include/uapi/asm/perf_regs.h"
 
 #define PERF_REGS_MASK	((1ULL << PERF_REG_RISCV_MAX) - 1)
 #define PERF_REGS_MAX	PERF_REG_RISCV_MAX
diff --git a/tools/perf/arch/s390/include/perf_regs.h b/tools/perf/arch/s390/include/perf_regs.h
index 130dfad2b96a..9c95589965fe 100644
--- a/tools/perf/arch/s390/include/perf_regs.h
+++ b/tools/perf/arch/s390/include/perf_regs.h
@@ -3,7 +3,7 @@
 
 #include <stdlib.h>
 #include <linux/types.h>
-#include <asm/perf_regs.h>
+#include "../../../../arch/s390/include/uapi/asm/perf_regs.h"
 
 void perf_regs_load(u64 *regs);
 
diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index f209ce2c1dd9..5495e5ca7cdc 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -4,7 +4,7 @@
 
 #include <stdlib.h>
 #include <linux/types.h>
-#include <asm/perf_regs.h>
+#include "../../../../arch/x86/include/uapi/asm/perf_regs.h"
 
 void perf_regs_load(u64 *regs);
 
-- 
2.34.1

