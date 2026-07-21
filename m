Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF7434E23;
	Tue, 21 Jul 2026 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615644; cv=none; b=cngSy6wexgMidrSsEvtgt7Mvpkjz9ag4j2N0DcP8RWKd7whE/8nijyTpd/t+x5FFdx42eRgWReqca/39Erui3jBfL+H5kHvVE/jHOIhdsEMc227Ak0zqqOdiobnQLn+MGilei4/GQjSeNs5O3kWf5j9hJHatj04Qg70DbS1L49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615644; c=relaxed/simple;
	bh=vXfypQMrut1DdLL+DtHpfL8ea1oWMWk1CyBxQehvkDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aF8OhOvdEr0hq78kpS5M9zwNcfyztQ05i80Hfrc64fM/quIfpuBMNaoua+60U9WwvO47AcNBWIhcRUdOZl4Qm08lewJDOQt0nCytQ+usZzjxDwdf2eLFoRAOQGseFz0bIMMD/+BHKYTOwJkLt/r5K5BIEVblwGIThbJkvmFjO+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I98ucbZo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I98ucbZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784615643; x=1816151643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vXfypQMrut1DdLL+DtHpfL8ea1oWMWk1CyBxQehvkDc=;
  b=I98ucbZovAvszWf+dbtprhzWthZ8423Z4m64sBKl2IGVWD7TZU0VZ9CH
   p/10A26OOd8GrqQ6aE6WjVi3Wod7MAvETwNvikFcEa0wJzUZpjRcOSKf1
   5csaBsv1Dvi12uSQaNkMxXR5z+hnW7d41TevxunGCVKWduvVhei/JaaZx
   fhZdHBaGub2aTIQiIKzd4xDz2hLCtX0XBKHtzFGU+naYT3Yo7f14KEPtz
   n6KvM8ccJAMqRFB1zsuuddJNOL6MdlBgKtiEd8nV9EGp3retWxykSmxej
   ubhtfxdDd5ICO+oCz5BBv+40ijr6tlorI46Aeb2gJuuiPY2a6N1k32hgt
   w==;
X-CSE-ConnectionGUID: KiS/y1NDQTSpCTvhodykdA==
X-CSE-MsgGUID: cGB7khGIR+meLMO7VmevIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95565528"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95565528"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:34:02 -0700
X-CSE-ConnectionGUID: MwE0frdcSpWlE+Ss3GnNGg==
X-CSE-MsgGUID: jq8JZrrSRnCPmkCVqy684g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="259656158"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jul 2026 23:33:57 -0700
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
Subject: [Patch v10 17/23] perf: Enhance perf_reg_validate() with simd_enabled argument
Date: Tue, 21 Jul 2026 14:25:00 +0800
Message-Id: <20260721062506.3745816-18-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
References: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
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
index 87297da5e44b..494e06501210 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -198,7 +198,7 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 		       (1ULL << PERF_REG_X86_R14) | \
 		       (1ULL << PERF_REG_X86_R15))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	/* The mask could be 0 if only the SIMD registers are interested */
 	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
@@ -218,7 +218,7 @@ u64 perf_reg_abi(struct task_struct *task)
 		       (1ULL << PERF_REG_X86_FS) | \
 		       (1ULL << PERF_REG_X86_GS))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	/* The mask could be 0 if only the SIMD registers are interested */
 	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index 518f28c6a7d4..09dbc2fc3859 100644
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
index 8f0018f061bd..6eaa1bb2e4fd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7812,7 +7812,7 @@ u64 __weak perf_reg_value(struct pt_regs *regs, int idx)
 	return 0;
 }
 
-int __weak perf_reg_validate(u64 mask)
+int __weak perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	return mask ? -ENOSYS : 0;
 }
@@ -13793,7 +13793,8 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
-		ret = perf_reg_validate(attr->sample_regs_user);
+		ret = perf_reg_validate(attr->sample_regs_user,
+					attr->sample_simd_regs_enabled);
 		if (ret)
 			return ret;
 		if (attr->sample_simd_regs_enabled) {
@@ -13825,7 +13826,8 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 		attr->sample_max_stack = sysctl_perf_event_max_stack;
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_INTR) {
-		ret = perf_reg_validate(attr->sample_regs_intr);
+		ret = perf_reg_validate(attr->sample_regs_intr,
+					attr->sample_simd_regs_enabled);
 		if (ret)
 			return ret;
 		if (attr->sample_simd_regs_enabled) {
-- 
2.34.1

