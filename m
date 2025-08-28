Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695852550D5;
	Thu, 28 Aug 2025 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344987; cv=none; b=jVNsmJ+RBE9iVLLHxJhpA0HFmTKReJfKn19yyg2iI9LWOTP5u5JCvZ1+7GjPDj5lcpS+CTII37psNB6GWOkJXgbOUI5EafZ5v2AejkKCVZpDMNirpWgKcVSR8fHMCtlvl/pBZrXt882MvziuUhQIBXrLzKCOs6o2omkVmGhxd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344987; c=relaxed/simple;
	bh=xhwATnYq3JE33xz/uR/IV3tbA7L1h/+6YAF/cs/4NxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9SQIC3ovsTpKD9WI5l5kV4Gz0ELVsFeFZSecsmCTAuXLVTbGrIBzitlg5q5rxRKfrCs/fLtdEb936cD5o52F5lry+8Qy5M705nLJZMnp86ZtG7H/a2xbzRyKWPwOPm6hLCYd43VH9mUQD9Mo+MJ/FzXiDE/YX+jvaQcbvYP91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHC9Eqp8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHC9Eqp8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756344986; x=1787880986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xhwATnYq3JE33xz/uR/IV3tbA7L1h/+6YAF/cs/4NxA=;
  b=IHC9Eqp8x2zlDLk1q8lGBPg0uQ4txq0hMg9IeIQOvOggndwFDMHSnaRq
   /ZS4uM9RjF3nSDibLQevlJjp0jjHCOj1qfUOtTAsXrMbtmU7dXRG6K5r1
   zqeaXga9LsrULxQ4wJdNDgfkL/NI32hK4T1n/G1C0WdER8RxzLCbu4Uih
   w1Zs//Jhwvfz8cjGG4YCBDNeP2lE2CETxBtxBFxeU3iX5KfWSqTUkMgSy
   SR2WCtq0geaI5ZXsesZgkml/3ZojvSCY9VFeJUzKTq0QALKUSYT/Eybzt
   6CMJtUnHXclZOvLhXrkv5L/FwY3IFPlYM3fYsfT6m1fBTSqGwlH2t35Tz
   g==;
X-CSE-ConnectionGUID: 25xUNUyaRoyuZGE/W6PeDQ==
X-CSE-MsgGUID: vEpC3UKKSd2FVm7FNnpEeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61240937"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61240937"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 18:36:26 -0700
X-CSE-ConnectionGUID: CidjKJw2Qcqo2okAV54uRw==
X-CSE-MsgGUID: qIuN8K/QSIq1YhfQE70Isw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170372597"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2025 18:36:23 -0700
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
Subject: [Patch v7 10/12] perf/x86/intel: Update dyn_constranit base on PEBS event precise level
Date: Thu, 28 Aug 2025 09:34:33 +0800
Message-Id: <20250828013435.1528459-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828013435.1528459-1-dapeng1.mi@linux.intel.com>
References: <20250828013435.1528459-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/intel/core.c | 11 +++++++++++
 arch/x86/events/intel/ds.c   |  1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 41c4af6bd62c..818c197585c6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4252,6 +4252,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	}
 
 	if (event->attr.precise_ip) {
+		struct arch_pebs_cap pebs_cap = hybrid(event->pmu, arch_pebs_cap);
+
 		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
 			return -EINVAL;
 
@@ -4265,6 +4267,15 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
+
+		if (x86_pmu.arch_pebs) {
+			u64 cntr_mask = hybrid(event->pmu, intel_ctrl) &
+						~GLOBAL_CTRL_EN_PERF_METRICS;
+			u64 pebs_mask = event->attr.precise_ip >= 3 ?
+						pebs_cap.pdists : pebs_cap.counters;
+			if (cntr_mask != pebs_mask)
+				event->hw.dyn_constraint &= pebs_mask;
+		}
 	}
 
 	if (needs_branch_stack(event)) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ed9bce51182d..4217d0a5d584 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3022,6 +3022,7 @@ static void __init intel_arch_pebs_init(void)
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
 	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
 	x86_pmu.pebs_capable = ~0ULL;
+	x86_pmu.flags |= PMU_FL_PEBS_ALL;
 
 	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
 	x86_pmu.pebs_disable = __intel_pmu_pebs_disable;
-- 
2.34.1

