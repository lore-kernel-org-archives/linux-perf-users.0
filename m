Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6120CCE2;
	Thu, 27 Feb 2025 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634985; cv=none; b=MRRCdfB2UfdNrS2n0d5sGOXesK3Qrm97EQHP15KjXNfqtSXnxrWSAfkw1SkDaQ/pN9lcQto5ITqx/rSMByg+B7Xh0Xk5N2MrEvuNb+SwjH1oWS9lBkghIS8RCcPSUwKrNf4vbpaE1SDBgfCnWzBxbV1X2tUNpcy/z4PkaYohP0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634985; c=relaxed/simple;
	bh=7ioaoaFEqmOjduVcLT1zN2cDU+hoCGDa+V7RfZiay3o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=A4ozzFj2VcGrLvRvKNgSU+XwkgKzYPmtBe7fxMvdANrBGTvxrdE25T3roL1fF9gR1eHrSAACBf3qX2HO9ohOrybHuhUNn7HAqIn7gYZT2YTRjdJCzYd9697fSXL6tIYT4chx7mpJRZ0S2QmGt+kyB4NGutbKDzgQwyH2Ppyq32g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GsbisALS; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GsbisALS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1740634984; x=1772170984;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7ioaoaFEqmOjduVcLT1zN2cDU+hoCGDa+V7RfZiay3o=;
  b=GsbisALSQdQpyIZmo/OaeFB/e/cu42FLd6J3/flcAsok5HuNBbKByizN
   nZL0QZu2ms6A62jp0T6pd/5wl20IrsQ71e2vGaYfYzmTjo3pwxOyOE8o+
   nqDsxlYOwHU5Vdnn4sTCMnigqlUXBARebvApSccWgs5JuUfuxJ3vSzZEt
   u55PWiSLTvML7mwG1UBNzlF1s43DIk6R5BMxymFsbioRnK8RRm9kAe2yw
   cVG+nWY4Rx/ar3Ii4zEisWVFoKSvl9Pdw8LzBQ44Orw+Ra10tvHZVa5Yg
   dzBDCrGjTj233Nin8i4CPhiGtxCGg3kQ0ueAseDqHVH5AQ9troL9jTi+o
   w==;
X-CSE-ConnectionGUID: Hs/UU8qKQMGiharzNw7V9A==
X-CSE-MsgGUID: 1RkmxL6JTb+3CsLpEv6lhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="191325972"
X-IronPort-AV: E=Sophos;i="6.13,319,1732546800"; 
   d="scan'208";a="191325972"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 14:41:52 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id F2D20D5019;
	Thu, 27 Feb 2025 14:41:49 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C51F3D0925;
	Thu, 27 Feb 2025 14:41:49 +0900 (JST)
Received: from sm-x86-mem01.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by yto-om3.fujitsu.com (Postfix) with ESMTP id 04DE54005847B;
	Thu, 27 Feb 2025 14:41:48 +0900 (JST)
From: Yoshihiro Furudera <fj5100bi@fujitsu.com>
To: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>
Subject: [PATCH] Remove some PMU events for FUJITSU-MONAKA
Date: Thu, 27 Feb 2025 05:40:45 +0000
Message-Id: <20250227054045.1340090-1-fj5100bi@fujitsu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following events are not counted properly:

0x0037 LL_CACHE_MISS_RD
0x400B L3D_CACHE_LMISS_RD
0x0396 L2D_CACHE_REFILL_L3D_MISS
0x039A L2D_CACHE_REFILL_L3D_MISS_PRF
0x039B L2D_CACHE_REFILL_L3D_MISS_HWPRF
0x039C L2D_CACHE_REFILL_L3D_HIT
0x03A0 L2D_CACHE_REFILL_L3D_HIT_PRF
0x03A1 L2D_CACHE_REFILL_L3D_HIT_HWPRF

Specifically, these events are always counted as misses,
regardless of whether the L3 prefetch is a hit or a miss.
So I remove these events in l3_cache.json, ll_cache.json

Signed-off-by: Yoshihiro Furudera <fj5100bi@fujitsu.com>
---
 .../arch/arm64/fujitsu/monaka/l3_cache.json   | 34 -------------------
 .../arch/arm64/fujitsu/monaka/ll_cache.json   |  4 ---
 2 files changed, 38 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
index 3f3e0d22ac68..917b9b5bf8bb 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
@@ -37,11 +37,6 @@
         "EventName": "L2D_CACHE_REFILL_L3D_CACHE_HWPRF",
         "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_CACHE caused by hardware prefetch access."
     },
-    {
-        "EventCode": "0x0396",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS",
-        "BriefDescription": "This event counts operations that cause a miss of the L3 cache."
-    },
     {
         "EventCode": "0x0397",
         "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM",
@@ -57,21 +52,6 @@
         "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_WR",
         "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS caused by demand write access."
     },
-    {
-        "EventCode": "0x039A",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS_PRF",
-        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS caused by prefetch access."
-    },
-    {
-        "EventCode": "0x039B",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS_HWPRF",
-        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS caused by hardware prefetch access."
-    },
-    {
-        "EventCode": "0x039C",
-        "EventName": "L2D_CACHE_REFILL_L3D_HIT",
-        "BriefDescription": "This event counts operations that cause a hit of the L3 cache."
-    },
     {
         "EventCode": "0x039D",
         "EventName": "L2D_CACHE_REFILL_L3D_HIT_DM",
@@ -87,16 +67,6 @@
         "EventName": "L2D_CACHE_REFILL_L3D_HIT_DM_WR",
         "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT caused by demand write access."
     },
-    {
-        "EventCode": "0x03A0",
-        "EventName": "L2D_CACHE_REFILL_L3D_HIT_PRF",
-        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT caused by prefetch access."
-    },
-    {
-        "EventCode": "0x03A1",
-        "EventName": "L2D_CACHE_REFILL_L3D_HIT_HWPRF",
-        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT caused by hardware prefetch access."
-    },
     {
         "EventCode": "0x03A2",
         "EventName": "L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT",
@@ -151,9 +121,5 @@
         "EventCode": "0x03AC",
         "EventName": "L2D_CACHE_REFILL_L3D_MISS_FR_L3",
         "BriefDescription": "This event counts the number of L3 cache misses where the requests access L3 cache in the different socket from the requests."
-    },
-    {
-        "ArchStdEvent": "L3D_CACHE_LMISS_RD",
-        "BriefDescription": "This event counts access counted by L3D_CACHE that is not completed by the L3D cache, and  a Memory-read operation, as defined by the L2D_CACHE_REFILL_L3D_MISS events."
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
index a441b84729ab..c2325855eda3 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
@@ -2,9 +2,5 @@
     {
         "ArchStdEvent": "LL_CACHE_RD",
         "BriefDescription": "This event counts access counted by L3D_CACHE that is a Memory-read operation, as defined by the L2D_CACHE_REFILL_L3D_CACHE events."
-    },
-    {
-        "ArchStdEvent": "LL_CACHE_MISS_RD",
-        "BriefDescription": "This event counts access counted by L3D_CACHE that is not completed by the L3D cache, and a Memory-read operation, as defined by the L2D_CACHE_REFILL_L3D_MISS events."
     }
 ]
-- 
2.43.0

