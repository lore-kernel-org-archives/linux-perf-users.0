Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF11EB3D
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686568; cv=none; b=kLj1HZc1VjUQM8F/un64JEkhYzkxLS9x/Ol9cdv0jVZfhJ5KqVOsr52mp+dBpq87a2TwFrVYZ/5znb+08WfoHThbajOwZcP+CQB51igGdbTMbkgGK0/99gNpiTFIk5YIGrUP1X0gWFhCffIeDQ+d4C3q/fef5YXMs3v2G8X3krY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686568; c=relaxed/simple;
	bh=UtPCiTSWLbpz3XdVFO7sK+jsQ6jIVqsxVRQ1Gq3WAPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YwBAQ4LMNQwO2a/AKz+mCIvrL8nbdmI6tANL9ydy9GYc/Xcy5yylAZgqOmyxSZfSHRe57IIwCqgu04FjbugKhKn4V3IWHsbGwvUGUIijkrO7UnVraqxICOWb1T7NOQWpSpHKh7MlxZ9WMwoZSCSzFaMqWKh/vunDR9NKivRnCig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zjm5ySpS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zjm5ySpS"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747d29e90b4so317741b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 17:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749686566; x=1750291366; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWSYgmdUR5fuOjGXovF71LaefH09HdMVkUZ5+LY/N74=;
        b=zjm5ySpSFWVYhWYBEI01Lg8yX84OE1Ou8g/jjEwW3/MbFym4j5gkqtHrXOS5P8lUGy
         omVJU64m20ROwgkNyXA3ZwROEDFfcyo44rGCwDY0u5+bFK7y+OkX2Uyr0zZBINlTXSMf
         dERwTOJ2clYdSCdF23C9GOfKDksDbMUTDZPKt0CChuWEwUEjrhWqdpcsczyHlCzvIW71
         YivrsegYnQWGos0WyyAUKy5lCHXGU71N1C9kfZw7Ua/tJWv4jCbtmMoOwxhs/Gn50Won
         AtOVkuxO7UQqQBK1SePOCMViQ8bWLIF+JCLKf3hKajtXHO7mBVwCFGVWXyTz7641irPt
         5iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749686566; x=1750291366;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BWSYgmdUR5fuOjGXovF71LaefH09HdMVkUZ5+LY/N74=;
        b=u3GEB94/7uAl5L0S0IDX+uslnQEepvZLWzx9X1Uuc8bYyR97XNacWOM8zkqyP5oXUV
         JfSfIum6Y1mccTzfwVzXBsKbP2WT3MO9OkG+F6GLEo1Q08uD1NP2yVsD1JKwVu9jggyg
         fMXiSh9DLb5CERpFe+BqGllnZwPoCt2Cc6pLvJI/Z6y8+N9bjCtO38lgBb6OY2q4gCtY
         vxAaRa5Hm7pHge7n0c1+POWzvr3LWCnMBQV0f8DUZITG6tfhrtR78e+S6B5imszVcN0W
         5aLTOy1k+vJ/bN/qEI2Gjk5dJS4E310d6+n4exy4jF1mqMsKd6HKo1z8sTfi0X+wEZpF
         Gg2A==
X-Forwarded-Encrypted: i=1; AJvYcCVbb2jha8VYT1vDYccjGrenpkpMMCe0JJGe0c4tBM4SEVh4lH1Q2wHiV1V0vchjomnN+7UGeIwUGjN7WHzvelNn@vger.kernel.org
X-Gm-Message-State: AOJu0YzX0/bNJoOHZP4TCkDfkO9nraIOLYkgfeFMjr209ZNuDuvnR69f
	bASDs7qlJ02XiurA27PyezUXEb8NPlIfw1uDSsyGGzwxLms/O2EvVQAr5y91Rh6D0PmgXhAkfVQ
	mDGGh2Uop7A==
X-Google-Smtp-Source: AGHT+IFC+dOqy4ZJoJeAffwE8Q788oIwfbnuUWr3CFRwdP7jbplHCccYJcTKShVNiWCG85Q3fZMo79/hUDcg
X-Received: from pgbdp10.prod.google.com ([2002:a05:6a02:f0a:b0:af9:8f44:d7ec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8b:b0:21f:556a:ca08
 with SMTP id adf61e73a8af0-21f978bdfdbmr2398802637.37.1749686566036; Wed, 11
 Jun 2025 17:02:46 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:02:18 -0700
In-Reply-To: <20250612000224.780337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612000224.780337-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612000224.780337-10-irogers@google.com>
Subject: [PATCH v1 09/15] perf vendor events: Update LunarLake events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.11 to v1.14.

Bring in the event updates v1.14:
https://github.com/intel/perfmon/commit/95634fec10542c0c466eb2c6d9a81e0c24f=
b1123
https://github.com/intel/perfmon/commit/84a49938387ac592af0a622273e4e8e4997=
e987d

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/lunarlake/cache.json   | 11 +++++++++++
 .../arch/x86/lunarlake/pipeline.json           | 18 ++++++++++++++----
 .../arch/x86/lunarlake/virtual-memory.json     | 18 ------------------
 tools/perf/pmu-events/arch/x86/mapfile.csv     |  2 +-
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/lunarlake/cache.json
index b1a6bb867a1e..ff37d49611c3 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
@@ -790,6 +790,17 @@
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "1000003",
+        "UMask": "0x101",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts retired load instructions with at leas=
t one uop that hit in the Level 0 of the L1 data cache. This event includes=
 all SW prefetches and lock instructions regardless of the data source.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT_L0",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the Level 0 of the L1 data cache. This event include=
s all SW prefetches and lock instructions regardless of the data source. Av=
ailable PDIST counters: 0",
+        "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/lunarlake/pipeline.json
index 4875047fb65c..6ac410510628 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
@@ -1247,9 +1247,19 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of demand loads that match =
on a wcb (request buffer) allocated by an L1 hardware prefetch",
+        "BriefDescription": "Counts the number of demand loads that match =
on a wcb (request buffer) allocated by an L1 hardware prefetch [This event =
is alias to LOAD_HIT_PREFETCH.HW_PF]",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4c",
+        "EventName": "LOAD_HIT_PREFETCH.HWPF",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to LOAD_HIT_PREFETCH.HWPF]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.HW_PF",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
@@ -1664,7 +1674,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of issue slo=
ts not consumed by the backend because allocation is stalled due to a mispr=
edicted jump or a machine clear.",
-        "Counter": "36",
+        "Counter": "Fixed counter 4",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
         "PublicDescription": "Fixed Counter: Counts the number of issue sl=
ots that were not consumed by the backend because allocation is stalled due=
 to a mispredicted jump or a machine clear.  Counts all issue slots blocked=
 during this recovery window including relevant microcode flows and while u=
ops are not yet available in the IQ. Also, includes the issue slots that we=
re consumed by the backend but were thrown away because they were younger t=
han the mispredict or machine clear.",
         "SampleAfterValue": "1000003",
@@ -1797,7 +1807,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of retiremen=
t slots not consumed due to front end stalls.",
-        "Counter": "37",
+        "Counter": "Fixed counter 5",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x6",
@@ -1903,7 +1913,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of consumed =
retirement slots.",
-        "Counter": "38",
+        "Counter": "Fixed counter 6",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x7",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
index defa3a967754..e60a5e904da2 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
@@ -36,24 +36,6 @@
         "UMask": "0x320",
         "Unit": "cpu_core"
     },
-    {
-        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to a demand load that did not start a page walk. A=
ccount for 4k page size only. Will result in a DTLB write from STLB.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x08",
-        "EventName": "DTLB_LOAD_MISSES.STLB_HIT_4K",
-        "SampleAfterValue": "200003",
-        "UMask": "0x20",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to a demand load that did not start a page walk. A=
ccount for large page sizes only. Will result in a DTLB write from STLB.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x08",
-        "EventName": "DTLB_LOAD_MISSES.STLB_HIT_LGPG",
-        "SampleAfterValue": "200003",
-        "UMask": "0x40",
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a demand load.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 53c0d19c51d4..5f27b3700c3c 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -22,7 +22,7 @@ GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
-GenuineIntel-6-BD,v1.11,lunarlake,core
+GenuineIntel-6-BD,v1.14,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.13,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
--=20
2.50.0.rc1.591.g9c95f17f64-goog

