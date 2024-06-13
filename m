Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE96130485;
	Thu, 13 Jun 2024 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249802; cv=none; b=ZZ5DGRmNkPrBGLxGFnmsdmlq/IJIZ8eTYBngpipHAGVdUdp8baTf9m02bpVdemmsCXtaNNG5q84NofwSdrvwAR++RYTQriBlIFddlAvj2+Z7ycOPkyLVOzGKo9PU4J8bwbbULCoLkieTaBqgZsxr99fHKgJqhBdDuAG125vfL3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249802; c=relaxed/simple;
	bh=DBH6FhtjpA/n4ZLwnFAI6tJE3vc/p+aOeOopI2EIROM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvr2gcXOTtQekRfYotwSLLIiQcS/gvo2YA7yAxNU//RD3LDSXhOBnWcX1l3LI2JYz1d4Zyyij28u/l5uyC963UHwuII3fo1Oywz065D8s0kUdPP+4NfjFTs4xvUmGu7Ik5n+jGm4lAF5dHkJGQkTFOpzBP6YsTJ1jtGz4ofSgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i0UEdVlD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0UEdVlD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718249797; x=1749785797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DBH6FhtjpA/n4ZLwnFAI6tJE3vc/p+aOeOopI2EIROM=;
  b=i0UEdVlDi1XR73O5OkXzt1y62WY2lQttnnhmolNvPjHN3z1TulGa7ZBo
   kFoG/XDqDPsosYHvB8zPnpJD1O6Kz79OQ8+pPtpQOmdx0dyfS0SrnfCBU
   AI2P/efmx4jMMVwW6vzQkltk1J0WmPAkUiLikEK/ecG7VeI7GRUJmy1iz
   +RiLIW4b8EAxEledRewaNd+TQqdVzDcV3lQMC+JLLwjhu3KIXmbJ6jftq
   oTyfwJqhjF5bENd+qiB3j5+842TV4op2qGU9gK+e24DKRRKuSurmGWHO3
   zPyXaEWI71hT1zbmFk3lx1mQiW7H/9Hetl9xBZUhHJkB2UPqjX0pHVZGR
   A==;
X-CSE-ConnectionGUID: dTzpsx/lTgOOlaDB5u6MDA==
X-CSE-MsgGUID: l0JCjhZETlG7QYX44VBNuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="12046702"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="12046702"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 20:36:36 -0700
X-CSE-ConnectionGUID: xHr5AA9bSUW800V/olV1Hw==
X-CSE-MsgGUID: +wJ1CIDzTUi/46Ign9mTHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40100343"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa009.fm.intel.com with ESMTP; 12 Jun 2024 20:36:35 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v13 1/9] Add fake testing metrics for GNR
Date: Wed, 12 Jun 2024 23:36:21 -0400
Message-ID: <20240613033631.199800-2-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613033631.199800-1-weilin.wang@intel.com>
References: <20240613033631.199800-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Update GNR metric json

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 .../arch/x86/graniterapids/cache.json         | 686 ++++++++++++++
 .../arch/x86/graniterapids/frontend.json      | 425 +++++++++
 .../arch/x86/graniterapids/gnr-metrics.json   | 108 +++
 .../arch/x86/graniterapids/memory.json        | 169 ++--
 .../arch/x86/graniterapids/metricgroups.json  | 118 +++
 .../arch/x86/graniterapids/pipeline.json      | 881 ++++++++++++++++++
 6 files changed, 2330 insertions(+), 57 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json b/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
index 56212827870c..28fa3a2e568b 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
@@ -1,4 +1,110 @@
 [
+    {
+        "BriefDescription": "L1D.HWPF_MISS",
+        "EventCode": "0x51",
+        "EventName": "L1D.HWPF_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines replaced in L1 data cache.",
+        "EventCode": "0x51",
+        "EventName": "L1D.REPLACEMENT",
+        "PublicDescription": "Counts L1D data line replacements including opportunistic replacements, and replacements that require stall-for-replace or block-for-replace.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of cycles a demand request has waited due to L1D Fill Buffer (FB) unavailability.",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.FB_FULL",
+        "PublicDescription": "Counts number of cycles a demand request has waited due to L1D Fill Buffer (FB) unavailability. Demand requests include cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of phases a demand request has waited due to L1D Fill Buffer (FB) unavailability.",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
+        "PublicDescription": "Counts number of phases a demand request has waited due to L1D Fill Buffer (FB) unavailability. Demand requests include cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of cycles a demand request has waited due to L1D due to lack of L2 resources.",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.L2_STALLS",
+        "PublicDescription": "Counts number of cycles a demand request has waited due to L1D due to lack of L2 resources. Demand requests include cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of L1D misses that are outstanding",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.PENDING",
+        "PublicDescription": "Counts number of L1D misses that are outstanding in each cycle, that is each cycle the number of Fill Buffers (FB) outstanding required by Demand Reads. FB either is held by demand loads, or it is held by non-demand loads and gets hit at least once by demand. The valid outstanding interval is defined until the FB deallocation by one of the following ways: from FB allocation, if FB is allocated by demand from the demand Hit FB, if it is allocated by hardware or software prefetch. Note: In the L1D, a Demand Read contains cacheable or noncacheable demand loads, including ones causing cache-line splits and reads due to page walks resulted from any request type.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles with L1D load Misses outstanding.",
+        "CounterMask": "1",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
+        "PublicDescription": "Counts duration of L1D miss outstanding in cycles.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "L2 cache lines filling L2",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.ALL",
+        "PublicDescription": "Counts the number of L2 cache lines filling the L2. Counting does not cover rejects.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1f"
+    },
+    {
+        "BriefDescription": "Modified cache lines that are evicted by L2 cache when triggered by an L2 cache fill.",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.NON_SILENT",
+        "PublicDescription": "Counts the number of lines that are evicted by L2 cache when triggered by an L2 cache fill. Those lines are in Modified state. Modified lines are written back to L3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Non-modified cache lines that are silently dropped by L2 cache when triggered by an L2 cache fill.",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.SILENT",
+        "PublicDescription": "Counts the number of lines that are silently dropped by L2 cache when triggered by an L2 cache fill. These lines are typically in Shared or Exclusive state. A non-threaded event.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "All accesses to L2 cache [This event is alias to L2_RQSTS.REFERENCES]",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.ALL",
+        "PublicDescription": "Counts all requests that were hit or true misses in L2 cache. True-miss excludes misses that were merged with ongoing L2 misses. [This event is alias to L2_RQSTS.REFERENCES]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event is alias to L2_RQSTS.HIT]",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This event is alias to L2_RQSTS.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf"
+    },
+    {
+        "BriefDescription": "Read requests with true-miss in L2 cache [This event is alias to L2_RQSTS.MISS]",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.MISS",
+        "PublicDescription": "Counts read requests of any type with true-miss in the L2 cache. True-miss excludes L2 misses that were merged with ongoing L2 misses. [This event is alias to L2_RQSTS.MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x3f"
+    },
     {
         "BriefDescription": "L2 code requests",
         "EventCode": "0x24",
@@ -15,6 +121,124 @@
         "SampleAfterValue": "200003",
         "UMask": "0xe1"
     },
+    {
+        "BriefDescription": "Demand requests that miss L2 cache",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
+        "PublicDescription": "Counts demand requests that miss L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x27"
+    },
+    {
+        "BriefDescription": "Demand requests to L2 cache",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_DEMAND_REFERENCES",
+        "PublicDescription": "Counts demand requests to L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe7"
+    },
+    {
+        "BriefDescription": "L2_RQSTS.ALL_HWPF",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_HWPF",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf0"
+    },
+    {
+        "BriefDescription": "RFO requests to L2 cache",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_RFO",
+        "PublicDescription": "Counts the total number of RFO (read for ownership) requests to L2 cache. L2 RFO requests include both L1D demand RFO misses as well as L1D RFO prefetches.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe2"
+    },
+    {
+        "BriefDescription": "L2 cache hits when fetching instructions, code reads.",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.CODE_RD_HIT",
+        "PublicDescription": "Counts L2 cache hits when fetching instructions, code reads.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc4"
+    },
+    {
+        "BriefDescription": "L2 cache misses when fetching instructions",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.CODE_RD_MISS",
+        "PublicDescription": "Counts L2 cache misses when fetching instructions.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x24"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests that hit L2 cache",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
+        "PublicDescription": "Counts the number of demand Data Read requests initiated by load instructions that hit L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc1"
+    },
+    {
+        "BriefDescription": "Demand Data Read miss L2 cache",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
+        "PublicDescription": "Counts demand Data Read requests with true-miss in the L2 cache. True-miss excludes misses that were merged with ongoing L2 misses. An access is counted once.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event is alias to L2_REQUEST.HIT]",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This event is alias to L2_REQUEST.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf"
+    },
+    {
+        "BriefDescription": "L2_RQSTS.HWPF_MISS",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.HWPF_MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x30"
+    },
+    {
+        "BriefDescription": "Read requests with true-miss in L2 cache [This event is alias to L2_REQUEST.MISS]",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.MISS",
+        "PublicDescription": "Counts read requests of any type with true-miss in the L2 cache. True-miss excludes L2 misses that were merged with ongoing L2 misses. [This event is alias to L2_REQUEST.MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x3f"
+    },
+    {
+        "BriefDescription": "All accesses to L2 cache [This event is alias to L2_REQUEST.ALL]",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.REFERENCES",
+        "PublicDescription": "Counts all requests that were hit or true misses in L2 cache. True-miss excludes misses that were merged with ongoing L2 misses. [This event is alias to L2_REQUEST.ALL]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "RFO requests that hit L2 cache",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_HIT",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests that hit L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc2"
+    },
+    {
+        "BriefDescription": "RFO requests that miss L2 cache",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_MISS",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests that miss L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x22"
+    },
+    {
+        "BriefDescription": "L2 writebacks that access L2 cache",
+        "EventCode": "0x23",
+        "EventName": "L2_TRANS.L2_WB",
+        "PublicDescription": "Counts L2 writebacks that access L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x40"
+    },
     {
         "BriefDescription": "Core-originated cacheable requests that missed L3  (Except hardware prefetches to the L3)",
         "EventCode": "0x2e",
@@ -50,5 +274,467 @@
         "PublicDescription": "Counts all retired store instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x82"
+    },
+    {
+        "BriefDescription": "All retired memory instructions.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ANY",
+        "PEBS": "1",
+        "PublicDescription": "Counts all retired memory instructions - loads and stores.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x83"
+    },
+    {
+        "BriefDescription": "Retired load instructions with locked access.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with locked access.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "Retired load instructions that split across a cacheline boundary.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions that split across a cacheline boundary.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Retired store instructions that split across a cacheline boundary.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired store instructions that split across a cacheline boundary.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x42"
+    },
+    {
+        "BriefDescription": "Retired load instructions that hit the STLB.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_HIT_LOADS",
+        "PEBS": "1",
+        "PublicDescription": "Number of retired load instructions with a clean hit in the 2nd-level TLB (STLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x9"
+    },
+    {
+        "BriefDescription": "Retired store instructions that hit the STLB.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_HIT_STORES",
+        "PEBS": "1",
+        "PublicDescription": "Number of retired store instructions that hit in the 2nd-level TLB (STLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0xa"
+    },
+    {
+        "BriefDescription": "Retired load instructions that miss the STLB.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
+        "PEBS": "1",
+        "PublicDescription": "Number of retired load instructions that (start a) miss in the 2nd-level TLB (STLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Retired store instructions that miss the STLB.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
+        "PEBS": "1",
+        "PublicDescription": "Number of retired store instructions that (start a) miss in the 2nd-level TLB (STLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x12"
+    },
+    {
+        "BriefDescription": "Completed demand load uops that miss the L1 d-cache.",
+        "EventCode": "0x43",
+        "EventName": "MEM_LOAD_COMPLETED.L1_MISS_ANY",
+        "PublicDescription": "Number of completed demand load requests that missed the L1 data cache including shadow misses (FB hits, merge to an ongoing L1D miss)",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xfd"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources were HitM responses from shared L3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions whose data sources were HitM responses from shared L3.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources were L3 and cross-core snoop hits in on-pkg core cache",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions whose data sources were L3 and cross-core snoop hits in on-pkg core cache.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources were HitM responses from shared L3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions whose data sources were HitM responses from shared L3.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
+        "PEBS": "1",
+        "PublicDescription": "Counts the retired load instructions whose data sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources were hits in L3 without snoops required",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions whose data sources were hits in L3 without snoops required.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources were L3 and cross-core snoop hits in on-pkg core cache",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions whose data sources were L3 and cross-core snoop hits in on-pkg core cache.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired load instructions which data sources missed L3 but serviced from local dram",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
+        "PEBS": "1",
+        "PublicDescription": "Retired load instructions which data sources missed L3 but serviced from local DRAM.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources was forwarded from a remote cache",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD",
+        "PEBS": "1",
+        "PublicDescription": "Retired load instructions whose data sources was forwarded from a remote cache.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Retired instructions with at least 1 uncacheable load or lock.",
+        "Data_LA": "1",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_MISC_RETIRED.UC",
+        "PEBS": "1",
+        "PublicDescription": "Retired instructions with at least one load to uncacheable memory-type, or at least one cache-line split locked access (Bus Lock).",
+        "SampleAfterValue": "100007",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of completed demand load requests that missed the L1, but hit the FB(fill buffer), because a preceding miss to the same cacheline initiated the line to be brought into L1, but data is not yet ready in L1.",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.FB_HIT",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at least one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding miss to the same cache line with data not ready.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L1 cache hits as data sources",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at least one uop that hit in the L1 data cache. This event includes all SW prefetches and lock instructions regardless of the data source.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L1 cache as data sources",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_MISS",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at least one uop that missed in the L1 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L2 cache hits as data sources",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_HIT",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with L2 cache hits as data sources.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L2 cache as data sources",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_MISS",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions missed L2 cache as data sources.",
+        "SampleAfterValue": "100021",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L3 cache hits as data sources",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L3_HIT",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at least one uop that hit in the L3 cache.",
+        "SampleAfterValue": "100021",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L3 cache as data sources",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L3_MISS",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at least one uop that missed in the L3 cache.",
+        "SampleAfterValue": "50021",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "MEM_STORE_RETIRED.L2_HIT",
+        "EventCode": "0x44",
+        "EventName": "MEM_STORE_RETIRED.L2_HIT",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired memory uops for any access",
+        "EventCode": "0xe5",
+        "EventName": "MEM_UOP_RETIRED.ANY",
+        "PublicDescription": "Number of retired micro-operations (uops) for load or store memory accesses",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that resulted in a snoop hit a modified line in another core's caches which forwarded the data.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that resulted in a snoop hit in another core's caches which forwarded the unmodified data to the requesting core.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that resulted in a snoop hit a modified line in another core's caches which forwarded the data.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Any memory transaction that reached the SQ.",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
+        "PublicDescription": "Counts memory transactions reached the super queue including requests initiated by the core, all L3 prefetches, page walks, etc..",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Demand and prefetch data reads",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DATA_RD",
+        "PublicDescription": "Counts the demand and prefetch data reads. All Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 prefetchers). Counting also covers reads due to page walks resulted from any request type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cacheable and Non-Cacheable code read requests",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
+        "PublicDescription": "Counts both cacheable and Non-Cacheable code read requests.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests sent to uncore",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
+        "PublicDescription": "Counts the Demand Data Read requests sent to uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determine average latency in the uncore.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Demand RFO requests including regular RFOs, locks, ItoM",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
+        "PublicDescription": "Counts the demand RFO (read for ownership) requests including regular RFOs, locks, ItoM.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles when offcore outstanding cacheable Core Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "PublicDescription": "Counts cycles when offcore outstanding cacheable Core Data Read transactions are present in the super queue. A transaction is considered to be in the Offcore outstanding state between L2 miss and transaction completion sent to requestor (SQ de-allocation). See corresponding Umask under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles with offcore outstanding Code Reads transactions in the SuperQueue (SQ), queue to uncore.",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE_RD",
+        "PublicDescription": "Counts the number of offcore outstanding Code Reads transactions in the super queue every cycle. The 'Offcore outstanding' state of the transaction lasts from the L2 miss until the sending transaction completion to requestor (SQ deallocation). See the corresponding Umask under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles where at least 1 outstanding demand data read request is pending.",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA_RD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles with offcore outstanding demand rfo reads transactions in SuperQueue (SQ), queue to uncore.",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO",
+        "PublicDescription": "Counts the number of offcore outstanding demand rfo Reads transactions in the super queue every cycle. The 'Offcore outstanding' state of the transaction lasts from the L2 miss until the sending transaction completion to requestor (SQ deallocation). See the corresponding Umask under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Offcore outstanding Code Reads transactions in the SuperQueue (SQ), queue to uncore, every cycle.",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
+        "PublicDescription": "Counts the number of offcore outstanding Code Reads transactions in the super queue every cycle. The 'Offcore outstanding' state of the transaction lasts from the L2 miss until the sending transaction completion to requestor (SQ deallocation). See the corresponding Umask under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "For every cycle, increments by the number of outstanding demand data read requests pending.",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
+        "PublicDescription": "For every cycle, increments by the number of outstanding demand data read requests pending.   Requests are considered outstanding from the time they miss the core's L2 cache until the transaction completion message is sent to the requestor.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles with at least 6 offcore outstanding Demand Data Read transactions in uncore queue.",
+        "CounterMask": "6",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD_GE_6",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Store Read transactions pending for off-core. Highly correlated.",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
+        "PublicDescription": "Counts the number of off-core outstanding read-for-ownership (RFO) store transactions every cycle. An RFO transaction is considered to be in the Off-core outstanding state between L2 cache miss and transaction completion.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts bus locks, accounts for cache line split locks and UC locks.",
+        "EventCode": "0x2c",
+        "EventName": "SQ_MISC.BUS_LOCK",
+        "PublicDescription": "Counts the more expensive bus lock needed to enforce cache coherency for certain memory accesses that need to be done atomically.  Can be created by issuing an atomic instruction (via the LOCK prefix) which causes a cache line split or accesses uncacheable memory.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHNTA instructions executed.",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.NTA",
+        "PublicDescription": "Counts the number of PREFETCHNTA instructions executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHW instructions executed.",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
+        "PublicDescription": "Counts the number of PREFETCHW instructions executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.T0",
+        "PublicDescription": "Counts the number of PREFETCHT0 instructions executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed.",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT2 instructions executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json b/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
index c6d5016e7337..4fa1c82509ae 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
@@ -1,4 +1,383 @@
 [
+    {
+        "BriefDescription": "Clears due to Unknown Branches.",
+        "EventCode": "0x60",
+        "EventName": "BACLEARS.ANY",
+        "PublicDescription": "Number of times the front-end is resteered when it finds a branch instruction in a fetch line. This is called Unknown Branch which occurs for the first time a branch instruction is fetched or when the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Stalls caused by changing prefix length of the instruction.",
+        "EventCode": "0x87",
+        "EventName": "DECODE.LCP",
+        "PublicDescription": "Counts cycles that the Instruction Length decoder (ILD) stalls occurred due to dynamically changing prefix length of the decoded instruction (by operand size prefix instruction 0x66, address size prefix instruction 0x67 or REX.W for Intel64). Count is proportional to the number of prefixes in a 16B-line. This may result in a three-cycle penalty for each LCP (Length changing prefix) in a 16-byte chunk.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles the Microcode Sequencer is busy.",
+        "EventCode": "0x87",
+        "EventName": "DECODE.MS_BUSY",
+        "SampleAfterValue": "500009",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "DSB-to-MITE switch true penalty cycles.",
+        "EventCode": "0x61",
+        "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
+        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache that holds translations of previously fetched instructions that were decoded by the legacy x86 decode pipeline (MITE). This event counts fetch penalty cycles when a transition occurs from DSB to MITE.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "DSB_FILL.FB_STALL_OT",
+        "EventCode": "0x62",
+        "EventName": "DSB_FILL.FB_STALL_OT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Retired ANT branches",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ANY_ANT",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x9",
+        "PEBS": "1",
+        "PublicDescription": "Always Not Taken (ANT) conditional retired branches (no BTB entry and not mispredicted)",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced DSB miss.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x1",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired Instructions that experienced DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced a critical DSB miss.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DSB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x11",
+        "PEBS": "1",
+        "PublicDescription": "Number of retired Instructions that experienced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache) miss. Critical means stalls were exposed to the back-end as a result of the DSB miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced iTLB true miss.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ITLB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x14",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired Instructions that experienced iTLB (Instruction TLB) true miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced Instruction L1 Cache true miss.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.L1I_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x12",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired Instructions who experienced Instruction L1 Cache true miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced Instruction L2 Cache true miss.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.L2_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x13",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired Instructions who experienced Instruction L2 Cache true miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions after front-end starvation of at least 1 cycle",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600106",
+        "PEBS": "1",
+        "PublicDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of at least 1 cycle which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 128 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x608006",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 128 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 16 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x601006",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are delivered to the back-end after a front-end stall of at least 16 cycles. During this period the front-end delivered no uops.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions after front-end starvation of at least 2 cycles",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600206",
+        "PEBS": "1",
+        "PublicDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of at least 2 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 256 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x610006",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 256 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end had at least 1 bubble-slot for a period of 2 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x100206",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are delivered to the back-end after the front-end had at least 1 bubble-slot for a period of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there was no RAT stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 32 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x602006",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are delivered to the back-end after a front-end stall of at least 32 cycles. During this period the front-end delivered no uops.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 4 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600406",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 4 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 512 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x620006",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 512 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 64 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x604006",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 64 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 8 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600806",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are delivered to the back-end after a front-end stall of at least 8 cycles. During this period the front-end delivered no uops.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Mispredicted Retired ANT branches",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.MISP_ANT",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x9",
+        "PEBS": "1",
+        "PublicDescription": "ANT retired branches that got just mispredicted",
+        "SampleAfterValue": "100007",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "FRONTEND_RETIRED.MS_FLOWS",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.MS_FLOWS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x8",
+        "PEBS": "1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced STLB (2nd level TLB) true miss.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.STLB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x15",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired Instructions that experienced STLB (2nd level TLB) true miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x17",
+        "PEBS": "1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L1 instruction cache miss.",
+        "EventCode": "0x80",
+        "EventName": "ICACHE_DATA.STALLS",
+        "PublicDescription": "Counts cycles where a code line fetch is stalled due to an L1 instruction cache miss. The decode pipeline works at a 32 Byte granularity.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "ICACHE_DATA.STALL_PERIODS",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x80",
+        "EventName": "ICACHE_DATA.STALL_PERIODS",
+        "SampleAfterValue": "500009",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Instruction fetch tag lookups that hit in the instruction cache (L1I). Counts at 64-byte cache-line granularity.",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.HIT",
+        "PublicDescription": "Counts instruction fetch tag lookups that hit in the instruction cache (L1I). Counts at 64-byte cache-line granularity. Accounts for both cacheable and uncacheable accesses.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L1 instruction cache tag miss.",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS",
+        "PublicDescription": "Counts cycles where a code fetch is stalled due to L1 instruction cache tag miss.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is delivering any Uop",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_CYCLES_ANY",
+        "PublicDescription": "Counts the number of cycles uops were delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles DSB is delivering optimal number of Uops",
+        "CounterMask": "6",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_CYCLES_OK",
+        "PublicDescription": "Counts the number of cycles where optimal number of uops was delivered to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipeline) path. During these cycles uops are not being delivered from the Decode Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_UOPS",
+        "PublicDescription": "Counts the number of uops delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles MITE is delivering any Uop",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_CYCLES_ANY",
+        "PublicDescription": "Counts the number of cycles uops were delivered to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipeline) path. During these cycles uops are not being delivered from the Decode Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles MITE is delivering optimal number of Uops",
+        "CounterMask": "6",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_CYCLES_OK",
+        "PublicDescription": "Counts the number of cycles where optimal number of uops was delivered to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipeline) path. During these cycles uops are not being delivered from the Decode Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) from MITE path",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_UOPS",
+        "PublicDescription": "Counts the number of uops delivered to Instruction Decode Queue (IDQ) from the MITE path. This also means that uops are not being delivered from the Decode Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles when uops are being delivered to IDQ while MS is busy",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_CYCLES_ANY",
+        "PublicDescription": "Counts cycles during which uops are being delivered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Number of switches from DSB or MITE to the MS",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_SWITCHES",
+        "PublicDescription": "Number of switches from DSB (Decode Stream Buffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Uops initiated by MITE or Decode Stream Buffer (DSB) and delivered to Instruction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_UOPS",
+        "PublicDescription": "Counts the number of uops initiated by MITE or Decode Stream Buffer (DSB) and delivered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS) is busy. Counting includes uops that may 'bypass' the IDQ.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slots event that were no operation was delivered to the back-end pipeline due to instruction fetch limitations when the back-end could have accepted more operations. Common examples include instruction cache misses or x86 instruction decode limitations.",
         "EventCode": "0x9c",
@@ -6,5 +385,51 @@
         "PublicDescription": "This event counts a subset of the Topdown Slots event that were no operation was delivered to the back-end pipeline due to instruction fetch limitations when the back-end could have accepted more operations. Common examples include instruction cache misses or x86 instruction decode limitations.\nThe count may be distributed among unhalted logical processors (hyper-threads) who share the same physical core, in processors that support Intel Hyper-Threading Technology. Software can use this event as the numerator for the Frontend Bound metric (or top-level category) of the Top-down Microarchitecture Analysis method.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when no uops are not delivered by the IDQ when backend of the machine is not stalled [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE]",
+        "CounterMask": "6",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE",
+        "PublicDescription": "Counts the number of cycles when no uops were delivered by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when optimal number of uops was delivered to the back-end when the back-end is not stalled [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK]",
+        "CounterMask": "1",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CYCLES_FE_WAS_OK",
+        "Invert": "1",
+        "PublicDescription": "Counts the number of cycles when the optimal number of uops were delivered by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Uops not delivered by IDQ when backend of the machine is not stalled",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
+        "PublicDescription": "Counts the number of uops not delivered to by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when no uops are not delivered by the IDQ when backend of the machine is not stalled [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE]",
+        "CounterMask": "6",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
+        "PublicDescription": "Counts the number of cycles when no uops were delivered by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when optimal number of uops was delivered to the back-end when the back-end is not stalled [This event is alias to IDQ_BUBBLES.CYCLES_FE_WAS_OK]",
+        "CounterMask": "1",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
+        "Invert": "1",
+        "PublicDescription": "Counts the number of cycles when the optimal number of uops were delivered by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_FE_WAS_OK]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json b/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
new file mode 100644
index 000000000000..a7da56a6493d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
@@ -0,0 +1,108 @@
+[
+	{
+		"BriefDescription": "TPEBS testing metric",
+		"MetricExpr": " min((MEM_LOAD_RETIRED.L3_HIT * MEM_LOAD_RETIRED.L3_HIT:R * ( 1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2 ) / CPU_CLK_UNHALTED.THREAD), 1)",
+		"MetricGroup": "",
+		"MetricName": "tma_l3_hit_latency",
+		"ScaleUnit": "100%"
+	},
+	{
+			"BriefDescription": "TPEBS testing metric",
+			"MetricExpr": "BR_MISP_RETIRED.COND_NTAKEN_COST * BR_MISP_RETIRED.COND_NTAKEN_COST:R / CPU_CLK_UNHALTED.THREAD",
+			"MetricGroup": "",
+			"MetricName": "tma_cond_nt_mispredicts",
+			"ScaleUnit": "100%"
+	},
+	{
+			"BriefDescription": "TPEBS testing metric",
+			"MetricExpr": "BR_MISP_RETIRED.COND_TAKEN_COST * BR_MISP_RETIRED.COND_TAKEN_COST:R / CPU_CLK_UNHALTED.THREAD",
+			"MetricGroup": "",
+			"MetricName": "tma_cond_tk_mispredicts",
+			"ScaleUnit": "100%"
+	},
+	{
+		"BriefDescription": "TPEBS testing metric",
+		"MetricExpr": "min((MEM_INST_RETIRED.STLB_HIT_STORES * MEM_INST_RETIRED.STLB_HIT_STORES:R + MEM_INST_RETIRED.STLB_MISS_STORES * MEM_INST_RETIRED.STLB_MISS_STORES:R) / CPU_CLK_UNHALTED.THREAD, 1)",
+		"MetricGroup": "",
+		"MetricName": "tma_dtlb_store",
+		"ScaleUnit": "100%"
+	},
+	{
+		"BriefDescription": "TPEBS testing metric",
+		"MetricExpr": "min(tma_dtlb_store - tma_store_stlb_miss, 1)",
+		"MetricGroup": "",
+		"MetricName": "tma_store_stlb_hit",
+		"ScaleUnit": "100%"
+	},
+	{
+		"BriefDescription": "TPEBS testing metric",
+		"MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES * MEM_INST_RETIRED.SPLIT_STORES:R / CPU_CLK_UNHALTED.THREAD",
+		"MetricGroup": "",
+		"MetricName": "tma_split_stores",
+		"ScaleUnit": "100%"
+	},
+	{
+		"BriefDescription": "TPEBS testing metric",
+		"MetricExpr": "min( MEM_INST_RETIRED.STLB_MISS_STORES * MEM_INST_RETIRED.STLB_MISS_STORES:R / CPU_CLK_UNHALTED.THREAD, 1 )",
+		"MetricGroup": "",
+		"MetricName": "tma_store_stlb_miss",
+		"ScaleUnit": "100%"
+	},
+	{
+		"BriefDescription": "TPEBS testing metric",
+		"MetricExpr": "FRONTEND_RETIRED.L1I_MISS * FRONTEND_RETIRED.L1I_MISS:R / CPU_CLK_UNHALTED.THREAD - FRONTEND_RETIRED.L2_MISS * FRONTEND_RETIRED.L2_MISS:R / CPU_CLK_UNHALTED.THREAD ",
+		"MetricGroup": "",
+		"MetricName": "tma_code_l2_hit",
+		"ScaleUnit": "100%"
+	},
+	{
+		"BriefDescription": "TPEBS testing metric",
+		"MetricExpr": "FRONTEND_RETIRED.L1I_MISS * cpu_core@RONTEND_RETIRED.L1I_MISS@R / CPU_CLK_UNHALTED.THREAD - FRONTEND_RETIRED.L2_MISS * FRONTEND_RETIRED.L2_MISS:R / CPU_CLK_UNHALTED.THREAD ",
+		"MetricGroup": "",
+		"MetricName": "tma_code_l2_hit_fake_r",
+		"ScaleUnit": "100%"
+	},
+	{
+		"BriefDescription": "TPEBS testing metric",
+		"MetricExpr": "FRONTEND_RETIRED.L1I_MISS / CPU_CLK_UNHALTED.THREAD - tma_code_l2_miss_fake",
+		"MetricGroup": "",
+		"MetricName": "tma_code_l2_hit_fake",
+		"ScaleUnit": "100%"
+	},
+	{
+		"BriefDescription": "TPEBS testing metric",
+		"MetricExpr": "FRONTEND_RETIRED.L2_MISS * FRONTEND_RETIRED.L2_MISS:R / CPU_CLK_UNHALTED.THREAD",
+		"MetricGroup": "",
+		"MetricName": "tma_code_l2_miss",
+		"ScaleUnit": "100%"
+	},
+	{
+		"BriefDescription": "TPEBS testing metric",
+		"MetricExpr": "FRONTEND_RETIRED.L2_MISS / CPU_CLK_UNHALTED.THREAD",
+		"MetricGroup": "",
+		"MetricName": "tma_code_l2_miss_fake",
+		"ScaleUnit": "100%"
+	},
+
+	{
+		"BriefDescription": "TPEBS testing metric",
+		"MetricExpr": "BR_MISP_RETIRED.COND_NTAKEN_COST / CPU_CLK_UNHALTED.THREAD",
+		"MetricGroup": "",
+		"MetricName": "tma_cond_nt_mispredicts_fake",
+		"ScaleUnit": "100%"
+  },
+  {
+		"BriefDescription": "TPEBS testing metric",
+		"MetricExpr": "BR_MISP_RETIRED.COND_TAKEN_COST / CPU_CLK_UNHALTED.THREAD",
+		"MetricGroup": "",
+		"MetricName": "tma_cond_tk_mispredicts_fake",
+		"ScaleUnit": "100%"
+  },
+	{
+		"BriefDescription": "TPEBS testing metric",
+		"MetricExpr": " min((MEM_LOAD_RETIRED.L3_HIT * ( 1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2 ) / CPU_CLK_UNHALTED.THREAD), 1)",
+		"MetricGroup": "",
+		"MetricName": "tma_l3_hit_latency_fake",
+		"ScaleUnit": "100%"
+	}
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/memory.json b/tools/perf/pmu-events/arch/x86/graniterapids/memory.json
index 1c0e0e86e58e..92248ebd8e4f 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/memory.json
@@ -1,4 +1,80 @@
 [
+    {
+        "BriefDescription": "Cycles while L3 cache miss demand load is outstanding.",
+        "CounterMask": "2",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L3_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Execution stalls while L3 cache miss demand load is outstanding.",
+        "CounterMask": "6",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Number of machine clears due to memory ordering conflicts.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
+        "PublicDescription": "Counts the number of Machine Clears detected dye to memory ordering. Memory Ordering Machine Clears may apply when a memory read may not conform to the memory ordering rules of the x86 architecture",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Execution stalls while L1 cache miss demand load is outstanding.",
+        "CounterMask": "3",
+        "EventCode": "0x47",
+        "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Execution stalls while L2 cache miss demand cacheable load request is outstanding.",
+        "CounterMask": "5",
+        "EventCode": "0x47",
+        "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
+        "PublicDescription": "Execution stalls while L2 cache miss demand cacheable load request is outstanding (will not count for uncacheable demand requests e.g. bus lock).",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Execution stalls while L3 cache miss demand cacheable load request is outstanding.",
+        "CounterMask": "9",
+        "EventCode": "0x47",
+        "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
+        "PublicDescription": "Execution stalls while L3 cache miss demand cacheable load request is outstanding (will not count for uncacheable demand requests e.g. bus lock).",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x9"
+    },
+    {
+        "BriefDescription": "MEMORY_ORDERING.MD_NUKE",
+        "EventCode": "0x09",
+        "EventName": "MEMORY_ORDERING.MD_NUKE",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of memory ordering machine clears due to memory renaming.",
+        "EventCode": "0x09",
+        "EventName": "MEMORY_ORDERING.MRN_NUKE",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 1024 cycles.",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x400",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 1024 cycles.  Reported latency may be longer than just the memory latency.",
+        "SampleAfterValue": "53",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 128 cycles.",
         "Data_LA": "1",
@@ -23,6 +99,18 @@
         "SampleAfterValue": "20011",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 2048 cycles.",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x800",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 2048 cycles.  Reported latency may be longer than just the memory latency.",
+        "SampleAfterValue": "23",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 256 cycles.",
         "Data_LA": "1",
@@ -106,69 +194,36 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Counts demand data reads that were not supplied by the local socket's L1, L2, or L3 caches.",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3FBFC00001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that were not supplied by the local socket's L1, L2, or L3 caches.",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_RFO.L3_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F3FC00002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Number of times an RTM execution aborted.",
-        "EventCode": "0xc9",
-        "EventName": "RTM_RETIRED.ABORTED",
-        "PublicDescription": "Counts the number of times RTM abort was triggered.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x4"
-    },
-    {
-        "BriefDescription": "Number of times an RTM execution successfully committed",
-        "EventCode": "0xc9",
-        "EventName": "RTM_RETIRED.COMMIT",
-        "PublicDescription": "Counts the number of times RTM commit succeeded.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Number of times an RTM execution started.",
-        "EventCode": "0xc9",
-        "EventName": "RTM_RETIRED.START",
-        "PublicDescription": "Counts the number of times we entered an RTM region. Does not count nested transactions.",
+        "BriefDescription": "Counts demand data read requests that miss the L3 cache.",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
         "SampleAfterValue": "100003",
-        "UMask": "0x1"
+        "UMask": "0x10"
     },
     {
-        "BriefDescription": "Speculatively counts the number of TSX aborts due to a data capacity limitation for transactional reads",
-        "EventCode": "0x54",
-        "EventName": "TX_MEM.ABORT_CAPACITY_READ",
-        "PublicDescription": "Speculatively counts the number of Transactional Synchronization Extensions (TSX) aborts due to a data capacity limitation for transactional reads",
-        "SampleAfterValue": "100003",
-        "UMask": "0x80"
+        "BriefDescription": "Cycles where data return is pending for a Demand Data Read request who miss L3 cache.",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_L3_MISS_DEMAND_DATA_RD",
+        "PublicDescription": "Cycles with at least 1 Demand Data Read requests who miss L3 cache in the superQ.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
     },
     {
-        "BriefDescription": "Speculatively counts the number of TSX aborts due to a data capacity limitation for transactional writes.",
-        "EventCode": "0x54",
-        "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
-        "PublicDescription": "Speculatively counts the number of Transactional Synchronization Extensions (TSX) aborts due to a data capacity limitation for transactional writes.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x2"
+        "BriefDescription": "For every cycle, increments by the number of demand data read requests pending that are known to have missed the L3 cache.",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD",
+        "PublicDescription": "For every cycle, increments by the number of demand data read requests pending that are known to have missed the L3 cache.  Note that this does not capture all elapsed cycles while requests are outstanding - only cycles from when the requests were known by the requesting core to have missed the L3 cache.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
     },
     {
-        "BriefDescription": "Number of times a transactional abort was signaled due to a data conflict on a transactionally accessed address",
-        "EventCode": "0x54",
-        "EventName": "TX_MEM.ABORT_CONFLICT",
-        "PublicDescription": "Counts the number of times a TSX line had a cache conflict.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
+        "BriefDescription": "Cycles where the core is waiting on at least 6 outstanding demand data read requests known to have missed the L3 cache.",
+        "CounterMask": "6",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD_GE_6",
+        "PublicDescription": "Cycles where the core is waiting on at least 6 outstanding demand data read requests known to have missed the L3 cache.  Note that this event does not capture all elapsed cycles while the requests are outstanding - only cycles from when the requests were known to have missed the L3 cache.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json b/tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json
new file mode 100644
index 000000000000..e6f7934320bf
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json
@@ -0,0 +1,118 @@
+{
+    "Backend": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Bad": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "BadSpec": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "BigFoot": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "BrMispredicts": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Branches": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "CacheMisses": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "CodeGen": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Compute": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Cor": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "DSB": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "DSBmiss": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "DataSharing": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Fed": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "FetchBW": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "FetchLat": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Flops": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "FpScalar": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "FpVector": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Frontend": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "HPC": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "IcMiss": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "InsType": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "IntVector": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "IoBW": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "L2Evicts": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "LSD": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "MachineClears": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Mem": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "MemoryBW": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "MemoryBound": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "MemoryLat": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "MemoryTLB": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Memory_BW": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Memory_Lat": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "MicroSeq": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "OS": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Offcore": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "PGO": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Pipeline": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "PortsUtil": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Power": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Prefetches": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Ret": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Retire": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "SMT": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Server": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Snoop": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "SoC": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "Summary": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "TmaL1": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "TmaL2": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "TmaL3mem": "Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet",
+    "TopdownL1": "Metrics for top-down breakdown at level 1",
+    "TopdownL2": "Metrics for top-down breakdown at level 2",
+    "TopdownL3": "Metrics for top-down breakdown at level 3",
+    "TopdownL4": "Metrics for top-down breakdown at level 4",
+    "TopdownL5": "Metrics for top-down breakdown at level 5",
+    "TopdownL6": "Metrics for top-down breakdown at level 6",
+    "tma_L1_group": "Metrics for top-down breakdown at level 1",
+    "tma_L2_group": "Metrics for top-down breakdown at level 2",
+    "tma_L3_group": "Metrics for top-down breakdown at level 3",
+    "tma_L4_group": "Metrics for top-down breakdown at level 4",
+    "tma_L5_group": "Metrics for top-down breakdown at level 5",
+    "tma_L6_group": "Metrics for top-down breakdown at level 6",
+    "tma_alu_op_utilization_group": "Metrics contributing to tma_alu_op_utilization category",
+    "tma_assists_group": "Metrics contributing to tma_assists category",
+    "tma_backend_bound_group": "Metrics contributing to tma_backend_bound category",
+    "tma_bad_speculation_group": "Metrics contributing to tma_bad_speculation category",
+    "tma_branch_resteers_group": "Metrics contributing to tma_branch_resteers category",
+    "tma_core_bound_group": "Metrics contributing to tma_core_bound category",
+    "tma_dram_bound_group": "Metrics contributing to tma_dram_bound category",
+    "tma_dtlb_load_group": "Metrics contributing to tma_dtlb_load category",
+    "tma_dtlb_store_group": "Metrics contributing to tma_dtlb_store category",
+    "tma_fetch_bandwidth_group": "Metrics contributing to tma_fetch_bandwidth category",
+    "tma_fetch_latency_group": "Metrics contributing to tma_fetch_latency category",
+    "tma_fp_arith_group": "Metrics contributing to tma_fp_arith category",
+    "tma_fp_vector_group": "Metrics contributing to tma_fp_vector category",
+    "tma_frontend_bound_group": "Metrics contributing to tma_frontend_bound category",
+    "tma_heavy_operations_group": "Metrics contributing to tma_heavy_operations category",
+    "tma_int_operations_group": "Metrics contributing to tma_int_operations category",
+    "tma_issue2P": "Metrics related by the issue $issue2P",
+    "tma_issueBC": "Metrics related by the issue $issueBC",
+    "tma_issueBM": "Metrics related by the issue $issueBM",
+    "tma_issueBW": "Metrics related by the issue $issueBW",
+    "tma_issueD0": "Metrics related by the issue $issueD0",
+    "tma_issueFB": "Metrics related by the issue $issueFB",
+    "tma_issueFL": "Metrics related by the issue $issueFL",
+    "tma_issueL1": "Metrics related by the issue $issueL1",
+    "tma_issueLat": "Metrics related by the issue $issueLat",
+    "tma_issueMC": "Metrics related by the issue $issueMC",
+    "tma_issueMS": "Metrics related by the issue $issueMS",
+    "tma_issueMV": "Metrics related by the issue $issueMV",
+    "tma_issueRFO": "Metrics related by the issue $issueRFO",
+    "tma_issueSL": "Metrics related by the issue $issueSL",
+    "tma_issueSO": "Metrics related by the issue $issueSO",
+    "tma_issueSmSt": "Metrics related by the issue $issueSmSt",
+    "tma_issueSpSt": "Metrics related by the issue $issueSpSt",
+    "tma_issueSyncxn": "Metrics related by the issue $issueSyncxn",
+    "tma_issueTLB": "Metrics related by the issue $issueTLB",
+    "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category",
+    "tma_l3_bound_group": "Metrics contributing to tma_l3_bound category",
+    "tma_light_operations_group": "Metrics contributing to tma_light_operations category",
+    "tma_load_op_utilization_group": "Metrics contributing to tma_load_op_utilization category",
+    "tma_mem_bandwidth_group": "Metrics contributing to tma_mem_bandwidth category",
+    "tma_mem_latency_group": "Metrics contributing to tma_mem_latency category",
+    "tma_memory_bound_group": "Metrics contributing to tma_memory_bound category",
+    "tma_microcode_sequencer_group": "Metrics contributing to tma_microcode_sequencer category",
+    "tma_mite_group": "Metrics contributing to tma_mite category",
+    "tma_ports_utilization_group": "Metrics contributing to tma_ports_utilization category",
+    "tma_ports_utilized_0_group": "Metrics contributing to tma_ports_utilized_0 category",
+    "tma_ports_utilized_3m_group": "Metrics contributing to tma_ports_utilized_3m category",
+    "tma_retiring_group": "Metrics contributing to tma_retiring category",
+    "tma_serializing_operation_group": "Metrics contributing to tma_serializing_operation category",
+    "tma_store_bound_group": "Metrics contributing to tma_store_bound category",
+    "tma_store_op_utilization_group": "Metrics contributing to tma_store_op_utilization category"
+}
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json b/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
index 764c0435d1d2..85b69be61029 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
@@ -1,4 +1,29 @@
 [
+    {
+        "BriefDescription": "Cycles when divide unit is busy executing divide or square root operations.",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.DIV_ACTIVE",
+        "PublicDescription": "Counts cycles when divide unit is busy executing divide or square root operations. Accounts for integer and floating-point operations.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x9"
+    },
+    {
+        "BriefDescription": "This event counts the cycles the integer divider is busy.",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.IDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of occurrences where a microcode assist is invoked by hardware.",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.ANY",
+        "PublicDescription": "Counts the number of occurrences where a microcode assist is invoked by hardware. Examples include AD (page Access Dirty), FP and AVX related assists.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1b"
+    },
     {
         "BriefDescription": "All branch instructions retired.",
         "EventCode": "0xc4",
@@ -7,6 +32,78 @@
         "PublicDescription": "Counts all branch instructions retired.",
         "SampleAfterValue": "400009"
     },
+    {
+        "BriefDescription": "Conditional branch instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PEBS": "1",
+        "PublicDescription": "Counts conditional branch instructions retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Not taken branch instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_NTAKEN",
+        "PEBS": "1",
+        "PublicDescription": "Counts not taken branch instructions retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Taken conditional branch instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "PublicDescription": "Counts taken conditional branch instructions retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Far branch instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
+        "PEBS": "1",
+        "PublicDescription": "Counts far branch instructions retired.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Indirect near branch instructions retired (excluding returns)",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "PublicDescription": "Counts near indirect branch instructions retired excluding returns. TSX abort is an indirect branch.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Direct and indirect near call instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "PEBS": "1",
+        "PublicDescription": "Counts both direct and indirect near call instructions retired.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Return instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "PEBS": "1",
+        "PublicDescription": "Counts return instructions retired.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Taken branch instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "PEBS": "1",
+        "PublicDescription": "Counts taken branch instructions retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "All mispredicted branch instructions retired.",
         "EventCode": "0xc5",
@@ -15,6 +112,197 @@
         "PublicDescription": "Counts all the retired branch instructions that were mispredicted by the processor. A branch misprediction occurs when the processor incorrectly predicts the destination of the branch.  When the misprediction is discovered at execution, all the instructions executed in the wrong (speculative) path must be discarded, and the processor must start fetching from the correct path.",
         "SampleAfterValue": "400009"
     },
+    {
+        "BriefDescription": "All mispredicted branch instructions retired. This precise event may be used to get the misprediction cost via the Retire_Latency field of PEBS. It fires on the instruction that immediately follows the mispredicted branch.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x44"
+    },
+    {
+        "BriefDescription": "Mispredicted conditional branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND",
+        "PEBS": "1",
+        "PublicDescription": "Counts mispredicted conditional branch instructions retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Mispredicted conditional branch instructions retired. This precise event may be used to get the misprediction cost via the Retire_Latency field of PEBS. It fires on the instruction that immediately follows the mispredicted branch.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x51"
+    },
+    {
+        "BriefDescription": "Mispredicted non-taken conditional branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
+        "PEBS": "1",
+        "PublicDescription": "Counts the number of conditional branch instructions retired that were mispredicted and the branch direction was not taken.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Mispredicted non-taken conditional branch instructions retired. This precise event may be used to get the misprediction cost via the Retire_Latency field of PEBS. It fires on the instruction that immediately follows the mispredicted branch.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_NTAKEN_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x50"
+    },
+    {
+        "BriefDescription": "number of branch instructions retired that were mispredicted and taken.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "PublicDescription": "Counts taken conditional mispredicted branch instructions retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Mispredicted taken conditional branch instructions retired. This precise event may be used to get the misprediction cost via the Retire_Latency field of PEBS. It fires on the instruction that immediately follows the mispredicted branch.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Miss-predicted near indirect branch instructions retired (excluding returns)",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "PublicDescription": "Counts miss-predicted near indirect branch instructions retired excluding returns. TSX abort is an indirect branch.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Mispredicted indirect CALL retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired mispredicted indirect (near taken) CALL instructions, including both register and memory indirect.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Mispredicted indirect CALL retired. This precise event may be used to get the misprediction cost via the Retire_Latency field of PEBS. It fires on the instruction that immediately follows the mispredicted branch.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_CALL_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x42"
+    },
+    {
+        "BriefDescription": "Mispredicted near indirect branch instructions retired (excluding returns). This precise event may be used to get the misprediction cost via the Retire_Latency field of PEBS. It fires on the instruction that immediately follows the mispredicted branch.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0xc0"
+    },
+    {
+        "BriefDescription": "Number of near branch instructions retired that were mispredicted and taken.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "PEBS": "1",
+        "PublicDescription": "Counts number of near branch instructions retired that were mispredicted and taken.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Mispredicted taken near branch instructions retired. This precise event may be used to get the misprediction cost via the Retire_Latency field of PEBS. It fires on the instruction that immediately follows the mispredicted branch.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x60"
+    },
+    {
+        "BriefDescription": "This event counts the number of mispredicted ret instructions retired. Non PEBS",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.RET",
+        "PEBS": "1",
+        "PublicDescription": "This is a non-precise version (that is, does not use PEBS) of the event that counts mispredicted return instructions retired.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Mispredicted ret instructions retired. This precise event may be used to get the misprediction cost via the Retire_Latency field of PEBS. It fires on the instruction that immediately follows the mispredicted branch.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.RET_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x48"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 light-weight slower wakeup time but more power saving optimized state.",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C01",
+        "PublicDescription": "Counts core clocks when the thread is in the C0.1 light-weight slower wakeup time but more power saving optimized state.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.2 light-weight faster wakeup time but less power saving optimized state.",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C02",
+        "PublicDescription": "Counts core clocks when the thread is in the C0.2 light-weight faster wakeup time but less power saving optimized state.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 or C0.2 or running a PAUSE in C0 ACPI state.",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
+        "PublicDescription": "Counts core clocks when the thread is in the C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions) or running the PAUSE instruction.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x70"
+    },
+    {
+        "BriefDescription": "Cycle counts are evenly distributed between active threads in the Core.",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
+        "PublicDescription": "This event distributes cycle counts between active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive when it executes the HLT or MWAIT instructions.  If all other hyperthreads are inactive (or disabled or do not exist), all counts are attributed to this hyperthread. To obtain the full count when the Core is active, sum the counts from each hyperthread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Core crystal clock cycles when this thread is unhalted and the other thread is halted.",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
+        "PublicDescription": "Counts Core crystal clock cycles when current thread is unhalted and the other thread is halted.",
+        "SampleAfterValue": "25003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "CPU_CLK_UNHALTED.PAUSE",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.PAUSE",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Core crystal clock cycles. Cycle counts are evenly distributed between active threads in the Core.",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
+        "PublicDescription": "This event distributes Core crystal clock cycle counts between active hyperthreads, i.e., those in C0 sleep-state. A hyperthread becomes inactive when it executes the HLT or MWAIT instructions. If one thread is active in a core, all counts are attributed to this hyperthread. To obtain the full count when the Core is active, sum the counts from each hyperthread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
@@ -44,6 +332,119 @@
         "PublicDescription": "This is an architectural event that counts the number of thread cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. The core frequency may change from time to time due to power or thermal throttling. For this reason, this event may have a changing ratio with regards to wall clock time.",
         "SampleAfterValue": "2000003"
     },
+    {
+        "BriefDescription": "Cycles while L1 cache miss demand load is outstanding.",
+        "CounterMask": "8",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles while L2 cache miss demand load is outstanding.",
+        "CounterMask": "1",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles while memory subsystem has an outstanding load.",
+        "CounterMask": "16",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Execution stalls while L1 cache miss demand load is outstanding.",
+        "CounterMask": "12",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc"
+    },
+    {
+        "BriefDescription": "Execution stalls while L2 cache miss demand load is outstanding.",
+        "CounterMask": "5",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Total execution stalls.",
+        "CounterMask": "4",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles total of 1 uop is executed on all ports and Reservation Station was not empty.",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
+        "PublicDescription": "Counts cycles during which a total of 1 uop was executed on all ports and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles total of 2 uops are executed on all ports and Reservation Station was not empty.",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
+        "PublicDescription": "Counts cycles during which a total of 2 uops were executed on all ports and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles total of 3 uops are executed on all ports and Reservation Station was not empty.",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
+        "PublicDescription": "Cycles total of 3 uops are executed on all ports and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles total of 4 uops are executed on all ports and Reservation Station was not empty.",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
+        "PublicDescription": "Cycles total of 4 uops are executed on all ports and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Execution stalls while memory subsystem has an outstanding load.",
+        "CounterMask": "5",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "Cycles where the Store Buffer was full and no loads caused an execution stall.",
+        "CounterMask": "2",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
+        "PublicDescription": "Counts cycles where the Store Buffer was full and no loads caused an execution stall.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Cycles no uop executed while RS was not empty, the SB was not full and there was no outstanding load.",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
+        "PublicDescription": "Number of cycles total of 0 uops executed on all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) was not full and there was no outstanding load.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Instruction decoders utilized in a cycle",
+        "EventCode": "0x75",
+        "EventName": "INST_DECODED.DECODERS",
+        "PublicDescription": "Number of decoders utilized in a cycle when the MITE (legacy decode pipeline) fetches instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter - architectural event",
         "EventName": "INST_RETIRED.ANY",
@@ -60,6 +461,171 @@
         "PublicDescription": "Counts the number of X86 instructions retired - an Architectural PerfMon event. Counting continues during hardware interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counted by a designated fixed counter freeing up programmable counters to count other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003"
     },
+    {
+        "BriefDescription": "INST_RETIRED.MACRO_FUSED",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.MACRO_FUSED",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Retired NOP instructions.",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.NOP",
+        "PublicDescription": "Counts all retired NOP or ENDBR32/64 or PREFETCHIT0/1 instructions",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Precise instruction retired with PEBS precise-distribution",
+        "EventName": "INST_RETIRED.PREC_DIST",
+        "PEBS": "1",
+        "PublicDescription": "A version of INST_RETIRED that allows for a precise distribution of samples across instructions retired. It utilizes the Precise Distribution of Instructions Retired (PDIR++) feature to fix bias in how retired instructions get sampled. Use on Fixed Counter 0.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Iterations of Repeat string retired instructions.",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.REP_ITERATION",
+        "PublicDescription": "Number of iterations of Repeat (REP) string retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, and doubleword version and string instructions can be repeated using a repetition prefix, REP, that allows their architectural execution to be repeated a number of times as specified by the RCX register. Note the number of iterations is implementation-dependent.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles the Backend cluster is recovering after a miss-speculation or a Store Buffer or Load Buffer drain stall.",
+        "CounterMask": "1",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.ALL_RECOVERY_CYCLES",
+        "PublicDescription": "Counts cycles the Backend cluster is recovering after a miss-speculation or a Store Buffer or Load Buffer drain stall.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Clears speculative count",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.CLEARS_COUNT",
+        "PublicDescription": "Counts the number of speculative clears due to any type of branch misprediction or machine clears",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cycles after recovery from a branch misprediction or machine clear till the first uop is issued from the resteered path.",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
+        "PublicDescription": "Cycles after recovery from a branch misprediction or machine clear till the first uop is issued from the resteered path.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Cycles when Resource Allocation Table (RAT) external stall is sent to Instruction Decode Queue (IDQ) for the thread",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.RAT_STALLS",
+        "PublicDescription": "This event counts the number of cycles during which Resource Allocation Table (RAT) external stall is sent to Instruction Decode Queue (IDQ) for the current thread. This also includes the cycles during which the Allocator is serving another thread.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Core cycles the allocator was stalled due to recovery from earlier clear event for this thread",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.RECOVERY_CYCLES",
+        "PublicDescription": "Counts core cycles when the Resource allocator was stalled due to recovery from an earlier branch misprediction or machine clear event.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "TMA slots where uops got dropped",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.UOP_DROPPING",
+        "PublicDescription": "Estimated number of Top-down Microarchitecture Analysis slots that got dropped due to non front-end reasons",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.128BIT",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.128BIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x13"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.256BIT",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.256BIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xac"
+    },
+    {
+        "BriefDescription": "integer ADD, SUB, SAD 128-bit vector instructions.",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.ADD_128",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular or horizontal), SAD 128-bit vector instructions.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "integer ADD, SUB, SAD 256-bit vector instructions.",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.ADD_256",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular or horizontal), SAD 256-bit vector instructions.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.MUL_256",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.MUL_256",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.SHUFFLES",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.SHUFFLES",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.VNNI_128",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.VNNI_128",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.VNNI_256",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.VNNI_256",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "False dependencies in MOB due to partial compare on address.",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
+        "PublicDescription": "Counts the number of times a load got blocked due to false dependencies in MOB due to partial compare on address.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "The number of times that split load operations are temporarily blocked because all resources for handling the split accesses are in use.",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.NO_SR",
+        "PublicDescription": "Counts the number of times that split load operations are temporarily blocked because all resources for handling the split accesses are in use.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x88"
+    },
     {
         "BriefDescription": "Loads blocked due to overlapping with a preceding store that cannot be forwarded.",
         "EventCode": "0x03",
@@ -68,6 +634,57 @@
         "SampleAfterValue": "100003",
         "UMask": "0x82"
     },
+    {
+        "BriefDescription": "Cycles Uops delivered by the LSD, but didn't come from the decoder.",
+        "CounterMask": "1",
+        "EventCode": "0xa8",
+        "EventName": "LSD.CYCLES_ACTIVE",
+        "PublicDescription": "Counts the cycles when at least one uop is delivered by the LSD (Loop-stream detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles optimal number of Uops delivered by the LSD, but did not come from the decoder.",
+        "CounterMask": "6",
+        "EventCode": "0xa8",
+        "EventName": "LSD.CYCLES_OK",
+        "PublicDescription": "Counts the cycles when optimal number of uops is delivered by the LSD (Loop-stream detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of Uops delivered by the LSD.",
+        "EventCode": "0xa8",
+        "EventName": "LSD.UOPS",
+        "PublicDescription": "Counts the number of uops delivered to the back-end by the LSD(Loop Stream Detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of machine clears (nukes) of any type.",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.COUNT",
+        "PublicDescription": "Counts the number of machine clears (nukes) of any type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "LFENCE instructions retired",
+        "EventCode": "0xe0",
+        "EventName": "MISC2_RETIRED.LFENCE",
+        "PublicDescription": "number of LFENCE retired instructions",
+        "SampleAfterValue": "400009",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts cycles where the pipeline is stalled due to serializing operations.",
+        "EventCode": "0xa2",
+        "EventName": "RESOURCE_STALLS.SCOREBOARD",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slots event that were not consumed by the back-end pipeline due to lack of back-end resources, as a result of memory subsystem delays, execution units limitations, or other conditions.",
         "EventCode": "0xa4",
@@ -76,6 +693,29 @@
         "SampleAfterValue": "10000003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "TMA slots wasted due to incorrect speculations.",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
+        "PublicDescription": "Number of slots of TMA method that were wasted due to incorrect speculation. It covers all types of control-flow or data-related mis-speculations.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "TMA slots wasted due to incorrect speculation by branch mispredictions",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
+        "PublicDescription": "Number of TMA slots that were wasted due to incorrect speculation by (any type of) branch mispredictions. This event estimates number of speculative operations that were issued but not retired as well as the out-of-order engine recovery past a branch misprediction.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "TOPDOWN.MEMORY_BOUND_SLOTS",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
         "EventName": "TOPDOWN.SLOTS",
@@ -91,6 +731,227 @@
         "SampleAfterValue": "10000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Number of non dec-by-all uops decoded by decoder",
+        "EventCode": "0x76",
+        "EventName": "UOPS_DECODED.DEC0_UOPS",
+        "PublicDescription": "This event counts the number of not dec-by-all uops decoded by decoder 0.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Uops executed on port 0",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_0",
+        "PublicDescription": "Number of uops dispatch to execution  port 0.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Uops executed on port 1",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_1",
+        "PublicDescription": "Number of uops dispatch to execution  port 1.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Uops executed on ports 2, 3 and 10",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_2_3_10",
+        "PublicDescription": "Number of uops dispatch to execution ports 2, 3 and 10",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Uops executed on ports 4 and 9",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_4_9",
+        "PublicDescription": "Number of uops dispatch to execution ports 4 and 9",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Uops executed on ports 5 and 11",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_5_11",
+        "PublicDescription": "Number of uops dispatch to execution ports 5 and 11",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Uops executed on port 6",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_6",
+        "PublicDescription": "Number of uops dispatch to execution  port 6.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Uops executed on ports 7 and 8",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_7_8",
+        "PublicDescription": "Number of uops dispatch to execution  ports 7 and 8.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Number of uops executed on the core.",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE",
+        "PublicDescription": "Counts the number of uops executed from any thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles at least 1 micro-op is executed from any thread on physical core.",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
+        "PublicDescription": "Counts cycles when at least 1 micro-op is executed from any thread on physical core.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles at least 2 micro-op is executed from any thread on physical core.",
+        "CounterMask": "2",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
+        "PublicDescription": "Counts cycles when at least 2 micro-ops are executed from any thread on physical core.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles at least 3 micro-op is executed from any thread on physical core.",
+        "CounterMask": "3",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
+        "PublicDescription": "Counts cycles when at least 3 micro-ops are executed from any thread on physical core.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles at least 4 micro-op is executed from any thread on physical core.",
+        "CounterMask": "4",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
+        "PublicDescription": "Counts cycles when at least 4 micro-ops are executed from any thread on physical core.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles where at least 1 uop was executed per-thread",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
+        "PublicDescription": "Cycles where at least 1 uop was executed per-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 2 uops were executed per-thread",
+        "CounterMask": "2",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
+        "PublicDescription": "Cycles where at least 2 uops were executed per-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 3 uops were executed per-thread",
+        "CounterMask": "3",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
+        "PublicDescription": "Cycles where at least 3 uops were executed per-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 4 uops were executed per-thread",
+        "CounterMask": "4",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
+        "PublicDescription": "Cycles where at least 4 uops were executed per-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts number of cycles no uops were dispatched to be executed on this thread.",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.STALLS",
+        "Invert": "1",
+        "PublicDescription": "Counts cycles during which no uops were dispatched from the Reservation Station (RS) per thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of uops to be executed per-thread each cycle.",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.THREAD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of x87 uops dispatched.",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.X87",
+        "PublicDescription": "Counts the number of x87 uops executed.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Uops that RAT issues to RS",
+        "EventCode": "0xae",
+        "EventName": "UOPS_ISSUED.ANY",
+        "PublicDescription": "Counts the number of uops that the Resource Allocation Table (RAT) issues to the Reservation Station (RS).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "UOPS_ISSUED.CYCLES",
+        "CounterMask": "1",
+        "EventCode": "0xae",
+        "EventName": "UOPS_ISSUED.CYCLES",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when RAT does not issue Uops to RS for the thread",
+        "CounterMask": "1",
+        "EventCode": "0xae",
+        "EventName": "UOPS_ISSUED.STALLS",
+        "Invert": "1",
+        "PublicDescription": "Counts cycles during which the Resource Allocation Table (RAT) does not issue any Uops to the reservation station (RS) for the current thread.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles with retired uop(s).",
+        "CounterMask": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.CYCLES",
+        "PublicDescription": "Counts cycles where at least one uop has retired.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired uops except the last uop of each instruction.",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.HEAVY",
+        "PublicDescription": "Counts the number of retired micro-operations (uops) except the last uop of each instruction. An instruction that is decoded into less than two uops does not contribute to the count.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "UOPS_RETIRED.MS",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.MS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x8",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slots event that are utilized by operations that eventually get retired (committed) by the processor pipeline. Usually, this event positively correlates with higher performance  for example, as measured by the instructions-per-cycle metric.",
         "EventCode": "0xc2",
@@ -98,5 +959,25 @@
         "PublicDescription": "This event counts a subset of the Topdown Slots event that are utilized by operations that eventually get retired (committed) by the processor pipeline. Usually, this event positively correlates with higher performance  for example, as measured by the instructions-per-cycle metric.\nSoftware can use this event as the numerator for the Retiring metric (or top-level category) of the Top-down Microarchitecture Analysis method.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles without actually retired uops.",
+        "CounterMask": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.STALLS",
+        "Invert": "1",
+        "PublicDescription": "This event counts cycles without actually retired uops.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles with less than 10 actually retired uops.",
+        "CounterMask": "10",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
+        "Invert": "1",
+        "PublicDescription": "Counts the number of cycles using always true condition (uops_ret < 16) applied to non PEBS uops retired event.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
     }
 ]
-- 
2.43.0

