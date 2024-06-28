Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117361CFBE;
	Fri, 28 Jun 2024 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544703; cv=none; b=FISNvMeDsk/TXDt9Cc/AmuB/pX2RNZ2dc0FdrwB46fDKIfbtM8ONT4XB990peFflo2Le2+kS0yGfH62SvNf8MG+T0gG1X3lv4KtnizGTxwrpYE3Wz6p2EFxzA8Zn96q77HCIwrR9btk0/yP1H1nuTxDLB7SwaZftGOJs4qOUq08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544703; c=relaxed/simple;
	bh=fR4rJ1nfUbYUgINIS+3DSOrkTMOKNrCV8SIFBABuWf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pq11Y40GDtdB253musBB5ZuDuv9v/V0Ik88GhiSwqbUM3Xen9wxW+9mo4RR1D94QvMDxQ0YH12FpzFfWFAF0jmbmLcHjxrslf+9wl4yynMqOqoDkEO+WcecQxWw8jAC4qU0igKqWD/s8/6Bv3XhKYazmLQ5OLY7vhy8nUfsFJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EN8G3TBp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EN8G3TBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719544703; x=1751080703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fR4rJ1nfUbYUgINIS+3DSOrkTMOKNrCV8SIFBABuWf4=;
  b=EN8G3TBpTftMsdShaAcEJnDLuINpA65BZN7zRTL0XSO3rHtQJNyVsa13
   aOmurFt8vXYF4fpCCgPkt5uavdUfa4CbmZxVx+AgafVKv3X/r7WUWEEqB
   1daWcLRf+6K/XlrfYhOTTK9HR8dKJ2zBNQoIHP8yMVjn7qOyRe07FWC5n
   0GZvz2abkgutXO92oCTnFBaGJEti3/VOuDS6CP/ca8KDFKKYMyHBq59EX
   kL86EG65L3jj4iUuui0DrTGzm0o28W+hVtTOBahAtuEaxmlGNG1RhLTpB
   pS00EVv5IO1VA0mF5t7FgmwEEcu7YTSisYhk5yoMjzArTswRhrB2ETQVB
   A==;
X-CSE-ConnectionGUID: GrXTKCniTnSnhpH4r0LX9A==
X-CSE-MsgGUID: FfsuHXUbSXql7McaI/++WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16669275"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16669275"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 20:18:21 -0700
X-CSE-ConnectionGUID: KT6DGDyVSq2HI0021jQlgA==
X-CSE-MsgGUID: dM3L1+A+TbyDoumtUmrc/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44657146"
Received: from lizhipe3-mobl1.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.249.171.174])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 20:18:15 -0700
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
Subject: [PATCH V2 2/3] perf/x86/intel/cstate: Add Arrowlake support
Date: Fri, 28 Jun 2024 11:17:57 +0800
Message-Id: <20240628031758.43103-3-rui.zhang@intel.com>
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

Like Alderlake, Arrowlake supports CC1/CC6/CC7 and PC2/PC3/PC6/PC8/PC10.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index dd1832055891..cb165af1a1bf 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF,GRR
+ *					  MTL,SRF,GRR,ARL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -53,30 +53,31 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						GRR
+ *						GRR,ARL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL,RKL,ADL,RPL,MTL
+ *						ICL,TGL,RKL,ADL,RPL,MTL,ARL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL
+ *						RPL,SPR,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL,RPL,MTL
+ *						ADL,RPL,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF
+ *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
+ *						ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -86,7 +87,7 @@
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
  *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
- *						ADL,RPL,MTL
+ *						ADL,RPL,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
@@ -95,7 +96,7 @@
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL,ADL,RPL,MTL
+ *						TNT,RKL,ADL,RPL,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
@@ -760,6 +761,9 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_METEORLAKE,		&adl_cstates),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,		&adl_cstates),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&adl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.34.1

