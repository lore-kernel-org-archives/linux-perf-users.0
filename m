Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5C30F529;
	Mon, 12 Jan 2026 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768195232; cv=none; b=CEV15zz/9njIX6MPsJBMBDd/XL0KpNJg72g7mOCZNQMUfrlHjf0DQMxWslK5gb90T2jxBsKLEaY2TzAPBiOoyDqR2TZYrMumGyLQE8CLpTHcLKdilk2HxhxAYSyzGqX0A/sbYf0fByd/XPVWaA3GyGS4kt2dDTxn+I/j2PFfbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768195232; c=relaxed/simple;
	bh=Jje9Nl6kZG8JO4M8Sr6/NKQaD3pizjWUtstA+P5+e2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfDrC+Jp1uaEavjGzHAveo5QDx9C9SB3f5+I7mtjNDa9YiTLzZbzwEx5F40M5RMliNJBqHjbhvkzVNVGzv7JqUvO+2DfkqSTkFLqPOlIh28KHUjCc2UkwlnQjtRv7UBNr2jnNrW3i9268ibYO0I9qx9GXoEj9C3YW0XHwKuBngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eu4XaVVv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eu4XaVVv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768195230; x=1799731230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jje9Nl6kZG8JO4M8Sr6/NKQaD3pizjWUtstA+P5+e2w=;
  b=eu4XaVVvl6l5k8yx5l8cosmD0m4aa7Le8SMgtfGfeRGaRwQ8fwZOgTo8
   1BGm2oFxvdfhAlhCdanY2qX3j1sxSkkxF7DOogLUyXF90ZUG5KF2ldKCZ
   09u/EQ+XhS86KHz4BqPAAnCQxc43GP04QWAWTcMW7fYlmKGp1jwWqpIcv
   DNjUht2uOc3eIMUkr3/j8/R4fULTw6BrbSp1tE/BWPVvraVSl/I0bK+UP
   4i53vl8SlRmCXybp16Yvzxc18Nx18SBlG/kRX7pNCOlgnEWRVwXX5f2vu
   rNCsse/cxinSL1v2raqMogj017r8r3kWkCEdKsUg0SphP1Dc1majztYr4
   Q==;
X-CSE-ConnectionGUID: kUIurmjkQky4fnubgy4EwQ==
X-CSE-MsgGUID: c9L109nOSDGzu1t8FpYDgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="68673233"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="68673233"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 21:20:28 -0800
X-CSE-ConnectionGUID: 5KawQ/jKQxiw0z8IiriLrQ==
X-CSE-MsgGUID: JenKE254SMeoanJn0aHl5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="235233434"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 11 Jan 2026 21:20:24 -0800
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
Subject: [Patch v2 4/7] perf/x86/intel: Add support for PEBS memory auxiliary info field in NVL
Date: Mon, 12 Jan 2026 13:16:46 +0800
Message-Id: <20260112051649.1113435-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to DMR (Panther Cove uarch), both P-core (Coyote Cove uarch) and
E-core (Arctic Wolf uarch) of NVL adopt the new PEBS memory auxiliary
info layout.

Coyote Cove microarchitecture shares the same PMU capabilities, including
the memory auxiliary info layout, with Panther Cove. Arctic Wolf
microarchitecture has a similar layout to Panther Cove, with the only
difference being specific data source encoding for L2 hit cases (up to
the L2 cache level). The OMR encoding remains the same as in Panther Cove.

For detailed information on the memory auxiliary info encoding, please
refer to section 16.2 "PEBS LOAD LATENCY AND STORE LATENCY FACILITY" in
the latest ISE documentation.

This patch defines Arctic Wolf specific data source encoding and then
supports PEBS memory auxiliary info field for NVL.

ISE: https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c   | 83 ++++++++++++++++++++++++++++++++++++
 arch/x86/events/perf_event.h |  2 +
 2 files changed, 85 insertions(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 06e42ac33749..a47f173d411b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -96,6 +96,18 @@ union intel_x86_pebs_dse {
 		unsigned int pnc_fb_full:1;
 		unsigned int ld_reserved8:16;
 	};
+	struct {
+		unsigned int arw_dse:8;
+		unsigned int arw_l2_miss:1;
+		unsigned int arw_xq_promotion:1;
+		unsigned int arw_reissue:1;
+		unsigned int arw_stlb_miss:1;
+		unsigned int arw_locked:1;
+		unsigned int arw_data_blk:1;
+		unsigned int arw_addr_blk:1;
+		unsigned int arw_fb_full:1;
+		unsigned int ld_reserved9:16;
+	};
 };
 
 
@@ -274,6 +286,29 @@ static u64 pnc_pebs_l2_hit_data_source[PNC_PEBS_DATA_SOURCE_MAX] = {
 	OP_LH | P(LVL, UNC) | LEVEL(NA) | P(SNOOP, NONE),	/* 0x0f: uncached */
 };
 
+/* Version for Arctic Wolf and later */
+
+/* L2 hit */
+#define ARW_PEBS_DATA_SOURCE_MAX	16
+static u64 arw_pebs_l2_hit_data_source[ARW_PEBS_DATA_SOURCE_MAX] = {
+	P(OP, LOAD) | P(LVL, NA) | LEVEL(NA) | P(SNOOP, NA),	/* 0x00: non-cache access */
+	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),	/* 0x01: L1 hit */
+	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE),	/* 0x02: WCB Hit */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, NONE),	/* 0x03: L2 Hit Clean */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, HIT),	/* 0x04: L2 Hit Snoop HIT */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, HITM),	/* 0x05: L2 Hit Snoop Hit Modified */
+	OP_LH | P(LVL, UNC) | LEVEL(NA) | P(SNOOP, NONE),	/* 0x06: uncached */
+	0,							/* 0x07: Reserved */
+	0,							/* 0x08: Reserved */
+	0,							/* 0x09: Reserved */
+	0,							/* 0x0a: Reserved */
+	0,							/* 0x0b: Reserved */
+	0,							/* 0x0c: Reserved */
+	0,							/* 0x0d: Reserved */
+	0,							/* 0x0e: Reserved */
+	0,							/* 0x0f: Reserved */
+};
+
 /* L2 miss */
 #define OMR_DATA_SOURCE_MAX		16
 static u64 omr_data_source[OMR_DATA_SOURCE_MAX] = {
@@ -458,6 +493,44 @@ u64 cmt_latency_data(struct perf_event *event, u64 status)
 				  dse.mtl_fwd_blk);
 }
 
+static u64 arw_latency_data(struct perf_event *event, u64 status)
+{
+	union intel_x86_pebs_dse dse;
+	union perf_mem_data_src src;
+	u64 val;
+
+	dse.val = status;
+
+	if (!dse.arw_l2_miss)
+		val = arw_pebs_l2_hit_data_source[dse.arw_dse & 0xf];
+	else
+		val = parse_omr_data_source(dse.arw_dse);
+
+	if (!val)
+		val = P(OP, LOAD) | LEVEL(NA) | P(SNOOP, NA);
+
+	if (dse.arw_stlb_miss)
+		val |= P(TLB, MISS) | P(TLB, L2);
+	else
+		val |= P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
+
+	if (dse.arw_locked)
+		val |= P(LOCK, LOCKED);
+
+	if (dse.arw_data_blk)
+		val |= P(BLK, DATA);
+	if (dse.arw_addr_blk)
+		val |= P(BLK, ADDR);
+	if (!dse.arw_data_blk && !dse.arw_addr_blk)
+		val |= P(BLK, NA);
+
+	src.val = val;
+	if (event->hw.flags & PERF_X86_EVENT_PEBS_ST_HSW)
+		src.mem_op = P(OP, STORE);
+
+	return src.val;
+}
+
 static u64 lnc_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
@@ -551,6 +624,16 @@ u64 pnc_latency_data(struct perf_event *event, u64 status)
 	return src.val;
 }
 
+u64 nvl_latency_data(struct perf_event *event, u64 status)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->pmu_type == hybrid_small)
+		return arw_latency_data(event, status);
+
+	return pnc_latency_data(event, status);
+}
+
 static u64 load_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index cbca1888e8f7..aedc1a7762c2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1666,6 +1666,8 @@ u64 arl_h_latency_data(struct perf_event *event, u64 status);
 
 u64 pnc_latency_data(struct perf_event *event, u64 status);
 
+u64 nvl_latency_data(struct perf_event *event, u64 status);
+
 extern struct event_constraint intel_core2_pebs_event_constraints[];
 
 extern struct event_constraint intel_atom_pebs_event_constraints[];
-- 
2.34.1

