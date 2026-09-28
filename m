Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D946C4BD;
	Mon, 28 Sep 2026 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581852; cv=none; b=a1nzt0ARkWlQKvsoC5k4WauPuEdntEWTOdeUdFFdiNQT4hdL7xPQ0ntsJcXaupd7c0SVza5kdencAfhaT0kUFbCAJsMng6Rz1NfCV3UGoUc+qV2r/VpGACW6sLfY9HlnW/ichOv3NxgvbnY9VUGM3XiSq6DWudkHcgmqqWHCuDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581852; c=relaxed/simple;
	bh=yORhQTvYMsoNzvBczV2rq8wFFxLb/9/ci2VN69FkLx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mc8eYVBakkPScy+Xi9WDOZAbCrEm/s5RhqiTLitffNovvy3DYFZASXqEAs7CU81JvezIOhHsTkz2t0Q+WULKHeiE02b0u8Nso5uVsHSE59+OvxPeYlERjjGSxMEH1SyyMqxnfw/W7qU1iMrMlQKYszZFNj99cYJ+C9fcxSfFenE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAdnV7+J; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAdnV7+J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581851; x=1822117851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yORhQTvYMsoNzvBczV2rq8wFFxLb/9/ci2VN69FkLx8=;
  b=VAdnV7+J3oMbEW67alFgd72AkRaNm3LBEL3HEkUo1t0dZrB7xk5OjqWG
   IUthHZpmBDF3hwREnDRGIPd8E4TIpGsl/KHFzxix50Hn1+WbaifOoPSxo
   tBWLOYTKlzTCMd8ZFVZMNh9EA7ah+UAJl4ttG/xhiCr/NRzsNMFkLn+h4
   S7AXnNwWQrhGUOCvLRVlquz+4C9gHIvcLb8ftim9xd7UH3c3pNBIVV50X
   3lt/2wPkFhziBwzQ72f/OOyaDFjGlXJcUofUGfOo29ftRycoVyUS3xvrh
   bz0GDkQhaEOE49yDjl6BfHKXLZefvVL7/m/FOtisvFObR/P61UEDeJkh1
   A==;
X-CSE-ConnectionGUID: HY+Xy6S+R5Sn+7t5Kl4uxw==
X-CSE-MsgGUID: Q4Sy9pogSCC38KLGNm47EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141410"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141410"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:50:51 -0700
X-CSE-ConnectionGUID: 0edP73gkRKKmQ3LiPXOjig==
X-CSE-MsgGUID: PEC3rzrjQhOLIPFbAx7F+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275024910"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:50:48 -0700
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
Subject: [PATCH 05/15] perf/x86/intel: Pass correct PEBS counter mask to no-drain update path
Date: Mon, 28 Sep 2026 15:42:59 +0800
Message-Id: <20260928074309.898043-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_pmu_drain_arch_pebs() calls intel_pmu_pebs_event_update_no_drain()
with X86_PMC_IDX_MAX, but that parameter is a counter bitmask, not a
max index value. As a result, PEBS event state is not updated/restored
correctly on the no-drain path.

Pass the PEBS counter mask to intel_pmu_pebs_event_update_no_drain().

Fixes: d21954c8a0ff ("perf/x86/intel: Process arch-PEBS records or record fragments")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8444670cee4a..0f24098587bf 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3358,8 +3358,9 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 
 	rdmsrq(MSR_IA32_PEBS_INDEX, index.whole);
 
+	mask = hybrid(cpuc->pmu, arch_pebs_cap).counters & cpuc->pebs_enabled;
 	if (unlikely(!index.wr)) {
-		intel_pmu_pebs_event_update_no_drain(cpuc, X86_PMC_IDX_MAX);
+		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
 		return 0;
 	}
 
@@ -3375,8 +3376,6 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 		index.thresh = ARCH_PEBS_THRESH_SINGLE;
 	wrmsrq(MSR_IA32_PEBS_INDEX, index.whole);
 
-	mask = hybrid(cpuc->pmu, arch_pebs_cap).counters & cpuc->pebs_enabled;
-
 	if (!iregs)
 		iregs = &dummy_iregs;
 
-- 
2.34.1

