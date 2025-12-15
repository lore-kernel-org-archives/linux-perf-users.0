Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C093B2C0F96;
	Mon, 15 Dec 2025 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823565; cv=none; b=s/VaHhMpo5i3MV6+FVZ3uHcD6b99bAK+v1Q77CMUWy8jmTviPdG6Y3kwDysfFfhBLWIl2JhIBRYOyoPPce28C8ifQ6uBYE6X6X5h9Xmy5O2Q5BSi1nP0IZjTMDgrcJgpp6Yl7BSC4b4oqE7NDRNpLia61WpH3UIMCDzBsMqydYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823565; c=relaxed/simple;
	bh=9h02IJssGM276+xXjvWoQc0ZX85BBk/k4zT92XjL+gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAq2YMvOpMOT56nbypKaHg0VaGvXrBe+NOW/QupOvgjivphKFomhZDFTfxkeL/MO3WkwpbUIz/wUOLpYqG0AnrAvhdaGa71VBk/oyp5prqJbkPf9TsCnah4JZgnkEjHgd11NzLoXPFzbppS7axtPa8YqCxlf6Aj+oAJt91R6D0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHGDib+Q; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHGDib+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765823564; x=1797359564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9h02IJssGM276+xXjvWoQc0ZX85BBk/k4zT92XjL+gs=;
  b=bHGDib+Q3IxAnDWiB6ncSl7ycP34L/UrKGxelh9oa3yUmwG1FWm+QO8I
   rw4XZt1WzDni/C6FaYmnWhl+VWDpOAeJ1DE5AQtT6H8VwMe+uoPRIzX3U
   8VjFN7NfltTBRacRxgdaxco6X+12tMIDnbr0MFJfRacCHkc/BrZbu7v9r
   BJ9x6oF8UimKfCp3fO9LwDSs4QWsH2XHp1tEbEWrxLMHTglxdkWbkUS0h
   plZ6mfOg6dWxmYF9fBEsONEVtukPG+uz5a2vgYBGbaf572SvJALioW8Qp
   KiHTJpI4V7vENo05Gl5YipsoSy1itQ3ZjHXAX2xtVSn5f5t4UX2WoWK5j
   g==;
X-CSE-ConnectionGUID: IaP/AnkuQpawRMgxLWiyWQ==
X-CSE-MsgGUID: kQ1wa2yWQTGq56vE5gl4Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67697555"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="67697555"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 10:32:43 -0800
X-CSE-ConnectionGUID: LBRBVTGIQf+0cOrqE+P8tQ==
X-CSE-MsgGUID: HvAHz4qsQCCAekbEe6l5cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="197547942"
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
Subject: [PATCH 1/3] perf/x86/intel/cstate: Add Wildcat Lake support
Date: Mon, 15 Dec 2025 10:25:18 -0800
Message-ID: <20251215182520.115822-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wildcat Lake (WCL) is a low-power variant of Panther Lake.  From a
C-state profiling perspective, it supports the same residency counters:
CC1/CC6/CC7 and PC2/PC6/PC10.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/cstate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index fa67fda6e45b..b719b0a68a2a 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF,GRR,ARL,LNL,PTL
+ *					  MTL,SRF,GRR,ARL,LNL,PTL,WCL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -53,19 +53,19 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						GRR,ARL,LNL,PTL
+ *						GRR,ARL,LNL,PTL,WCL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
  *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL,
- *						PTL
+ *						PTL,WCL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL,ARL,LNL,SRF,PTL
+ *						RPL,SPR,MTL,ARL,LNL,SRF,PTL,WCL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -78,7 +78,7 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						ARL,LNL,PTL
+ *						ARL,LNL,PTL,WCL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -97,7 +97,8 @@
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL,ADL,RPL,MTL,ARL,LNL,PTL
+ *						TNT,RKL,ADL,RPL,MTL,ARL,LNL,PTL,
+ *						WCL
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
@@ -654,6 +655,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_cstates),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&lnl_cstates),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,	&lnl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.52.0

