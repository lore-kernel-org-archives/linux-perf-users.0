Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6239E2874E1;
	Wed, 14 Jan 2026 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353751; cv=none; b=q0dRAkwI1B4AHj7oe7Bq4hwU/8cmiDMUlRX/5SJ6eKN6BCS/hl1jspfS14eqtl2AuN82qqwexTWvJL91OEQxMChQRlVGVYfCQVzKvBoGLr6lqQ+flcb/3x6HJjAcWyt0uPyfatqABtjWK7hgaUrm1ZAnu1USuX+VcJaNK+/KFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353751; c=relaxed/simple;
	bh=8swUns+f4sPnKRPagD2A6Oy6QNSylTblYdaomHLa5sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bp6Y28/tlxPv4g3EVUQ7XaJEFVTsH35TPw8h0NY88hH0Bx9jISo4+9EU9FVQoAJbQuwvccR7UtKgn9hrLah0c5LeRsZefrIFB7yaTQ0HxZiy8y3GaHC9QrK/lfiN6nAF3QhZhllO3mEFhYdc0fCnviSExftKXSqi8eqkHyaOejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPYEHHHB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPYEHHHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768353750; x=1799889750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8swUns+f4sPnKRPagD2A6Oy6QNSylTblYdaomHLa5sw=;
  b=SPYEHHHBi6Oi8M/H4zPCutkkrDrurPyqH4HnrP2WuOskuVdv4mQ2unxl
   nPdtKbmydVaU/pfiyh+1oA/04JKm049/k8tVcXV9luWgALUEItVYK0vvY
   s7aRdVVRxSccPtMcgwoLuQd3mepELWIBnO/xBIlRqyIYqhOLZaOi6P9s+
   B4gU4RGZKKI2eQbLf+2xOvfylmoeFRnqgYTRvIrU4XUNVTHeY1etX/UrS
   B2wJ8YvdH+weFDZoEy6G68+mE1DADMePCUJm4ta0NWFrudhRd/lot9yTA
   jXYGl9jn/etQFQUgd2hejhkPh46iB8YRvIiq7Eu7YA/wfJG+uRxR8v/6O
   A==;
X-CSE-ConnectionGUID: 95AhHwYZSYCg/rqzE478KA==
X-CSE-MsgGUID: yjpOXLa5S1WEeubqbeFEBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="87231533"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="87231533"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 17:22:29 -0800
X-CSE-ConnectionGUID: ComK2FhFRQ2FRiXncdTLbw==
X-CSE-MsgGUID: R29EW0WgQL2SxWKU3rM8jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204561214"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 13 Jan 2026 17:22:26 -0800
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
Subject: [Patch v3 6/7] perf/x86: Use macros to replace magic numbers in attr_rdpmc
Date: Wed, 14 Jan 2026 09:17:49 +0800
Message-Id: <20260114011750.350569-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114011750.350569-1-dapeng1.mi@linux.intel.com>
References: <20260114011750.350569-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace magic numbers in attr_rdpmc with macros to improve readability
and make their meanings clearer for users.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c       | 7 ++++---
 arch/x86/events/intel/p6.c   | 2 +-
 arch/x86/events/perf_event.h | 7 +++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0ecac9495d74..c2717cb5034f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2163,7 +2163,8 @@ static int __init init_hw_perf_events(void)
 
 	pr_cont("%s PMU driver.\n", x86_pmu.name);
 
-	x86_pmu.attr_rdpmc = 1; /* enable userspace RDPMC usage by default */
+	/* enable userspace RDPMC usage by default */
+	x86_pmu.attr_rdpmc = X86_USER_RDPMC_CONDITIONAL_ENABLE;
 
 	for (quirk = x86_pmu.quirks; quirk; quirk = quirk->next)
 		quirk->func();
@@ -2643,12 +2644,12 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
 		 */
 		if (val == 0)
 			static_branch_inc(&rdpmc_never_available_key);
-		else if (x86_pmu.attr_rdpmc == 0)
+		else if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_NEVER_ENABLE)
 			static_branch_dec(&rdpmc_never_available_key);
 
 		if (val == 2)
 			static_branch_inc(&rdpmc_always_available_key);
-		else if (x86_pmu.attr_rdpmc == 2)
+		else if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_ENABLE)
 			static_branch_dec(&rdpmc_always_available_key);
 
 		on_each_cpu(cr4_update_pce, NULL, 1);
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index 6e41de355bd8..fb991e0ac614 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -243,7 +243,7 @@ static __init void p6_pmu_rdpmc_quirk(void)
 		 */
 		pr_warn("Userspace RDPMC support disabled due to a CPU erratum\n");
 		x86_pmu.attr_rdpmc_broken = 1;
-		x86_pmu.attr_rdpmc = 0;
+		x86_pmu.attr_rdpmc = X86_USER_RDPMC_NEVER_ENABLE;
 	}
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f7caabc5d487..24a81d2916e9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -187,6 +187,13 @@ struct amd_nb {
 	 (1ULL << PERF_REG_X86_R14)   | \
 	 (1ULL << PERF_REG_X86_R15))
 
+/* user space rdpmc control values */
+enum {
+	X86_USER_RDPMC_NEVER_ENABLE		= 0,
+	X86_USER_RDPMC_CONDITIONAL_ENABLE	= 1,
+	X86_USER_RDPMC_ALWAYS_ENABLE		= 2,
+};
+
 /*
  * Per register state.
  */
-- 
2.34.1

