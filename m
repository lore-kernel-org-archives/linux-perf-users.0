Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901F1DFF7;
	Wed, 12 Nov 2025 00:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762908474; cv=none; b=lScwPjwhiPmmH+abE3/MML4Oz8YhgbbqrkKB4GRJfsejho3JwCQp7dvG7bfGEIIbaAHaV8iY+82iGN+3OSRb9m6lXQUsTZZhCOw4mcpWv32YSfTDRCozjEO+EnCUTYpI9Dih2wCKNX09hXtEW6bMXSKLGC5NCNpZRrB35WgHTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762908474; c=relaxed/simple;
	bh=jL6R/IPNeLhRSo2k5vRqel1tHMqnyqJilObXnC4HQV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VOtpNIsFXsNu1h6cbqfBY0iyWMoMGhmzi2PC6AU7Wea8ECTgu/CcgBu2ymSQssLoBXbIU3yn8Ejj3F/MyMV7VlLIBHRzQRmT/4goq6kY3hIBM0NVRlobtY0hPs6Rwd8hBwRvFthmDa9xgrJakel/MnW+7vpaYGXvx91c9OVFPeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jV6kwMdi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jV6kwMdi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762908472; x=1794444472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jL6R/IPNeLhRSo2k5vRqel1tHMqnyqJilObXnC4HQV0=;
  b=jV6kwMdi0s2qJmDDnHoTTX9tZG1iG9vxCFTSwnFTWRzdYCYLQKfM2Zn5
   IaxEy3z7F/wujWKFexmgGccUMTAs55Dk5qKHcRpCewb8G3q5BUYfDpajl
   t8QnGWmpWzjxD1zZwbSqrWxcWwXUYRkFHSLMIh3U/i6kVa5jY/kV1a2RK
   FG8kVpsE9Wmghc/7RSzoZbfBEAhmv2ke5GEHhCKyRQjWanJVKYnH9nucx
   osQPorrHGBPQE1EECB/7YuHalmas7iFWGDIhJlVD0AljXWm+XqhT8URIY
   O27dwerpQArqcGBq00e4za/yuDChvaeLnEGrefB0Zzgu3N1rKUuhm6p2q
   w==;
X-CSE-ConnectionGUID: im4wbTdQQm6Tlco4esYI9g==
X-CSE-MsgGUID: iVuKywPdRoiU5d1vZ2Ro0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64172926"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="64172926"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 16:47:52 -0800
X-CSE-ConnectionGUID: EBJPeTvfR4S2NJpD+to/9Q==
X-CSE-MsgGUID: TRWnnaQsT66FNNnZ0P1pPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="188725620"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 11 Nov 2025 16:47:48 -0800
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
Subject: [PATCH] perf/x86/intel: Only check GP counters for PEBS constraints validation
Date: Wed, 12 Nov 2025 08:45:13 +0800
Message-Id: <20251112004513.3279333-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's good enough to only check GP counters for PEBS constraints
validation since constraints overlap can only happen on GP counters.

Besides opportunistically refine the code style and use pr_warn() to
replace pr_info() as the message itself is a warning message.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index aad89c9d9514..81e6c8bcabde 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5506,7 +5506,7 @@ static void __intel_pmu_check_dyn_constr(struct event_constraint *constr,
 			}
 
 			if (check_fail) {
-				pr_info("The two events 0x%llx and 0x%llx may not be "
+				pr_warn("The two events 0x%llx and 0x%llx may not be "
 					"fully scheduled under some circumstances as "
 					"%s.\n",
 					c1->code, c2->code, dyn_constr_type_name[type]);
@@ -5519,6 +5519,7 @@ static void intel_pmu_check_dyn_constr(struct pmu *pmu,
 				       struct event_constraint *constr,
 				       u64 cntr_mask)
 {
+	u64 gp_mask = GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
 	enum dyn_constr_type i;
 	u64 mask;
 
@@ -5533,20 +5534,25 @@ static void intel_pmu_check_dyn_constr(struct pmu *pmu,
 				mask = x86_pmu.lbr_counters;
 			break;
 		case DYN_CONSTR_ACR_CNTR:
-			mask = hybrid(pmu, acr_cntr_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
+			mask = hybrid(pmu, acr_cntr_mask64) & gp_mask;
 			break;
 		case DYN_CONSTR_ACR_CAUSE:
-			if (hybrid(pmu, acr_cntr_mask64) == hybrid(pmu, acr_cause_mask64))
+			if (hybrid(pmu, acr_cntr_mask64) ==
+					hybrid(pmu, acr_cause_mask64))
 				continue;
-			mask = hybrid(pmu, acr_cause_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
+			mask = hybrid(pmu, acr_cause_mask64) & gp_mask;
 			break;
 		case DYN_CONSTR_PEBS:
-			if (x86_pmu.arch_pebs)
-				mask = hybrid(pmu, arch_pebs_cap).counters;
+			if (x86_pmu.arch_pebs) {
+				mask = hybrid(pmu, arch_pebs_cap).counters &
+				       gp_mask;
+			}
 			break;
 		case DYN_CONSTR_PDIST:
-			if (x86_pmu.arch_pebs)
-				mask = hybrid(pmu, arch_pebs_cap).pdists;
+			if (x86_pmu.arch_pebs) {
+				mask = hybrid(pmu, arch_pebs_cap).pdists &
+				       gp_mask;
+			}
 			break;
 		default:
 			pr_warn("Unsupported dynamic constraint type %d\n", i);

base-commit: 2093d8cf80fa5552d1025a78a8f3a10bf3b6466e
-- 
2.34.1

