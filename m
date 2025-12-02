Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EEF2C0277
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694479; cv=none; b=FXQnbMy9NreuNMOWNHcbPV7bfw90id1yrlCYF+BfDtKfO0iP7+76Dx+xXuymcD5M6JHtLL2QiVMj20hBOYMu2eriGT8l3o1GZJGUJOF7AhTZKemKXrouxxP4Q7VqmkgM2pP1ba7gYpnPrfYiCpok/w/FTl14zon1ssVlzJwdcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694479; c=relaxed/simple;
	bh=j0Z4qvPYk2JbtY0lHEqQPYXuGZVZsV4Rw21OlnTzBPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GiefXJRHste+YZReZ6AZYS7f5H/qP+cqZWOempYlyq3mi87DMEN7Wb5+3+Ir5EiUPzGHrX3bybR1PsZmIuihrJRKt4m7E8zlU1GaPtFBECyWgF1ufqSFZB2TjAZnhBDsYiivQgaJ+OhO2agSzbg9aWM8j4d5+2YC44DyfWfGkgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gb+MwNQd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gb+MwNQd"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29806c42760so179245865ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 08:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764694477; x=1765299277; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADVeOsRfKm8u+ZmA4pTg4xKUzoVQaY9Kv/E/ZF3ik08=;
        b=gb+MwNQdKl6dxyYrccyHYFyr2lcidqiNCHvaC4Gz0aEtg/vJooAgh8b1pFSTP1uDRz
         5ApEvz1fyOMp9W7mIb1263qfq3GXVa1Akz6y5yntS7qvVSDbQyyhYKQUsmkTYeh/9auH
         enfI/2SQBrqHM42ckaJR9pV5n0G8zyef75sEvuGH6DtSC3sNfiZzSuLFougE5BML4dtA
         v0+k3IrEH7diTBygrdFoxoqV1nO/l5pK5u4R52cUuPl+FeiSVWioS2xheJmPAG9dHZP5
         hOZWLpUJDO5T+S2hxet3h9uLhaGqCIL5ejVEluE3gA7ExofCYqdOEekdzxuC+5QWzO+c
         ubbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764694477; x=1765299277;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADVeOsRfKm8u+ZmA4pTg4xKUzoVQaY9Kv/E/ZF3ik08=;
        b=NrlKiSncV6IuL3oefLbzJKzlga6MM4ei2E4h6fIG9qKmUyXqje6mB3/ctZNwRBBKwu
         q0pVX1aGvgF+ssGETucHCkQ1J3frq5r5b6xZ74i4dC9i8y/sKNEVz/L3q4tYpzws1uIY
         Ckgqdhbv0ltsNhtutf/of5Ol48e98xzraOn8UoSOyrxbZ4/5meZls/BsEIqeK32ByZ0r
         wnsZy8cKw7FKI7MTxDAebNL9H7ryHhEgxg5+TSUipjzZy06heuaFNVycNcXYqp+qmYfT
         x/3mW+sqdIjJebIyWIJNjm4M9eDY09qOxhH2egchpE+ZAB9ZBR4KXLmBjNJnS/hZTGpb
         7OMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFiqvPn4n0YxW2r1q72YaKmlS1xlauCs/rGaPuD2eTqA2D4QfLDqWaT7J3rVp8jzeHOPZJ+F465WTffm9m9/8V@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjzf5xhzYdWYR5XPtrLJT6TeFXLy987FISUgtiqy9YZwX4FMZR
	QjU/0PIgwbHp88LhnFFyjiRTHU/qNLDGOZKed60//JdQDnUtsz5LccO44Qwek2biZc5sk2Roabw
	u/UXIAjtqgQ==
X-Google-Smtp-Source: AGHT+IHjy4RWUa+HRlRbd7fYgWm3gn1vWGtanPgC/3ECG1MesS5wG1thUjbZLmEZ+Tzzf1C9foFiXGaHnmRL
X-Received: from dybkk11.prod.google.com ([2002:a05:7301:3c8b:b0:2a4:7efb:f33e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:692:b0:119:e56b:c752
 with SMTP id a92af1059eb24-11cb6836855mr21096671c88.23.1764694477043; Tue, 02
 Dec 2025 08:54:37 -0800 (PST)
Date: Tue,  2 Dec 2025 08:53:40 -0800
In-Reply-To: <20251202165340.555375-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202165340.555375-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202165340.555375-10-irogers@google.com>
Subject: [PATCH v1 9/9] perf vendor events intel: Update sierraforest events
 from 1.12 to 1.13
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

The updated events were published in:
https://github.com/intel/perfmon/commit/445e38f5128592f8b5c38da30267fff025e37613

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../arch/x86/sierraforest/cache.json          | 20 +++++++++----------
 .../arch/x86/sierraforest/uncore-cache.json   |  9 +++++++++
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 77a5ec666a51..3d0c57198056 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -30,7 +30,7 @@ GenuineIntel-6-CC,v1.02,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.35,sapphirerapids,core
-GenuineIntel-6-AF,v1.12,sierraforest,core
+GenuineIntel-6-AF,v1.13,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.37,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json b/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
index b2650e8ae252..de0e7661a52d 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
@@ -327,7 +327,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
@@ -338,7 +338,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
@@ -349,7 +349,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
@@ -360,7 +360,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
@@ -371,7 +371,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
@@ -382,7 +382,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
@@ -393,7 +393,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
@@ -404,7 +404,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
@@ -415,7 +415,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
@@ -426,7 +426,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
index 3d1fb5f0417e..35b1763b0020 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
@@ -9,6 +9,15 @@
         "PublicDescription": "UNC_CHACMS_CLOCKTICKS",
         "Unit": "CHACMS"
     },
+    {
+        "BriefDescription": "UNC_CHACMS_DISTRESS_ASSERTED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHACMS_DISTRESS_ASSERTED",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "CHACMS"
+    },
     {
         "BriefDescription": "Counts the number of cycles FAST trigger is received from the global FAST distress wire.",
         "Counter": "0,1,2,3",
-- 
2.52.0.158.g65b55ccf14-goog

