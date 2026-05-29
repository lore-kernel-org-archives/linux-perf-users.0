Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833B38D3F9
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030374; cv=none; b=IC8M3wx2kKyf3Dp6/JL4KBdjnaRL85SeLbnJ5XA4BVXWxybTrHwS+yS4SVjoRKVOZ9H/FgrpwEOspYbs/FVYtpLXAcidJvZlnOrygVxvi8ZWeNIfJ/oOg6NRgxAPECjJ4MtYhI0SRI53aha2Qls15IA2KqJwHJktvjkuRLS00Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030374; c=relaxed/simple;
	bh=iC/gefflb8NqP3o2cSNf+DKjPemRNmzBz4Vcvz9VLKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=akTJvNMz8t/jdCzybOF8ubdc6SHrhuJCofh5jykEDjRMB3/T6Y/XUTQR/qfjs5be7LVH30Sv3JNp1x+WMd4XgumSOwAiZk31dbG2KM4Kof9fEKIS+WKEnthHWxOWbRe0APVaHOi+Av/dubFHJgrkcChbA1Q8oxGUA9dWMRvFCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dq86vIz1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dq86vIz1"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82c84be9c3so6527013a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780030368; x=1780635168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uB1RkI0VKUUUzru6TeCdxQucy6eFd/xTQOTJRcnkh4=;
        b=dq86vIz1O/9lTOy5elNfKwb4NBPSSRGPB0wndtOUDHXASGIUC58VswFvTHm23CXHJI
         7xgTmxql5MesgY4mAwp66teM03l1IMYZun+Cy4Y09K729Lw/mef6z/fVNSjeXCI0OHoH
         qBUgQ2pYfyDMDnZCWExXNvvEEuWlwP7wakbPUW2tVpGfEFLwoBJqEqPJRsWAHt5KhFe9
         RGx8Jzk7a3YdSfnot5Zc1Zt2K1SItUzGn0hoyZ3RwEUpWY66kw0mEQN1FmyVzft9OsK8
         FLSefcAie2Ld7Q7dyS8plpIE8BggTbgrdAdTg6MAXv3WEa8Gd1h6EaMYneyymEuwQrq2
         zB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780030368; x=1780635168;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+uB1RkI0VKUUUzru6TeCdxQucy6eFd/xTQOTJRcnkh4=;
        b=p7Gh1hQxqt3tT0L9XGhZ7yLggrbRErVduYDw91yiXfKiGrTfPLdkWm6GAKjFA6trB9
         AAecbvMBxcPSZmgkHcpbzvd15foY9QzDpeLUOR8jq4fPLoJzg3+6wmANLgkCaZ+EsOoL
         9sYBX36b3sMcqMt1vE3OZAmMKRK9K3qlEHikp9oJn6gRlzSNhp+xVl/ODd7Z5BALOwDh
         S9VF3Cpcj/S5N07zWDsIjd0Lh4wa2x+DMgGzPXpqMVez7aU+TUZoX+Jh/Rp1p/wzrPHg
         8hDNK33uwsagq/GRpFVSqBQ8WhA5nGCVWczELYAi6aM/Mt9REgB48cmTDFRC/WBpd1TX
         Z7ow==
X-Forwarded-Encrypted: i=1; AFNElJ9Uuh502Fujlw2ll4q9+PD067cJHyb1bDNs6EPNkyyYxsfd/wt9p02VkMpxMmlLX1q64Stk5Ao3Xd/F5KajdKPD@vger.kernel.org
X-Gm-Message-State: AOJu0YwKS3tw3xbVpFPbgr9f7lyo/P51cN3qZu0hV+8G0BZ5fx9C7e2m
	Lo41tmM1Pdn+5ds6OGF0QWgNyRh7oQ3IsV2F8pICnyVN+fPF5/uIokucwegsxkBPg5E8/ZZZ+0z
	YizKeuOiLDg==
X-Received: from pgkp9.prod.google.com ([2002:a63:f449:0:b0:c82:76de:4df1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d96:b0:3a2:f14a:4277
 with SMTP id adf61e73a8af0-3b411e1090dmr1295381637.32.1780030367984; Thu, 28
 May 2026 21:52:47 -0700 (PDT)
Date: Thu, 28 May 2026 21:51:48 -0700
In-Reply-To: <20260529045155.311805-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529045155.311805-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529045155.311805-7-irogers@google.com>
Subject: [PATCH v1 06/12] perf vendor events intel: Update grandridge events
 from 1.11 to 1.12
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
https://github.com/intel/perfmon/commit/50159a77124571c633adc2625fa7b566010=
d5001

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/grandridge/cache.json | 56 ++++++++++++++++
 .../arch/x86/grandridge/floating-point.json   |  8 +++
 .../arch/x86/grandridge/frontend.json         | 64 +++++++++++++++++++
 .../arch/x86/grandridge/pipeline.json         | 15 +++++
 .../arch/x86/grandridge/uncore-io.json        | 15 ++---
 .../arch/x86/grandridge/uncore-memory.json    | 32 +++++-----
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 7 files changed, 167 insertions(+), 25 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/grandridge/cache.json b/tools/p=
erf/pmu-events/arch/x86/grandridge/cache.json
index 0aa921ba89b4..393ce9421c12 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/cache.json
@@ -121,6 +121,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which missed in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x35",
+        "EventName": "MEM_BOUND_STALLS_IFETCH.L2_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7e"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an ICACHE or ITLB miss which hit in the LLC. If the=
 core has access to an L3 cache, an LLC hit refers to an L3 cache hit, othe=
rwise it counts zeros.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -129,6 +137,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an ICACHE or ITLB miss which hit in the LLC, no sno=
op was required. LLC provides the data. If the core has access to an L3 cac=
he, an LLC hit refers to an L3 cache hit, otherwise it counts zeros.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x35",
+        "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_HIT_NOSNOOP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an ICACHE or ITLB miss which missed all the caches.=
 If the core has access to an L3 cache, an LLC miss refers to an L3 cache m=
iss, otherwise it is an L2 cache miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -137,6 +153,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x78"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an ICACHE or ITLB miss which missed all the caches.=
 DRAM, MMIO or other LOCAL memory type provides the data. If the core has a=
ccess to an L3 cache, an LLC miss refers to an L3 cache miss, otherwise it =
is an L2 cache miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x35",
+        "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_MISS_LOCALMEM",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an L1 demand load miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -154,6 +178,14 @@
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
@@ -162,6 +194,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which hit in the LLC, a snoop wa=
s required, the snoop misses or the snoop hits but NO_FWD. LLC provides the=
 data. If the core has access to an L3 cache, an LLC hit refers to an L3 ca=
che hit, otherwise it counts zeros.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_HIT_SNOOP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the local cache=
s. If the core has access to an L3 cache, an LLC miss refers to an L3 cache=
 miss, otherwise it is an L2 cache miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -170,6 +210,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x78"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled to a demand load miss and the data was provided from an un=
known source. If the core has access to an L3 cache, an LLC miss refers to =
an L3 cache miss, otherwise it is an L2 cache miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS_LOCALMEM",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled to a store buffer full condition",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -178,6 +226,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x80"
     },
+    {
+        "BriefDescription": "Counts the total number of load ops retired t=
hat miss the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xff"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in DRAM",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/floating-point.json =
b/tools/perf/pmu-events/arch/x86/grandridge/floating-point.json
index 5266eed969be..c567f073713c 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/floating-point.json
@@ -90,6 +90,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
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
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/frontend.json b/tool=
s/perf/pmu-events/arch/x86/grandridge/frontend.json
index fef5cba533bb..8a591e31d331 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/frontend.json
@@ -8,6 +8,54 @@
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged with having preceded with frontend bound behavior",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ALL",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles/empty issue slots due=
 to a baclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_DETECT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles /empty issue slots du=
e to a btclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_RESTEER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged following an ms flow due to the bubble/wasted issue slot from=
 exiting long ms flow",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.CISC",
+        "PublicDescription": "Counts the number of  instructions retired t=
hat were tagged following an ms flow due to the bubble/wasted issue slot fr=
om exiting long ms flow",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged every cycle the decoder is unable to send 3 uops per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ica=
che miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ICACHE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -16,6 +64,22 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
+    {
+        "BriefDescription": "Counts the number of instruction retired tagg=
ed after a wasted issue slot if none of the previous events occurred",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.OTHER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles/empty issue slots due=
 to a predecode wrong.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.PREDECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/grandridge/pipeline.json
index 20986b987e18..0a8f7d327150 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
@@ -260,6 +260,13 @@
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
@@ -268,6 +275,14 @@
         "SampleAfterValue": "20003",
         "UMask": "0x8"
     },
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
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json b/too=
ls/perf/pmu-events/arch/x86/grandridge/uncore-io.json
index 764cf2f0b4a8..1a495a89ed57 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json
@@ -824,7 +824,7 @@
         "Unit": "IIO"
     },
     {
-        "BriefDescription": "-",
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.ABORT",
         "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.ABORT",
@@ -836,7 +836,7 @@
         "Unit": "IIO"
     },
     {
-        "BriefDescription": "-",
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.CONFINED_P2P",
         "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.CONFINED_P2P",
@@ -848,7 +848,7 @@
         "Unit": "IIO"
     },
     {
-        "BriefDescription": "-",
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.LOC_P2P",
         "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.LOC_P2P",
@@ -860,7 +860,7 @@
         "Unit": "IIO"
     },
     {
-        "BriefDescription": "-",
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MCAST",
         "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MCAST",
@@ -872,7 +872,7 @@
         "Unit": "IIO"
     },
     {
-        "BriefDescription": "-",
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MEM",
         "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MEM",
@@ -884,7 +884,7 @@
         "Unit": "IIO"
     },
     {
-        "BriefDescription": "-",
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MSGB",
         "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MSGB",
@@ -896,7 +896,7 @@
         "Unit": "IIO"
     },
     {
-        "BriefDescription": "-",
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX",
         "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX",
@@ -915,7 +915,6 @@
         "FCMask": "0x01",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "PublicDescription": "-",
         "UMask": "0x4",
         "Unit": "IIO"
     },
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
index 6a11e5505957..8413391d752c 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
@@ -195,7 +195,7 @@
         "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM0",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -206,7 +206,7 @@
         "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM1",
         "UMask": "0x2",
         "Unit": "IMC"
     },
@@ -217,7 +217,7 @@
         "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH1_DIMM0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_MR4_2XREF_CYCLES.SCH1_DIMM0",
         "UMask": "0x4",
         "Unit": "IMC"
     },
@@ -228,7 +228,7 @@
         "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH1_DIMM1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_MR4_2XREF_CYCLES.SCH1_DIMM1",
         "UMask": "0x8",
         "Unit": "IMC"
     },
@@ -239,7 +239,7 @@
         "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH0_DIMM0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH0_DIMM0",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -250,7 +250,7 @@
         "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH0_DIMM1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH0_DIMM1",
         "UMask": "0x2",
         "Unit": "IMC"
     },
@@ -261,7 +261,7 @@
         "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH1_DIMM0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH1_DIMM0",
         "UMask": "0x4",
         "Unit": "IMC"
     },
@@ -272,7 +272,7 @@
         "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH1_DIMM1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH1_DIMM1",
         "UMask": "0x8",
         "Unit": "IMC"
     },
@@ -617,7 +617,7 @@
         "EventName": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT0",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -628,7 +628,7 @@
         "EventName": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT1",
         "UMask": "0x2",
         "Unit": "IMC"
     },
@@ -639,7 +639,7 @@
         "EventName": "UNC_M_THROTTLE_HIGH_CYCLES.SLOT0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_THROTTLE_HIGH_CYCLES.SLOT0",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -650,7 +650,7 @@
         "EventName": "UNC_M_THROTTLE_HIGH_CYCLES.SLOT1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_THROTTLE_HIGH_CYCLES.SLOT1",
         "UMask": "0x2",
         "Unit": "IMC"
     },
@@ -661,7 +661,7 @@
         "EventName": "UNC_M_THROTTLE_LOW_CYCLES.SLOT0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_THROTTLE_LOW_CYCLES.SLOT0",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -672,7 +672,7 @@
         "EventName": "UNC_M_THROTTLE_LOW_CYCLES.SLOT1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_THROTTLE_LOW_CYCLES.SLOT1",
         "UMask": "0x2",
         "Unit": "IMC"
     },
@@ -683,7 +683,7 @@
         "EventName": "UNC_M_THROTTLE_MID_CYCLES.SLOT0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_THROTTLE_MID_CYCLES.SLOT0",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -694,7 +694,7 @@
         "EventName": "UNC_M_THROTTLE_MID_CYCLES.SLOT1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
+        "PublicDescription": "UNC_M_THROTTLE_MID_CYCLES.SLOT1",
         "UMask": "0x2",
         "Unit": "IMC"
     },
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index b6d4d37bcf99..a1548f1306a6 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -12,7 +12,7 @@ GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.23,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
-GenuineIntel-6-B6,v1.11,grandridge,core
+GenuineIntel-6-B6,v1.12,grandridge,core
 GenuineIntel-6-A[DE],v1.17,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
--=20
2.54.0.823.g6e5bcc1fc9-goog

