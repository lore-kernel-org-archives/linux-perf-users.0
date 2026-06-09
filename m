Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D454949F1
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041872; cv=none; b=sFToCtnMf1d3zoH15S5fCuN37QK+vp0IYa1sfqmV9wRtbDorkQjwqAWg371MpLOGuNZv9h7NYfVQwsWPAEAFMKXOxRT8K1nl60QVYEB64sExoRjV8AqwPe0OBS0duYD7cTyPWgX5JvGeHob0ZspxjIO7eXN351S6nr9PhOlcol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041872; c=relaxed/simple;
	bh=bLrOjy2OCdDQHDe2TDfieLIrz75W31iZtleSIYi0KOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=daBBAbbGk25pEzu1YxXzKNflBNrWZ+tziOdSr84P3iXEZ13OmQEHY0QFTZpKo+dyqDR74/kFuK+1Foh1s9fS2ZME3+ce41+CRP5w02sdYTaue/UbgOppnYtYoSsJz0kigHRgB+iVw2eIuuD4XYLIg2LFtakPzq8Szbs1ENzs3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZWvIl+EK; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWvIl+EK"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2cda4d0so3077674a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 14:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781041856; x=1781646656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1rcnyTrGXImGlSNA8JQX3j0MaK0p5tkgHi7ksH0SGoI=;
        b=ZWvIl+EKJOLchnYMLv2cct0X1fgHlF3SMOA+1RDKv93mE+2Chx6Av/kuAIYDZZL97e
         JUIJ6D+oU5PFnrXxjvAwwE8B/p9cQciOUQEeZs9QKIZI7HFu0mt9XpO/PuH4RjAmZazP
         BCC34IRLgKY4/cYB2VpVnDS3uU9bnu3HClDyybZ96EsXF2Q1lgdu4Y93oCIHTLoH3C7L
         st0NJmy0Rt6HuvA/YRenIoJCPR4GPC69OafOIgyIgc9Qse9Wqzt0SikB9PWFtm7IPhD3
         xwQ0xCJsifJbEYr2o/40SVr8EEzDYtRg4HDek1KKtDlY2hnPLiO3eYC0idG8VZnRvkn/
         khBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781041856; x=1781646656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rcnyTrGXImGlSNA8JQX3j0MaK0p5tkgHi7ksH0SGoI=;
        b=ei1Wuhyj6991nOtByRsB5+tceCMUX9aH1kTN9PlO1mpi15h2GUfXowYleLhJCS4aAV
         r0XO9/xJre/t/pyrR3+GhNWAwoAD/Uet/wAHpllaAREU7y3nGpGcfdc4IOgvZ570Hjkl
         Zm2NWPk0ahNwTAi6MhsP2UwvuD2RHIZictP1y4ExwvNsWMNx7dhF1/v3HN4bKYAZ65D1
         4qbP86cz0Em2sOBoyNu08sixLwQ+Kj8gBQUqVmENDgQvS6vt/cgMo6y5/JEqzRHXvF0i
         q2boXdbLtvR68p04z1LS0pGdeLHXFmmRn25IMhLVxzT1reSQU2SGp4IVCl/CwDDqKa1V
         8ZAw==
X-Forwarded-Encrypted: i=1; AFNElJ94YLg3HqVA7/wrHnizfkXFzPHxXRy4S5GSy3RakKh3LF+JFlHQUyNIB9PxkG6fNEILF1UOE1NlRu8Xcf7/Cy8L@vger.kernel.org
X-Gm-Message-State: AOJu0YyFZXPilfWsbDkdv4hW2gJv5nqM6CVq+JW79eJS1II5hwIFlJSq
	ivX6IAcvpT9XNQAZeFinPvUGRdBfGysw3jB+7sH+5jV/YF0l7fShRDXj2VAls7UqrUbqUF4eh7O
	DlEZwNA==
X-Received: from pfbfj40.prod.google.com ([2002:a05:6a00:3a28:b0:842:3d2d:1e84])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d28:b0:842:6a3b:60c9
 with SMTP id d2e1a72fcca58-842b0f4cc1bmr24915638b3a.24.1781041855299; Tue, 09
 Jun 2026 14:50:55 -0700 (PDT)
Date: Tue,  9 Jun 2026 14:50:44 -0700
In-Reply-To: <20260609215046.2391903-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609215046.2391903-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609215046.2391903-6-ctshao@google.com>
Subject: [PATCH v1 5/6] perf vendor events intel: Update pantherlake events
 from 1.05 to 1.06
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-actions@lists.infradead.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

The updated events were published in:
https://github.com/intel/perfmon/commit/ffc03fc3b414127c5a36bbb648e500c4afeff134

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/pantherlake/counter.json         |   5 +
 .../arch/x86/pantherlake/pipeline.json        |  29 ++-
 .../x86/pantherlake/uncore-interconnect.json  |  10 +
 .../arch/x86/pantherlake/uncore-memory.json   | 221 +++++++++++++++++-
 5 files changed, 260 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/uncore-interconnect.json

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 7d19f8fa335a..6af3cee12c8a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -26,7 +26,7 @@ GenuineIntel-6-BD,v1.25,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.21,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
-GenuineIntel-6-(CC|D5),v1.05,pantherlake,core
+GenuineIntel-6-(CC|D5),v1.06,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.39,sapphirerapids,core
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/counter.json b/tools/perf/pmu-events/arch/x86/pantherlake/counter.json
index 432b6946ccbc..9794b435f650 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/counter.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/counter.json
@@ -13,5 +13,10 @@
         "Unit": "iMC",
         "CountersNumFixed": "0",
         "CountersNumGeneric": "5"
+    },
+    {
+        "Unit": "SANTA",
+        "CountersNumFixed": 1,
+        "CountersNumGeneric": "0"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json b/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
index d476bad5e2a7..5d5303c02954 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
@@ -887,11 +887,32 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This event counts the number of mispredicted ret instructions retired. Non PEBS [This event is alias to BR_MISP_RETIRED.RET]",
+        "BriefDescription": "This event is deprecated. [This event is alias to BR_MISP_RETIRED.NEAR_RETURN]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_RET",
+        "PublicDescription": "This event is deprecated. [This event is alias to BR_MISP_RETIRED.NEAR_RETURN] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near RET branch instructions retired. [This event is alias to BR_MISP_RETIRED.NEAR_RET]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_RETURN",
+        "PublicDescription": "Counts the number of mispredicted near RET branch instructions retired. [This event is alias to BR_MISP_RETIRED.NEAR_RET] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event counts the number of mispredicted ret instructions retired [This event is alias to BR_MISP_RETIRED.RET]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_RETURN",
-        "PublicDescription": "This is a non-precise version (that is, does not use PEBS) of the event that counts mispredicted return instructions retired. [This event is alias to BR_MISP_RETIRED.RET] Available PDIST counters: 0,1",
+        "PublicDescription": "This event counts the number of mispredicted ret instructions retired [This event is alias to BR_MISP_RETIRED.RET] Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1726,7 +1747,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of machines clears due to memory renaming.",
+        "BriefDescription": "Counts the number of machine clears due to memory renaming.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MRN_NUKE",
@@ -1930,7 +1951,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number issue slots not consumed  due to a  color request for an FCW or MXCSR control register when all 4 colors (copies) are already in use.",
+        "BriefDescription": "Counts the number of issue slots not consumed due to a color request for an FCW or MXCSR control register when all 4 colors (copies) are already in use.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x75",
         "EventName": "SERIALIZATION.COLOR_STALLS",
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/pantherlake/uncore-interconnect.json
new file mode 100644
index 000000000000..69ef928d57f6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/uncore-interconnect.json
@@ -0,0 +1,10 @@
+[
+    {
+        "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles.",
+        "Counter": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "Unit": "SANTA"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/uncore-memory.json b/tools/perf/pmu-events/arch/x86/pantherlake/uncore-memory.json
index a881b99be5f3..8faa03e1c6d0 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/uncore-memory.json
@@ -1,6 +1,30 @@
 [
     {
-        "BriefDescription": "Read CAS command sent to DRAM",
+        "BriefDescription": "ACT command for a read request sent to DRAM.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x24",
+        "EventName": "UNC_M_ACT_COUNT_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command sent to DRAM.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x26",
+        "EventName": "UNC_M_ACT_COUNT_TOTAL",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command for a write request sent to DRAM.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x25",
+        "EventName": "UNC_M_ACT_COUNT_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS command sent to DRAM.",
         "Counter": "0,1,2,3,4",
         "EventCode": "0x22",
         "EventName": "UNC_M_CAS_COUNT_RD",
@@ -8,13 +32,153 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Write CAS command sent to DRAM",
+        "BriefDescription": "Write CAS command sent to DRAM.",
         "Counter": "0,1,2,3,4",
         "EventCode": "0x23",
         "EventName": "UNC_M_CAS_COUNT_WR",
         "PerPkg": "1",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "Counting the number of clocks.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_CLOCKTICKS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE in DRAM is low.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x29",
+        "EventName": "UNC_M_DRAM_CKE_OFF_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming read request page status is Page Empty.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M_DRAM_PAGE_EMPTY_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "incoming read request page status is Page Empty",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming write request page status is Page Empty.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_DRAM_PAGE_EMPTY_WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "incoming write request page status is Page Empty",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming read request page status is Page Hit.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M_DRAM_PAGE_HIT_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "incoming read request page status is Page Hit",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming write request page status is Page Hit.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x1F",
+        "EventName": "UNC_M_DRAM_PAGE_HIT_WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "incoming write request page status is Page Hit",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming read request page status is Page Miss.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x1E",
+        "EventName": "UNC_M_DRAM_PAGE_MISS_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "incoming read request page status is Page Miss",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming write request page status is Page Miss.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x21",
+        "EventName": "UNC_M_DRAM_PAGE_MISS_WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "incoming write request page status is Page Miss",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM in Self-refresh (all channels).",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x12",
+        "EventName": "UNC_M_DRAM_SELF_REFRESH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Any Rank at Hot state.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x19",
+        "EventName": "UNC_M_DRAM_THERMAL_HOT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Any Rank at Warm state.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x1A",
+        "EventName": "UNC_M_DRAM_THERMAL_WARM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PRE command sent to DRAM for a read/write request.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x27",
+        "EventName": "UNC_M_PRE_COUNT_PAGE_MISS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts number of bytes read, in 32B chunk, per DDR channel. Counter increments by 1 after receiving 32B chunk data.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x3A",
+        "EventName": "UNC_M_RD_DATA",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of VC0 read in channel0  - this event can increment by more than 1 (per channel/sub-ch).",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x13",
+        "EventName": "UNC_M_RD_OCCUPANCY_CH0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of VC0 read in channel0  - this event can  increment by more than 1 (per channel/sub-ch)",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of VC0 read in channel1 - this event can increment by more than 1 (per channel/sub-ch).",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x14",
+        "EventName": "UNC_M_RD_OCCUPANCY_CH1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Total number of read and write byte transfers to/from DRAM, in 32B chunk, per DDR channel. Counter increments by 1 after sending  or receiving 32B chunk data.",
         "Counter": "0,1,2,3,4",
@@ -22,5 +186,58 @@
         "EventName": "UNC_M_TOTAL_DATA",
         "PerPkg": "1",
         "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Total number of requests entering MC, this is the sum of all RD + WR requests for all VCs.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x39",
+        "EventName": "UNC_M_TOTAL_REQUESTS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC0 read request.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_VC0_REQUESTS_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC0 write request.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_VC0_REQUESTS_WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC1 read request.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_VC1_REQUESTS_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC1 write request.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_VC1_REQUESTS_WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts number of bytes written, in 32B chunk, per DDR channel. Counter increments by 1 after sending 32B chunk data.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x3B",
+        "EventName": "UNC_M_WR_DATA",
+        "PerPkg": "1",
+        "Unit": "iMC"
     }
 ]
-- 
2.54.0.1099.g489fc7bff1-goog

