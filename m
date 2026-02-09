Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCD631DDB8;
	Mon,  9 Feb 2026 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621974; cv=none; b=d/HUAnk0ixfzmbPf46GwqovFTLJPCT5lWp8WXyDt2ZCLvvJpoX7zVbnslk+ROoSYjbitvyJA/DDjZkADUeu3k+kljmPdtgI2/gcOBdO0NrRHMTtSefYpO9PKeALHVf5dmZV7zHyHK7fXwXdKTT8/nVx4+ZNT8v8AwE9TZj4EOd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621974; c=relaxed/simple;
	bh=hmQnHbJipSad3Ltuk+N5rXvMTH+C44IN6AhB0cqwOIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HBH5RXGUdH00tE58kUCuA2OnVWEDCWJryeQVCDXohyNWNtpOg6rcP7F3z7cNNgzR963mlxB5YfuYaM3rTpGNKe23/4pmPmbDspy7H2LmK4uMyNnLnvezwMERDANjeBJDCLl69N5n8M3G+a8NaLaDoj2N0F0cQWFTRhjQgKTQVa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MRYpzL5a; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MRYpzL5a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621975; x=1802157975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hmQnHbJipSad3Ltuk+N5rXvMTH+C44IN6AhB0cqwOIM=;
  b=MRYpzL5aCA/NxM42kQgdAqSCO4UqvcAh64XgPXvEVk5OIdlfKk2FXYyw
   /fyjc4V/XsSSiOe6Dp0zHepT2Jd2iFDvlGPNM2JhRjxHfsu+PQwCut23y
   J09d8OE6XKe2KwGCTmBFWYq8EoETV/R9p1+xVW9nvRuf3Oy5gqacFwtpM
   +yVrczGrh76G2UGvTziKOf5aIDEoYyhp2WI6480le0ALlEhDqz91km8WI
   Z8ps9/cA0MG+uFOTzdgIPMRNW6xcPekU6UwOVysz/5VIrl2gWSkxNW+sS
   TFLbCSYxfN1Bllw1s9e+dPp1KoAyJCm3Qj6pTwOsWziKpAnWWtgpKjTlX
   w==;
X-CSE-ConnectionGUID: /wlB+t9HRoq77D0DjvCqPw==
X-CSE-MsgGUID: zEcUV+bpTuesIvwx5Sh8/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098520"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098520"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:26:15 -0800
X-CSE-ConnectionGUID: FlkyNOt4QWiNXg7i+r8IUw==
X-CSE-MsgGUID: FnXiR4ClTFup8aIHieFCOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694774"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:26:10 -0800
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
Subject: [Patch v6 17/22] perf: Enhance perf_reg_validate() with simd_enabled argument
Date: Mon,  9 Feb 2026 15:20:42 +0800
Message-Id: <20260209072047.2180332-18-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
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

V6: new patch, splited from the next patch.

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
index 2e3c10dffb35..9b3134220b3e 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -166,7 +166,7 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 		       (1ULL << PERF_REG_X86_R14) | \
 		       (1ULL << PERF_REG_X86_R15))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
 		return -EINVAL;
@@ -185,7 +185,7 @@ u64 perf_reg_abi(struct task_struct *task)
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
index 5742126f50cc..8b27b4873dd0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7728,7 +7728,7 @@ u64 __weak perf_reg_value(struct pt_regs *regs, int idx)
 	return 0;
 }
 
-int __weak perf_reg_validate(u64 mask)
+int __weak perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	return mask ? -ENOSYS : 0;
 }
@@ -13614,7 +13614,8 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
-		ret = perf_reg_validate(attr->sample_regs_user);
+		ret = perf_reg_validate(attr->sample_regs_user,
+					attr->sample_simd_regs_enabled);
 		if (ret)
 			return ret;
 		ret = perf_simd_reg_validate(attr->sample_simd_vec_reg_qwords,
@@ -13644,7 +13645,8 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 		attr->sample_max_stack = sysctl_perf_event_max_stack;
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_INTR) {
-		ret = perf_reg_validate(attr->sample_regs_intr);
+		ret = perf_reg_validate(attr->sample_regs_intr,
+					attr->sample_simd_regs_enabled);
 		if (ret)
 			return ret;
 		ret = perf_simd_reg_validate(attr->sample_simd_vec_reg_qwords,
-- 
2.34.1

