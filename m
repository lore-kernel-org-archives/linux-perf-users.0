Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76419BE59
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkvNHYvt"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AEC19A
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cb4de3bf0so265505276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280348; x=1698885148; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIJm2dBEQklpWcDCRL2fEL2h7jukoTmPn7q3HyInlQ0=;
        b=GkvNHYvt9x30mBzY5cJMyLC7LgfdyUOzpTM7R+zgv0FJ7UM+CEk09WRuDXL6OHd7gH
         8ujYuFweLUaSSdAxoPmNtU2MPFEFuYg/zKPysskk2NYXFQD0Xb+QgtUEJZ1C7UWukccR
         DMHNUqZ4gL1PPgt+NrdBIOi8sHUN9LlBXYjyA5Z+ZumDwnepJXYh1yXZySWyOF/LjQIl
         wn61vH0TlFnRU4DG9Iwzu9lJEMt3v1EKwg8C9DzihAWSRWP3rAMqq+WYRZK2FTPKSL7O
         fmRH1YSXA8AlGkpcnf9pgxcThlBGFkwxwsdBcdDGtp0/E2k3ciBammf0X4gArKPVjNv/
         LRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280348; x=1698885148;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QIJm2dBEQklpWcDCRL2fEL2h7jukoTmPn7q3HyInlQ0=;
        b=kRhLNrTIzG7bdtkMmr2D6taLwnE5hRCP7ZfRN+QL94RAqj68MC5PkER29QfWZKZKGx
         0sg1u0PF8u+A2p8uykVohEMSuRjWb705WmiZuIlSubu0XhFAoU0Z16KTzpH6iVNOYEyw
         Uv4xWi47Myn3X/Nr1zPanJc5MlQ2Q8c7p4bDzjYMiYxZUfSfLHUiTrxtemQOKq+WF2q3
         P5gu5QEstnhrzz6Sg4faZC/uhGquXU5WhU/npI2O8QtMIwG3EsONxcaEbQercJr+bCWp
         YkcW2fVvpzi4olzvUdxoeUQUyJJFEG1hiDX8Lpi2Hf6cHvV+3fZ8upwf+BEonCvJMKSY
         uO/Q==
X-Gm-Message-State: AOJu0YxVLgqN6xHHruT4UtxQ11OgUWlYBwJGF9h8LIan6epz1FNIrudU
	Or5fMed5K9KGv4T/Yf03wPMW49vB/zhp
X-Google-Smtp-Source: AGHT+IEpn+ip9x0UynKTe5NpWUMIg5nfExiLIkqmzrrrpz7UMq6PSZ428hpxRkKL7bI+p7CUIWrW3MLUddK2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a0d:cc04:0:b0:5a7:fc19:a060 with SMTP id
 o4-20020a0dcc04000000b005a7fc19a060mr353347ywd.8.1698280348166; Wed, 25 Oct
 2023 17:32:28 -0700 (PDT)
Date: Wed, 25 Oct 2023 17:31:46 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 6/9] perf vendor events intel: Update meteorlake events to v1.06
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Zhengjun Xing <zhengjun.xing@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update meteorlake from v1.04 to v1.06 adding the changes from:
https://github.com/intel/perfmon/commit/bc84df043091ec7c98c0629f3d074d9d7a1=
08194
https://github.com/intel/perfmon/commit/405d3ee987d756b5b5d9a64d8a8fa775598=
22ecf

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 30 ++++++++
 .../arch/x86/meteorlake/frontend.json         | 29 ++++++--
 .../arch/x86/meteorlake/memory.json           | 37 ++++++++++
 .../pmu-events/arch/x86/meteorlake/other.json | 40 +++++++++++
 .../arch/x86/meteorlake/pipeline.json         | 68 ++++++++++++++++++-
 .../arch/x86/meteorlake/uncore-other.json     |  9 +++
 7 files changed, 209 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/uncore-other.=
json

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index b25f9d90b2d7..5b455739065b 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,7 +21,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.00,lunarlake,core
-GenuineIntel-6-A[AC],v1.04,meteorlake,core
+GenuineIntel-6-A[AC],v1.06,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.01,rocketlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/cache.json
index 1de0200b32f6..5fef87502d4b 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -966,6 +966,16 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another cores caches, data forwarding is required as the data i=
s modified.",
         "EventCode": "0x2A,0x2B",
@@ -976,6 +986,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and non-modified data=
 was forwarded.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another cores caches which forwarded the unmodified data to the=
 requesting core.",
         "EventCode": "0x2A,0x2B",
@@ -986,6 +1006,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that resulte=
d in a snoop hit in another cores caches, data forwarding is required as th=
e data is modified.",
         "EventCode": "0x2A,0x2B",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/frontend.json
index 8264419500a5..9da8689eda81 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
@@ -460,6 +460,27 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled [This event is alias to IDQ_=
UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE]",
+        "CounterMask": "6",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES=
_0_UOPS_DELIV.CORE]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled [This event is alias t=
o IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK]",
+        "CounterMask": "1",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CYCLES_FE_WAS_OK",
+        "Invert": "1",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_N=
OT_DELIVERED.CYCLES_FE_WAS_OK]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled",
         "EventCode": "0x9c",
@@ -470,22 +491,22 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled",
+        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled [This event is alias to IDQ_=
BUBBLES.CYCLES_0_UOPS_DELIV.CORE]",
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
-        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle.",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DEL=
IV.CORE]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled",
+        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled [This event is alias t=
o IDQ_BUBBLES.CYCLES_FE_WAS_OK]",
         "CounterMask": "1",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
         "Invert": "1",
-        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle.",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLE=
S.CYCLES_FE_WAS_OK]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json b/tools/=
perf/pmu-events/arch/x86/meteorlake/memory.json
index 2605e1d0ba9f..a5b83293f157 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
@@ -66,6 +66,14 @@
         "UMask": "0x84",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
+        "SampleAfterValue": "20003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of machine clears due to memory orderi=
ng conflicts.",
         "EventCode": "0xc3",
@@ -75,6 +83,15 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
+        "CounterMask": "2",
+        "EventCode": "0x47",
+        "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
         "CounterMask": "3",
@@ -279,6 +296,26 @@
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were no=
t supplied by the L3 cache.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts demand data read requests that miss th=
e L3 cache.",
         "EventCode": "0x21",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/other.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/other.json
index f4c603599df4..d55e792c0c43 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/other.json
@@ -7,6 +7,46 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that have any type of=
 response.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10800",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "EventCode": "0x2A,0x2B",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index 352c5efafc06..deaa7aba93f7 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -217,6 +217,15 @@
         "UMask": "0x50",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted taken JCC (=
Jump on Conditional Code) branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken.",
         "EventCode": "0xc5",
@@ -292,6 +301,15 @@
         "UMask": "0xc0",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near taken =
branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken.",
         "EventCode": "0xc5",
@@ -733,7 +751,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
+        "BriefDescription": "Bubble cycles of BAClear (Unknown Branch).",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "MSRIndex": "0x3F7",
@@ -1045,6 +1063,14 @@
         "UMask": "0x3",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to Branch Mispredict",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to a machine clear (nuke).",
         "EventCode": "0x73",
@@ -1068,6 +1094,22 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stall (sche=
duler not being able to accept another uop).  This could be caused by RSV f=
ull or load/store buffer block.",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IEC and FPC RAT stalls - which=
 can be due to the FIQ and IEC reservation station stall (integer, FP and S=
IMD scheduler not being able to accept another uop. )",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to mrbl stall.  A 'marble' refers=
 to a physical register file entry, also known as the physical destination =
(PDST).",
         "EventCode": "0x74",
@@ -1076,6 +1118,14 @@
         "UMask": "0x20",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to ROB full",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to iq/jeu scoreboards or ms scb",
         "EventCode": "0x74",
@@ -1156,6 +1206,14 @@
         "UMask": "0x10",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend that do not categorize into any oth=
er common frontend stall",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.OTHER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to predecode wrong",
         "EventCode": "0x71",
@@ -1398,6 +1456,14 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the total number of uops retired.",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.ALL",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles with retired uop(s).",
         "CounterMask": "1",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/uncore-other.json b/=
tools/perf/pmu-events/arch/x86/meteorlake/uncore-other.json
new file mode 100644
index 000000000000..2af92e43b28a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/uncore-other.json
@@ -0,0 +1,9 @@
+[
+    {
+        "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les.",
+        "EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "Unit": "CLOCK"
+    }
+]
--=20
2.42.0.758.gaed0368e0e-goog

