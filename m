Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C01BA083
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907621; cv=none; b=qJNIHoE/yWpWukdkSJtKqZGYGkm2lVOy8jVgZgvMh/cZe/N+vk0YzdjRYMM+2ItaGb/ULdUTIaZzm9xltuz3uaJi0owStlbID1ETFAtM5Im2otkCOE/vGBSPES7WDL5G0rFhIKT/v+FFodhV8QrYqEJhQ2TqEHTVQ+iv/2hG4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907621; c=relaxed/simple;
	bh=a+Cbj3Njosnx6MtOC7Q9pMF6owDcnrW33aWewo8iw4o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=G2tXx7xNrOhwlpWNISZvtr0FVzDGSvcpXf6tAvYejxhtZL+5C6KZacATdhsbktH8trwMvQyrydYgFcBe+Wss91XSE1a4hRkU+u4mVcNJOP2XRIHFkSiJ+y04lTh2EHxQpx6Nk6d4wpbw3qM52aTOYRR1QJAp3C58GUltTuJino8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QI4WiEnq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QI4WiEnq"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfab38b7f6bso1810181276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718907606; x=1719512406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYqZSOtd5pzWs5jD6fnx+CXnnXk6npCbOXzlH+997Hc=;
        b=QI4WiEnqKeHQGgpUR07SVylqDHIVagH4mCXO2oaShvFYKVTDYh+oMSzN34YWXB4WfT
         8go8zJZ2LNflKzwR65VCyHktlbKTVPCLYqjH6ZH2ceh3rmsg/QGt4sovTxv8rsDahKL2
         PYdA/j/FNJ/GuYGJh+tn7gMmlaOqDHrpCE7VJjiQy+Q52nIBGFEOdS6A87cnf35hpfc7
         ZxaLqxxz6PU9wbw/jwtrKbrgSMy0sL37VbjkiapHfnr0HVUL+F6s6FZeWZgWrHvHjUBd
         uf27CMFNEBdm+wI5C4o+KakQq3U2UeohKn+E2jpRlRIEUQnEboq73TfSyHZVz7twbAzl
         mqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907606; x=1719512406;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tYqZSOtd5pzWs5jD6fnx+CXnnXk6npCbOXzlH+997Hc=;
        b=QzUTGIsylpnfO3UusiAIOZ2wOx8/qcduUjYOPMULGCSkuNEW4D536HIF93pllosjhI
         yV2+2g5gnOAowLmutnpraZLIh4KieUqQzDyrAbYfdsCB8q5PRLNTZRAkTKtab/7+BL4R
         afKCrQifvGLOvMqxtc9ker5VG/ItUDqy7A1DcTYSUwWCQUMiWan0A/reE7TZ0b6XBjSm
         JuHiaZHaJ6H+5sDeqo1HtiMPBh99zdSe4BDPIXP3Nc+yFf+0z2wHAnQ1gIfXUogUxj+v
         EqBbI9JvGccMmEDyWU00moJTezWj5DbJh9TE4HCSCxvVM7WFTzH0b0JOeFNPOWA2tEVC
         M9rw==
X-Forwarded-Encrypted: i=1; AJvYcCUQCM+U+dbcLTg+Cq6Qd4zCtvlFQ8D7ulSl+p13zdOZAYfH85z0hNawXWqWWlSwNPu4C4P3jeqiByqHJ+R6zAYtRJrtjiM8K19IcUM1mfLi3g==
X-Gm-Message-State: AOJu0YzRPHTuk7Msfe5Xf/Pfsphgs0syTSWLKOv//9IDuW77Go6pZUQT
	nzQNqITH++OIYZatCwOXTWT/zbwjOsSSjjp8cOcV+0VJGwNZOhvj+Ft4aNqQVlKX3u2GrjUE4K2
	UbFt4zQ==
X-Google-Smtp-Source: AGHT+IHl5wyu/ZFSEyqeG5i3sr8wps1DLlzcoDAmXvH655vLg3S1KFoCtL1UgQ5fbc2Yeoq0e/C+9w2R1Oe+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a6b7:dc01:68ba:649])
 (user=irogers job=sendgmr) by 2002:a05:6902:1006:b0:dfe:1633:89e9 with SMTP
 id 3f1490d57ef6-e02be16c56dmr1735585276.1.1718907605971; Thu, 20 Jun 2024
 11:20:05 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:17:36 -0700
In-Reply-To: <20240620181752.3945845-1-irogers@google.com>
Message-Id: <20240620181752.3945845-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240620181752.3945845-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v2 22/37] perf vendor events: Add lunarlake counter information
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Weilin Wang <weilin.wang@intel.com>, Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add counter information necessary for optimizing event grouping the
perf tool.

The most recent RFC patch set using this information:
https://lore.kernel.org/lkml/20240412210756.309828-1-weilin.wang@intel.com/

The information was added in:
https://github.com/intel/perfmon/commit/475892a9690cb048949e593fe39cee65cd4=
765e1
and later patches.

Co-authored-by: Weilin Wang <weilin.wang@intel.com>
Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../pmu-events/arch/x86/lunarlake/cache.json  | 20 +++++++++++
 .../arch/x86/lunarlake/frontend.json          |  3 ++
 .../pmu-events/arch/x86/lunarlake/memory.json | 15 ++++++++
 .../pmu-events/arch/x86/lunarlake/other.json  |  6 ++++
 .../arch/x86/lunarlake/pipeline.json          | 36 +++++++++++++++++++
 .../arch/x86/lunarlake/virtual-memory.json    |  6 ++++
 6 files changed, 86 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/lunarlake/cache.json
index fb48be357c4e..759714618e08 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of L2 Cache Accesses Counts=
 the total number of L2 Cache Accesses - sum of hits, misses, rejects  fron=
t door requests for CRd/DRd/RFO/ItoM/L2 Prefetches only, per core event",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
         "PublicDescription": "Counts the number of L2 Cache Accesses Count=
s the total number of L2 Cache Accesses - sum of hits, misses, rejects  fro=
nt door requests for CRd/DRd/RFO/ItoM/L2 Prefetches only.",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 =
cache. Counts on a per core basis.",
@@ -19,6 +21,7 @@
     },
     {
         "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
@@ -28,6 +31,7 @@
     },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that access the LLC. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 c=
ache. Counts on a per core basis.",
@@ -37,6 +41,7 @@
     },
     {
         "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
@@ -46,6 +51,7 @@
     },
     {
         "BriefDescription": "Retired load instructions.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
@@ -57,6 +63,7 @@
     },
     {
         "BriefDescription": "Retired store instructions.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
@@ -68,6 +75,7 @@
     },
     {
         "BriefDescription": "Counts the number of load uops retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
@@ -78,6 +86,7 @@
     },
     {
         "BriefDescription": "Counts the number of store uops retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
@@ -88,6 +97,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
@@ -100,6 +110,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
@@ -112,6 +123,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
@@ -124,6 +136,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
@@ -136,6 +149,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
@@ -148,6 +162,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
@@ -160,6 +175,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
@@ -172,6 +188,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
@@ -184,6 +201,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
@@ -196,6 +214,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
@@ -208,6 +227,7 @@
     },
     {
         "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/lunarlake/frontend.json
index 3a24934e8d6e..0327bece0f94 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
         "SampleAfterValue": "200003",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump and the instruction cache registers bytes are not present=
. -",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "SampleAfterValue": "200003",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were no operation was delivered to the back-end pipeline due =
to instruction fetch limitations when the back-end could have accepted more=
 operations. Common examples include instruction cache misses or x86 instru=
ction decode limitations.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CORE",
         "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were no operation was delivered to the back-end pipeline due=
 to instruction fetch limitations when the back-end could have accepted mor=
e operations. Common examples include instruction cache misses or x86 instr=
uction decode limitations. Software can use this event as the numerator for=
 the Frontend Bound metric (or top-level category) of the Top-down Microarc=
hitecture Analysis method.",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/lunarlake/memory.json
index 9c188d80b7b9..3d12e226d5ef 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 1024 cycles.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
@@ -14,6 +15,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
@@ -27,6 +29,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 16 cycles.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
@@ -40,6 +43,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 2048 cycles.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
@@ -53,6 +57,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
@@ -66,6 +71,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 32 cycles.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
@@ -79,6 +85,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 4 cycles.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
@@ -92,6 +99,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 512 cycles.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
@@ -105,6 +113,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 64 cycles.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
@@ -118,6 +127,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 8 cycles.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
@@ -131,6 +141,7 @@
     },
     {
         "BriefDescription": "Retired memory store access operations. A PDi=
st event for PEBS Store Latency Facility.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
@@ -142,6 +153,7 @@
     },
     {
         "BriefDescription": "Counts cacheable demand data reads were not s=
upplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -152,6 +164,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -162,6 +175,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership, including =
SWPREFETCHW which is an RFO were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -172,6 +186,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were no=
t supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/lunarlake/other.json
index 377f717db6cc..0b49b4684c4b 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/other.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts cacheable demand data reads Catch all =
value for any response types - this includes response types not define in t=
he OCR.  If this is set all other response types will be ignored",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -11,6 +12,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -21,6 +23,7 @@
     },
     {
         "BriefDescription": "Counts cacheable demand data reads were suppl=
ied by DRAM.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -31,6 +34,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -41,6 +45,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership, including =
SWPREFETCHW which is an RFO Catch all value for any response types - this i=
ncludes response types not define in the OCR.  If this is set all other res=
ponse types will be ignored",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -51,6 +56,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/lunarlake/pipeline.json
index 2c9f85ec8c4a..220c2115fec9 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "All branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -19,6 +21,7 @@
     },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -28,6 +31,7 @@
     },
     {
         "BriefDescription": "All mispredicted branch instructions retired.=
",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -37,6 +41,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
@@ -44,6 +49,7 @@
     },
     {
         "BriefDescription": "Core cycles when the core is not in a halt st=
ate.",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. This event is a component in many key event ratios.=
 The core frequency may change from time to time due to transitions associa=
ted with Enhanced Intel SpeedStep Technology or TM2. For this reason this e=
vent may have a changing ratio with regards to time. When the core frequenc=
y is constant, this event can approximate elapsed time while the core was n=
ot in the halt state. It is counted on a dedicated fixed counter, leaving t=
he programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -52,6 +58,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
         "SampleAfterValue": "2000003",
@@ -59,6 +66,7 @@
     },
     {
         "BriefDescription": "Thread cycles when thread is not in halt stat=
e [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
         "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
@@ -67,6 +75,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
         "UMask": "0x3",
@@ -74,6 +83,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. Note: =
On all current platforms this event stops counting during 'throttling (TM)'=
 states duty off periods the processor is 'halted'.  The counter update is =
done at a lower clock rate then the core clock the overflow status bit for =
this counter may appear 'sticky'.  After the counter has overflowed and sof=
tware clears the overflow status bit and resets the counter to less than MA=
X. The reset value to the counter is not clocked immediately so the overflo=
w status bit will flip 'high (1)' and generate another PMI (if enabled) aft=
er which the reset value gets clocked into the counter. Therefore, software=
 will get the interrupt, read the overflow status bit '1 for bit 34 while t=
he counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -82,6 +92,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock=
 cycles",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
         "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses a programmable general purpose performan=
ce counter.",
@@ -91,6 +102,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
         "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. Note: =
On all current platforms this event stops counting during 'throttling (TM)'=
 states duty off periods the processor is 'halted'.  The counter update is =
done at a lower clock rate then the core clock the overflow status bit for =
this counter may appear 'sticky'.  After the counter has overflowed and sof=
tware clears the overflow status bit and resets the counter to less than MA=
X. The reset value to the counter is not clocked immediately so the overflo=
w status bit will flip 'high (1)' and generate another PMI (if enabled) aft=
er which the reset value gets clocked into the counter. Therefore, software=
 will get the interrupt, read the overflow status bit '1 for bit 34 while t=
he counter value is less than MAX. Software should ignore this case.",
@@ -100,6 +112,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
@@ -107,6 +120,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in a halt =
state.",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -115,6 +129,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "SampleAfterValue": "2000003",
@@ -122,6 +137,7 @@
     },
     {
         "BriefDescription": "Thread cycles when thread is not in halt stat=
e [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
@@ -130,6 +146,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "SampleAfterValue": "2000003",
@@ -138,6 +155,7 @@
     },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
@@ -147,6 +165,7 @@
     },
     {
         "BriefDescription": "Counts the number of instructions retired",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
@@ -155,6 +174,7 @@
     },
     {
         "BriefDescription": "Number of instructions retired. General Count=
er - architectural event",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
@@ -164,6 +184,7 @@
     },
     {
         "BriefDescription": "Counts the number of occurrences a retired lo=
ad gets blocked because its address partially overlaps with an older store =
(size mismatch) - unknown_sta/bad_forward",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PEBS": "1",
@@ -173,6 +194,7 @@
     },
     {
         "BriefDescription": "Loads blocked due to overlapping with a prece=
ding store that cannot be forwarded.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
@@ -182,6 +204,7 @@
     },
     {
         "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
         "PEBS": "1",
@@ -191,6 +214,7 @@
     },
     {
         "BriefDescription": "LBR record is inserted",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
         "PEBS": "1",
@@ -200,6 +224,7 @@
     },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were not consumed by the back-end pipeline due to lack of bac=
k-end resources, as a result of memory subsystem delays, execution units li=
mitations, or other conditions.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
         "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were not consumed by the back-end pipeline due to lack of ba=
ck-end resources, as a result of memory subsystem delays, execution units l=
imitations, or other conditions. Software can use this event as the numerat=
or for the Backend Bound metric (or top-level category) of the Top-down Mic=
roarchitecture Analysis method.",
@@ -209,6 +234,7 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
+        "Counter": "Fixed counter 3",
         "EventName": "TOPDOWN.SLOTS",
         "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
Software can use this event as the denominator for the top-level metrics of=
 the TMA method. This architectural event is counted on a designated fixed =
counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
@@ -217,6 +243,7 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. General counter - architectural event",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.SLOTS_P",
         "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod.",
@@ -226,6 +253,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
.ALL_P]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
         "SampleAfterValue": "1000003",
@@ -233,6 +261,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
.ALL]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL_P",
         "SampleAfterValue": "1000003",
@@ -240,6 +269,7 @@
     },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls [This event is alias to TOPDOWN_BE_BOUND.ALL_P]=
",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN_BE_BOUND.ALL",
         "SampleAfterValue": "1000003",
@@ -248,6 +278,7 @@
     },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls [This event is alias to TOPDOWN_BE_BOUND.ALL]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN_BE_BOUND.ALL_P",
         "SampleAfterValue": "1000003",
@@ -256,6 +287,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of retiremen=
t slots not consumed due to front end stalls",
+        "Counter": "37",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x6",
@@ -263,6 +295,7 @@
     },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "TOPDOWN_FE_BOUND.ALL_P",
         "SampleAfterValue": "1000003",
@@ -271,6 +304,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of consumed =
retirement slots.",
+        "Counter": "38",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "PEBS": "1",
         "SampleAfterValue": "1000003",
@@ -279,6 +313,7 @@
     },
     {
         "BriefDescription": "Counts the number of consumed retirement slot=
s.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "TOPDOWN_RETIRING.ALL_P",
         "PEBS": "1",
@@ -288,6 +323,7 @@
     },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that are utilized by operations that eventually get retired (commi=
tted) by the processor pipeline. Usually, this event positively correlates =
with higher performance  for example, as measured by the instructions-per-c=
ycle metric.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.SLOTS",
         "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that are utilized by operations that eventually get retired (comm=
itted) by the processor pipeline. Usually, this event positively correlates=
 with higher performance  for example, as measured by the instructions-per-=
cycle metric. Software can use this event as the numerator for the Retiring=
 metric (or top-level category) of the Top-down Microarchitecture Analysis =
method.",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
index bb9458799f1c..59af79e3466e 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to any page size.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to any page si=
ze. Includes page walks that page fault.",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
@@ -19,6 +21,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to any page size.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to any page size.  Includes page walks =
that page fault.",
@@ -28,6 +31,7 @@
     },
     {
         "BriefDescription": "Store misses in all TLB levels causes a page =
walk that completes. (All page sizes)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
@@ -37,6 +41,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to any page size.  Include=
s page walks that page fault.",
@@ -46,6 +51,7 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
--=20
2.45.2.627.g7a2c4fd464-goog

