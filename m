Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F73937EFFC;
	Thu, 17 Sep 2026 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610386; cv=none; b=fh5LatNUpq8crLqYFjvUKVkPYcwA+WEPTLdqfEMk5eImihWG86xZRlsenTIuShxsWI5yF8jKVuXyshoNoua1nKD+q28LaxiuTc33FWGkpTR/1yjAmByyRvGDhmaK/CYw8W92yQtWBn4wVicerkBEBrpX9IBI4sSsvKCEA6P2g0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610386; c=relaxed/simple;
	bh=Nvi+zRSbHpoSlgoJwAgVOA+jSwsUBrWCPWHxs5YCIXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NGna5KxrUUlv4j6a7sYbU6eOIL1Em34+g+PoJAAtYDFku5+Yw+rDboXS/phuDv4ugfP0W2YuK/n/P/16Osux9w9rsJtt0/Tkh0bv736s9LhK+0Lv8onDpLg69dmki+gSKsfiDieQOVFk76XxayV8PSQqn3ml2kQzE4fRe0oOAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fp/QoO6Y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fp/QoO6Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789610384; x=1821146384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nvi+zRSbHpoSlgoJwAgVOA+jSwsUBrWCPWHxs5YCIXE=;
  b=Fp/QoO6YKJAFvUhwjzDnLhhUlIXOJLBjw5z51j1xxyq5NtoLU48Rrh8D
   9H0ySX2g68OpSutNR/FXNosUgBjDoJ6W+BkI1bpX4c/LI9tkyMxZXo2wR
   Mot4noUgfq01oPg+RRcO8psqcKu6V0BM34KECvKxkb/PgljKysKHMzJeE
   72pax5NLGhsfmJEZ3/G+hbGiAKi5K63Rr5G7huoCw0FzQABjE8uHrMS3x
   qYgwp1b0P/X99+J7amJqh+6HrvfOtoZJwRZmzJeGqvs1mUPX9e0KodJoe
   zUm/IODPcD8eZYAycCNPQ0Fznf+HlvGEQPPzc1reM7a62EK3k/MSM3Y9y
   A==;
X-CSE-ConnectionGUID: Cp2HxYT8QvW3uQG4qzMQ2g==
X-CSE-MsgGUID: 7cv0nON3TkOOgothDjP1SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107498534"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107498534"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 18:59:44 -0700
X-CSE-ConnectionGUID: ESoAe1YXQHSOuBFtLNHKwA==
X-CSE-MsgGUID: f2HJ47tdT7SGiEpdwwkXLg==
X-ExtLoop1: 1
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 18:59:40 -0700
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
Subject: [PATCH 02/12] perf/x86/intel: Fix CMT PEBS load/store direction for latency events
Date: Thu, 17 Sep 2026 09:52:24 +0800
Message-Id: <20260917015234.981153-3-dapeng1.mi@linux.intel.com>
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

Same issue exists on Crestmont, intel_cmt_pebs_event_constraints[]
applies LAT_CONSTRAINT constraints to
MEM_UOPS_RETIRED.{LOAD,STORE}_LATENCY, but does not set explicit
LOAD/STORE flags for those events.

The PEBS latency path (pebs_latency_data(), via cmt_latency_data) uses
the event flags to determine memory operation direction. Without an
explicit STORE flag, samples from MEM_UOPS_RETIRED.STORE_LATENCY can be
misclassified as LOADs.

Set explicit LOAD/STORE flags in intel_cmt_pebs_event_constraints[] for:
- MEM_UOPS_RETIRED.LOAD_LATENCY
- MEM_UOPS_RETIRED.STORE_LATENCY

This fixes incorrect STORE sample classification.

Fixes: e99fb45436ea ("perf/x86/intel: Update event constraints and cache_extra_regsfor MTL")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 20674871c6c3..434adf15d83c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1305,8 +1305,8 @@ struct event_constraint intel_grt_pebs_event_constraints[] = {
 
 struct event_constraint intel_cmt_pebs_event_constraints[] = {
 	/* Allow all events as PEBS with no flags */
-	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0x3),
-	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xff),
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x5d0, 0x3),
+	INTEL_HYBRID_STLAT_CONSTRAINT(0x6d0, 0xff),
 	EVENT_CONSTRAINT_END
 };
 
-- 
2.34.1

