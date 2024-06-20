Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501DE1BA062
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907665; cv=none; b=PuRt/bVegTrYdtogSBv9M1yTbhetUdR3b8Cz3rFhLr7heXbS3SGbTZ23xJI1hYjgsthdghO6NXtynpktJVLyVRpV+4d60/6u3bpeoEOcYHTjjQt8LNnXJpHzRcbEeJFE+G/TU/4WlZQdNs8MD7le7qF0/qhkYtbzVvRxii/xd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907665; c=relaxed/simple;
	bh=J6RQewX4OSBPqFKYvpESdWYCrZvbEsY/a9uQH4N7zvQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=O1l2B8JTlLlmAcQ1C5O+0HzY5mG9+xSr6fch2VrHAG8SqLgMS5PBCFQuGmQ4AzRI+KwYlTpVSoRDmYWPx8HFJjc0hFhn6Z8+9dJgOghrk+mK8Vxx1D09JPgSXV/pw8EkmIkmKhvHAYjzJja+1ksjEMm63H7RPMtz5vgHU8fnrv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+vJNo7v; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+vJNo7v"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6313189f622so23851207b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718907604; x=1719512404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spdrQuWMtm0wU1QNj5ZjZ9cN6oLi/hLM1ih4QJ+sDqM=;
        b=Z+vJNo7vNhCAZxA5ikYtmv5ioe/UDGfc7HkcmhgRN4JZIUxz39s0kO4OXqhdWNDUTB
         f2J5oFQRwvlX3GrTgi4bIpP/R/5dtjHzk1zpZUkSP7U4vaRZuiUpnO7pYZoENka7FPNc
         vRGMIu83rB0Tr1YYsnwTkS7DYo3Kl4uwUdQe4UuDQ/53SGeXdDtD4tjEy8y6ajJKC/XC
         AL36Gyo7ttKrCRxqeWaFPFpoBcPYUM7A+dAcZZqzhZYgYodJYXLF8nuRxyZUIUvkikEQ
         Vsz/Q/U35wFCdIX5NCu7ZeRj4E98f7XoqfysNhl3Xrpz9PcfPgQSxIIzMkBoXss5VYIy
         84VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907604; x=1719512404;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=spdrQuWMtm0wU1QNj5ZjZ9cN6oLi/hLM1ih4QJ+sDqM=;
        b=xM/qBwNupVekajeinv9Mudl8bCoQkBwyXjT3htWEfQejqSnga4ZV6AqmvRTt3RvG3k
         P+YCpzAbc7JmFLowJk2luXcf4bqiYqx8oHdp8TJNBC1woVMNggFklfDdKDinQHH9Zy1p
         Z6P4NMXMvLRlxzPKy4Jdu7bXJvOhmy/c+jC6zC+xqbjNPtzVa2Y/mkhVzVYUJD60p5jj
         FunhjIxIfHNVfEyByjfMJvh1wzzfoUzCXPFcrq//04VBpZoehBTnMRCfvWQZPw9hvJJw
         VCSck5hi743869SJv/sadrtTG2lBOvfz7kEjI1hXOnMut1YoS/hbxyL3PCfm7kUUjke8
         e9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUOCmkVahWr9Rxr6rp5iyKccvnzeE1W1JO0/mugYbcLpKzEibYIU9Y0lO+SxzpzJDmWBeIka7lvlqRvoosnrIlYqoo2rpMo9UOYsLrVPdzKdg==
X-Gm-Message-State: AOJu0YzdJPcoY9fK29mKv9HHQk1PjwevrxE3E2G031jrBHq8tIoyzpMa
	xGhnTDuqZA/81IolEvoFLXsGO9dJrbVO4rq8efSBT1i2yUDaxXpku93Nh/TLx5o2rD9ay0X8R9X
	pNZOphQ==
X-Google-Smtp-Source: AGHT+IFiU4MizHOIOu4NiBS7+hC2H7uswEMO5lCwDOy+e9wsDf6ME9N1OnUEVRGlkWrbq8gTztuzXJ0QvoLY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a6b7:dc01:68ba:649])
 (user=irogers job=sendgmr) by 2002:a05:690c:7091:b0:62c:f01d:3470 with SMTP
 id 00721157ae682-63a8fbea0d1mr12582087b3.6.1718907603862; Thu, 20 Jun 2024
 11:20:03 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:17:35 -0700
In-Reply-To: <20240620181752.3945845-1-irogers@google.com>
Message-Id: <20240620181752.3945845-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240620181752.3945845-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v2 21/37] perf vendor events: Add knightslanding counter information
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Weilin Wang <weilin.wang@intel.com>, Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add counter information necessary for optimizing event grouping the
perf tool.

The most recent RFC patch set using this information:
https://lore.kernel.org/lkml/20240412210756.309828-1-weilin.wang@intel.com/

The information was added in:
https://github.com/intel/perfmon/commit/475892a9690cb048949e593fe39cee65cd4=
765e1
and later patches.

Co-authored-by: Weilin Wang <weilin.wang@intel.com>
Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../arch/x86/knightslanding/cache.json        | 213 +++++++++
 .../arch/x86/knightslanding/counter.json      |  37 ++
 .../x86/knightslanding/floating-point.json    |   3 +
 .../arch/x86/knightslanding/frontend.json     |   7 +
 .../arch/x86/knightslanding/memory.json       | 101 +++++
 .../arch/x86/knightslanding/pipeline.json     |  45 ++
 .../arch/x86/knightslanding/uncore-cache.json | 421 ++++++++++++++++++
 .../arch/x86/knightslanding/uncore-io.json    |  24 +
 .../x86/knightslanding/uncore-memory.json     |  14 +
 .../x86/knightslanding/virtual-memory.json    |   7 +
 10 files changed, 872 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/counter.j=
son

diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json b/too=
ls/perf/pmu-events/arch/x86/knightslanding/cache.json
index 8da3a5a7be73..a9f905bc19d2 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
@@ -1,12 +1,14 @@
 [
     {
         "BriefDescription": "Counts the number of MEC requests that were n=
ot accepted into the L2Q because of any L2  queue reject condition. There i=
s no concept of at-ret here. It might include requests due to instructions =
in the speculative path.",
+        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ALL",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "This event counts the number of core cycles t=
he fetch stalls because of an icache miss. This is a cumulative count of cy=
cles the NIP stalled for all icache misses.",
+        "Counter": "0,1",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ICACHE_FILL_PENDING_CYCLES",
         "SampleAfterValue": "200003",
@@ -14,6 +16,7 @@
     },
     {
         "BriefDescription": "Counts the number of L2HWP allocated into XQ =
GP",
+        "Counter": "0,1",
         "EventCode": "0x3E",
         "EventName": "L2_PREFETCHER.ALLOC_XQ",
         "SampleAfterValue": "100007",
@@ -21,6 +24,7 @@
     },
     {
         "BriefDescription": "Counts the number of L2 cache misses",
+        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_REQUESTS.MISS",
         "SampleAfterValue": "200003",
@@ -28,6 +32,7 @@
     },
     {
         "BriefDescription": "Counts the total number of L2 cache reference=
s.",
+        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_REQUESTS.REFERENCE",
         "SampleAfterValue": "200003",
@@ -35,12 +40,14 @@
     },
     {
         "BriefDescription": "Counts the number of MEC requests from the L2=
Q that reference a cache line (cacheable requests) excluding SW prefetches =
filling only to L2 cache and L1 evictions (automatically excludes L2HWP, UC=
, WC) that were rejected - Multiple repeated rejects should be counted mult=
iple times",
+        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REQUESTS_REJECT.ALL",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Counts all the load micro-ops retired",
+        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PublicDescription": "This event counts the number of load micro-o=
ps retired.",
@@ -49,6 +56,7 @@
     },
     {
         "BriefDescription": "Counts all the store micro-ops retired",
+        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PublicDescription": "This event counts the number of store micro-=
ops retired.",
@@ -57,6 +65,7 @@
     },
     {
         "BriefDescription": "Counts the loads retired that get the data fr=
om the other core in the same tile in M state (Precise Event)",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.HITM",
@@ -67,6 +76,7 @@
     },
     {
         "BriefDescription": "Counts the number of load micro-ops retired t=
hat miss in L1 D cache",
+        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L1_MISS_LOADS",
         "PublicDescription": "This event counts the number of load micro-o=
ps retired that miss in L1 Data cache. Note that prefetch misses will not b=
e counted.",
@@ -75,6 +85,7 @@
     },
     {
         "BriefDescription": "Counts the number of load micro-ops retired t=
hat hit in the L2 (Precise Event)",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L2_HIT_LOADS",
@@ -85,6 +96,7 @@
     },
     {
         "BriefDescription": "Counts the number of load micro-ops retired t=
hat miss in the L2 (Precise Event)",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L2_MISS_LOADS",
@@ -95,6 +107,7 @@
     },
     {
         "BriefDescription": "Counts the number of load micro-ops retired t=
hat caused micro TLB miss",
+        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.UTLB_MISS_LOADS",
         "SampleAfterValue": "200003",
@@ -102,6 +115,7 @@
     },
     {
         "BriefDescription": "Counts the matrix events specified by MSR_OFF=
CORE_RESPx",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE",
         "SampleAfterValue": "100007",
@@ -109,6 +123,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -118,6 +133,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from snoop request hit with data f=
orwarded from it Far(not in the same quadrant as the request)-other tile L2=
 in E/F/M state. Valid only in SNC4 Cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -127,6 +143,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from a snoop request hit with data=
 forwarded from its Far(not in the same quadrant as the request)-other tile=
's L2 in E/F state. Valid only for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -136,6 +153,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from a snoop request hit with data=
 forwarded from its Far(not in the same quadrant as the request)-other tile=
's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -145,6 +163,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from snoop request hit with data f=
orwarded from its Near-other tile L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -154,6 +173,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from a snoop request hit with data=
 forwarded from its Near-other tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -163,6 +183,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from a snoop request hit with data=
 forwarded from its Near-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -172,6 +193,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses which hit its own tile's L2 with d=
ata in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -181,6 +203,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses which hit its own tile's L2 with d=
ata in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -190,6 +213,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses which hit its own tile's L2 with d=
ata in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -199,6 +223,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses which hit its own tile's L2 with d=
ata in S state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -208,6 +233,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that are outstanding, per weighted cycle, from the time of the=
 request to when any response is received. The outstanding response should =
be programmed only on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -217,6 +243,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -226,6 +253,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from snoop request hit with=
 data forwarded from it Far(not in the same quadrant as the request)-other =
tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -235,6 +263,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from a snoop request hit wi=
th data forwarded from its Far(not in the same quadrant as the request)-oth=
er tile's L2 in E/F state. Valid only for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -244,6 +273,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from a snoop request hit wi=
th data forwarded from its Far(not in the same quadrant as the request)-oth=
er tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -253,6 +283,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from snoop request hit with=
 data forwarded from its Near-other tile L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -262,6 +293,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from a snoop request hit wi=
th data forwarded from its Near-other tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -271,6 +303,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from a snoop request hit wi=
th data forwarded from its Near-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -280,6 +313,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses which hit its own tile's L2=
 with data in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -289,6 +323,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses which hit its own tile's L2=
 with data in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -298,6 +333,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses which hit its own tile's L2=
 with data in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -307,6 +343,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses which hit its own tile's L2=
 with data in S state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -316,6 +353,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that are outstanding, per weighted cycle, from the time=
 of the request to when any response is received. The outstanding response =
should be programmed only on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -325,6 +363,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -334,6 +373,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from snoop request hit with data forwarded from it Far(not in t=
he same quadrant as the request)-other tile L2 in E/F/M state. Valid only i=
n SNC4 Cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -343,6 +383,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from a snoop request hit with data forwarded from its Far(not i=
n the same quadrant as the request)-other tile's L2 in E/F state. Valid onl=
y for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -352,6 +393,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from a snoop request hit with data forwarded from its Far(not i=
n the same quadrant as the request)-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -361,6 +403,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from snoop request hit with data forwarded from its Near-other =
tile L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -370,6 +413,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from a snoop request hit with data forwarded from its Near-othe=
r tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -379,6 +423,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from a snoop request hit with data forwarded from its Near-othe=
r tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -388,6 +433,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses which hit its own tile's L2 with data in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -397,6 +443,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses which hit its own tile's L2 with data in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -406,6 +453,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses which hit its own tile's L2 with data in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -415,6 +463,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that are outstan=
ding, per weighted cycle, from the time of the request to when any response=
 is received. The outstanding response should be programmed only on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -424,6 +473,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for an=
y response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -433,6 +483,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from snoop request hit with data forwarded from it Far(not in the s=
ame quadrant as the request)-other tile L2 in E/F/M state. Valid only in SN=
C4 Cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -442,6 +493,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from a snoop request hit with data forwarded from its Far(not in th=
e same quadrant as the request)-other tile's L2 in E/F state. Valid only fo=
r SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -451,6 +503,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from a snoop request hit with data forwarded from its Far(not in th=
e same quadrant as the request)-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -460,6 +513,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from snoop request hit with data forwarded from its Near-other tile=
 L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -469,6 +523,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from a snoop request hit with data forwarded from its Near-other ti=
le's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -478,6 +533,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from a snoop request hit with data forwarded from its Near-other ti=
le's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -487,6 +543,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses which hit its own tile's L2 with data in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -496,6 +553,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses which hit its own tile's L2 with data in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -505,6 +563,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses which hit its own tile's L2 with data in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -514,6 +573,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses which hit its own tile's L2 with data in S state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -523,6 +583,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that are outstanding=
, per weighted cycle, from the time of the request to when any response is =
received. The outstanding response should be programmed only on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -532,6 +593,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for any resp=
onse",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -541,6 +603,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from snoop request hit with data forwarded from it Far(not in the same qu=
adrant as the request)-other tile L2 in E/F/M state. Valid only in SNC4 Clu=
ster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -550,6 +613,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from a snoop request hit with data forwarded from its Far(not in the same=
 quadrant as the request)-other tile's L2 in E/F state. Valid only for SNC4=
 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -559,6 +623,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from a snoop request hit with data forwarded from its Far(not in the same=
 quadrant as the request)-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -568,6 +633,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from snoop request hit with data forwarded from its Near-other tile L2 in=
 E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -577,6 +643,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from a snoop request hit with data forwarded from its Near-other tile's L=
2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -586,6 +653,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from a snoop request hit with data forwarded from its Near-other tile's L=
2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -595,6 +663,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s which hit its own tile's L2 with data in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -604,6 +673,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s which hit its own tile's L2 with data in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -613,6 +683,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s which hit its own tile's L2 with data in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -622,6 +693,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s which hit its own tile's L2 with data in S state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -631,6 +703,7 @@
     },
     {
         "BriefDescription": "Accounts for responses which miss its own til=
e's L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -640,6 +713,7 @@
     },
     {
         "BriefDescription": "Counts any request that are outstanding, per =
weighted cycle, from the time of the request to when any response is receiv=
ed. The outstanding response should be programmed only on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -649,6 +723,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -658,6 +733,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from snoop request hit with data forwarded from=
 it Far(not in the same quadrant as the request)-other tile L2 in E/F/M sta=
te. Valid only in SNC4 Cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -667,6 +743,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from a snoop request hit with data forwarded fr=
om its Far(not in the same quadrant as the request)-other tile's L2 in E/F =
state. Valid only for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -676,6 +753,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from a snoop request hit with data forwarded fr=
om its Far(not in the same quadrant as the request)-other tile's L2 in M st=
ate.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -685,6 +763,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from snoop request hit with data forwarded from=
 its Near-other tile L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -694,6 +773,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from a snoop request hit with data forwarded fr=
om its Near-other tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -703,6 +783,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from a snoop request hit with data forwarded fr=
om its Near-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -712,6 +793,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses which hit its own tile's L2 with data in E stat=
e",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -721,6 +803,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses which hit its own tile's L2 with data in F stat=
e",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -730,6 +813,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses which hit its own tile's L2 with data in M stat=
e",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -739,6 +823,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses which hit its own tile's L2 with data in S stat=
e",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -748,6 +833,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that are outstanding, per weighted cycle, from the time of the request to w=
hen any response is received. The outstanding response should be programmed=
 only on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -757,6 +843,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -766,6 +853,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from snoop request hit with data forwarded from it =
Far(not in the same quadrant as the request)-other tile L2 in E/F/M state. =
Valid only in SNC4 Cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -775,6 +863,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from a snoop request hit with data forwarded from i=
ts Far(not in the same quadrant as the request)-other tile's L2 in E/F stat=
e. Valid only for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -784,6 +873,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from a snoop request hit with data forwarded from i=
ts Far(not in the same quadrant as the request)-other tile's L2 in M state.=
",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -793,6 +883,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from snoop request hit with data forwarded from its=
 Near-other tile L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -802,6 +893,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from a snoop request hit with data forwarded from i=
ts Near-other tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -811,6 +903,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from a snoop request hit with data forwarded from i=
ts Near-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -820,6 +913,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses which hit its own tile's L2 with data in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -829,6 +923,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses which hit its own tile's L2 with data in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -838,6 +933,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses which hit its own tile's L2 with data in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -847,6 +943,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses which hit its own tile's L2 with data in S state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -856,6 +953,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 are outstanding, per weighted cycle, from the time of the request to when =
any response is received. The outstanding response should be programmed onl=
y on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -865,6 +963,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -874,6 +973,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from snoop request hit with data forwarded =
from it Far(not in the same quadrant as the request)-other tile L2 in E/F/M=
 state. Valid only in SNC4 Cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -883,6 +983,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from a snoop request hit with data forwarde=
d from its Far(not in the same quadrant as the request)-other tile's L2 in =
E/F state. Valid only for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_FAR_TILE_E_F"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -892,6 +993,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from a snoop request hit with data forwarde=
d from its Far(not in the same quadrant as the request)-other tile's L2 in =
M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -901,6 +1003,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from snoop request hit with data forwarded =
from its Near-other tile L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -910,6 +1013,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from a snoop request hit with data forwarde=
d from its Near-other tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_NEAR_TILE_E_F=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -919,6 +1023,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from a snoop request hit with data forwarde=
d from its Near-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -928,6 +1033,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses which hit its own tile's L2 with data in E =
state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -937,6 +1043,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses which hit its own tile's L2 with data in F =
state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -946,6 +1053,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses which hit its own tile's L2 with data in M =
state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -955,6 +1063,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses which hit its own tile's L2 with data in S =
state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -964,6 +1073,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that are outstanding, per weighted cycle, from the time of the request =
to when any response is received. The outstanding response should be progra=
mmed only on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -973,6 +1083,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -982,6 +1093,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses from a snoop request hit with data f=
orwarded from its Far(not in the same quadrant as the request)-other tile's=
 L2 in E/F state. Valid only for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_FAR_TILE_E_F"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -991,6 +1103,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses from a snoop request hit with data f=
orwarded from its Far(not in the same quadrant as the request)-other tile's=
 L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1000,6 +1113,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses from a snoop request hit with data f=
orwarded from its Near-other tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_NEAR_TILE_E_F=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1009,6 +1123,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses from a snoop request hit with data f=
orwarded from its Near-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1018,6 +1133,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses which hit its own tile's L2 with dat=
a in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1027,6 +1143,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses which hit its own tile's L2 with dat=
a in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1036,6 +1153,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses which hit its own tile's L2 with dat=
a in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1045,6 +1163,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses which hit its own tile's L2 with dat=
a in S state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1054,6 +1173,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that are outstanding, per weighted cycle, from the time of the r=
equest to when any response is received. The outstanding response should be=
 programmed only on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -1063,6 +1183,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1072,6 +1193,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from snoop request hit with data forwarded from it Far(n=
ot in the same quadrant as the request)-other tile L2 in E/F/M state. Valid=
 only in SNC4 Cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1081,6 +1203,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from a snoop request hit with data forwarded from its Fa=
r(not in the same quadrant as the request)-other tile's L2 in E/F state. Va=
lid only for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1090,6 +1213,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from a snoop request hit with data forwarded from its Fa=
r(not in the same quadrant as the request)-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1099,6 +1223,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from snoop request hit with data forwarded from its Near=
-other tile L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1108,6 +1233,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from a snoop request hit with data forwarded from its Ne=
ar-other tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1117,6 +1243,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from a snoop request hit with data forwarded from its Ne=
ar-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1126,6 +1253,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses which hit its own tile's L2 with data in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1135,6 +1263,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses which hit its own tile's L2 with data in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1144,6 +1273,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses which hit its own tile's L2 with data in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1153,6 +1283,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses which hit its own tile's L2 with data in S state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1162,6 +1293,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that are =
outstanding, per weighted cycle, from the time of the request to when any r=
esponse is received. The outstanding response should be programmed only on =
PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -1171,6 +1303,7 @@
     },
     {
         "BriefDescription": "Counts Full streaming stores (WC and should b=
e programmed on PMC1) that accounts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1180,6 +1313,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1189,6 +1323,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from snoop=
 request hit with data forwarded from it Far(not in the same quadrant as th=
e request)-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1198,6 +1333,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from a sno=
op request hit with data forwarded from its Far(not in the same quadrant as=
 the request)-other tile's L2 in E/F state. Valid only for SNC4 cluster mod=
e.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1207,6 +1343,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from a sno=
op request hit with data forwarded from its Far(not in the same quadrant as=
 the request)-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1216,6 +1353,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from snoop=
 request hit with data forwarded from its Near-other tile L2 in E/F/M state=
",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1225,6 +1363,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from a sno=
op request hit with data forwarded from its Near-other tile's L2 in E/F sta=
te.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_NEAR_TILE_E_F"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1234,6 +1373,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from a sno=
op request hit with data forwarded from its Near-other tile's L2 in M state=
.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1243,6 +1383,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses which hit =
its own tile's L2 with data in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1252,6 +1393,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses which hit =
its own tile's L2 with data in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1261,6 +1403,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses which hit =
its own tile's L2 with data in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1270,6 +1413,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses which hit =
its own tile's L2 with data in S state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1279,6 +1423,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that are outstanding, per weighted cyc=
le, from the time of the request to when any response is received. The outs=
tanding response should be programmed only on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -1288,6 +1433,7 @@
     },
     {
         "BriefDescription": "Counts Partial streaming stores (WC and shoul=
d be programmed on PMC1) that accounts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_STREAMING_STORES.ANY_RESPON=
SE",
         "MSRIndex": "0x1a7",
@@ -1297,6 +1443,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.ANY_RESPONSE",
         "MSRIndex": "0x1a7",
@@ -1306,6 +1453,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from snoop request h=
it with data forwarded from it Far(not in the same quadrant as the request)=
-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a7",
@@ -1315,6 +1463,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from a snoop request=
 hit with data forwarded from its Far(not in the same quadrant as the reque=
st)-other tile's L2 in E/F state. Valid only for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_FAR_TILE_E_F"=
,
         "MSRIndex": "0x1a7",
@@ -1324,6 +1473,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from a snoop request=
 hit with data forwarded from its Far(not in the same quadrant as the reque=
st)-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a7",
@@ -1333,6 +1483,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from snoop request h=
it with data forwarded from its Near-other tile L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a7",
@@ -1342,6 +1493,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from a snoop request=
 hit with data forwarded from its Near-other tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_NEAR_TILE_E_F=
",
         "MSRIndex": "0x1a7",
@@ -1351,6 +1503,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from a snoop request=
 hit with data forwarded from its Near-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a7",
@@ -1360,6 +1513,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses which hit its own ti=
le's L2 with data in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a7",
@@ -1369,6 +1523,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses which hit its own ti=
le's L2 with data in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a7",
@@ -1378,6 +1533,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses which hit its own ti=
le's L2 with data in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a7",
@@ -1387,6 +1543,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses which hit its own ti=
le's L2 with data in S state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a7",
@@ -1396,6 +1553,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1405,6 +1563,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from snoop request hit with data forwarded from it Far(not in t=
he same quadrant as the request)-other tile L2 in E/F/M state. Valid only i=
n SNC4 Cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1414,6 +1573,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Far(not i=
n the same quadrant as the request)-other tile's L2 in E/F state. Valid onl=
y for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1423,6 +1583,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Far(not i=
n the same quadrant as the request)-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1432,6 +1593,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from snoop request hit with data forwarded from its Near-other =
tile L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1441,6 +1603,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Near-othe=
r tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_NEAR_TILE_E_F"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1450,6 +1613,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Near-othe=
r tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1459,6 +1623,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses which hit its own tile's L2 with data in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1468,6 +1633,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses which hit its own tile's L2 with data in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1477,6 +1643,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses which hit its own tile's L2 with data in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1486,6 +1653,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses which hit its own tile's L2 with data in S state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1495,6 +1663,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that are outstan=
ding, per weighted cycle, from the time of the request to when any response=
 is received. The outstanding response should be programmed only on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -1504,6 +1673,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1513,6 +1683,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from snoop request hit with data forwarded from it Far(not in t=
he same quadrant as the request)-other tile L2 in E/F/M state. Valid only i=
n SNC4 Cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1522,6 +1693,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Far(not i=
n the same quadrant as the request)-other tile's L2 in E/F state. Valid onl=
y for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1531,6 +1703,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Far(not i=
n the same quadrant as the request)-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1540,6 +1713,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from snoop request hit with data forwarded from its Near-other =
tile L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1549,6 +1723,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Near-othe=
r tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_NEAR_TILE_E_F"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1558,6 +1733,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Near-othe=
r tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1567,6 +1743,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses which hit its own tile's L2 with data in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1576,6 +1753,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses which hit its own tile's L2 with data in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1585,6 +1763,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that are outstan=
ding, per weighted cycle, from the time of the request to when any response=
 is received. The outstanding response should be programmed only on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -1594,6 +1773,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1603,6 +1783,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from a snoop request hit with=
 data forwarded from its Far(not in the same quadrant as the request)-other=
 tile's L2 in E/F state. Valid only for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1612,6 +1793,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from a snoop request hit with=
 data forwarded from its Far(not in the same quadrant as the request)-other=
 tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1621,6 +1803,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from snoop request hit with d=
ata forwarded from its Near-other tile L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1630,6 +1813,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from a snoop request hit with=
 data forwarded from its Near-other tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1639,6 +1823,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from a snoop request hit with=
 data forwarded from its Near-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1648,6 +1833,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses which hit its own tile's L2 w=
ith data in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1657,6 +1843,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses which hit its own tile's L2 w=
ith data in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1666,6 +1853,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses which hit its own tile's L2 w=
ith data in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1675,6 +1863,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses which hit its own tile's L2 w=
ith data in S state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1684,6 +1873,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1693,6 +1883,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from snoop request hit with data forwarded from it Far(not in the=
 same quadrant as the request)-other tile L2 in E/F/M state. Valid only in =
SNC4 Cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1702,6 +1893,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from a snoop request hit with data forwarded from its Far(not in =
the same quadrant as the request)-other tile's L2 in E/F state. Valid only =
for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1711,6 +1903,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from a snoop request hit with data forwarded from its Far(not in =
the same quadrant as the request)-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1720,6 +1913,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from snoop request hit with data forwarded from its Near-other ti=
le L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1729,6 +1923,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from a snoop request hit with data forwarded from its Near-other =
tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1738,6 +1933,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from a snoop request hit with data forwarded from its Near-other =
tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1747,6 +1943,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses which hit its own tile's L2 with data in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1756,6 +1953,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses which hit its own tile's L2 with data in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1765,6 +1963,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses which hit its own tile's L2 with data in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1774,6 +1973,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses which hit its own tile's L2 with data in S state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1783,6 +1983,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that are outstandi=
ng, per weighted cycle, from the time of the request to when any response i=
s received. The outstanding response should be programmed only on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -1792,6 +1993,7 @@
     },
     {
         "BriefDescription": "Counts all streaming stores (WC and should be=
 programmed on PMC1) that accounts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.ANY_RESPONSE",
         "MSRIndex": "0x1a7",
@@ -1801,6 +2003,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for any response",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1810,6 +2013,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from a snoop request hit wi=
th data forwarded from its Far(not in the same quadrant as the request)-oth=
er tile's L2 in E/F state. Valid only for SNC4 cluster mode.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1819,6 +2023,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from a snoop request hit wi=
th data forwarded from its Far(not in the same quadrant as the request)-oth=
er tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1828,6 +2033,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from snoop request hit with=
 data forwarded from its Near-other tile L2 in E/F/M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1837,6 +2043,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from a snoop request hit wi=
th data forwarded from its Near-other tile's L2 in E/F state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_NEAR_TILE_E_F"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1846,6 +2053,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from a snoop request hit wi=
th data forwarded from its Near-other tile's L2 in M state.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1855,6 +2063,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses which hit its own tile's L2=
 with data in E state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1864,6 +2073,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses which hit its own tile's L2=
 with data in F state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1873,6 +2083,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses which hit its own tile's L2=
 with data in M state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1882,6 +2093,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses which hit its own tile's L2=
 with data in S state",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1891,6 +2103,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that are outstanding, per weighted cycle, from the time=
 of the request to when any response is received. The outstanding response =
should be programmed only on PMC0.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.OUTSTANDING",
         "MSRIndex": "0x1a6",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/counter.json b/t=
ools/perf/pmu-events/arch/x86/knightslanding/counter.json
new file mode 100644
index 000000000000..4ce9f30a4fe5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/counter.json
@@ -0,0 +1,37 @@
+[
+    {
+        "Unit": "core",
+        "CountersNumFixed": "3",
+        "CountersNumGeneric": "2"
+    },
+    {
+        "Unit": "CHA",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "EDC_ECLK",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "EDC_UCLK",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "iMC_DCLK",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "iMC_UCLK",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    },
+    {
+        "Unit": "M2PCIe",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.j=
son b/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
index 089aa3ef345d..29c0ff23957a 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of floating operations reti=
red that required microcode assists",
+        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.FP_ASSIST",
         "PublicDescription": "This event counts the number of times that t=
he pipeline stalled due to FP operations needing assists.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Counts the number of packed SSE, AVX, AVX2, A=
VX-512 micro-ops (both floating point and integer) except for loads (memory=
-to-register mov-type micro-ops), packed byte and word multiplies.",
+        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.PACKED_SIMD",
         "PublicDescription": "The length of the packed operation (128bits,=
 256bits or 512bits) is not taken into account when updating the counter; a=
ll count the same (+1). \r\nMask (k) registers are ignored. For example: a =
micro-op operating with a mask that only enables one element or even zero e=
lements will still trigger this counter (+1)\r\nThis event is defined at th=
e micro-op level and not instruction level. Most instructions are implement=
ed with one micro-op but not all.",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Counts the number of scalar SSE, AVX, AVX2, A=
VX-512 micro-ops except for loads (memory-to-register mov-type micro ops), =
division, sqrt.",
+        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.SCALAR_SIMD",
         "PublicDescription": "This event is defined at the micro-op level =
and not instruction level. Most instructions are implemented with one micro=
-op but not all.",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/frontend.json b/=
tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
index 9001f5019848..63343a0d1e86 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of times the front end rest=
eers for any branch as a result of another branch handling mechanism in the=
 front end.",
+        "Counter": "0,1",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.ALL",
         "SampleAfterValue": "200003",
@@ -8,6 +9,7 @@
     },
     {
         "BriefDescription": "Counts the number of times the front end rest=
eers for conditional branches as a result of another branch handling mechan=
ism in the front end.",
+        "Counter": "0,1",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.COND",
         "SampleAfterValue": "200003",
@@ -15,6 +17,7 @@
     },
     {
         "BriefDescription": "Counts the number of times the front end rest=
eers for RET branches as a result of another branch handling mechanism in t=
he front end.",
+        "Counter": "0,1",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.RETURN",
         "SampleAfterValue": "200003",
@@ -22,6 +25,7 @@
     },
     {
         "BriefDescription": "Counts all instruction fetches, including unc=
acheable fetches.",
+        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
         "SampleAfterValue": "200003",
@@ -29,6 +33,7 @@
     },
     {
         "BriefDescription": "Counts all instruction fetches that hit the i=
nstruction cache.",
+        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.HIT",
         "SampleAfterValue": "200003",
@@ -36,6 +41,7 @@
     },
     {
         "BriefDescription": "Counts all instruction fetches that miss the =
instruction cache or produce memory requests. An instruction fetch miss is =
counted only once and not once for every cycle it is outstanding.",
+        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "SampleAfterValue": "200003",
@@ -43,6 +49,7 @@
     },
     {
         "BriefDescription": "Counts the number of times the MSROM starts a=
 flow of uops.",
+        "Counter": "0,1",
         "EventCode": "0xE7",
         "EventName": "MS_DECODED.MS_ENTRY",
         "SampleAfterValue": "200003",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/memory.json b/to=
ols/perf/pmu-events/arch/x86/knightslanding/memory.json
index b0361f6f0dd9..7e4518986bb9 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of times the machine clears=
 due to memory ordering hazards",
+        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "SampleAfterValue": "200003",
@@ -8,6 +9,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for data responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -26,6 +29,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for data responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -35,6 +39,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from MCDRAM (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -44,6 +49,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for data responses from MCDRAM Far or Other tile=
 L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -53,6 +59,7 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for data responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -62,6 +69,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -71,6 +79,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for data responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -80,6 +89,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for data responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -89,6 +99,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from MCDRAM (local and far)=
",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -98,6 +109,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for data responses from MCDRAM Far or Oth=
er tile L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -107,6 +119,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for data responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -116,6 +129,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r data responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -125,6 +139,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r data responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -134,6 +149,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from MCDRAM (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -143,6 +159,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r data responses from MCDRAM Far or Other tile L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -152,6 +169,7 @@
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r data responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -161,6 +179,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -170,6 +189,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for da=
ta responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -179,6 +199,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for da=
ta responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -188,6 +209,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from MCDRAM (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -197,6 +219,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for da=
ta responses from MCDRAM Far or Other tile L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -206,6 +229,7 @@
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for da=
ta responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -215,6 +239,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -224,6 +249,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for data res=
ponses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -233,6 +259,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for data res=
ponses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -242,6 +269,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from MCDRAM (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -251,6 +279,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for data res=
ponses from MCDRAM Far or Other tile L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -260,6 +289,7 @@
     },
     {
         "BriefDescription": "Counts any request that accounts for data res=
ponses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -269,6 +299,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -278,6 +309,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for data responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -287,6 +319,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for data responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -296,6 +329,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from MCDRAM (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -305,6 +339,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for data responses from MCDRAM Far or Other tile L2 hit far."=
,
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -314,6 +349,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for data responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -323,6 +359,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -332,6 +369,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for data responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -341,6 +379,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for data responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -350,6 +389,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from MCDRAM (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -359,6 +399,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -368,6 +409,7 @@
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for data responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -377,6 +419,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -386,6 +429,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for data responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -395,6 +439,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for data responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -404,6 +449,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from MCDRAM (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -413,6 +459,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for data responses from MCDRAM Far or Other tile L2 hit f=
ar.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -422,6 +469,7 @@
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for data responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -431,6 +479,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -440,6 +489,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for data responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -449,6 +499,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for data responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -458,6 +509,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses from MCDRAM (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -467,6 +519,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for data responses from MCDRAM Far or Other tile L=
2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -476,6 +529,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for data responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -485,6 +539,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -494,6 +549,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for data responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -503,6 +559,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for data responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -512,6 +569,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from MCDRAM (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -521,6 +579,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for data responses from MCDRAM Far or Other tile L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -530,6 +589,7 @@
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for data responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -539,6 +599,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from DDR (=
local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -548,6 +609,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for data responses from =
DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -557,6 +619,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for data responses from =
DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -566,6 +629,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from MCDRA=
M (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -575,6 +639,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for data responses from =
MCDRAM Far or Other tile L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -584,6 +649,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for data responses from =
MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -593,6 +659,7 @@
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from any N=
ON_DRAM system address. This includes MMIO transactions",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -602,6 +669,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for data responses from DRAM Far."=
,
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.DDR_FAR",
         "MSRIndex": "0x1a7",
@@ -611,6 +679,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for data responses from DRAM Local=
.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.DDR_NEAR",
         "MSRIndex": "0x1a7",
@@ -620,6 +689,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from MCDRAM (local a=
nd far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.MCDRAM",
         "MSRIndex": "0x1a7",
@@ -629,6 +699,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for data responses from MCDRAM Far=
 or Other tile L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.MCDRAM_FAR",
         "MSRIndex": "0x1a7",
@@ -638,6 +709,7 @@
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for data responses from MCDRAM Loc=
al.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.MCDRAM_NEAR",
         "MSRIndex": "0x1a7",
@@ -647,6 +719,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -656,6 +729,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r data responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -665,6 +739,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r data responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -674,6 +749,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r data responses from MCDRAM Far or Other tile L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -683,6 +759,7 @@
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r data responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -692,6 +769,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -701,6 +779,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r data responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -710,6 +789,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r data responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -719,6 +799,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r data responses from MCDRAM Far or Other tile L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -728,6 +809,7 @@
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r data responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -737,6 +819,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -746,6 +829,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for data responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -755,6 +839,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for data responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -764,6 +849,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from MCDRAM (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -773,6 +859,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for data responses from MCDRAM Far or Other=
 tile L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -782,6 +869,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for data responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -791,6 +879,7 @@
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from any NON_DRAM system addr=
ess. This includes MMIO transactions",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -800,6 +889,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -809,6 +899,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
data responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -818,6 +909,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
data responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -827,6 +919,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from MCDRAM (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -836,6 +929,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
data responses from MCDRAM Far or Other tile L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -845,6 +939,7 @@
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
data responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -854,6 +949,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from DDR (local and far)",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.DDR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -863,6 +959,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for data responses from DRAM Far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -872,6 +969,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for data responses from DRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -881,6 +979,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from MCDRAM (local and far)=
",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -890,6 +989,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for data responses from MCDRAM Far or Oth=
er tile L2 hit far.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
@@ -899,6 +999,7 @@
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for data responses from MCDRAM Local.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json b/=
tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
index 5b2e71750976..37d679ed8061 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of branch instructions reti=
red (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -8,6 +9,7 @@
     },
     {
         "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CALL",
         "PEBS": "1",
@@ -16,6 +18,7 @@
     },
     {
         "BriefDescription": "Counts the number of far branch instructions =
retired. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
@@ -24,6 +27,7 @@
     },
     {
         "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
         "PEBS": "1",
@@ -32,6 +36,7 @@
     },
     {
         "BriefDescription": "Counts the number of branch instructions reti=
red that were conditional jumps. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.JCC",
         "PEBS": "1",
@@ -40,6 +45,7 @@
     },
     {
         "BriefDescription": "Counts the number of branch instructions reti=
red that were near indirect CALL or near indirect JMP. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
@@ -48,6 +54,7 @@
     },
     {
         "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
         "PEBS": "1",
@@ -56,6 +63,7 @@
     },
     {
         "BriefDescription": "Counts the number of near RET branch instruct=
ions retired. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.RETURN",
         "PEBS": "1",
@@ -64,6 +72,7 @@
     },
     {
         "BriefDescription": "Counts the number of branch instructions reti=
red that were conditional jumps and predicted taken. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
         "PEBS": "1",
@@ -72,6 +81,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -79,6 +89,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near CALL b=
ranch instructions retired. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.CALL",
         "PEBS": "1",
@@ -87,6 +98,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted far branch =
instructions retired. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.FAR_BRANCH",
         "PEBS": "1",
@@ -95,6 +107,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
         "PEBS": "1",
@@ -103,6 +116,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired that were conditional jumps. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.JCC",
         "PEBS": "1",
@@ -111,6 +125,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired that were near indirect CALL or near indirect JMP. (Precis=
e Event)",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
@@ -119,6 +134,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near relati=
ve CALL branch instructions retired. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.REL_CALL",
         "PEBS": "1",
@@ -127,6 +143,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired. (Precise Event)",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.RETURN",
         "PEBS": "1",
@@ -135,6 +152,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired that were conditional jumps and predicted taken. (Precise =
Event)",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
         "PEBS": "1",
@@ -143,6 +161,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock=
 cycles",
+        "Counter": "0,1",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF",
         "SampleAfterValue": "2000003",
@@ -150,12 +169,14 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of core cycles =
while the thread is not in a halt state. The thread enters the halt state w=
hen it is running the HLT instruction. This event is a component in many ke=
y event ratios. The core frequency may change from time to time due to tran=
sitions associated with Enhanced Intel SpeedStep Technology or TM2. For thi=
s reason this event may have a changing ratio with regards to time. When th=
e core frequency is constant, this event can approximate elapsed time while=
 the core was not in the halt state. It is counted on a dedicated fixed cou=
nter",
         "SampleAfterValue": "2000003",
@@ -163,12 +184,14 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es",
+        "Counter": "0,1",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Cycles the number of core cycles when divider=
 is busy.  Does not imply a stall waiting for the divider.",
+        "Counter": "0,1",
         "EventCode": "0xCD",
         "EventName": "CYCLES_DIV_BUSY.ALL",
         "PublicDescription": "This event counts cycles when the divider is=
 busy. More specifically cycles when the divide unit is unable to accept a =
new divide uop because it is busy processing a previously dispatched uop. T=
he cycles will be counted irrespective of whether or not another divide uop=
 is waiting to enter the divide unit (from the RS). This event counts integ=
er divides, x87 divides, divss, divsd, sqrtss, sqrtsd event and does not co=
unt vector divides.",
@@ -177,6 +200,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions=
 that retire.  For instructions that consist of multiple micro-ops, this ev=
ent counts exactly once, as the last micro-op of the instruction retires.  =
The event continues counting while instructions retire, including during in=
terrupt service routines caused by hardware interrupts, faults or traps.",
         "SampleAfterValue": "2000003",
@@ -184,12 +208,14 @@
     },
     {
         "BriefDescription": "Counts the total number of instructions retir=
ed",
+        "Counter": "0,1",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Counts the number of instructions retired (Pr=
ecise Event)",
+        "Counter": "0",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_PS",
         "PEBS": "2",
@@ -197,6 +223,7 @@
     },
     {
         "BriefDescription": "Counts all machine clears",
+        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.ALL",
         "SampleAfterValue": "200003",
@@ -204,6 +231,7 @@
     },
     {
         "BriefDescription": "Counts the number of times that the machine c=
lears due to program modifying data within 1K of a recently fetched code pa=
ge",
+        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "SampleAfterValue": "200003",
@@ -211,6 +239,7 @@
     },
     {
         "BriefDescription": "Counts the total number of core cycles when n=
o micro-ops are allocated for any reason.",
+        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.ALL",
         "SampleAfterValue": "200003",
@@ -218,6 +247,7 @@
     },
     {
         "BriefDescription": "Counts the number of core cycles when no micr=
o-ops are allocated and the alloc pipe is stalled waiting for a mispredicte=
d branch to retire.",
+        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.MISPREDICTS",
         "PublicDescription": "This event counts the number of core cycles =
when no uops are allocated and the alloc pipe is stalled waiting for a misp=
redicted branch to retire.",
@@ -226,6 +256,7 @@
     },
     {
         "BriefDescription": "Counts the number of core cycles when no micr=
o-ops are allocated, the IQ is empty, and no other condition is blocking al=
location.",
+        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.NOT_DELIVERED",
         "PublicDescription": "This event counts the number of core cycles =
when no uops are allocated, the instruction queue is empty and the alloc pi=
pe is stalled waiting for instructions to be fetched.",
@@ -234,6 +265,7 @@
     },
     {
         "BriefDescription": "Counts the number of core cycles when no micr=
o-ops are allocated and a RATstall (caused by reservation station full) is =
asserted.",
+        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.RAT_STALL",
         "SampleAfterValue": "200003",
@@ -241,6 +273,7 @@
     },
     {
         "BriefDescription": "Counts the number of core cycles when no micr=
o-ops are allocated and the ROB is full",
+        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.ROB_FULL",
         "SampleAfterValue": "200003",
@@ -248,6 +281,7 @@
     },
     {
         "BriefDescription": "Counts any retired load that was pushed into =
the recycle queue for any reason.",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.ANY_LD",
         "SampleAfterValue": "200003",
@@ -255,6 +289,7 @@
     },
     {
         "BriefDescription": "Counts any retired store that was pushed into=
 the recycle queue for any reason.",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.ANY_ST",
         "SampleAfterValue": "200003",
@@ -262,6 +297,7 @@
     },
     {
         "BriefDescription": "Counts the number of occurrences a retired lo=
ad gets blocked because its address overlaps with a store whose data is not=
 ready",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_BLOCK_STD_NOTREADY",
         "SampleAfterValue": "200003",
@@ -269,6 +305,7 @@
     },
     {
         "BriefDescription": "Counts the number of occurrences a retired lo=
ad gets blocked because its address partially overlaps with a store  (Preci=
se Event)",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_BLOCK_ST_FORWARD",
@@ -279,6 +316,7 @@
     },
     {
         "BriefDescription": "Counts the number of occurrences a retired lo=
ad was pushed into the rehab queue because it sees a cache line split. Each=
 split should be counted only once. (Precise Event)",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_SPLITS",
@@ -289,6 +327,7 @@
     },
     {
         "BriefDescription": "Counts all the retired locked loads. It does =
not include stores because we would double count if we count stores",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LOCK",
         "SampleAfterValue": "200003",
@@ -296,6 +335,7 @@
     },
     {
         "BriefDescription": "Counts the store micro-ops retired that were =
pushed in the rehab queue because the store address buffer is full",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.STA_FULL",
         "SampleAfterValue": "200003",
@@ -303,6 +343,7 @@
     },
     {
         "BriefDescription": "Counts the number of occurrences a retired st=
ore that is a cache line split. Each split should be counted only once.",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.ST_SPLITS",
         "PublicDescription": "This event counts the number of retired stor=
e that experienced a cache line boundary split(Precise Event). Note that ea=
ch spilt should be counted only once.",
@@ -311,6 +352,7 @@
     },
     {
         "BriefDescription": "Counts the total number of core cycles alloca=
tion pipeline is stalled when any one of the reservation stations is full."=
,
+        "Counter": "0,1",
         "EventCode": "0xCB",
         "EventName": "RS_FULL_STALL.ALL",
         "SampleAfterValue": "200003",
@@ -318,6 +360,7 @@
     },
     {
         "BriefDescription": "Counts the number of core cycles when allocat=
ion pipeline is stalled and is waiting for a free MEC reservation station e=
ntry.",
+        "Counter": "0,1",
         "EventCode": "0xCB",
         "EventName": "RS_FULL_STALL.MEC",
         "SampleAfterValue": "200003",
@@ -325,6 +368,7 @@
     },
     {
         "BriefDescription": "Counts the number of micro-ops retired",
+        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ALL",
         "PublicDescription": "This event counts the number of micro-ops (u=
ops) retired. The processor decodes complex macro instructions into a seque=
nce of simpler uops. Most instructions are composed of one or two uops. Som=
e instructions are decoded into longer sequences such as repeat instruction=
s, floating point transcendental instructions, and assists.",
@@ -333,6 +377,7 @@
     },
     {
         "BriefDescription": "Counts the number of micro-ops retired that a=
re from the complex flows issued by the micro-sequencer (MS).",
+        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.MS",
         "PublicDescription": "This event counts the number of micro-ops re=
tired that were supplied from MSROM.",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.jso=
n b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
index 120e4813d82a..1550b6457965 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IP=
Q",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.IPQ_HIT",
         "PerPkg": "1",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IP=
Q",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.IPQ_MISS",
         "PerPkg": "1",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IR=
Q",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.IRQ_HIT",
         "PerPkg": "1",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IR=
Q",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.IRQ_MISS",
         "PerPkg": "1",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IR=
Q or PRQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOC_ALL",
         "PerPkg": "1",
@@ -41,6 +46,7 @@
     },
     {
         "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -PR=
Q",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.PRQ_HIT",
         "PerPkg": "1",
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -PR=
Q",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.PRQ_MISS",
         "PerPkg": "1",
@@ -57,6 +64,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR0",
         "PerPkg": "1",
@@ -65,6 +73,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR1",
         "PerPkg": "1",
@@ -73,6 +82,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR2",
         "PerPkg": "1",
@@ -81,6 +91,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR3",
         "PerPkg": "1",
@@ -89,6 +100,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR4",
         "PerPkg": "1",
@@ -97,6 +109,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR5",
         "PerPkg": "1",
@@ -105,6 +118,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR6",
         "PerPkg": "1",
@@ -113,6 +127,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR7",
         "PerPkg": "1",
@@ -121,6 +136,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 0-7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED_EXT.ANY_OF_TGR0_THRU_TGR7"=
,
         "PerPkg": "1",
@@ -129,6 +145,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 8",
+        "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED_EXT.TGR8",
         "PerPkg": "1",
@@ -137,6 +154,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR0",
         "PerPkg": "1",
@@ -145,6 +163,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR1",
         "PerPkg": "1",
@@ -153,6 +172,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR2",
         "PerPkg": "1",
@@ -161,6 +181,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR3",
         "PerPkg": "1",
@@ -169,6 +190,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR4",
         "PerPkg": "1",
@@ -177,6 +199,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR5",
         "PerPkg": "1",
@@ -185,6 +208,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR6",
         "PerPkg": "1",
@@ -193,6 +217,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR7",
         "PerPkg": "1",
@@ -201,6 +226,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 0-7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY_EXT.ANY_OF_TGR0_THRU_TGR7=
",
         "PerPkg": "1",
@@ -209,6 +235,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 8",
+        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY_EXT.TGR8",
         "PerPkg": "1",
@@ -217,6 +244,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR0",
         "PerPkg": "1",
@@ -225,6 +253,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR1",
         "PerPkg": "1",
@@ -233,6 +262,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR2",
         "PerPkg": "1",
@@ -241,6 +271,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR3",
         "PerPkg": "1",
@@ -249,6 +280,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR4",
         "PerPkg": "1",
@@ -257,6 +289,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR5",
         "PerPkg": "1",
@@ -265,6 +298,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR6",
         "PerPkg": "1",
@@ -273,6 +307,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR7",
         "PerPkg": "1",
@@ -281,6 +316,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 0-7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED_EXT.ANY_OF_TGR0_THRU_TGR7"=
,
         "PerPkg": "1",
@@ -289,6 +325,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 8",
+        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED_EXT.TGR8",
         "PerPkg": "1",
@@ -297,6 +334,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR0",
         "PerPkg": "1",
@@ -305,6 +343,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR1",
         "PerPkg": "1",
@@ -313,6 +352,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR2",
         "PerPkg": "1",
@@ -321,6 +361,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR3",
         "PerPkg": "1",
@@ -329,6 +370,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR4",
         "PerPkg": "1",
@@ -337,6 +379,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR5",
         "PerPkg": "1",
@@ -345,6 +388,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR6",
         "PerPkg": "1",
@@ -353,6 +397,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR7",
         "PerPkg": "1",
@@ -361,6 +406,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 0-7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8B",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY_EXT.ANY_OF_TGR0_THRU_TGR7=
",
         "PerPkg": "1",
@@ -369,6 +415,7 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 8",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8B",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY_EXT.TGR8",
         "PerPkg": "1",
@@ -377,6 +424,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR0",
         "PerPkg": "1",
@@ -385,6 +433,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR1",
         "PerPkg": "1",
@@ -393,6 +442,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR2",
         "PerPkg": "1",
@@ -401,6 +451,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR3",
         "PerPkg": "1",
@@ -409,6 +460,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR4",
         "PerPkg": "1",
@@ -417,6 +469,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR5",
         "PerPkg": "1",
@@ -425,6 +478,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR6",
         "PerPkg": "1",
@@ -433,6 +487,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR7",
         "PerPkg": "1",
@@ -441,6 +496,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0-7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD_EXT.ANY_OF_TGR=
0_THRU_TGR7",
         "PerPkg": "1",
@@ -449,6 +505,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD_EXT.TGR8",
         "PerPkg": "1",
@@ -457,6 +514,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR0",
         "PerPkg": "1",
@@ -465,6 +523,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR1",
         "PerPkg": "1",
@@ -473,6 +532,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR2",
         "PerPkg": "1",
@@ -481,6 +541,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR3",
         "PerPkg": "1",
@@ -489,6 +550,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR4",
         "PerPkg": "1",
@@ -497,6 +559,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR5",
         "PerPkg": "1",
@@ -505,6 +568,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR6",
         "PerPkg": "1",
@@ -513,6 +577,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR7",
         "PerPkg": "1",
@@ -521,6 +586,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0-7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD5",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL_EXT.ANY_OF_TGR=
0_THRU_TGR7",
         "PerPkg": "1",
@@ -529,6 +595,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD5",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL_EXT.TGR8",
         "PerPkg": "1",
@@ -537,6 +604,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR0",
         "PerPkg": "1",
@@ -545,6 +613,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR1",
         "PerPkg": "1",
@@ -553,6 +622,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR2",
         "PerPkg": "1",
@@ -561,6 +631,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR3",
         "PerPkg": "1",
@@ -569,6 +640,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR4",
         "PerPkg": "1",
@@ -577,6 +649,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR5",
         "PerPkg": "1",
@@ -585,6 +658,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR6",
         "PerPkg": "1",
@@ -593,6 +667,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR7",
         "PerPkg": "1",
@@ -601,6 +676,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 0-7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED_EXT.ANY_OF_TGR0_THRU_TGR7"=
,
         "PerPkg": "1",
@@ -609,6 +685,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 8",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED_EXT.TGR8",
         "PerPkg": "1",
@@ -617,6 +694,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR0",
         "PerPkg": "1",
@@ -625,6 +703,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR1",
         "PerPkg": "1",
@@ -633,6 +712,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR2",
         "PerPkg": "1",
@@ -641,6 +721,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR3",
         "PerPkg": "1",
@@ -649,6 +730,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR4",
         "PerPkg": "1",
@@ -657,6 +739,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR5",
         "PerPkg": "1",
@@ -665,6 +748,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR6",
         "PerPkg": "1",
@@ -673,6 +757,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR7",
         "PerPkg": "1",
@@ -681,6 +766,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 0-7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY_EXT.ANY_OF_TGR0_THRU_TGR7=
",
         "PerPkg": "1",
@@ -689,6 +775,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 8",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY_EXT.TGR8",
         "PerPkg": "1",
@@ -697,6 +784,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR0",
         "PerPkg": "1",
@@ -705,6 +793,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR1",
         "PerPkg": "1",
@@ -713,6 +802,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR2",
         "PerPkg": "1",
@@ -721,6 +811,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR3",
         "PerPkg": "1",
@@ -729,6 +820,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR4",
         "PerPkg": "1",
@@ -737,6 +829,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR5",
         "PerPkg": "1",
@@ -745,6 +838,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR6",
         "PerPkg": "1",
@@ -753,6 +847,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR7",
         "PerPkg": "1",
@@ -761,6 +856,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 0-7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8D",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED_EXT.ANY_OF_TGR0_THRU_TGR7"=
,
         "PerPkg": "1",
@@ -769,6 +865,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 8",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8D",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED_EXT.TGR8",
         "PerPkg": "1",
@@ -777,6 +874,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR0",
         "PerPkg": "1",
@@ -785,6 +883,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR1",
         "PerPkg": "1",
@@ -793,6 +892,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR2",
         "PerPkg": "1",
@@ -801,6 +901,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR3",
         "PerPkg": "1",
@@ -809,6 +910,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR4",
         "PerPkg": "1",
@@ -817,6 +919,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR5",
         "PerPkg": "1",
@@ -825,6 +928,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR6",
         "PerPkg": "1",
@@ -833,6 +937,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR7",
         "PerPkg": "1",
@@ -841,6 +946,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 0-7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8F",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY_EXT.ANY_OF_TGR0_THRU_TGR7=
",
         "PerPkg": "1",
@@ -849,6 +955,7 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 8",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8F",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY_EXT.TGR8",
         "PerPkg": "1",
@@ -857,6 +964,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR0",
         "PerPkg": "1",
@@ -865,6 +973,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR1",
         "PerPkg": "1",
@@ -873,6 +982,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR2",
         "PerPkg": "1",
@@ -881,6 +991,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR3",
         "PerPkg": "1",
@@ -889,6 +1000,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR4",
         "PerPkg": "1",
@@ -897,6 +1009,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR5",
         "PerPkg": "1",
@@ -905,6 +1018,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR6",
         "PerPkg": "1",
@@ -913,6 +1027,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR7",
         "PerPkg": "1",
@@ -921,6 +1036,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0-7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD_EXT.ANY_OF_TGR=
0_THRU_TGR7",
         "PerPkg": "1",
@@ -929,6 +1045,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD_EXT.TGR8",
         "PerPkg": "1",
@@ -937,6 +1054,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR0",
         "PerPkg": "1",
@@ -945,6 +1063,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR1",
         "PerPkg": "1",
@@ -953,6 +1072,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR2",
         "PerPkg": "1",
@@ -961,6 +1081,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR3",
         "PerPkg": "1",
@@ -969,6 +1090,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR4",
         "PerPkg": "1",
@@ -977,6 +1099,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR5",
         "PerPkg": "1",
@@ -985,6 +1108,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR6",
         "PerPkg": "1",
@@ -993,6 +1117,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR7",
         "PerPkg": "1",
@@ -1001,6 +1126,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0-7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD7",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL_EXT.ANY_OF_TGR=
0_THRU_TGR7",
         "PerPkg": "1",
@@ -1009,6 +1135,7 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
         "EventCode": "0xD7",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL_EXT.TGR8",
         "PerPkg": "1",
@@ -1017,6 +1144,7 @@
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Writeback transactions from L2 to the LLC  This includes=
 all write transactions -- both Cacheable and UC.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.E_STATE",
         "PerPkg": "1",
@@ -1025,6 +1153,7 @@
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Filters for any transaction originating from the IPQ or =
IRQ.  This does not include lookups originating from the ISMQ.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.F_STATE",
         "PerPkg": "1",
@@ -1033,6 +1162,7 @@
     },
     {
         "BriefDescription": "Lines Victimized that Match NID",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.LOCAL",
         "PerPkg": "1",
@@ -1041,6 +1171,7 @@
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Read transactions",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.M_STATE",
         "PerPkg": "1",
@@ -1049,6 +1180,7 @@
     },
     {
         "BriefDescription": "Lines Victimized that Does Not Match NID",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.REMOTE",
         "PerPkg": "1",
@@ -1057,6 +1189,7 @@
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Filters for only snoop requests coming from the remote s=
ocket(s) through the IPQ.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.S_STATE",
         "PerPkg": "1",
@@ -1065,6 +1198,7 @@
     },
     {
         "BriefDescription": "Uncore Clocks",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_H_CLOCK",
         "PerPkg": "1",
@@ -1072,6 +1206,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal ADS Used",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9D",
         "EventName": "UNC_H_EGRESS_HORZ_ADS_USED.AD",
         "PerPkg": "1",
@@ -1080,6 +1215,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal ADS Used",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9D",
         "EventName": "UNC_H_EGRESS_HORZ_ADS_USED.AK",
         "PerPkg": "1",
@@ -1088,6 +1224,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal ADS Used",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9D",
         "EventName": "UNC_H_EGRESS_HORZ_ADS_USED.BL",
         "PerPkg": "1",
@@ -1096,6 +1233,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Bypass. AD ring",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9F",
         "EventName": "UNC_H_EGRESS_HORZ_BYPASS.AD",
         "PerPkg": "1",
@@ -1104,6 +1242,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Bypass. AK ring",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9F",
         "EventName": "UNC_H_EGRESS_HORZ_BYPASS.AK",
         "PerPkg": "1",
@@ -1112,6 +1251,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Bypass. BL ring",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9F",
         "EventName": "UNC_H_EGRESS_HORZ_BYPASS.BL",
         "PerPkg": "1",
@@ -1120,6 +1260,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Bypass. IV ring",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9F",
         "EventName": "UNC_H_EGRESS_HORZ_BYPASS.IV",
         "PerPkg": "1",
@@ -1128,6 +1269,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full AD=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x96",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_FULL.AD",
         "PerPkg": "1",
@@ -1136,6 +1278,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full AK=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x96",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_FULL.AK",
         "PerPkg": "1",
@@ -1144,6 +1287,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full BL=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x96",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_FULL.BL",
         "PerPkg": "1",
@@ -1152,6 +1296,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full IV=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x96",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_FULL.IV",
         "PerPkg": "1",
@@ -1160,6 +1305,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty AD",
+        "Counter": "0,1,2,3",
         "EventCode": "0x97",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_NE.AD",
         "PerPkg": "1",
@@ -1168,6 +1314,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty AK",
+        "Counter": "0,1,2,3",
         "EventCode": "0x97",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_NE.AK",
         "PerPkg": "1",
@@ -1176,6 +1323,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty BL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x97",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_NE.BL",
         "PerPkg": "1",
@@ -1184,6 +1332,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty IV",
+        "Counter": "0,1,2,3",
         "EventCode": "0x97",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_NE.IV",
         "PerPkg": "1",
@@ -1192,6 +1341,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Inserts AD",
+        "Counter": "0,1,2,3",
         "EventCode": "0x95",
         "EventName": "UNC_H_EGRESS_HORZ_INSERTS.AD",
         "PerPkg": "1",
@@ -1200,6 +1350,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Inserts AK",
+        "Counter": "0,1,2,3",
         "EventCode": "0x95",
         "EventName": "UNC_H_EGRESS_HORZ_INSERTS.AK",
         "PerPkg": "1",
@@ -1208,6 +1359,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Inserts BL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x95",
         "EventName": "UNC_H_EGRESS_HORZ_INSERTS.BL",
         "PerPkg": "1",
@@ -1216,6 +1368,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Inserts IV",
+        "Counter": "0,1,2,3",
         "EventCode": "0x95",
         "EventName": "UNC_H_EGRESS_HORZ_INSERTS.IV",
         "PerPkg": "1",
@@ -1224,6 +1377,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress NACKs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x99",
         "EventName": "UNC_H_EGRESS_HORZ_NACK.AD",
         "PerPkg": "1",
@@ -1232,6 +1386,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress NACKs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x99",
         "EventName": "UNC_H_EGRESS_HORZ_NACK.AK",
         "PerPkg": "1",
@@ -1240,6 +1395,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress NACKs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x99",
         "EventName": "UNC_H_EGRESS_HORZ_NACK.BL",
         "PerPkg": "1",
@@ -1248,6 +1404,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress NACKs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x99",
         "EventName": "UNC_H_EGRESS_HORZ_NACK.IV",
         "PerPkg": "1",
@@ -1256,6 +1413,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Occupancy AD",
+        "Counter": "0,1,2,3",
         "EventCode": "0x94",
         "EventName": "UNC_H_EGRESS_HORZ_OCCUPANCY.AD",
         "PerPkg": "1",
@@ -1264,6 +1422,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Occupancy AK",
+        "Counter": "0,1,2,3",
         "EventCode": "0x94",
         "EventName": "UNC_H_EGRESS_HORZ_OCCUPANCY.AK",
         "PerPkg": "1",
@@ -1272,6 +1431,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Occupancy BL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x94",
         "EventName": "UNC_H_EGRESS_HORZ_OCCUPANCY.BL",
         "PerPkg": "1",
@@ -1280,6 +1440,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Occupancy IV",
+        "Counter": "0,1,2,3",
         "EventCode": "0x94",
         "EventName": "UNC_H_EGRESS_HORZ_OCCUPANCY.IV",
         "PerPkg": "1",
@@ -1288,6 +1449,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Injection Starvation",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9B",
         "EventName": "UNC_H_EGRESS_HORZ_STARVED.AD",
         "PerPkg": "1",
@@ -1296,6 +1458,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Injection Starvation",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9B",
         "EventName": "UNC_H_EGRESS_HORZ_STARVED.AK",
         "PerPkg": "1",
@@ -1304,6 +1467,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Injection Starvation",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9B",
         "EventName": "UNC_H_EGRESS_HORZ_STARVED.BL",
         "PerPkg": "1",
@@ -1312,6 +1476,7 @@
     },
     {
         "BriefDescription": "CMS Horizontal Egress Injection Starvation",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9B",
         "EventName": "UNC_H_EGRESS_HORZ_STARVED.IV",
         "PerPkg": "1",
@@ -1320,6 +1485,7 @@
     },
     {
         "BriefDescription": "Counts number of cycles IV was blocked in the=
 TGR Egress due to SNP/GO Ordering requirements",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAE",
         "EventName": "UNC_H_EGRESS_ORDERING.IV_SNP_GO_DN",
         "PerPkg": "1",
@@ -1328,6 +1494,7 @@
     },
     {
         "BriefDescription": "Counts number of cycles IV was blocked in the=
 TGR Egress due to SNP/GO Ordering requirements",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAE",
         "EventName": "UNC_H_EGRESS_ORDERING.IV_SNP_GO_UP",
         "PerPkg": "1",
@@ -1336,6 +1503,7 @@
     },
     {
         "BriefDescription": "CMS Vertical ADS Used",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UNC_H_EGRESS_VERT_ADS_USED.AD_AG0",
         "PerPkg": "1",
@@ -1344,6 +1512,7 @@
     },
     {
         "BriefDescription": "CMS Vertical ADS Used",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UNC_H_EGRESS_VERT_ADS_USED.AD_AG1",
         "PerPkg": "1",
@@ -1352,6 +1521,7 @@
     },
     {
         "BriefDescription": "CMS Vertical ADS Used",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UNC_H_EGRESS_VERT_ADS_USED.AK_AG0",
         "PerPkg": "1",
@@ -1360,6 +1530,7 @@
     },
     {
         "BriefDescription": "CMS Vertical ADS Used",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UNC_H_EGRESS_VERT_ADS_USED.AK_AG1",
         "PerPkg": "1",
@@ -1368,6 +1539,7 @@
     },
     {
         "BriefDescription": "CMS Vertical ADS Used",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UNC_H_EGRESS_VERT_ADS_USED.BL_AG0",
         "PerPkg": "1",
@@ -1376,6 +1548,7 @@
     },
     {
         "BriefDescription": "CMS Vertical ADS Used",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UNC_H_EGRESS_VERT_ADS_USED.BL_AG1",
         "PerPkg": "1",
@@ -1384,6 +1557,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. AD ring agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.AD_AG0",
         "PerPkg": "1",
@@ -1392,6 +1566,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. AD ring agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.AD_AG1",
         "PerPkg": "1",
@@ -1400,6 +1575,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. AK ring agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.AK_AG0",
         "PerPkg": "1",
@@ -1408,6 +1584,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. AK ring agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.AK_AG1",
         "PerPkg": "1",
@@ -1416,6 +1593,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. BL ring agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.BL_AG0",
         "PerPkg": "1",
@@ -1424,6 +1602,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. BL ring agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.BL_AG1",
         "PerPkg": "1",
@@ -1432,6 +1611,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. IV ring agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.IV",
         "PerPkg": "1",
@@ -1440,6 +1620,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full AD -=
 Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.AD_AG0",
         "PerPkg": "1",
@@ -1448,6 +1629,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full AD -=
 Agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.AD_AG1",
         "PerPkg": "1",
@@ -1456,6 +1638,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full AK -=
 Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.AK_AG0",
         "PerPkg": "1",
@@ -1464,6 +1647,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full AK -=
 Agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.AK_AG1",
         "PerPkg": "1",
@@ -1472,6 +1656,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full BL -=
 Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.BL_AG0",
         "PerPkg": "1",
@@ -1480,6 +1665,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full BL -=
 Agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.BL_AG1",
         "PerPkg": "1",
@@ -1488,6 +1674,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full IV -=
 Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.IV_AG0",
         "PerPkg": "1",
@@ -1496,6 +1683,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 AD - Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.AD_AG0",
         "PerPkg": "1",
@@ -1504,6 +1692,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 AD - Agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.AD_AG1",
         "PerPkg": "1",
@@ -1512,6 +1701,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 AK - Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.AK_AG0",
         "PerPkg": "1",
@@ -1520,6 +1710,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 AK - Agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.AK_AG1",
         "PerPkg": "1",
@@ -1528,6 +1719,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 BL - Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.BL_AG0",
         "PerPkg": "1",
@@ -1536,6 +1728,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 BL - Agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.BL_AG1",
         "PerPkg": "1",
@@ -1544,6 +1737,7 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 IV - Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.IV_AG0",
         "PerPkg": "1",
@@ -1552,6 +1746,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations AD - Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.AD_AG0",
         "PerPkg": "1",
@@ -1560,6 +1755,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations AD - Agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.AD_AG1",
         "PerPkg": "1",
@@ -1568,6 +1764,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations AK - Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.AK_AG0",
         "PerPkg": "1",
@@ -1576,6 +1773,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations AK - Agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.AK_AG1",
         "PerPkg": "1",
@@ -1584,6 +1782,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations BL - Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.BL_AG0",
         "PerPkg": "1",
@@ -1592,6 +1791,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations BL - Agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.BL_AG1",
         "PerPkg": "1",
@@ -1600,6 +1800,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations IV - Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.IV_AG0",
         "PerPkg": "1",
@@ -1608,6 +1809,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.AD_AG0",
         "PerPkg": "1",
@@ -1616,6 +1818,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.AD_AG1",
         "PerPkg": "1",
@@ -1624,6 +1827,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs Onto AK Ring",
+        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.AK_AG0",
         "PerPkg": "1",
@@ -1632,6 +1836,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.AK_AG1",
         "PerPkg": "1",
@@ -1640,6 +1845,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs Onto BL Ring",
+        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.BL_AG0",
         "PerPkg": "1",
@@ -1648,6 +1854,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.BL_AG1",
         "PerPkg": "1",
@@ -1656,6 +1863,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.IV_AG0",
         "PerPkg": "1",
@@ -1664,6 +1872,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy AD - Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.AD_AG0",
         "PerPkg": "1",
@@ -1672,6 +1881,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy AD - Agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.AD_AG1",
         "PerPkg": "1",
@@ -1680,6 +1890,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy AK - Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.AK_AG0",
         "PerPkg": "1",
@@ -1688,6 +1899,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy AK - Agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.AK_AG1",
         "PerPkg": "1",
@@ -1696,6 +1908,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy BL - Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.BL_AG0",
         "PerPkg": "1",
@@ -1704,6 +1917,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy BL - Agent 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.BL_AG1",
         "PerPkg": "1",
@@ -1712,6 +1926,7 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy IV - Agent 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.IV_AG0",
         "PerPkg": "1",
@@ -1720,6 +1935,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.AD_AG0",
         "PerPkg": "1",
@@ -1728,6 +1944,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.AD_AG1",
         "PerPkg": "1",
@@ -1736,6 +1953,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation Onto=
 AK Ring",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.AK_AG0",
         "PerPkg": "1",
@@ -1744,6 +1962,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.AK_AG1",
         "PerPkg": "1",
@@ -1752,6 +1971,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation Onto=
 BL Ring",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.BL_AG0",
         "PerPkg": "1",
@@ -1760,6 +1980,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.BL_AG1",
         "PerPkg": "1",
@@ -1768,6 +1989,7 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.IV_AG0",
         "PerPkg": "1",
@@ -1776,6 +1998,7 @@
     },
     {
         "BriefDescription": "Counts cycles source throttling is asserted -=
 horizontal",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA5",
         "EventName": "UNC_H_FAST_ASSERTED.HORZ",
         "PerPkg": "1",
@@ -1784,6 +2007,7 @@
     },
     {
         "BriefDescription": "Counts cycles source throttling is asserted -=
 vertical",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA5",
         "EventName": "UNC_H_FAST_ASSERTED.VERT",
         "PerPkg": "1",
@@ -1791,6 +2015,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AD ring is being used at this ring stop - Left and Even",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA7",
         "EventName": "UNC_H_HORZ_RING_AD_IN_USE.LEFT_EVEN",
         "PerPkg": "1",
@@ -1799,6 +2024,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AD ring is being used at this ring stop - Left and Odd",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA7",
         "EventName": "UNC_H_HORZ_RING_AD_IN_USE.LEFT_ODD",
         "PerPkg": "1",
@@ -1807,6 +2033,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AD ring is being used at this ring stop - Right and Even",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA7",
         "EventName": "UNC_H_HORZ_RING_AD_IN_USE.RIGHT_EVEN",
         "PerPkg": "1",
@@ -1815,6 +2042,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AD ring is being used at this ring stop - Right and Odd",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA7",
         "EventName": "UNC_H_HORZ_RING_AD_IN_USE.RIGHT_ODD",
         "PerPkg": "1",
@@ -1823,6 +2051,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AK ring is being used at this ring stop - Left and Even",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA9",
         "EventName": "UNC_H_HORZ_RING_AK_IN_USE.LEFT_EVEN",
         "PerPkg": "1",
@@ -1831,6 +2060,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AK ring is being used at this ring stop - Left and Odd",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA9",
         "EventName": "UNC_H_HORZ_RING_AK_IN_USE.LEFT_ODD",
         "PerPkg": "1",
@@ -1839,6 +2069,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AK ring is being used at this ring stop - Right and Even",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA9",
         "EventName": "UNC_H_HORZ_RING_AK_IN_USE.RIGHT_EVEN",
         "PerPkg": "1",
@@ -1847,6 +2078,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AK ring is being used at this ring stop - Right and Odd",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA9",
         "EventName": "UNC_H_HORZ_RING_AK_IN_USE.RIGHT_ODD",
         "PerPkg": "1",
@@ -1855,6 +2087,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al BL ring is being used at this ring stop - Left and Even",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAB",
         "EventName": "UNC_H_HORZ_RING_BL_IN_USE.LEFT_EVEN",
         "PerPkg": "1",
@@ -1863,6 +2096,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al BL ring is being used at this ring stop - Left and Odd",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAB",
         "EventName": "UNC_H_HORZ_RING_BL_IN_USE.LEFT_ODD",
         "PerPkg": "1",
@@ -1871,6 +2105,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al BL ring is being used at this ring stop - Right and Even",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAB",
         "EventName": "UNC_H_HORZ_RING_BL_IN_USE.RIGHT_EVEN",
         "PerPkg": "1",
@@ -1879,6 +2114,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al BL ring is being used at this ring stop - Right and Odd",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAB",
         "EventName": "UNC_H_HORZ_RING_BL_IN_USE.RIGHT_ODD",
         "PerPkg": "1",
@@ -1887,6 +2123,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al IV ring is being used at this ring stop - Left",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAD",
         "EventName": "UNC_H_HORZ_RING_IV_IN_USE.LEFT",
         "PerPkg": "1",
@@ -1895,6 +2132,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al IV ring is being used at this ring stop - Right",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAD",
         "EventName": "UNC_H_HORZ_RING_IV_IN_USE.RIGHT",
         "PerPkg": "1",
@@ -1903,6 +2141,7 @@
     },
     {
         "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - IPQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_H_INGRESS_INSERTS.IPQ",
         "PerPkg": "1",
@@ -1911,6 +2150,7 @@
     },
     {
         "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - IRQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_H_INGRESS_INSERTS.IRQ",
         "PerPkg": "1",
@@ -1919,6 +2159,7 @@
     },
     {
         "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - IRQ Rejected",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_H_INGRESS_INSERTS.IRQ_REJ",
         "PerPkg": "1",
@@ -1927,6 +2168,7 @@
     },
     {
         "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - PRQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_H_INGRESS_INSERTS.PRQ",
         "PerPkg": "1",
@@ -1935,6 +2177,7 @@
     },
     {
         "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - PRQ Rejected",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_H_INGRESS_INSERTS.PRQ_REJ",
         "PerPkg": "1",
@@ -1943,6 +2186,7 @@
     },
     {
         "BriefDescription": "Cycles with the IPQ in Internal Starvation.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_INGRESS_INT_STARVED.IPQ",
         "PerPkg": "1",
@@ -1951,6 +2195,7 @@
     },
     {
         "BriefDescription": "Cycles with the IRQ in Internal Starvation.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_INGRESS_INT_STARVED.IRQ",
         "PerPkg": "1",
@@ -1959,6 +2204,7 @@
     },
     {
         "BriefDescription": "Cycles with the ISMQ in Internal Starvation."=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_INGRESS_INT_STARVED.ISMQ",
         "PerPkg": "1",
@@ -1967,6 +2213,7 @@
     },
     {
         "BriefDescription": "Ingress internal starvation cycles. Counts cy=
cles in internal starvation. This occurs when one or more of the entries in=
 the ingress queue are being starved out by other entries in the queue.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_INGRESS_INT_STARVED.PRQ",
         "PerPkg": "1",
@@ -1975,6 +2222,7 @@
     },
     {
         "BriefDescription": "Ingress Occupancy. Counts number of entries i=
n the specified Ingress queue in each cycle. - IPQ",
+        "Counter": "0",
         "EventCode": "0x11",
         "EventName": "UNC_H_INGRESS_OCCUPANCY.IPQ",
         "PerPkg": "1",
@@ -1983,6 +2231,7 @@
     },
     {
         "BriefDescription": "Ingress Occupancy. Counts number of entries i=
n the specified Ingress queue in each cycle. - IRQ",
+        "Counter": "0",
         "EventCode": "0x11",
         "EventName": "UNC_H_INGRESS_OCCUPANCY.IRQ",
         "PerPkg": "1",
@@ -1991,6 +2240,7 @@
     },
     {
         "BriefDescription": "Ingress Occupancy. Counts number of entries i=
n the specified Ingress queue in each cycle. - IRQ Rejected",
+        "Counter": "0",
         "EventCode": "0x11",
         "EventName": "UNC_H_INGRESS_OCCUPANCY.IRQ_REJ",
         "PerPkg": "1",
@@ -1999,6 +2249,7 @@
     },
     {
         "BriefDescription": "Ingress Occupancy. Counts number of entries i=
n the specified Ingress queue in each cycle. - PRQ",
+        "Counter": "0",
         "EventCode": "0x11",
         "EventName": "UNC_H_INGRESS_OCCUPANCY.PRQ",
         "PerPkg": "1",
@@ -2007,6 +2258,7 @@
     },
     {
         "BriefDescription": "Ingress Occupancy. Counts number of entries i=
n the specified Ingress queue in each cycle. - PRQ Rejected",
+        "Counter": "0",
         "EventCode": "0x11",
         "EventName": "UNC_H_INGRESS_OCCUPANCY.PRQ_REJ",
         "PerPkg": "1",
@@ -2015,6 +2267,7 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
@@ -2023,6 +2276,7 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
@@ -2031,6 +2285,7 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -2039,6 +2294,7 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2047,6 +2303,7 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2055,6 +2312,7 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
@@ -2063,6 +2321,7 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
@@ -2071,6 +2330,7 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -2079,6 +2339,7 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.ALLOW_SNP",
         "PerPkg": "1",
@@ -2087,6 +2348,7 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.ANY_REJECT_IPQ0",
         "PerPkg": "1",
@@ -2095,6 +2357,7 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.PA_MATCH",
         "PerPkg": "1",
@@ -2103,6 +2366,7 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.SF_VICTIM",
         "PerPkg": "1",
@@ -2111,6 +2375,7 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.SF_WAY",
         "PerPkg": "1",
@@ -2119,6 +2384,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
@@ -2127,6 +2393,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
@@ -2135,6 +2402,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -2143,6 +2411,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2151,6 +2420,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2159,6 +2429,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
@@ -2167,6 +2438,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
@@ -2175,6 +2447,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -2183,6 +2456,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.ALLOW_SNP",
         "PerPkg": "1",
@@ -2191,6 +2465,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.ANY_REJECT_IRQ0",
         "PerPkg": "1",
@@ -2199,6 +2474,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.PA_MATCH",
         "PerPkg": "1",
@@ -2207,6 +2483,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.SF_VICTIM",
         "PerPkg": "1",
@@ -2215,6 +2492,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.SF_WAY",
         "PerPkg": "1",
@@ -2223,6 +2501,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
@@ -2231,6 +2510,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
@@ -2239,6 +2519,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -2247,6 +2528,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2255,6 +2537,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2263,6 +2546,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
@@ -2271,6 +2555,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
@@ -2279,6 +2564,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -2287,6 +2573,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.AD_REQ_VN0",
         "PerPkg": "1",
@@ -2295,6 +2582,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.AD_RSP_VN0",
         "PerPkg": "1",
@@ -2303,6 +2591,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.AK_NON_UPI",
         "PerPkg": "1",
@@ -2311,6 +2600,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2319,6 +2609,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2327,6 +2618,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.BL_RSP_VN0",
         "PerPkg": "1",
@@ -2335,6 +2627,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.BL_WB_VN0",
         "PerPkg": "1",
@@ -2343,6 +2636,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.IV_NON_UPI",
         "PerPkg": "1",
@@ -2351,6 +2645,7 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.AD_REQ_VN0",
         "PerPkg": "1",
@@ -2359,6 +2654,7 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.AD_RSP_VN0",
         "PerPkg": "1",
@@ -2367,6 +2663,7 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.AK_NON_UPI",
         "PerPkg": "1",
@@ -2375,6 +2672,7 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2383,6 +2681,7 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2391,6 +2690,7 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.BL_RSP_VN0",
         "PerPkg": "1",
@@ -2399,6 +2699,7 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.BL_WB_VN0",
         "PerPkg": "1",
@@ -2407,6 +2708,7 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.IV_NON_UPI",
         "PerPkg": "1",
@@ -2415,6 +2717,7 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.ALLOW_SNP",
         "PerPkg": "1",
@@ -2423,6 +2726,7 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.ANY_REJECT_IRQ0",
         "PerPkg": "1",
@@ -2431,6 +2735,7 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.PA_MATCH",
         "PerPkg": "1",
@@ -2439,6 +2744,7 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.SF_VICTIM",
         "PerPkg": "1",
@@ -2447,6 +2753,7 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.SF_WAY",
         "PerPkg": "1",
@@ -2455,6 +2762,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
@@ -2463,6 +2771,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
@@ -2471,6 +2780,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -2479,6 +2789,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2487,6 +2798,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2495,6 +2807,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
@@ -2503,6 +2816,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
@@ -2511,6 +2825,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -2519,6 +2834,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.ALLOW_SNP",
         "PerPkg": "1",
@@ -2527,6 +2843,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.ANY_REJECT_IRQ0",
         "PerPkg": "1",
@@ -2535,6 +2852,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.PA_MATCH",
         "PerPkg": "1",
@@ -2543,6 +2861,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.SF_VICTIM",
         "PerPkg": "1",
@@ -2551,6 +2870,7 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.SF_WAY",
         "PerPkg": "1",
@@ -2559,6 +2879,7 @@
     },
     {
         "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.AD_REQ_VN0",
         "PerPkg": "1",
@@ -2567,6 +2888,7 @@
     },
     {
         "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.AD_RSP_VN0",
         "PerPkg": "1",
@@ -2575,6 +2897,7 @@
     },
     {
         "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.AK_NON_UPI",
         "PerPkg": "1",
@@ -2583,6 +2906,7 @@
     },
     {
         "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2591,6 +2915,7 @@
     },
     {
         "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2599,6 +2924,7 @@
     },
     {
         "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_RSP_VN0",
         "PerPkg": "1",
@@ -2607,6 +2933,7 @@
     },
     {
         "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_WB_VN0",
         "PerPkg": "1",
@@ -2615,6 +2942,7 @@
     },
     {
         "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.IV_NON_UPI",
         "PerPkg": "1",
@@ -2623,6 +2951,7 @@
     },
     {
         "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.ALLOW_SNP",
         "PerPkg": "1",
@@ -2631,6 +2960,7 @@
     },
     {
         "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.ANY_REJECT_IRQ0",
         "PerPkg": "1",
@@ -2639,6 +2969,7 @@
     },
     {
         "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.PA_MATCH",
         "PerPkg": "1",
@@ -2647,6 +2978,7 @@
     },
     {
         "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.SF_VICTIM",
         "PerPkg": "1",
@@ -2655,6 +2987,7 @@
     },
     {
         "BriefDescription": "REQUESTQ includes:  IRQ, PRQ, IPQ, RRQ, WBQ (=
everything except for ISMQ)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.SF_WAY",
         "PerPkg": "1",
@@ -2663,6 +2996,7 @@
     },
     {
         "BriefDescription": "Miscellaneous events in the Cbo. CV0 Prefetch=
 Miss",
+        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_H_MISC.CV0_PREF_MISS",
         "PerPkg": "1",
@@ -2671,6 +3005,7 @@
     },
     {
         "BriefDescription": "Miscellaneous events in the Cbo. CV0 Prefetch=
 Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_H_MISC.CV0_PREF_VIC",
         "PerPkg": "1",
@@ -2679,6 +3014,7 @@
     },
     {
         "BriefDescription": "Miscellaneous events in the Cbo. RFO HitS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_H_MISC.RFO_HIT_S",
         "PerPkg": "1",
@@ -2687,6 +3023,7 @@
     },
     {
         "BriefDescription": "Miscellaneous events in the Cbo. Silent Snoop=
 Eviction",
+        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_H_MISC.RSPI_WAS_FSE",
         "PerPkg": "1",
@@ -2695,6 +3032,7 @@
     },
     {
         "BriefDescription": "Miscellaneous events in the Cbo. Write Combin=
ing Aliasing",
+        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_H_MISC.WC_ALIASING",
         "PerPkg": "1",
@@ -2703,6 +3041,7 @@
     },
     {
         "BriefDescription": "Number of incoming messages from the Horizont=
al ring that were bounced, by ring type.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UNC_H_RING_BOUNCES_HORZ.AD",
         "PerPkg": "1",
@@ -2711,6 +3050,7 @@
     },
     {
         "BriefDescription": "Number of incoming messages from the Horizont=
al ring that were bounced, by ring type - Acknowledgements to core",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UNC_H_RING_BOUNCES_HORZ.AK",
         "PerPkg": "1",
@@ -2719,6 +3059,7 @@
     },
     {
         "BriefDescription": "Number of incoming messages from the Horizont=
al ring that were bounced, by ring type - Data Responses to core.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UNC_H_RING_BOUNCES_HORZ.BL",
         "PerPkg": "1",
@@ -2727,6 +3068,7 @@
     },
     {
         "BriefDescription": "Number of incoming messages from the Horizont=
al ring that were bounced, by ring type - Snoops of processor's cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UNC_H_RING_BOUNCES_HORZ.IV",
         "PerPkg": "1",
@@ -2735,6 +3077,7 @@
     },
     {
         "BriefDescription": "Number of incoming messages from the Vertical=
 ring that were bounced, by ring type.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA0",
         "EventName": "UNC_H_RING_BOUNCES_VERT.AD",
         "PerPkg": "1",
@@ -2743,6 +3086,7 @@
     },
     {
         "BriefDescription": "Number of incoming messages from the Vertical=
 ring that were bounced, by ring type - Acknowledgements to core",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA0",
         "EventName": "UNC_H_RING_BOUNCES_VERT.AK",
         "PerPkg": "1",
@@ -2751,6 +3095,7 @@
     },
     {
         "BriefDescription": "Number of incoming messages from the Vertical=
 ring that were bounced, by ring type - Data Responses to core.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA0",
         "EventName": "UNC_H_RING_BOUNCES_VERT.BL",
         "PerPkg": "1",
@@ -2759,6 +3104,7 @@
     },
     {
         "BriefDescription": "Number of incoming messages from the Vertical=
 ring that were bounced, by ring type - Snoops of processor's cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA0",
         "EventName": "UNC_H_RING_BOUNCES_VERT.IV",
         "PerPkg": "1",
@@ -2767,6 +3113,7 @@
     },
     {
         "BriefDescription": "Horizontal ring sink starvation count - AD ri=
ng",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA3",
         "EventName": "UNC_H_RING_SINK_STARVED_HORZ.AD",
         "PerPkg": "1",
@@ -2775,6 +3122,7 @@
     },
     {
         "BriefDescription": "Horizontal ring sink starvation count - AK ri=
ng",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA3",
         "EventName": "UNC_H_RING_SINK_STARVED_HORZ.AK",
         "PerPkg": "1",
@@ -2783,6 +3131,7 @@
     },
     {
         "BriefDescription": "Horizontal ring sink starvation count - BL ri=
ng",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA3",
         "EventName": "UNC_H_RING_SINK_STARVED_HORZ.BL",
         "PerPkg": "1",
@@ -2791,6 +3140,7 @@
     },
     {
         "BriefDescription": "Horizontal ring sink starvation count - IV ri=
ng",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA3",
         "EventName": "UNC_H_RING_SINK_STARVED_HORZ.IV",
         "PerPkg": "1",
@@ -2799,6 +3149,7 @@
     },
     {
         "BriefDescription": "Vertical ring sink starvation count - AD ring=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "UNC_H_RING_SINK_STARVED_VERT.AD",
         "PerPkg": "1",
@@ -2807,6 +3158,7 @@
     },
     {
         "BriefDescription": "Vertical ring sink starvation count - AK ring=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "UNC_H_RING_SINK_STARVED_VERT.AK",
         "PerPkg": "1",
@@ -2815,6 +3167,7 @@
     },
     {
         "BriefDescription": "Vertical ring sink starvation count - BL ring=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "UNC_H_RING_SINK_STARVED_VERT.BL",
         "PerPkg": "1",
@@ -2823,6 +3176,7 @@
     },
     {
         "BriefDescription": "Vertical ring sink starvation count - IV ring=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "UNC_H_RING_SINK_STARVED_VERT.IV",
         "PerPkg": "1",
@@ -2831,6 +3185,7 @@
     },
     {
         "BriefDescription": "Counts cycles in throttle mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA4",
         "EventName": "UNC_H_RING_SRC_THRTL",
         "PerPkg": "1",
@@ -2838,6 +3193,7 @@
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Filters for any transaction originating from the IPQ or =
IRQ.  This does not include lookups originating from the ISMQ.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_H_SF_LOOKUP.ANY",
         "PerPkg": "1",
@@ -2846,6 +3202,7 @@
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Read transactions",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_H_SF_LOOKUP.DATA_READ",
         "PerPkg": "1",
@@ -2854,6 +3211,7 @@
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Filters for only snoop requests coming from the remote s=
ocket(s) through the IPQ.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_H_SF_LOOKUP.REMOTE_SNOOP",
         "PerPkg": "1",
@@ -2862,6 +3220,7 @@
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Writeback transactions from L2 to the LLC  This includes=
 all write transactions -- both Cacheable and UC.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_H_SF_LOOKUP.WRITE",
         "PerPkg": "1",
@@ -2870,6 +3229,7 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, because a message from the other queue has higher priorit=
y",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_H_TG_INGRESS_BUSY_STARVED.AD_BNC",
         "PerPkg": "1",
@@ -2878,6 +3238,7 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, because a message from the other queue has higher priorit=
y",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_H_TG_INGRESS_BUSY_STARVED.AD_CRD",
         "PerPkg": "1",
@@ -2886,6 +3247,7 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, because a message from the other queue has higher priorit=
y",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_H_TG_INGRESS_BUSY_STARVED.BL_BNC",
         "PerPkg": "1",
@@ -2894,6 +3256,7 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, because a message from the other queue has higher priorit=
y",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_H_TG_INGRESS_BUSY_STARVED.BL_CRD",
         "PerPkg": "1",
@@ -2902,6 +3265,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_H_TG_INGRESS_BYPASS.AD_BNC",
         "PerPkg": "1",
@@ -2910,6 +3274,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_H_TG_INGRESS_BYPASS.AD_CRD",
         "PerPkg": "1",
@@ -2918,6 +3283,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_H_TG_INGRESS_BYPASS.AK_BNC",
         "PerPkg": "1",
@@ -2926,6 +3292,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_H_TG_INGRESS_BYPASS.BL_BNC",
         "PerPkg": "1",
@@ -2934,6 +3301,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_H_TG_INGRESS_BYPASS.BL_CRD",
         "PerPkg": "1",
@@ -2942,6 +3310,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_H_TG_INGRESS_BYPASS.IV_BNC",
         "PerPkg": "1",
@@ -2950,6 +3319,7 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.AD_BNC",
         "PerPkg": "1",
@@ -2958,6 +3328,7 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.AD_CRD",
         "PerPkg": "1",
@@ -2966,6 +3337,7 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.AK_BNC",
         "PerPkg": "1",
@@ -2974,6 +3346,7 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.BL_BNC",
         "PerPkg": "1",
@@ -2982,6 +3355,7 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.BL_CRD",
         "PerPkg": "1",
@@ -2990,6 +3364,7 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.IFV",
         "PerPkg": "1",
@@ -2998,6 +3373,7 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.IV_BNC",
         "PerPkg": "1",
@@ -3006,6 +3382,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_H_TG_INGRESS_INSERTS.AD_BNC",
         "PerPkg": "1",
@@ -3014,6 +3391,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_H_TG_INGRESS_INSERTS.AD_CRD",
         "PerPkg": "1",
@@ -3022,6 +3400,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_H_TG_INGRESS_INSERTS.AK_BNC",
         "PerPkg": "1",
@@ -3030,6 +3409,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_H_TG_INGRESS_INSERTS.BL_BNC",
         "PerPkg": "1",
@@ -3038,6 +3418,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_H_TG_INGRESS_INSERTS.BL_CRD",
         "PerPkg": "1",
@@ -3046,6 +3427,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_H_TG_INGRESS_INSERTS.IV_BNC",
         "PerPkg": "1",
@@ -3054,6 +3436,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.AD_BNC",
         "PerPkg": "1",
@@ -3062,6 +3445,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.AD_CRD",
         "PerPkg": "1",
@@ -3070,6 +3454,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.AK_BNC",
         "PerPkg": "1",
@@ -3078,6 +3463,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.BL_BNC",
         "PerPkg": "1",
@@ -3086,6 +3472,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.BL_CRD",
         "PerPkg": "1",
@@ -3094,6 +3481,7 @@
     },
     {
         "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.IV_BNC",
         "PerPkg": "1",
@@ -3102,6 +3490,7 @@
     },
     {
         "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -SF=
/LLC Evictions",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TOR_INSERTS.EVICT",
         "PerPkg": "1",
@@ -3110,6 +3499,7 @@
     },
     {
         "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -Hi=
t (Not a Miss)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TOR_INSERTS.HIT",
         "PerPkg": "1",
@@ -3118,6 +3508,7 @@
     },
     {
         "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IP=
Q",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TOR_INSERTS.IPQ",
         "PerPkg": "1",
@@ -3126,6 +3517,7 @@
     },
     {
         "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IR=
Q",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TOR_INSERTS.IRQ",
         "PerPkg": "1",
@@ -3134,6 +3526,7 @@
     },
     {
         "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -Mi=
ss",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TOR_INSERTS.MISS",
         "PerPkg": "1",
@@ -3142,6 +3535,7 @@
     },
     {
         "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -PR=
Q",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TOR_INSERTS.PRQ",
         "PerPkg": "1",
@@ -3150,6 +3544,7 @@
     },
     {
         "BriefDescription": "For each cycle, this event accumulates the nu=
mber of valid entries in the TOR that match qualifications specified by the=
 subevent -SF/LLC Evictions",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.EVICT",
         "PerPkg": "1",
@@ -3158,6 +3553,7 @@
     },
     {
         "BriefDescription": "For each cycle, this event accumulates the nu=
mber of valid entries in the TOR that match qualifications specified by the=
 subevent -Hit (Not a Miss)",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.HIT",
         "PerPkg": "1",
@@ -3166,6 +3562,7 @@
     },
     {
         "BriefDescription": "For each cycle, this event accumulates the nu=
mber of valid entries in the TOR that match qualifications specified by the=
 subevent -IPQ",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.IPQ",
         "PerPkg": "1",
@@ -3174,6 +3571,7 @@
     },
     {
         "BriefDescription": "For each cycle, this event accumulates the nu=
mber of valid entries in the TOR that match qualifications specified by the=
 subevent -IPQ hit",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.IPQ_HIT",
         "PerPkg": "1",
@@ -3182,6 +3580,7 @@
     },
     {
         "BriefDescription": "For each cycle, this event accumulates the nu=
mber of valid entries in the TOR that match qualifications specified by the=
 subevent -IPQ miss",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.IPQ_MISS",
         "PerPkg": "1",
@@ -3190,6 +3589,7 @@
     },
     {
         "BriefDescription": "For each cycle, this event accumulates the nu=
mber of valid entries in the TOR that match qualifications specified by the=
 subevent -IRQ or PRQ",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.IRQ",
         "PerPkg": "1",
@@ -3198,6 +3598,7 @@
     },
     {
         "BriefDescription": "For each cycle, this event accumulates the nu=
mber of valid entries in the TOR that match qualifications specified by the=
 subevent -IRQ or PRQ hit",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.IRQ_HIT",
         "PerPkg": "1",
@@ -3206,6 +3607,7 @@
     },
     {
         "BriefDescription": "For each cycle, this event accumulates the nu=
mber of valid entries in the TOR that match qualifications specified by the=
 subevent -IRQ or PRQ miss",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.IRQ_MISS",
         "PerPkg": "1",
@@ -3214,6 +3616,7 @@
     },
     {
         "BriefDescription": "For each cycle, this event accumulates the nu=
mber of valid entries in the TOR that match qualifications specified by the=
 subevent -Miss",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.MISS",
         "PerPkg": "1",
@@ -3222,6 +3625,7 @@
     },
     {
         "BriefDescription": "For each cycle, this event accumulates the nu=
mber of valid entries in the TOR that match qualifications specified by the=
 subevent -PRQ",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.PRQ",
         "PerPkg": "1",
@@ -3230,6 +3634,7 @@
     },
     {
         "BriefDescription": "For each cycle, this event accumulates the nu=
mber of valid entries in the TOR that match qualifications specified by the=
 subevent -PRQ hit",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.PRQ_HIT",
         "PerPkg": "1",
@@ -3238,6 +3643,7 @@
     },
     {
         "BriefDescription": "For each cycle, this event accumulates the nu=
mber of valid entries in the TOR that match qualifications specified by the=
 subevent -PRQ miss",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.PRQ_MISS",
         "PerPkg": "1",
@@ -3246,12 +3652,14 @@
     },
     {
         "BriefDescription": "Uncore Clocks",
+        "Counter": "0,1,2,3",
         "EventName": "UNC_H_U_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AD ring is being used at this ring stop - Down and Even",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "UNC_H_VERT_RING_AD_IN_USE.DN_EVEN",
         "PerPkg": "1",
@@ -3260,6 +3668,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AD ring is being used at this ring stop - Down and Odd",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "UNC_H_VERT_RING_AD_IN_USE.DN_ODD",
         "PerPkg": "1",
@@ -3268,6 +3677,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AD ring is being used at this ring stop - Up and Even",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "UNC_H_VERT_RING_AD_IN_USE.UP_EVEN",
         "PerPkg": "1",
@@ -3276,6 +3686,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AD ring is being used at this ring stop - Up and Odd",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "UNC_H_VERT_RING_AD_IN_USE.UP_ODD",
         "PerPkg": "1",
@@ -3284,6 +3695,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AK ring is being used at this ring stop - Down and Even",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA8",
         "EventName": "UNC_H_VERT_RING_AK_IN_USE.DN_EVEN",
         "PerPkg": "1",
@@ -3292,6 +3704,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AK ring is being used at this ring stop - Down and Odd",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA8",
         "EventName": "UNC_H_VERT_RING_AK_IN_USE.DN_ODD",
         "PerPkg": "1",
@@ -3300,6 +3713,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AK ring is being used at this ring stop - Up and Even",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA8",
         "EventName": "UNC_H_VERT_RING_AK_IN_USE.UP_EVEN",
         "PerPkg": "1",
@@ -3308,6 +3722,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AK ring is being used at this ring stop - Up and Odd",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA8",
         "EventName": "UNC_H_VERT_RING_AK_IN_USE.UP_ODD",
         "PerPkg": "1",
@@ -3316,6 +3731,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 BL ring is being used at this ring stop - Down and Even",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAA",
         "EventName": "UNC_H_VERT_RING_BL_IN_USE.DN_EVEN",
         "PerPkg": "1",
@@ -3324,6 +3740,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 BL ring is being used at this ring stop - Down and Odd",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAA",
         "EventName": "UNC_H_VERT_RING_BL_IN_USE.DN_ODD",
         "PerPkg": "1",
@@ -3332,6 +3749,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 BL ring is being used at this ring stop - Up and Even",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAA",
         "EventName": "UNC_H_VERT_RING_BL_IN_USE.UP_EVEN",
         "PerPkg": "1",
@@ -3340,6 +3758,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 BL ring is being used at this ring stop - Up and Odd",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAA",
         "EventName": "UNC_H_VERT_RING_BL_IN_USE.UP_ODD",
         "PerPkg": "1",
@@ -3348,6 +3767,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 IV ring is being used at this ring stop - Down",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAC",
         "EventName": "UNC_H_VERT_RING_IV_IN_USE.DN",
         "PerPkg": "1",
@@ -3356,6 +3776,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 IV ring is being used at this ring stop - Up",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAC",
         "EventName": "UNC_H_VERT_RING_IV_IN_USE.UP",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-io.json b=
/tools/perf/pmu-events/arch/x86/knightslanding/uncore-io.json
index 898f7e425cd4..7df7650e1a57 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-io.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_0",
         "PerPkg": "1",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_1",
         "PerPkg": "1",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_0",
         "PerPkg": "1",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_1",
         "PerPkg": "1",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_0",
         "PerPkg": "1",
@@ -41,6 +46,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_1",
         "PerPkg": "1",
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_0",
+        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_0",
         "PerPkg": "1",
@@ -57,6 +64,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_1",
+        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_1",
         "PerPkg": "1",
@@ -65,6 +73,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_0",
+        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_0",
         "PerPkg": "1",
@@ -73,6 +82,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_1",
+        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_1",
         "PerPkg": "1",
@@ -81,6 +91,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_0",
+        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_0",
         "PerPkg": "1",
@@ -89,6 +100,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_1",
+        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_1",
         "PerPkg": "1",
@@ -97,6 +109,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.AD_0",
         "PerPkg": "1",
@@ -105,6 +118,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.AD_1",
         "PerPkg": "1",
@@ -113,6 +127,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.AK_0",
         "PerPkg": "1",
@@ -121,6 +136,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.AK_1",
         "PerPkg": "1",
@@ -129,6 +145,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_0",
         "PerPkg": "1",
@@ -137,6 +154,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_1",
         "PerPkg": "1",
@@ -145,6 +163,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.BL_0",
         "PerPkg": "1",
@@ -153,6 +172,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.BL_1",
         "PerPkg": "1",
@@ -161,6 +181,7 @@
     },
     {
         "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.ALL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_INGRESS_CYCLES_NE.ALL",
         "PerPkg": "1",
@@ -169,6 +190,7 @@
     },
     {
         "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_IDI",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_IDI",
         "PerPkg": "1",
@@ -177,6 +199,7 @@
     },
     {
         "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCB",
         "PerPkg": "1",
@@ -185,6 +208,7 @@
     },
     {
         "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCS",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.js=
on b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
index fb752974179b..f137dfde8481 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is clean with re=
spect to DDR. This event is only valid in cache and hybrid memory mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_E_EDC_ACCESS.HIT_CLEAN",
         "PerPkg": "1",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is dirty with re=
spect to DDR. This event is only valid in cache and hybrid memory mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_E_EDC_ACCESS.HIT_DIRTY",
         "PerPkg": "1",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s clean with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_E_EDC_ACCESS.MISS_CLEAN",
         "PerPkg": "1",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s dirty with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_E_EDC_ACCESS.MISS_DIRTY",
         "PerPkg": "1",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Number of EDC Hits or Misses. Miss I",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_E_EDC_ACCESS.MISS_INVALID",
         "PerPkg": "1",
@@ -41,12 +46,14 @@
     },
     {
         "BriefDescription": "ECLK count",
+        "Counter": "0,1,2,3",
         "EventName": "UNC_E_E_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "EDC_ECLK"
     },
     {
         "BriefDescription": "Counts the number of read requests received b=
y the MCDRAM controller. This event is valid in all three memory modes: fla=
t, cache and hybrid. In cache and hybrid memory mode, this event counts all=
 read requests as well as streaming stores that hit or miss in the MCDRAM c=
ache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_E_RPQ_INSERTS",
         "PerPkg": "1",
@@ -55,12 +62,14 @@
     },
     {
         "BriefDescription": "UCLK count",
+        "Counter": "0,1,2,3",
         "EventName": "UNC_E_U_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "EDC_UCLK"
     },
     {
         "BriefDescription": "Counts the number of write requests received =
by the MCDRAM controller. This event is valid in all three memory modes: fl=
at, cache and hybrid. In cache and hybrid memory mode, this event counts al=
l streaming stores, writebacks and, read requests that miss in MCDRAM cache=
.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_E_WPQ_INSERTS",
         "PerPkg": "1",
@@ -69,6 +78,7 @@
     },
     {
         "BriefDescription": "CAS All",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_CAS_COUNT.ALL",
         "PerPkg": "1",
@@ -77,6 +87,7 @@
     },
     {
         "BriefDescription": "CAS Reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_CAS_COUNT.RD",
         "PerPkg": "1",
@@ -85,6 +96,7 @@
     },
     {
         "BriefDescription": "CAS Writes",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_CAS_COUNT.WR",
         "PerPkg": "1",
@@ -93,12 +105,14 @@
     },
     {
         "BriefDescription": "DCLK count",
+        "Counter": "0,1,2,3",
         "EventName": "UNC_M_D_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC_DCLK"
     },
     {
         "BriefDescription": "UCLK count",
+        "Counter": "0,1,2,3",
         "EventName": "UNC_M_U_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC_UCLK"
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.j=
son b/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
index 9be30a33b43b..cf3c5f4f4fb7 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of load micro-ops retired t=
hat cause a DTLB miss (Precise Event)",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "Counts the total number of core cycles for al=
l the page walks. The cycles for page walks started in speculative path wil=
l also be included.",
+        "Counter": "0,1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.CYCLES",
         "PublicDescription": "This event counts every cycle when a data (D=
) page walk or instruction (I) page walk is in progress.",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "Counts the total number of core cycles for al=
l the D-side page walks. The cycles for page walks started in speculative p=
ath will also be included.",
+        "Counter": "0,1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.D_SIDE_CYCLES",
         "SampleAfterValue": "200003",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Counts the total D-side page walks that are c=
ompleted or started. The page walks started in the speculative path will al=
so be counted",
+        "Counter": "0,1",
         "EdgeDetect": "1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.D_SIDE_WALKS",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Counts the total number of core cycles for al=
l the I-side page walks. The cycles for page walks started in speculative p=
ath will also be included.",
+        "Counter": "0,1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.I_SIDE_CYCLES",
         "PublicDescription": "This event counts every cycle when an I-side=
 (walks due to an instruction fetch) page walk is in progress.",
@@ -41,6 +46,7 @@
     },
     {
         "BriefDescription": "Counts the total I-side page walks that are c=
ompleted.",
+        "Counter": "0,1",
         "EdgeDetect": "1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.I_SIDE_WALKS",
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "Counts the total page walks that are complete=
d (I-side and D-side)",
+        "Counter": "0,1",
         "EdgeDetect": "1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.WALKS",
--=20
2.45.2.627.g7a2c4fd464-goog

