Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA9426EC1;
	Wed, 27 May 2026 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895236; cv=none; b=P43JycXkeurL4rpPqt9QdiIa7/jBeL4jreB9WSGy1lUnGKvs0XXH2ZsBNIYAjCT5dY6/SB8Fm45e2WtK8mCXNaCtgFPPI5RW0gLjx0m4415UEeERK2ihgZEvVtvzp9SBQ/gMdaw86bmBw6OfjCbNHQLUh5leh2GGBmT458/MuFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895236; c=relaxed/simple;
	bh=OUH2QCdYG+UL1lkzFiq1f89c/t/gBn57HqTS+mgcBzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmiOqMH91Hu3D5Hmp1GulLRpGlnvrusqwO1Wmk+aHFlpE7FJQ28CDAAyxmGjnDk7RcV60NeNv+1zmEgPQD13glrq/6ixxKYiXJk0lCsfcBiyITpDjBtoOpnuD+wlE5TNrhFIyXuQGGqsr+JDI7hLeXNKOEF0Ozaojoya9lv7+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jq4CoVW8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jq4CoVW8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779895234; x=1811431234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OUH2QCdYG+UL1lkzFiq1f89c/t/gBn57HqTS+mgcBzw=;
  b=jq4CoVW8cpdcx2yJUs8EDM6royQiHRjzR1jiGUNqj4Z084sygnCeVL6g
   H3mzlNVsvALI2YFy52SqBoOL7HzwFJ0u4R/QpMME8DcJlVZN1o1JPW7Xn
   /EYjDJyWM9m7HCFAEyalPzvyBRuvpr4+uLACCtqOMEKwM37wf25EUXake
   duofbaqJAkAQY9GNMtEOt4Qt0pnJiqGOuI0u3BKtrfwQcQ/xGJF07gTp7
   wOmGCL5FCj7WoT+ZJYPYK3ZOKiwZiLYIehwfEEdshDAK7MhoTSrgazPGZ
   yoaZpTnFaMhfsbrkoScZutavUqFhWxSEXfOB/ZsD0eovnO5Kj3cuLbgQ4
   w==;
X-CSE-ConnectionGUID: gp2TuZ7qS2izOAa3lh25Iw==
X-CSE-MsgGUID: Xf5YGPVERniWulFhl1lXRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="98149319"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="98149319"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:20:31 -0700
X-CSE-ConnectionGUID: fgGLB5lPR82EX3T/aZTy9g==
X-CSE-MsgGUID: DwC7PIxySWy0XeRGntJhGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="241231399"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:20:31 -0700
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
	stable@vger.kernel.org
Subject: [PATCH V2 4/7] perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()
Date: Wed, 27 May 2026 08:11:51 -0700
Message-ID: <20260527151154.130505-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527151154.130505-1-zide.chen@intel.com>
References: <20260527151154.130505-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some Raptor Cove CPUs, enabling uncore PMON globally at driver init
may increase power consumption even when no perf events are in use.

Drop adl_uncore_msr_init_box() and defer programming the global control
register to enable_box(), so it is only set when a box is actually used.

IMC and IMC freerunning counters use a separate control path and are
unaffected.

Cc: stable@vger.kernel.org
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 3dbc6bacbd9d..edddd4f9ab5f 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -563,12 +563,6 @@ void tgl_uncore_cpu_init(void)
 	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
 }
 
-static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
-{
-	if (box->pmu->pmu_idx == 0)
-		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
-}
-
 static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
 	wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
@@ -587,7 +581,6 @@ static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
 }
 
 static struct intel_uncore_ops adl_uncore_msr_ops = {
-	.init_box	= adl_uncore_msr_init_box,
 	.enable_box	= adl_uncore_msr_enable_box,
 	.disable_box	= adl_uncore_msr_disable_box,
 	.exit_box	= adl_uncore_msr_exit_box,
-- 
2.54.0

