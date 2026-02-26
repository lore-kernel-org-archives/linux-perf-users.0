Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6738A71C
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 04:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772081610; cv=none; b=MB+eWcGEPtCrjyHzdNPg1TGVMYth8at0lMZ2mL0NWG6BmmW+0jsGquR30krifckG1vyA1BGkwqfv+w0hUEJ2148zFJkfiV+IM3wpnE8rIV5ILZ1bPhA6CmzI3MdobIClrApkHntK9Mo8ozwePkJfx/RK4sXLs9436DUg4RcPdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772081610; c=relaxed/simple;
	bh=lOsoOFRZMW24Cb+H50A5yAie0d8ezxNyThtruTIS1WA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UW2JzGxB6X+WouExRMeh85vIej3WY7b7Fs+PFltZA27XFgJ8DxymZSPz7fTRWyiedj+Q37xD2svRubelo7XvpOS64aeAQix/pT2LsybfCXc97oFPMtaB9uYj8azUGeCdh6HBxiSphm52rxkn6UIY/T8szDFYdNahE/AmmiHzW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EbqDd/J8; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EbqDd/J8"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdb58f18f0so5291272eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 20:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772081607; x=1772686407; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JebxhsuRXpmS99sqoEAcdewBCf+xeG1RAop12duRn7Q=;
        b=EbqDd/J8dqGYd8uorALVm+VRjx//zK7l/AKjYt6kJu0Gp6Rl0nAHdREzfP2BdwpQju
         8YG4p5mhrPg2zOZ6oDU7m2o3FwIT0ympLAafNfnXqxoCjINuCHJz5301FdkViaFb0pQl
         +FSYri+jFdINSLxyZG/sklRorF3gua785cK4vWB6uYdIgATeFRscXXdE6a1T4gyB8Ckq
         PSQACh92TxEkptWrOZbxVdZm19azICdf9cJMzqa74MP5+cL5KY9ScQ/GjXZBEwfID0QK
         UFqVH7ftWicujRTAT9MgIj+iOd5fwRrOBjwMWnCy2jbliHRZjWYY3EwqEz+XSTPZ9Ntk
         0ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772081607; x=1772686407;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JebxhsuRXpmS99sqoEAcdewBCf+xeG1RAop12duRn7Q=;
        b=qOV3wT0+jzoQSizQEwMnCdEh7BRfQ8rMhShJh461hezpoKsWuQDuW5tv8Dfxlm0fa+
         qup1k01Z59PLD8jVTpXw42Z12jNJhlCbMp0ADQpd8GIxuumt3a9QV2rYU0OQ+mWs815N
         coNJpmwK15VVwBK4RdQWqV6jZIjohzc1N2R9OhxHOGWQZrFDWyxkrvfEo49Z3bSVj1zc
         DCFcid5sksXVPj154/v4w7/mXdePUR/CPhnlKoCqSvdDG101g5KdZJkqGSpI4apVJwTR
         0ZLVDgE3daXRNQu+2Y/5NihbQriZhmHElYjk1EkMdN+Kw7ZOKL0EzfxGu32aiRceNP/U
         o0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVid8AKwBen0j7GMANrTxMjEUGKIpxO41uiIl/q8wlgNbMHaG+26DotMQHlpL7ovFng95KkSvWFOwtvsSES5w6q@vger.kernel.org
X-Gm-Message-State: AOJu0YwSg3mA5v3fyff1Y359vBNbf1Uv6OZgVqYNBVw00vrSYlIg86oh
	xnCKcMBQVhsvzUOH4tiYFu7hB3zA9i8E3VtKj3FRUeT929wHcyfzWAbYGSsTQ//gR2Qq9meY1iK
	ZcEOxwyunrg==
X-Received: from dyw4.prod.google.com ([2002:a05:7300:8804:b0:2ba:9d01:ecf2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cd97:b0:2b7:f522:995c
 with SMTP id 5a478bee46e88-2bdd3063fabmr400582eec.38.1772081606919; Wed, 25
 Feb 2026 20:53:26 -0800 (PST)
Date: Wed, 25 Feb 2026 20:53:01 -0800
In-Reply-To: <20260226045301.459948-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226045301.459948-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226045301.459948-10-irogers@google.com>
Subject: [PATCH v1 10/10] perf vendor events intel: Update sierraforest events
 from 1.13 to 1.15
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The updated events were published in:
https://github.com/intel/perfmon/commit/996bacad8f144e675b32f0096b9fe6813380695c
https://github.com/intel/perfmon/commit/93b6ef08ca9b01788458e8f5a0e7cbb716715b7c

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../arch/x86/sierraforest/cache.json          | 22 +++++-----
 .../arch/x86/sierraforest/pipeline.json       | 42 ++++++++++++++++---
 3 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 8ef03af9f150..8a9e1735e21e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -30,7 +30,7 @@ GenuineIntel-6-CC,v1.04,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.36,sapphirerapids,core
-GenuineIntel-6-AF,v1.13,sierraforest,core
+GenuineIntel-6-AF,v1.15,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.37,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json b/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
index de0e7661a52d..168f43557a0e 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
@@ -326,7 +326,7 @@
         "UMask": "0x82"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 1024. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -337,7 +337,7 @@
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 128. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -348,7 +348,7 @@
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 16. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -359,7 +359,7 @@
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 2048. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -370,7 +370,7 @@
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 256. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -381,7 +381,7 @@
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 32. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -392,7 +392,7 @@
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 4. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -403,7 +403,7 @@
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 512. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -414,7 +414,7 @@
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 64. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -425,7 +425,7 @@
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 8. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -499,7 +499,7 @@
         "UMask": "0x12"
     },
     {
-        "BriefDescription": "Counts the number of  stores uops retired same as MEM_UOPS_RETIRED.ALL_STORES",
+        "BriefDescription": "Counts the number of stores uops retired.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json b/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
index 70af13143024..cf67ff6135e0 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
@@ -186,7 +186,7 @@
         "UMask": "0xf7"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.THREAD]",
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "SampleAfterValue": "2000003",
@@ -200,7 +200,7 @@
         "SampleAfterValue": "2000003"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted reference clock cycles",
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted reference clock cycles.",
         "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
@@ -216,7 +216,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.CORE]",
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
@@ -230,10 +230,10 @@
         "SampleAfterValue": "2000003"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of instructions retired",
+        "BriefDescription": "Fixed Counter: Counts the number of instructions retired.",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PublicDescription": "Fixed Counter: Counts the number of instructions retired Available PDIST counters: 32",
+        "PublicDescription": "Fixed Counter: Counts the number of instructions retired. Available PDIST counters: 32",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -309,6 +309,38 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of CLFLUSH, CLWB, and CLDEMOTE instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe0",
+        "EventName": "MISC_RETIRED1.CL_INST",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "Counts the number of LFENCE instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe0",
+        "EventName": "MISC_RETIRED1.LFENCE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of accesses to KeyLocker cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe1",
+        "EventName": "MISC_RETIRED2.KEYLOCKER_ACCESS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of misses to KeyLocker cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe1",
+        "EventName": "MISC_RETIRED2.KEYLOCKER_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x11"
+    },
     {
         "BriefDescription": "Counts the number of issue slots in a UMWAIT or TPAUSE instruction where no uop issues due to the instruction putting the CPU into the C0.1 activity state.",
         "Counter": "0,1,2,3,4,5,6,7",
-- 
2.53.0.414.gf7e9f6c205-goog

