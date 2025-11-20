Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA30302CDB;
	Thu, 20 Nov 2025 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763617040; cv=none; b=pQQ0RZlCXVuqtXwB8SYVKiR6h+xj8S3d5HeaCt0WgvQoRPPe8lVe76FgRiM0zLp4Z41bKowEeZxFSLph/fvAoB1Zat8ugtxBYKhKYZmpxt1tJ+B6fOPSZ9HoWxmCNnYGstIlmsV+nyz3qeAUJdSupnPqI/R/4dL0T2P2NyrNiRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763617040; c=relaxed/simple;
	bh=3nPLc6AN1mkX+nVuqsfQbjvdtBX9H5HtKheVv+b1h9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EwijTCOo+5ReDWeKGmqnhCU4WD8zJq9ePVJPIguBRZlOE7BgCYvTIwN+M0uWpIq6aXbYkHyfXJmNdvU0cXvCIfV6pBoNgQTfuPFgGZxG6nsFpymQrs4H7y5ISENGxrUAv82Lty29MYSVltPjp7v+U7zyrMVxwiNBoOmHCnvQ2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjOturJI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjOturJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763617039; x=1795153039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3nPLc6AN1mkX+nVuqsfQbjvdtBX9H5HtKheVv+b1h9A=;
  b=cjOturJICN9pNaKVLw5CXyfKODyVUr7HKPWbSfYKj6JVFffoD/h/wV/g
   BexKDoM+dezy3b7KVLF5F8MLTsHfIuunAZd8mhyyjwEBCfQNOm9AOlKyh
   IFXIrvR9+qlUcNkSOvQzlAWxLkhuCXgvHqypQExNcfKcvWqSTrWFgTGO2
   e60mtuxDvJwXkZdKIQFZqSHri7Y97GjPjRGm0C55J/1tzmQ3tj7npYQkE
   NWoTT/wuucO6EJcT3Tx7bzrY8c1phNrBpdzlAg6Y00nazIy1OlQsLkCMU
   8tz8mAYoyHW770xH1rwX7kq1jMSZk+5AhTK3EIbBiEmKmWVTqYDiGjBA8
   w==;
X-CSE-ConnectionGUID: dWX0Wk78QFC9nh+sNdRhmA==
X-CSE-MsgGUID: XOr0M8LZTyOru+CfUrcWrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65710178"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65710178"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 21:37:18 -0800
X-CSE-ConnectionGUID: Om2IvvEGQJep3KQtk39gBQ==
X-CSE-MsgGUID: ZwCqrg9eQjev8y/ip9gpZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="191055559"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Nov 2025 21:37:15 -0800
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
Subject: [PATCH 4/7] perf/x86/intel: Add support for PEBS memory auxiliary info field in NVL
Date: Thu, 20 Nov 2025 13:34:28 +0800
Message-Id: <20251120053431.491677-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
References: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
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
index 0db6ffc7007e..d082eb160a10 100644
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
@@ -457,6 +492,44 @@ u64 cmt_latency_data(struct perf_event *event, u64 status)
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
@@ -550,6 +623,16 @@ u64 pnc_latency_data(struct perf_event *event, u64 status)
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

