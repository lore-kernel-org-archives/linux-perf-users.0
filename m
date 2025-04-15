Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380328BAA7;
	Tue, 15 Apr 2025 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705445; cv=none; b=bJCuiZtOLYVleUOX/vcvR+/Ut/76e92s/U6ZToe1iOCsy3M4m+kwswYzdmwgrVfBAcPjs57+u4K7FWEL7rdz++GwVpiJvVZgN6IOesb/KjoWSg/1Uz81TNdnTBu4+UEPFfwAfTqsMYXKymXcrm3G1h9ahK6vrpAp4ZrhNrx3ovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705445; c=relaxed/simple;
	bh=KU+fwd9ys/2H/rWcdMTGYWyS/WENx0jFbK3PxdMIHpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EM/OBePyBRTCC1Y1AtYDeV8Zf7HjKXV8ixtKZgK65t9eX19LWKJwZoiH2CdIl6Yqss/kI7wa+iLocq3XeqMfdsLF2I0BeOUvWiXoXnIa27h2EYg6jZejVCgmxL24yx01iTu0lyiyHuIMI6S5bAioGqhUJwXq9CuGXhkJ7OaYJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwWe6fjA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwWe6fjA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705444; x=1776241444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KU+fwd9ys/2H/rWcdMTGYWyS/WENx0jFbK3PxdMIHpk=;
  b=hwWe6fjAItDxxhuXzrHP7F0LZuLWf8RqVsrJlIoRKnsa0/O3DDPN/zUZ
   7j7HmF74gvhMI//vMvdIVNoflCg+xDLpjChgGIzcjPX71nK1zzABENpz9
   sz0vLcFN1e8UrklOVDa49oih5Hj/ByL/6ET2A/52GsriDe+TFVnMfRbCb
   J2YH1wiskjDZtFiPu+YnakncHvIO1JGAviqKi4fJOsZPRjM/iccU+pvtM
   6LX5jFp+7Moy3cwOc7+mW5yZ6vwpBw46QhYtRMMWztluKyGBr3ckSC2Ne
   bHhZxQl1rt6X/eeefTlT2Zk/RxxT8NUjSzLzalPVm3vciAjKjmsIeR/gG
   A==;
X-CSE-ConnectionGUID: Dp3EhExIT7SzQ3KBOhQH/A==
X-CSE-MsgGUID: Q5c94PtISUqsPaxD1T7Ewg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46116075"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46116075"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:24:04 -0700
X-CSE-ConnectionGUID: xFm4KFhhTC6Aa4j6YVjYeA==
X-CSE-MsgGUID: 1F64bVbgTPS13tRPJfTOYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055641"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:24:00 -0700
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
Subject: [Patch v3 15/22] perf/x86/intel: Support SSP register capturing for arch-PEBS
Date: Tue, 15 Apr 2025 11:44:21 +0000
Message-Id: <20250415114428.341182-16-dapeng1.mi@linux.intel.com>
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

Arch-PEBS supports to capture shadow stack pointer (SSP) register in GPR
group. This patch supports to capture and output SSP register at
interrupt or user space, but capturing SSP at user space requires
'exclude_kernel' attribute must be set. That avoids kernel space SSP
register is captured unintentionally.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 15 +++++++++++++++
 arch/x86/events/intel/core.c          |  3 ++-
 arch/x86/events/intel/ds.c            |  9 +++++++--
 arch/x86/events/perf_event.h          |  4 ++++
 arch/x86/include/asm/perf_event.h     |  1 +
 arch/x86/include/uapi/asm/perf_regs.h |  4 +++-
 arch/x86/kernel/perf_regs.c           |  7 +++++++
 7 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9c205a8a4fa6..0ccbe8385c7f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -650,6 +650,21 @@ int x86_pmu_hw_config(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	if (unlikely(event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP))) {
+		/* Only arch-PEBS supports to capture SSP register. */
+		if (!x86_pmu.arch_pebs || !event->attr.precise_ip)
+			return -EINVAL;
+		/* Only user space is allowed to capture. */
+		if (!event->attr.exclude_kernel)
+			return -EINVAL;
+	}
+
+	if (unlikely(event->attr.sample_regs_intr & BIT_ULL(PERF_REG_X86_SSP))) {
+		/* Only arch-PEBS supports to capture SSP register. */
+		if (!x86_pmu.arch_pebs || !event->attr.precise_ip)
+			return -EINVAL;
+	}
+
 	/* sample_regs_user never support XMM registers */
 	if (unlikely(event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK))
 		return -EINVAL;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d543ed052743..b6416535f84d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4151,12 +4151,13 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
 static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 {
 	unsigned long flags = x86_pmu.large_pebs_flags;
+	u64 gprs_mask = x86_pmu.arch_pebs ? ARCH_PEBS_GP_REGS : PEBS_GP_REGS;
 
 	if (event->attr.use_clockid)
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
+	if (event->attr.sample_regs_user & ~gprs_mask)
 		flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
 	return flags;
 }
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 19b51b4d0d94..91a093cba11f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1431,6 +1431,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	u64 sample_type = attr->sample_type;
 	u64 pebs_data_cfg = 0;
 	bool gprs, tsx_weight;
+	u64 gprs_mask;
 
 	if (!(sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) &&
 	    attr->precise_ip > 1)
@@ -1445,10 +1446,11 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	 * + precise_ip < 2 for the non event IP
 	 * + For RTM TSX weight we need GPRs for the abort code.
 	 */
+	gprs_mask = x86_pmu.arch_pebs ? ARCH_PEBS_GP_REGS : PEBS_GP_REGS;
 	gprs = ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-		(attr->sample_regs_intr & PEBS_GP_REGS)) ||
+		(attr->sample_regs_intr & gprs_mask)) ||
 	       ((sample_type & PERF_SAMPLE_REGS_USER) &&
-		(attr->sample_regs_user & PEBS_GP_REGS));
+		(attr->sample_regs_user & gprs_mask));
 
 	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT_TYPE) &&
 		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
@@ -2243,6 +2245,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ssp = 0;
 
 	format_group = basic->format_group;
 
@@ -2359,6 +2362,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ssp = 0;
 
 	__setup_perf_sample_data(event, iregs, data);
 
@@ -2395,6 +2399,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 		__setup_pebs_gpr_group(event, regs, (struct pebs_gprs *)gprs,
 				       sample_type);
+		perf_regs->ssp = gprs->ssp;
 	}
 
 	if (header->aux) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index c6c2ab34e711..6a8804a75de9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -175,6 +175,10 @@ struct amd_nb {
 	 (1ULL << PERF_REG_X86_R14)   | \
 	 (1ULL << PERF_REG_X86_R15))
 
+#define ARCH_PEBS_GP_REGS		\
+	(PEBS_GP_REGS |			\
+	 (1ULL << PERF_REG_X86_SSP))
+
 /*
  * Per register state.
  */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 4e5adbc7baea..ba382361b13f 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -704,6 +704,7 @@ extern void perf_events_lapic_init(void);
 struct pt_regs;
 struct x86_perf_regs {
 	struct pt_regs	regs;
+	u64		ssp;
 	u64		*xmm_regs;
 };
 
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..f9c5b16b1882 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,11 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/* arch-PEBS supports to capture shadow stack pointer (SSP) */
+	PERF_REG_X86_SSP,
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
-	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+	PERF_REG_X86_64_MAX = PERF_REG_X86_SSP + 1,
 
 	/* These all need two bits set because they are 128bit */
 	PERF_REG_X86_XMM0  = 32,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 624703af80a1..985bd616200e 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -54,6 +54,8 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
 	PT_REGS_OFFSET(PERF_REG_X86_R13, r13),
 	PT_REGS_OFFSET(PERF_REG_X86_R14, r14),
 	PT_REGS_OFFSET(PERF_REG_X86_R15, r15),
+	/* The pt_regs struct does not store Shadow stack pointer. */
+	(unsigned int) -1,
 #endif
 };
 
@@ -68,6 +70,11 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
 	}
 
+	if (idx == PERF_REG_X86_SSP) {
+		perf_regs = container_of(regs, struct x86_perf_regs, regs);
+		return perf_regs->ssp;
+	}
+
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
 		return 0;
 
-- 
2.40.1

