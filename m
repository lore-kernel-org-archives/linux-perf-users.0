Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C753AD50D;
	Mon, 27 Apr 2026 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280429; cv=none; b=nJ0vknfpCTGfNhiCb7B7W53IBA/8++Q4vFkYKVlimVjbBsBDykseD9eqiZOdwsljQK9DgFVnBDtrW86Tv2x//IniYLV1QDqlWmcZ8U/EVYpsOc7bs7SmvClE26HGqhw3fIO73lMCcHV2UtGjrFsTxKqbZuEgmL4Al8KTREWQPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280429; c=relaxed/simple;
	bh=BSiRhiJaK8vaseOEYBdc8h6BfjVONGImkHO7urgWINQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k2U3OJnnl+cS1no4YybshiX+NHewUY1VPEOjs45n/GGT7msR0eZH8swI4tW4G3MyziBxyu4ExARtGU51YNgpcERiVrMpqZ9sV7UEUsQqyHykINjXhgXou6y+3Y4LSAhaQrOPGtdR7r5HRNninfOmeQBXbNXL4kYALii/F/5puiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUNDCFCr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUNDCFCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777280429; x=1808816429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BSiRhiJaK8vaseOEYBdc8h6BfjVONGImkHO7urgWINQ=;
  b=FUNDCFCrcsxegzXVo7OfCAGVE1GppxgpopeMWkrtc4dT2LTXmJ24Eoyf
   5B61F1qCJ1xp7xH5RwK/KshPVDdMKGCmb056tnwd+u9iq7ENSy0Jbd40s
   iK8NhAZgikPd5Zz6spptHVbGGAdpEF7MVuSYnAM77s1z5is2WKFf9Zekc
   7bjZfSa/Hvne6/uue/dSDrqcHPeGQcL8uMbP1KvPtmBnGbaYufatpDezy
   O/Lt7sp7083k7KXuz7SZv3Vc7A2bDoLVI7QUgvTBtOOaEb3G72S62YmID
   KAt8u3GrSK7XeyMzEEuaC8vQc8Re4Dcu+wWbrqypsPe7p6HOy5v7pHaM5
   Q==;
X-CSE-ConnectionGUID: d6eVUaqiQ1i+TdFNzB5hkg==
X-CSE-MsgGUID: IjmhjGgKS6qimaVUMEu83Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88476356"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="88476356"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:00:29 -0700
X-CSE-ConnectionGUID: pUGuhvURSneTkupXfqhhPQ==
X-CSE-MsgGUID: fWs4P+NYR6+cuFq4Z0Oopw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="233850655"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 02:00:25 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 4/4] perf/x86/intel: Consolidate MSR_IA32_PERF_CFG_C tracking
Date: Mon, 27 Apr 2026 16:55:13 +0800
Message-Id: <20260427085513.3728672-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427085513.3728672-1-dapeng1.mi@linux.intel.com>
References: <20260427085513.3728672-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both Auto Counter Reload (ACR) and Architectural PEBS use the PERF_CFG_C
MSRs to configure event behavior. Currently, the driver maintains two
independent variables acr_cfg_c and cfg_c_val to cache the values intended
for these MSRs.

Using separate variables to track a single hardware register state is
error-prone and can lead to configuration conflicts. Consolidate the
tracking into a single cfg_c_val variable to ensure a unified and
consistent view of the PERF_CFG_C MSR state.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 13 +++++++------
 arch/x86/events/perf_event.h |  4 +---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 60568a9ce06b..013e6e02706d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3169,10 +3169,10 @@ static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
 		wrmsrl(msr_b + msr_offset, mask);
 		cpuc->acr_cfg_b[idx] = mask;
 	}
-	/* Only need to update the reload value when there is a valid config value. */
-	if (mask && cpuc->acr_cfg_c[idx] != reload) {
+	/* Only update CFG_C reload when ACR is actively enabled (mask != 0) */
+	if (mask && ((cpuc->cfg_c_val[idx] & ARCH_PEBS_RELOAD) != reload)) {
 		wrmsrl(msr_c + msr_offset, reload);
-		cpuc->acr_cfg_c[idx] = reload;
+		cpuc->cfg_c_val[idx] = reload;
 	}
 }
 
@@ -3198,14 +3198,15 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
-	union arch_pebs_index old, new;
-	struct arch_pebs_cap cap;
 	u64 ext = 0;
 
-	cap = hybrid(cpuc->pmu, arch_pebs_cap);
+	if (is_acr_event_group(event))
+		ext |= (-hwc->sample_period) & ARCH_PEBS_RELOAD;
 
 	if (event->attr.precise_ip) {
 		u64 pebs_data_cfg = intel_get_arch_pebs_data_config(event);
+		struct arch_pebs_cap cap = hybrid(cpuc->pmu, arch_pebs_cap);
+		union arch_pebs_index old, new;
 
 		ext |= ARCH_PEBS_EN;
 		if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 524668dcf4cc..40d6fe0afc4a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -322,10 +322,8 @@ struct cpu_hw_events {
 	u64			fixed_ctrl_val;
 	u64			active_fixed_ctrl_val;
 
-	/* Intel ACR configuration */
+	/* Intel ACR/arch-PEBS configuration */
 	u64			acr_cfg_b[X86_PMC_IDX_MAX];
-	u64			acr_cfg_c[X86_PMC_IDX_MAX];
-	/* Cached CFG_C values */
 	u64			cfg_c_val[X86_PMC_IDX_MAX];
 
 	/*
-- 
2.34.1

