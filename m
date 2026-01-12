Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48030E84F;
	Mon, 12 Jan 2026 05:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768195225; cv=none; b=LYdKAmMvNpI0Ok5eEL7HWbdjI2Gp443mIOotyKiG9OtbrDiJzofcXpVLqXkTtVYE53+7YnIriACmntyFE1lkJ1FRXfcnjE0DzDmnoN3yzWIGEHEA3/jMClLH+mrQeRiMF0dqABvzOFCOi+HgFH6fpx42Wmzfb9EwlV81JUZ6CI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768195225; c=relaxed/simple;
	bh=v8IElGX8i0ySe3uIAhT6UmH/LZEkqPLuMWeaQIuHFnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=te9w9jGJopkIM3oHublCAbOXA4D3RfGkYcQPTTMUnBp+FhnZmc/v4FcBGPZz/T2DXrZ6AVgz0mCWuH+6je09iNM/nytkujP1+rm+yfWeh8UvaL07AhUvsWIYIOtBCO1+rACEhZ+r+AnaKlO+qZEruIjzjJcGS5qYfwQQid7a+vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1nMVbzw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1nMVbzw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768195220; x=1799731220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v8IElGX8i0ySe3uIAhT6UmH/LZEkqPLuMWeaQIuHFnM=;
  b=P1nMVbzwHzQum8nJpP2CL/3xzNzIk0r2YVO2khMna2n60N2waUn7cNPq
   kRMpz/8TES+DVKCs6zhK7rw4dr/+3fMEpbn3TVNfEFlHVnRsv5vhk3w6e
   3bL/dDC/gUFD1q/NSXumi1h7eTJTLhVd8rfsmv1j0wPmx1wqQlt02AkKB
   LRFTw5h2u3VjXEw1EJmxRPmFF1lrouT2ysJdyDU4LgoArd/sen3b+QiJ+
   XhDOHoj3fmcgYIHgfNPyxAM0TnFRm1cGlfyILUZec55/tSbCe9wq0OLwc
   GRU0fLkEK6BepxS0erzJZSplwlDOGumwG/ZDGERXk/4NO/xMBb7THd4dX
   Q==;
X-CSE-ConnectionGUID: 5m2Yy3q+S4WjxuRNFFwGwA==
X-CSE-MsgGUID: 8qay7tw2TkOZ8twm3JMJVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="68673223"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="68673223"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 21:20:20 -0800
X-CSE-ConnectionGUID: 8rJ3zbe/RTuAsNIzTTDqjQ==
X-CSE-MsgGUID: 8M1ThxrDQW2nAJjPWD0Xow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="235233387"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 11 Jan 2026 21:20:16 -0800
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
Subject: [Patch v2 2/7] perf/x86/intel: Add support for PEBS memory auxiliary info field in DMR
Date: Mon, 12 Jan 2026 13:16:44 +0800
Message-Id: <20260112051649.1113435-3-dapeng1.mi@linux.intel.com>
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

With the introduction of the OMR feature, the PEBS memory auxiliary info
field for load and store latency events has been restructured for DMR.

The memory auxiliary info field's bit[8] indicates whether a L2 cache
miss occurred for a memory load or store instruction. If bit[8] is 0,
it signifies no L2 cache miss, and bits[7:0] specify the exact cache data
source (up to the L2 cache level). If bit[8] is 1, bits[7:0] represent
the OMR encoding, indicating the specific L3 cache or memory region
involved in the memory access. A significant enhancement is OMR encoding
provides up to 8 fine-grained memory regions besides the cache region.

A significant enhancement for OMR encoding is the ability to provide
up to 8 fine-grained memory regions in addition to the cache region,
offering more detailed insights into memory access regions.

For detailed information on the memory auxiliary info encoding, please
refer to section 16.2 "PEBS LOAD LATENCY AND STORE LATENCY FACILITY" in
the ISE documentation.

This patch ensures that the PEBS memory auxiliary info field is correctly
interpreted and utilized in DMR.

ISE: https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c            | 140 ++++++++++++++++++++++++++
 arch/x86/events/perf_event.h          |   2 +
 include/uapi/linux/perf_event.h       |  27 ++++-
 tools/include/uapi/linux/perf_event.h |  27 ++++-
 4 files changed, 190 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index feb1c3cf63e4..272e652f25fc 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -34,6 +34,17 @@ struct pebs_record_32 {
 
  */
 
+union omr_encoding {
+	struct {
+		u8 omr_source : 4;
+		u8 omr_remote : 1;
+		u8 omr_hitm : 1;
+		u8 omr_snoop : 1;
+		u8 omr_promoted : 1;
+	};
+	u8 omr_full;
+};
+
 union intel_x86_pebs_dse {
 	u64 val;
 	struct {
@@ -73,6 +84,18 @@ union intel_x86_pebs_dse {
 		unsigned int lnc_addr_blk:1;
 		unsigned int ld_reserved6:18;
 	};
+	struct {
+		unsigned int pnc_dse: 8;
+		unsigned int pnc_l2_miss:1;
+		unsigned int pnc_stlb_clean_hit:1;
+		unsigned int pnc_stlb_any_hit:1;
+		unsigned int pnc_stlb_miss:1;
+		unsigned int pnc_locked:1;
+		unsigned int pnc_data_blk:1;
+		unsigned int pnc_addr_blk:1;
+		unsigned int pnc_fb_full:1;
+		unsigned int ld_reserved8:16;
+	};
 };
 
 
@@ -228,6 +251,85 @@ void __init intel_pmu_pebs_data_source_lnl(void)
 	__intel_pmu_pebs_data_source_cmt(data_source);
 }
 
+/* Version for Panthercove and later */
+
+/* L2 hit */
+#define PNC_PEBS_DATA_SOURCE_MAX	16
+static u64 pnc_pebs_l2_hit_data_source[PNC_PEBS_DATA_SOURCE_MAX] = {
+	P(OP, LOAD) | P(LVL, NA) | LEVEL(NA) | P(SNOOP, NA),	/* 0x00: non-cache access */
+	OP_LH               | LEVEL(L0) | P(SNOOP, NONE),	/* 0x01: L0 hit */
+	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),	/* 0x02: L1 hit */
+	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE),	/* 0x03: L1 Miss Handling Buffer hit */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, NONE),	/* 0x04: L2 Hit Clean */
+	0,							/* 0x05: Reserved */
+	0,							/* 0x06: Reserved */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, HIT),	/* 0x07: L2 Hit Snoop HIT */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, HITM),	/* 0x08: L2 Hit Snoop Hit Modified */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, MISS),	/* 0x09: Prefetch Promotion */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, MISS),	/* 0x0a: Cross Core Prefetch Promotion */
+	0,							/* 0x0b: Reserved */
+	0,							/* 0x0c: Reserved */
+	0,							/* 0x0d: Reserved */
+	0,							/* 0x0e: Reserved */
+	OP_LH | P(LVL, UNC) | LEVEL(NA) | P(SNOOP, NONE),	/* 0x0f: uncached */
+};
+
+/* L2 miss */
+#define OMR_DATA_SOURCE_MAX		16
+static u64 omr_data_source[OMR_DATA_SOURCE_MAX] = {
+	P(OP, LOAD) | P(LVL, NA) | LEVEL(NA) | P(SNOOP, NA),	/* 0x00: invalid */
+	0,							/* 0x01: Reserved */
+	OP_LH | P(LVL, L3) | LEVEL(L3) | P(REGION, L_SHARE),	/* 0x02: local CA shared cache */
+	OP_LH | P(LVL, L3) | LEVEL(L3) | P(REGION, L_NON_SHARE),/* 0x03: local CA non-shared cache */
+	OP_LH | P(LVL, L3) | LEVEL(L3) | P(REGION, O_IO),	/* 0x04: other CA IO agent */
+	OP_LH | P(LVL, L3) | LEVEL(L3) | P(REGION, O_SHARE),	/* 0x05: other CA shared cache */
+	OP_LH | P(LVL, L3) | LEVEL(L3) | P(REGION, O_NON_SHARE),/* 0x06: other CA non-shared cache */
+	OP_LH | LEVEL(RAM) | P(REGION, MMIO),			/* 0x07: MMIO */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM0),			/* 0x08: Memory region 0 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM1),			/* 0x09: Memory region 1 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM2),			/* 0x0a: Memory region 2 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM3),			/* 0x0b: Memory region 3 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM4),			/* 0x0c: Memory region 4 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM5),			/* 0x0d: Memory region 5 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM6),			/* 0x0e: Memory region 6 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM7),			/* 0x0f: Memory region 7 */
+};
+
+static u64 parse_omr_data_source(u8 dse)
+{
+	union omr_encoding omr;
+	u64 val = 0;
+
+	omr.omr_full = dse;
+	val = omr_data_source[omr.omr_source];
+	if (omr.omr_source > 0x1 && omr.omr_source < 0x7)
+		val |= omr.omr_remote ? P(LVL, REM_CCE1) : 0;
+	else if (omr.omr_source > 0x7)
+		val |= omr.omr_remote ? P(LVL, REM_RAM1) : P(LVL, LOC_RAM);
+
+	if (omr.omr_remote)
+		val |= REM;
+
+	val |= omr.omr_hitm ? P(SNOOP, HITM) : P(SNOOP, HIT);
+
+	if (omr.omr_source == 0x2) {
+		u8 snoop = omr.omr_snoop | omr.omr_promoted;
+
+		if (snoop == 0x0)
+			val |= P(SNOOP, NA);
+		else if (snoop == 0x1)
+			val |= P(SNOOP, MISS);
+		else if (snoop == 0x2)
+			val |= P(SNOOP, HIT);
+		else if (snoop == 0x3)
+			val |= P(SNOOP, NONE);
+	} else if (omr.omr_source > 0x2 && omr.omr_source < 0x7) {
+		val |= omr.omr_snoop ? P(SNOOPX, FWD) : 0;
+	}
+
+	return val;
+}
+
 static u64 precise_store_data(u64 status)
 {
 	union intel_x86_pebs_dse dse;
@@ -411,6 +513,44 @@ u64 arl_h_latency_data(struct perf_event *event, u64 status)
 	return lnl_latency_data(event, status);
 }
 
+u64 pnc_latency_data(struct perf_event *event, u64 status)
+{
+	union intel_x86_pebs_dse dse;
+	union perf_mem_data_src src;
+	u64 val;
+
+	dse.val = status;
+
+	if (!dse.pnc_l2_miss)
+		val = pnc_pebs_l2_hit_data_source[dse.pnc_dse & 0xf];
+	else
+		val = parse_omr_data_source(dse.pnc_dse);
+
+	if (!val)
+		val = P(OP, LOAD) | LEVEL(NA) | P(SNOOP, NA);
+
+	if (dse.pnc_stlb_miss)
+		val |= P(TLB, MISS) | P(TLB, L2);
+	else
+		val |= P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
+
+	if (dse.pnc_locked)
+		val |= P(LOCK, LOCKED);
+
+	if (dse.pnc_data_blk)
+		val |= P(BLK, DATA);
+	if (dse.pnc_addr_blk)
+		val |= P(BLK, ADDR);
+	if (!dse.pnc_data_blk && !dse.pnc_addr_blk)
+		val |= P(BLK, NA);
+
+	src.val = val;
+	if (event->hw.flags & PERF_X86_EVENT_PEBS_ST_HSW)
+		src.mem_op = P(OP, STORE);
+
+	return src.val;
+}
+
 static u64 load_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 586e3fdfe6d8..bd501c2a0f73 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1664,6 +1664,8 @@ u64 lnl_latency_data(struct perf_event *event, u64 status);
 
 u64 arl_h_latency_data(struct perf_event *event, u64 status);
 
+u64 pnc_latency_data(struct perf_event *event, u64 status);
+
 extern struct event_constraint intel_core2_pebs_event_constraints[];
 
 extern struct event_constraint intel_atom_pebs_event_constraints[];
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index c44a8fb3e418..533393ec94d0 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1330,14 +1330,16 @@ union perf_mem_data_src {
 			mem_snoopx  :  2, /* Snoop mode, ext */
 			mem_blk     :  3, /* Access blocked */
 			mem_hops    :  3, /* Hop level */
-			mem_rsvd    : 18;
+			mem_region  :  5, /* cache/memory regions */
+			mem_rsvd    : 13;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd    : 18,
+		__u64	mem_rsvd    : 13,
+			mem_region  :  5, /* cache/memory regions */
 			mem_hops    :  3, /* Hop level */
 			mem_blk     :  3, /* Access blocked */
 			mem_snoopx  :  2, /* Snoop mode, ext */
@@ -1394,7 +1396,7 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L4			0x0004 /* L4 */
 #define PERF_MEM_LVLNUM_L2_MHB			0x0005 /* L2 Miss Handling Buffer */
 #define PERF_MEM_LVLNUM_MSC			0x0006 /* Memory-side Cache */
-/* 0x007 available */
+#define PERF_MEM_LVLNUM_L0			0x0007 /* L0 */
 #define PERF_MEM_LVLNUM_UNC			0x0008 /* Uncached */
 #define PERF_MEM_LVLNUM_CXL			0x0009 /* CXL */
 #define PERF_MEM_LVLNUM_IO			0x000a /* I/O */
@@ -1447,6 +1449,25 @@ union perf_mem_data_src {
 /* 5-7 available */
 #define PERF_MEM_HOPS_SHIFT			43
 
+/* Cache/Memory region */
+#define PERF_MEM_REGION_NA		0x0  /* Invalid */
+#define PERF_MEM_REGION_RSVD		0x01 /* Reserved */
+#define PERF_MEM_REGION_L_SHARE		0x02 /* Local CA shared cache */
+#define PERF_MEM_REGION_L_NON_SHARE	0x03 /* Local CA non-shared cache */
+#define PERF_MEM_REGION_O_IO		0x04 /* Other CA IO agent */
+#define PERF_MEM_REGION_O_SHARE		0x05 /* Other CA shared cache */
+#define PERF_MEM_REGION_O_NON_SHARE	0x06 /* Other CA non-shared cache */
+#define PERF_MEM_REGION_MMIO		0x07 /* MMIO */
+#define PERF_MEM_REGION_MEM0		0x08 /* Memory region 0 */
+#define PERF_MEM_REGION_MEM1		0x09 /* Memory region 1 */
+#define PERF_MEM_REGION_MEM2		0x0a /* Memory region 2 */
+#define PERF_MEM_REGION_MEM3		0x0b /* Memory region 3 */
+#define PERF_MEM_REGION_MEM4		0x0c /* Memory region 4 */
+#define PERF_MEM_REGION_MEM5		0x0d /* Memory region 5 */
+#define PERF_MEM_REGION_MEM6		0x0e /* Memory region 6 */
+#define PERF_MEM_REGION_MEM7		0x0f /* Memory region 7 */
+#define PERF_MEM_REGION_SHIFT		46
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index c44a8fb3e418..d4b99610a3b0 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1330,14 +1330,16 @@ union perf_mem_data_src {
 			mem_snoopx  :  2, /* Snoop mode, ext */
 			mem_blk     :  3, /* Access blocked */
 			mem_hops    :  3, /* Hop level */
-			mem_rsvd    : 18;
+			mem_region  :  5, /* cache/memory regions */
+			mem_rsvd    : 13;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd    : 18,
+		__u64	mem_rsvd    : 13,
+			mem_region  :  5, /* cache/memory regions */
 			mem_hops    :  3, /* Hop level */
 			mem_blk     :  3, /* Access blocked */
 			mem_snoopx  :  2, /* Snoop mode, ext */
@@ -1394,7 +1396,7 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L4			0x0004 /* L4 */
 #define PERF_MEM_LVLNUM_L2_MHB			0x0005 /* L2 Miss Handling Buffer */
 #define PERF_MEM_LVLNUM_MSC			0x0006 /* Memory-side Cache */
-/* 0x007 available */
+#define PERF_MEM_LVLNUM_L0			0x0007   /* L0 */
 #define PERF_MEM_LVLNUM_UNC			0x0008 /* Uncached */
 #define PERF_MEM_LVLNUM_CXL			0x0009 /* CXL */
 #define PERF_MEM_LVLNUM_IO			0x000a /* I/O */
@@ -1447,6 +1449,25 @@ union perf_mem_data_src {
 /* 5-7 available */
 #define PERF_MEM_HOPS_SHIFT			43
 
+/* Cache/Memory region */
+#define PERF_MEM_REGION_NA		0x0  /* Invalid */
+#define PERF_MEM_REGION_RSVD		0x01 /* Reserved */
+#define PERF_MEM_REGION_L_SHARE		0x02 /* Local CA shared cache */
+#define PERF_MEM_REGION_L_NON_SHARE	0x03 /* Local CA non-shared cache */
+#define PERF_MEM_REGION_O_IO		0x04 /* Other CA IO agent */
+#define PERF_MEM_REGION_O_SHARE		0x05 /* Other CA shared cache */
+#define PERF_MEM_REGION_O_NON_SHARE	0x06 /* Other CA non-shared cache */
+#define PERF_MEM_REGION_MMIO		0x07 /* MMIO */
+#define PERF_MEM_REGION_MEM0		0x08 /* Memory region 0 */
+#define PERF_MEM_REGION_MEM1		0x09 /* Memory region 1 */
+#define PERF_MEM_REGION_MEM2		0x0a /* Memory region 2 */
+#define PERF_MEM_REGION_MEM3		0x0b /* Memory region 3 */
+#define PERF_MEM_REGION_MEM4		0x0c /* Memory region 4 */
+#define PERF_MEM_REGION_MEM5		0x0d /* Memory region 5 */
+#define PERF_MEM_REGION_MEM6		0x0e /* Memory region 6 */
+#define PERF_MEM_REGION_MEM7		0x0f /* Memory region 7 */
+#define PERF_MEM_REGION_SHIFT		46
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 
-- 
2.34.1

