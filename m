Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B73596EE;
	Wed, 29 Oct 2025 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733503; cv=none; b=XKNZFHVeeb71I6Xzuc2VnXEK6W+mEE1JFuyIIp5iMvqV39zpwpyzydkuQBLuzf6a5XzLW3m7MCWYNYxlxDNMsCknTszQaw/axRV8H3p8QW2vBHDQQq3vKdHzfKNIt84sXmqJYG8h3t5sVpWja7AS7BMf4QphKyVDEwcGC/e+oG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733503; c=relaxed/simple;
	bh=cYyNaAksI+D/C3feVrPf1ESBa8xCmdPN8oY1e3XJyMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDj5F10QePrZP3YFRr9VV4s/suVnsX5s4nYPO2p4MHBETKI+vb/VNKoEYYdbUqDH39iqgdK3JSOVvUVmUcbNip3lV8FlH6/wbvDv2aouPzLp6hPcYMGjenlem8D9u/rY0JymtHlV/0s7ZEqIUAz55BeZdckhkDNc10Av+wQ84cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J90OgtVd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J90OgtVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761733502; x=1793269502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cYyNaAksI+D/C3feVrPf1ESBa8xCmdPN8oY1e3XJyMY=;
  b=J90OgtVd41lueKowFeHQuLMwTzG8K/OCrCW9pyw3RwqU3BNS6qtjKDEC
   kbjQ1AOOS93yV+RaflfWOLfyzNh3ICApFXp9VKNpO8NkXaIVj6bcUh9Am
   Rju6Sy9qXPFK3BNTa+0fLkeUECpVjF/Meijs+JMd0o0EFtHs/x7JEZlY3
   Rh9aDjpOXtYqP9qqWZ/i2AJUSiiVtwDN/IwrTUUHAc53Oq79owPZ0wBVS
   6em7700NaXp8CEs+1BUJCJyyC31BGtm7jC9kCVXe6KKoXyY/92QkPjluW
   omXnNXWXwaTUZ9NB4AuJaBUsrcrWfAdQhf7eRaT9Jar5bR37gOTAc7OG2
   w==;
X-CSE-ConnectionGUID: WBVqnEP/TCKE2t/dQhh4XQ==
X-CSE-MsgGUID: Zc739aFQQoSlUQJ1J2oVEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="63891059"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63891059"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 03:25:01 -0700
X-CSE-ConnectionGUID: 5+XPOq5mTeiwfxY6R8haFw==
X-CSE-MsgGUID: oXMPmBtuTiS0DgzCqckMXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185963463"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 29 Oct 2025 03:24:57 -0700
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
Subject: [Patch v9 10/12] perf/x86/intel: Update dyn_constranit base on PEBS event precise level
Date: Wed, 29 Oct 2025 18:21:34 +0800
Message-Id: <20251029102136.61364-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
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
index 6e04d73dfae5..40ccfd80d554 100644
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
index 5c26a5235f94..1179980f795b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3005,6 +3005,7 @@ static void __init intel_arch_pebs_init(void)
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
 	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
 	x86_pmu.pebs_capable = ~0ULL;
+	x86_pmu.flags |= PMU_FL_PEBS_ALL;
 
 	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
 	x86_pmu.pebs_disable = __intel_pmu_pebs_disable;
-- 
2.34.1

