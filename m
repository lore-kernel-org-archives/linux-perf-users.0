Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249225;
	b=npDa9yAk/g1zu2tHEO1hjhH8EjUrGkmDfUQpHpa3eSPxFEHrxJohr7kFnQUzK6Yd2hRs
	 MUAKAJTNvMyMEAiDyEZnVByzFopws5hdDjVwy1Tm5pqbm9/FUfOI1yDaa5ai6rexO8QAF
	 K0p/TYtWKGWu6Akycfp8LIPuKb9l7SSeap17skzAYZ5sgTpRIyPQlItPhA6Je5JTApkhY
	 RI4T1SUtB6uBPB8DH92UTXTvLXIpbWRPB0XVZGskGFfrg3Er9jxs98dVFzo1wDsZziI20
	 DdvKTbSh0gU5Wo+BcBZo9z3Io2uj+d/sBNF+e/mc3NRJDvbQrzekgzTiKT0EkW2sPiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249225;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8CrB0Izb9RCgbyuLTsLtugBVvhPWOmwsAnrt3LuXukA=;
	b=TM9dzo1NSpNJKB4VhWxI16YYC4P4Lt5XtqIClrUTI5tJ2tLon6VOteFhCpvfLBBGQGvR
	 0kmJmRGzM/qMEBXe5t6enBAuSy1fChxk/L2wLHnDMrZxvlGVT0E6G6RhqZiVlWBvnhXsh
	 XaJF4FHVBJKT4dmnChBu+3BqWD69eZMf1GKobeeb+9z4BANBebOd+AsbAVYjA8kxJjEdz
	 295ScbMuBD6H3mbehDCktkFJC4Gd+WMbyJgwbHY9rVxEbv0fMNmYwbQxRbsNPNeUuVPrw
	 ajRhJwzxjzcSSocBUpN5QsQljidzuF7W7QHAUJuUPjJOCQuITB6Vf1JDeWQW13yoo8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K4CtogpS;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86489606A31A;
	Thu, 29 Oct 2026 04:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86489606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K4CtogpS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249225; x=1824785225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ShmOFcKWsMhxwDMTrAUAt2M+Fx3W9K6ZXyPKFGmexkM=;
  b=K4CtogpS7U8mi+KGStZMifmFPw6TosGbRqgUIWACyOrMC+ADT+uSUUbo
   qKAn/DaJsLaB8Nx49iKA5Pu84zUMx/5tt5ymWeoLkAZuCEyN5dlAA91Lu
   N64zP3+rhqXpUqa84zh0aoX7xylpvIFAu9YMmfgZl0TckSNYa2UdqTo68
   DsBzW0fgIm1TmgPveMkfmjwPUHO40kNvGYMZSrWCHCaSh69uUWc0Eh703
   ZNs4TdJeLhh/mwdxpC9NFmh9U6BVZVG52VVI3GWNo8HfS4spvrLwYwN0d
   wOC3rHp30mjAEm2B/TRC+9PVyIvtj+zN59opLnXA4t1Bn7XM4hQA16F7o
   A==;
X-CSE-ConnectionGUID: ygTNcMbNR2a3XlGoAu9G0A==
X-CSE-MsgGUID: uHsi95opRlaazkHCXU+CUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986268"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986268"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:47:04 -0700
X-CSE-ConnectionGUID: 6ZgtpV3SQua6tve83x3WdQ==
X-CSE-MsgGUID: Roqkig6GQvOSLgS2t261DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420358"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:47:00 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v5 05/18] perf/x86: Add lbr_enabled to track LBR state
Date: Thu, 29 Oct 2026 12:39:01 +0800
Message-Id: <20261029043914.1395147-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a lbr_enabled flag to track whether LBR is enabled. This will be
used by a subsequent change to avoid blindly re-enabling LBR in
perf_snapshot_branch_stack() without checking whether LBR has already
been disabled.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/amd/lbr.c    | 2 ++
 arch/x86/events/intel/core.c | 5 +++++
 arch/x86/events/intel/lbr.c  | 2 ++
 arch/x86/events/perf_event.h | 9 +++++++++
 4 files changed, 18 insertions(+)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 46bd3ce1d614..cf11e4815c39 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -399,6 +399,8 @@ void amd_pmu_lbr_enable_all(void)
 	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
 		return;
 
+	cpuc->lbr_enabled = 1;
+
 	/* Set hardware branch filter */
 	if (cpuc->lbr_select) {
 		lbr_select = cpuc->lbr_sel->config & LBR_SELECT_MASK;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 18cae4ac32b6..0ed0269189ba 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4001,6 +4001,11 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * It needs to be restored when leaving the handler.
 	 */
 	pmu_enabled = cpuc->enabled;
+
+	/* If pmu version < 4, LBR freeze disables LBR. */
+	if (x86_pmu.version < 4)
+		cpuc->lbr_enabled = 0;
+
 	/*
 	 * In general, the early ACK is only applied for old platforms.
 	 * For the big core starts from Haswell, the late ACK should be
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 1ae853f7ac1a..ee724b28d90c 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -132,6 +132,8 @@ static void __intel_pmu_lbr_enable(bool pmi)
 	if (pmi && x86_pmu.version >= 4)
 		return;
 
+	cpuc->lbr_enabled = 1;
+
 	/*
 	 * No need to reprogram LBR_SELECT in a PMI, as it
 	 * did not change.
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e274802ef062..a4aab8130e92 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -473,6 +473,7 @@ struct cpu_hw_events {
 	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	unsigned long		dirty[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	int			enabled;
+	int			lbr_enabled;
 
 	int			n_events; /* the # of events in the below arrays */
 	int			n_added;  /* the # last events in the below arrays;
@@ -1676,8 +1677,11 @@ int amd_pmu_lbr_hw_config(struct perf_event *event);
 
 static __always_inline void __amd_pmu_lbr_disable(void)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	u64 dbg_ctl, dbg_extn_cfg;
 
+	cpuc->lbr_enabled = 0;
+
 	rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
 	wrmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
 
@@ -1829,13 +1833,18 @@ static __always_inline void __intel_pmu_pebs_disable_all(void)
 
 static __always_inline void __intel_pmu_arch_lbr_disable(void)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	cpuc->lbr_enabled = 0;
 	wrmsrq(MSR_ARCH_LBR_CTL, 0);
 }
 
 static __always_inline void __intel_pmu_lbr_disable(void)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	u64 debugctl;
 
+	cpuc->lbr_enabled = 0;
 	rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 	debugctl &= ~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
 	wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
-- 
2.34.1

