Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4837F014;
	Fri, 15 May 2026 06:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825809; cv=none; b=IdQ9vk/kDWB2gzM5WeAB/4COn1LM7oBm3UN7pThqlcI6Gv8I62wzy+pAOW8YTTVmE+s5rGg9aqT1eRpaasDQ4U4jlf7lnMTBxD72QjIUH2DwfD1cVsvATH8AGVyeGKJ023E23GL45AI5ttt73f5qjkAhaL6hawI447rWghmbGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825809; c=relaxed/simple;
	bh=xwPL4Kr/o8xCWQY7+QX7Aj9RxUaVMAVhHTAZjBRrp00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HiV6K8kuasdTK750KFe0JQu8HA2aIhxUL5s91P025CGkhzAtsAYdDIwRQdLyZUJFiK6C1CsfzzXgmCm+LEfsJAxHRXl4BOpR2ClrtvyBMVf9tjIYO5XMee895jByqdJeFgHeCwjSqqThCxouynuP3T2yuPWed2Pj7AiMq8gCNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGAz5F5M; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGAz5F5M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825808; x=1810361808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xwPL4Kr/o8xCWQY7+QX7Aj9RxUaVMAVhHTAZjBRrp00=;
  b=GGAz5F5MQ9/mGv0BFw0ofUxcC+S39C9S6AEhtF/XiEsKCUQz0JeKwCrJ
   ak83yPkpau8z6D8E2zZAurfbmMbd0hKgTCz31BJODUPVVZFCkwIFsBunT
   BxOVmNr0oM7eF9dUx7kGclvZBjb06vWqeI2Wi3IwdaSSjsW6oZpmSUE9W
   V+i9e4CnXZrcovjZjFhOF0ESoQCemvSRQtG8a9aQqBr5vSQx1GtD8M23R
   aez+xjxA58v17FIEPjdxT4ttH0M+srOP+7V66NjmtumSLOhPfBIRCVWNk
   3khpZaDrd9zyETLRNZeEISseME/SZJQeKhei84koiXQnQBnSiLflaKHBC
   Q==;
X-CSE-ConnectionGUID: QBFJKH8jRv6HHHIMAe4sxw==
X-CSE-MsgGUID: cPuTjqIRTwuDpHjWLMIlJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79635912"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79635912"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:16:48 -0700
X-CSE-ConnectionGUID: Y6ZmHeOATziScyKQjInnjw==
X-CSE-MsgGUID: 34P+8V19Rc62fXmJN4n3ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="235968411"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2026 23:16:44 -0700
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
Subject: [PATCH 02/11] perf/x86/intel: Update event constraints and cache_extra_regs[] for SPR
Date: Fri, 15 May 2026 14:11:34 +0800
Message-Id: <20260515061143.338553-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
References: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update perf hard-coded event constraints and cache_extra_regs[] for
Sapphire rapids according to the latest SPR perfmon events (v1.39).

Emerald Rapids (EMR) and Granite Rapids (GNR) share exactly same event
constraints and extra MSR values with SPR. No extra changes are needed
for EMR and GNR.

Please note the change could temporarily impact other platforms which
share the hard coded data structures, but it would be fixed in
subsequent patches soon.

SPR perfmon events:
https://github.com/intel/perfmon/blob/main/SPR/events/sapphirerapids_core.json

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1390d1da985b..b3ccc785a4f6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -356,11 +356,12 @@ static struct extra_reg intel_glc_extra_regs[] __read_mostly = {
 
 static struct event_constraint intel_glc_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
-	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* pseudo INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
-	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x0200, 1),	/* pseudo CPU_CLK_UNHALTED.THREAD */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* pseudo CPU_CLK_UNHALTED.REF_TSC */
 	FIXED_EVENT_CONSTRAINT(0x013c, 2),	/* CPU_CLK_UNHALTED.REF_TSC_P */
-	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* pseudo TOPDOWN.SLOTS */
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
@@ -380,9 +381,13 @@ static struct event_constraint intel_glc_event_constraints[] = {
 
 	INTEL_UEVENT_CONSTRAINT(0x01a3, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x02a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x05a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x06a3, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x08a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x0ca3, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x01cd, 0xfe),
 	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x1),
 	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
 	INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xdf, 0xf),
@@ -714,18 +719,18 @@ static __initconst const u64 glc_hw_cache_extra_regs
 {
  [ C(LL  ) ] = {
 	[ C(OP_READ) ] = {
-		[ C(RESULT_ACCESS) ] = 0x10001,
-		[ C(RESULT_MISS)   ] = 0x3fbfc00001,
+		[ C(RESULT_ACCESS) ] = 0x10001,		/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0x3fbfc00001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
 	},
 	[ C(OP_WRITE) ] = {
-		[ C(RESULT_ACCESS) ] = 0x3f3ffc0002,
-		[ C(RESULT_MISS)   ] = 0x3f3fc00002,
+		[ C(RESULT_ACCESS) ] = 0x3f3ffc0002,	/* OCR.DEMAND_RFO.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0x3f3fc00002,	/* OCR.DEMAND_RFO.L3_MISS */
 	},
  },
  [ C(NODE) ] = {
 	[ C(OP_READ) ] = {
-		[ C(RESULT_ACCESS) ] = 0x10c000001,
-		[ C(RESULT_MISS)   ] = 0x3fb3000001,
+		[ C(RESULT_ACCESS) ] = 0x104000001,	/* OCR.DEMAND_DATA_RD.LOCAL_DRAM */
+		[ C(RESULT_MISS)   ] = 0x730000001,	/* OCR.DEMAND_DATA_RD.REMOTE_DRAM */
 	},
  },
 };
-- 
2.34.1

