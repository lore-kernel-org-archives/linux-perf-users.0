Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960D3427FB8
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061654; cv=none; b=Jl44batoXrTdR4QTcCd0jUbXdvpOGx17D8gkURBi/4nulD/lM/yuBuBoysDqwPAstGPhnrakP3s4Yc3t/h/S8uOox1qrhLKk3RZPEoS9BEKzAhp0P++Fbw2wcVe0wE6zRqoYbTZAcX+fKy4/HddrxsLhFhngUIUHm0pUIUdjqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061654; c=relaxed/simple;
	bh=NBYdl2Upj2fYKYIyOuN0s/fEUn0oWeRq62AjyDGIQ/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OpJjJIaptq5nPwrNMB3HGDTnoqkdB3lIqKZzYDO1LFtndxdjaQI3UXGi7JRIdAdT1MYk7s5Ge420Qhciz+I1qEW3acykMh9hbyx5UuAzsQfoO0p7bYh1rRIN8h9BcDkx8KQ8Gq6Z9oUUKceuJ3izJ96chHNhCrDSf+5EAIev8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BoC6cx92; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BoC6cx92"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8485d853b08so11679630b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784061651; x=1784666451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=02n7/SnQmzXRLvkxo1ormukP3+S00C7QdjaagOH/jf0=;
        b=BoC6cx92kwcnoxdCYJwb+ZfUTv89qwgdZVR7uSN5YyfQHmkiBV1TIRXd2JTB1yDvs7
         QnwLQZ9/ckPevHWyHXbUm8aKgJAL3QKZQUnGHaA4uQVbc9ZaIsLbdpoeSvyzI8FThAii
         KhoM+G2RmTpx/mdY26LIyFoskkmCVXEdEJ++rl22bB68OcB/NRDV++JXD0YP2VERlGkK
         w5ITubCwCDSSxKweqy+feRMowwBnW1t9xj7jXjQv09Nyztl+PoBC9XoIzbd2N1/8k8GS
         NcQNQ6zvfwRAdQ/utPnDcKJZvrycsO5XyGc15/2dEFBoc2mSktCYuDmkXN56vv81+GRr
         7Otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061651; x=1784666451;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=02n7/SnQmzXRLvkxo1ormukP3+S00C7QdjaagOH/jf0=;
        b=qBN7DLckAk8fyFABkk8CJS+1x8RQmU70NOX1YWmvVvqIFV+iAdgOSLSjEEMORko5A6
         gim7lMWdzurAxvexfMM+Akf90pnO9BWCTFMeBOzQH+O9hI/cbRKamQm0gZrfjyCRllE/
         VTIo6syN+WZ/w+MR1U+NomiofHfE2xQTLlEsT4LDAYdl6PDOTy3GjS7gZgW461GOY2a+
         6cJt/own5NIZrTMDBMl4ZPt6QAtV7L7mRpmtwScJdKwoo2V7W5BMZ8/HqBOi+Q++u0Xy
         YLGfFC4ONdPQgIW9TWhOH5GCzda9vi9Sl6PlTGT/mUCMtHczs38zWcQp6cXF3naTG+BX
         od2w==
X-Forwarded-Encrypted: i=1; AHgh+Ro4ot5qjXUMy5Aj4WpIAkp3fZ8nsTy/PcK2tmnyEf8gHpO2GieK7AYiXSHMCfYkIwGhr/nbapOZp/GvSfWvuxsH@vger.kernel.org
X-Gm-Message-State: AOJu0YxgHSomD9GQgl0xj2qgqQAl6GzwzzNWO06RwCgJNP0vRXmbD8QO
	mbaxOuzLbK/8lf2dmxV+vqEXaAqwgNetXIfblv2t/wLwUwYDwH+dyOcKvfVB7T4cJqhfXgFE7Do
	+K1HYiQ==
X-Received: from pfbji10.prod.google.com ([2002:a05:6a00:8f0a:b0:847:84bb:c715])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd09:b0:848:6e2d:2709
 with SMTP id d2e1a72fcca58-84a559b0c30mr3829573b3a.56.1784061650639; Tue, 14
 Jul 2026 13:40:50 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:40:36 -0700
In-Reply-To: <20260714204044.1952031-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714204044.1952031-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714204044.1952031-6-ctshao@google.com>
Subject: [PATCH v2 05/12] perf vendor events intel: Update grandridge events
 from 1.12 to 1.13
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:
https://github.com/intel/perfmon/commit/e479bd676826824110a49505b51a92952de=
91200

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../pmu-events/arch/x86/grandridge/cache.json |  25 ++++
 .../arch/x86/grandridge/counter.json          |  42 ------
 .../arch/x86/grandridge/floating-point.json   |  56 +++++++
 .../arch/x86/grandridge/memory.json           |  57 +++++++
 .../arch/x86/grandridge/pipeline.json         | 140 ++++++++++++++++++
 .../arch/x86/grandridge/uncore-memory.json    |   2 +-
 .../arch/x86/grandridge/virtual-memory.json   |   8 +
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 8 files changed, 288 insertions(+), 44 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/grandridge/counter.json

diff --git a/tools/perf/pmu-events/arch/x86/grandridge/cache.json b/tools/p=
erf/pmu-events/arch/x86/grandridge/cache.json
index 393ce9421c12..4c7727df33e4 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/cache.json
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
@@ -322,6 +338,15 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/counter.json b/tools=
/perf/pmu-events/arch/x86/grandridge/counter.json
deleted file mode 100644
index d9ac3aca5bd5..000000000000
--- a/tools/perf/pmu-events/arch/x86/grandridge/counter.json
+++ /dev/null
@@ -1,42 +0,0 @@
-[
-    {
-        "Unit": "core",
-        "CountersNumFixed": "3",
-        "CountersNumGeneric": "8"
-    },
-    {
-        "Unit": "B2CMI",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "CHA",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "IMC",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "IIO",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "IRP",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "PCU",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
-    },
-    {
-        "Unit": "CHACMS",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    }
-]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/floating-point.json =
b/tools/perf/pmu-events/arch/x86/grandridge/floating-point.json
index c567f073713c..67d52477aad6 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/floating-point.json
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
@@ -90,6 +106,46 @@
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
     {
         "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer store data port.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/memory.json b/tools/=
perf/pmu-events/arch/x86/grandridge/memory.json
index 48b6301e7696..3cbd86976e51 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/memory.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/memory.json
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
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/grandridge/pipeline.json
index 0a8f7d327150..01cf2d81757f 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
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
@@ -113,6 +138,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xdf"
     },
+    {
+        "BriefDescription": "Counts the number of taken branch instruction=
s retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.TAKEN",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -236,6 +269,80 @@
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
@@ -275,6 +382,22 @@
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
     {
         "BriefDescription": "Counts the number of machines clears due to m=
emory renaming.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -356,6 +479,23 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
index 8413391d752c..cec6e0a3147a 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
@@ -448,7 +448,7 @@
         "Unit": "IMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands. : Precharge due to (=
?) : Counts the number of DRAM Precharge commands sent on this channel.",
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to p=
age table : Counts the number of DRAM Precharge commands sent on this chann=
el.",
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.PGT",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/grandridge/virtual-memory.json
index 35cc5b6d41f2..88996fdac15f 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/virtual-memory.json
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
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 554ce716d402..d9f45cc906c7 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -12,7 +12,7 @@ GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.24,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
-GenuineIntel-6-B6,v1.12,grandridge,core
+GenuineIntel-6-B6,v1.13,grandridge,core
 GenuineIntel-6-A[DE],v1.19,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
--=20
2.55.0.141.g00534a21ce-goog

