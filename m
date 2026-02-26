Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91A238A70D
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128804; cv=none; b=tO29OtzeeaGAocEOMzXPBP2DNCimnuY1S5lbOB0rPZbV8UMaD1mpK4oJqZZ3h+eLNs6FW06Rg3R13OqSUOi1VpBz0/hp6HDZIFo9+d4ZFJ40+ykecuH2HxiLuMWxIa2pxVOMva8RjsLoMPnkFOzHiJL9EuVEquDUwipBfankBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128804; c=relaxed/simple;
	bh=lOsoOFRZMW24Cb+H50A5yAie0d8ezxNyThtruTIS1WA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=t0dIh6mfLARCmrw1z4h/Zf+bo5YhijU6qxhgTz7m9OkRm7MA0iA68rufHHnmK1vIDVjx+DVc2s1DVoHk7CoG3NaNqJn2BZHEHEBAFLYqXMrP5lnLJ4CDjnSMo4/CvXzi3xy7AjkpbpYx6deeVFz/0YjJLUmZC/TxelndSU2R/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4g9GBFNA; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4g9GBFNA"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdc42265a2so1055583eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 10:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772128802; x=1772733602; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JebxhsuRXpmS99sqoEAcdewBCf+xeG1RAop12duRn7Q=;
        b=4g9GBFNAUTEtK9hxX3lmJiLXqCec0kuTdkZWZYLsTdJNYkYqnx1Xdqx/JdLdqAIgRw
         Ck8HutWqhAdX3i5rRk74E5RUHR81e+U53/FNqRlOg+VpmiGM9u5olybAAIY6jCV3/IGG
         Tjm2cO4nJkTMeJVhTeJ56JO2gpdtjCoyoR3F4ELAe4SpqX3ICEcNqT+JuAf+OBOC7pvI
         cLEVsmrl/uAmo0qjsF/o1y2u7o9GAHkGDdLsV3aucK2Mzfd6wKodH1aak+29bf9x4f5c
         cUFOxyTqpb+qrqYDfcHn8eGn2KWAJMpQx0Mq5uvg4pB7ItYVbH79iGzo4bmi64kwblNg
         MXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772128802; x=1772733602;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JebxhsuRXpmS99sqoEAcdewBCf+xeG1RAop12duRn7Q=;
        b=hVOzqqPDaEM7fueCGPjIGKcCLTHXrMZeuWHBK2iNpI3OPgs5SHJpbTaaP3qI8Vgsdk
         Kt7mFOBYAsUc+zoOPZHXaA7SQaO3D8yaCWnkp9EqFslaW7hoX67+YtG9qGTmeXIlZuxr
         eSuxgw3p8xZtI5Prxr4cnTgdTPes0lkQvzxiraS8RgHZ7bcUJWb0A8fSC0lg9E17bFuH
         eE+sIFiqIaYcGgVBooS06Peb4VxbWzg4fxXBS1Gg03yINKExT2F3Wsl59c752fg8ahdy
         d5GpB2178QjBjPFgTjjfldxrFUyaRI7NgH60admy2YsgJpQAhAencwJhFDxn6ernpeof
         KEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXskvdmkZjAv95QZL39O1ZoRd/d1iggCfnOjEwZngziOCNfOh+BFEurIUSw+M5wHj3sxatGqHGM8yxQA4jLZUCa@vger.kernel.org
X-Gm-Message-State: AOJu0YweoO7pUAPOLHGeBq4gpdR1LSNBKISexPcePJwK5w1ZpYaT/CwZ
	6rtw0tZ37N22hUgMG0YfM2H687jQIouNeukyVWiyC4Vg0QJOntepoMSCtJhXctgHTq2oh1G2xVu
	jWZqHExvS1Q==
X-Received: from dlw4.prod.google.com ([2002:a05:7022:44:b0:124:9d31:3581])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:45a8:b0:11b:82b8:40ae
 with SMTP id a92af1059eb24-1276acc4a5cmr9814942c88.18.1772128801157; Thu, 26
 Feb 2026 10:00:01 -0800 (PST)
Date: Thu, 26 Feb 2026 09:59:36 -0800
In-Reply-To: <20260226175936.593159-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226175936.593159-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260226175936.593159-10-irogers@google.com>
Subject: [PATCH v2 10/10] perf vendor events intel: Update sierraforest events
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

