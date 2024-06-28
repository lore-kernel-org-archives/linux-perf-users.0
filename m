Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9F914A85;
	Fri, 28 Jun 2024 03:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544705; cv=none; b=XL4dsn8Cm9p2wYvSl9im7Qmcs/1oP8mCR8f2Rk0JHakIyj76zQ1X92kEILVoDU4LiGDxsxFKhbEfYzmAnY0TBNZowKoB7LAZtMrzqq+tSMEmmtQGgiW7SlV9wfAnQKRwqxKu4llKCRSBn7DJukkCiP1ZJCUFjco+xCYeaQ5B9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544705; c=relaxed/simple;
	bh=m75iibZvsPzksbrW9Ki8c0hJBr9cy7PUnjmnyWnDKWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bi+h9BDOCLwPX+BdEmij0oW8lh00mKJ8FYyqmjAetCJPtjIWNPGYXFLZ+cP3KmUeP16olPh3C+Z0fxeKBGUOR1wG+b4NURHsamoKkjKEx6OdaUVVgE+4bGGG+1cI6gtABV6D7rXnQ6WFGNDVRn0rZmCW7u+DP3wmsU5pC1HbKZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyOPWCj+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyOPWCj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719544704; x=1751080704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m75iibZvsPzksbrW9Ki8c0hJBr9cy7PUnjmnyWnDKWM=;
  b=XyOPWCj+Zt7H46e21Cd7p2LA1CR+VatTN7yZOq/puI6zH19HrnxZx/lX
   VZldAcWoWkkspmdI6ilFZZlRRX4Z4YgpcqRI7T05RYF//lCMVgxEkIqbq
   rwKHWYZ2LEeUNKBm9tIdKHsVWrSUyLU2gZBF3+Aa6bmMDRvPExacj3mfU
   IoE5yDkmjrIgw2/B02G8LuqlkVN74BW2IQpig9qk3Dks+Ve1t6FZUbMKD
   BY3Wuwt1Vqg6hYoK+jqi6CdnQLBsPpY7ISAyfQ8Bmwgruexevpov7+0uC
   EZywCOvWaYw+2+Wjp3tYOg6LUp7mC6ywBvfWxmHWRTDckxGlZGfqOiH4O
   Q==;
X-CSE-ConnectionGUID: jsDfGA7IQ2SVUBHHmS2O0Q==
X-CSE-MsgGUID: j9cjIrJ2QE2vnVJV/RZvcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16669280"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16669280"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 20:18:22 -0700
X-CSE-ConnectionGUID: iyU+myySRFCMfVq9t4/F3g==
X-CSE-MsgGUID: fT0Rvl1ET0qi3cDt49PjBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44657152"
Received: from lizhipe3-mobl1.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.249.171.174])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 20:18:18 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ak@linux.intel.com,
	kan.liang@linux.intel.com
Subject: [PATCH V2 3/3] perf/x86/intel/cstate: Add Lunarlake support
Date: Fri, 28 Jun 2024 11:17:58 +0800
Message-Id: <20240628031758.43103-4-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628031758.43103-1-rui.zhang@intel.com>
References: <20240628031758.43103-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared with previous client platforms, PC8 is removed from Lunarlake.
It supports CC1/CC6/CC7 and PC2/PC3/PC6/PC10 residency counters.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index cb165af1a1bf..be58cfb012dd 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF,GRR,ARL
+ *					  MTL,SRF,GRR,ARL,LNL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -53,31 +53,31 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						GRR,ARL
+ *						GRR,ARL,LNL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL,RKL,ADL,RPL,MTL,ARL
+ *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL,ARL
+ *						RPL,SPR,MTL,ARL,LNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL,RPL,MTL,ARL
+ *						ADL,RPL,MTL,ARL,LNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						ARL
+ *						ARL,LNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -96,7 +96,7 @@
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL,ADL,RPL,MTL,ARL
+ *						TNT,RKL,ADL,RPL,MTL,ARL,LNL
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
@@ -641,6 +641,17 @@ static const struct cstate_model adl_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
+static const struct cstate_model lnl_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES) |
+				  BIT(PERF_CSTATE_CORE_C7_RES),
+
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C3_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES) |
+				  BIT(PERF_CSTATE_PKG_C10_RES),
+};
+
 static const struct cstate_model slm_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
@@ -764,6 +775,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&adl_cstates),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.34.1

