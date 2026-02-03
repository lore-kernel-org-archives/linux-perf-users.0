Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D521C5F27;
	Tue,  3 Feb 2026 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086883; cv=none; b=FBh7LZTjQK7EsDd9Ymwa6DGbz88DN8gYqOdalGA1pPuA/73Twt3VEjHEiNiSeVaX3oluiGn4TP5TlvQFmLFsawJIsy1m4+yK/rrvmEkDnvVo63WgkvBSwnXIkUZpfhpPSjtD6qbHc4ZAuO5ku1vNHZpCCKBTsYLVDB+4yVptOSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086883; c=relaxed/simple;
	bh=mYFJnn/E2IkfJ4/3A75277NT6QtDqiUGREPprJygmkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d73pbryguNuLNdzEp8n4ebXAOwWMxiZJw/i3rvITHJ3aL5vbugz7W7r0d4f0PkimyFv5GOFLR/paj4g4EMIyWf+gTzaaMGUOC4QqiNrds3pPnaSJHfZ7nNt54Xm+j9srsnEF69tUHBU0IHYDg4yCGl6mOhy+d9zlj27kfBks31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMHs0/hX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMHs0/hX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770086882; x=1801622882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mYFJnn/E2IkfJ4/3A75277NT6QtDqiUGREPprJygmkg=;
  b=CMHs0/hXB9zQweagibn5MS+97ml2Gxw0P/M0OHPBKmPmCwHs2pnC1agd
   rIXjAX0AceMnJWJoJtjQUnbJgUzO4sOdkQ4Vbbw1qL/WTYCjBsR1rXvmX
   LX6qO8CS2QnQ39dELO+NKb8CsX7NgRKkMKA8mG0H8nwHrlpMv1kO743nk
   txR/233ZrdbUas+wR5Fi5HviGqJ/XIxQXBds/eynCqrU8Ag/9H036Kfpd
   0wiHor5zanXieEeWBPdIItdjloPgpvJLcuvQbN/Ex0X+A010tTTEN5Doc
   t14weqIDkBj1w7XDtVhafQGFt6ue/40oNM9HQLvnib7vGVtqfSI4BOaC5
   g==;
X-CSE-ConnectionGUID: tf0bYQpWR9evNBrnSpv/nA==
X-CSE-MsgGUID: 979tAQz/RxullLX8MqUY0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71152147"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="71152147"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 18:48:02 -0800
X-CSE-ConnectionGUID: JH/eTF6TSiuKXucoPMPEOw==
X-CSE-MsgGUID: WT3SpuxkSHGiSuTN2JEXrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="208991734"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa010.jf.intel.com with ESMTP; 02 Feb 2026 18:47:56 -0800
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
Subject: [Patch v3 2/4] perf arch: Update arch headers to use relative UAPI paths
Date: Tue,  3 Feb 2026 10:43:54 +0800
Message-Id: <20260203024356.444942-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203024356.444942-1-dapeng1.mi@linux.intel.com>
References: <20260203024356.444942-1-dapeng1.mi@linux.intel.com>
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

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/arm/include/perf_regs.h       | 2 +-
 tools/perf/arch/arm64/include/perf_regs.h     | 2 +-
 tools/perf/arch/csky/include/perf_regs.h      | 2 +-
 tools/perf/arch/loongarch/include/perf_regs.h | 2 +-
 tools/perf/arch/mips/include/perf_regs.h      | 2 +-
 tools/perf/arch/powerpc/include/perf_regs.h   | 2 +-
 tools/perf/arch/riscv/include/perf_regs.h     | 2 +-
 tools/perf/arch/s390/include/perf_regs.h      | 2 +-
 tools/perf/arch/x86/include/perf_regs.h       | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

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
index 076c7746c8a2..0bf7b963909c 100644
--- a/tools/perf/arch/csky/include/perf_regs.h
+++ b/tools/perf/arch/csky/include/perf_regs.h
@@ -6,7 +6,7 @@
 
 #include <stdlib.h>
 #include <linux/types.h>
-#include <asm/perf_regs.h>
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

