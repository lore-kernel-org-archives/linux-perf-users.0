Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269CD38D41F
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030410; cv=none; b=bKevSD5BvW/ACq2r57ZmaVZxmNpcFMlqQkbo3agzAu8VpY87/j1AMnwll2u3ClXF2x13etHfFmJIqTUJMkhJFlgycRf6wTEQkhDUXgL1u+FLO4Sp3hFrLWXxMVPyH0uiM94uiBzqDiyAkg8Mj/q5jjcnUwxWwkvtWdy4VgjxUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030410; c=relaxed/simple;
	bh=55ZjObuhvwFtYr936Vy9TgKtjgexb9y7i/qaYPd1GvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BaZuCpK8HvTrpVkZGY+Q4HyXXLz0Lm4aWKmBB9u1CDzWL1dKZjRkVoZEq9B+JaRf3ZWZhfeDrLzDJtaLgXMOA42D3iDD7aPzhiWvOPBgmaqhIVhNgiRTAJA5NUhldAFcV3x7XxvwrXXje/94ukTeTFhN0yB9//HAO0+/LbvOtvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VrhkEO6I; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrhkEO6I"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so19163743b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780030407; x=1780635207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhiWDPGxtTbD4cB4Te4aaYhEUYYWFs3jRly2haLuLug=;
        b=VrhkEO6IPWd8aZM0TSPxQxgG+SCSlQNyfcqc8qLEuuk34pztbvPwREpfLJLGByRzk3
         iA2dB4M7gMM22+43HA6/wd1nWuObTsWi7pQQ1IFhhN8P3Lmzn/vTKVYiZqea8BQ58S4e
         c/YY51G9XVfrMT0nydXQfWa56O1AtPiU61J27rnhWLeCe+6NLot4UXPVM5EDB9Uh50R+
         jy9U8VHsyU/3xu0ykh7tb3p7PkeWgqH4aY5nM86PnK4M05m40kQ8HtUgXJZGIqT/nYe7
         ReHE9gohd/XOjVkHiuGXkuPnETejUQniDYsT9LRrzewSwUGpHZD+3AK9HwbrjmpScmWc
         rQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780030407; x=1780635207;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yhiWDPGxtTbD4cB4Te4aaYhEUYYWFs3jRly2haLuLug=;
        b=AOip9dxpMTtsfRr8zDcL6GU1ZVs3kuwuCB5CsTOBGaPfVry0Q4LNMe3jDMt7trIQK9
         SfR4/XwWZlMVpdgr3I7iq4sAbsU5Uz+YFMfknWf5sLuUrwvBFfY3JipgO193knUIaQDA
         qm2LXf+xltfSTev6R+e6Fquq2iew/xfWdPX9Y/nAW7yD5c6Y1/6XZp1uc7QndU5qtYhy
         rzKYEXkpN9t0s+GPZ3S1wGRpNv7FOML3iLnncssmViSz5RrLju9xh/bNp4pJorZ6y6eM
         /WquwXJhiQonWEpc+PKv1MBDqseO+cA+y4GhWT0GDRHgUG+cO3+QjoiaEkq3ibyYkBtL
         s7kg==
X-Forwarded-Encrypted: i=1; AFNElJ+vRoa5l1pbBkw4ZUIdC8x0IdFRmjXIQeP2rT2vXcbXlIgqFmE84jb5MGN7UrU/dlRtJ+dZXHcyqhK1BVfWCcle@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzGJl6GpavKicqqGmDDbDK8NHSBI3Plpzn6qD7DypUqk9ajUe
	+bj4h0kXGnq48WGfPC85DqE+l5YS9KONyysydt127vXW3Xna6dCuZpfnwgxEqypdmDtkw1sp3kY
	1ci4qHM7vsg==
X-Received: from pfbfb19.prod.google.com ([2002:a05:6a00:2d93:b0:838:5125:b5e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:301e:b0:82c:e83d:a9b0
 with SMTP id d2e1a72fcca58-84212bffaafmr1345397b3a.21.1780030407122; Thu, 28
 May 2026 21:53:27 -0700 (PDT)
Date: Thu, 28 May 2026 21:51:54 -0700
In-Reply-To: <20260529045155.311805-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529045155.311805-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529045155.311805-13-irogers@google.com>
Subject: [PATCH v1 12/12] perf vendor events intel: Update sierraforest events
 from 1.15 to 1.17
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
https://github.com/intel/perfmon/commit/efa15280e0577982744642a77af18208aab=
3635b
https://github.com/intel/perfmon/commit/5cdba6c2ccfde2ec13e0e701bc2a374849c=
e9a44

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/sierraforest/cache.json          |  49 ++++++
 .../arch/x86/sierraforest/floating-point.json |  64 +++++++
 .../arch/x86/sierraforest/memory.json         |  57 +++++++
 .../arch/x86/sierraforest/pipeline.json       | 156 ++++++++++++++++++
 .../arch/x86/sierraforest/virtual-memory.json |   8 +
 6 files changed, 335 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index dbe1fe5a68f6..50a403b429b1 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -30,7 +30,7 @@ GenuineIntel-6-(CC|D5),v1.05,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.39,sapphirerapids,core
-GenuineIntel-6-AF,v1.15,sierraforest,core
+GenuineIntel-6-AF,v1.17,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.37,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json b/tools=
/perf/pmu-events/arch/x86/sierraforest/cache.json
index 168f43557a0e..71acb49b2ab9 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
@@ -1,4 +1,12 @@
 [
+    {
+        "BriefDescription": "Counts the number of requests that were not a=
ccepted into the L2Q because the L2Q is FULL.",
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
+        "SampleAfterValue": "200003"
+    },
     {
         "BriefDescription": "Counts the number of L1D cacheline (dirty) ev=
ictions caused by load misses, stores, and prefetches.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -62,6 +70,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
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
+        "SampleAfterValue": "200003"
+    },
     {
         "BriefDescription": "Counts the number of L2 Cache Accesses that r=
esulted in a Hit from a front door request only (does not include rejects o=
r recycles), per core event",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -154,6 +170,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which missed in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.L2_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7e"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which hit in the LLC. If the cor=
e has access to an L3 cache, an LLC hit refers to an L3 cache hit, otherwis=
e it counts zeros.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -178,6 +202,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x78"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the caches, a s=
noop was required, and hits in other core or module on the same die. Anothe=
r core provides the data with a FWD, NO_FWD, or HITM. If the core has acces=
s to an L3 cache, an LLC miss refers to an L3 cache miss, otherwise it is a=
n L2 cache miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS_OTHERMOD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled to a store buffer full condition",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -227,6 +259,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache in which a snoop was required and modified data was forwa=
rded.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_UOPS_MISC_RETIRED.L3_HIT_SNOOP_HITM",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired that hi=
t the L1 data cache.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -307,6 +347,15 @@
         "SampleAfterValue": "20003",
         "UMask": "0x1"
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
+        "UMask": "0x83"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/floating-point.jso=
n b/tools/perf/pmu-events/arch/x86/sierraforest/floating-point.json
index 5266eed969be..67d52477aad6 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/floating-point.json
@@ -8,6 +8,22 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Counts the number of active floating point di=
viders per cycle in the loop stage.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_OCCUPANCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point divider u=
ops executed per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Counts the number of all types of floating po=
int operations per uop with all default weighting",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -90,6 +106,54 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Counts the number of uops executed on all flo=
ating point ports.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xf"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 0.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.P0",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 1.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.P1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 2.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.P2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 0, 1, 2.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.PRIMARY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer store data port.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.STD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/memory.json b/tool=
s/perf/pmu-events/arch/x86/sierraforest/memory.json
index dc850a179517..01e07f90e76b 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/memory.json
@@ -1,4 +1,12 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to any number of reasons, incl=
uding an L1 miss, WCB full, pagewalk, store address block or store data blo=
ck.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.ANY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7f"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to any number of reasons, incl=
uding an L1 miss, WCB full, pagewalk, store address block or store data blo=
ck, on a load that retires.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -15,6 +23,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0xf4"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a DL1 miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DL1 =
miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -23,6 +39,15 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x81"
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
+        "UMask": "0x40"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to other =
block cases.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -32,6 +57,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0xc0"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a pagewalk.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.PGWALK",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a page=
walk.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -40,6 +73,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0xa0"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a store address match.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.ST_ADDR",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a stor=
e address match.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -48,6 +89,22 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x84"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to request buffers full or loc=
k in progress.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.WCB_FULL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to reques=
t buffers full or lock in progress.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.WCB_FULL_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82"
+    },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/sierraforest/pipeline.json
index cf67ff6135e0..e7ffb0042477 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
@@ -8,6 +8,31 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
+    {
+        "BriefDescription": "Counts the number of cycles when any of the i=
nteger dividers are active.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of active integer dividers =
per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_OCCUPANCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of integer divider uops exe=
cuted per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -121,6 +146,15 @@
         "SampleAfterValue": "200003",
         "UMask": "0xdf"
     },
+    {
+        "BriefDescription": "Counts the number of taken branch instruction=
s retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "SRF7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.TAKEN",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -244,6 +278,80 @@
         "EventName": "INST_RETIRED.ANY_P",
         "SampleAfterValue": "2000003"
     },
+    {
+        "BriefDescription": "Counts the number of uops executed on all Int=
eger ports.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xff"
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
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port 0.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.P0",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port 1.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.P1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port 2.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.P2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port 3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.P3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port  0,1, 2, 3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.PRIMARY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x78"
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
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on an inte=
ger store data and jump port.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.STD_JMP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked because it initially appears to be store forward blocked, but subseq=
uently is shown not to be blocked based on 4K alias check.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -268,6 +376,13 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Counts the total number of machine clears for=
 any reason including, but not limited to, memory ordering, memory disambig=
uation, SMC, and FP assist.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.ANY",
+        "SampleAfterValue": "20003"
+    },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory ordering in which an internal load passes an older store within the sa=
me CPU.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -276,6 +391,30 @@
         "SampleAfterValue": "20003",
         "UMask": "0x8"
     },
+    {
+        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine without the use of microcode.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FAST",
+        "SampleAfterValue": "20003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of virtual traps taken.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FPC_VIRTUAL_TRAP",
+        "SampleAfterValue": "20003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of machines clears due to m=
emory renaming.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MRN_NUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
     {
         "BriefDescription": "Counts the number of machine clears due to a =
page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A p=
age fault occurs when either the page is not present, or an access violatio=
n occurs.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -349,6 +488,23 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots not consumed=
 due to a color request for an FCW or MXCSR control register when all 4 col=
ors (copies) are already in use.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.COLOR_STALLS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8"
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
+        "UMask": "0x2"
+    },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
.ALL_P]",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/virtual-memory.jso=
n b/tools/perf/pmu-events/arch/x86/sierraforest/virtual-memory.json
index 35cc5b6d41f2..88996fdac15f 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/virtual-memory.json
@@ -137,6 +137,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a DTLB miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.DTLB_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DTLB=
 miss.",
         "Counter": "0,1,2,3,4,5,6,7",
--=20
2.54.0.823.g6e5bcc1fc9-goog

