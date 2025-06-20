Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45455229B29;
	Fri, 20 Jun 2025 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404577; cv=none; b=FF1E0SDLhk0hBocMWLZr4X5yIglEX07ZzhM8e4pBgVA++wws8FcQuILb4E/HEAaslPXEsgAhq4qaiocdB8PI4prM5ACXM3Im6sULzgN08kN5rjpJkfiy5o/PEehiYHra7mNkybEXe34w9X68PhD+ECQmALEt9UTeMmx6e/KFhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404577; c=relaxed/simple;
	bh=FdLKjriQbeodnad0w+4f5569bHFWgZk4vPWeQQc6NHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaNR0ws12LdzgHZt9orF5xoeGh4cV5b7hdN3brVGoXzLl64mEBLeC3tM0VhtOHumhyliRWlbaUGBe2yH/jZvI8fILdWP2xdVzgZao2mScNwIcIftohblH6iX9J/gby45BDHhCzKIa0vpWrGOukaCVBq0CeXLz0FqhKpskidZpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5YDceZU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5YDceZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750404576; x=1781940576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FdLKjriQbeodnad0w+4f5569bHFWgZk4vPWeQQc6NHE=;
  b=J5YDceZUbzY7GJApGPOT9ju2enZyxNHTB40dwJdDMCGXN58cpPY5+wVn
   K42Rp7XICi6CIMZVg/ZyPmXBLe6aWlHjssfzsY1pE5m1MO13EZ0xYFIOV
   Yn8UC6/4HnBUWQpj+2ujdcr6jDyXCRpqEvKHqabRsJL7diEDzzYuk9pVw
   qVx6rGO3L0uzi9nqtwlc2QUHtPSbSkfbbqQi+QkQr0sZLDaDreKpFbTm+
   9LuP0gI0lfIogcPCSiS3OE4QqntRcMGCXU1qO1w0jwVLCHr+trMBSgfWb
   uf3WJ0AtcaR2usbjuZTA6TbcW5X/CQ4Beg9CJ9geoL//h6Z/d/ywg+ugp
   g==;
X-CSE-ConnectionGUID: QaDWpyDDTF+2gyV1JfPNRg==
X-CSE-MsgGUID: fFjDlNgPQaaPKSwhkRRUVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51887782"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="51887782"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 00:29:36 -0700
X-CSE-ConnectionGUID: QWXA5CHgT2+ez6LjituEww==
X-CSE-MsgGUID: ik8N5zvKSUaiifKzVOTcPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="156651045"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 00:29:33 -0700
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
Subject: [Patch v4 08/13] perf/x86/intel: Update dyn_constranit base on PEBS event precise level
Date: Fri, 20 Jun 2025 10:39:04 +0000
Message-ID: <20250620103909.1586595-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
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
index 5e6ef9f3a077..00b41c693d13 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4255,6 +4255,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	}
 
 	if (event->attr.precise_ip) {
+		struct arch_pebs_cap pebs_cap = hybrid(event->pmu, arch_pebs_cap);
+
 		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
 			return -EINVAL;
 
@@ -4268,6 +4270,15 @@ static int intel_pmu_hw_config(struct perf_event *event)
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
index 72b925b8c482..30915338b929 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2987,6 +2987,7 @@ static void __init intel_arch_pebs_init(void)
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
 	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
 	x86_pmu.pebs_capable = ~0ULL;
+	x86_pmu.flags |= PMU_FL_PEBS_ALL;
 
 	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
 	x86_pmu.pebs_disable = __intel_pmu_pebs_disable;
-- 
2.43.0

