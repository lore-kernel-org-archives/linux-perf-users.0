Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4CC234987;
	Tue, 18 Feb 2025 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866474; cv=none; b=hGbWiqZVLGdX5+8YO/HaPDN7+Qmmz1z4/O9zx5Qlq5TXMNBzkYC14adrZWD03WLV4kXrTUfaAlJRFsATcCaSF1CnLErdVAGnQ+cJIiSPHS9BrHddKOT9BrWvw7Daj0DAyJrK9QVYVUb2FEW5gZ29NrJjVsV7Pg3CYft1UjTFDYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866474; c=relaxed/simple;
	bh=zlcehtRImEArlJgqpqckOJzYMXNhid/joYfJ0dPIgPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bSoSpytRmEn2oSoRNACGEd/ORQv0dCUMppeGPhBZsrdGplbCpxgkkPKVcv+S/ez5/N1z7e0ovShmTe3WIFfnm2KWWBMiHCJ67iR2FS9YWGyB8mxnxYM8Ad5kxvdIIBRDpDrCpDnLyGuUX2SkLtAg0wi0xmEcIHKTuAzc0quC1BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7hyiGNG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7hyiGNG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866474; x=1771402474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zlcehtRImEArlJgqpqckOJzYMXNhid/joYfJ0dPIgPY=;
  b=D7hyiGNGklxO8tr7PDRXnuXayZL56BOy5hv1gDFKmFAJOw9wrIQPXklV
   lvevwPRPbsuqrP7UZ5Uc0BKximCzrcrp6cpnc/AZ+6hTjnmmeYFkelSRC
   H/kW8WqYLvprAjYzqBddH+Tmw4mreCWX8mpZT/rssyzVWVQxPC5I10A+b
   3ogr0iyAkfsWRmXuaitvhnT4A/jiiUeCz+TuTma/mSJRnS6UEOzKbKuO0
   JC5smGS2sr2TBh59kpgoyKvAvI9FQJTVlXENQCHu/OdcrkAGhSMcJJin+
   YVMX4h2/pNmXyXPTuag6k6iMXsCe53w6eknhopKr0lDo8cEEq3nFenoNs
   w==;
X-CSE-ConnectionGUID: 2jkwIW6/R1y+xGuEr/0Z9A==
X-CSE-MsgGUID: pNg/KfIKRdCpp75QcBII6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200816"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200816"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:14:34 -0800
X-CSE-ConnectionGUID: ygdL5WNTRlaYpAaLUgs50w==
X-CSE-MsgGUID: d7Zg4naaQqSOGdTDU8kITA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166255"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:14:29 -0800
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
Subject: [Patch v2 13/24] perf/x86/intel: Update dyn_constranit base on PEBS event precise level
Date: Tue, 18 Feb 2025 15:28:07 +0000
Message-Id: <20250218152818.158614-14-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch-PEBS provides CPUIDs to enumerate which counters support PEBS
sampling and precise distribution PEBS sampling. Thus PEBS constraints
should be dynamically configured base on these counter and precise
distribution bitmap instead of defining them statically.

Update event dyn_constraint base on PEBS event precise level.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 6 ++++++
 arch/x86/events/intel/ds.c   | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 472366c3db22..c777e0531d40 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4033,6 +4033,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		return ret;
 
 	if (event->attr.precise_ip) {
+		struct arch_pebs_cap pebs_cap = hybrid(event->pmu, arch_pebs_cap);
+
 		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
 			return -EINVAL;
 
@@ -4046,6 +4048,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
+
+		if (x86_pmu.arch_pebs)
+			event->hw.dyn_constraint = event->attr.precise_ip >= 3 ?
+						   pebs_cap.pdists : pebs_cap.counters;
 	}
 
 	if (needs_branch_stack(event)) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 519767fc9180..615aefb4e52e 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2948,6 +2948,7 @@ static void __init intel_arch_pebs_init(void)
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
 	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
 	x86_pmu.pebs_capable = ~0ULL;
+	x86_pmu.flags |= PMU_FL_PEBS_ALL;
 
 	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
 	x86_pmu.pebs_disable = __intel_pmu_pebs_disable;
-- 
2.40.1

