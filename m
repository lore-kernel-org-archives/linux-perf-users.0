Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8BD37F33B;
	Thu, 17 Sep 2026 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610383; cv=none; b=Cn0oPu7/mJNUjuGVPdzDlU716MNomX3jzNg2gw0vyGiBksjNs1MiC+QOsr2L/I0j0dXh+b/B/cXxN4denrjbikmtp7ETKs4f2gfY0DwD7K5kOM6ukYc1J97pMyR/H9QwePN3ahnPMXLsYD/1c3snkjwkFiAQOubgB/KKhNhlM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610383; c=relaxed/simple;
	bh=J9WUaVt3R+dNx4jJxSk3X2XtLqmj5tbYD7tcc9N4XF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nFPpveEq8l6WGaC5f/2FIfc8Mdzvn0Ng1aaAl4XQOE9QSq6DUt230LhuhDetDI13sLG53VK1bxgUE23HjQaXcr8wkWxZqQlQXcMZW58LX770JTnq6oiXHAPtYXSdnzAh6boXixiG3cvKDN0XVDEzHFEqyNsOOUsEApWUZJP6L9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2wF2rsw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2wF2rsw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789610381; x=1821146381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J9WUaVt3R+dNx4jJxSk3X2XtLqmj5tbYD7tcc9N4XF0=;
  b=e2wF2rsw2H9d3s9pTK/aO+WhJA3Xb0cl1RhsewuRzIDCOlxBV+r9I1TE
   g++LQt+qd39yeJvzPyItEDj5wV1xIKyHuo3RbTMJdqGDoO8EUV6QkJHZY
   EtQlFwMX4e7dEDhIvT/WlifEg5qwodetShtZYqeYQH34xXjuHnxyccgoR
   Q0tfT0xZ/Opk8gmRNgZsf3ZKxBx0+rTZD4uzLL7SW8rKdqYN2To4Hmmx2
   ec5MQLBpMGGuZJC9DUJHMryhzgqjxkFP1l/s9CG3tCZZOcvivGW6qAf22
   76frX3Zl5kvF5XCGGwdGvITUM5OnH8vin4P0Gd3jeG0ELGFXoFyhKa4ZW
   w==;
X-CSE-ConnectionGUID: w/XD1JQ/RYWzqdWALR0IMw==
X-CSE-MsgGUID: ZFDgSHD7TJeTQ9AP52TKIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107498529"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107498529"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 18:59:40 -0700
X-CSE-ConnectionGUID: wWGXIKuNQyOgbbxf/S5+/g==
X-CSE-MsgGUID: 5NqGQWzvQ3a6v3W0HBe7xg==
X-ExtLoop1: 1
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 18:59:37 -0700
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
Subject: [PATCH 01/12] perf/x86/intel: Fix GRT PEBS load/store direction for latency events
Date: Thu, 17 Sep 2026 09:52:23 +0800
Message-Id: <20260917015234.981153-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Gracemont, intel_grt_pebs_event_constraints[] applies LAT_CONSTRAINT
constraints to MEM_UOPS_RETIRED.{LOAD,STORE}_LATENCY, but does not set
explicit LOAD/STORE flags for those events.

The PEBS latency path (pebs_latency_data(), via __grt_latency_data())
uses the event flags to determine memory operation direction. Without an
explicit STORE flag, samples from MEM_UOPS_RETIRED.STORE_LATENCY can be
misclassified as LOADs.

Set explicit LOAD/STORE flags in intel_grt_pebs_event_constraints[] for:
- MEM_UOPS_RETIRED.LOAD_LATENCY
- MEM_UOPS_RETIRED.STORE_LATENCY

Also update __grt_latency_data() to explicitly interpret these flags when
assigning the sampled memory operation direction.

This fixes incorrect STORE sample classification.

Fixes: 39a41278f041 ("perf/x86/intel: Fix PEBS memory access info encoding for ADL")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2edff9754eb2..20674871c6c3 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -455,6 +455,7 @@ static inline void pebs_set_tlb_lock(u64 *val, bool tlb, bool lock)
 static u64 __grt_latency_data(struct perf_event *event, u64 status,
 			       u8 dse, bool tlb, bool lock, bool blk)
 {
+	union perf_mem_data_src src;
 	u64 val;
 
 	WARN_ON_ONCE(is_hybrid() &&
@@ -470,7 +471,16 @@ static u64 __grt_latency_data(struct perf_event *event, u64 status,
 	else
 		val |= P(BLK, NA);
 
-	return val;
+	src.val = val;
+
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_LDLAT | PERF_X86_EVENT_PEBS_LD_HSW))
+		src.mem_op = P(OP, LOAD);
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_STLAT | PERF_X86_EVENT_PEBS_ST_HSW))
+		src.mem_op = P(OP, STORE);
+
+	return src.val;
 }
 
 u64 grt_latency_data(struct perf_event *event, u64 status)
@@ -1288,8 +1298,8 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 
 struct event_constraint intel_grt_pebs_event_constraints[] = {
 	/* Allow all events as PEBS with no flags */
-	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0x3),
-	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0x3f),
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x5d0, 0x3),
+	INTEL_HYBRID_STLAT_CONSTRAINT(0x6d0, 0x3f),
 	EVENT_CONSTRAINT_END
 };
 
-- 
2.34.1

