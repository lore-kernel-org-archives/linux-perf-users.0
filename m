Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C9267B02;
	Wed, 12 Nov 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938160; cv=none; b=JPVFRZuql7u5akL93GdqBdt87f50U8CTkdPcLVHjjsHC+uQDbqwjWyVpdXQSrlQYCTGlwPxLhXj8IIprFnaLHmKq5PDyWCrGehqlEWPssxF0+VtZvYb8FqCrR3P/5ty9S8KnxtBEODcrdxUgyKbXxOqwWogpOhmdVowon93J1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938160; c=relaxed/simple;
	bh=yRGAE42KEjZlL1h5YThKHpL/X3+qBZ6BVFyZGahF89o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G9DEyGH8BOkxnCbpZjzNyv3qghnDNosaHjuPu0uMpqmUjhoAoGbGdUkKW+TIdtvXG4c3hGOQmQscmDH/N+0V/AIFDRBv598tgEAX5gm8nu0qUFDUSrCjpqZ64F2Hi+FCyhawbDm6njBwyq4Sg7dtPGNDtNdmnG8/H11E2ihM4f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXe4PCci; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXe4PCci"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762938159; x=1794474159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yRGAE42KEjZlL1h5YThKHpL/X3+qBZ6BVFyZGahF89o=;
  b=WXe4PCciJGtv8f1dy4vDprkxqD+BkaKPiUCdflTNPkJqifkeHduikmRx
   6tFWSmcJSemCgcQ0BRDxwdOI7R7puB7OK6jjOF2DSkbFv3HwZ0Jc1CyHc
   lVmsugJMTv0h2EGPX5AIKiAE4DyyJTvHDmAxC/dv2nK/sUFEEs28KW2Wl
   Z4QKIV8xqxMpyPub1UOB0AZz6v6arXNw8oS8gf0ZmrzgapjF3/k0KS/2G
   NkF8hSwPvE/jR3BOkXS5uBdhlXxdc7cs7veOtoMrQrN/qC73LoI3pDKzD
   k6TeqN6yJwrm95svwMJjRpCZnzMlJy/49T99KACru8NbM2mHh7cwDCAdz
   w==;
X-CSE-ConnectionGUID: 7ZjwzvXzQOWlaCQWTFV1QQ==
X-CSE-MsgGUID: YyvNPZE/SHyADp/sRawEmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64878446"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="64878446"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 01:02:38 -0800
X-CSE-ConnectionGUID: on9WpuZETXmwiDjoDKREvA==
X-CSE-MsgGUID: R+cXr2rfRMWJPOBPKfbVOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="194145907"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa004.fm.intel.com with ESMTP; 12 Nov 2025 01:02:35 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] x86/events/intel/cstate: Add Pantherlake support
Date: Wed, 12 Nov 2025 14:30:24 +0530
Message-Id: <20251112090024.3298186-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It supports the same C-state residency counters as Lunarlake.This
enables monitoring of C1, C6, C7 core states and C2,C3,C6,C10
package states residency counters on Pantherlake platforms.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 arch/x86/events/intel/cstate.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index ec753e39b007..b3582eeb6c4b 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF,GRR,ARL,LNL
+ *					  MTL,SRF,GRR,ARL,LNL,PTL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -53,31 +53,32 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						GRR,ARL,LNL
+ *						GRR,ARL,LNL,PTL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL
+ *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL,
+ *						PTL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL,ARL,LNL,SRF
+ *						RPL,SPR,MTL,ARL,LNL,SRF,PTL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL,RPL,MTL,ARL,LNL
+ *						ADL,RPL,MTL,ARL,LNL,PTL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						ARL,LNL
+ *						ARL,LNL,PTL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -96,7 +97,7 @@
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL,ADL,RPL,MTL,ARL,LNL
+ *						TNT,RKL,ADL,RPL,MTL,ARL,LNL,PTL
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
@@ -652,6 +653,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_cstates),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&lnl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.34.1

