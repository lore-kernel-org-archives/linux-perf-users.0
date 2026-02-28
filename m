Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD9244675;
	Sat, 28 Feb 2026 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772257040; cv=none; b=mhb87GlQUyIMhWP2PnmuwcWeppISEsQsMc8IjsTQaDDPUtfmYoaqXeyLoU9T8GiPPAzpncSqcnrXHpIz+DcAWqHN0WM/x43CKPBCqHD8V+HvtAQ9cQFTVr4+U0Ys1uxNZnAkagZyknP038JsvQylOtYq1uy4ebcMia49R2Xvq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772257040; c=relaxed/simple;
	bh=0pgX2X13LxqLggF8X/tXBFrts0q0SfC9K/zEUHi5xkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lHmaWkfLYOo1DwOGE1UO5RJA9VxjAGgqF6rkV1BPiXjGdEiU8q3+UGy83z+qQ3lkI4brYi1VNxmzb1uAfFiztsmO6CTLOKSZGOt/ZbgEDubOTKjHGmH3ZIDig+tqVgIZ4wNER3BaB9g8I+ptsdpZ+rSf6L40ALrgnzl13LTfMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huvgxL6t; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huvgxL6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772257040; x=1803793040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0pgX2X13LxqLggF8X/tXBFrts0q0SfC9K/zEUHi5xkE=;
  b=huvgxL6tC/0IknjjzwBgr7WJe9O/1j7EIUukNEzXIQkl1KRlJ9X+trya
   66fF2AdzqPHFC4lDhGeFzcbxmQYmEbJZmRf+QFEGquTxSGTHy8W+dmRhe
   rKPAP0ktgL0QZ3Q1F3O8QJPC0im3dzrqnxiBvkQvzBp3o4sgJMfqj+pL5
   yvJwaw9km2CWNYHR/+p/N7+ArJ3CmbHOZdFyVizcNowcMymF+Ql0wTaci
   vfIN9xR7DoYhAJ81qElahKAgq3wbAXCrp8TYCgF0WncHrmeOTu48mW8J2
   HmqqBZjDIXegauGi2m+lXBfapqx9LxjapKbkoPelpwBnrjjeItL72xdlR
   g==;
X-CSE-ConnectionGUID: Smy46VMEQw22quVVa8TJpw==
X-CSE-MsgGUID: ++mwalI+QZyQ8TcvJghtVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73307697"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="73307697"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 21:37:19 -0800
X-CSE-ConnectionGUID: jIenbP8RQ4CvpynUYOdTtw==
X-CSE-MsgGUID: QtykkrndTBOa4vbySi7hwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="254921371"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 27 Feb 2026 21:37:16 -0800
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
Subject: [RESEND Patch 1/2] perf/x86/intel: Only check GP counters for PEBS constraints validation
Date: Sat, 28 Feb 2026 13:33:19 +0800
Message-Id: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
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
index cf3a4fe06ff2..4768236c054b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5770,7 +5770,7 @@ static void __intel_pmu_check_dyn_constr(struct event_constraint *constr,
 			}
 
 			if (check_fail) {
-				pr_info("The two events 0x%llx and 0x%llx may not be "
+				pr_warn("The two events 0x%llx and 0x%llx may not be "
 					"fully scheduled under some circumstances as "
 					"%s.\n",
 					c1->code, c2->code, dyn_constr_type_name[type]);
@@ -5783,6 +5783,7 @@ static void intel_pmu_check_dyn_constr(struct pmu *pmu,
 				       struct event_constraint *constr,
 				       u64 cntr_mask)
 {
+	u64 gp_mask = GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
 	enum dyn_constr_type i;
 	u64 mask;
 
@@ -5797,20 +5798,25 @@ static void intel_pmu_check_dyn_constr(struct pmu *pmu,
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

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.34.1

