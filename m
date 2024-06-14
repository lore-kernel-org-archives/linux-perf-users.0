Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F41188CB0
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Jun 2024 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406200; cv=none; b=lv2NZgcMOhtxl6Kpqc7Fj4sk/J2AGN642mJI/30LNHit2HP1A2nX+jC6hrCTdsQsLvUwr2Qvql/44e3naV5R8tt1GfsCQpbj4nfJCBNR6aK9XKj72UA1390X3V3WrTZqJF/O5/VqvViWx2wX9PqYxZpY4onTdY+0Yc+iICL7ufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406200; c=relaxed/simple;
	bh=xsjIOjWhTIRYBRBM7UQA+dMZHexOhvHftqhwcXqWU1c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Eu51Gh7+3GHU5G+hE1RyKxUkoXsFbfx/Vl9e6BNtc1UBnPMZodSnssgCrYrKcaod+mFCfj0kBzcwivV29qMdlxDjkwQNzIo+rlmPdYrSx3lRzYUSLJQWLyWMRkrC26bRIxkr+oDNm6HGNp0bnrLxk8uKPO9nCO9y224++T1RWm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F8R+x/nu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8R+x/nu"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dff16daff8dso2322543276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jun 2024 16:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718406191; x=1719010991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozQRQXQ3qhVI+ajlYf14uUnTD41sfmItYRUk2kmRFrI=;
        b=F8R+x/nu0WdstjXe84f0dJInj/IYUarL89oaYdiPIBUpf776stuOzsYLaU3FgEmS1i
         ky2Bu405122zBQ4ZOa6+vIm0AFWq/IXl1EUimElg4cldoMXo2XADKtNc5bfWLZzFlQXC
         wQRfq4Fw8ZIGnJiPJaRTfmkCj6jKUQvx9DpIVK7KHKPWAYoiO+QEc4xIY9J7N6R2fSJf
         LR1/ueIjP5c/gxRm8uyCFT2zWW22Q0ROnDuI92Af1hpIaRJn9V/Aau+hCAFzgKxu7wTx
         99DkyJyEwrPEca71R5QUdMl1ET+sOuRKSwouwcEY38xFMHrqNbBFNro5ZBLThtJJ1q3S
         TPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718406191; x=1719010991;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ozQRQXQ3qhVI+ajlYf14uUnTD41sfmItYRUk2kmRFrI=;
        b=l97hn3b+HDapb5VEsrraxYcXxhSzlfpfYDavwiJxnYlr6R1RMcTHC2yKPJkgajIpV3
         lQ16KctG34BaROZASeT05ZqtBWwajZeMCI7BEPYgUs8tY0KSs8iX/S13VAVaDcEdI7Tz
         GTyvVRD4rNwKKOW5HMh8Kxiq3ZAtlirpjzn2H4N8EGs5CtUs8NiLtoB6myB1ZMXzFyB3
         op1/gDuY4TmVA5SBLJ2Ox0S1E6KJqGSzHoAGas1FRPyGUvMGvMS2Q9AW8RBHgKCjQKoF
         18D37h0uhOZJCnpBzp+ICD9S5erBGvn6sD6HAPVyWRbgymf+sIbItu/xT0bVvl6wBaIZ
         SpMg==
X-Forwarded-Encrypted: i=1; AJvYcCWEUIz+S7x343tLJz1LXFAzdQpWyF6mMF9+asmvjFTqR4n6UpmpLO5xy+xlj+2IpVcIOk1fnlXdklDzZsLl9A3iDQsYZYCj5wDBYUhRNDgDzg==
X-Gm-Message-State: AOJu0YxmVt4/xPCz9KoI3JeL+PqAMA8GSHOMxBnPB9L4b7tgJOniwNmg
	BL9olxCWeSZlDGwNl3+FsNC4I7wdI6JF8hXia0WXW9bYNGU1j14gNGsvkuetsfT36mpayIkeWbV
	VPnKB+A==
X-Google-Smtp-Source: AGHT+IECMd81MgZzuq0MdIu3enoT+kgGX/xAFI3JAjnFBBUrcpq2e3aOsZ5D65dQB3Xqg6KOlyDSeWyYph6s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:714a:5e65:12a1:603])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d92:b0:dff:91c:c7c8 with SMTP id
 3f1490d57ef6-dff15487564mr413439276.11.1718406190934; Fri, 14 Jun 2024
 16:03:10 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:01:19 -0700
In-Reply-To: <20240614230146.3783221-1-irogers@google.com>
Message-Id: <20240614230146.3783221-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240614230146.3783221-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v1 11/37] perf vendor events: Add goldmontplus counter information
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
---
 .../arch/x86/goldmontplus/cache.json          | 101 ++++++++++++++++++
 .../arch/x86/goldmontplus/counter.json        |   7 ++
 .../arch/x86/goldmontplus/floating-point.json |   3 +
 .../arch/x86/goldmontplus/frontend.json       |   8 ++
 .../arch/x86/goldmontplus/memory.json         |   3 +
 .../arch/x86/goldmontplus/other.json          |   5 +
 .../arch/x86/goldmontplus/pipeline.json       |  42 ++++++++
 .../arch/x86/goldmontplus/virtual-memory.json |  18 ++++
 8 files changed, 187 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/counter.jso=
n

diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json b/tools=
/perf/pmu-events/arch/x86/goldmontplus/cache.json
index a7f80fd1b1df..92086758e7ce 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Requests rejected by the L2Q",
+        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ALL",
         "PublicDescription": "Counts the number of demand and L1 prefetche=
r requests rejected by the L2Q due to a full or nearly full condition which=
 likely indicates back pressure from L2Q. It also counts requests that woul=
d have gone directly to the XQ, but are rejected due to a full or nearly fu=
ll condition, indicating back pressure from the IDI link. The L2Q may also =
reject transactions from a core to insure fairness between cores, or to del=
ay a core's dirty eviction when the address conflicts with incoming externa=
l snoops.",
@@ -8,6 +9,7 @@
     },
     {
         "BriefDescription": "L1 Cache evictions for dirty data",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "DL1.REPLACEMENT",
         "PublicDescription": "Counts when a modified (dirty) cache line is=
 evicted from the data L1 cache and needs to be written back to memory.  No=
 count will occur if the evicted line is clean, and hence does not require =
a writeback.",
@@ -16,6 +18,7 @@
     },
     {
         "BriefDescription": "Cycles code-fetch stalled due to an outstandi=
ng ICache miss.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ICACHE_FILL_PENDING_CYCLES",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ICache miss. That is, the decoder queue is able to accept byt=
es, but the fetch unit is unable to provide bytes due to an ICache miss.  N=
ote: this event is not the same as the total number of cycles spent retriev=
ing instruction cache lines from the memory hierarchy.",
@@ -24,6 +27,7 @@
     },
     {
         "BriefDescription": "Requests rejected by the XQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_XQ.ALL",
         "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the L2 XQ rejects due to a full or near full condition which=
 likely indicates back pressure from the intra-die interconnect (IDI) fabri=
c. The XQ may reject transactions from the L2Q (non-cacheable requests), L2=
 misses and L2 write-back victims.",
@@ -31,6 +35,7 @@
     },
     {
         "BriefDescription": "L2 cache request misses",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PublicDescription": "Counts memory requests originating from the =
core that miss in the L2 cache.",
@@ -39,6 +44,7 @@
     },
     {
         "BriefDescription": "L2 cache requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "Counts memory requests originating from the =
core that reference a cache line in the L2 cache.",
@@ -47,6 +53,7 @@
     },
     {
         "BriefDescription": "Loads retired that came from DRAM (Precise ev=
ent capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
@@ -57,6 +64,7 @@
     },
     {
         "BriefDescription": "Memory uop retired where cross core or cross =
module HITM occurred (Precise event capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HITM",
@@ -67,6 +75,7 @@
     },
     {
         "BriefDescription": "Load uops retired that hit L1 data cache (Pre=
cise event capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
@@ -77,6 +86,7 @@
     },
     {
         "BriefDescription": "Load uops retired that missed L1 data cache (=
Precise event capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
@@ -87,6 +97,7 @@
     },
     {
         "BriefDescription": "Load uops retired that hit L2 (Precise event =
capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
@@ -97,6 +108,7 @@
     },
     {
         "BriefDescription": "Load uops retired that missed L2 (Precise eve=
nt capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
@@ -107,6 +119,7 @@
     },
     {
         "BriefDescription": "Loads retired that hit WCB (Precise event cap=
able)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.WCB_HIT",
@@ -117,6 +130,7 @@
     },
     {
         "BriefDescription": "Memory uops retired (Precise event capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL",
@@ -127,6 +141,7 @@
     },
     {
         "BriefDescription": "Load uops retired (Precise event capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
@@ -137,6 +152,7 @@
     },
     {
         "BriefDescription": "Store uops retired (Precise event capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
@@ -147,6 +163,7 @@
     },
     {
         "BriefDescription": "Locked load uops retired (Precise event capab=
le)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
@@ -157,6 +174,7 @@
     },
     {
         "BriefDescription": "Memory uops retired that split a cache-line (=
Precise event capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT",
@@ -167,6 +185,7 @@
     },
     {
         "BriefDescription": "Load uops retired that split a cache-line (Pr=
ecise event capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
@@ -177,6 +196,7 @@
     },
     {
         "BriefDescription": "Stores uops retired that split a cache-line (=
Precise event capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
@@ -187,6 +207,7 @@
     },
     {
         "BriefDescription": "Requires MSR_OFFCORE_RESP[0,1] to specify req=
uest type and response. (duplicated for both MSRs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE",
         "SampleAfterValue": "100007",
@@ -194,6 +215,7 @@
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) have an=
y transaction responses from the uncore subsystem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -204,6 +226,7 @@
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) hit the=
 L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -214,6 +237,7 @@
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) miss th=
e L2 cache with a snoop hit in the other processor module, data forwarding =
is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -224,6 +248,7 @@
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) true mi=
ss for the L2 cache with a snoop miss in the other processor module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.SNOOP_MISS_OR_N=
O_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -234,6 +259,7 @@
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) outstan=
ding, per cycle, from the time of the L2 miss to when any response is recei=
ved.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -244,6 +270,7 @@
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers have any transaction responses from the uncore subsystem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -254,6 +281,7 @@
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers hit the L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -264,6 +292,7 @@
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers miss the L2 cache with a snoop hit in the other processor module, da=
ta forwarding is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.L2_MISS.HITM_OTHER_C=
ORE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -274,6 +303,7 @@
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers true miss for the L2 cache with a snoop miss in the other processor =
module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.L2_MISS.SNOOP_MISS_O=
R_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -284,6 +314,7 @@
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers outstanding, per cycle, from the time of the L2 miss to when any res=
ponse is received.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -294,6 +325,7 @@
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) have any transaction responses fr=
om the uncore subsystem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -304,6 +336,7 @@
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) hit the L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -314,6 +347,7 @@
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) miss the L2 cache with a snoop hi=
t in the other processor module, data forwarding is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -324,6 +358,7 @@
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) true miss for the L2 cache with a=
 snoop miss in the other processor module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_MISS.SNOOP_MISS_OR_NO_S=
NOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -334,6 +369,7 @@
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) outstanding, per cycle, from the =
time of the L2 miss to when any response is received.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -344,6 +380,7 @@
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem have =
any transaction responses from the uncore subsystem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -354,6 +391,7 @@
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem hit t=
he L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -364,6 +402,7 @@
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem miss =
the L2 cache with a snoop hit in the other processor module, data forwardin=
g is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -374,6 +413,7 @@
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem true =
miss for the L2 cache with a snoop miss in the other processor module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS.SNOOP_MISS_OR_N=
O_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -384,6 +424,7 @@
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem outst=
anding, per cycle, from the time of the L2 miss to when any response is rec=
eived.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -394,6 +435,7 @@
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) have any transaction responses from the uncore subsystem."=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -404,6 +446,7 @@
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) hit the L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -414,6 +457,7 @@
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) miss the L2 cache with a snoop hit in the other processor =
module, data forwarding is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -424,6 +468,7 @@
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) true miss for the L2 cache with a snoop miss in the other =
processor module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.SNOOP_MISS_OR_NO_SN=
OOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -434,6 +479,7 @@
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) outstanding, per cycle, from the time of the L2 miss to wh=
en any response is received.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -444,6 +490,7 @@
     },
     {
         "BriefDescription": "Counts bus lock and split lock requests have =
any transaction responses from the uncore subsystem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -454,6 +501,7 @@
     },
     {
         "BriefDescription": "Counts bus lock and split lock requests hit t=
he L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -464,6 +512,7 @@
     },
     {
         "BriefDescription": "Counts bus lock and split lock requests miss =
the L2 cache with a snoop hit in the other processor module, data forwardin=
g is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -474,6 +523,7 @@
     },
     {
         "BriefDescription": "Counts bus lock and split lock requests true =
miss for the L2 cache with a snoop miss in the other processor module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_MISS.SNOOP_MISS_OR_NO_=
SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -484,6 +534,7 @@
     },
     {
         "BriefDescription": "Counts bus lock and split lock requests outst=
anding, per cycle, from the time of the L2 miss to when any response is rec=
eived.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -494,6 +545,7 @@
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions have any transaction responses from the u=
ncore subsystem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -504,6 +556,7 @@
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions hit the L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -514,6 +567,7 @@
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions miss the L2 cache with a snoop hit in the=
 other processor module, data forwarding is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -524,6 +578,7 @@
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions true miss for the L2 cache with a snoop m=
iss in the other processor module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_MISS.SNOOP_MISS_OR_NO_SNO=
OP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -534,6 +589,7 @@
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions outstanding, per cycle, from the time of =
the L2 miss to when any response is received.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -544,6 +600,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache have any transaction re=
sponses from the uncore subsystem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -554,6 +611,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache hit the L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -564,6 +622,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache miss the L2 cache with =
a snoop hit in the other processor module, data forwarding is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_MISS.HITM_OTHER_C=
ORE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -574,6 +633,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache true miss for the L2 ca=
che with a snoop miss in the other processor module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_MISS.SNOOP_MISS_O=
R_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -584,6 +644,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache outstanding, per cycle,=
 from the time of the L2 miss to when any response is received.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -594,6 +655,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines have any transaction responses from the uncore subsystem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -604,6 +666,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines hit the L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -614,6 +677,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines miss the L2 cache with a snoop hit in the other processor module,=
 data forwarding is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.HITM_OTHER_C=
ORE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -624,6 +688,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines true miss for the L2 cache with a snoop miss in the other process=
or module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.SNOOP_MISS_O=
R_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -634,6 +699,7 @@
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines outstanding, per cycle, from the time of the L2 miss to when any =
response is received.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -644,6 +710,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line have any transaction respo=
nses from the uncore subsystem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -654,6 +721,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line hit the L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -664,6 +732,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line miss the L2 cache with a s=
noop hit in the other processor module, data forwarding is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.HITM_OTHER_CORE"=
,
         "MSRIndex": "0x1a6, 0x1a7",
@@ -674,6 +743,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line true miss for the L2 cache=
 with a snoop miss in the other processor module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.SNOOP_MISS_OR_NO=
_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -684,6 +754,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line outstanding, per cycle, fr=
om the time of the L2 miss to when any response is received.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -694,6 +765,7 @@
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes have any transaction responses from the uncore subsystem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6, 0x1a7",
@@ -704,6 +776,7 @@
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes hit the L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -714,6 +787,7 @@
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes miss the L2 cache with a snoop hit in the other processor module, da=
ta forwarding is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.L2_MISS.HITM_=
OTHER_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -724,6 +798,7 @@
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes true miss for the L2 cache with a snoop miss in the other processor =
module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.L2_MISS.SNOOP=
_MISS_OR_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -734,6 +809,7 @@
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes outstanding, per cycle, from the time of the L2 miss to when any res=
ponse is received.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -744,6 +820,7 @@
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher have any transaction responses from the unco=
re subsystem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -754,6 +831,7 @@
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher hit the L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -764,6 +842,7 @@
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher miss the L2 cache with a snoop hit in the ot=
her processor module, data forwarding is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -774,6 +853,7 @@
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher true miss for the L2 cache with a snoop miss=
 in the other processor module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.SNOOP_MISS_OR=
_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -784,6 +864,7 @@
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher outstanding, per cycle, from the time of the=
 L2 miss to when any response is received.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -794,6 +875,7 @@
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher have any transaction responses from the uncore sub=
system.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -804,6 +886,7 @@
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher hit the L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -814,6 +897,7 @@
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher miss the L2 cache with a snoop hit in the other pr=
ocessor module, data forwarding is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -824,6 +908,7 @@
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher true miss for the L2 cache with a snoop miss in th=
e other processor module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.SNOOP_MISS_OR=
_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -834,6 +919,7 @@
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher outstanding, per cycle, from the time of the L2 mi=
ss to when any response is received.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -844,6 +930,7 @@
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher have any transaction responses from the uncore subs=
ystem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -854,6 +941,7 @@
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher hit the L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -864,6 +952,7 @@
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher miss the L2 cache with a snoop hit in the other pro=
cessor module, data forwarding is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -874,6 +963,7 @@
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher true miss for the L2 cache with a snoop miss in the=
 other processor module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.SNOOP_MISS_OR_NO_=
SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -884,6 +974,7 @@
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher outstanding, per cycle, from the time of the L2 mis=
s to when any response is received.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -894,6 +985,7 @@
     },
     {
         "BriefDescription": "Counts any data writes to uncacheable write c=
ombining (USWC) memory region  have any transaction responses from the unco=
re subsystem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -904,6 +996,7 @@
     },
     {
         "BriefDescription": "Counts any data writes to uncacheable write c=
ombining (USWC) memory region  hit the L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -914,6 +1007,7 @@
     },
     {
         "BriefDescription": "Counts any data writes to uncacheable write c=
ombining (USWC) memory region  miss the L2 cache with a snoop hit in the ot=
her processor module, data forwarding is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.L2_MISS.HITM_OTHER=
_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -924,6 +1018,7 @@
     },
     {
         "BriefDescription": "Counts any data writes to uncacheable write c=
ombining (USWC) memory region  true miss for the L2 cache with a snoop miss=
 in the other processor module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.L2_MISS.SNOOP_MISS=
_OR_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -934,6 +1029,7 @@
     },
     {
         "BriefDescription": "Counts any data writes to uncacheable write c=
ombining (USWC) memory region  outstanding, per cycle, from the time of the=
 L2 miss to when any response is received.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -944,6 +1040,7 @@
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions have any transaction responses from the uncore subsys=
tem.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -954,6 +1051,7 @@
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions hit the L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -964,6 +1062,7 @@
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions miss the L2 cache with a snoop hit in the other proce=
ssor module, data forwarding is required.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -974,6 +1073,7 @@
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions true miss for the L2 cache with a snoop miss in the o=
ther processor module.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.L2_MISS.SNOOP_MISS_OR_N=
O_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
@@ -984,6 +1084,7 @@
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions outstanding, per cycle, from the time of the L2 miss =
to when any response is received.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.OUTSTANDING",
         "MSRIndex": "0x1a6",
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/counter.json b/too=
ls/perf/pmu-events/arch/x86/goldmontplus/counter.json
new file mode 100644
index 000000000000..aa443347b694
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/counter.json
@@ -0,0 +1,7 @@
+[
+    {
+        "Unit": "core",
+        "CountersNumFixed": "3",
+        "CountersNumGeneric": "4"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.jso=
n b/tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.json
index 822a7a6bcaeb..3d06ac1ee0cf 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Cycles the FP divide unit is busy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCD",
         "EventName": "CYCLES_DIV_BUSY.FPDIV",
         "PublicDescription": "Counts core cycles the floating point divide=
 unit is busy.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Machine clears due to FP assists",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.FP_ASSIST",
         "PublicDescription": "Counts machine clears due to floating point =
(FP) operations needing assists.  For instance, if the result was a floatin=
g point denormal, the hardware clears the pipeline and reissues uops to pro=
duce the correct IEEE compliant denormal result.",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Floating point divide uops retired (Precise E=
vent Capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.FPDIV",
         "PEBS": "2",
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json b/to=
ols/perf/pmu-events/arch/x86/goldmontplus/frontend.json
index ace2a114b546..249a97cf3f4c 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "BACLEARs asserted for any branch type",
+        "Counter": "0,1,2,3",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.ALL",
         "PublicDescription": "Counts the number of times a BACLEAR is sign=
aled for any reason, including, but not limited to indirect branch/call,  J=
cc (Jump on Conditional Code/Jump if Condition is Met) branch, unconditiona=
l branch/call, and returns.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "BACLEARs asserted for conditional branch",
+        "Counter": "0,1,2,3",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.COND",
         "PublicDescription": "Counts BACLEARS on Jcc (Jump on Conditional =
Code/Jump if Condition is Met) branches.",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "BACLEARs asserted for return branch",
+        "Counter": "0,1,2,3",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.RETURN",
         "PublicDescription": "Counts BACLEARS on return instructions.",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Decode restrictions due to predicting wrong i=
nstruction length",
+        "Counter": "0,1,2,3",
         "EventCode": "0xE9",
         "EventName": "DECODE_RESTRICTION.PREDECODE_WRONG",
         "PublicDescription": "Counts the number of times the prediction (f=
rom the predecode cache) for instruction length is incorrect.",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "References per ICache line. This event counts=
 differently than Intel processors based on Silvermont microarchitecture",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
         "PublicDescription": "Counts requests to the Instruction Cache (IC=
ache) for one or more bytes in an ICache Line.  The event strives to count =
on a cache line basis, so that multiple fetches to a single cache line coun=
t as one ICACHE.ACCESS.  Specifically, the event counts when accesses from =
straight line code crosses the cache line boundary, or when a branch target=
 is to a new line.\r\nThis event counts differently than Intel processors b=
ased on Silvermont microarchitecture.",
@@ -41,6 +46,7 @@
     },
     {
         "BriefDescription": "References per ICache line that are available=
 in the ICache (hit). This event counts differently than Intel processors b=
ased on Silvermont microarchitecture",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.HIT",
         "PublicDescription": "Counts requests to the Instruction Cache (IC=
ache) for one or more bytes in an ICache Line and that cache line is in the=
 ICache (hit).  The event strives to count on a cache line basis, so that m=
ultiple accesses which hit in a single cache line count as one ICACHE.HIT. =
 Specifically, the event counts when straight line code crosses the cache l=
ine boundary, or when a branch target is to a new line, and that cache line=
 is in the ICache. This event counts differently than Intel processors base=
d on Silvermont microarchitecture.",
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "References per ICache line that are not avail=
able in the ICache (miss). This event counts differently than Intel process=
ors based on Silvermont microarchitecture",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "PublicDescription": "Counts requests to the Instruction Cache (IC=
ache)  for one or more bytes in an ICache Line and that cache line is not i=
n the ICache (miss).  The event strives to count on a cache line basis, so =
that multiple accesses which miss in a single cache line count as one ICACH=
E.MISS.  Specifically, the event counts when straight line code crosses the=
 cache line boundary, or when a branch target is to a new line, and that ca=
che line is not in the ICache. This event counts differently than Intel pro=
cessors based on Silvermont microarchitecture.",
@@ -57,6 +64,7 @@
     },
     {
         "BriefDescription": "MS decode starts",
+        "Counter": "0,1,2,3",
         "EventCode": "0xE7",
         "EventName": "MS_DECODED.MS_ENTRY",
         "PublicDescription": "Counts the number of times the Microcode Seq=
uencer (MS) starts a flow of uops from the MSROM. It does not count every t=
ime a uop is read from the MSROM.  The most common case that this counts is=
 when a micro-coded instruction is encountered by the front end of the mach=
ine.  Other cases include when an instruction encounters a fault, trap, or =
microcode assist of any sort that initiates a flow of uops.  The event will=
 count MS startups for uops that are speculative, and subsequently cleared =
by branch mispredict or a machine clear.",
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/memory.json b/tool=
s/perf/pmu-events/arch/x86/goldmontplus/memory.json
index 7038873a5c8d..72bc2155ed00 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Machine clears due to memory ordering issue",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "PublicDescription": "Counts machine clears due to memory ordering=
 issues.  This occurs when a snoop request happens and the machine is uncer=
tain if memory ordering will be preserved - as another core is in the proce=
ss of modifying the data.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Load uops that split a page (Precise event ca=
pable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "MISALIGN_MEM_REF.LOAD_PAGE_SPLIT",
         "PEBS": "2",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "Store uops that split a page (Precise event c=
apable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "MISALIGN_MEM_REF.STORE_PAGE_SPLIT",
         "PEBS": "2",
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/other.json b/tools=
/perf/pmu-events/arch/x86/goldmontplus/other.json
index ec0ce9078c98..96bbc4fc82a1 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/other.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/other.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Cycles code-fetch stalled due to any reason."=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ALL",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
ny reason. That is, the decoder queue is able to accept bytes, but the fetc=
h unit is unable to provide bytes.  This will include cycles due to an ITLB=
 miss, ICache miss and other events.",
@@ -8,6 +9,7 @@
     },
     {
         "BriefDescription": "Cycles the code-fetch stalls and an ITLB miss=
 is outstanding.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ITLB_FILL_PENDING_CYCLES",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ITLB miss. That is, the decoder queue is able to accept bytes=
, but the fetch unit is unable to provide bytes due to an ITLB miss.  Note:=
 this event is not the same as page walk cycles to retrieve an instruction =
translation.",
@@ -16,6 +18,7 @@
     },
     {
         "BriefDescription": "Cycles hardware interrupts are masked",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "HW_INTERRUPTS.MASKED",
         "PublicDescription": "Counts the number of core cycles during whic=
h interrupts are masked (disabled). Increments by 1 each core cycle that EF=
LAGS.IF is 0, regardless of whether interrupts are pending or not.",
@@ -24,6 +27,7 @@
     },
     {
         "BriefDescription": "Cycles pending interrupts are masked",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "HW_INTERRUPTS.PENDING_AND_MASKED",
         "PublicDescription": "Counts core cycles during which there are pe=
nding interrupts, but interrupts are masked (EFLAGS.IF =3D 0).",
@@ -32,6 +36,7 @@
     },
     {
         "BriefDescription": "Hardware interrupts received",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "HW_INTERRUPTS.RECEIVED",
         "PublicDescription": "Counts hardware interrupts received by the p=
rocessor.",
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
index 33ef331e77e0..8cbf253d0c30 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Retired branch instructions (Precise event ca=
pable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "2",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Retired taken branch instructions (Precise ev=
ent capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_TAKEN_BRANCHES",
         "PEBS": "2",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "Retired near call instructions (Precise event=
 capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CALL",
         "PEBS": "2",
@@ -27,6 +30,7 @@
     },
     {
         "BriefDescription": "Retired far branch instructions (Precise even=
t capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "2",
@@ -36,6 +40,7 @@
     },
     {
         "BriefDescription": "Retired near indirect call instructions (Prec=
ise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
         "PEBS": "2",
@@ -45,6 +50,7 @@
     },
     {
         "BriefDescription": "Retired conditional branch instructions (Prec=
ise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.JCC",
         "PEBS": "2",
@@ -54,6 +60,7 @@
     },
     {
         "BriefDescription": "Retired instructions of near indirect Jmp or =
call (Precise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
         "PEBS": "2",
@@ -63,6 +70,7 @@
     },
     {
         "BriefDescription": "Retired near relative call instructions (Prec=
ise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
         "PEBS": "2",
@@ -72,6 +80,7 @@
     },
     {
         "BriefDescription": "Retired near return instructions (Precise eve=
nt capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.RETURN",
         "PEBS": "2",
@@ -81,6 +90,7 @@
     },
     {
         "BriefDescription": "Retired conditional branch instructions that =
were taken (Precise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
         "PEBS": "2",
@@ -90,6 +100,7 @@
     },
     {
         "BriefDescription": "Retired mispredicted branch instructions (Pre=
cise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "2",
@@ -98,6 +109,7 @@
     },
     {
         "BriefDescription": "Retired mispredicted near indirect call instr=
uctions (Precise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
         "PEBS": "2",
@@ -107,6 +119,7 @@
     },
     {
         "BriefDescription": "Retired mispredicted conditional branch instr=
uctions (Precise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.JCC",
         "PEBS": "2",
@@ -116,6 +129,7 @@
     },
     {
         "BriefDescription": "Retired mispredicted instructions of near ind=
irect Jmp or near indirect call (Precise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
         "PEBS": "2",
@@ -125,6 +139,7 @@
     },
     {
         "BriefDescription": "Retired mispredicted near return instructions=
 (Precise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.RETURN",
         "PEBS": "2",
@@ -134,6 +149,7 @@
     },
     {
         "BriefDescription": "Retired mispredicted conditional branch instr=
uctions that were taken (Precise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
         "PEBS": "2",
@@ -143,6 +159,7 @@
     },
     {
         "BriefDescription": "Core cycles when core is not halted  (Fixed e=
vent)",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state.  The core enters the halt state when it is runn=
ing the HLT instruction. In mobile systems the core frequency may change fr=
om time to time. For this reason this event may have a changing ratio with =
regards to time.  This event uses fixed counter 1.  You cannot collect a PE=
Bs record for this event.",
         "SampleAfterValue": "2000003",
@@ -150,6 +167,7 @@
     },
     {
         "BriefDescription": "Core cycles when core is not halted",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
         "PublicDescription": "Core cycles when core is not halted.  This e=
vent uses a (_P)rogrammable general purpose performance counter.",
@@ -157,6 +175,7 @@
     },
     {
         "BriefDescription": "Reference cycles when core is not halted",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF",
         "PublicDescription": "Reference cycles when core is not halted.  T=
his event uses a (_P)rogrammable general purpose performance counter.",
@@ -165,6 +184,7 @@
     },
     {
         "BriefDescription": "Reference cycles when core is not halted  (Fi=
xed event)",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction.  In mobile systems the core frequency may chang=
e from time.  This event is not affected by core frequency changes but coun=
ts as if the core is running at the maximum frequency all the time.  This e=
vent uses fixed counter 2.  You cannot collect a PEBs record for this event=
.",
         "SampleAfterValue": "2000003",
@@ -172,6 +192,7 @@
     },
     {
         "BriefDescription": "Cycles a divider is busy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCD",
         "EventName": "CYCLES_DIV_BUSY.ALL",
         "PublicDescription": "Counts core cycles if either divide unit is =
busy.",
@@ -179,6 +200,7 @@
     },
     {
         "BriefDescription": "Cycles the integer divide unit is busy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCD",
         "EventName": "CYCLES_DIV_BUSY.IDIV",
         "PublicDescription": "Counts core cycles the integer divide unit i=
s busy.",
@@ -187,6 +209,7 @@
     },
     {
         "BriefDescription": "Instructions retired (Fixed event)",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "2",
         "PublicDescription": "Counts the number of instructions that retir=
e execution. For instructions that consist of multiple uops, this event cou=
nts the retirement of the last uop of the instruction. The counter continue=
s counting during hardware interrupts, traps, and inside interrupt handlers=
.  This event uses fixed counter 0.  You cannot collect a PEBs record for t=
his event.",
@@ -195,6 +218,7 @@
     },
     {
         "BriefDescription": "Instructions retired (Precise event capable)"=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "2",
@@ -203,6 +227,7 @@
     },
     {
         "BriefDescription": "Instructions retired - using Reduced Skid PEB=
S feature",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "2",
@@ -211,6 +236,7 @@
     },
     {
         "BriefDescription": "Unfilled issue slots per cycle",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCA",
         "EventName": "ISSUE_SLOTS_NOT_CONSUMED.ANY",
         "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend due to either a full resource  in=
 the backend (RESOURCE_FULL) or due to the processor recovering from some e=
vent (RECOVERY).",
@@ -218,6 +244,7 @@
     },
     {
         "BriefDescription": "Unfilled issue slots per cycle to recover",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCA",
         "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RECOVERY",
         "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend because allocation is stalled wai=
ting for a mispredicted jump to retire or other branch-like conditions (e.g=
. the event is relevant during certain microcode flows).   Counts all issue=
 slots blocked while within this window including slots where uops were not=
 available in the Instruction Queue.",
@@ -226,6 +253,7 @@
     },
     {
         "BriefDescription": "Unfilled issue slots per cycle because of a f=
ull resource in the backend",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCA",
         "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RESOURCE_FULL",
         "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed because of a full resource in the backend.  Incl=
uding but not limited to resources such as the Re-order Buffer (ROB), reser=
vation stations (RS), load/store buffers, physical registers, or any other =
needed machine resource that is currently unavailable.   Note that uops mus=
t be available for consumption in order for this event to fire.  If a uop i=
s not available (Instruction Queue is empty), this event will not count.",
@@ -234,6 +262,7 @@
     },
     {
         "BriefDescription": "Loads blocked because address has 4k partial =
address false dependence (Precise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.4K_ALIAS",
         "PEBS": "2",
@@ -243,6 +272,7 @@
     },
     {
         "BriefDescription": "Loads blocked (Precise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ALL_BLOCK",
         "PEBS": "2",
@@ -252,6 +282,7 @@
     },
     {
         "BriefDescription": "Loads blocked due to store data not ready (Pr=
ecise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DATA_UNKNOWN",
         "PEBS": "2",
@@ -261,6 +292,7 @@
     },
     {
         "BriefDescription": "Loads blocked due to store forward restrictio=
n (Precise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PEBS": "2",
@@ -270,6 +302,7 @@
     },
     {
         "BriefDescription": "Loads blocked because address in not in the U=
TLB (Precise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.UTLB_MISS",
         "PEBS": "2",
@@ -279,6 +312,7 @@
     },
     {
         "BriefDescription": "All machine clears",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.ALL",
         "PublicDescription": "Counts machine clears for any reason.",
@@ -286,6 +320,7 @@
     },
     {
         "BriefDescription": "Machine clears due to memory disambiguation",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
         "PublicDescription": "Counts machine clears due to memory disambig=
uation.  Memory disambiguation happens when a load which has been issued co=
nflicts with a previous unretired store in the pipeline whose address was n=
ot known at issue time, but is later resolved to be the same as the load ad=
dress.",
@@ -294,6 +329,7 @@
     },
     {
         "BriefDescription": "Machines clear due to a page fault",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.PAGE_FAULT",
         "PublicDescription": "Counts the number of times that the machines=
 clears due to a page fault. Covers both I-side and D-side(Loads/Stores) pa=
ge faults. A page fault occurs when either page is not present, or an acces=
s violation",
@@ -302,6 +338,7 @@
     },
     {
         "BriefDescription": "Self-Modifying Code detected",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "PublicDescription": "Counts the number of times that the processo=
r detects that a program is writing to a code section and has to perform a =
machine clear because of that modification.  Self-modifying code (SMC) caus=
es a severe penalty in all Intel(R) architecture processors.",
@@ -310,6 +347,7 @@
     },
     {
         "BriefDescription": "Uops issued to the back end per cycle",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.ANY",
         "PublicDescription": "Counts uops issued by the front end and allo=
cated into the back end of the machine.  This event counts uops that retire=
 as well as uops that were speculatively executed but didn't retire. The so=
rt of speculative uops that might be counted includes, but is not limited t=
o those uops issued in the shadow of a miss-predicted branch, those uops th=
at are inserted during an assist (such as for a denormal floating point res=
ult), and (previously allocated) uops that might be canceled during a machi=
ne clear.",
@@ -317,6 +355,7 @@
     },
     {
         "BriefDescription": "Uops requested but not-delivered to the back-=
end per cycle",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UOPS_NOT_DELIVERED.ANY",
         "PublicDescription": "This event used to measure front-end ineffic=
iencies. I.e. when front-end of the machine is not delivering uops to the b=
ack-end and the back-end has is not stalled. This event can be used to iden=
tify if the machine is truly front-end bound.  When this event occurs, it i=
s an indication that the front-end of the machine is operating at less than=
 its theoretical peak performance. Background: We can think of the processo=
r pipeline as being divided into 2 broader parts: Front-end and Back-end. F=
ront-end is responsible for fetching the instruction, decoding into uops in=
 machine understandable format and putting them into a uop queue to be cons=
umed by back end. The back-end then takes these uops, allocates the require=
d resources.  When all resources are ready, uops are executed. If the back-=
end is not ready to accept uops from the front-end, then we do not want to =
count these as front-end bottlenecks.  However, whenever we have bottleneck=
s in the back-end, we will have allocation unit stalls and eventually forci=
ng the front-end to wait until the back-end is ready to receive more uops. =
This event counts only when back-end is requesting more uops and front-end =
is not able to provide them. When 3 uops are requested and no uops are deli=
vered, the event counts 3. When 3 are requested, and only 1 is delivered, t=
he event counts 2. When only 2 are delivered, the event counts 1. Alternati=
vely stated, the event will not count if 3 uops are delivered, or if the ba=
ck end is stalled and not requesting any uops at all.  Counts indicate miss=
ed opportunities for the front-end to deliver a uop to the back end. Some e=
xamples of conditions that cause front-end efficiencies are: ICache misses,=
 ITLB misses, and decoder restrictions that limit the front-end bandwidth. =
Known Issues: Some uops require multiple allocation slots.  These uops will=
 not be charged as a front end 'not delivered' opportunity, and will be reg=
arded as a back end problem. For example, the INC instruction has one uop t=
hat requires 2 issue slots.  A stream of INC instructions will not count as=
 UOPS_NOT_DELIVERED, even though only one instruction can be issued per clo=
ck.  The low uop issue rate for a stream of INC instructions is considered =
to be a back end issue.",
@@ -324,6 +363,7 @@
     },
     {
         "BriefDescription": "Uops retired (Precise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ANY",
         "PEBS": "2",
@@ -332,6 +372,7 @@
     },
     {
         "BriefDescription": "Integer divide uops retired (Precise Event Ca=
pable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.IDIV",
         "PEBS": "2",
@@ -341,6 +382,7 @@
     },
     {
         "BriefDescription": "MS uops retired (Precise event capable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.MS",
         "PEBS": "2",
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.jso=
n b/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
index 3d6feb45a50b..09208af2e0ba 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Page walk completed due to a demand load to a=
 1GB page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1GB",
         "PublicDescription": "Counts page walks completed due to demand da=
ta loads (including SW prefetches) whose address translations missed in all=
 TLB levels and were mapped to 1GB pages.  The page walks can end with or w=
ithout a page fault.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to a demand load to a=
 2M or 4M page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts page walks completed due to demand da=
ta loads (including SW prefetches) whose address translations missed in all=
 TLB levels and were mapped to 2M or 4M pages.  The page walks can end with=
 or without a page fault.",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to a demand load to a=
 4K page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts page walks completed due to demand da=
ta loads (including SW prefetches) whose address translations missed in all=
 TLB levels and were mapped to 4K pages.  The page walks can end with or wi=
thout a page fault.",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Page walks outstanding due to a demand load e=
very cycle.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
         "PublicDescription": "Counts once per cycle for each page walk occ=
urring due to a load (demand data loads or SW prefetches). Includes cycles =
spent traversing the Extended Page Table (EPT). Average cycles per walk can=
 be calculated by dividing by the number of walks.",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to a demand data stor=
e to a 1GB page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1GB",
         "PublicDescription": "Counts page walks completed due to demand da=
ta stores whose address translations missed in the TLB and were mapped to 1=
GB pages.  The page walks can end with or without a page fault.",
@@ -41,6 +46,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to a demand data stor=
e to a 2M or 4M page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts page walks completed due to demand da=
ta stores whose address translations missed in the TLB and were mapped to 2=
M or 4M pages.  The page walks can end with or without a page fault.",
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to a demand data stor=
e to a 4K page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts page walks completed due to demand da=
ta stores whose address translations missed in the TLB and were mapped to 4=
K pages.  The page walks can end with or without a page fault.",
@@ -57,6 +64,7 @@
     },
     {
         "BriefDescription": "Page walks outstanding due to a demand data s=
tore every cycle.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
         "PublicDescription": "Counts once per cycle for each page walk occ=
urring due to a demand data store. Includes cycles spent traversing the Ext=
ended Page Table (EPT). Average cycles per walk can be calculated by dividi=
ng by the number of walks.",
@@ -65,6 +73,7 @@
     },
     {
         "BriefDescription": "Page walks outstanding due to walking the EPT=
 every cycle",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4F",
         "EventName": "EPT.WALK_PENDING",
         "PublicDescription": "Counts once per cycle for each page walk onl=
y while traversing the Extended Page Table (EPT), and does not count during=
 the rest of the translation.  The EPT is used for translating Guest-Physic=
al Addresses to Physical Addresses for Virtual Machine Monitors (VMMs).  Av=
erage cycles per walk can be calculated by dividing the count by number of =
walks.",
@@ -73,6 +82,7 @@
     },
     {
         "BriefDescription": "ITLB misses",
+        "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "ITLB.MISS",
         "PublicDescription": "Counts the number of times the machine was u=
nable to find a translation in the Instruction Translation Lookaside Buffer=
 (ITLB) for a linear address of an instruction fetch.  It counts when new t=
ranslation are filled into the ITLB.  The event is speculative in nature, b=
ut will not count translations (page walks) that are begun and not finished=
, or translations that are finished but not filled into the ITLB.",
@@ -81,6 +91,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to an instruction fet=
ch in a 1GB page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_1GB",
         "PublicDescription": "Counts page walks completed due to instructi=
on fetches whose address translations missed in the TLB and were mapped to =
1GB pages.  The page walks can end with or without a page fault.",
@@ -89,6 +100,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to an instruction fet=
ch in a 2M or 4M page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts page walks completed due to instructi=
on fetches whose address translations missed in the TLB and were mapped to =
2M or 4M pages.  The page walks can end with or without a page fault.",
@@ -97,6 +109,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to an instruction fet=
ch in a 4K page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts page walks completed due to instructi=
on fetches whose address translations missed in the TLB and were mapped to =
4K pages.  The page walks can end with or without a page fault.",
@@ -105,6 +118,7 @@
     },
     {
         "BriefDescription": "Page walks outstanding due to an instruction =
fetch every cycle.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_PENDING",
         "PublicDescription": "Counts once per cycle for each page walk occ=
urring due to an instruction fetch. Includes cycles spent traversing the Ex=
tended Page Table (EPT). Average cycles per walk can be calculated by divid=
ing by the number of walks.",
@@ -113,6 +127,7 @@
     },
     {
         "BriefDescription": "Memory uops retired that missed the DTLB (Pre=
cise event capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS",
@@ -123,6 +138,7 @@
     },
     {
         "BriefDescription": "Load uops retired that missed the DTLB (Preci=
se event capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
@@ -133,6 +149,7 @@
     },
     {
         "BriefDescription": "Store uops retired that missed the DTLB (Prec=
ise event capable)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_STORES",
@@ -143,6 +160,7 @@
     },
     {
         "BriefDescription": "STLB flushes",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSHES.STLB_ANY",
         "PublicDescription": "Counts STLB flushes.  The TLBs are flushed o=
n instructions like INVLPG and MOV to CR3.",
--=20
2.45.2.627.g7a2c4fd464-goog

