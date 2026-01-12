Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847E30EF94;
	Mon, 12 Jan 2026 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768195218; cv=none; b=NoBYWubzsVB2ujZQtRrsT5gdETW6+FehtZ+PaDhNrAkm+6VulRaqlHdi6B2fTvUWXB8aBcc+fa3m5Ejd00x54746TOUN9kZudOLBm8fGcVXeW8hrXZkDHwsoK9e5FaEhfRDLWZl+1rTjy2DJtWtZEh2wAg96Nz75nJNcDWr7PTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768195218; c=relaxed/simple;
	bh=mD4cUKeT80Gmm4SvuP3lmdsk/KPKwm5ADKsv7AVp93k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B0akzEltkM2k5Dy6CuZlhVwvr3Il2S8J4nsTJaR0Kjo/FWMYOKZ8pRVeRDS2/2U+Ljb+bo79UJ1xcsavogSCe/5CbCQnxMLZVDmVa6x39rz4vSDEdkjD3VAgqJu8jxh1YnW8KjRnmHs7AzkdNmrhb7i2mKnvqXvyhER5us9k6dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAGekp/y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAGekp/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768195216; x=1799731216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mD4cUKeT80Gmm4SvuP3lmdsk/KPKwm5ADKsv7AVp93k=;
  b=hAGekp/yubQohzcvSnNTfAMYhOitxORdO0G3eEHmrq0xnWItxTbnVDnZ
   t/X5XGstBdNQqtPOizX/Yutbf1jV8NXHCymj+9LLEgYm8gPJKCZ9kFuph
   VyPo7gvSFZ/4OHbDfkhsssky1RENuNtQYsUKZgWumeBvc2Yo/Rr3633Ao
   wp14O1KWJWGt69JCC/DAbvlaGHudZu6yBp+ksOiW7b/077wWeiVmpr5CZ
   L3a6/05u6t0zmWk4sR2B/Bl90EUESaPfOh41pvQBExGjE+1q8IU1BeoAd
   HiG6HgDltb8JzymnXPW6vjZAUe5nPu8m05caCf3YxfE0fzJLnAyScopeS
   w==;
X-CSE-ConnectionGUID: VZ+UrKHSRfmp+tTLbT7gUQ==
X-CSE-MsgGUID: /yfBdoaQR1KUWzpVxmnh9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="68673213"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="68673213"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 21:20:16 -0800
X-CSE-ConnectionGUID: MAbXLbs0RUO/C1pd8Pq+Bg==
X-CSE-MsgGUID: iHbo50JDTIqOmxUa9f1KEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="235233378"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 11 Jan 2026 21:20:13 -0800
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
Subject: [Patch v2 1/7] perf/x86/intel: Support the 4 new OMR MSRs introduced in DMR and NVL
Date: Mon, 12 Jan 2026 13:16:43 +0800
Message-Id: <20260112051649.1113435-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Diamond Rapids (DMR) and Nova Lake (NVL) introduce an enhanced
Off-Module Response (OMR) facility, replacing the Off-Core Response (OCR)
Performance Monitoring of previous processors.

Legacy microarchitectures used the OCR facility to evaluate off-core and
multi-core off-module transactions. The newly named OMR facility improves
OCR capabilities for scalable coverage of new memory systems in
multi-core module systems.

Similar to OCR, 4 additional off-module configuration MSRs
(OFFMODULE_RSP_0 to OFFMODULE_RSP_3) are introduced to specify attributes
of off-module transactions. When multiple identical OMR events are
created, they need to occupy the same OFFMODULE_RSP_x MSR. To ensure
these multiple identical OMR events can work simultaneously, the
intel_alt_er() and intel_fixup_er() helpers are enhanced to rotate these
OMR events across different OFFMODULE_RSP_* MSRs, similar to previous OCR
events.

For more details about OMR, please refer to section 16.1 "OFF-MODULE
 RESPONSE (OMR) FACILITY" in ISE documentation.

ISE link: https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

v2: Optimize intel_fixup_er().

 arch/x86/events/intel/core.c     | 55 +++++++++++++++++++++-----------
 arch/x86/events/perf_event.h     |  5 +++
 arch/x86/include/asm/msr-index.h |  5 +++
 3 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1840ca1918d1..6ea3260f6422 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3532,17 +3532,28 @@ static int intel_alt_er(struct cpu_hw_events *cpuc,
 	struct extra_reg *extra_regs = hybrid(cpuc->pmu, extra_regs);
 	int alt_idx = idx;
 
-	if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
-		return idx;
-
-	if (idx == EXTRA_REG_RSP_0)
-		alt_idx = EXTRA_REG_RSP_1;
-
-	if (idx == EXTRA_REG_RSP_1)
-		alt_idx = EXTRA_REG_RSP_0;
+	if (idx == EXTRA_REG_RSP_0 || idx == EXTRA_REG_RSP_1) {
+		if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
+			return idx;
+		if (++alt_idx > EXTRA_REG_RSP_1)
+			alt_idx = EXTRA_REG_RSP_0;
+		if (config & ~extra_regs[alt_idx].valid_mask)
+			return idx;
+	}
 
-	if (config & ~extra_regs[alt_idx].valid_mask)
-		return idx;
+	if (idx >= EXTRA_REG_OMR_0 && idx <= EXTRA_REG_OMR_3) {
+		if (!(x86_pmu.flags & PMU_FL_HAS_OMR))
+			return idx;
+		if (++alt_idx > EXTRA_REG_OMR_3)
+			alt_idx = EXTRA_REG_OMR_0;
+		/*
+		 * Subtracting EXTRA_REG_OMR_0 ensures to get correct
+		 * OMR extra_reg entries which start from 0.
+		 */
+		if (config &
+		    ~extra_regs[alt_idx - EXTRA_REG_OMR_0].valid_mask)
+			return idx;
+	}
 
 	return alt_idx;
 }
@@ -3550,16 +3561,24 @@ static int intel_alt_er(struct cpu_hw_events *cpuc,
 static void intel_fixup_er(struct perf_event *event, int idx)
 {
 	struct extra_reg *extra_regs = hybrid(event->pmu, extra_regs);
-	event->hw.extra_reg.idx = idx;
+	int er_idx;
 
-	if (idx == EXTRA_REG_RSP_0) {
-		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
-		event->hw.config |= extra_regs[EXTRA_REG_RSP_0].event;
-		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_0;
-	} else if (idx == EXTRA_REG_RSP_1) {
+	event->hw.extra_reg.idx = idx;
+	switch (idx) {
+	case EXTRA_REG_RSP_0 ... EXTRA_REG_RSP_1:
+		er_idx = idx - EXTRA_REG_RSP_0;
 		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
-		event->hw.config |= extra_regs[EXTRA_REG_RSP_1].event;
-		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_1;
+		event->hw.config |= extra_regs[er_idx].event;
+		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_0 + er_idx;
+		break;
+	case EXTRA_REG_OMR_0 ... EXTRA_REG_OMR_3:
+		er_idx = idx - EXTRA_REG_OMR_0;
+		event->hw.config &= ~ARCH_PERFMON_EVENTSEL_UMASK;
+		event->hw.config |= 1ULL << (8 + er_idx);
+		event->hw.extra_reg.reg = MSR_OMR_0 + er_idx;
+		break;
+	default:
+		pr_warn("The extra reg idx %d is not supported.\n", idx);
 	}
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3161ec0a3416..586e3fdfe6d8 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -45,6 +45,10 @@ enum extra_reg_type {
 	EXTRA_REG_FE		= 4,  /* fe_* */
 	EXTRA_REG_SNOOP_0	= 5,  /* snoop response 0 */
 	EXTRA_REG_SNOOP_1	= 6,  /* snoop response 1 */
+	EXTRA_REG_OMR_0		= 7,  /* OMR 0 */
+	EXTRA_REG_OMR_1		= 8,  /* OMR 1 */
+	EXTRA_REG_OMR_2		= 9,  /* OMR 2 */
+	EXTRA_REG_OMR_3		= 10,  /* OMR 3 */
 
 	EXTRA_REG_MAX		      /* number of entries needed */
 };
@@ -1099,6 +1103,7 @@ do {									\
 #define PMU_FL_RETIRE_LATENCY	0x200 /* Support Retire Latency in PEBS */
 #define PMU_FL_BR_CNTR		0x400 /* Support branch counter logging */
 #define PMU_FL_DYN_CONSTRAINT	0x800 /* Needs dynamic constraint */
+#define PMU_FL_HAS_OMR		0x1000 /* has 4 equivalent OMR regs */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3d0a0950d20a..6d1b69ea01c2 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -263,6 +263,11 @@
 #define MSR_SNOOP_RSP_0			0x00001328
 #define MSR_SNOOP_RSP_1			0x00001329
 
+#define MSR_OMR_0			0x000003e0
+#define MSR_OMR_1			0x000003e1
+#define MSR_OMR_2			0x000003e2
+#define MSR_OMR_3			0x000003e3
+
 #define MSR_LBR_SELECT			0x000001c8
 #define MSR_LBR_TOS			0x000001c9
 
-- 
2.34.1

