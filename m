Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2A63B38AA;
	Fri, 29 May 2026 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041845; cv=none; b=tGjNV9RGOdUOe9bnRPYdxeUt5QTXigo8yqBRg2xztajk0CFVlgUubwHfr7qwthBwEP4ApcKbAHbZiTCNdHdVz+s2UORfbNN15aX+BrYJSSBIUOFlQXoeg/3fn6pffB6lTYaqDbDylJNZeth2Rq1KlJgkaxYYUWQE+vR97s2037I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041845; c=relaxed/simple;
	bh=zji4kzmOkTMEUSi2LnhVML9fZRR/rYsSGCekPnWAnGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jV58RXL8/DY8p8VcFfIkY58I9ArDw3OyLKu7nbwlOt57iE+QF27F3Q+rIhz8bhGp2rZX5TiUSXjnXUF4mVMIS+G9+KdqQIuwRgim1wGenUdl8Ueol+eHE3NOgmrQJXDNLLSd4fOgXw6oqc599W89y24Td+7PY9oM2gt3E+N0E08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUGghkDo; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUGghkDo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041844; x=1811577844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zji4kzmOkTMEUSi2LnhVML9fZRR/rYsSGCekPnWAnGk=;
  b=jUGghkDoJg04wclTVCZ0mBVZagX5lR7Cj3z0SwuqO36e4+SBof5X2DIP
   rpj+RTJOAa08sGAyy5jjqvjTzHnx16bKnyqEjdd6FaUVZohmWMBmHFiZW
   8HZKENH4q2Sr0q3wj4IhQOivQ66BuS+l9ud5xDN9FqzoAZ3/nJmdb0yRA
   9d46iGKa2TLCjtWd3e1EZPr0RWK+2bf+gzHOUuxLDbc42iZzqXCMPger3
   ozODOuLfygDe2dfTFKACYUixZ7Qk+HCKtGfSnOkhqGU+0GsTDphF7ANJA
   TOaH/fSCxGswj/spCxBswNfQk/8SPmni1mgTJ65eEduSfvHhatNH3E8N8
   w==;
X-CSE-ConnectionGUID: 1FRgVifpT160ZP3wSt1rVw==
X-CSE-MsgGUID: 9g7nIiEqR3a0FZTvxe2SxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106342094"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106342094"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:04:04 -0700
X-CSE-ConnectionGUID: GtWtFA1RTvKuaM3rIRY0Ug==
X-CSE-MsgGUID: G11wQUw+RHGknPHLD9BJ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802440"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:03:59 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v8 17/23] perf: Enhance perf_reg_validate() with simd_enabled argument
Date: Fri, 29 May 2026 15:56:39 +0800
Message-Id: <20260529075645.580362-18-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The upcoming patch will support x86 APX eGPRs sampling by using the
reclaimed XMM register space to represent eGPRs in sample_regs_* fields.

To differentiate between XMM and eGPRs in sample_regs_* fields, an
additional argument, simd_enabled, is introduced to the
perf_reg_validate() helper. If simd_enabled is set to 1, it indicates
that eGPRs are represented in sample_regs_* fields for the x86 platform;
otherwise, XMM registers are represented.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/arm/kernel/perf_regs.c       | 2 +-
 arch/arm64/kernel/perf_regs.c     | 2 +-
 arch/csky/kernel/perf_regs.c      | 2 +-
 arch/loongarch/kernel/perf_regs.c | 2 +-
 arch/mips/kernel/perf_regs.c      | 2 +-
 arch/parisc/kernel/perf_regs.c    | 2 +-
 arch/powerpc/perf/perf_regs.c     | 2 +-
 arch/riscv/kernel/perf_regs.c     | 2 +-
 arch/s390/kernel/perf_regs.c      | 2 +-
 arch/x86/kernel/perf_regs.c       | 4 ++--
 include/linux/perf_regs.h         | 2 +-
 kernel/events/core.c              | 8 +++++---
 12 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/perf_regs.c b/arch/arm/kernel/perf_regs.c
index d575a4c3ca56..838d701adf4d 100644
--- a/arch/arm/kernel/perf_regs.c
+++ b/arch/arm/kernel/perf_regs.c
@@ -18,7 +18,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 #define REG_RESERVED (~((1ULL << PERF_REG_ARM_MAX) - 1))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || mask & REG_RESERVED)
 		return -EINVAL;
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 70e2f13f587f..71a3e0238de4 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -77,7 +77,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 #define REG_RESERVED (~((1ULL << PERF_REG_ARM64_MAX) - 1))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	u64 reserved_mask = REG_RESERVED;
 
diff --git a/arch/csky/kernel/perf_regs.c b/arch/csky/kernel/perf_regs.c
index 94601f37b596..c932a96afc56 100644
--- a/arch/csky/kernel/perf_regs.c
+++ b/arch/csky/kernel/perf_regs.c
@@ -18,7 +18,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 #define REG_RESERVED (~((1ULL << PERF_REG_CSKY_MAX) - 1))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || mask & REG_RESERVED)
 		return -EINVAL;
diff --git a/arch/loongarch/kernel/perf_regs.c b/arch/loongarch/kernel/perf_regs.c
index 8dd604f01745..164514f40ae0 100644
--- a/arch/loongarch/kernel/perf_regs.c
+++ b/arch/loongarch/kernel/perf_regs.c
@@ -25,7 +25,7 @@ u64 perf_reg_abi(struct task_struct *tsk)
 }
 #endif /* CONFIG_32BIT */
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask)
 		return -EINVAL;
diff --git a/arch/mips/kernel/perf_regs.c b/arch/mips/kernel/perf_regs.c
index 7736d3c5ebd2..00a5201dbd5d 100644
--- a/arch/mips/kernel/perf_regs.c
+++ b/arch/mips/kernel/perf_regs.c
@@ -28,7 +28,7 @@ u64 perf_reg_abi(struct task_struct *tsk)
 }
 #endif /* CONFIG_32BIT */
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask)
 		return -EINVAL;
diff --git a/arch/parisc/kernel/perf_regs.c b/arch/parisc/kernel/perf_regs.c
index b9fe1f2fcb9b..4f21aab5405c 100644
--- a/arch/parisc/kernel/perf_regs.c
+++ b/arch/parisc/kernel/perf_regs.c
@@ -34,7 +34,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 #define REG_RESERVED (~((1ULL << PERF_REG_PARISC_MAX) - 1))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || mask & REG_RESERVED)
 		return -EINVAL;
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
index 350dccb0143c..a01d8a903640 100644
--- a/arch/powerpc/perf/perf_regs.c
+++ b/arch/powerpc/perf/perf_regs.c
@@ -125,7 +125,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || mask & REG_RESERVED)
 		return -EINVAL;
diff --git a/arch/riscv/kernel/perf_regs.c b/arch/riscv/kernel/perf_regs.c
index 3bba8deababb..1ecc8760b88b 100644
--- a/arch/riscv/kernel/perf_regs.c
+++ b/arch/riscv/kernel/perf_regs.c
@@ -18,7 +18,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 #define REG_RESERVED (~((1ULL << PERF_REG_RISCV_MAX) - 1))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || mask & REG_RESERVED)
 		return -EINVAL;
diff --git a/arch/s390/kernel/perf_regs.c b/arch/s390/kernel/perf_regs.c
index 7b305f1456f8..6496fd23c540 100644
--- a/arch/s390/kernel/perf_regs.c
+++ b/arch/s390/kernel/perf_regs.c
@@ -34,7 +34,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 #define REG_RESERVED (~((1UL << PERF_REG_S390_MAX) - 1))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || mask & REG_RESERVED)
 		return -EINVAL;
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 21b282be8ab9..79803b3b6d6b 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -192,7 +192,7 @@ int perf_simd_reg_validate(u16 simd_enabled, u16 vec_qwords,
 		       (1ULL << PERF_REG_X86_R14) | \
 		       (1ULL << PERF_REG_X86_R15))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	/* The mask could be 0 if only the SIMD registers are interested */
 	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
@@ -212,7 +212,7 @@ u64 perf_reg_abi(struct task_struct *task)
 		       (1ULL << PERF_REG_X86_FS) | \
 		       (1ULL << PERF_REG_X86_GS))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	/* The mask could be 0 if only the SIMD registers are interested */
 	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index 8fa3eeb14953..496080e12141 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -10,7 +10,7 @@ struct perf_regs {
 };
 
 u64 perf_reg_value(struct pt_regs *regs, int idx);
-int perf_reg_validate(u64 mask);
+int perf_reg_validate(u64 mask, bool simd_enabled);
 u64 perf_reg_abi(struct task_struct *task);
 void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index afd5b1408231..bf88d9a61f0b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7774,7 +7774,7 @@ u64 __weak perf_reg_value(struct pt_regs *regs, int idx)
 	return 0;
 }
 
-int __weak perf_reg_validate(u64 mask)
+int __weak perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	return mask ? -ENOSYS : 0;
 }
@@ -13743,7 +13743,8 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
-		ret = perf_reg_validate(attr->sample_regs_user);
+		ret = perf_reg_validate(attr->sample_regs_user,
+					attr->sample_simd_regs_enabled);
 		if (ret)
 			return ret;
 		ret = perf_simd_reg_validate(attr->sample_simd_regs_enabled,
@@ -13776,7 +13777,8 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 		attr->sample_max_stack = sysctl_perf_event_max_stack;
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_INTR) {
-		ret = perf_reg_validate(attr->sample_regs_intr);
+		ret = perf_reg_validate(attr->sample_regs_intr,
+					attr->sample_simd_regs_enabled);
 		if (ret)
 			return ret;
 		ret = perf_simd_reg_validate(attr->sample_simd_regs_enabled,
-- 
2.34.1

