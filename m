Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF2288C24;
	Thu, 23 Oct 2025 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761259462; cv=none; b=Zdiu09zVqPCPhezZ+8Fp3jILTSSqsAHjxg4OMIM85FMqvChmGJXrIVpKYebyoXuTUpYB+RndbWebE1ZuVsUOvj3g6X2QUli4dKcBcvl5Y0Z5MIwP7AsZyxmW9ZJ/UTMn2dgz0Ho48uVpDg/BAwIBvQzhNV4X3G/eTa1Muc/UZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761259462; c=relaxed/simple;
	bh=ltxwjcO6fbW7VFGHu2ab0NFMy4SRYIsPlADiG3WOl94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/fdLWm+QInSYUW3fORM+rIL6483SgFuFVQ+ZryV+4RKoczUkdBAvrJe21S01lgt+OxPBW9TwC8+XJElcJgmEuFHkp0ht4lnV6gvf7KVaTQSKDc2qmQU9KZkQdDnv9XidkgRdbzSXJq6sd2Ncwf6nZl/UraZ8fqJc+ykmY3gqxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IU9VFnCn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IU9VFnCn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761259461; x=1792795461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ltxwjcO6fbW7VFGHu2ab0NFMy4SRYIsPlADiG3WOl94=;
  b=IU9VFnCn6DzYkDwis6CskInn2tUVGy0+UvNsvBZnl9bOLdsM3QLGP2k3
   DArfIvLXIKpVQhkXf7KaWiJmI0ep0f3w2gdI+NVHdaxZJ4j6MrROzHTAo
   xTrFTQolC4J+gLbJUsu8mXDJzu4IiqKYyDrAhhQMnmws7jdfXIq7So4cq
   oWxPHt419gyzWaTehIvUrNze1h+pPitoKN/sAEgS3OOQWdZgiASQP7qnu
   0xlZk8q8XCksp/JlMHGSLvstqrcVIDnhfTIjHZudbSVk42WHOQT03OMV4
   +lo8gt4Dppliezvij9RYLUxvB+7Nof5ya4Iz9n7+gR1lWnFy7Q2bisoSK
   Q==;
X-CSE-ConnectionGUID: oJilxQzuRsmkGX9JGJbCkg==
X-CSE-MsgGUID: 7UPJSQH6Tr6qs2FyWISt5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63333510"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="63333510"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 15:44:20 -0700
X-CSE-ConnectionGUID: TbDhDJyvTRyaJTSWgC9p2w==
X-CSE-MsgGUID: TkdAOh+4RZaSy/U+ucfTag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="183885487"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 15:44:20 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH RESEND 3/3] perf/x86/intel/cstate: Add Pantherlake support
Date: Thu, 23 Oct 2025 15:37:53 -0700
Message-ID: <20251023223754.1743928-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023223754.1743928-1-zide.chen@intel.com>
References: <20251023223754.1743928-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

Like Lunarlake, Pantherlake supports CC1/CC6/CC7 and PC2/PC6/PC10.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/intel/cstate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 2bfd011f99da..fa67fda6e45b 100644
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
@@ -652,6 +653,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_cstates),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&lnl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.51.1

