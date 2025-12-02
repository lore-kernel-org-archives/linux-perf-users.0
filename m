Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FFB2C11F3
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694465; cv=none; b=fGIdR74ROgsNqnJS14CSx5RpYrlwyIMUuZo7YhVoplHhw/m1UfoxK3jXyzLg2ANcfAYONbzCO4VnAZhra6dodoD1Zyq9yI5uG8bv4lsXD1w83eAiZNu0HjbHczUdzqFGEEkcKXXVIny5mSa9CThxWQG7Pjk/idRRB+UCGeaT2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694465; c=relaxed/simple;
	bh=Le7vaWqggWRu+RKcBZavqLB/iDhLzen9T4Y5MRnWTgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RYePr8qL6A83h0WeVHjUhm5UFaMDa/FS3hOHYQrVMZQBTQecsVieBfDvZbLo2pL4ZjY2PK7lEXyGBUyGvxtePzO/tzHVsP9Jl5+KXEZyzfzdCo7GwdKn73iyzRphLXxXNoJE3NrUdz0p/NTQVDfLLNEqmcS77txPDgcoe0r04eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3EZ/QxP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3EZ/QxP"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so5179750a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764694463; x=1765299263; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTp7vBknXjJ72FhL75a6ZxjJAqrib/pYa9OiIA4ahQQ=;
        b=h3EZ/QxPmReAhfVrrD/baeBnortt+ExZi+byLgf8Q5Op76slQ2wF2HFQCNh0g/XNVs
         jRh+a0JyuesktrQzPJUEpEtsli0JQPQ0LFNxsaGFxwMUXHywDa48SH/R+Tc/qTTTJ1Jh
         5t1ud9Un9lar8VFVQjEFpMiNVfIGZLAl926Rl7BDP0n3fgwqnk088QQQLvwVeliI1NOj
         isR+smu/MMOZTEqGV/tcsxheVYQnI4WYdzrz+J4Sv/JYxcjCMItK+0BDmu1HOjSW5kiS
         1iyTWDOAxeTxuA5dts1cXhLIn1w7bOQ5lb1etZ0IIvZZisHBc0cTIfCstu/llT3A4+bv
         8l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764694463; x=1765299263;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cTp7vBknXjJ72FhL75a6ZxjJAqrib/pYa9OiIA4ahQQ=;
        b=dHkWizq/gTVpGfYLtAA3iGus+nqfq5Ai7XCUdBTdm6jxvEvrP18HEJ40keOIqZje8s
         nv0xZoaxW5HOQ1u/+/9atY4RxPSniL8q6xszB7QzvtJ7zQewts6Gg/BkkSnKnkWtB5F7
         WGhp8CL5qYbttN6KZX674tuPTr7wQ3bRbukEBgXKbqZzNxkBCjRvhTrT3vXporUQKGRz
         m5VwsyOKuEIAi50m4pi+eVHEyqKbIoQWCWfnUbntwYhj2ltLbgKoo3aCzmeygH7cD/Al
         OxlQg3ffvlgCPqkRGh21mVl/N+HpmB3RwL/3uKmmqAaWH/rP28OTvh3plttMcQ+daKxs
         /NLg==
X-Forwarded-Encrypted: i=1; AJvYcCXsdmaIQO8ulSftnKNWgnv5NxdBw8vKEsPltmGspcpJcO0eAzzqR2uZMg1qKrKElZX+fVObXHMUuw2veHL/XmRk@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzgc/nqXjgQ1nDG8hoKGyOXronpkxUVJmDS8ZfM9+MieC7WUpb
	8cEWi7bGq4gwZlOHr60juAiFO2S03XpLuMisR7GvEv/qmseu3N7kyEmoa+NLT2dLieWabsXYZ0x
	YXNexeXzs2w==
X-Google-Smtp-Source: AGHT+IH32dpLeVnXNvbBMeIKIw2KvoB8n0TY6njaR5v5vZcWHDY745pKmQeMOXk1pZFAF9E8rHP6cZmd6y48
X-Received: from dybfx7.prod.google.com ([2002:a05:7300:c387:b0:2a4:75c7:9884])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6426:b0:2a4:3593:ddd3
 with SMTP id 5a478bee46e88-2ab8f90592dmr99234eec.0.1764694463399; Tue, 02 Dec
 2025 08:54:23 -0800 (PST)
Date: Tue,  2 Dec 2025 08:53:37 -0800
In-Reply-To: <20251202165340.555375-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202165340.555375-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202165340.555375-7-irogers@google.com>
Subject: [PATCH v1 6/9] perf vendor events intel: Update lunarlake events from
 1.18 to 1.19
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
https://github.com/intel/perfmon/commit/09a0c74b23b5d20adf1f97e5022856568d0=
5494c

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/lunarlake/cache.json  | 20 +++++++-------
 .../pmu-events/arch/x86/lunarlake/other.json  |  1 +
 .../arch/x86/lunarlake/pipeline.json          | 26 ++++++++++++++++---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/lunarlake/cache.json
index 402ca8fc50b6..3d2616be8ec1 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
@@ -243,7 +243,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of L2 prefetches initiated =
by either the L2 Stream or AMP that were throttled due to exceeding the XQ =
threshold set by either XQ_THRESOLD_DTP or XQ_THRESHOLD. Counts on a per co=
re basis.",
+        "BriefDescription": "Counts the number of L2 prefetches initiated =
by either the L2 Stream or AMP that were throttled due to exceeding the XQ =
threshold set by either XQ_THRESHOLD_DTP or XQ_THRESHOLD. Counts on a per c=
ore basis.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x28",
         "EventName": "L2_PREFETCHES_THROTTLED.XQ_THRESH",
@@ -464,7 +464,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of LLC prefetches throttled=
 due to exceeding the XQ threshold set by either XQ_THRESOLD_DTP or LLC_XQ_=
THRESHOLD. Counts on a per core basis.",
+        "BriefDescription": "Counts the number of LLC prefetches throttled=
 due to exceeding the XQ threshold set by either XQ_THRESHOLD_DTP or LLC_XQ=
_THRESHOLD. Counts on a per core basis.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x29",
         "EventName": "LLC_PREFETCHES_THROTTLED.XQ_THRESH",
@@ -1089,7 +1089,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
@@ -1101,7 +1101,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
@@ -1113,7 +1113,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
@@ -1125,7 +1125,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
@@ -1137,7 +1137,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
@@ -1149,7 +1149,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
@@ -1161,7 +1161,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
@@ -1173,7 +1173,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/lunarlake/other.json
index 1df716442549..164374edf293 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/other.json
@@ -178,6 +178,7 @@
         "EventCode": "0xf4",
         "EventName": "XQ_PROMOTION.ALL",
         "SampleAfterValue": "1000003",
+        "UMask": "0x7",
         "Unit": "cpu_atom"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/lunarlake/pipeline.json
index cdaa01e9a57d..97797f7b072e 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
@@ -21,8 +21,9 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of active floating point an=
d integer dividers per cycle.",
+        "BriefDescription": "This event is deprecated.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
         "EventCode": "0xcd",
         "EventName": "ARITH.DIV_OCCUPANCY",
         "SampleAfterValue": "1000003",
@@ -30,8 +31,9 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of floating point and integ=
er divider uops executed per cycle.",
+        "BriefDescription": "This event is deprecated.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
         "EventCode": "0xcd",
         "EventName": "ARITH.DIV_UOPS",
         "SampleAfterValue": "1000003",
@@ -1023,6 +1025,15 @@
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
     {
         "BriefDescription": "Counts the number of uops executed on all Int=
eger ports.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1205,7 +1216,7 @@
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ALL",
         "SampleAfterValue": "1000003",
-        "UMask": "0x10",
+        "UMask": "0x1f",
         "Unit": "cpu_atom"
     },
     {
@@ -1613,6 +1624,15 @@
         "UMask": "0x8",
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
     {
         "BriefDescription": "Counts the number of issue slots not consumed=
 by the backend due to a micro-sequencer (MS) scoreboard, which stalls the =
front-end from issuing from the UROM until a specified older uop retires.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 946471c4d4b7..3bed131e242d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -22,7 +22,7 @@ GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
-GenuineIntel-6-BD,v1.18,lunarlake,core
+GenuineIntel-6-BD,v1.19,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.17,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
--=20
2.52.0.158.g65b55ccf14-goog

