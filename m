Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840F38D40C
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030396; cv=none; b=bVKhT6odk8JVUbnkp24oJ9TOXLSmFPuAwvDp1cHWBuN0FvrwfLAslKkTaDS2vZCZELV+/DVOKBVdctnTcOdoTjWEL68XiWJqzsJz1DJKjYniNSGGlHpLWUBg9fFoOF1W2h+tdASx90pz5Q0jIpKw8WVb8SDRiugioeGvf7kAllI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030396; c=relaxed/simple;
	bh=O0+OYc2O+V9sePOLXQZ7dsky5uJq+avs/CDhnnYG0XY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cBB9pDH+O7X9HuKqnb9yUItAMSr1Zm6OIaBfkz/iZHtnTpOMCowHgyo/Y8WH9LN4L/rqKNupBrgpMFpOPeDH8y44u1xX4uNwodb4Y2gmSwkDaeObaIMSY0QeIMKJPDjKWwFFLQ2k0phYWXQEZFzQPnajwxbIHlwooFjuM/GU1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eu4rUQCR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eu4rUQCR"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf004bf8beso21897275ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780030388; x=1780635188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/HeyL1c7A6kUekKQ0Fbl4jckoaXZ983LXlWT4z/+Gc=;
        b=eu4rUQCRjWUv8IQQjB521vvNQ7ii0bPp843sX0s6QWqs4J0u3gtd4RWCSgp5U8FE55
         JXa412y9ZwG50YRoNUNCrcsvBFqs7cuTibVK7eUJC9eDy5NKehFx8rgIKiSjUNWBALRq
         8Ta8VE4Nf2aqcMBpzAoSB7L56slAfAnHlDZs37Kug7cXU4xjyGH4EdxZMgkIUDyLatJI
         +R1YLB4ruGXfLc1xzQKk4m2xbibpbX9bJDYPNiEi8BkZ4E+AnKJamNhniQZP6622Uubq
         ZBkkrJpJmAiPYVe2Pk0po40gYlOUxxm04Yd+BqJZi6w/n5aZsB1beRr2EJ07+P8MXm67
         l9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780030388; x=1780635188;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6/HeyL1c7A6kUekKQ0Fbl4jckoaXZ983LXlWT4z/+Gc=;
        b=ERYK6YQO8dMkuKoyWv+Iv5mLfBtFIWvN5Ag5I1szf66J1JcrnHtf418HvBlvGJy7v1
         yEAuwpsc3va1AnJzH6f95i8BKJFsMmDq5cGhTjZhQiazGk8Pj7QAZHeQISDKlTS7XEGQ
         2dA4j2DA9CtQMvyU+ZtWewQgFyfZADd3giYKRaqVmXed+VqIXcdkP3nR1sG94Ue6DSMr
         Pw5UyR0wEI1fR2h1TxzWzgIXQ2mwecGWeDpKJZDV4zWYYVlNesBLIbA7Hamh4r46PECC
         aFG7Mv+gf8b8nQvi9p/wUAX1L57Sw9vL5eNOtYs9u2S5zpwtXZXepswLFsXagurz6zXD
         oXcg==
X-Forwarded-Encrypted: i=1; AFNElJ/DR1BeivgoC3m0czBlVoHLrk9M80fWawIVcYldfB65xPOv4Ebr+aXdnBnMowRfbHfzeLUUazowIlIurWzNVoIv@vger.kernel.org
X-Gm-Message-State: AOJu0YzbpbiCdGzJ44pxu+OmkbdI5SN7/xZdzIMIMOMsYvdUr/AFFKu7
	8GaiQTgDjXICjzzEAElw50UOUCf0E2dwsE7NoplLJXigSifvyGW6mmKGtSVGf4/9rbjK2xxAU89
	vauKUT6hnXw==
X-Received: from plbms4.prod.google.com ([2002:a17:903:ac4:b0:2b2:4713:9ce4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d50a:b0:2bc:db02:d1ed
 with SMTP id d9443c01a7336-2bf20ce46f5mr18020265ad.38.1780030388116; Thu, 28
 May 2026 21:53:08 -0700 (PDT)
Date: Thu, 28 May 2026 21:51:51 -0700
In-Reply-To: <20260529045155.311805-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529045155.311805-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529045155.311805-10-irogers@google.com>
Subject: [PATCH v1 09/12] perf vendor events intel: Update meteorlake events
 from 1.20 to 1.21
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events and metrics were published in:
https://github.com/intel/perfmon/commit/419a6600ad2019d4acbf0f79cc54cde8516=
4afc1

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |  55 ++++++
 .../arch/x86/meteorlake/floating-point.json   |  63 +++++++
 .../arch/x86/meteorlake/memory.json           |  64 +++++++
 .../arch/x86/meteorlake/pipeline.json         | 158 ++++++++++++++++++
 .../arch/x86/meteorlake/virtual-memory.json   |   9 +
 6 files changed, 350 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 4176d22da1a7..1a6bb8597cbe 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -23,7 +23,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.22,lunarlake,core
-GenuineIntel-6-(AA|AC|B5),v1.20,meteorlake,core
+GenuineIntel-6-(AA|AC|B5),v1.21,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-CC,v1.04,pantherlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/cache.json
index 4c1220c19456..6419bc36f249 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -1,4 +1,13 @@
 [
+    {
+        "BriefDescription": "Counts the number of request that were not ac=
cepted into the L2Q because the L2Q is FULL.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x31",
+        "EventName": "CORE_REJECT_L2Q.ANY",
+        "PublicDescription": "Counts the number of (demand and L1 prefetch=
ers) core requests rejected by the L2Q due to a full or nearly full w condi=
tion which likely indicates back pressure from L2Q.  It also counts request=
s that would have gone directly to the XQ, but are rejected due to a full o=
r nearly full condition, indicating back pressure from the IDI link.  The L=
2Q may also reject transactions  from a core to insure fairness between cor=
es, or to delay a cores dirty eviction when the address conflicts incoming =
external snoops.  (Note that L2 prefetcher requests that are dropped are no=
t counted by this event.) Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of L1D cacheline (dirty) ev=
ictions caused by load misses, stores, and prefetches.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -181,6 +190,15 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of demand and prefetch tran=
sactions that the External Queue (XQ) rejects due to a full or near full co=
ndition.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x30",
+        "EventName": "L2_REJECT_XQ.ANY",
+        "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition which likely indicates back pressure from the IDI link.  The XQ ma=
y reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses=
) and WOB (L2 write-back victims).",
+        "SampleAfterValue": "200003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_RQSTS.REFERENCES]",
         "Counter": "0,1,2,3",
@@ -885,6 +903,33 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache in which a snoop was required and modified data was forwa=
rded.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_UOPS_MISC_RETIRED.L3_HIT_SNOOP_HITM",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache in which a snoop was required and no data was forwarded."=
,
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_UOPS_MISC_RETIRED.L3_HIT_SNOOP_NO_FWD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache in which a snoop was required and non-modified data was f=
orwarded.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_UOPS_MISC_RETIRED.L3_HIT_SNOOP_WITH_FWD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in DRAM",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -993,6 +1038,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of memory uops retired.  A =
single uop that performs both a load AND a store will be counted as 1, not =
2 (e.g. ADD [mem], CONST)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL",
+        "SampleAfterValue": "200003",
+        "UMask": "0x83",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json =
b/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
index 28dc5e06ee31..1ccbd54904c5 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
@@ -19,6 +19,24 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of active floating point di=
viders per cycle in the loop stage.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_OCCUPANCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point divider u=
ops executed per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts all microcode FP assists.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -274,6 +292,51 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of uops executed on all flo=
ating point ports.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xf",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 0.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.P0",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 1.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.P1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 2.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.P2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 0, 1, 2.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.PRIMARY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer store data port.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json b/tools/=
perf/pmu-events/arch/x86/meteorlake/memory.json
index f0cbeda4d5ca..7cdd5cb39009 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
@@ -19,6 +19,15 @@
         "UMask": "0x6",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to any number of reasons, incl=
uding an L1 miss, WCB full, pagewalk, store address block or store data blo=
ck.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.ANY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7f",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to any number of reasons, incl=
uding an L1 miss, WCB full, pagewalk, store address block or store data blo=
ck, on a load that retires.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -37,6 +46,15 @@
         "UMask": "0xf4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a DL1 miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DL1 =
miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -46,6 +64,16 @@
         "UMask": "0x81",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to other block cases.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.OTHER",
+        "PublicDescription": "Counts the number of cycles that the head (o=
ldest load) of the load buffer is stalled due to other block cases such as =
pipeline conflicts, fences, etc.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to other =
block cases.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -56,6 +84,15 @@
         "UMask": "0xc0",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a pagewalk.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.PGWALK",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a page=
walk.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -65,6 +102,15 @@
         "UMask": "0xa0",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a store address match.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.ST_ADDR",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a stor=
e address match.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -74,6 +120,24 @@
         "UMask": "0x84",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to request buffers full or loc=
k in progress.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.WCB_FULL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to reques=
t buffers full or lock in progress.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.WCB_FULL_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index 7662846745bd..09e1147c4733 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -20,6 +20,16 @@
         "UMask": "0x9",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of cycles when any of the i=
nteger dividers are active.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event counts the cycles the integer divi=
der is busy.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -30,6 +40,24 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of active integer dividers =
per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_OCCUPANCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of integer divider uops exe=
cuted per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -255,6 +283,16 @@
         "UMask": "0xdf",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of taken branch instruction=
s retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "MTL013",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.TAKEN",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -929,6 +967,89 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of uops executed on all Int=
eger ports.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xff",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on a load =
port.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.LD",
+        "PublicDescription": "Counts the number of uops executed on a load=
 port.  This event counts for integer uops even if the destination is FP/ve=
ctor",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port 0.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.P0",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port 1.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.P1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port 2.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.P2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port 3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.P3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port  0,1, 2, 3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.PRIMARY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x78",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on a Store=
 address port.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.STA",
+        "PublicDescription": "Counts the number of uops executed on a Stor=
e address port. This event counts integer uops even if the data source is F=
P/vector",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on an inte=
ger store data and jump port.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.STD_JMP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "INT_VEC_RETIRED.128BIT",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1131,6 +1252,24 @@
         "UMask": "0x8",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine without the use of microcode.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FAST",
+        "SampleAfterValue": "20003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of virtual traps taken.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FPC_VIRTUAL_TRAP",
+        "SampleAfterValue": "20003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of machines clears due to m=
emory renaming.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1303,6 +1442,25 @@
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number issue slots not consumed  d=
ue to a  color request for an FCW or MXCSR control register when all 4 colo=
rs (copies) are already in use.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.COLOR_STALLS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots not consumed=
 by the backend due to a micro-sequencer (MS) scoreboard, which stalls the =
front-end from issuing from the UROM until a specified older uop retires.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.NON_C01_MS_SCB",
+        "PublicDescription": "Counts the number of issue slots not consume=
d by the backend due to a micro-sequencer (MS) scoreboard, which stalls the=
 front-end from issuing from the UROM until a specified older uop retires. =
The most commonly executed instruction with an MS scoreboard is PAUSE.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were not consumed by the back-end pipeline due to lack of bac=
k-end resources, as a result of memory subsystem delays, execution units li=
mitations, or other conditions.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
index 305b96b26a4e..04396c7b3e08 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
@@ -356,6 +356,15 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a DTLB miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.DTLB_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DTLB=
 miss.",
         "Counter": "0,1,2,3,4,5,6,7",
--=20
2.54.0.823.g6e5bcc1fc9-goog

