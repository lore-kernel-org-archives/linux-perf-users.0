Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827DA3148DB;
	Fri, 23 Jan 2026 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159608; cv=none; b=a8FTI2rbDugje00aI3AKCjZ1+c0zqoOm78ETklux9QDA8PG9umG2tqEAY0ZoGXeCCkT0aNAKMohW6HpIVKOSqbeAe6/Gop0mRmtVCbfSKPVSoBS8b7r0BakVOJ6vIAz0tON4NuIic76yYmAa8zYFL7FDvFpviBzcw9Ea0H2NcZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159608; c=relaxed/simple;
	bh=ncerroQx+BYFBXz+X2s1R2yFLoReqfY70Q0mauAyyP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R95XEouL8QlVhCNRH2Y9Vfcw5GbbA6GmbxLHhqEF6XbvU7zA88LghkgRXG3TQtFmiuKOX4kTV25Y3Zm/PsotxJoWjEkGL1ejUVwC7hApep4qb+8JbKSGa3ZJ4tyDzYNksCqB4tRDMHWlR9NIZvhtc9vS/5Sc3Sa4M96kY3j11yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luKrG8Mu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luKrG8Mu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769159604; x=1800695604;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ncerroQx+BYFBXz+X2s1R2yFLoReqfY70Q0mauAyyP0=;
  b=luKrG8MuLP1KpkBPEtJkp/6EHrxHZczx/UVAkWwAok2BmbMUO9VO69q/
   Y38uPt2zGnN64DKlk/w3NgsabXfdQIv6WAg3WmcwZNDcNZWkeRg8gjcBG
   Ef3INudUlpElnnbKTL2Ek/AkMwxGT7utzVjLycZje0/Z/uaMyrNzR+WVs
   vRYIIohvPcYJ5y2mcZzlXUu2rS67pL5lzSTogg9cKjTPB/Ifq+r3Bfag4
   7HtVm1wfycPvIYIrMWulj0+1MaYeMxe1K46jv3/sTNrLXcS8py+kpb3Yt
   6I3O6HSFHOGQA3NVXUli+c5OTCTYollTXSkt/fnIo/qI6zYxhyKV9lECv
   A==;
X-CSE-ConnectionGUID: KEjP7PlJR7mndzVB9BkzRw==
X-CSE-MsgGUID: JubVXj12SuKsN1lFBgecgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="87989804"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="87989804"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 01:13:23 -0800
X-CSE-ConnectionGUID: DFzus9/lSkeZ+EvI8ZUt3A==
X-CSE-MsgGUID: quo+lgtdQeCUFZe04/FQlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211103345"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa003.jf.intel.com with ESMTP; 23 Jan 2026 01:13:20 -0800
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
Subject: [RFC Patch] perf regs: Remove __weak attribute from perf-regs functions
Date: Fri, 23 Jan 2026 17:09:38 +0800
Message-Id: <20260123090938.2222960-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, some architecture-specific perf-regs functions, such as
arch__intr_reg_mask() and arch__user_reg_mask(), are defined with the
__weak attribute. This approach ensures that only functions matching
the architecture of the build/run host are compiled and executed,
reducing build time and binary size.

However, this __weak attribute restricts these functions to be called
only on the same architecture, preventing cross-architecture
functionality. For example, a perf.data file captured on x86 cannot be
parsed on an ARM platform.

To address this limitation, this patch removes the __weak attribute from
these perf-regs functions. The architecture-specific code is moved from
the arch/ directory to the util/perf-regs-arch/ directory. The
appropriate architectural functions are then called based on the EM_HOST.

No functional changes are intended.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

This patch is based on Ian's 2 patchset, 
https://lore.kernel.org/lkml/20260117052849.2205545-1-irogers@google.com/
+
https://lore.kernel.org/all/20260121021735.3625244-1-irogers@google.com/

Ian, is this change what you expected?

Although the __weak functions like arch__intr_reg_mask() and
arch__user_reg_mask() have been removed and replaced with
perf_intr_reg_mask() and perf_user_reg_mask() functions that call
different architecture-specific sub-functions based on the em_machine
value, there are still some challenges:

1. The sub-functions perf_intr_reg_mask_*() and perf_user_reg_mask_*()
are still architecture-dependent and require calling perf_event_open()
syscall to get the register bitmaps from the kernel. It remains
impossible to obtain the bitmaps for a different architecture (e.g., 
getting x86 register bitmaps on an ARM platform). While the code can be
executed, the returned results may be incorrect.

2. Since all variants of perf_intr_reg_mask_*() and perf_user_reg_mask_*()
sub-functions are built, it introduces build challenges.

For example, there are duplicate macro definitions, such as the
PERF_REG_EXTENDED_MASK macro, which is defined for both arm64 and 
x86 architectures. To fix the build errors, the following code changes
were made (which may seem more like a hack).

diff --git a/tools/arch/arm64/include/uapi/asm/perf_regs.h b/tools/arch/arm64/include/uapi/asm/perf_regs.h
index 86e556429e0e..43e8e08f52ed 100644
--- a/tools/arch/arm64/include/uapi/asm/perf_regs.h
+++ b/tools/arch/arm64/include/uapi/asm/perf_regs.h
@@ -43,6 +43,6 @@ enum perf_event_arm_regs {
        PERF_REG_ARM64_EXTENDED_MAX
 };

-#define PERF_REG_EXTENDED_MASK (1ULL << PERF_REG_ARM64_VG)
+#define PERF_ARM64_REG_EXTENDED_MASK   (1ULL << PERF_REG_ARM64_VG)

Additionally, there could be architecture-specific instructions called,
such as the "mfspr" instruction on PowerPC, which causes build errors on
other platforms like x86.

 tools/arch/arm64/include/uapi/asm/perf_regs.h |   2 +-
 tools/perf/arch/arm/util/Build                |   2 -
 tools/perf/arch/arm/util/perf_regs.c          |  13 -
 tools/perf/arch/arm64/util/Build              |   1 -
 tools/perf/arch/arm64/util/perf_regs.c        | 141 ---------
 tools/perf/arch/csky/Build                    |   1 -
 tools/perf/arch/csky/util/Build               |   1 -
 tools/perf/arch/csky/util/perf_regs.c         |  13 -
 tools/perf/arch/loongarch/util/Build          |   1 -
 tools/perf/arch/loongarch/util/perf_regs.c    |  13 -
 tools/perf/arch/mips/util/Build               |   1 -
 tools/perf/arch/mips/util/perf_regs.c         |  13 -
 tools/perf/arch/powerpc/util/Build            |   1 -
 tools/perf/arch/powerpc/util/perf_regs.c      | 172 -----------
 tools/perf/arch/riscv/include/perf_regs.h     |   7 +
 tools/perf/arch/riscv/util/Build              |   1 -
 tools/perf/arch/riscv/util/perf_regs.c        |  13 -
 tools/perf/arch/s390/util/Build               |   1 -
 tools/perf/arch/s390/util/perf_regs.c         |  13 -
 tools/perf/arch/x86/util/Build                |   1 -
 tools/perf/arch/x86/util/perf_regs.c          | 283 -----------------
 tools/perf/util/evsel.c                       |   4 +-
 tools/perf/util/parse-regs-options.c          |   2 +-
 .../util/perf-regs-arch/perf_regs_aarch64.c   | 140 ++++++++-
 .../perf/util/perf-regs-arch/perf_regs_arm.c  |  10 +-
 .../perf/util/perf-regs-arch/perf_regs_csky.c |  10 +-
 .../util/perf-regs-arch/perf_regs_loongarch.c |  10 +-
 .../perf/util/perf-regs-arch/perf_regs_mips.c |  10 +-
 .../util/perf-regs-arch/perf_regs_powerpc.c   | 179 ++++++++++-
 .../util/perf-regs-arch/perf_regs_riscv.c     |  10 +-
 .../perf/util/perf-regs-arch/perf_regs_s390.c |  10 +-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 284 +++++++++++++++++-
 tools/perf/util/perf_regs.c                   | 103 ++++++-
 tools/perf/util/perf_regs.h                   |  27 +-
 tools/perf/util/probe-file.c                  |   3 +-
 35 files changed, 778 insertions(+), 718 deletions(-)
 delete mode 100644 tools/perf/arch/arm/util/perf_regs.c
 delete mode 100644 tools/perf/arch/arm64/util/perf_regs.c
 delete mode 100644 tools/perf/arch/csky/Build
 delete mode 100644 tools/perf/arch/csky/util/Build
 delete mode 100644 tools/perf/arch/csky/util/perf_regs.c
 delete mode 100644 tools/perf/arch/loongarch/util/perf_regs.c
 delete mode 100644 tools/perf/arch/mips/util/perf_regs.c
 delete mode 100644 tools/perf/arch/powerpc/util/perf_regs.c
 delete mode 100644 tools/perf/arch/riscv/util/perf_regs.c
 delete mode 100644 tools/perf/arch/s390/util/perf_regs.c
 delete mode 100644 tools/perf/arch/x86/util/perf_regs.c

diff --git a/tools/arch/arm64/include/uapi/asm/perf_regs.h b/tools/arch/arm64/include/uapi/asm/perf_regs.h
index 86e556429e0e..43e8e08f52ed 100644
--- a/tools/arch/arm64/include/uapi/asm/perf_regs.h
+++ b/tools/arch/arm64/include/uapi/asm/perf_regs.h
@@ -43,6 +43,6 @@ enum perf_event_arm_regs {
 	PERF_REG_ARM64_EXTENDED_MAX
 };
 
-#define PERF_REG_EXTENDED_MASK	(1ULL << PERF_REG_ARM64_VG)
+#define PERF_ARM64_REG_EXTENDED_MASK	(1ULL << PERF_REG_ARM64_VG)
 
 #endif /* _ASM_ARM64_PERF_REGS_H */
diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
index 3291f893b943..b94bf3c5279a 100644
--- a/tools/perf/arch/arm/util/Build
+++ b/tools/perf/arch/arm/util/Build
@@ -1,5 +1,3 @@
-perf-util-y += perf_regs.o
-
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 
 perf-util-y += pmu.o auxtrace.o cs-etm.o
diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
deleted file mode 100644
index 03a5bc0cf64c..000000000000
--- a/tools/perf/arch/arm/util/perf_regs.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "perf_regs.h"
-#include "../../../util/perf_regs.h"
-
-uint64_t arch__intr_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
-
-uint64_t arch__user_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 0177af19cc00..bc12c35d06c8 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -8,6 +8,5 @@ perf-util-y += header.o
 perf-util-y += hisi-ptt.o
 perf-util-y += machine.o
 perf-util-y += mem-events.o
-perf-util-y += perf_regs.o
 perf-util-y += pmu.o
 perf-util-y += tsc.o
diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
deleted file mode 100644
index 9bb768e1bea1..000000000000
--- a/tools/perf/arch/arm64/util/perf_regs.c
+++ /dev/null
@@ -1,141 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <errno.h>
-#include <regex.h>
-#include <string.h>
-#include <sys/auxv.h>
-#include <linux/kernel.h>
-#include <linux/zalloc.h>
-
-#include "perf_regs.h"
-#include "../../../perf-sys.h"
-#include "../../../util/debug.h"
-#include "../../../util/event.h"
-#include "../../../util/perf_regs.h"
-
-#define SMPL_REG_MASK(b) (1ULL << (b))
-
-#ifndef HWCAP_SVE
-#define HWCAP_SVE	(1 << 22)
-#endif
-
-/* %xNUM */
-#define SDT_OP_REGEX1  "^(x[1-2]?[0-9]|3[0-1])$"
-
-/* [sp], [sp, NUM] */
-#define SDT_OP_REGEX2  "^\\[sp(, )?([0-9]+)?\\]$"
-
-static regex_t sdt_op_regex1, sdt_op_regex2;
-
-static int sdt_init_op_regex(void)
-{
-	static int initialized;
-	int ret = 0;
-
-	if (initialized)
-		return 0;
-
-	ret = regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
-	if (ret)
-		goto error;
-
-	ret = regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
-	if (ret)
-		goto free_regex1;
-
-	initialized = 1;
-	return 0;
-
-free_regex1:
-	regfree(&sdt_op_regex1);
-error:
-	pr_debug4("Regex compilation error.\n");
-	return ret;
-}
-
-/*
- * SDT marker arguments on Arm64 uses %xREG or [sp, NUM], currently
- * support these two formats.
- */
-int arch_sdt_arg_parse_op(char *old_op, char **new_op)
-{
-	int ret, new_len;
-	regmatch_t rm[5];
-
-	ret = sdt_init_op_regex();
-	if (ret < 0)
-		return ret;
-
-	if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
-		/* Extract xNUM */
-		new_len = 2;	/* % NULL */
-		new_len += (int)(rm[1].rm_eo - rm[1].rm_so);
-
-		*new_op = zalloc(new_len);
-		if (!*new_op)
-			return -ENOMEM;
-
-		scnprintf(*new_op, new_len, "%%%.*s",
-			(int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1].rm_so);
-	} else if (!regexec(&sdt_op_regex2, old_op, 5, rm, 0)) {
-		/* [sp], [sp, NUM] or [sp,NUM] */
-		new_len = 7;	/* + ( % s p ) NULL */
-
-		/* If the argument is [sp], need to fill offset '0' */
-		if (rm[2].rm_so == -1)
-			new_len += 1;
-		else
-			new_len += (int)(rm[2].rm_eo - rm[2].rm_so);
-
-		*new_op = zalloc(new_len);
-		if (!*new_op)
-			return -ENOMEM;
-
-		if (rm[2].rm_so == -1)
-			scnprintf(*new_op, new_len, "+0(%%sp)");
-		else
-			scnprintf(*new_op, new_len, "+%.*s(%%sp)",
-				  (int)(rm[2].rm_eo - rm[2].rm_so),
-				  old_op + rm[2].rm_so);
-	} else {
-		pr_debug4("Skipping unsupported SDT argument: %s\n", old_op);
-		return SDT_ARG_SKIP;
-	}
-
-	return SDT_ARG_VALID;
-}
-
-uint64_t arch__intr_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
-
-uint64_t arch__user_reg_mask(void)
-{
-	struct perf_event_attr attr = {
-		.type                   = PERF_TYPE_HARDWARE,
-		.config                 = PERF_COUNT_HW_CPU_CYCLES,
-		.sample_type            = PERF_SAMPLE_REGS_USER,
-		.disabled               = 1,
-		.exclude_kernel         = 1,
-		.sample_period		= 1,
-		.sample_regs_user	= PERF_REGS_MASK
-	};
-	int fd;
-
-	if (getauxval(AT_HWCAP) & HWCAP_SVE)
-		attr.sample_regs_user |= SMPL_REG_MASK(PERF_REG_ARM64_VG);
-
-	/*
-	 * Check if the pmu supports perf extended regs, before
-	 * returning the register mask to sample.
-	 */
-	if (attr.sample_regs_user != PERF_REGS_MASK) {
-		event_attr_init(&attr);
-		fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
-		if (fd != -1) {
-			close(fd);
-			return attr.sample_regs_user;
-		}
-	}
-	return PERF_REGS_MASK;
-}
diff --git a/tools/perf/arch/csky/Build b/tools/perf/arch/csky/Build
deleted file mode 100644
index e63eabc2c8f4..000000000000
--- a/tools/perf/arch/csky/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-y += util/
diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
deleted file mode 100644
index 6b2d0e021b11..000000000000
--- a/tools/perf/arch/csky/util/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-y += perf_regs.o
diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky/util/perf_regs.c
deleted file mode 100644
index 2cf7a54106e0..000000000000
--- a/tools/perf/arch/csky/util/perf_regs.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "perf_regs.h"
-#include "../../util/perf_regs.h"
-
-uint64_t arch__intr_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
-
-uint64_t arch__user_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index 0aa31986ecb5..0c958c8e0718 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -1,5 +1,4 @@
 perf-util-y += header.o
-perf-util-y += perf_regs.o
 
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/loongarch/util/perf_regs.c b/tools/perf/arch/loongarch/util/perf_regs.c
deleted file mode 100644
index 03a5bc0cf64c..000000000000
--- a/tools/perf/arch/loongarch/util/perf_regs.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "perf_regs.h"
-#include "../../../util/perf_regs.h"
-
-uint64_t arch__intr_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
-
-uint64_t arch__user_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
diff --git a/tools/perf/arch/mips/util/Build b/tools/perf/arch/mips/util/Build
index 691fa2051958..818b808a8247 100644
--- a/tools/perf/arch/mips/util/Build
+++ b/tools/perf/arch/mips/util/Build
@@ -1,2 +1 @@
-perf-util-y += perf_regs.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
diff --git a/tools/perf/arch/mips/util/perf_regs.c b/tools/perf/arch/mips/util/perf_regs.c
deleted file mode 100644
index 2cf7a54106e0..000000000000
--- a/tools/perf/arch/mips/util/perf_regs.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "perf_regs.h"
-#include "../../util/perf_regs.h"
-
-uint64_t arch__intr_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
-
-uint64_t arch__user_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 5fd28ec713a4..43c3e7c450a3 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,6 +1,5 @@
 perf-util-y += header.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-util-y += perf_regs.o
 perf-util-y += mem-events.o
 perf-util-y += pmu.o
 perf-util-y += sym-handling.o
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
deleted file mode 100644
index 779073f7e992..000000000000
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ /dev/null
@@ -1,172 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <errno.h>
-#include <string.h>
-#include <regex.h>
-#include <linux/zalloc.h>
-
-#include "perf_regs.h"
-#include "../../../util/perf_regs.h"
-#include "../../../util/debug.h"
-#include "../../../util/event.h"
-#include "../../../util/header.h"
-#include "../../../perf-sys.h"
-#include "utils_header.h"
-
-#include <linux/kernel.h>
-
-#define PVR_POWER9		0x004E
-#define PVR_POWER10		0x0080
-#define PVR_POWER11		0x0082
-
-/* REG or %rREG */
-#define SDT_OP_REGEX1  "^(%r)?([1-2]?[0-9]|3[0-1])$"
-
-/* -NUM(REG) or NUM(REG) or -NUM(%rREG) or NUM(%rREG) */
-#define SDT_OP_REGEX2  "^(\\-)?([0-9]+)\\((%r)?([1-2]?[0-9]|3[0-1])\\)$"
-
-static regex_t sdt_op_regex1, sdt_op_regex2;
-
-static int sdt_init_op_regex(void)
-{
-	static int initialized;
-	int ret = 0;
-
-	if (initialized)
-		return 0;
-
-	ret = regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
-	if (ret)
-		goto error;
-
-	ret = regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
-	if (ret)
-		goto free_regex1;
-
-	initialized = 1;
-	return 0;
-
-free_regex1:
-	regfree(&sdt_op_regex1);
-error:
-	pr_debug4("Regex compilation error.\n");
-	return ret;
-}
-
-/*
- * Parse OP and convert it into uprobe format, which is, +/-NUM(%gprREG).
- * Possible variants of OP are:
- *	Format		Example
- *	-------------------------
- *	NUM(REG)	48(18)
- *	-NUM(REG)	-48(18)
- *	NUM(%rREG)	48(%r18)
- *	-NUM(%rREG)	-48(%r18)
- *	REG		18
- *	%rREG		%r18
- *	iNUM		i0
- *	i-NUM		i-1
- *
- * SDT marker arguments on Powerpc uses %rREG form with -mregnames flag
- * and REG form with -mno-regnames. Here REG is general purpose register,
- * which is in 0 to 31 range.
- */
-int arch_sdt_arg_parse_op(char *old_op, char **new_op)
-{
-	int ret, new_len;
-	regmatch_t rm[5];
-	char prefix;
-
-	/* Constant argument. Uprobe does not support it */
-	if (old_op[0] == 'i') {
-		pr_debug4("Skipping unsupported SDT argument: %s\n", old_op);
-		return SDT_ARG_SKIP;
-	}
-
-	ret = sdt_init_op_regex();
-	if (ret < 0)
-		return ret;
-
-	if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
-		/* REG or %rREG --> %gprREG */
-
-		new_len = 5;	/* % g p r NULL */
-		new_len += (int)(rm[2].rm_eo - rm[2].rm_so);
-
-		*new_op = zalloc(new_len);
-		if (!*new_op)
-			return -ENOMEM;
-
-		scnprintf(*new_op, new_len, "%%gpr%.*s",
-			(int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].rm_so);
-	} else if (!regexec(&sdt_op_regex2, old_op, 5, rm, 0)) {
-		/*
-		 * -NUM(REG) or NUM(REG) or -NUM(%rREG) or NUM(%rREG) -->
-		 *	+/-NUM(%gprREG)
-		 */
-		prefix = (rm[1].rm_so == -1) ? '+' : '-';
-
-		new_len = 8;	/* +/- ( % g p r ) NULL */
-		new_len += (int)(rm[2].rm_eo - rm[2].rm_so);
-		new_len += (int)(rm[4].rm_eo - rm[4].rm_so);
-
-		*new_op = zalloc(new_len);
-		if (!*new_op)
-			return -ENOMEM;
-
-		scnprintf(*new_op, new_len, "%c%.*s(%%gpr%.*s)", prefix,
-			(int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].rm_so,
-			(int)(rm[4].rm_eo - rm[4].rm_so), old_op + rm[4].rm_so);
-	} else {
-		pr_debug4("Skipping unsupported SDT argument: %s\n", old_op);
-		return SDT_ARG_SKIP;
-	}
-
-	return SDT_ARG_VALID;
-}
-
-uint64_t arch__intr_reg_mask(void)
-{
-	struct perf_event_attr attr = {
-		.type                   = PERF_TYPE_HARDWARE,
-		.config                 = PERF_COUNT_HW_CPU_CYCLES,
-		.sample_type            = PERF_SAMPLE_REGS_INTR,
-		.precise_ip             = 1,
-		.disabled               = 1,
-		.exclude_kernel         = 1,
-	};
-	int fd;
-	u32 version;
-	u64 extended_mask = 0, mask = PERF_REGS_MASK;
-
-	/*
-	 * Get the PVR value to set the extended
-	 * mask specific to platform.
-	 */
-	version = (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
-	if (version == PVR_POWER9)
-		extended_mask = PERF_REG_PMU_MASK_300;
-	else if ((version == PVR_POWER10) || (version == PVR_POWER11))
-		extended_mask = PERF_REG_PMU_MASK_31;
-	else
-		return mask;
-
-	attr.sample_regs_intr = extended_mask;
-	attr.sample_period = 1;
-	event_attr_init(&attr);
-
-	/*
-	 * check if the pmu supports perf extended regs, before
-	 * returning the register mask to sample.
-	 */
-	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
-	if (fd != -1) {
-		close(fd);
-		mask |= extended_mask;
-	}
-	return mask;
-}
-
-uint64_t arch__user_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
diff --git a/tools/perf/arch/riscv/include/perf_regs.h b/tools/perf/arch/riscv/include/perf_regs.h
index d482edb413e5..df3566e4c2c4 100644
--- a/tools/perf/arch/riscv/include/perf_regs.h
+++ b/tools/perf/arch/riscv/include/perf_regs.h
@@ -10,10 +10,17 @@
 
 #define PERF_REGS_MASK	((1ULL << PERF_REG_RISCV_MAX) - 1)
 #define PERF_REGS_MAX	PERF_REG_RISCV_MAX
+
+#if defined (__riscv_xlen)
+
 #if __riscv_xlen == 64
 #define PERF_SAMPLE_REGS_ABI    PERF_SAMPLE_REGS_ABI_64
 #else
 #define PERF_SAMPLE_REGS_ABI	PERF_SAMPLE_REGS_ABI_32
 #endif
 
+#else
+#define PERF_SAMPLE_REGS_ABI	PERF_SAMPLE_REGS_NONE
+#endif
+
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
index 628b9ebd418b..da5b12e7f862 100644
--- a/tools/perf/arch/riscv/util/Build
+++ b/tools/perf/arch/riscv/util/Build
@@ -1,4 +1,3 @@
-perf-util-y += perf_regs.o
 perf-util-y += header.o
 
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/riscv/util/perf_regs.c
deleted file mode 100644
index 2cf7a54106e0..000000000000
--- a/tools/perf/arch/riscv/util/perf_regs.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "perf_regs.h"
-#include "../../util/perf_regs.h"
-
-uint64_t arch__intr_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
-
-uint64_t arch__user_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index 5391d26fedd4..3b09c058e0ec 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -1,6 +1,5 @@
 perf-util-y += header.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-util-y += perf_regs.o
 
 perf-util-y += machine.o
 perf-util-y += pmu.o
diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390/util/perf_regs.c
deleted file mode 100644
index 2cf7a54106e0..000000000000
--- a/tools/perf/arch/s390/util/perf_regs.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "perf_regs.h"
-#include "../../util/perf_regs.h"
-
-uint64_t arch__intr_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
-
-uint64_t arch__user_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index fad256252bb9..b7b401cfbd45 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -2,7 +2,6 @@ perf-util-y += header.o
 perf-util-y += tsc.o
 perf-util-y += pmu.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-util-y += perf_regs.o
 perf-util-y += topdown.o
 perf-util-y += machine.o
 perf-util-y += event.o
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
deleted file mode 100644
index a7ca4154fdf9..000000000000
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ /dev/null
@@ -1,283 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <errno.h>
-#include <string.h>
-#include <regex.h>
-#include <linux/kernel.h>
-#include <linux/zalloc.h>
-
-#include "perf_regs.h"
-#include "../../../perf-sys.h"
-#include "../../../util/perf_regs.h"
-#include "../../../util/debug.h"
-#include "../../../util/event.h"
-#include "../../../util/pmu.h"
-#include "../../../util/pmus.h"
-
-struct sdt_name_reg {
-	const char *sdt_name;
-	const char *uprobe_name;
-};
-#define SDT_NAME_REG(n, m) {.sdt_name = "%" #n, .uprobe_name = "%" #m}
-#define SDT_NAME_REG_END {.sdt_name = NULL, .uprobe_name = NULL}
-
-static const struct sdt_name_reg sdt_reg_tbl[] = {
-	SDT_NAME_REG(eax, ax),
-	SDT_NAME_REG(rax, ax),
-	SDT_NAME_REG(al,  ax),
-	SDT_NAME_REG(ah,  ax),
-	SDT_NAME_REG(ebx, bx),
-	SDT_NAME_REG(rbx, bx),
-	SDT_NAME_REG(bl,  bx),
-	SDT_NAME_REG(bh,  bx),
-	SDT_NAME_REG(ecx, cx),
-	SDT_NAME_REG(rcx, cx),
-	SDT_NAME_REG(cl,  cx),
-	SDT_NAME_REG(ch,  cx),
-	SDT_NAME_REG(edx, dx),
-	SDT_NAME_REG(rdx, dx),
-	SDT_NAME_REG(dl,  dx),
-	SDT_NAME_REG(dh,  dx),
-	SDT_NAME_REG(esi, si),
-	SDT_NAME_REG(rsi, si),
-	SDT_NAME_REG(sil, si),
-	SDT_NAME_REG(edi, di),
-	SDT_NAME_REG(rdi, di),
-	SDT_NAME_REG(dil, di),
-	SDT_NAME_REG(ebp, bp),
-	SDT_NAME_REG(rbp, bp),
-	SDT_NAME_REG(bpl, bp),
-	SDT_NAME_REG(rsp, sp),
-	SDT_NAME_REG(esp, sp),
-	SDT_NAME_REG(spl, sp),
-
-	/* rNN registers */
-	SDT_NAME_REG(r8b,  r8),
-	SDT_NAME_REG(r8w,  r8),
-	SDT_NAME_REG(r8d,  r8),
-	SDT_NAME_REG(r9b,  r9),
-	SDT_NAME_REG(r9w,  r9),
-	SDT_NAME_REG(r9d,  r9),
-	SDT_NAME_REG(r10b, r10),
-	SDT_NAME_REG(r10w, r10),
-	SDT_NAME_REG(r10d, r10),
-	SDT_NAME_REG(r11b, r11),
-	SDT_NAME_REG(r11w, r11),
-	SDT_NAME_REG(r11d, r11),
-	SDT_NAME_REG(r12b, r12),
-	SDT_NAME_REG(r12w, r12),
-	SDT_NAME_REG(r12d, r12),
-	SDT_NAME_REG(r13b, r13),
-	SDT_NAME_REG(r13w, r13),
-	SDT_NAME_REG(r13d, r13),
-	SDT_NAME_REG(r14b, r14),
-	SDT_NAME_REG(r14w, r14),
-	SDT_NAME_REG(r14d, r14),
-	SDT_NAME_REG(r15b, r15),
-	SDT_NAME_REG(r15w, r15),
-	SDT_NAME_REG(r15d, r15),
-	SDT_NAME_REG_END,
-};
-
-/*
- * Perf only supports OP which is in  +/-NUM(REG)  form.
- * Here plus-minus sign, NUM and parenthesis are optional,
- * only REG is mandatory.
- *
- * SDT events also supports indirect addressing mode with a
- * symbol as offset, scaled mode and constants in OP. But
- * perf does not support them yet. Below are few examples.
- *
- * OP with scaled mode:
- *     (%rax,%rsi,8)
- *     10(%ras,%rsi,8)
- *
- * OP with indirect addressing mode:
- *     check_action(%rip)
- *     mp_+52(%rip)
- *     44+mp_(%rip)
- *
- * OP with constant values:
- *     $0
- *     $123
- *     $-1
- */
-#define SDT_OP_REGEX  "^([+\\-]?)([0-9]*)(\\(?)(%[a-z][a-z0-9]+)(\\)?)$"
-
-static regex_t sdt_op_regex;
-
-static int sdt_init_op_regex(void)
-{
-	static int initialized;
-	int ret = 0;
-
-	if (initialized)
-		return 0;
-
-	ret = regcomp(&sdt_op_regex, SDT_OP_REGEX, REG_EXTENDED);
-	if (ret < 0) {
-		pr_debug4("Regex compilation error.\n");
-		return ret;
-	}
-
-	initialized = 1;
-	return 0;
-}
-
-/*
- * Max x86 register name length is 5(ex: %r15d). So, 6th char
- * should always contain NULL. This helps to find register name
- * length using strlen, instead of maintaining one more variable.
- */
-#define SDT_REG_NAME_SIZE  6
-
-/*
- * The uprobe parser does not support all gas register names;
- * so, we have to replace them (ex. for x86_64: %rax -> %ax).
- * Note: If register does not require renaming, just copy
- * paste as it is, but don't leave it empty.
- */
-static void sdt_rename_register(char *sdt_reg, int sdt_len, char *uprobe_reg)
-{
-	int i = 0;
-
-	for (i = 0; sdt_reg_tbl[i].sdt_name != NULL; i++) {
-		if (!strncmp(sdt_reg_tbl[i].sdt_name, sdt_reg, sdt_len)) {
-			strcpy(uprobe_reg, sdt_reg_tbl[i].uprobe_name);
-			return;
-		}
-	}
-
-	strncpy(uprobe_reg, sdt_reg, sdt_len);
-}
-
-int arch_sdt_arg_parse_op(char *old_op, char **new_op)
-{
-	char new_reg[SDT_REG_NAME_SIZE] = {0};
-	int new_len = 0, ret;
-	/*
-	 * rm[0]:  +/-NUM(REG)
-	 * rm[1]:  +/-
-	 * rm[2]:  NUM
-	 * rm[3]:  (
-	 * rm[4]:  REG
-	 * rm[5]:  )
-	 */
-	regmatch_t rm[6];
-	/*
-	 * Max prefix length is 2 as it may contains sign(+/-)
-	 * and displacement 0 (Both sign and displacement 0 are
-	 * optional so it may be empty). Use one more character
-	 * to hold last NULL so that strlen can be used to find
-	 * prefix length, instead of maintaining one more variable.
-	 */
-	char prefix[3] = {0};
-
-	ret = sdt_init_op_regex();
-	if (ret < 0)
-		return ret;
-
-	/*
-	 * If unsupported OR does not match with regex OR
-	 * register name too long, skip it.
-	 */
-	if (strchr(old_op, ',') || strchr(old_op, '$') ||
-	    regexec(&sdt_op_regex, old_op, 6, rm, 0)   ||
-	    rm[4].rm_eo - rm[4].rm_so > SDT_REG_NAME_SIZE) {
-		pr_debug4("Skipping unsupported SDT argument: %s\n", old_op);
-		return SDT_ARG_SKIP;
-	}
-
-	/*
-	 * Prepare prefix.
-	 * If SDT OP has parenthesis but does not provide
-	 * displacement, add 0 for displacement.
-	 *     SDT         Uprobe     Prefix
-	 *     -----------------------------
-	 *     +24(%rdi)   +24(%di)   +
-	 *     24(%rdi)    +24(%di)   +
-	 *     %rdi        %di
-	 *     (%rdi)      +0(%di)    +0
-	 *     -80(%rbx)   -80(%bx)   -
-	 */
-	if (rm[3].rm_so != rm[3].rm_eo) {
-		if (rm[1].rm_so != rm[1].rm_eo)
-			prefix[0] = *(old_op + rm[1].rm_so);
-		else if (rm[2].rm_so != rm[2].rm_eo)
-			prefix[0] = '+';
-		else
-			scnprintf(prefix, sizeof(prefix), "+0");
-	}
-
-	/* Rename register */
-	sdt_rename_register(old_op + rm[4].rm_so, rm[4].rm_eo - rm[4].rm_so,
-			    new_reg);
-
-	/* Prepare final OP which should be valid for uprobe_events */
-	new_len = strlen(prefix)              +
-		  (rm[2].rm_eo - rm[2].rm_so) +
-		  (rm[3].rm_eo - rm[3].rm_so) +
-		  strlen(new_reg)             +
-		  (rm[5].rm_eo - rm[5].rm_so) +
-		  1;					/* NULL */
-
-	*new_op = zalloc(new_len);
-	if (!*new_op)
-		return -ENOMEM;
-
-	scnprintf(*new_op, new_len, "%.*s%.*s%.*s%.*s%.*s",
-		  strlen(prefix), prefix,
-		  (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].rm_so,
-		  (int)(rm[3].rm_eo - rm[3].rm_so), old_op + rm[3].rm_so,
-		  strlen(new_reg), new_reg,
-		  (int)(rm[5].rm_eo - rm[5].rm_so), old_op + rm[5].rm_so);
-
-	return SDT_ARG_VALID;
-}
-
-uint64_t arch__intr_reg_mask(void)
-{
-	struct perf_event_attr attr = {
-		.type			= PERF_TYPE_HARDWARE,
-		.config			= PERF_COUNT_HW_CPU_CYCLES,
-		.sample_type		= PERF_SAMPLE_REGS_INTR,
-		.sample_regs_intr	= PERF_REG_EXTENDED_MASK,
-		.precise_ip		= 1,
-		.disabled 		= 1,
-		.exclude_kernel		= 1,
-	};
-	int fd;
-	/*
-	 * In an unnamed union, init it here to build on older gcc versions
-	 */
-	attr.sample_period = 1;
-
-	if (perf_pmus__num_core_pmus() > 1) {
-		struct perf_pmu *pmu = NULL;
-		__u64 type = PERF_TYPE_RAW;
-
-		/*
-		 * The same register set is supported among different hybrid PMUs.
-		 * Only check the first available one.
-		 */
-		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
-			type = pmu->type;
-			break;
-		}
-		attr.config |= type << PERF_PMU_TYPE_SHIFT;
-	}
-
-	event_attr_init(&attr);
-
-	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
-	if (fd != -1) {
-		close(fd);
-		return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
-	}
-
-	return PERF_REGS_MASK;
-}
-
-uint64_t arch__user_reg_mask(void)
-{
-	return PERF_REGS_MASK;
-}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5ac1a05601b1..a36528fd41c6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1055,13 +1055,13 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 			evsel__set_sample_bit(evsel, REGS_USER);
 			evsel__set_sample_bit(evsel, STACK_USER);
 			if (opts->sample_user_regs &&
-			    DWARF_MINIMAL_REGS(e_machine) != arch__user_reg_mask()) {
+			    DWARF_MINIMAL_REGS(e_machine) != perf_user_reg_mask(EM_HOST)) {
 				attr->sample_regs_user |= DWARF_MINIMAL_REGS(e_machine);
 				pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
 					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
 					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
 			} else {
-				attr->sample_regs_user |= arch__user_reg_mask();
+				attr->sample_regs_user |= perf_user_reg_mask(EM_HOST);
 			}
 			attr->sample_stack_user = param->dump_size;
 			attr->exclude_callchain_user = 1;
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index c0d0ef9fd495..2af6e4ad2a34 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -70,7 +70,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	if (!str)
 		return -1;
 
-	mask = intr ? arch__intr_reg_mask() : arch__user_reg_mask();
+	mask = intr ? perf_intr_reg_mask(EM_HOST) : perf_user_reg_mask(EM_HOST);
 
 	/* because str is read-only */
 	s = os = strdup(str);
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c b/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
index 9dcda80d310f..fb31b7625e68 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
@@ -1,7 +1,143 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <regex.h>
+#include <string.h>
+#include <sys/auxv.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
 
-#include "../perf_regs.h"
-#include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
+#include "../debug.h"		/* tools/perf/util/debug.h */
+#include "../event.h"		/* tools/perf/util/event.h */
+#include "../perf_regs.h"	/* tools/perf/util/perf_regs.h */
+#include "../../perf-sys.h"	/* tools/perf/perf-sys.h */
+#include "../../arch/arm64/include/perf_regs.h"	/* tools/perf/arch/arm64/include/perf_regs.h */
+#include "../../../arch/arm64/include/uapi/asm/perf_regs.h" /* tools/arch/arm64/include/uapi/asm/perf_regs.h */
+
+#define SMPL_REG_MASK(b) (1ULL << (b))
+
+#ifndef HWCAP_SVE
+#define HWCAP_SVE	(1 << 22)
+#endif
+
+/* %xNUM */
+#define SDT_OP_REGEX1  "^(x[1-2]?[0-9]|3[0-1])$"
+
+/* [sp], [sp, NUM] */
+#define SDT_OP_REGEX2  "^\\[sp(, )?([0-9]+)?\\]$"
+
+static regex_t sdt_op_regex1, sdt_op_regex2;
+
+static int sdt_init_op_regex(void)
+{
+	static int initialized;
+	int ret = 0;
+
+	if (initialized)
+		return 0;
+
+	ret = regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
+	if (ret)
+		goto error;
+
+	ret = regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
+	if (ret)
+		goto free_regex1;
+
+	initialized = 1;
+	return 0;
+
+free_regex1:
+	regfree(&sdt_op_regex1);
+error:
+	pr_debug4("Regex compilation error.\n");
+	return ret;
+}
+
+/*
+ * SDT marker arguments on Arm64 uses %xREG or [sp, NUM], currently
+ * support these two formats.
+ */
+int __perf_sdt_arg_parse_op_arm64(char *old_op, char **new_op)
+{
+	int ret, new_len;
+	regmatch_t rm[5];
+
+	ret = sdt_init_op_regex();
+	if (ret < 0)
+		return ret;
+
+	if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
+		/* Extract xNUM */
+		new_len = 2;	/* % NULL */
+		new_len += (int)(rm[1].rm_eo - rm[1].rm_so);
+
+		*new_op = zalloc(new_len);
+		if (!*new_op)
+			return -ENOMEM;
+
+		scnprintf(*new_op, new_len, "%%%.*s",
+			(int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1].rm_so);
+	} else if (!regexec(&sdt_op_regex2, old_op, 5, rm, 0)) {
+		/* [sp], [sp, NUM] or [sp,NUM] */
+		new_len = 7;	/* + ( % s p ) NULL */
+
+		/* If the argument is [sp], need to fill offset '0' */
+		if (rm[2].rm_so == -1)
+			new_len += 1;
+		else
+			new_len += (int)(rm[2].rm_eo - rm[2].rm_so);
+
+		*new_op = zalloc(new_len);
+		if (!*new_op)
+			return -ENOMEM;
+
+		if (rm[2].rm_so == -1)
+			scnprintf(*new_op, new_len, "+0(%%sp)");
+		else
+			scnprintf(*new_op, new_len, "+%.*s(%%sp)",
+				  (int)(rm[2].rm_eo - rm[2].rm_so),
+				  old_op + rm[2].rm_so);
+	} else {
+		pr_debug4("Skipping unsupported SDT argument: %s\n", old_op);
+		return SDT_ARG_SKIP;
+	}
+
+	return SDT_ARG_VALID;
+}
+
+uint64_t __perf_reg_mask_arm64(bool intr)
+{
+	struct perf_event_attr attr = {
+		.type                   = PERF_TYPE_HARDWARE,
+		.config                 = PERF_COUNT_HW_CPU_CYCLES,
+		.sample_type            = PERF_SAMPLE_REGS_USER,
+		.disabled               = 1,
+		.exclude_kernel         = 1,
+		.sample_period		= 1,
+		.sample_regs_user	= PERF_REGS_MASK
+	};
+	int fd;
+
+	if (intr)
+		return PERF_REGS_MASK;
+
+	if (getauxval(AT_HWCAP) & HWCAP_SVE)
+		attr.sample_regs_user |= SMPL_REG_MASK(PERF_REG_ARM64_VG);
+
+	/*
+	 * Check if the pmu supports perf extended regs, before
+	 * returning the register mask to sample.
+	 */
+	if (attr.sample_regs_user != PERF_REGS_MASK) {
+		event_attr_init(&attr);
+		fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+		if (fd != -1) {
+			close(fd);
+			return attr.sample_regs_user;
+		}
+	}
+	return PERF_REGS_MASK;
+}
 
 const char *__perf_reg_name_arm64(int id)
 {
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_arm.c b/tools/perf/util/perf-regs-arch/perf_regs_arm.c
index e29d130a587a..70f00308991a 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_arm.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_arm.c
@@ -1,7 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "../perf_regs.h"
-#include "../../../arch/arm/include/uapi/asm/perf_regs.h"
+#include "../perf_regs.h"	/* tools/perf/util/perf_regs.h */
+#include "../../arch/arm/include/perf_regs.h"	/* tools/perf/arch/arm/include/perf_regs.h */
+#include "../../../arch/arm/include/uapi/asm/perf_regs.h" /* tools/arch/arm/include/uapi/asm/perf_regs.h */
+
+uint64_t __perf_reg_mask_arm(bool intr __maybe_unused)
+{
+	return PERF_REGS_MASK;
+}
 
 const char *__perf_reg_name_arm(int id)
 {
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_csky.c b/tools/perf/util/perf-regs-arch/perf_regs_csky.c
index 75b461ef2eba..c656af151a03 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_csky.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_csky.c
@@ -1,7 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "../perf_regs.h"
-#include "../../arch/csky/include/uapi/asm/perf_regs.h"
+#include "../perf_regs.h"	/* tools/perf/util/perf_regs.h */
+#include "../../arch/csky/include/perf_regs.h"	/* tools/perf/arch/csky/include/perf_regs.h */
+#include "../../../arch/csky/include/uapi/asm/perf_regs.h" /* tools/arch/csky/include/uapi/asm/perf_regs.h */
+
+uint64_t __perf_reg_mask_csky(bool intr __maybe_unused)
+{
+	return PERF_REGS_MASK;
+}
 
 const char *__perf_reg_name_csky(int id)
 {
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c b/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
index 043f97f4e3ac..1325a71158a8 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
@@ -1,7 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "../perf_regs.h"
-#include "../../../arch/loongarch/include/uapi/asm/perf_regs.h"
+#include "../perf_regs.h"	/* tools/perf/util/perf_regs.h */
+#include "../../arch/loongarch/include/perf_regs.h"	/* tools/perf/arch/loongarch/include/perf_regs.h */
+#include "../../../arch/loongarch/include/uapi/asm/perf_regs.h" /* tools/arch/loongarch/include/uapi/asm/perf_regs.h */
+
+uint64_t __perf_reg_mask_loongarch(bool intr __maybe_unused)
+{
+	return PERF_REGS_MASK;
+}
 
 const char *__perf_reg_name_loongarch(int id)
 {
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_mips.c b/tools/perf/util/perf-regs-arch/perf_regs_mips.c
index 793178fc3c78..2d7ebd284db2 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_mips.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_mips.c
@@ -1,7 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "../perf_regs.h"
-#include "../../../arch/mips/include/uapi/asm/perf_regs.h"
+#include "../perf_regs.h"	/* tools/perf/util/perf_regs.h */
+#include "../../arch/mips/include/perf_regs.h"	/* tools/perf/arch/mips/include/perf_regs.h */
+#include "../../../arch/mips/include/uapi/asm/perf_regs.h" /* tools/arch/mips/include/uapi/asm/perf_regs.h */
+
+uint64_t __perf_reg_mask_mips(bool intr __maybe_unused)
+{
+	return PERF_REGS_MASK;
+}
 
 const char *__perf_reg_name_mips(int id)
 {
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c b/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
index 08636bb09a3a..74c269e9f25c 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
@@ -1,7 +1,182 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "../perf_regs.h"
-#include "../../../arch/powerpc/include/uapi/asm/perf_regs.h"
+#include <errno.h>
+#include <string.h>
+#include <regex.h>
+#include <linux/zalloc.h>
+
+#include "../debug.h"		/* tools/perf/util/debug.h */
+#include "../event.h"		/* tools/perf/util/event.h */
+#include "../header.h"		/* tools/perf/util/header.h */
+#include "../perf_regs.h"	/* tools/perf/util/perf_regs.h */
+#include "../../perf-sys.h"	/* tools/perf/perf-sys.h */
+#include "../../arch/powerpc/util/utils_header.h"	/* tools/perf/arch/powerpc/util/utils_header.h */
+#include "../../arch/powerpc/include/perf_regs.h"	/* tools/perf/arch/powerpc/include/perf_regs.h */
+#include "../../../arch/powerpc/include/uapi/asm/perf_regs.h" /* tools/arch/powerpc/include/uapi/asm/perf_regs.h */
+
+#include <linux/kernel.h>
+
+#define PVR_POWER9		0x004E
+#define PVR_POWER10		0x0080
+#define PVR_POWER11		0x0082
+
+/* REG or %rREG */
+#define SDT_OP_REGEX1  "^(%r)?([1-2]?[0-9]|3[0-1])$"
+
+/* -NUM(REG) or NUM(REG) or -NUM(%rREG) or NUM(%rREG) */
+#define SDT_OP_REGEX2  "^(\\-)?([0-9]+)\\((%r)?([1-2]?[0-9]|3[0-1])\\)$"
+
+static regex_t sdt_op_regex1, sdt_op_regex2;
+
+static int sdt_init_op_regex(void)
+{
+	static int initialized;
+	int ret = 0;
+
+	if (initialized)
+		return 0;
+
+	ret = regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
+	if (ret)
+		goto error;
+
+	ret = regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
+	if (ret)
+		goto free_regex1;
+
+	initialized = 1;
+	return 0;
+
+free_regex1:
+	regfree(&sdt_op_regex1);
+error:
+	pr_debug4("Regex compilation error.\n");
+	return ret;
+}
+
+/*
+ * Parse OP and convert it into uprobe format, which is, +/-NUM(%gprREG).
+ * Possible variants of OP are:
+ *	Format		Example
+ *	-------------------------
+ *	NUM(REG)	48(18)
+ *	-NUM(REG)	-48(18)
+ *	NUM(%rREG)	48(%r18)
+ *	-NUM(%rREG)	-48(%r18)
+ *	REG		18
+ *	%rREG		%r18
+ *	iNUM		i0
+ *	i-NUM		i-1
+ *
+ * SDT marker arguments on Powerpc uses %rREG form with -mregnames flag
+ * and REG form with -mno-regnames. Here REG is general purpose register,
+ * which is in 0 to 31 range.
+ */
+int __perf_sdt_arg_parse_op_powerpc(char *old_op, char **new_op)
+{
+	int ret, new_len;
+	regmatch_t rm[5];
+	char prefix;
+
+	/* Constant argument. Uprobe does not support it */
+	if (old_op[0] == 'i') {
+		pr_debug4("Skipping unsupported SDT argument: %s\n", old_op);
+		return SDT_ARG_SKIP;
+	}
+
+	ret = sdt_init_op_regex();
+	if (ret < 0)
+		return ret;
+
+	if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
+		/* REG or %rREG --> %gprREG */
+
+		new_len = 5;	/* % g p r NULL */
+		new_len += (int)(rm[2].rm_eo - rm[2].rm_so);
+
+		*new_op = zalloc(new_len);
+		if (!*new_op)
+			return -ENOMEM;
+
+		scnprintf(*new_op, new_len, "%%gpr%.*s",
+			(int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].rm_so);
+	} else if (!regexec(&sdt_op_regex2, old_op, 5, rm, 0)) {
+		/*
+		 * -NUM(REG) or NUM(REG) or -NUM(%rREG) or NUM(%rREG) -->
+		 *	+/-NUM(%gprREG)
+		 */
+		prefix = (rm[1].rm_so == -1) ? '+' : '-';
+
+		new_len = 8;	/* +/- ( % g p r ) NULL */
+		new_len += (int)(rm[2].rm_eo - rm[2].rm_so);
+		new_len += (int)(rm[4].rm_eo - rm[4].rm_so);
+
+		*new_op = zalloc(new_len);
+		if (!*new_op)
+			return -ENOMEM;
+
+		scnprintf(*new_op, new_len, "%c%.*s(%%gpr%.*s)", prefix,
+			(int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].rm_so,
+			(int)(rm[4].rm_eo - rm[4].rm_so), old_op + rm[4].rm_so);
+	} else {
+		pr_debug4("Skipping unsupported SDT argument: %s\n", old_op);
+		return SDT_ARG_SKIP;
+	}
+
+	return SDT_ARG_VALID;
+}
+
+#if defined(__powerpc64__) && defined(__powerpc__)
+uint64_t __perf_reg_mask_powerpc(bool intr)
+{
+	struct perf_event_attr attr = {
+		.type                   = PERF_TYPE_HARDWARE,
+		.config                 = PERF_COUNT_HW_CPU_CYCLES,
+		.sample_type            = PERF_SAMPLE_REGS_INTR,
+		.precise_ip             = 1,
+		.disabled               = 1,
+		.exclude_kernel         = 1,
+	};
+	int fd;
+	u32 version;
+	u64 extended_mask = 0, mask = PERF_REGS_MASK;
+
+	if (!intr)
+		return PERF_REGS_MASK;
+
+	/*
+	 * Get the PVR value to set the extended
+	 * mask specific to platform.
+	 */
+	version = (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
+	if (version == PVR_POWER9)
+		extended_mask = PERF_REG_PMU_MASK_300;
+	else if ((version == PVR_POWER10) || (version == PVR_POWER11))
+		extended_mask = PERF_REG_PMU_MASK_31;
+	else
+		return mask;
+
+	attr.sample_regs_intr = extended_mask;
+	attr.sample_period = 1;
+	event_attr_init(&attr);
+
+	/*
+	 * check if the pmu supports perf extended regs, before
+	 * returning the register mask to sample.
+	 */
+	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+	if (fd != -1) {
+		close(fd);
+		mask |= extended_mask;
+	}
+	return mask;
+}
+#else
+uint64_t __perf_reg_mask_powerpc(bool intr __maybe_unused)
+{
+	return PERF_REGS_MASK;
+}
+#endif
 
 const char *__perf_reg_name_powerpc(int id)
 {
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
index 337b687c655d..bf87a8ce0ad3 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
@@ -1,7 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "../perf_regs.h"
-#include "../../../arch/riscv/include/uapi/asm/perf_regs.h"
+#include "../perf_regs.h"	/* tools/perf/util/perf_regs.h */
+#include "../../arch/riscv/include/perf_regs.h"	/* tools/perf/arch/riscv/include/perf_regs.h */
+#include "../../../arch/riscv/include/uapi/asm/perf_regs.h" /* tools/arch/riscv/include/uapi/asm/perf_regs.h */
+
+uint64_t __perf_reg_mask_riscv(bool intr __maybe_unused)
+{
+	return PERF_REGS_MASK;
+}
 
 const char *__perf_reg_name_riscv(int id)
 {
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
index d69bba881080..4095922997aa 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_s390.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
@@ -1,7 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "../perf_regs.h"
-#include "../../../arch/s390/include/uapi/asm/perf_regs.h"
+#include "../perf_regs.h"	/* tools/perf/util/perf_regs.h */
+#include "../../arch/s390/include/perf_regs.h"	/* tools/perf/arch/s390/include/perf_regs.h */
+#include "../../../arch/s390/include/uapi/asm/perf_regs.h" /* tools/arch/s390/include/uapi/asm/perf_regs.h */
+
+uint64_t __perf_reg_mask_s390(bool intr __maybe_unused)
+{
+	return PERF_REGS_MASK;
+}
 
 const char *__perf_reg_name_s390(int id)
 {
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index 708954a9d35d..b3bcee7a774a 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -1,7 +1,287 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "../perf_regs.h"
-#include "../../../arch/x86/include/uapi/asm/perf_regs.h"
+#include <errno.h>
+#include <string.h>
+#include <regex.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
+
+#include "../debug.h"		/* tools/perf/util/debug.h */
+#include "../event.h"		/* tools/perf/util/event.h */
+#include "../pmu.h"		/* tools/perf/util/pmu.h */
+#include "../pmus.h"		/* tools/perf/util/pmus.h */
+#include "../perf_regs.h"	/* tools/perf/util/perf_regs.h */
+#include "../../perf-sys.h"	/* tools/perf/perf-sys.h */
+#include "../../arch/x86/include/perf_regs.h"	/* tools/perf/arch/x86/include/perf_regs.h */
+#include "../../../arch/x86/include/uapi/asm/perf_regs.h" /* tools/arch/x86/include/uapi/asm/perf_regs.h */
+
+struct sdt_name_reg {
+	const char *sdt_name;
+	const char *uprobe_name;
+};
+#define SDT_NAME_REG(n, m) {.sdt_name = "%" #n, .uprobe_name = "%" #m}
+#define SDT_NAME_REG_END {.sdt_name = NULL, .uprobe_name = NULL}
+
+static const struct sdt_name_reg sdt_reg_tbl[] = {
+	SDT_NAME_REG(eax, ax),
+	SDT_NAME_REG(rax, ax),
+	SDT_NAME_REG(al,  ax),
+	SDT_NAME_REG(ah,  ax),
+	SDT_NAME_REG(ebx, bx),
+	SDT_NAME_REG(rbx, bx),
+	SDT_NAME_REG(bl,  bx),
+	SDT_NAME_REG(bh,  bx),
+	SDT_NAME_REG(ecx, cx),
+	SDT_NAME_REG(rcx, cx),
+	SDT_NAME_REG(cl,  cx),
+	SDT_NAME_REG(ch,  cx),
+	SDT_NAME_REG(edx, dx),
+	SDT_NAME_REG(rdx, dx),
+	SDT_NAME_REG(dl,  dx),
+	SDT_NAME_REG(dh,  dx),
+	SDT_NAME_REG(esi, si),
+	SDT_NAME_REG(rsi, si),
+	SDT_NAME_REG(sil, si),
+	SDT_NAME_REG(edi, di),
+	SDT_NAME_REG(rdi, di),
+	SDT_NAME_REG(dil, di),
+	SDT_NAME_REG(ebp, bp),
+	SDT_NAME_REG(rbp, bp),
+	SDT_NAME_REG(bpl, bp),
+	SDT_NAME_REG(rsp, sp),
+	SDT_NAME_REG(esp, sp),
+	SDT_NAME_REG(spl, sp),
+
+	/* rNN registers */
+	SDT_NAME_REG(r8b,  r8),
+	SDT_NAME_REG(r8w,  r8),
+	SDT_NAME_REG(r8d,  r8),
+	SDT_NAME_REG(r9b,  r9),
+	SDT_NAME_REG(r9w,  r9),
+	SDT_NAME_REG(r9d,  r9),
+	SDT_NAME_REG(r10b, r10),
+	SDT_NAME_REG(r10w, r10),
+	SDT_NAME_REG(r10d, r10),
+	SDT_NAME_REG(r11b, r11),
+	SDT_NAME_REG(r11w, r11),
+	SDT_NAME_REG(r11d, r11),
+	SDT_NAME_REG(r12b, r12),
+	SDT_NAME_REG(r12w, r12),
+	SDT_NAME_REG(r12d, r12),
+	SDT_NAME_REG(r13b, r13),
+	SDT_NAME_REG(r13w, r13),
+	SDT_NAME_REG(r13d, r13),
+	SDT_NAME_REG(r14b, r14),
+	SDT_NAME_REG(r14w, r14),
+	SDT_NAME_REG(r14d, r14),
+	SDT_NAME_REG(r15b, r15),
+	SDT_NAME_REG(r15w, r15),
+	SDT_NAME_REG(r15d, r15),
+	SDT_NAME_REG_END,
+};
+
+/*
+ * Perf only supports OP which is in  +/-NUM(REG)  form.
+ * Here plus-minus sign, NUM and parenthesis are optional,
+ * only REG is mandatory.
+ *
+ * SDT events also supports indirect addressing mode with a
+ * symbol as offset, scaled mode and constants in OP. But
+ * perf does not support them yet. Below are few examples.
+ *
+ * OP with scaled mode:
+ *     (%rax,%rsi,8)
+ *     10(%ras,%rsi,8)
+ *
+ * OP with indirect addressing mode:
+ *     check_action(%rip)
+ *     mp_+52(%rip)
+ *     44+mp_(%rip)
+ *
+ * OP with constant values:
+ *     $0
+ *     $123
+ *     $-1
+ */
+#define SDT_OP_REGEX  "^([+\\-]?)([0-9]*)(\\(?)(%[a-z][a-z0-9]+)(\\)?)$"
+
+static regex_t sdt_op_regex;
+
+static int sdt_init_op_regex(void)
+{
+	static int initialized;
+	int ret = 0;
+
+	if (initialized)
+		return 0;
+
+	ret = regcomp(&sdt_op_regex, SDT_OP_REGEX, REG_EXTENDED);
+	if (ret < 0) {
+		pr_debug4("Regex compilation error.\n");
+		return ret;
+	}
+
+	initialized = 1;
+	return 0;
+}
+
+/*
+ * Max x86 register name length is 5(ex: %r15d). So, 6th char
+ * should always contain NULL. This helps to find register name
+ * length using strlen, instead of maintaining one more variable.
+ */
+#define SDT_REG_NAME_SIZE  6
+
+/*
+ * The uprobe parser does not support all gas register names;
+ * so, we have to replace them (ex. for x86_64: %rax -> %ax).
+ * Note: If register does not require renaming, just copy
+ * paste as it is, but don't leave it empty.
+ */
+static void sdt_rename_register(char *sdt_reg, int sdt_len, char *uprobe_reg)
+{
+	int i = 0;
+
+	for (i = 0; sdt_reg_tbl[i].sdt_name != NULL; i++) {
+		if (!strncmp(sdt_reg_tbl[i].sdt_name, sdt_reg, sdt_len)) {
+			strcpy(uprobe_reg, sdt_reg_tbl[i].uprobe_name);
+			return;
+		}
+	}
+
+	strncpy(uprobe_reg, sdt_reg, sdt_len);
+}
+
+int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op)
+{
+	char new_reg[SDT_REG_NAME_SIZE] = {0};
+	int new_len = 0, ret;
+	/*
+	 * rm[0]:  +/-NUM(REG)
+	 * rm[1]:  +/-
+	 * rm[2]:  NUM
+	 * rm[3]:  (
+	 * rm[4]:  REG
+	 * rm[5]:  )
+	 */
+	regmatch_t rm[6];
+	/*
+	 * Max prefix length is 2 as it may contains sign(+/-)
+	 * and displacement 0 (Both sign and displacement 0 are
+	 * optional so it may be empty). Use one more character
+	 * to hold last NULL so that strlen can be used to find
+	 * prefix length, instead of maintaining one more variable.
+	 */
+	char prefix[3] = {0};
+
+	ret = sdt_init_op_regex();
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * If unsupported OR does not match with regex OR
+	 * register name too long, skip it.
+	 */
+	if (strchr(old_op, ',') || strchr(old_op, '$') ||
+	    regexec(&sdt_op_regex, old_op, 6, rm, 0)   ||
+	    rm[4].rm_eo - rm[4].rm_so > SDT_REG_NAME_SIZE) {
+		pr_debug4("Skipping unsupported SDT argument: %s\n", old_op);
+		return SDT_ARG_SKIP;
+	}
+
+	/*
+	 * Prepare prefix.
+	 * If SDT OP has parenthesis but does not provide
+	 * displacement, add 0 for displacement.
+	 *     SDT         Uprobe     Prefix
+	 *     -----------------------------
+	 *     +24(%rdi)   +24(%di)   +
+	 *     24(%rdi)    +24(%di)   +
+	 *     %rdi        %di
+	 *     (%rdi)      +0(%di)    +0
+	 *     -80(%rbx)   -80(%bx)   -
+	 */
+	if (rm[3].rm_so != rm[3].rm_eo) {
+		if (rm[1].rm_so != rm[1].rm_eo)
+			prefix[0] = *(old_op + rm[1].rm_so);
+		else if (rm[2].rm_so != rm[2].rm_eo)
+			prefix[0] = '+';
+		else
+			scnprintf(prefix, sizeof(prefix), "+0");
+	}
+
+	/* Rename register */
+	sdt_rename_register(old_op + rm[4].rm_so, rm[4].rm_eo - rm[4].rm_so,
+			    new_reg);
+
+	/* Prepare final OP which should be valid for uprobe_events */
+	new_len = strlen(prefix)              +
+		  (rm[2].rm_eo - rm[2].rm_so) +
+		  (rm[3].rm_eo - rm[3].rm_so) +
+		  strlen(new_reg)             +
+		  (rm[5].rm_eo - rm[5].rm_so) +
+		  1;					/* NULL */
+
+	*new_op = zalloc(new_len);
+	if (!*new_op)
+		return -ENOMEM;
+
+	scnprintf(*new_op, new_len, "%.*s%.*s%.*s%.*s%.*s",
+		  strlen(prefix), prefix,
+		  (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].rm_so,
+		  (int)(rm[3].rm_eo - rm[3].rm_so), old_op + rm[3].rm_so,
+		  strlen(new_reg), new_reg,
+		  (int)(rm[5].rm_eo - rm[5].rm_so), old_op + rm[5].rm_so);
+
+	return SDT_ARG_VALID;
+}
+
+uint64_t __perf_reg_mask_x86(bool intr)
+{
+	struct perf_event_attr attr = {
+		.type			= PERF_TYPE_HARDWARE,
+		.config			= PERF_COUNT_HW_CPU_CYCLES,
+		.sample_type		= PERF_SAMPLE_REGS_INTR,
+		.sample_regs_intr	= PERF_REG_EXTENDED_MASK,
+		.precise_ip		= 1,
+		.disabled 		= 1,
+		.exclude_kernel		= 1,
+	};
+	int fd;
+
+	if (!intr)
+		return PERF_REGS_MASK;
+
+	/*
+	 * In an unnamed union, init it here to build on older gcc versions
+	 */
+	attr.sample_period = 1;
+
+	if (perf_pmus__num_core_pmus() > 1) {
+		struct perf_pmu *pmu = NULL;
+		__u64 type = PERF_TYPE_RAW;
+
+		/*
+		 * The same register set is supported among different hybrid PMUs.
+		 * Only check the first available one.
+		 */
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			type = pmu->type;
+			break;
+		}
+		attr.config |= type << PERF_PMU_TYPE_SHIFT;
+	}
+
+	event_attr_init(&attr);
+
+	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+	if (fd != -1) {
+		close(fd);
+		return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
+	}
+
+	return PERF_REGS_MASK;
+}
 
 const char *__perf_reg_name_x86(int id)
 {
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 5f61e0f51d40..8fd910f0a4cf 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -10,20 +10,109 @@
 #define EM_LOONGARCH		258
 #endif
 
-int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
-				 char **new_op __maybe_unused)
+int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op)
 {
-	return SDT_ARG_SKIP;
+	int ret = SDT_ARG_SKIP;
+
+	switch (e_machine) {
+	case EM_AARCH64:
+		ret = __perf_sdt_arg_parse_op_arm64(old_op, new_op);
+		break;
+	case EM_PPC:
+	case EM_PPC64:
+		ret =__perf_sdt_arg_parse_op_powerpc(old_op, new_op);
+		break;
+	case EM_386:
+	case EM_X86_64:
+		ret = __perf_sdt_arg_parse_op_x86(old_op, new_op);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
 }
 
-uint64_t __weak arch__intr_reg_mask(void)
+uint64_t perf_intr_reg_mask(uint16_t e_machine)
 {
-	return 0;
+	uint64_t mask = 0;
+
+	switch (e_machine) {
+	case EM_ARM:
+		mask = __perf_reg_mask_arm(/*intr=*/true);
+		break;
+	case EM_AARCH64:
+		mask = __perf_reg_mask_arm64(/*intr=*/true);
+		break;
+	case EM_CSKY:
+		mask = __perf_reg_mask_csky(/*intr=*/true);
+		break;
+	case EM_LOONGARCH:
+		mask = __perf_reg_mask_loongarch(/*intr=*/true);
+		break;
+	case EM_MIPS:
+		mask = __perf_reg_mask_mips(/*intr=*/true);
+		break;
+	case EM_PPC:
+	case EM_PPC64:
+		mask = __perf_reg_mask_powerpc(/*intr=*/true);
+		break;
+	case EM_RISCV:
+		mask = __perf_reg_mask_riscv(/*intr=*/true);
+		break;
+	case EM_S390:
+		mask = __perf_reg_mask_s390(/*intr=*/true);
+		break;
+	case EM_386:
+	case EM_X86_64:
+		mask = __perf_reg_mask_x86(/*intr=*/true);
+		break;
+	default:
+		break;
+	}
+
+	return mask;
 }
 
-uint64_t __weak arch__user_reg_mask(void)
+uint64_t perf_user_reg_mask(uint16_t e_machine)
 {
-	return 0;
+	uint64_t mask = 0;
+
+	switch (e_machine) {
+	case EM_ARM:
+		mask = __perf_reg_mask_arm(/*intr=*/false);
+		break;
+	case EM_AARCH64:
+		mask = __perf_reg_mask_arm64(/*intr=*/false);
+		break;
+	case EM_CSKY:
+		mask = __perf_reg_mask_csky(/*intr=*/false);
+		break;
+	case EM_LOONGARCH:
+		mask = __perf_reg_mask_loongarch(/*intr=*/false);
+		break;
+	case EM_MIPS:
+		mask = __perf_reg_mask_mips(/*intr=*/false);
+		break;
+	case EM_PPC:
+	case EM_PPC64:
+		mask = __perf_reg_mask_powerpc(/*intr=*/false);
+		break;
+	case EM_RISCV:
+		mask = __perf_reg_mask_riscv(/*intr=*/false);
+		break;
+	case EM_S390:
+		mask = __perf_reg_mask_s390(/*intr=*/false);
+		break;
+	case EM_386:
+	case EM_X86_64:
+		mask = __perf_reg_mask_x86(/*intr=*/false);
+		break;
+	default:
+		break;
+	}
+
+	return mask;
 }
 
 const char *perf_reg_name(int id, uint16_t e_machine)
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 2c2a8de6912d..77c0b517b94a 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -12,38 +12,59 @@ enum {
 	SDT_ARG_SKIP,
 };
 
-int arch_sdt_arg_parse_op(char *old_op, char **new_op);
-uint64_t arch__intr_reg_mask(void);
-uint64_t arch__user_reg_mask(void);
+int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op);
+uint64_t perf_intr_reg_mask(uint16_t e_machine);
+uint64_t perf_user_reg_mask(uint16_t e_machine);
 
 const char *perf_reg_name(int id, uint16_t e_machine);
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 uint64_t perf_arch_reg_ip(uint16_t e_machine);
 uint64_t perf_arch_reg_sp(uint16_t e_machine);
+
+int __perf_sdt_arg_parse_op_arm64(char *old_op, char **new_op);
+uint64_t __perf_reg_mask_arm64(bool intr);
 const char *__perf_reg_name_arm64(int id);
 uint64_t __perf_reg_ip_arm64(void);
 uint64_t __perf_reg_sp_arm64(void);
+
+uint64_t __perf_reg_mask_arm(bool intr);
 const char *__perf_reg_name_arm(int id);
 uint64_t __perf_reg_ip_arm(void);
 uint64_t __perf_reg_sp_arm(void);
+
+uint64_t __perf_reg_mask_csky(bool intr);
 const char *__perf_reg_name_csky(int id);
 uint64_t __perf_reg_ip_csky(void);
 uint64_t __perf_reg_sp_csky(void);
+
+uint64_t __perf_reg_mask_loongarch(bool intr);
 const char *__perf_reg_name_loongarch(int id);
 uint64_t __perf_reg_ip_loongarch(void);
 uint64_t __perf_reg_sp_loongarch(void);
+
+uint64_t __perf_reg_mask_mips(bool intr);
 const char *__perf_reg_name_mips(int id);
 uint64_t __perf_reg_ip_mips(void);
 uint64_t __perf_reg_sp_mips(void);
+
+int __perf_sdt_arg_parse_op_powerpc(char *old_op, char **new_op);
+uint64_t __perf_reg_mask_powerpc(bool intr);
 const char *__perf_reg_name_powerpc(int id);
 uint64_t __perf_reg_ip_powerpc(void);
 uint64_t __perf_reg_sp_powerpc(void);
+
+uint64_t __perf_reg_mask_riscv(bool intr);
 const char *__perf_reg_name_riscv(int id);
 uint64_t __perf_reg_ip_riscv(void);
 uint64_t __perf_reg_sp_riscv(void);
+
+uint64_t __perf_reg_mask_s390(bool intr);
 const char *__perf_reg_name_s390(int id);
 uint64_t __perf_reg_ip_s390(void);
 uint64_t __perf_reg_sp_s390(void);
+
+int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op);
+uint64_t __perf_reg_mask_x86(bool intr);
 const char *__perf_reg_name_x86(int id);
 uint64_t __perf_reg_ip_x86(void);
 uint64_t __perf_reg_sp_x86(void);
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 5069fb61f48c..f78c3bc3d601 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -28,6 +28,7 @@
 #include "session.h"
 #include "perf_regs.h"
 #include "string2.h"
+#include "dwarf-regs.h"
 
 /* 4096 - 2 ('\n' + '\0') */
 #define MAX_CMDLEN 4094
@@ -784,7 +785,7 @@ static int synthesize_sdt_probe_arg(struct strbuf *buf, int i, const char *arg)
 		op = desc;
 	}
 
-	ret = arch_sdt_arg_parse_op(op, &new_op);
+	ret = perf_sdt_arg_parse_op(EM_HOST, op, &new_op);
 
 	if (ret < 0)
 		goto error;
-- 
2.34.1

