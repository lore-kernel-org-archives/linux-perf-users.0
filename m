Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8320D1D5AB5;
	Thu, 23 Jan 2025 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613258; cv=none; b=TVirVOV9a+lVqoTaMAJLKM86lxYxXDo3mvBupYK+8EGE6/r/T1ORrzxgi5sVsiuxVhRx+tNk/dlcrQCXQVEieinq44jGQ13C6CqAn8m9iRH/hxPhTzs0rYU9h68BNhuJX0/Uf2RSzTM0o4mTCepjJ3g0whLSjetCPCvZhVrjtf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613258; c=relaxed/simple;
	bh=4oXkoEn57uFVGb/wlrcvRfUkBiaTMHDJsbUvCeXZ3pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WSxkc4dt13uEiP1kvvIYLbhn+cgCkNgOESJSLJSjXSVHVCmU15yKc43/QkbxnqO/UzxdBCzvUuVp/kT3t3MqObyKXBtbmDCB68YaFyVrgnILX1HqiREPbNqe9tAzZdKIyct65NnrHhHWkfdj9N+jq/T+NO3VUVqqLwl2cbkS8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5+5HUjP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5+5HUjP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613257; x=1769149257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4oXkoEn57uFVGb/wlrcvRfUkBiaTMHDJsbUvCeXZ3pk=;
  b=n5+5HUjPOy1ScSA68WNRmgUU/MMpDM3PrFFMrl8OCE+bNzWMqM2EljKX
   q3iZaEGJ+T3Q0lNJQ4xXVy2NRLLboq5PzIol5yuT8bPFBkYm2jfBIXdKT
   00W58tV2N8dYM696JrXuapQXfzycbN92P6D3L6X+/whkzyTNcWxUprd/s
   tKkDucCJGBN15JwjX32zdfUx7XextcEBZiku7piNaJ7JIhFOhnJNUNY6i
   /Lop67Nb61KisYWIHJu6Ntsb0PdMRJHD/sUtJInEgoO82pYz8udzHfejP
   u6wOEpEtawGw5NaEiqenwrPIokypWQpiIiav5RuprnyDCJWtW9xVuHGp4
   w==;
X-CSE-ConnectionGUID: RxNOs8gFTJuCrtyFa0dwaA==
X-CSE-MsgGUID: GiErytExSI21VDy2WgjSlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513164"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513164"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:20:56 -0800
X-CSE-ConnectionGUID: ZcsX0TBdTp6kSzpgmxooBg==
X-CSE-MsgGUID: I4xZK48LSGeIxiRCy7Ek3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334656"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:20:52 -0800
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
Subject: [PATCH 13/20] perf/x86/intel: Add SSP register support for arch-PEBS
Date: Thu, 23 Jan 2025 14:07:14 +0000
Message-Id: <20250123140721.2496639-14-dapeng1.mi@linux.intel.com>
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

Arch-PEBS supports to capture SSP register in GPR group. This patch
supports to read and output this register. SSP is for shadow stacks.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 10 ++++++++++
 arch/x86/events/intel/ds.c            |  3 +++
 arch/x86/include/asm/perf_event.h     |  1 +
 arch/x86/include/uapi/asm/perf_regs.h |  3 ++-
 arch/x86/kernel/perf_regs.c           |  5 +++++
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f40b03adb5c7..7ed80f01f15d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -646,6 +646,16 @@ int x86_pmu_hw_config(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	/* sample_regs_user never support SSP register. */
+	if (unlikely(event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP)))
+		return -EINVAL;
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
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 5d8c5c8d5e24..a7e101f6f2d6 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2209,6 +2209,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ssp = 0;
 
 	format_group = basic->format_group;
 
@@ -2325,6 +2326,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ssp = 0;
 
 	__setup_perf_sample_data(event, iregs, data);
 
@@ -2361,6 +2363,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 		__setup_pebs_gpr_group(event, regs, (struct pebs_gprs *)gprs,
 				       sample_type);
+		perf_regs->ssp = gprs->ssp;
 	}
 
 	if (header->aux) {
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index d0a3a13b8dae..cca8a0d68cbc 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -671,6 +671,7 @@ extern void perf_events_lapic_init(void);
 struct pt_regs;
 struct x86_perf_regs {
 	struct pt_regs	regs;
+	u64		ssp;
 	u64		*xmm_regs;
 };
 
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..2e88fdebd259 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,10 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	PERF_REG_X86_SSP,
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
-	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+	PERF_REG_X86_64_MAX = PERF_REG_X86_SSP + 1,
 
 	/* These all need two bits set because they are 128bit */
 	PERF_REG_X86_XMM0  = 32,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 624703af80a1..4b15c7488ec1 100644
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
 
@@ -68,6 +70,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
 	}
 
+	if (idx == PERF_REG_X86_SSP)
+		return perf_regs->ssp;
+
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
 		return 0;
 
-- 
2.40.1

