Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF538C429
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030345; cv=none; b=IRqR28dX3yj5+QoL6OIbj4GA5v/6fe6RGwGvJzMCHjhdjsGyzv0lMUxxcN32hzcP5BNb1l06va1Xs8y/ueVQtdAOAVQ6SRi5SUNorVK+hTMlajvcwTODDUiyFhp9PKiwKiNH7rVF79HZJdIm63WRbi4dborkUymzgu3gbj72O+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030345; c=relaxed/simple;
	bh=y/DmNrE5bGKZd9qsv2N+f78bcUV5QxOYZRsE3WkBPUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oIt9QEtFvbSSB0E9XAFVwauryM+qMpUa8MMBvcjN6ILGzcwFYMmmGMjgIc7Cm5UH4HYMc/LwMLooKUgsTjgccWwR3KL8KLMBzNUz/s2qJzD6Q6iT2FQEX/JiNwaaNJGCg+c43+3QmpVvfICOpedUKeboA/GChoJ4PXvuqhVXkPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BC2kPT7d; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BC2kPT7d"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf281d523eso56145ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780030340; x=1780635140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=55f7eel4OxDFHn34x1DJVoafuR6jID1WSJeqa1tuUUc=;
        b=BC2kPT7d9OfAQy9GTiawV6FmBEqFEZE7nxKN79QR4x/jfwA2qfZXjmq/B6Zj1YDGw3
         Q5b4rXtKi1dh1Yi/3c7iTQkXT25gLa+069IlzQWuODuRAR8jPUpblILu50GcAEyqNGid
         Ck5AA0m6M5P9GM7q6X2QkLv5W7WufZNnxVxIjqoOA58pU6IdLScshL1vOnbyT9k6EmwX
         itbXnUu2tE6BNM5V9KpQjtD19Xwi2Jy66ml8sefjAbS5R1d/NR6UuzZiQQp8p2VhCxJs
         cApVLE46nvJleSICqaWxBdGOm5V3IoNkwO7QGKn0GkROIZfk1PNH0iziz11hGOPGPlaT
         bLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780030340; x=1780635140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55f7eel4OxDFHn34x1DJVoafuR6jID1WSJeqa1tuUUc=;
        b=jPjcuU0UF8PdWmDD+zsrXnDC4F03BeEgAJAZd4Az7fGBnu4o5WdhNIj4HKY39Zcfva
         irmNkSAu9DK4n9/LObJnpdzXgQV5yFoitgOaOESDoe7FiGrvGxAE1Hs2WP5+sBCE0Ts0
         WNVrm9SZmSCzjE4r5DbbZF0cCIWvOmfmjvpSgYzIL9Ui1/RuqQihaBVg+ACHs5/MKRJv
         MQPxtsLd1fmfn4wSdpp8Rd3l7cEZIWbrVUZK3ln7GkwCTDLG4eGWvU2xco78Twd1a+wY
         RQsImuUgkAg46vWWSm832Ip7WLDm1k4q17vLuVhiMXZzlc5OHqPkB6D1GNQZdaotNcA5
         Vy2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+NGBuBZfpHveSJlJIoODK8wTWKQrrpKKqzfdC9W3VeTIqKtfvgNJ51bHJwuDWHchA8pplJ3h7gk358uhM1V3+K@vger.kernel.org
X-Gm-Message-State: AOJu0YyHg9apazlapiaiMKIGBz4BYFyknuijxPPCMwm+oOe8FdoXTbrj
	B5xX2b4P3xh3AaNYUP/HlyUjbC/aAYobCKRRBf1R8tGjH8PMtoxNLmTIj29THYFhG3HcilP7pz3
	R+4xtXRQEdw==
X-Received: from pljf4.prod.google.com ([2002:a17:902:ff04:b0:2bd:4a28:b705])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74f:b0:2ba:3e2f:6874
 with SMTP id d9443c01a7336-2bf209873bbmr17024155ad.26.1780030340111; Thu, 28
 May 2026 21:52:20 -0700 (PDT)
Date: Thu, 28 May 2026 21:51:44 -0700
In-Reply-To: <20260529045155.311805-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529045155.311805-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529045155.311805-3-irogers@google.com>
Subject: [PATCH v1 02/12] perf vendor events intel: Update alderlaken events
 from 1.37 to 1.39
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

The updated events were published in:
https://github.com/intel/perfmon/commit/e55693d19f4dfe6b09c0ee9eb2b4e93781e16dd9
https://github.com/intel/perfmon/commit/25a1cd4847c1ed9159b5c79d1f7afe24ec965269

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/alderlaken/cache.json | 50 ++++++++++++++++
 .../arch/x86/alderlaken/memory.json           | 57 +++++++++++++++++++
 .../arch/x86/alderlaken/pipeline.json         | 48 ++++++++++++++++
 .../arch/x86/alderlaken/virtual-memory.json   |  8 +++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 5 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
index 1f97a4dc6fb1..0ffad953e752 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
@@ -225,6 +225,16 @@
         "SampleAfterValue": "20003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of memory uops retired.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL",
+        "PublicDescription": "Counts the number of memory uops retired.  A single uop that performs both a load AND a store will be counted as 1, not 2 (e.g. ADD [mem], CONST)",
+        "SampleAfterValue": "200003",
+        "UMask": "0x83"
+    },
     {
         "BriefDescription": "Counts the number of load uops retired.",
         "Counter": "0,1,2,3,4,5",
@@ -245,6 +255,17 @@
         "SampleAfterValue": "200003",
         "UMask": "0x82"
     },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 1024. Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x400",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 128. Only counts with PEBS enabled.",
         "Counter": "0,1",
@@ -267,6 +288,17 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 2048. Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x800",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 256. Only counts with PEBS enabled.",
         "Counter": "0,1",
@@ -342,6 +374,15 @@
         "SampleAfterValue": "200003",
         "UMask": "0x21"
     },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that were splits.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT",
+        "SampleAfterValue": "200003",
+        "UMask": "0x43"
+    },
     {
         "BriefDescription": "Counts the number of retired split load uops.",
         "Counter": "0,1,2,3,4,5",
@@ -351,6 +392,15 @@
         "SampleAfterValue": "200003",
         "UMask": "0x41"
     },
+    {
+        "BriefDescription": "Counts the number of retired split store uops.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
+        "SampleAfterValue": "200003",
+        "UMask": "0x42"
+    },
     {
         "BriefDescription": "Counts the total number of load and store uops retired that missed in the second level TLB.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json b/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
index 049c5e2630d7..a0dd82ddd58a 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
@@ -1,4 +1,12 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to any number of reasons, including an L1 miss, WCB full, pagewalk, store address block or store data block.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.ANY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7f"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to any number of reasons, including an L1 miss, WCB full, pagewalk, store address block or store data block, on a load that retires.",
         "Counter": "0,1,2,3,4,5",
@@ -15,6 +23,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0xf4"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to a DL1 miss.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a DL1 miss.",
         "Counter": "0,1,2,3,4,5",
@@ -23,6 +39,15 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x81"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to other block cases.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.OTHER",
+        "PublicDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to other block cases such as pipeline conflicts, fences, etc.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to other block cases.",
         "Counter": "0,1,2,3,4,5",
@@ -32,6 +57,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0xc0"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to a pagewalk.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.PGWALK",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a pagewalk.",
         "Counter": "0,1,2,3,4,5",
@@ -40,6 +73,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0xa0"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to a store data forward block.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.ST_ADDR",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a store address match.",
         "Counter": "0,1,2,3,4,5",
@@ -48,6 +89,22 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x84"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to request buffers full or lock in progress.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.WCB_FULL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to request buffers full or lock in progress.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.WCB_FULL_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82"
+    },
     {
         "BriefDescription": "Counts the number of machine clears due to memory ordering caused by a snoop from an external agent. Does not count internally generated machine clears such as those due to memory disambiguation.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
index a13851071624..ad3acb109bd8 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
@@ -175,6 +175,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xfd"
     },
+    {
+        "BriefDescription": "Counts the number of near relative JMP branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.REL_JMP",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.NEAR_RETURN",
         "Counter": "0,1,2,3,4,5",
@@ -184,6 +192,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
+    {
+        "BriefDescription": "Counts the number of taken branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.TAKEN",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.COND_TAKEN",
         "Counter": "0,1,2,3,4,5",
@@ -293,6 +309,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
+    {
+        "BriefDescription": "Counts the total number of BTCLEARS.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xe8",
+        "EventName": "BTCLEAR.ANY",
+        "PublicDescription": "Counts the total number of BTCLEARS which occurs when the Branch Target Buffer (BTB) predicts a taken branch.",
+        "SampleAfterValue": "200003"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.THREAD]",
         "Counter": "Fixed counter 1",
@@ -400,6 +424,22 @@
         "SampleAfterValue": "20003",
         "UMask": "0x8"
     },
+    {
+        "BriefDescription": "Counts the number of machine clears that flush the pipeline and restart the machine without the use of microcode.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FAST",
+        "SampleAfterValue": "20003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of virtual traps taken.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FPC_VIRTUAL_TRAP",
+        "SampleAfterValue": "20003",
+        "UMask": "0x40"
+    },
     {
         "BriefDescription": "Counts the number of machines clears due to memory renaming.",
         "Counter": "0,1,2,3,4,5",
@@ -482,6 +522,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Counts the number issue slots not consumed  due to a  color request for an FCW or MXCSR control register when all 4 colors (copies) are already in use.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.COLOR_STALLS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Counts the number of issue slots not consumed by the backend due to a micro-sequencer (MS) scoreboard, which stalls the front-end from issuing from the UROM until a specified older uop retires.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json b/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
index d9c737a17df0..56c1bfc38024 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
@@ -42,6 +42,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xe"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to a DTLB miss.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.DTLB_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a DTLB miss.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 2f542283202a..c076dbed1611 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.39,alderlake,core
-GenuineIntel-6-BE,v1.37,alderlaken,core
+GenuineIntel-6-BE,v1.39,alderlaken,core
 GenuineIntel-6-C[56],v1.16,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
-- 
2.54.0.823.g6e5bcc1fc9-goog

