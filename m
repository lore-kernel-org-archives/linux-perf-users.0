Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A6E1E0B66
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184246; cv=none; b=JBpsnPbHo+zxTPIyUb1RAKFuBFpeakkgVf4ZVEDqam0STDx85vq1shrSc8/VjvZjjBZmPXPTBgCRt1ZND8EQXQkqwHhY+qRc0mCu9UH09dXMsEgowgYK3yVjmgai0VpB+xH4zcRCGXVwSQoBBIQphkHE0VmnTQDkMYpUUx+6VwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184246; c=relaxed/simple;
	bh=+xJ+qKPbgUXdDO+AUiNHm01I/HedJpQNqwkqFEOIwww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jwD3/VOI4Nsp6fhSkYicyymiTKYqTDX6lyOQSr42MMCOVhoj+FlErtKQx9ELr8XPSuIR6FIV5vrwXBXYzUM1TdpG/SaBUR+NiTrpBT63Zt4h8BEKFHLYyJfqPSsQ974x5IIrwAP9ur+ziUcDN86tosasFt1quSigphGOei+rjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pp+B9CW2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pp+B9CW2"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225429696a9so65378745ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743184242; x=1743789042; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrejIaQiYbMAiCXOQcwPJT0mKEc7KANFMGJ2WDrEAWY=;
        b=pp+B9CW2aCn0q2vPsNxlK0TFpM4VFKfGWvCCSilG/AaPjPWWjoNWx+IE/eAdHprERt
         B+kvV9KbQqbAE/wPUb0PPPD1XXP6xwHLoDgr3o79QgeCbl+osmEf6//XJRw5asu1FzJe
         NGARkMSJjrjIKP3SssC27hbxBNf3DCwomODocjIFpNj2ymGodljxqFkoLXy2fkOJr+Oj
         RKKGZnQnY8wPsezyt8AhQNH+I9EqScC1ehgfefiNEJHUcZQHXxHHkHC4wLFe0jQnRRXc
         9gAjpRySYMBAe//PHC2xAue4Exm9rXZpRnHmqo0hy1MtDnAlsC+WbqXBTSrGWY+n8f5V
         kqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743184242; x=1743789042;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OrejIaQiYbMAiCXOQcwPJT0mKEc7KANFMGJ2WDrEAWY=;
        b=dXgq45HzL8TiQYODmN+a0BcDdhfsWR5wGFdIot1x6UMMZNumxtWrEDe//8tUqq/vfY
         tt9E8ZsQGbPdO2fL1ZoFAc6XbMlQnL3XrWdrrd9aCjx6dstoOAqROCSwAMaDlcFOUwBE
         6lHPbr++eFB3znunnUZX0E7+0LyZr1uYMFp7BBubK+1uLAjLnv2SnRLkLE3NtKtDmSiu
         cXO9c5wH1hvGpDuvOj6gbSDMcboDmlgrYwCTrllwlv5Nt5WcUJaRCMD0WUf7Yf9g0fey
         /rUULkUQ80UV0vyh6htAKfYwKGkf9rTsZl5L1e4UHy2TBxi3lSv1kTeDUMpqdx3Yb3AE
         dYbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9m8uTo2rGxqnONY6zZ95ttjclD+iud2pThFImmhDi1HW336Ic8TW0VrwY6J/XKvoukRvxupOuZzGHIpyhzJa+@vger.kernel.org
X-Gm-Message-State: AOJu0YyMW9FxXkI5upf9PcxkpX2XM/qcViXaFQ7ZzijegCh9Lb8m99Ue
	Z6kuu5GIxLEIbIg0ab5um0JhvIXf43Lci7kE2a6lWX2VeGv+IAgcKyWpl0ah4pqhh3TvZZ9y593
	Tq3BQ5g==
X-Google-Smtp-Source: AGHT+IFQup1jcFqrjKxnEWn2651+5qNyoY5M9VDSZ0+TcGTxXmT9fRvuOr3d7DCeuswrtwU64XyYtIBkNVPW
X-Received: from pllb6.prod.google.com ([2002:a17:902:e946:b0:226:3efa:da86])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a24:b0:226:252e:b6ef
 with SMTP id d9443c01a7336-2292f941644mr1231895ad.7.1743184242522; Fri, 28
 Mar 2025 10:50:42 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:49:40 -0700
In-Reply-To: <20250328175006.43110-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328175006.43110-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328175006.43110-10-irogers@google.com>
Subject: [PATCH v5 09/35] perf vendor events: Update clearwaterforest events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update event topic of OCR.DEMAND_DATA_RD.ANY_RESPONSE and
OCR.DEMAND_RFO.ANY_RESPONSE to be cache. Add PDIST counter into
descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/clearwaterforest/cache.json      | 35 +++++++++++++++++++
 .../arch/x86/clearwaterforest/memory.json     |  2 ++
 .../arch/x86/clearwaterforest/other.json      | 22 ------------
 .../arch/x86/clearwaterforest/pipeline.json   |  6 ++--
 4 files changed, 41 insertions(+), 24 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.j=
son

diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json b/t=
ools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
index 875361b30f1d..ecb7dc252208 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
@@ -22,6 +22,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
+        "PublicDescription": "Counts the number of load ops retired. Avail=
able PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x81"
     },
@@ -30,6 +31,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
+        "PublicDescription": "Counts the number of store ops retired. Avai=
lable PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x82"
     },
@@ -40,6 +42,7 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x400",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -50,6 +53,7 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -60,6 +64,7 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -70,6 +75,7 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x800",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -80,6 +86,7 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -90,6 +97,7 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -100,6 +108,7 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -110,6 +119,7 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -120,6 +130,7 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -130,6 +141,7 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -138,7 +150,30 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
+        "PublicDescription": "Counts the number of  stores uops retired sa=
me as MEM_UOPS_RETIRED.ALL_STORES Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "PublicDescription": "Counts demand data reads that have any type =
of response. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "PublicDescription": "Counts demand read for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json b/=
tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
index f5007e56f39b..58e543550279 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
@@ -6,6 +6,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x33FBFC00001",
+        "PublicDescription": "Counts demand data reads that were not suppl=
ied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16,6 +17,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x33FBFC00002",
+        "PublicDescription": "Counts demand read for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were n=
ot supplied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json b/t=
ools/perf/pmu-events/arch/x86/clearwaterforest/other.json
deleted file mode 100644
index 80454e497f83..000000000000
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
+++ /dev/null
@@ -1,22 +0,0 @@
-[
-    {
-        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json =
b/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
index 6a5faa704b85..26bd12fefa3d 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
+        "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003"
     },
     {
@@ -12,7 +12,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path.",
+        "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path. Available PDIST count=
ers: 0,1",
         "SampleAfterValue": "1000003"
     },
     {
@@ -63,6 +63,7 @@
         "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired.",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
+        "PublicDescription": "Fixed Counter: Counts the number of instruct=
ions retired. Available PDIST counters: 32",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -71,6 +72,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
+        "PublicDescription": "Counts the number of instructions retired. A=
vailable PDIST counters: 0,1",
         "SampleAfterValue": "1000003"
     },
     {
--=20
2.49.0.472.ge94155a9ec-goog

