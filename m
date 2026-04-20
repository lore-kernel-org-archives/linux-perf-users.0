Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130F437EFE0;
	Mon, 20 Apr 2026 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653424; cv=none; b=FsZACBIk9MtHlowhVXSMAciUWxizN4Roikw5BmKcdZkfWF3ziCKO6IPkCjJloZnsQObVkp0USObNHWXLVXgCSmZvoQkUVGnMKx0Zo6eyDCb8B+rddMaxI8O77NzQYT34pu0EgCOuXAP+P9xaxdlWLag8LlJL5Kddl8D2K4NLYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653424; c=relaxed/simple;
	bh=2bf08aeEUxhfg1cK5fNzAhUOWDp4cmQTN0IHH56OVw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qT8IdscHxexzvW06NqcOnmjOGFBRbRWVoxNYS2ne1vafS8qcT8/noZlLlFERjm70KwHRELThJQe/9D3v16e3gJ22NijsfounXohnjZhnO3xLpozON2wACUmb03zjuuvC/A93URaWT3vpiXY/dK/FCv+hShy1U3W7OWcEdzt6TXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QH+B+ZZr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QH+B+ZZr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776653423; x=1808189423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2bf08aeEUxhfg1cK5fNzAhUOWDp4cmQTN0IHH56OVw8=;
  b=QH+B+ZZrEYKzQHdzpHZGQs+2ma/V87R8o5hqst0agShKhFvqr3F/2pyg
   FZQApdlndtR02lQN/P8dwZhSE+r8+yVbr6Wzp90zMwU+d1eqh4H+4/7MN
   UjMgF9J30BdDXL74TsHIjlGLWQkRgG4uDqr4Pd5Cv3USmzP6i+M7melyr
   T4z0gqq/IjE32YsW8ZJfxgS0JGcr3xs5ZA47U4M41vvmzAzVzJQEc7++Y
   Y6BaPFTJly5E2qUHDG8LaCndwtRlYmvImB6yGM3ida2Q9EjIC+/C7PLqz
   OVv3HH4haFAbp2cYI5DNxE1ZvJayWeTqmTSuK1H17AVLa238E9dOwQxy9
   Q==;
X-CSE-ConnectionGUID: kIWtPM84QMqhWJar5y5zOg==
X-CSE-MsgGUID: e3ykd4R5S8y0ZdS05r4Bpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81442190"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="81442190"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 19:50:23 -0700
X-CSE-ConnectionGUID: MIp3dRJbQnutHoXTOTISLA==
X-CSE-MsgGUID: eJxJ5q7/S5a9VO6J4j55uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="228908022"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 19 Apr 2026 19:50:19 -0700
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
Subject: [Patch v2 4/4] perf/x86/intel: Consolidate MSR_IA32_PERF_CFG_C tracking
Date: Mon, 20 Apr 2026 10:45:28 +0800
Message-Id: <20260420024528.2130065-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420024528.2130065-1-dapeng1.mi@linux.intel.com>
References: <20260420024528.2130065-1-dapeng1.mi@linux.intel.com>
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

V2: New patch.

 arch/x86/events/intel/core.c | 13 +++++++------
 arch/x86/events/perf_event.h |  4 +---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fa4073bf18fe..667917baf7f2 100644
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

