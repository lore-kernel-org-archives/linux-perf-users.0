Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8DB1D79B8;
	Thu, 23 Jan 2025 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613265; cv=none; b=Pi1O7LT5HIqsfznVWpEgZl0bPQ/OHW2ejrA976e8AC+Do6D8veoPumzQSfoly5CFQEMk99A7YH+Wawa9FoZdpCn+itM/WlyEhZkQOFdqJOUmfGmhpT8PbfWrOyiiqJt9TXdZse3nwb/qACLcLweQbTMC3eChGDXlP73KP4QYYcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613265; c=relaxed/simple;
	bh=w7EIU9s7myqloD03Ci09IIyRJUcSx3e2Cw1hcdZRa3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GmlvmwTc+wDB5k50f5/NKPvjEb68z9rDTksF4ac75LZCi61B4sG4tAM+kGvu65Q6w6YtvwjYn2ahNRYulyP7AotRLeYsn6L47KwQBw5JFUKf+xAuZ5lecDdFPyadtSTOohRU1zbbektlkGOPrrwjCzUCi+tATYpdTBYYUQpw7vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKXEHxvo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKXEHxvo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613264; x=1769149264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w7EIU9s7myqloD03Ci09IIyRJUcSx3e2Cw1hcdZRa3s=;
  b=MKXEHxvo60wfgDYnJF2UN7M3SZVLtMKEsrTv94oLwUaoUxKAsn8BDTt/
   TzgCOxGr9p7majp9IZp54Y/+fjrIr0U5t9vZlfPCnSnJIcHh1B/xNdaEA
   4Hl3Qokta+dioiwJxQcg9CO1XSPFGzKlAIsJlQ/V/V1PR/A89nBsrbfvv
   4hi4MTb/yYQxYUv8qhvkTYm9iuT2BArdTFElEy67njdDJusPttycXMIzc
   8d4O02+0U9+r938ks7ZecfhFlTe+GcQJphcIaKRpQ7aHTpM5yX2xrM/Hc
   GQzij4q4sISriTbIRtrjiDwy+IvsLpCFChAUHRCDO18kdujQOapfUE+ZW
   Q==;
X-CSE-ConnectionGUID: 0ncoMfWOSFS+5SsDAcFfaQ==
X-CSE-MsgGUID: XIFGLKRgQWGJmmD3zbnuWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513189"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513189"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:21:04 -0800
X-CSE-ConnectionGUID: 6K8E2ZmBSHSITE+wJeMJqg==
X-CSE-MsgGUID: TYnnR/0JTx6WpOB0oU0vnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334720"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:20:59 -0800
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
Subject: [PATCH 15/20] perf/core: Support to capture higher width vector registers
Date: Thu, 23 Jan 2025 14:07:16 +0000
Message-Id: <20250123140721.2496639-16-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arch-PEBS supports to capture more vector registers like OPMASK/YMM/ZMM
registers besides XMM registers. This patch extends PERF_SAMPLE_REGS_INTR
attribute to support these higher width vector registers capturing.

The array sample_regs_intr_ext[] is added into perf_event_attr structure
to record user configured extended register bitmap and a helper
perf_reg_ext_validate() is added to validate if these registers are
supported on some specific PMUs.

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
 arch/x86/include/uapi/asm/perf_regs.h | 83 ++++++++++++++++++++++++++-
 arch/x86/kernel/perf_regs.c           | 50 +++++++++++++++-
 include/linux/perf_event.h            |  2 +
 include/linux/perf_regs.h             | 10 ++++
 include/uapi/linux/perf_event.h       | 10 ++++
 kernel/events/core.c                  | 53 ++++++++++++++++-
 15 files changed, 249 insertions(+), 5 deletions(-)

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
index a38d791cd0c2..54125b344b2b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -680,6 +680,10 @@ struct x86_perf_regs {
 	struct pt_regs	regs;
 	u64		ssp;
 	u64		*xmm_regs;
+	u64		*opmask_regs;
+	u64		*ymmh_regs;
+	u64		**zmmh_regs;
+	u64		**h16zmm_regs;
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 2e88fdebd259..6651e5af448d 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -32,7 +32,7 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
 	PERF_REG_X86_64_MAX = PERF_REG_X86_SSP + 1,
 
-	/* These all need two bits set because they are 128bit */
+	/* These all need two bits set because they are 128 bits */
 	PERF_REG_X86_XMM0  = 32,
 	PERF_REG_X86_XMM1  = 34,
 	PERF_REG_X86_XMM2  = 36,
@@ -52,6 +52,87 @@ enum perf_event_x86_regs {
 
 	/* These include both GPRs and XMMX registers */
 	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
+
+	/*
+	 * YMM upper bits need two bits set because they are 128 bits.
+	 * PERF_REG_X86_YMMH0 = 64
+	 */
+	PERF_REG_X86_YMMH0	= PERF_REG_X86_XMM_MAX,
+	PERF_REG_X86_YMMH1	= PERF_REG_X86_YMMH0 + 2,
+	PERF_REG_X86_YMMH2	= PERF_REG_X86_YMMH1 + 2,
+	PERF_REG_X86_YMMH3	= PERF_REG_X86_YMMH2 + 2,
+	PERF_REG_X86_YMMH4	= PERF_REG_X86_YMMH3 + 2,
+	PERF_REG_X86_YMMH5	= PERF_REG_X86_YMMH4 + 2,
+	PERF_REG_X86_YMMH6	= PERF_REG_X86_YMMH5 + 2,
+	PERF_REG_X86_YMMH7	= PERF_REG_X86_YMMH6 + 2,
+	PERF_REG_X86_YMMH8	= PERF_REG_X86_YMMH7 + 2,
+	PERF_REG_X86_YMMH9	= PERF_REG_X86_YMMH8 + 2,
+	PERF_REG_X86_YMMH10	= PERF_REG_X86_YMMH9 + 2,
+	PERF_REG_X86_YMMH11	= PERF_REG_X86_YMMH10 + 2,
+	PERF_REG_X86_YMMH12	= PERF_REG_X86_YMMH11 + 2,
+	PERF_REG_X86_YMMH13	= PERF_REG_X86_YMMH12 + 2,
+	PERF_REG_X86_YMMH14	= PERF_REG_X86_YMMH13 + 2,
+	PERF_REG_X86_YMMH15	= PERF_REG_X86_YMMH14 + 2,
+	PERF_REG_X86_YMMH_MAX	= PERF_REG_X86_YMMH15 + 2,
+
+	/*
+	 * ZMM0-15 upper bits need four bits set because they are 256 bits
+	 * PERF_REG_X86_ZMMH0 = 96
+	 */
+	PERF_REG_X86_ZMMH0	= PERF_REG_X86_YMMH_MAX,
+	PERF_REG_X86_ZMMH1	= PERF_REG_X86_ZMMH0 + 4,
+	PERF_REG_X86_ZMMH2	= PERF_REG_X86_ZMMH1 + 4,
+	PERF_REG_X86_ZMMH3	= PERF_REG_X86_ZMMH2 + 4,
+	PERF_REG_X86_ZMMH4	= PERF_REG_X86_ZMMH3 + 4,
+	PERF_REG_X86_ZMMH5	= PERF_REG_X86_ZMMH4 + 4,
+	PERF_REG_X86_ZMMH6	= PERF_REG_X86_ZMMH5 + 4,
+	PERF_REG_X86_ZMMH7	= PERF_REG_X86_ZMMH6 + 4,
+	PERF_REG_X86_ZMMH8	= PERF_REG_X86_ZMMH7 + 4,
+	PERF_REG_X86_ZMMH9	= PERF_REG_X86_ZMMH8 + 4,
+	PERF_REG_X86_ZMMH10	= PERF_REG_X86_ZMMH9 + 4,
+	PERF_REG_X86_ZMMH11	= PERF_REG_X86_ZMMH10 + 4,
+	PERF_REG_X86_ZMMH12	= PERF_REG_X86_ZMMH11 + 4,
+	PERF_REG_X86_ZMMH13	= PERF_REG_X86_ZMMH12 + 4,
+	PERF_REG_X86_ZMMH14	= PERF_REG_X86_ZMMH13 + 4,
+	PERF_REG_X86_ZMMH15	= PERF_REG_X86_ZMMH14 + 4,
+	PERF_REG_X86_ZMMH_MAX	= PERF_REG_X86_ZMMH15 + 4,
+
+	/*
+	 * ZMM16-31 need eight bits set because they are 512 bits
+	 * PERF_REG_X86_ZMM16 = 160
+	 */
+	PERF_REG_X86_ZMM16	= PERF_REG_X86_ZMMH_MAX,
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
+	 * PERF_REG_X86_OPMASK0 = 288
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
index 4b15c7488ec1..1447cd341868 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -59,12 +59,41 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
 #endif
 };
 
-u64 perf_reg_value(struct pt_regs *regs, int idx)
+static u64 perf_reg_ext_value(struct pt_regs *regs, int idx)
 {
 	struct x86_perf_regs *perf_regs;
 
+	perf_regs = container_of(regs, struct x86_perf_regs, regs);
+
+	switch (idx) {
+	case PERF_REG_X86_YMMH0 ... PERF_REG_X86_YMMH_MAX - 1:
+		idx -= PERF_REG_X86_YMMH0;
+		return !perf_regs->ymmh_regs ? 0 : perf_regs->ymmh_regs[idx];
+	case PERF_REG_X86_ZMMH0 ... PERF_REG_X86_ZMMH_MAX - 1:
+		idx -= PERF_REG_X86_ZMMH0;
+		return !perf_regs->zmmh_regs ? 0 : perf_regs->zmmh_regs[idx / 4][idx % 4];
+	case PERF_REG_X86_ZMM16 ... PERF_REG_X86_ZMM_MAX - 1:
+		idx -= PERF_REG_X86_ZMM16;
+		return !perf_regs->h16zmm_regs ? 0 : perf_regs->h16zmm_regs[idx / 8][idx % 8];
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
+u64 perf_reg_value(struct pt_regs *regs, int idx)
+{
+	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
+
+	if (idx >= PERF_REG_EXTENDED_OFFSET)
+		return perf_reg_ext_value(regs, idx);
+
 	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
-		perf_regs = container_of(regs, struct x86_perf_regs, regs);
 		if (!perf_regs->xmm_regs)
 			return 0;
 		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
@@ -100,6 +129,11 @@ int perf_reg_validate(u64 mask)
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
@@ -125,6 +159,18 @@ int perf_reg_validate(u64 mask)
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
index 2d07bc1193f3..3612ef66f86c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -301,6 +301,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
 #define PERF_PMU_CAP_AUX_PAUSE			0x0200
+#define PERF_PMU_CAP_MORE_EXT_REGS		0x0400
 
 /**
  * pmu::scope
@@ -1389,6 +1390,7 @@ static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *b
 	br->reserved = 0;
 }
 
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
index 0524d541d4e3..575cd653291c 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -379,6 +379,10 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
+#define PERF_ATTR_SIZE_VER9	168	/* add: sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE] */
+
+#define PERF_EXT_REGS_ARRAY_SIZE	4
+#define PERF_NUM_EXT_REGS		(PERF_EXT_REGS_ARRAY_SIZE * 64)
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -531,6 +535,12 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+	/*
+	 * Extension sets of regs to dump for each sample.
+	 * See asm/perf_regs.h for details.
+	 */
+	__u64	sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE];
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0f8c55990783..0da480b5e025 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7081,6 +7081,21 @@ perf_output_sample_regs(struct perf_output_handle *handle,
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
@@ -7509,6 +7524,13 @@ static void perf_output_read(struct perf_output_handle *handle,
 		perf_output_read_one(handle, event, enabled, running);
 }
 
+inline bool has_more_extended_regs(struct perf_event *event)
+{
+	return !!bitmap_weight(
+			(unsigned long *)event->attr.sample_regs_intr_ext,
+			PERF_NUM_EXT_REGS);
+}
+
 void perf_output_sample(struct perf_output_handle *handle,
 			struct perf_event_header *header,
 			struct perf_sample_data *data,
@@ -7666,6 +7688,12 @@ void perf_output_sample(struct perf_output_handle *handle,
 			perf_output_sample_regs(handle,
 						data->regs_intr.regs,
 						mask);
+			if (has_more_extended_regs(event)) {
+				perf_output_sample_regs_ext(
+					handle, data->regs_intr.regs,
+					(unsigned long *)event->attr.sample_regs_intr_ext,
+					PERF_NUM_EXT_REGS);
+			}
 		}
 	}
 
@@ -7980,6 +8008,12 @@ void perf_prepare_sample(struct perf_sample_data *data,
 			u64 mask = event->attr.sample_regs_intr;
 
 			size += hweight64(mask) * sizeof(u64);
+
+			if (has_more_extended_regs(event)) {
+				size += bitmap_weight(
+					(unsigned long *)event->attr.sample_regs_intr_ext,
+					 PERF_NUM_EXT_REGS) * sizeof(u64);
+			}
 		}
 
 		data->dyn_size += size;
@@ -11991,6 +12025,10 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		    has_extended_regs(event))
 			ret = -EOPNOTSUPP;
 
+		if (!(pmu->capabilities & PERF_PMU_CAP_MORE_EXT_REGS) &&
+		    has_more_extended_regs(event))
+			ret = -EOPNOTSUPP;
+
 		if (pmu->capabilities & PERF_PMU_CAP_NO_EXCLUDE &&
 		    event_has_any_exclude_flag(event))
 			ret = -EINVAL;
@@ -12561,8 +12599,19 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (!attr->sample_max_stack)
 		attr->sample_max_stack = sysctl_perf_event_max_stack;
 
-	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
-		ret = perf_reg_validate(attr->sample_regs_intr);
+	if (attr->sample_type & PERF_SAMPLE_REGS_INTR) {
+		if (attr->sample_regs_intr != 0)
+			ret = perf_reg_validate(attr->sample_regs_intr);
+		if (ret)
+			return ret;
+		if (!!bitmap_weight((unsigned long *)attr->sample_regs_intr_ext,
+				    PERF_NUM_EXT_REGS))
+			ret = perf_reg_ext_validate(
+				(unsigned long *)attr->sample_regs_intr_ext,
+				PERF_NUM_EXT_REGS);
+		if (ret)
+			return ret;
+	}
 
 #ifndef CONFIG_CGROUP_PERF
 	if (attr->sample_type & PERF_SAMPLE_CGROUP)
-- 
2.40.1

