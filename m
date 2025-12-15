Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623D2E8B75;
	Mon, 15 Dec 2025 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823567; cv=none; b=Jz73PdxVpCKHYydU7ECS9cyoMUJGPcg1jXLbKsLpmKiEIDMh35zumlnnvhSNN1WMO+NanbsHa+00W0NO8cNDROhDlPKRRRh6TBDXDdzZKPcY4KVHoNAVqHHijv+XfFvpMxL4+IUdNtOKtn/dY1O4YmKr7VpiRveCOoXT7Epk0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823567; c=relaxed/simple;
	bh=PhsDg/wOOlYxt7L7an+aypeyHc+6lLG6L2ogGgmH3Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeHNmQowYFItLLRv1g1+RiQ+xgS6ulpbQ9yZZlzJ4JAsiqKEpHLboOJnHNKAWQv5r/zg3G/iWrnewIj4u7c7UFCdFtRkKaNblGhbHfd2wJnDmhb+btNpsy+eCLPSUD3kRX80s+cISeJhDKxTDBxfkGJ3ZgGLwxA4I84tDBQzo3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCD/oq7K; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCD/oq7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765823567; x=1797359567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PhsDg/wOOlYxt7L7an+aypeyHc+6lLG6L2ogGgmH3Rc=;
  b=mCD/oq7KHF0kyZT9GnGP5NZCbB1Khsapjau38dpXg246GNP2NYFxYVMK
   uyaVQOm8c0n804blKXmxdtFlGoQ6N91P0OPg+YwusnSebF9jURDjysc95
   hYfH9rHnPseTQDUp55Y6iqcvPJcCDFUZyyHOGCcpLWu3yDL5w4NPn35T6
   xMVuEfpzfmc5Zs+DfLJ9elw0xrPAKyc+nbXr8KyLEuAja/EMheFRSQiiY
   bm+BNjLW6iz+4hYOygVsd5tKSa/+xwPJxuzI6l4pio1fIUMwgbRXVDSmR
   WYVFg/kkBThopGxp3kmTRjEH+Ix45h+Q9qtu5xoTQXGhd31+sFsSuHtp6
   Q==;
X-CSE-ConnectionGUID: N3yi06cPRK2Rnou1YfQ1Bg==
X-CSE-MsgGUID: Y8ntcDoGTYCCftNV0mb/QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67697561"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="67697561"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 10:32:43 -0800
X-CSE-ConnectionGUID: yHkFVY/ES42sWkpYhF/06A==
X-CSE-MsgGUID: JABZeudTQmSeI5cSauumKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="197547945"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 10:32:42 -0800
From: Zide Chen <zide.chen@intel.com>
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
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH 2/3] perf/x86/intel/cstate: Add Nova Lake support
Date: Mon, 15 Dec 2025 10:25:19 -0800
Message-ID: <20251215182520.115822-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215182520.115822-1-zide.chen@intel.com>
References: <20251215182520.115822-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to Lunar Lake and Panther Lake, Nova Lake supports CC1/CC6/CC7
and PC2/PC6/PC10 residency counters; it also adds support for MC6.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/cstate.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index b719b0a68a2a..008f8ea59315 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF,GRR,ARL,LNL,PTL,WCL
+ *					  MTL,SRF,GRR,ARL,LNL,PTL,WCL,NVL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -53,19 +53,20 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						GRR,ARL,LNL,PTL,WCL
+ *						GRR,ARL,LNL,PTL,WCL,NVL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
  *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL,
- *						PTL,WCL
+ *						PTL,WCL,NVL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL,ARL,LNL,SRF,PTL,WCL
+ *						RPL,SPR,MTL,ARL,LNL,SRF,PTL,WCL,
+ *						NVL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -78,7 +79,7 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						ARL,LNL,PTL,WCL
+ *						ARL,LNL,PTL,WCL,NVL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -98,11 +99,11 @@
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
  *						TNT,RKL,ADL,RPL,MTL,ARL,LNL,PTL,
- *						WCL
+ *						WCL,NVL
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
- *			       Available model: SRF,GRR
+ *			       Available model: SRF,GRR,NVL
  *			       Scope: A cluster of cores shared L2 cache
  *
  */
@@ -528,6 +529,18 @@ static const struct cstate_model lnl_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
+static const struct cstate_model nvl_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES) |
+				  BIT(PERF_CSTATE_CORE_C7_RES),
+
+	.module_events		= BIT(PERF_CSTATE_MODULE_C6_RES),
+
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES) |
+				  BIT(PERF_CSTATE_PKG_C10_RES),
+};
+
 static const struct cstate_model slm_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
@@ -656,6 +669,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_cstates),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&lnl_cstates),
 	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,	&lnl_cstates),
+	X86_MATCH_VFM(INTEL_NOVALAKE,		&nvl_cstates),
+	X86_MATCH_VFM(INTEL_NOVALAKE_L,		&nvl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.52.0

