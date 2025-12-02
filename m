Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939AE2BF3C5
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694477; cv=none; b=PzWnPqo8Qg9CGK9c93rOJRUTQ4JsDRw8x6+n+5zhwYy4d9Irtl/nXNtWkJ2FuXjvTSGFm1OGawd33/ZdLatdqH/Abzn2rIF+IQ645Jo4c+Usl3txoWOrkxV5XvPbjhRQMg6+e8aW1gY7xkZClRvkvRStcizIEd1A1d9SQ1HlCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694477; c=relaxed/simple;
	bh=3klVsg1qWputI1MVGb88cjOZyH8uA/KKrb5HQ1TzHxs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jyWkkgE0LaseZJ4X4ihhWftHZTiqajbVtOafVnPCkoZe4KiBFs1Os5eWBS2roDPMZeEH22F2+YGe5GMJwP5mqWK9AYjJksUf9enQwkU655Mny++JArNMGP6OGXZOz7xFubFpnaXxP6NzGLOpZUTqLrAGBlYFU7YMwwMxyCuOJn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dYCe1Mye; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYCe1Mye"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bde2d88e5e3so8389343a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764694475; x=1765299275; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAFdeWV+BoTuHkc9bEXjPnVDqepWlnWnNyvZmM2fZsA=;
        b=dYCe1MyeA2gKz39kVJ0OJIx++wpUghK87km4gDTU+I2IO3j3d/hbHRdzzRaxu4+zcU
         rbkBt6sTbfABL+1OWrUO1IssbkHa2VA5O5UGxicfjUlohFKpI6+PPhgX/W5EBCcrBF0s
         0vKtRLqEP7zoiRiG8MLVV/AswOKkXmLaaP+dYc8CtL/ilENs/jnidFmrREEKsMU1mvby
         3SNRB9GCXJy/CoaquGdLORFN8GT7taatNuLwcTfzWRbrhCduZvJ+qYsUwgdCAyxahglI
         dVTY0HLyVFVf52ByBq00Ki9pHgpxPxbyn01pdq3CVTuoyRkZHMd79bSG1wvG82ZW/o2c
         gpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764694475; x=1765299275;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SAFdeWV+BoTuHkc9bEXjPnVDqepWlnWnNyvZmM2fZsA=;
        b=jC1I6Ut7cBsPX77PQf/hBhxS1UgaBKwpGXq/X2CRo8mIO0JI55QYjABMz+UPQdWbB6
         N7ci1ygEk/rSgaSL3MPJAJnSd1/Fjj+fHDi5TuSHnppq/sRgIoBigaVRWyfczhS81ajy
         P5qZYClFK2lyYs/Vyf8CeEztcsoXUG5hcPs0H362gL118vZqJY/T/boD25ndkU64pHJY
         jSs3ya/45y7W62LwZPs9vNvj2FJqRHLMap2btP3AsBGxf0LOlJO8Ffp95+O3AG+ssMrG
         oTsQvFCYkT8NHmkcW4x6b5zYFSDmleXlR0TE3Ogw16KGSEWRy/wNqVpViqsQIzx9JpLr
         VcLA==
X-Forwarded-Encrypted: i=1; AJvYcCVrpw4MLaTKRZ3uiaa+T8jnKi2nA8dD3q4B0dkMJr1lh1wBZQQLc2EOwDfxoV/3CRru1PkwOFlRKOdpmROcvDf3@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWAnjQ5nGw7NoYDTWN9il2KnduP6XcgjQg3PSIOf2jMkyrTYl
	v1XnZC3FcmOy8gQ9WDo572blXJ0jcWU+Q+3Gv31LGjIGFk3KzaJgwxmJEhe6Z08qPUXSfkFhLlZ
	kg+DjQx3/wA==
X-Google-Smtp-Source: AGHT+IFAtFrjOL4iBDSVWrCTZ+aD2XFS4vo0zZbNYMT13XUuvR+ZLoOpYXTQv5Dot9e9v+WDlctpJI7C4IaE
X-Received: from dybde1.prod.google.com ([2002:a05:7300:ae01:b0:2a4:4f7b:275d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:a08:b0:2a4:3593:646a
 with SMTP id 5a478bee46e88-2a7192c03bfmr21587526eec.26.1764694474815; Tue, 02
 Dec 2025 08:54:34 -0800 (PST)
Date: Tue,  2 Dec 2025 08:53:39 -0800
In-Reply-To: <20251202165340.555375-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202165340.555375-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202165340.555375-9-irogers@google.com>
Subject: [PATCH v1 8/9] perf vendor events intel: Update pantherlake events
 from 1.00 to 1.02
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:
https://github.com/intel/perfmon/commit/6edacf434dffa046435de2f6a182c00df3c=
f4edc

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/pantherlake/cache.json           |  38 +++
 .../arch/x86/pantherlake/floating-point.json  |  73 +++++
 .../arch/x86/pantherlake/memory.json          |   9 +
 .../arch/x86/pantherlake/pipeline.json        | 305 +++++++++++++++++-
 5 files changed, 425 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 558e4f8a1419..77a5ec666a51 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -26,7 +26,7 @@ GenuineIntel-6-BD,v1.19,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.18,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
-GenuineIntel-6-CC,v1.00,pantherlake,core
+GenuineIntel-6-CC,v1.02,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.35,sapphirerapids,core
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/cache.json b/tools/=
perf/pmu-events/arch/x86/pantherlake/cache.json
index 7098ea1d6d16..91f5ab908926 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/cache.json
@@ -383,6 +383,15 @@
         "UMask": "0x10",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the caches, a s=
noop was required, and hits in other core or module on same die.  Another c=
ore provides the data with a fwd, no fwd, or hitM.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS_OTHERMOD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts all retired load instructions.",
         "Counter": "0,1,2,3",
@@ -727,6 +736,16 @@
         "UMask": "0x40",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache in which a snoop was required and modified data was forwa=
rded.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_UOPS_MISC_RETIRED.L3_HIT_SNOOP_HITM",
+        "PublicDescription": "Counts the number of load ops retired that h=
it in the L3 cache in which a snoop was required and modified data was forw=
arded. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired that hi=
t the L1 data cache.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -830,6 +849,16 @@
         "SampleAfterValue": "100021",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of memory uops retired.  A =
single uop that performs both a load AND a store will be counted as 1, not =
2 (e.g. ADD [mem], CONST).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL",
+        "PublicDescription": "Counts the number of memory uops retired.  A=
 single uop that performs both a load AND a store will be counted as 1, not=
 2 (e.g. ADD [mem], CONST). Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x83",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1371,5 +1400,14 @@
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to an icache miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ICACHE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/floating-point.json=
 b/tools/perf/pmu-events/arch/x86/pantherlake/floating-point.json
index 57c26866bc79..e306a45b22ee 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/floating-point.json
@@ -273,6 +273,69 @@
         "UMask": "0x3f",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of uops executed on all flo=
ating point ports.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1f",
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
g point and vector integer port 3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.P3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 0, 1, 2, 3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.PRIMARY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1e",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer store data port.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.STD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -282,5 +345,15 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point divide uo=
ps retired (x87 and sse, including x87 sqrt).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.FPDIV",
+        "PublicDescription": "Counts the number of floating point divide u=
ops retired (x87 and sse, including x87 sqrt). Available PDIST counters: 0,=
1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/memory.json b/tools=
/perf/pmu-events/arch/x86/pantherlake/memory.json
index 397a15dbb964..3d31e620383d 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/memory.json
@@ -8,6 +8,15 @@
         "UMask": "0xf4",
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
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/pantherlake/pipeline.json
index 2d805ac98c5b..fb87d30c403d 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
@@ -329,6 +329,17 @@
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.NEAR_INDIRECT]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_NEAR_IND",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.NEAR_INDIRECT] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -570,6 +581,16 @@
         "UMask": "0x8040",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired. [This event is a=
lias to BR_MISP_RETIRED.ALL_NEAR_IND]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT",
+        "PublicDescription": "Counts the number of mispredicted near indir=
ect JMP and near indirect CALL branch instructions retired. [This event is =
alias to BR_MISP_RETIRED.ALL_NEAR_IND] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Miss-predicted near indirect branch instructi=
ons retired (excluding returns) [This event is alias to BR_MISP_RETIRED.IND=
IRECT]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -1126,6 +1147,70 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of uops executed on seconda=
ry integer ports 0,1,2,3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.2ND",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
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
     {
         "BriefDescription": "Counts the number of uops executed on integer=
 port  0,1, 2, 3.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1135,6 +1220,25 @@
         "UMask": "0x78",
         "Unit": "cpu_atom"
     },
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
         "BriefDescription": "Number of vector integer instructions retired=
 of 128-bit vector-width.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -1236,7 +1340,7 @@
         "EventName": "LD_BLOCKS.ALL",
         "PublicDescription": "Counts the number of retired loads that are =
blocked for any of the following reasons:  DTLB miss, address alias, store =
forward or data unknown (includes memory disambiguation blocks and ESP cons=
uming load blocks). Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
-        "UMask": "0x10",
+        "UMask": "0x1f",
         "Unit": "cpu_atom"
     },
     {
@@ -1360,6 +1464,15 @@
         "UMask": "0x20",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of machine clears due to pr=
ogram modifying data (self modifying code) within 1K of a recently fetched =
code page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.SMC",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Self-modifying code (SMC) detected.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -1507,6 +1620,25 @@
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots where no uop=
 could issue due to an IQ scoreboard that stalls allocation until a specifi=
ed older uop retires or (in the case of jump scoreboard) executes. Commonly=
 executed instructions with IQ scoreboards include LFENCE and MFENCE.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.IQ_JEU_SCB",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
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
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were not consumed by the back-end pipeline due to lack of bac=
k-end resources, as a result of memory subsystem delays, execution units li=
mitations, or other conditions.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -1582,6 +1714,42 @@
         "SampleAfterValue": "1000003",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to Fast Nukes such as  Memory Ord=
ering Machine clears and MRN nukes",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to a branch mispredict that resul=
ted in LSD exit.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.LSD_MISPREDICT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to Branch Mispredict",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to a machine clear (nuke).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.NUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls. [This event is alias to TOPDOWN_BE_BOUND.ALL_P=
]",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1591,6 +1759,15 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to due to certain allocation rest=
rictions.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls. [This event is alias to TOPDOWN_BE_BOUND.ALL]"=
,
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1600,6 +1777,33 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to LSD entry.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.LSD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stall (sche=
duler not being able to accept another uop).  This could be caused by RSV f=
ull or load/store buffer block.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to iq/jeu scoreboards or ms scb",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of retiremen=
t slots not consumed due to front end stalls.",
         "Counter": "Fixed counter 5",
@@ -1617,6 +1821,78 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BAClear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BTClear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to ms",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.CISC",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to decode stall",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.DECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to latency related stalls inclu=
ding BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x72",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to itlb miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ITLB_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend that do not categorize into any oth=
er common frontend stall",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.OTHER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to predecode wrong",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of consumed =
retirement slots.",
         "Counter": "Fixed counter 6",
@@ -1841,6 +2117,25 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of integer divide uops reti=
red.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.IDIV",
+        "PublicDescription": "Counts the number of integer divide uops ret=
ired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops that are from the c=
omplex flows issued by the micro-sequencer (MS).  This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.MS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "UOPS_RETIRED.MS",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -1887,5 +2182,13 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of x87 uops retired, includ=
es those in ms flows.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.X87",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
     }
 ]
--=20
2.52.0.158.g65b55ccf14-goog

