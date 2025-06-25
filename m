Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E868634A;
	Wed, 25 Jun 2025 01:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750813711; cv=none; b=RF5sym25yPQQ1MZO6UqnGwxfxPk6EtctBTPSB+ft+SuK6iwTFFFqTM68GavuYJ9+v6muhdGWUQ4EDmtoRAnPsur0YU4fysqqMRwWbY/HYxC040ZIOux4OfhpBsmZSe4wHPYX5OWk+iZwNgC6Moy5EliFeNOkvsA1DlPjsiRRDpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750813711; c=relaxed/simple;
	bh=TOF0C3SFCw/3wf+4fGiczSw4KaPn8gRnHe/zXv3hBqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY3uwyyuYe3n1rJMqGKS7IldqZpCUBF0VQ8ctgHCUs31Mz+8XDN0DpC3BsJk08brhEiRF5Tj7HtSwWtVR5gpMQMzmDiH1ZoYA0zjp7g1Hx9lYpGo3FUZsq8XIzRdCj7kaGUELEYIk5Husr4kJYWVsvvCB3hnBuhtBCfFLu3tibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEIwnQ1D; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEIwnQ1D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750813710; x=1782349710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TOF0C3SFCw/3wf+4fGiczSw4KaPn8gRnHe/zXv3hBqM=;
  b=YEIwnQ1DPiw6ftfK//e6y+pNcpk0h9Cs9rg4XG9ho7ftnL0Lpt7J/ADm
   4NHuYeyRVtKm3BcyVAgbg9KnwCUAQbGkh8FpNwHqaizJW8wlPlGVHpAA1
   VlQADPrl0KE47zxIwsIRNFgxSRJEbh/AOMTas9wqpZCKAgzOA9G2EXf+T
   VmbgELIQXIi8aL7L4kHOkELk+/IsjdGDix4NpXA+lk/kt0rpgt4I0jB+B
   Qozf9U2gyLofBOxe6kKpw7S/PMn9kFI15QDsvrwSISoS4dv6HdWIVzDJW
   XqxIkMqF73zsMS8wbQTUEr+mShlAfYxpMGJ0xFHQCmfAAK9ZLee0A+Iss
   g==;
X-CSE-ConnectionGUID: xHcmzCzqQkmUGyGyQ11vEw==
X-CSE-MsgGUID: 06kpQPQBSrmPt9Uuq558ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53003641"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="53003641"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 18:08:30 -0700
X-CSE-ConnectionGUID: xO2Sq9mWRp+JcSgzKF56Og==
X-CSE-MsgGUID: pLVpZm2VQk+Vz8A5adQ1gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="156470228"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.124])
  by orviesa003.jf.intel.com with ESMTP; 24 Jun 2025 18:08:27 -0700
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
Subject: [PATCH 2/2] perf/x86/intel/cstate: Add Pantherlake support
Date: Wed, 25 Jun 2025 09:08:22 +0800
Message-ID: <20250625010822.250826-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625010822.250826-1-rui.zhang@intel.com>
References: <20250625010822.250826-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like Lunarlake, Pantherlake supports CC1/CC6/CC7 and PC2/PC6/PC10.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/intel/cstate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 6f5286a99e0c..369b0d204ff0 100644
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
@@ -53,18 +53,19 @@
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
@@ -77,7 +78,7 @@
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
@@ -651,6 +652,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_cstates),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&lnl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.43.0

