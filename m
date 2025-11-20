Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4F3002CE;
	Thu, 20 Nov 2025 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763617028; cv=none; b=ccbUhcWVSU9zV80dQzHYYaEIoMdmNhXYOcaO71/L7085IPwe3jat/qGJLqjcgp7fFZazwUffkkC7ux/GN3H7LqORgr/jjZZn+//YU8xC2Zenhb2+6RjeSukuoGQ7jq+w+MvGEF4ikfLv5o99DCgmdY0iZzx9e+QJ0fEj/YrubOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763617028; c=relaxed/simple;
	bh=mxmtB5LHf+KKSdJFHtNgNUq3nDPZqEkLcEPvhZhRNmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCFx/bx6tF6jVYlPhpGmY1ZrUyeTf+eWbBIf6hNFd6mSxvxVCJMr9bDCm3W2QMB6jhveNOzBeuUqjSux1j5dVkYpsOfclm0dvfuXzDPsYXZbKghK6agRIRVFuGAhKs4MwaiuiQl15rX8XQ9keroqt349xlEOZEG5YmVV3+Nvi7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Swf/pdUt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Swf/pdUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763617026; x=1795153026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mxmtB5LHf+KKSdJFHtNgNUq3nDPZqEkLcEPvhZhRNmA=;
  b=Swf/pdUt33GyZ2ftYH2/FvS6FKjxO5u69zXfaCkkCFl8xw8/kkfz0V3Q
   8OmAzRuTsYqJX2tcGo3JdlXWRfPm+umrUmXeAQwXWb5XMUEpLtMg0f2DR
   YgLjkcAN7pywU0ffyPV4lVcZsN4Se0+6sUi6DkKGlldUeffq70Pf5HZj0
   79VEvTonSizb5hSyfqTo+fHsP2Ny/JjYQOaPgZ78LSCjnriDM7cqgD7t5
   hf3Y3LvFSbvsipC0qDGgs5l2uWgP/CYIPBSl+kJpdNa+0otN8A8m/570E
   U14ST/4q2HjXqNGey6RhRtAhwMf1tql4I+lJSc1CZAth3yDX/DLvmBZE5
   A==;
X-CSE-ConnectionGUID: Pag2Yc0hTDyPusKaFKhqGg==
X-CSE-MsgGUID: qC1HBc26SLW+T7fozX99lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65710149"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65710149"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 21:37:05 -0800
X-CSE-ConnectionGUID: GU14klhDQNCFYErxadC4og==
X-CSE-MsgGUID: DitVtM4PRp2xnU+7SH7lsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="191055523"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Nov 2025 21:37:02 -0800
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
Subject: [PATCH 1/7] perf/x86/intel: Support newly introduced 4 OMR MSRs for DMR & NVL
Date: Thu, 20 Nov 2025 13:34:25 +0800
Message-Id: <20251120053431.491677-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
References: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Diamond Rapids and Nova Lake feature an expanded facility called
the Off-Module Response (OMR) facility, which replaces the Off-Core
Response (OCR) Performance Monitoring of previous processors.

Legacy microarchitectures used the OCR facility to evaluate off-core
and multi-core off-module transactions. The properly renamed, OMR
facility, improves the OCR capability for scalable coverage of new
memory systems of multi-core module systems.

Similarly with OCR, 4 additional off-module configuration MSRs
OFFMODULE_RSP_0 ~ OFFMODULE_RSP_3 are introduced to specify
attributes of the off-module transaction.

For more details about OMR, please refer to section 16.1 "OFF-MODULE
 RESPONSE (OMR) FACILITY" in ISE documentation.

This patch adds support for these 4 OMR events.

ISE link: https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c     | 45 +++++++++++++++++++++++---------
 arch/x86/events/perf_event.h     |  5 ++++
 arch/x86/include/asm/msr-index.h |  5 ++++
 3 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index aad89c9d9514..5970f7c20101 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3529,17 +3529,24 @@ static int intel_alt_er(struct cpu_hw_events *cpuc,
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
+		if (config &
+		    ~extra_regs[alt_idx - EXTRA_REG_OMR_0].valid_mask)
+			return idx;
+	}
 
 	return alt_idx;
 }
@@ -3547,16 +3554,28 @@ static int intel_alt_er(struct cpu_hw_events *cpuc,
 static void intel_fixup_er(struct perf_event *event, int idx)
 {
 	struct extra_reg *extra_regs = hybrid(event->pmu, extra_regs);
-	event->hw.extra_reg.idx = idx;
+	int omr_idx;
 
-	if (idx == EXTRA_REG_RSP_0) {
+	event->hw.extra_reg.idx = idx;
+	switch (idx) {
+	case EXTRA_REG_RSP_0:
 		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
 		event->hw.config |= extra_regs[EXTRA_REG_RSP_0].event;
 		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_0;
-	} else if (idx == EXTRA_REG_RSP_1) {
+		break;
+	case EXTRA_REG_RSP_1:
 		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
 		event->hw.config |= extra_regs[EXTRA_REG_RSP_1].event;
 		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_1;
+		break;
+	case EXTRA_REG_OMR_0 ... EXTRA_REG_OMR_3:
+		omr_idx = idx - EXTRA_REG_OMR_0;
+		event->hw.config &= ~ARCH_PERFMON_EVENTSEL_UMASK;
+		event->hw.config |= 1ULL << (8 + omr_idx);
+		event->hw.extra_reg.reg = MSR_OMR_0 + omr_idx;
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
index 65cc528fbad8..170cece31e3c 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -259,6 +259,11 @@
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

