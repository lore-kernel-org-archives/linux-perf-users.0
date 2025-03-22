Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BEB1F3B83
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Mar 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742625341; cv=none; b=VbGDgjbh6SkrBYTTJS0misk4+SnN+szLBa6hth+DEKJ4ebQIOCmd3zokbWN69CWq7btHzUwnsXJ4M95cmVUPRo+D67QTNBIuuzM/D3qTXu8WGHc0gK/zoT/1gdXdxRGTXK+9ujk578zeYYbm/JlLF5ts4j3zmS44V7af6jEyWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742625341; c=relaxed/simple;
	bh=ctFqUDQckKzVSG33T+IsdXdx8dTadzpOv0SmZRQHLw8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BXwJHO3PZM3dkNR/CJSY4VRPEuE0SNNGqkWO/Z1ilEdg5zX6GlSOTPckKbGrYBeGSWLCBEfgP94uBGNpMYtAuHaZ5ARC0i+LQgIRuR34lBVzdCpQD1ONDxgr5jLueeoaTZx6jEjFIWNaud+Ly9XUEZzQxbEtrkIWxdOgR8xvkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zj2YUO0C; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zj2YUO0C"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f4348c854eso31734677b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 23:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742625335; x=1743230135; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCeVNN7TIWImHS0j62KJ6VLYzh9l1k/vX/z1AR1Qmr4=;
        b=Zj2YUO0Caa7/O84uX6md2nfLg81iWelapW8RjGfraW0G7tz3ueyLgY1izcoEaEYK0Y
         I82XpjvX1U0ELzXFH1NKJ64Z8NQ+d5LnKujVr5a9qwzF3lIrT9LPKqh3LfdFP+MVOCP9
         KQaFH1eN2ayVURQb6wMsR5+I4Z3wwtYzQmgsOQI/1k1tITDluq/yaedmddLyHDVJYObn
         J9D4wsM6RbSCKokzJb6+gfBH6XhG2mZoL9ycbXwprqLJDKs7AqfwLu78OFDPVCt7eVYv
         hcyE/jTD/4VrICPBzRTdtAVS1QowI/h2obSyb62JRnpNHnTDfodoEj7e8lO2BIP3Kkd9
         ZL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742625335; x=1743230135;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hCeVNN7TIWImHS0j62KJ6VLYzh9l1k/vX/z1AR1Qmr4=;
        b=A7MmJImsc693sIhWXrghlGKM1tBNvxA1QnOfFREA8qTF/yhl5T2tzsy58uYhan+H85
         +5GKNYoYFqeKazr4I/j074ELnk96pinv29Gx5pUA2tNZK/WX1CiTEarml4MOAcGecAWK
         NrJK/llV+jjFF6o4VCTdIN0CriYSeL3Ype7N0Lt2jq+KbLj2nckrNeSJtcdnziG6mXEX
         nlv9EELNYMTmHVGqcf5MbeWJB2gMrmXvkYOTqcXZ5IIYZsTiGyegwlVlK4trLIwYnPIm
         DpdObGvQyyQjBSWnB1Xn5TTfJfBVHv9lx0hXGNYliwe1ZvIQxeMXGKUy6T5gkG0PEQhJ
         pcgg==
X-Forwarded-Encrypted: i=1; AJvYcCXNMIa7wA4diuX5U8dRyTPKRDRvdE1+pbKCot6osKrTHXiqAHLWnqxkUw9n35zcSftcEl7xTY05NR1V8njB+KZe@vger.kernel.org
X-Gm-Message-State: AOJu0YxtTlL9eUlzbFbjEEaF8DxfJkq2e2m8irHcvrWSuRIUPGSoLl2+
	2CeW5h9ClaADSAUBkNXvVkbFBxg6B4Eawp2rV7tEf3y01VQ7O8pTl2RsYvUYD2kVNP47UiZV5sk
	Uv0666Q==
X-Google-Smtp-Source: AGHT+IFGcHJsP7czHiNgTeXXByD8ILYoJ0lIeefL5I0HwRpMqcypTiBwO8HVqFWXFxtUfQmqaT7j7ZkpoVvZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c16d:a1c1:1823:1d0e])
 (user=irogers job=sendgmr) by 2002:a05:690c:3383:b0:6fb:8461:e7f4 with SMTP
 id 00721157ae682-700bacc218dmr325847b3.3.1742625334919; Fri, 21 Mar 2025
 23:35:34 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:33:56 -0700
In-Reply-To: <20250322063403.364981-1-irogers@google.com>
Message-Id: <20250322063403.364981-29-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250322063403.364981-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v1 28/35] perf vendor events: Update sierraforest events
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

Update events from v1.08 to v1.09.
Update event topics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/sierraforest/cache.json          |  20 ++
 .../arch/x86/sierraforest/memory.json         |  20 ++
 .../arch/x86/sierraforest/other.json          |  48 ----
 .../arch/x86/sierraforest/pipeline.json       |   8 +
 .../arch/x86/sierraforest/uncore-cache.json   |  32 +++
 .../arch/x86/sierraforest/uncore-memory.json  | 240 ++++++++++++++++++
 7 files changed, 321 insertions(+), 49 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 0c16c9b840a5..bde2f32423a1 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -29,7 +29,7 @@ GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.25,sapphirerapids,core
-GenuineIntel-6-AF,v1.08,sierraforest,core
+GenuineIntel-6-AF,v1.09,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.36,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json b/tools=
/perf/pmu-events/arch/x86/sierraforest/cache.json
index 072df00aff92..21671c65d6dd 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
@@ -466,6 +466,16 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -486,6 +496,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/memory.json b/tool=
s/perf/pmu-events/arch/x86/sierraforest/memory.json
index 22d23077618e..3e2d0b565cfa 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/memory.json
@@ -82,6 +82,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to another socket.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x730000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/other.json b/tools=
/perf/pmu-events/arch/x86/sierraforest/other.json
index 4c77dac8ec78..daa16030d493 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/other.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/other.json
@@ -8,46 +8,6 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
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
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to another socket.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x730000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -57,13 +17,5 @@
         "MSRValue": "0x10800",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x75",
-        "EventName": "SERIALIZATION.C01_MS_SCB",
-        "SampleAfterValue": "200003",
-        "UMask": "0x4"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/sierraforest/pipeline.json
index df2c7bb474a0..a934b64f66d0 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
@@ -300,6 +300,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.C01_MS_SCB",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
.ALL_P]",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json =
b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
index a779a1a73ea5..7182ca00ef8d 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
@@ -873,6 +873,38 @@
         "UMask": "0x1",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "Counts snoop filter capacity evictions for en=
tries tracking exclusive lines in the cores? cache.? Snoop filter capacity =
evictions occur when the snoop filter is full and evicts an existing entry =
to track a new entry.? Does not count clean evictions such as when a core?s=
 cache replaces a tracked cacheline with a new cacheline.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3d",
+        "EventName": "UNC_CHA_SF_EVICTION.E_STATE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Filter Capacity Evictions : E state",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts snoop filter capacity evictions for en=
tries tracking modified lines in the cores? cache.? Snoop filter capacity e=
victions occur when the snoop filter is full and evicts an existing entry t=
o track a new entry.? Does not count clean evictions such as when a core?s =
cache replaces a tracked cacheline with a new cacheline.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3d",
+        "EventName": "UNC_CHA_SF_EVICTION.M_STATE",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Filter Capacity Evictions : M state",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts snoop filter capacity evictions for en=
tries tracking shared lines in the cores? cache.? Snoop filter capacity evi=
ctions occur when the snoop filter is full and evicts an existing entry to =
track a new entry.? Does not count clean evictions such as when a core?s ca=
che replaces a tracked cacheline with a new cacheline.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3d",
+        "EventName": "UNC_CHA_SF_EVICTION.S_STATE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Filter Capacity Evictions : S state",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "All TOR Inserts",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json=
 b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
index ae9c62b32e92..c7e9dbe02eb0 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
@@ -188,6 +188,94 @@
         "PublicDescription": "DRAM Clockticks",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "# of cycles MR4 temp readings forced 2x refre=
sh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 temp readings forced 2x refre=
sh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 temp readings forced 2x refre=
sh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH1_DIMM0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 temp readings forced 2x refre=
sh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH1_DIMM1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x8",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 MRRs was triggered/running",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH0_DIMM0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 MRRs was triggered/running",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH0_DIMM1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 MRRs was triggered/running",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH1_DIMM0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 MRRs was triggered/running",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH1_DIMM1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x8",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
         "Counter": "0,1,2,3",
@@ -286,6 +374,70 @@
         "PublicDescription": "-",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "# of cycles Throttling at Critical level on s=
pecified DIMM and throttle level is zero.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x89",
+        "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at Critical level on s=
pecified DIMM and throttle level is zero.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x89",
+        "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "UNC_M_POWER_THROTTLE_CYCLES.BW_SLOT0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.BW_SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "UNC_M_POWER_THROTTLE_CYCLES.BW_SLOT1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.BW_SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "MR4 temp reading is throttling",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.MR4BLKEN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x8",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "RAPL is throttling",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RAPLBLK",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x4",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
         "Counter": "0,1,2,3",
@@ -480,6 +632,94 @@
         "UMask": "0x1",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "# of cycles Throttling at Critical level on s=
pecified DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at Critical level on s=
pecified DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at High level on speci=
fied DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8d",
+        "EventName": "UNC_M_THROTTLE_HIGH_CYCLES.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at High level on speci=
fied DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8d",
+        "EventName": "UNC_M_THROTTLE_HIGH_CYCLES.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at Normal level on spe=
cified DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8b",
+        "EventName": "UNC_M_THROTTLE_LOW_CYCLES.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at Normal level on spe=
cified DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8b",
+        "EventName": "UNC_M_THROTTLE_LOW_CYCLES.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at Mid level on specif=
ied DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8c",
+        "EventName": "UNC_M_THROTTLE_MID_CYCLES.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at Mid level on specif=
ied DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8c",
+        "EventName": "UNC_M_THROTTLE_MID_CYCLES.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "Write Pending Queue Allocations",
         "Counter": "0,1,2,3",
--=20
2.49.0.395.g12beb8f557-goog

