Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE74028BABB;
	Tue, 15 Apr 2025 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705449; cv=none; b=Ch+j2pS5BKr7JMyaRSYpL+g0l32He1BZiXGgrTUqqAsx99B4oHIl1kNPfojG4pWTxVExwQ+KipTq3xX7FLvjXIbAi2tsOMuPeOUjkdyzW2jUZyWxk2x30oFizcF8xeX3cojreaq7yEw/KnenjuvR1bUC8TqYl+HQ0Jm7Cc57pIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705449; c=relaxed/simple;
	bh=qYqUfma8FkYSXAkd2OIGwxjfQdBIy2QD/gjcseBGXfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fV6ZDkeFTM3Guh9Wvqy+IGeuJna25DXXe1H72qVnxiLcIH92ztVQlN1Gl/643nQ0nU66tYoEoBGnMbxE5TX78FLK2NMwj1XHKgBcjJeWC7/mU052q/eEvvZYi3reEcLbQv0JcFVQ2ppAuDD+QHoJPBZ/19O7t1Jx2EdLaMf7d8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LH7rSAHw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LH7rSAHw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705448; x=1776241448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qYqUfma8FkYSXAkd2OIGwxjfQdBIy2QD/gjcseBGXfs=;
  b=LH7rSAHwb64chVEdN8VccMw98CAVMVBdDeTVmbqaBFVCjKrVGDPRT6f2
   GRc+jH+sqyDvl1yfcnDTunj2IX3puyOCkp+rUJwFypPk6Q7M5HAkwtCs6
   EV1i70t9Smoawyj9lYP9b/xCK8lLOPkIBIQ8dCyq5aovIsdhr4XhWcMSO
   4kZHhESYxm742BVl5+sXbBZpJaiGnfgQbyMsy7CTmltpuv6x6YTEOFm8y
   uIHOzs7olDe2Lm4vKMeNdWtc1O6Itv9TanKuysRNohAev5xkHr4l/kO3h
   7OXVQPb/yRy54uRQ95YnJxEdVH/tYzPe+eeTkloCdwwVpfHkPRbqOl3Ip
   Q==;
X-CSE-ConnectionGUID: p+/75zFnRaKjVehzLZkEtw==
X-CSE-MsgGUID: 2ANaFblFShOWZeOVCuyaUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46116086"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46116086"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:24:08 -0700
X-CSE-ConnectionGUID: fZKp7LkPRtqkIZYkazDZlw==
X-CSE-MsgGUID: SjiNQv7oSvqjdapuLZJDuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055653"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:24:04 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 16/22] perf/core: Support to capture higher width vector registers
Date: Tue, 15 Apr 2025 11:44:22 +0000
Message-Id: <20250415114428.341182-17-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arch-PEBS supports to capture more vector registers like OPMASK/YMM/ZMM
registers besides XMM registers. This patch extends PERF_SAMPLE_REGS_INTR
and PERF_SAMPLE_REGS_USER attributes to support these new vector registers
capturing at interrupt and user space.

The arrays sample_regs_intr/user__ext[] is added into perf_event_attr
structure to record user configured extended register bitmap and a helper
perf_reg_ext_validate() is added to validate if these registers are
supported on some specific PMUs. Furthermore considering to leave enough
space to support more GPRs like R16 ~ R31 introduced by APX in the future,
directly extend the array size to 7.

This patch just adds the common perf/core support, the x86/intel specific
support would be added in next patch.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/arm/kernel/perf_regs.c           |  6 ++
 arch/arm64/kernel/perf_regs.c         |  6 ++
 arch/csky/kernel/perf_regs.c          |  5 ++
 arch/loongarch/kernel/perf_regs.c     |  5 ++
 arch/mips/kernel/perf_regs.c          |  5 ++
 arch/powerpc/perf/perf_regs.c         |  5 ++
 arch/riscv/kernel/perf_regs.c         |  5 ++
 arch/s390/kernel/perf_regs.c          |  5 ++
 arch/x86/include/asm/perf_event.h     |  4 ++
 arch/x86/include/uapi/asm/perf_regs.h | 79 ++++++++++++++++++++-
 arch/x86/kernel/perf_regs.c           | 64 ++++++++++++++++-
 include/linux/perf_event.h            |  4 ++
 include/linux/perf_regs.h             | 10 +++
 include/uapi/linux/perf_event.h       | 11 +++
 kernel/events/core.c                  | 98 +++++++++++++++++++++++++--
 15 files changed, 304 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/perf_regs.c b/arch/arm/kernel/perf_regs.c
index 0529f90395c9..86b2002d0846 100644
--- a/arch/arm/kernel/perf_regs.c
+++ b/arch/arm/kernel/perf_regs.c
@@ -37,3 +37,9 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
 }
+
+int perf_reg_ext_validate(unsigned long *mask, unsigned int size)
+{
+	return -EINVAL;
+}
+
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index b4eece3eb17d..1c91fd3530d5 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -104,3 +104,9 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
 }
+
+int perf_reg_ext_validate(unsigned long *mask, unsigned int size)
+{
+	return -EINVAL;
+}
+
diff --git a/arch/csky/kernel/perf_regs.c b/arch/csky/kernel/perf_regs.c
index 09b7f88a2d6a..d2e2af0bf1ad 100644
--- a/arch/csky/kernel/perf_regs.c
+++ b/arch/csky/kernel/perf_regs.c
@@ -26,6 +26,11 @@ int perf_reg_validate(u64 mask)
 	return 0;
 }
 
+int perf_reg_ext_validate(unsigned long *mask, unsigned int size)
+{
+	return -EINVAL;
+}
+
 u64 perf_reg_abi(struct task_struct *task)
 {
 	return PERF_SAMPLE_REGS_ABI_32;
diff --git a/arch/loongarch/kernel/perf_regs.c b/arch/loongarch/kernel/perf_regs.c
index 263ac4ab5af6..e1df67e3fab4 100644
--- a/arch/loongarch/kernel/perf_regs.c
+++ b/arch/loongarch/kernel/perf_regs.c
@@ -34,6 +34,11 @@ int perf_reg_validate(u64 mask)
 	return 0;
 }
 
+int perf_reg_ext_validate(unsigned long *mask, unsigned int size)
+{
+	return -EINVAL;
+}
+
 u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
 	if (WARN_ON_ONCE((u32)idx >= PERF_REG_LOONGARCH_MAX))
diff --git a/arch/mips/kernel/perf_regs.c b/arch/mips/kernel/perf_regs.c
index e686780d1647..bbb5f25b9191 100644
--- a/arch/mips/kernel/perf_regs.c
+++ b/arch/mips/kernel/perf_regs.c
@@ -37,6 +37,11 @@ int perf_reg_validate(u64 mask)
 	return 0;
 }
 
+int perf_reg_ext_validate(unsigned long *mask, unsigned int size)
+{
+	return -EINVAL;
+}
+
 u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
 	long v;
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
index 350dccb0143c..d919c628aee3 100644
--- a/arch/powerpc/perf/perf_regs.c
+++ b/arch/powerpc/perf/perf_regs.c
@@ -132,6 +132,11 @@ int perf_reg_validate(u64 mask)
 	return 0;
 }
 
+int perf_reg_ext_validate(unsigned long *mask, unsigned int size)
+{
+	return -EINVAL;
+}
+
 u64 perf_reg_abi(struct task_struct *task)
 {
 	if (is_tsk_32bit_task(task))
diff --git a/arch/riscv/kernel/perf_regs.c b/arch/riscv/kernel/perf_regs.c
index fd304a248de6..5beb60544c9a 100644
--- a/arch/riscv/kernel/perf_regs.c
+++ b/arch/riscv/kernel/perf_regs.c
@@ -26,6 +26,11 @@ int perf_reg_validate(u64 mask)
 	return 0;
 }
 
+int perf_reg_ext_validate(unsigned long *mask, unsigned int size)
+{
+	return -EINVAL;
+}
+
 u64 perf_reg_abi(struct task_struct *task)
 {
 #if __riscv_xlen == 64
diff --git a/arch/s390/kernel/perf_regs.c b/arch/s390/kernel/perf_regs.c
index a6b058ee4a36..9247573229b0 100644
--- a/arch/s390/kernel/perf_regs.c
+++ b/arch/s390/kernel/perf_regs.c
@@ -42,6 +42,11 @@ int perf_reg_validate(u64 mask)
 	return 0;
 }
 
+int perf_reg_ext_validate(unsigned long *mask, unsigned int size)
+{
+	return -EINVAL;
+}
+
 u64 perf_reg_abi(struct task_struct *task)
 {
 	if (test_tsk_thread_flag(task, TIF_31BIT))
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ba382361b13f..560eb218868c 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -706,6 +706,10 @@ struct x86_perf_regs {
 	struct pt_regs	regs;
 	u64		ssp;
 	u64		*xmm_regs;
+	u64		*opmask_regs;
+	u64		*ymmh_regs;
+	u64		*zmmh_regs;
+	u64		*h16zmm_regs;
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index f9c5b16b1882..5e2d9796b2cc 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -33,7 +33,7 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
 	PERF_REG_X86_64_MAX = PERF_REG_X86_SSP + 1,
 
-	/* These all need two bits set because they are 128bit */
+	/* These all need two bits set because they are 128 bits */
 	PERF_REG_X86_XMM0  = 32,
 	PERF_REG_X86_XMM1  = 34,
 	PERF_REG_X86_XMM2  = 36,
@@ -53,6 +53,83 @@ enum perf_event_x86_regs {
 
 	/* These include both GPRs and XMMX registers */
 	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
+
+	/* Leave bits[127:64] for other GP registers, like R16 ~ R31.*/
+
+	/*
+	 * Each YMM register need 4 bits to represent because they are 256 bits.
+	 * PERF_REG_X86_YMMH0 = 128
+	 */
+	PERF_REG_X86_YMM0	= 128,
+	PERF_REG_X86_YMM1	= PERF_REG_X86_YMM0 + 4,
+	PERF_REG_X86_YMM2	= PERF_REG_X86_YMM1 + 4,
+	PERF_REG_X86_YMM3	= PERF_REG_X86_YMM2 + 4,
+	PERF_REG_X86_YMM4	= PERF_REG_X86_YMM3 + 4,
+	PERF_REG_X86_YMM5	= PERF_REG_X86_YMM4 + 4,
+	PERF_REG_X86_YMM6	= PERF_REG_X86_YMM5 + 4,
+	PERF_REG_X86_YMM7	= PERF_REG_X86_YMM6 + 4,
+	PERF_REG_X86_YMM8	= PERF_REG_X86_YMM7 + 4,
+	PERF_REG_X86_YMM9	= PERF_REG_X86_YMM8 + 4,
+	PERF_REG_X86_YMM10	= PERF_REG_X86_YMM9 + 4,
+	PERF_REG_X86_YMM11	= PERF_REG_X86_YMM10 + 4,
+	PERF_REG_X86_YMM12	= PERF_REG_X86_YMM11 + 4,
+	PERF_REG_X86_YMM13	= PERF_REG_X86_YMM12 + 4,
+	PERF_REG_X86_YMM14	= PERF_REG_X86_YMM13 + 4,
+	PERF_REG_X86_YMM15	= PERF_REG_X86_YMM14 + 4,
+	PERF_REG_X86_YMM_MAX	= PERF_REG_X86_YMM15 + 4,
+
+	/*
+	 * Each ZMM register needs 8 bits to represent because they are 512 bits
+	 * PERF_REG_X86_ZMMH0 = 192
+	 */
+	PERF_REG_X86_ZMM0	= PERF_REG_X86_YMM_MAX,
+	PERF_REG_X86_ZMM1	= PERF_REG_X86_ZMM0 + 8,
+	PERF_REG_X86_ZMM2	= PERF_REG_X86_ZMM1 + 8,
+	PERF_REG_X86_ZMM3	= PERF_REG_X86_ZMM2 + 8,
+	PERF_REG_X86_ZMM4	= PERF_REG_X86_ZMM3 + 8,
+	PERF_REG_X86_ZMM5	= PERF_REG_X86_ZMM4 + 8,
+	PERF_REG_X86_ZMM6	= PERF_REG_X86_ZMM5 + 8,
+	PERF_REG_X86_ZMM7	= PERF_REG_X86_ZMM6 + 8,
+	PERF_REG_X86_ZMM8	= PERF_REG_X86_ZMM7 + 8,
+	PERF_REG_X86_ZMM9	= PERF_REG_X86_ZMM8 + 8,
+	PERF_REG_X86_ZMM10	= PERF_REG_X86_ZMM9 + 8,
+	PERF_REG_X86_ZMM11	= PERF_REG_X86_ZMM10 + 8,
+	PERF_REG_X86_ZMM12	= PERF_REG_X86_ZMM11 + 8,
+	PERF_REG_X86_ZMM13	= PERF_REG_X86_ZMM12 + 8,
+	PERF_REG_X86_ZMM14	= PERF_REG_X86_ZMM13 + 8,
+	PERF_REG_X86_ZMM15	= PERF_REG_X86_ZMM14 + 8,
+	PERF_REG_X86_ZMM16	= PERF_REG_X86_ZMM15 + 8,
+	PERF_REG_X86_ZMM17	= PERF_REG_X86_ZMM16 + 8,
+	PERF_REG_X86_ZMM18	= PERF_REG_X86_ZMM17 + 8,
+	PERF_REG_X86_ZMM19	= PERF_REG_X86_ZMM18 + 8,
+	PERF_REG_X86_ZMM20	= PERF_REG_X86_ZMM19 + 8,
+	PERF_REG_X86_ZMM21	= PERF_REG_X86_ZMM20 + 8,
+	PERF_REG_X86_ZMM22	= PERF_REG_X86_ZMM21 + 8,
+	PERF_REG_X86_ZMM23	= PERF_REG_X86_ZMM22 + 8,
+	PERF_REG_X86_ZMM24	= PERF_REG_X86_ZMM23 + 8,
+	PERF_REG_X86_ZMM25	= PERF_REG_X86_ZMM24 + 8,
+	PERF_REG_X86_ZMM26	= PERF_REG_X86_ZMM25 + 8,
+	PERF_REG_X86_ZMM27	= PERF_REG_X86_ZMM26 + 8,
+	PERF_REG_X86_ZMM28	= PERF_REG_X86_ZMM27 + 8,
+	PERF_REG_X86_ZMM29	= PERF_REG_X86_ZMM28 + 8,
+	PERF_REG_X86_ZMM30	= PERF_REG_X86_ZMM29 + 8,
+	PERF_REG_X86_ZMM31	= PERF_REG_X86_ZMM30 + 8,
+	PERF_REG_X86_ZMM_MAX	= PERF_REG_X86_ZMM31 + 8,
+
+	/*
+	 * OPMASK Registers
+	 * PERF_REG_X86_OPMASK0 = 448
+	 */
+	PERF_REG_X86_OPMASK0	= PERF_REG_X86_ZMM_MAX,
+	PERF_REG_X86_OPMASK1	= PERF_REG_X86_OPMASK0 + 1,
+	PERF_REG_X86_OPMASK2	= PERF_REG_X86_OPMASK1 + 1,
+	PERF_REG_X86_OPMASK3	= PERF_REG_X86_OPMASK2 + 1,
+	PERF_REG_X86_OPMASK4	= PERF_REG_X86_OPMASK3 + 1,
+	PERF_REG_X86_OPMASK5	= PERF_REG_X86_OPMASK4 + 1,
+	PERF_REG_X86_OPMASK6	= PERF_REG_X86_OPMASK5 + 1,
+	PERF_REG_X86_OPMASK7	= PERF_REG_X86_OPMASK6 + 1,
+
+	PERF_REG_X86_VEC_MAX	= PERF_REG_X86_OPMASK7 + 1,
 };
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 985bd616200e..466ccd67ea99 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -59,12 +59,55 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
 #endif
 };
 
+static u64 perf_reg_ext_value(struct pt_regs *regs, int idx)
+{
+	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
+	u64 data;
+	int mod;
+
+	switch (idx) {
+	case PERF_REG_X86_YMM0 ... PERF_REG_X86_YMM_MAX - 1:
+		idx -= PERF_REG_X86_YMM0;
+		mod = idx % 4;
+		if (mod < 2)
+			data = !perf_regs->xmm_regs ? 0 : perf_regs->xmm_regs[idx / 4 + mod];
+		else
+			data = !perf_regs->ymmh_regs ? 0 : perf_regs->ymmh_regs[idx / 4 + mod - 2];
+		return data;
+	case PERF_REG_X86_ZMM0 ... PERF_REG_X86_ZMM16 - 1:
+		idx -= PERF_REG_X86_ZMM0;
+		mod = idx % 8;
+		if (mod < 4) {
+			if (mod < 2)
+				data = !perf_regs->xmm_regs ? 0 : perf_regs->xmm_regs[idx / 8 + mod];
+			else
+				data = !perf_regs->ymmh_regs ? 0 : perf_regs->ymmh_regs[idx / 8 + mod - 2];
+		} else {
+			data = !perf_regs->zmmh_regs ? 0 : perf_regs->zmmh_regs[idx / 8 + mod - 4];
+		}
+		return data;
+	case PERF_REG_X86_ZMM16 ... PERF_REG_X86_ZMM_MAX - 1:
+		idx -= PERF_REG_X86_ZMM16;
+		return !perf_regs->h16zmm_regs ? 0 : perf_regs->h16zmm_regs[idx];
+	case PERF_REG_X86_OPMASK0 ... PERF_REG_X86_OPMASK7:
+		idx -= PERF_REG_X86_OPMASK0;
+		return !perf_regs->opmask_regs ? 0 : perf_regs->opmask_regs[idx];
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+
+	return 0;
+}
+
 u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
-	struct x86_perf_regs *perf_regs;
+	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
+
+	if (idx >= PERF_REG_EXTENDED_OFFSET)
+		return perf_reg_ext_value(regs, idx);
 
 	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
-		perf_regs = container_of(regs, struct x86_perf_regs, regs);
 		if (!perf_regs->xmm_regs)
 			return 0;
 		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
@@ -102,6 +145,11 @@ int perf_reg_validate(u64 mask)
 	return 0;
 }
 
+int perf_reg_ext_validate(unsigned long *mask, unsigned int size)
+{
+	return -EINVAL;
+}
+
 u64 perf_reg_abi(struct task_struct *task)
 {
 	return PERF_SAMPLE_REGS_ABI_32;
@@ -127,6 +175,18 @@ int perf_reg_validate(u64 mask)
 	return 0;
 }
 
+int perf_reg_ext_validate(unsigned long *mask, unsigned int size)
+{
+	if (!mask || !size || size > PERF_NUM_EXT_REGS)
+		return -EINVAL;
+
+	if (find_last_bit(mask, size) >
+	    (PERF_REG_X86_VEC_MAX - PERF_REG_EXTENDED_OFFSET))
+		return -EINVAL;
+
+	return 0;
+}
+
 u64 perf_reg_abi(struct task_struct *task)
 {
 	if (!user_64bit_mode(task_pt_regs(task)))
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 947ad12dfdbe..5a33c5a0e4e4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -303,6 +303,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
 #define PERF_PMU_CAP_AUX_PAUSE			0x0200
+#define PERF_PMU_CAP_MORE_EXT_REGS		0x0400
 
 /**
  * pmu::scope
@@ -1424,6 +1425,9 @@ static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *b
 	br->reserved = 0;
 }
 
+extern bool has_more_extended_intr_regs(struct perf_event *event);
+extern bool has_more_extended_user_regs(struct perf_event *event);
+extern bool has_more_extended_regs(struct perf_event *event);
 extern void perf_output_sample(struct perf_output_handle *handle,
 			       struct perf_event_header *header,
 			       struct perf_sample_data *data,
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index f632c5725f16..aa4dfb5af552 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -9,6 +9,8 @@ struct perf_regs {
 	struct pt_regs	*regs;
 };
 
+#define PERF_REG_EXTENDED_OFFSET	64
+
 #ifdef CONFIG_HAVE_PERF_REGS
 #include <asm/perf_regs.h>
 
@@ -21,6 +23,8 @@ int perf_reg_validate(u64 mask);
 u64 perf_reg_abi(struct task_struct *task);
 void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs);
+int perf_reg_ext_validate(unsigned long *mask, unsigned int size);
+
 #else
 
 #define PERF_REG_EXTENDED_MASK	0
@@ -35,6 +39,12 @@ static inline int perf_reg_validate(u64 mask)
 	return mask ? -ENOSYS : 0;
 }
 
+static inline int perf_reg_ext_validate(unsigned long *mask,
+					unsigned int size)
+{
+	return -EINVAL;
+}
+
 static inline u64 perf_reg_abi(struct task_struct *task)
 {
 	return PERF_SAMPLE_REGS_ABI_NONE;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 5fc753c23734..78aae0464a54 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -379,6 +379,10 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
+#define PERF_ATTR_SIZE_VER9	168	/* add: sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE] */
+
+#define PERF_EXT_REGS_ARRAY_SIZE	7
+#define PERF_NUM_EXT_REGS		(PERF_EXT_REGS_ARRAY_SIZE * 64)
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -533,6 +537,13 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+	/*
+	 * Extension sets of regs to dump for each sample.
+	 * See asm/perf_regs.h for details.
+	 */
+	__u64	sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE];
+	__u64   sample_regs_user_ext[PERF_EXT_REGS_ARRAY_SIZE];
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2eb9cd5d86a1..ebf3be1a6e47 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7345,6 +7345,21 @@ perf_output_sample_regs(struct perf_output_handle *handle,
 	}
 }
 
+static void
+perf_output_sample_regs_ext(struct perf_output_handle *handle,
+			    struct pt_regs *regs,
+			    unsigned long *mask,
+			    unsigned int size)
+{
+	int bit;
+	u64 val;
+
+	for_each_set_bit(bit, mask, size) {
+		val = perf_reg_value(regs, bit + PERF_REG_EXTENDED_OFFSET);
+		perf_output_put(handle, val);
+	}
+}
+
 static void perf_sample_regs_user(struct perf_regs *regs_user,
 				  struct pt_regs *regs)
 {
@@ -7773,6 +7788,26 @@ static void perf_output_read(struct perf_output_handle *handle,
 		perf_output_read_one(handle, event, enabled, running);
 }
 
+inline bool has_more_extended_intr_regs(struct perf_event *event)
+{
+	return !!bitmap_weight(
+			(unsigned long *)event->attr.sample_regs_intr_ext,
+			PERF_NUM_EXT_REGS);
+}
+
+inline bool has_more_extended_user_regs(struct perf_event *event)
+{
+	return !!bitmap_weight(
+			(unsigned long *)event->attr.sample_regs_user_ext,
+			PERF_NUM_EXT_REGS);
+}
+
+inline bool has_more_extended_regs(struct perf_event *event)
+{
+	return has_more_extended_intr_regs(event) ||
+	       has_more_extended_user_regs(event);
+}
+
 void perf_output_sample(struct perf_output_handle *handle,
 			struct perf_event_header *header,
 			struct perf_sample_data *data,
@@ -7898,6 +7933,12 @@ void perf_output_sample(struct perf_output_handle *handle,
 			perf_output_sample_regs(handle,
 						data->regs_user.regs,
 						mask);
+			if (has_more_extended_user_regs(event)) {
+				perf_output_sample_regs_ext(
+					handle, data->regs_user.regs,
+					(unsigned long *)event->attr.sample_regs_user_ext,
+					PERF_NUM_EXT_REGS);
+			}
 		}
 	}
 
@@ -7930,6 +7971,12 @@ void perf_output_sample(struct perf_output_handle *handle,
 			perf_output_sample_regs(handle,
 						data->regs_intr.regs,
 						mask);
+			if (has_more_extended_intr_regs(event)) {
+				perf_output_sample_regs_ext(
+					handle, data->regs_intr.regs,
+					(unsigned long *)event->attr.sample_regs_intr_ext,
+					PERF_NUM_EXT_REGS);
+			}
 		}
 	}
 
@@ -8181,6 +8228,12 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		if (data->regs_user.regs) {
 			u64 mask = event->attr.sample_regs_user;
 			size += hweight64(mask) * sizeof(u64);
+
+			if (has_more_extended_user_regs(event)) {
+				size += bitmap_weight(
+					(unsigned long *)event->attr.sample_regs_user_ext,
+					 PERF_NUM_EXT_REGS) * sizeof(u64);
+			}
 		}
 
 		data->dyn_size += size;
@@ -8244,6 +8297,12 @@ void perf_prepare_sample(struct perf_sample_data *data,
 			u64 mask = event->attr.sample_regs_intr;
 
 			size += hweight64(mask) * sizeof(u64);
+
+			if (has_more_extended_intr_regs(event)) {
+				size += bitmap_weight(
+					(unsigned long *)event->attr.sample_regs_intr_ext,
+					 PERF_NUM_EXT_REGS) * sizeof(u64);
+			}
 		}
 
 		data->dyn_size += size;
@@ -12496,6 +12555,12 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		goto err_destroy;
 	}
 
+	if (!(pmu->capabilities & PERF_PMU_CAP_MORE_EXT_REGS) &&
+	    has_more_extended_regs(event)) {
+		ret = -EOPNOTSUPP;
+		goto err_destroy;
+	}
+
 	if (pmu->capabilities & PERF_PMU_CAP_NO_EXCLUDE &&
 	    event_has_any_exclude_flag(event)) {
 		ret = -EINVAL;
@@ -13028,9 +13093,19 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
-		ret = perf_reg_validate(attr->sample_regs_user);
-		if (ret)
-			return ret;
+		if (attr->sample_regs_user != 0) {
+			ret = perf_reg_validate(attr->sample_regs_user);
+			if (ret)
+				return ret;
+		}
+		if (!!bitmap_weight((unsigned long *)attr->sample_regs_user_ext,
+				    PERF_NUM_EXT_REGS)) {
+			ret = perf_reg_ext_validate(
+				(unsigned long *)attr->sample_regs_user_ext,
+				PERF_NUM_EXT_REGS);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_STACK_USER) {
@@ -13051,8 +13126,21 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (!attr->sample_max_stack)
 		attr->sample_max_stack = sysctl_perf_event_max_stack;
 
-	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
-		ret = perf_reg_validate(attr->sample_regs_intr);
+	if (attr->sample_type & PERF_SAMPLE_REGS_INTR) {
+		if (attr->sample_regs_intr != 0) {
+			ret = perf_reg_validate(attr->sample_regs_intr);
+			if (ret)
+				return ret;
+		}
+		if (!!bitmap_weight((unsigned long *)attr->sample_regs_intr_ext,
+				    PERF_NUM_EXT_REGS)) {
+			ret = perf_reg_ext_validate(
+				(unsigned long *)attr->sample_regs_intr_ext,
+				PERF_NUM_EXT_REGS);
+			if (ret)
+				return ret;
+		}
+	}
 
 #ifndef CONFIG_CGROUP_PERF
 	if (attr->sample_type & PERF_SAMPLE_CGROUP)
-- 
2.40.1

