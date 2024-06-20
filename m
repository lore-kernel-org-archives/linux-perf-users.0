Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77261B3F11
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907660; cv=none; b=XWHs64iIBRcWDQvhf6f79hFTYjrqR7vymIy1CM9i8eLQpQCTyPF4FVyD+T7CHhzb4TjwOjwB/7itQImttZ4Qem/nNIQA483+w6HWDCOPrxpWei5wC/sTcXOaKmhG6MCF1zddrMsz7hqJpdXliP1QlXX7eqr99LqERgqWa5fZixQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907660; c=relaxed/simple;
	bh=Vl0aCPY9814Daxm+0oew0wnpgDz3+3VH0a7A/BznG2A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=PerifCZeZAR26w3gGDZXIh2/HdgN84NqaXjmgD/+oOENU1zcNkxpQ5DJGzivHd91CnWGUybXf7aXDCwCnPEGjXlbGBgzyMoStZL2iOIPcySy4mNA8gBdtrBkwnoFVHk6s2QjmzgamKuixoXLqWZj/WfbWEYVjnReQlSvWbC0yTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCZ2IYOj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCZ2IYOj"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-632b6ff93e4so22452197b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718907584; x=1719512384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z9XuuaVhdaFPVEP964WVi0hjAt52TrxCnsExzkXT5w=;
        b=JCZ2IYOjYnu27xMduRKL1e6WdQRwfyYaIrSrj9FrBFOfSq/A3w6JrnlBqzxvs0f5Mm
         Q/u4vDApupyjNOuIzc8AC6bG8mL7b0V4IRkWzMDOVITDssonml/ygrFhcR2JteGpXJrx
         o59YlozuKhF8hhlxNi+tAUfKsS/9Zgx137eKjbvn3GVh1ky5eHTqee+ysywabjJ0OJSo
         0FAPzkr7EAgYjlMuVkvOPW/WvhKy8itk2MEZ4/SSA7fjIlDKCuvOaEkdQ+Vm24RnreJK
         oB6Z0WpC+779KhSpiP1+hSa6g6d+uOD0fRWOjrLm41JEL+TY7J7Iiqlmi6SLyIdiKFP+
         9SJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907584; x=1719512384;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Z9XuuaVhdaFPVEP964WVi0hjAt52TrxCnsExzkXT5w=;
        b=Y5CP28ZhBGD929JQTum1Hr4+P8wCb1b2WMWGiupHSlwAMX70leHDi82DWEyizo2ffZ
         GOqwGr5+dLExQq2siMIWbALti6W/g3NOwZzACGY9tETlY3UcTCK/L7gPR3kSCzHedhhI
         au5RkHkzhr3W7787EMeTGT/lr514ZN0DypyuJjeqXtFlo/I4MFsjAvmRxBCaI0h1PV9a
         kfOpM8i7cZ9EYpH4OpLNGIDX8H+QE2O3sLMXGe05AgtzrthA5q2+/EVGaiW/+6Mpu1Os
         rEbpYpDtlBdjAGPaTZDCJyvZL/kjVPZ9DyMa3KhhBXARNETnjdoE+PVFss58U1x/e2JJ
         kJkg==
X-Forwarded-Encrypted: i=1; AJvYcCW+bwalzRKjGUuQKR+LrpsS4soy3LzV0bwRDQhD36O025GG2SsU1ZbEV9jVHJjhnzPvhLAvK6WRG8/YoL1NbzY9wn9PUfiv4d6cPYfeztGOcg==
X-Gm-Message-State: AOJu0YzE8s1TPW0JOoXn5MYBy5dB2uKYnILoe5v+TCOFsmVHiNs4Sbu5
	JPco1ou8harYmxcunCUnYk9Fqstr0I1UwF2JjosZ7KTqjeed6E+JkPwYhoi8RkWOOAtgK2kppHl
	JfOB9zg==
X-Google-Smtp-Source: AGHT+IE/n8JzXpnNxTp+9nSqb41ehM0yYW7LR0w3iKBayUlhdOqA4TElJd6VjHYzUcEOpbSTL6qmLASec0Oo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a6b7:dc01:68ba:649])
 (user=irogers job=sendgmr) by 2002:a05:690c:ec9:b0:62f:f535:f2c with SMTP id
 00721157ae682-63a8d82cbe5mr19524317b3.2.1718907584368; Thu, 20 Jun 2024
 11:19:44 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:17:27 -0700
In-Reply-To: <20240620181752.3945845-1-irogers@google.com>
Message-Id: <20240620181752.3945845-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240620181752.3945845-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v2 13/37] perf vendor events: Update graniterapids events and
 add counter information
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

Update events from v1.01 to v1.02.

Bring in the event updates v1.02:
https://github.com/intel/perfmon/commit/0ff9f681bd07d0e84026c52f4941d21b1cd=
4c171

Add counter information. The most recent RFC patch set using this
information:
https://lore.kernel.org/lkml/20240412210756.309828-1-weilin.wang@intel.com/

There are over 1000 new events.

Co-authored-by: Weilin Wang <weilin.wang@intel.com>
Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../arch/x86/graniterapids/cache.json         |  825 ++++
 .../arch/x86/graniterapids/counter.json       |   77 +
 .../x86/graniterapids/floating-point.json     |  242 ++
 .../arch/x86/graniterapids/frontend.json      |  469 ++-
 .../arch/x86/graniterapids/memory.json        |  175 +-
 .../arch/x86/graniterapids/other.json         |  150 +-
 .../arch/x86/graniterapids/pipeline.json      | 1009 ++++-
 .../arch/x86/graniterapids/uncore-cache.json  | 3674 +++++++++++++++++
 .../arch/x86/graniterapids/uncore-cxl.json    |   31 +
 .../graniterapids/uncore-interconnect.json    | 1849 +++++++++
 .../arch/x86/graniterapids/uncore-io.json     | 1901 +++++++++
 .../arch/x86/graniterapids/uncore-memory.json |  449 ++
 .../arch/x86/graniterapids/uncore-power.json  |   11 +
 .../x86/graniterapids/virtual-memory.json     |  159 +
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 15 files changed, 10975 insertions(+), 48 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/counter.js=
on
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/floating-p=
oint.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-cac=
he.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-cxl=
.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-int=
erconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.=
json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-mem=
ory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-pow=
er.json

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json b/tool=
s/perf/pmu-events/arch/x86/graniterapids/cache.json
index 56212827870c..b56066274813 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
@@ -1,6 +1,135 @@
 [
+    {
+        "BriefDescription": "L1D.HWPF_MISS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "L1D.HWPF_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines replaced in =
L1 data cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "L1D.REPLACEMENT",
+        "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of cycles a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.FB_FULL",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of phases a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
+        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of cycles a demand request has waited =
due to L1D due to lack of L2 resources.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.L2_STALLS",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of L1D misses that are outstanding",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.PENDING",
+        "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles with L1D load Misses outstanding.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
+        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "L2 cache lines filling L2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.ALL",
+        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1f"
+    },
+    {
+        "BriefDescription": "Modified cache lines that are evicted by L2 c=
ache when triggered by an L2 cache fill.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.NON_SILENT",
+        "PublicDescription": "Counts the number of lines that are evicted =
by L2 cache when triggered by an L2 cache fill. Those lines are in Modified=
 state. Modified lines are written back to L3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache when triggered by an L2 cache fill.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.SILENT",
+        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache when triggered by an L2 cache fill. These lines are ty=
pically in Shared or Exclusive state. A non-threaded event.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cache lines that have been L2 hardware prefet=
ched but not used by demand accesses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.USELESS_HWPF",
+        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_RQSTS.REFERENCES]",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.ALL",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event i=
s alias to L2_RQSTS.HIT]",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This=
 event is alias to L2_RQSTS.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf"
+    },
+    {
+        "BriefDescription": "Read requests with true-miss in L2 cache [Thi=
s event is alias to L2_RQSTS.MISS]",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.MISS",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x3f"
+    },
     {
         "BriefDescription": "L2 code requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
         "PublicDescription": "Counts the total number of L2 code requests.=
",
@@ -9,14 +138,167 @@
     },
     {
         "BriefDescription": "Demand Data Read access L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
         "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
         "UMask": "0xe1"
     },
+    {
+        "BriefDescription": "Demand requests that miss L2 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
+        "PublicDescription": "Counts demand requests that miss L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x27"
+    },
+    {
+        "BriefDescription": "Demand requests to L2 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_DEMAND_REFERENCES",
+        "PublicDescription": "Counts demand requests to L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe7"
+    },
+    {
+        "BriefDescription": "L2_RQSTS.ALL_HWPF",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_HWPF",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf0"
+    },
+    {
+        "BriefDescription": "RFO requests to L2 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_RFO",
+        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe2"
+    },
+    {
+        "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.CODE_RD_HIT",
+        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc4"
+    },
+    {
+        "BriefDescription": "L2 cache misses when fetching instructions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.CODE_RD_MISS",
+        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x24"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests that hit L2 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc1"
+    },
+    {
+        "BriefDescription": "Demand Data Read miss L2 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
+        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event i=
s alias to L2_REQUEST.HIT]",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This=
 event is alias to L2_REQUEST.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf"
+    },
+    {
+        "BriefDescription": "L2_RQSTS.HWPF_MISS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.HWPF_MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x30"
+    },
+    {
+        "BriefDescription": "Read requests with true-miss in L2 cache [Thi=
s event is alias to L2_REQUEST.MISS]",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.MISS",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x3f"
+    },
+    {
+        "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_REQUEST.ALL]",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.REFERENCES",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "RFO requests that hit L2 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_HIT",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc2"
+    },
+    {
+        "BriefDescription": "RFO requests that miss L2 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_MISS",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x22"
+    },
+    {
+        "BriefDescription": "SW prefetch requests that hit L2 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.SWPF_HIT",
+        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc8"
+    },
+    {
+        "BriefDescription": "SW prefetch requests that miss L2 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.SWPF_MISS",
+        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x28"
+    },
+    {
+        "BriefDescription": "L2 writebacks that access L2 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "L2_TRANS.L2_WB",
+        "PublicDescription": "Counts L2 writebacks that access L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x40"
+    },
     {
         "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
@@ -25,6 +307,7 @@
     },
     {
         "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
@@ -33,6 +316,7 @@
     },
     {
         "BriefDescription": "Retired load instructions.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
@@ -43,6 +327,7 @@
     },
     {
         "BriefDescription": "Retired store instructions.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
@@ -50,5 +335,545 @@
         "PublicDescription": "Counts all retired store instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x82"
+    },
+    {
+        "BriefDescription": "All retired memory instructions.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ANY",
+        "PEBS": "1",
+        "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x83"
+    },
+    {
+        "BriefDescription": "Retired load instructions with locked access.=
",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with locked=
 access.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "Retired load instructions that split across a=
 cacheline boundary.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Retired store instructions that split across =
a cacheline boundary.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x42"
+    },
+    {
+        "BriefDescription": "Retired load instructions that hit the STLB."=
,
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_HIT_LOADS",
+        "PEBS": "1",
+        "PublicDescription": "Number of retired load instructions with a c=
lean hit in the 2nd-level TLB (STLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x9"
+    },
+    {
+        "BriefDescription": "Retired store instructions that hit the STLB.=
",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_HIT_STORES",
+        "PEBS": "1",
+        "PublicDescription": "Number of retired store instructions that hi=
t in the 2nd-level TLB (STLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0xa"
+    },
+    {
+        "BriefDescription": "Retired load instructions that miss the STLB.=
",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
+        "PEBS": "1",
+        "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Retired store instructions that miss the STLB=
.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
+        "PEBS": "1",
+        "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x12"
+    },
+    {
+        "BriefDescription": "Completed demand load uops that miss the L1 d=
-cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "MEM_LOAD_COMPLETED.L1_MISS_ANY",
+        "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss)",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xfd"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were HitM responses from shared L3",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
+        "PEBS": "1",
+        "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were hits in L3 without snoops required",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were hits in L3 without snoops required.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were L3 and cross-core snoop hits in on-pkg core cache",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired load instructions which data sources =
missed L3 but serviced from local dram",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
+        "PEBS": "1",
+        "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
was forwarded from a remote cache",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD",
+        "PEBS": "1",
+        "PublicDescription": "Retired load instructions whose data sources=
 was forwarded from a remote cache.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Retired instructions with at least 1 uncachea=
ble load or lock.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_MISC_RETIRED.UC",
+        "PEBS": "1",
+        "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock).",
+        "SampleAfterValue": "100007",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of completed demand load requests that=
 missed the L1, but hit the FB(fill buffer), because a preceding miss to th=
e same cacheline initiated the line to be brought into L1, but data is not =
yet ready in L1.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.FB_HIT",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L1 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L1 cache as =
data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_MISS",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L2 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_HIT",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L2 cache as =
data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_MISS",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources.",
+        "SampleAfterValue": "100021",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L3 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L3_HIT",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache.",
+        "SampleAfterValue": "100021",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L3 cache as =
data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L3_MISS",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache.",
+        "SampleAfterValue": "50021",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "MEM_STORE_RETIRED.L2_HIT",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x44",
+        "EventName": "MEM_STORE_RETIRED.L2_HIT",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired memory uops for any access",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe5",
+        "EventName": "MEM_UOP_RETIRED.ANY",
+        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit in the L3 or were snooped from another co=
re's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that resulted in a snoop hit a modified line in an=
other core's caches which forwarded the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that hit in the L3 o=
r were snooped from another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit a modified line in another core's caches which forwarded the data.=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another core's caches which forwarded the unmodified data to th=
e requesting core.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit in=
 the L3 or were snooped from another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that result=
ed in a snoop hit a modified line in another core's caches which forwarded =
the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that hit in the L3 or were snooped from another core's caches on the sa=
me socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F003C4477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Any memory transaction that reached the SQ.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
+        "PublicDescription": "Counts memory transactions reached the super=
 queue including requests initiated by the core, all L3 prefetches, page wa=
lks, etc..",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Demand and prefetch data reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DATA_RD",
+        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cacheable and Non-Cacheable code read request=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
+        "PublicDescription": "Counts both cacheable and Non-Cacheable code=
 read requests.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests sent to uncore",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
+        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Demand RFO requests including regular RFOs, l=
ocks, ItoM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
+        "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles when offcore outstanding cacheable Cor=
e Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "PublicDescription": "Counts cycles when offcore outstanding cache=
able Core Data Read transactions are present in the super queue. A transact=
ion is considered to be in the Offcore outstanding state between L2 miss an=
d transaction completion sent to requestor (SQ de-allocation). See correspo=
nding Umask under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles with offcore outstanding Code Reads tr=
ansactions in the SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE=
_RD",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles where at least 1 outstanding demand da=
ta read request is pending.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles with offcore outstanding demand rfo re=
ads transactions in SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
+        "PublicDescription": "Counts the number of offcore outstanding dem=
and rfo Reads transactions in the super queue every cycle. The 'Offcore out=
standing' state of the transaction lasts from the L2 miss until the sending=
 transaction completion to requestor (SQ deallocation). See the correspondi=
ng Umask under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Offcore outstanding Code Reads transactions i=
n the SuperQueue (SQ), queue to uncore, every cycle.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "For every cycle, increments by the number of =
outstanding demand data read requests pending.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
+        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Store Read transactions pending for off-core.=
 Highly correlated.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
+        "PublicDescription": "Counts the number of off-core outstanding re=
ad-for-ownership (RFO) store transactions every cycle. An RFO transaction i=
s considered to be in the Off-core outstanding state between L2 cache miss =
and transaction completion.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts bus locks, accounts for cache line spl=
it locks and UC locks.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2c",
+        "EventName": "SQ_MISC.BUS_LOCK",
+        "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of PREFETCHNTA, PREFETCHW, =
PREFETCHT0, PREFETCHT1 or PREFETCHT2 instructions executed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.ANY",
+        "SampleAfterValue": "100003",
+        "UMask": "0xf"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHNTA instructions executed."=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.NTA",
+        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHW instructions executed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
+        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.T0",
+        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructio=
ns executed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/counter.json b/to=
ols/perf/pmu-events/arch/x86/graniterapids/counter.json
new file mode 100644
index 000000000000..250781a8ca64
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/counter.json
@@ -0,0 +1,77 @@
+[
+    {
+        "Unit": "core",
+        "CountersNumFixed": "4",
+        "CountersNumGeneric": "8"
+    },
+    {
+        "Unit": "B2CMI",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "CHA",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "IMC",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "B2HOT",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    },
+    {
+        "Unit": "IIO",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "IRP",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "UPI",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "B2UPI",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    },
+    {
+        "Unit": "B2CXL",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    },
+    {
+        "Unit": "PCU",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    },
+    {
+        "Unit": "CHACMS",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    },
+    {
+        "Unit": "MDF",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "CXLCM",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 8
+    },
+    {
+        "Unit": "CXLDP",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/floating-point.js=
on b/tools/perf/pmu-events/arch/x86/graniterapids/floating-point.json
new file mode 100644
index 000000000000..59789eee060c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/floating-point.json
@@ -0,0 +1,242 @@
+[
+    {
+        "BriefDescription": "This event counts the cycles the floating poi=
nt divider is busy.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.FPDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all microcode FP assists.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.FP",
+        "PublicDescription": "Counts all microcode Floating Point assists.=
",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "ASSISTS.SSE_AVX_MIX",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.SSE_AVX_MIX",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_0 [This event is ali=
as to FP_ARITH_DISPATCHED.V0]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.PORT_0",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_1 [This event is ali=
as to FP_ARITH_DISPATCHED.V1]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.PORT_1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_5 [This event is ali=
as to FP_ARITH_DISPATCHED.V2]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.PORT_5",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V0 [This event is alias t=
o FP_ARITH_DISPATCHED.PORT_0]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V0",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V1 [This event is alias t=
o FP_ARITH_DISPATCHED.PORT_1]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V2 [This event is alias t=
o FP_ARITH_DISPATCHED.PORT_5]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V2",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 128-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 2 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice =
as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 SQRT =
DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they pe=
rform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 4 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perf=
orm 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed single =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single and 256-bit packed double precision FP instructions retired; some =
instructions will count twice as noted below.  Each count represents 2 or/a=
nd 4 computation operations, 1 for each element.  Applies to SSE* and AVX* =
packed single precision and packed double precision FP instructions: ADD SU=
B HADD HSUB SUBADD MUL DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DP=
P and FM(N)ADD/SUB count twice as they perform 2 calculations per element."=
,
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.4_FLOPS",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events."=
,
+        "SampleAfterValue": "100003",
+        "UMask": "0x18"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 512-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14=
 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform =
2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14=
 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calc=
ulations per element. The DAZ and FTZ flags in the MXCSR register need to b=
e set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 512-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 16 computatio=
n operations, one for each element.  Applies to SSE* and AVX* packed single=
 precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT1=
4 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform=
 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 16 computation oper=
ations, one for each element.  Applies to SSE* and AVX* packed single preci=
sion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP1=
4 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 cal=
culations per element. The DAZ and FTZ flags in the MXCSR register need to =
be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d single precision and 512-bit packed double precision  FP instructions ret=
ired; some instructions will count twice as noted below.  Each count repres=
ents 8 computation operations, 1 for each element.  Applies to SSE* and AVX=
* packed single precision and double precision FP instructions: ADD SUB HAD=
D HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14 RCP RCP14 DPP FM(N)ADD/SUB=
.  DPP and FM(N)ADD/SUB count twice as they perform 2 calculations per elem=
ent.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.8_FLOPS",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision and 512-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 8 computation operations, one for each element.  Applies =
to SSE* and AVX* packed single precision and double precision floating-poin=
t instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14=
 RCP RCP14 DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice=
 as they perform 2 calculations per element. The DAZ and FTZ flags in the M=
XCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x60"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational scalar floati=
ng-point instructions retired; some instructions will count twice as noted =
below.  Applies to SSE* and AVX* scalar, double and single precision floati=
ng-point: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 RANGE SQRT DPP FM(N)ADD/SUB=
.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple c=
alculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational scalar=
 double precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar double precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructi=
ons count twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational scalar=
 single precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar single precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB=
 instructions count twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of any Vector retired FP arithmetic in=
structions",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.VECTOR",
+        "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xfc"
+    },
+    {
+        "BriefDescription": "FP_ARITH_INST_RETIRED2.128B_PACKED_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.128B_PACKED_HALF",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "FP_ARITH_INST_RETIRED2.256B_PACKED_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.256B_PACKED_HALF",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "FP_ARITH_INST_RETIRED2.512B_PACKED_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.512B_PACKED_HALF",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of all Scalar Half-Precision FP arithm=
etic instructions(1) retired - regular and complex.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.SCALAR",
+        "PublicDescription": "FP_ARITH_INST_RETIRED2.SCALAR",
+        "SampleAfterValue": "100003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "FP_ARITH_INST_RETIRED2.SCALAR_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.SCALAR_HALF",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of all Vector (also called packed) Hal=
f-Precision FP arithmetic instructions(1) retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.VECTOR",
+        "PublicDescription": "FP_ARITH_INST_RETIRED2.VECTOR",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1c"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/frontend.json
index c6d5016e7337..663c1a0e55a2 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
@@ -1,9 +1,474 @@
 [
     {
-        "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were no operation was delivered to the back-end pipeline due =
to instruction fetch limitations when the back-end could have accepted more=
 operations. Common examples include instruction cache misses or x86 instru=
ction decode limitations.",
+        "BriefDescription": "Clears due to Unknown Branches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "BACLEARS.ANY",
+        "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x87",
+        "EventName": "DECODE.LCP",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles the Microcode Sequencer is busy.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x87",
+        "EventName": "DECODE.MS_BUSY",
+        "SampleAfterValue": "500009",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "DSB-to-MITE switch true penalty cycles.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x61",
+        "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
+        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired ANT branches",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ANY_ANT",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x9",
+        "PEBS": "1",
+        "PublicDescription": "Always Not Taken (ANT) conditional retired b=
ranches (no BTB entry and not mispredicted)",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced DSB miss=
.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x1",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced a critic=
al DSB miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DSB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x11",
+        "PEBS": "1",
+        "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced iTLB tru=
e miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ITLB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x14",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced Instruct=
ion L1 Cache true miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.L1I_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x12",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced Instruct=
ion L2 Cache true miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.L2_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x13",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions after front-end starvati=
on of at least 1 cycle",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600106",
+        "PEBS": "1",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 128 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x608006",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 16 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x601006",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions after front-end starvati=
on of at least 2 cycles",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600206",
+        "PEBS": "1",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 256 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x610006",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end had at least 1 bubble-slot for a period of 2=
 cycles which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x100206",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 32 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x602006",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 4 cycles w=
hich was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600406",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 512 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x620006",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 64 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x604006",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 8 cycles w=
hich was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600806",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "I-Cache miss too close to Code Prefetch Instr=
uction",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATE_SWPF",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x9",
+        "PEBS": "1",
+        "PublicDescription": "Number of Instruction Cache demand miss in s=
hadow of an on-going i-fetch cache-line triggered by PREFETCHIT0/1 instruct=
ions",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Mispredicted Retired ANT branches",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.MISP_ANT",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x9",
+        "PEBS": "1",
+        "PublicDescription": "ANT retired branches that got just mispredic=
ted",
+        "SampleAfterValue": "100007",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "FRONTEND_RETIRED.MS_FLOWS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.MS_FLOWS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x8",
+        "PEBS": "1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.STLB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x15",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x17",
+        "PEBS": "1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "ICACHE_DATA.STALLS",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "ICACHE_DATA.STALL_PERIODS",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x80",
+        "EventName": "ICACHE_DATA.STALL_PERIODS",
+        "SampleAfterValue": "500009",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_CYCLES_ANY",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles DSB is delivering optimal number of Uo=
ps",
+        "Counter": "0,1,2,3",
+        "CounterMask": "6",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_CYCLES_OK",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_UOPS",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles MITE is delivering any Uop",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_CYCLES_ANY",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles MITE is delivering optimal number of U=
ops",
+        "Counter": "0,1,2,3",
+        "CounterMask": "6",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_CYCLES_OK",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_UOPS",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles when uops are being delivered to IDQ w=
hile MS is busy",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_CYCLES_ANY",
+        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Number of switches from DSB or MITE to the MS=
",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_SWITCHES",
+        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Uops initiated by MITE or Decode Stream Buffe=
r (DSB) and delivered to Instruction Decode Queue (IDQ) while Microcode Seq=
uencer (MS) is busy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_UOPS",
+        "PublicDescription": "Counts the number of uops initiated by MITE =
or Decode Stream Buffer (DSB) and delivered to Instruction Decode Queue (ID=
Q) while the Microcode Sequencer (MS) is busy. Counting includes uops that =
may 'bypass' the IDQ.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that when no operation was delivered to the back-end pipeline due =
to instruction fetch limitations when the back-end could have accepted more=
 operations. Common examples include instruction cache misses or x86 instru=
ction decode limitations.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CORE",
-        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were no operation was delivered to the back-end pipeline due=
 to instruction fetch limitations when the back-end could have accepted mor=
e operations. Common examples include instruction cache misses or x86 instr=
uction decode limitations.\nThe count may be distributed among unhalted log=
ical processors (hyper-threads) who share the same physical core, in proces=
sors that support Intel Hyper-Threading Technology. Software can use this e=
vent as the numerator for the Frontend Bound metric (or top-level category)=
 of the Top-down Microarchitecture Analysis method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that when no operation was delivered to the back-end pipeline due=
 to instruction fetch limitations when the back-end could have accepted mor=
e operations. Common examples include instruction cache misses or x86 instr=
uction decode limitations. The count may be distributed among unhalted logi=
cal processors (hyper-threads) who share the same physical core, in process=
ors that support Intel Hyper-Threading Technology. Software can use this ev=
ent as the numerator for the Frontend Bound metric (or top-level category) =
of the Top-down Microarchitecture Analysis method.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled [This event is alias to IDQ_=
UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "6",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES=
_0_UOPS_DELIV.CORE]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled [This event is alias t=
o IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CYCLES_FE_WAS_OK",
+        "Invert": "1",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_N=
OT_DELIVERED.CYCLES_FE_WAS_OK]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled [This event is alias to IDQ_=
BUBBLES.CYCLES_0_UOPS_DELIV.CORE]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "6",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DEL=
IV.CORE]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled [This event is alias t=
o IDQ_BUBBLES.CYCLES_FE_WAS_OK]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
+        "Invert": "1",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLE=
S.CYCLES_FE_WAS_OK]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/memory.json b/too=
ls/perf/pmu-events/arch/x86/graniterapids/memory.json
index 1c0e0e86e58e..38b74c6752c2 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/memory.json
@@ -1,6 +1,85 @@
 [
+    {
+        "BriefDescription": "Cycles while L3 cache miss demand load is out=
standing.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "2",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L3_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Execution stalls while L3 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "6",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Number of machine clears due to memory orderi=
ng conflicts.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
+        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "2",
+        "EventCode": "0x47",
+        "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "3",
+        "EventCode": "0x47",
+        "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Execution stalls while L2 cache miss demand c=
acheable load request is outstanding.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "5",
+        "EventCode": "0x47",
+        "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
+        "PublicDescription": "Execution stalls while L2 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock).",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Execution stalls while L3 cache miss demand c=
acheable load request is outstanding.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "9",
+        "EventCode": "0x47",
+        "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
+        "PublicDescription": "Execution stalls while L3 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock).",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x9"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 1024 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x400",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency.",
+        "SampleAfterValue": "53",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
@@ -13,6 +92,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 16 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
@@ -23,8 +103,22 @@
         "SampleAfterValue": "20011",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 2048 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x800",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency.",
+        "SampleAfterValue": "23",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
@@ -37,6 +131,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 32 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
@@ -49,6 +144,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 4 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
@@ -61,6 +157,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 512 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
@@ -73,6 +170,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 64 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
@@ -85,6 +183,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 8 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
@@ -97,6 +196,7 @@
     },
     {
         "BriefDescription": "Retired memory store access operations. A PDi=
st event for PEBS Store Latency Facility.",
+        "Counter": "0",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
@@ -105,8 +205,19 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the local socket's L1, L=
2, or L3 caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the local socket's L1, L2, or L3 caches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -116,6 +227,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were n=
ot supplied by the local socket's L1, L2, or L3 caches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -124,51 +236,40 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Number of times an RTM execution aborted.",
-        "EventCode": "0xc9",
-        "EventName": "RTM_RETIRED.ABORTED",
-        "PublicDescription": "Counts the number of times RTM abort was tri=
ggered.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x4"
-    },
-    {
-        "BriefDescription": "Number of times an RTM execution successfully=
 committed",
-        "EventCode": "0xc9",
-        "EventName": "RTM_RETIRED.COMMIT",
-        "PublicDescription": "Counts the number of times RTM commit succee=
ded.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Number of times an RTM execution started.",
-        "EventCode": "0xc9",
-        "EventName": "RTM_RETIRED.START",
-        "PublicDescription": "Counts the number of times we entered an RTM=
 region. Does not count nested transactions.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F3FC04477",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional reads",
-        "EventCode": "0x54",
-        "EventName": "TX_MEM.ABORT_CAPACITY_READ",
-        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional reads",
+        "BriefDescription": "Counts demand data read requests that miss th=
e L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
         "SampleAfterValue": "100003",
-        "UMask": "0x80"
+        "UMask": "0x10"
     },
     {
-        "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional writes.",
-        "EventCode": "0x54",
-        "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
-        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional writes.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x2"
+        "BriefDescription": "Cycles where data return is pending for a Dem=
and Data Read request who miss L3 cache.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_L3_MISS_DEM=
AND_DATA_RD",
+        "PublicDescription": "Cycles with at least 1 Demand Data Read requ=
ests who miss L3 cache in the superQ.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
     },
     {
-        "BriefDescription": "Number of times a transactional abort was sig=
naled due to a data conflict on a transactionally accessed address",
-        "EventCode": "0x54",
-        "EventName": "TX_MEM.ABORT_CONFLICT",
-        "PublicDescription": "Counts the number of times a TSX line had a =
cache conflict.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
+        "BriefDescription": "For every cycle, increments by the number of =
demand data read requests pending that are known to have missed the L3 cach=
e.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD"=
,
+        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/other.json b/tool=
s/perf/pmu-events/arch/x86/graniterapids/other.json
index 5e799bae03ea..8b9b3c920934 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/other.json
@@ -1,6 +1,53 @@
 [
+    {
+        "BriefDescription": "ASSISTS.PAGE_FAULT",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.PAGE_FAULT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the cycles where the AMX (Advance Matr=
ix Extension) unit is busy performing an operation.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb7",
+        "EventName": "EXE.AMX_BUSY",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C000004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM attached to this socket=
, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM=
 accesses that are controlled by the close SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104000004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -9,21 +56,112 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In S=
NC Mode counts only those DRAM accesses that are controlled by the close SN=
C Cluster.",
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
+        "EventName": "OCR.DEMAND_RFO.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x104000001",
+        "MSRValue": "0x73C000002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response.",
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mo=
de.  In SNC Mode counts only those DRAM accesses that are controlled by the=
 close SNC Cluster.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F3FFC0002",
+        "MSRValue": "0x104000002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts writebacks of modified cachelines and =
streaming stores that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.MODIFIED_WRITE.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10808",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F3FFC4477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that have any type of=
 response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10800",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_COUNT",
+        "Invert": "1",
+        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
+        "SampleAfterValue": "100003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Cycles when RS was empty and a resource alloc=
ation stall is asserted",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_RESOURCE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles the uncore cannot take further request=
s",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x2d",
+        "EventName": "XQ.FULL_CYCLES",
+        "PublicDescription": "number of cycles when the thread is active a=
nd the uncore cannot take any further requests (for example prefetches, loa=
ds or stores initiated by the Core that miss the L2 cache).",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
index 764c0435d1d2..0ef9daf64e2e 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
@@ -1,22 +1,347 @@
 [
+    {
+        "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.DIV_ACTIVE",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x9"
+    },
+    {
+        "BriefDescription": "This event counts the cycles the integer divi=
der is busy.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.IDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.ANY",
+        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1b"
+    },
     {
         "BriefDescription": "All branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
         "PublicDescription": "Counts all branch instructions retired.",
         "SampleAfterValue": "400009"
     },
+    {
+        "BriefDescription": "Conditional branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PEBS": "1",
+        "PublicDescription": "Counts conditional branch instructions retir=
ed.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Not taken branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_NTAKEN",
+        "PEBS": "1",
+        "PublicDescription": "Counts not taken branch instructions retired=
.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Taken conditional branch instructions retired=
.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "PublicDescription": "Counts taken conditional branch instructions=
 retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Far branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
+        "PEBS": "1",
+        "PublicDescription": "Counts far branch instructions retired.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Indirect near branch instructions retired (ex=
cluding returns)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Direct and indirect near call instructions re=
tired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "PEBS": "1",
+        "PublicDescription": "Counts both direct and indirect near call in=
structions retired.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Return instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "PEBS": "1",
+        "PublicDescription": "Counts return instructions retired.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Taken branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "PEBS": "1",
+        "PublicDescription": "Counts taken branch instructions retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "All mispredicted branch instructions retired.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
         "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path.",
         "SampleAfterValue": "400009"
     },
+    {
+        "BriefDescription": "All mispredicted branch instructions retired.=
 This precise event may be used to get the misprediction cost via the Retir=
e_Latency field of PEBS. It fires on the instruction that immediately follo=
ws the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x44"
+    },
+    {
+        "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND",
+        "PEBS": "1",
+        "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Mispredicted conditional branch instructions =
retired. This precise event may be used to get the misprediction cost via t=
he Retire_Latency field of PEBS. It fires on the instruction that immediate=
ly follows the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x51"
+    },
+    {
+        "BriefDescription": "Mispredicted non-taken conditional branch ins=
tructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
+        "PEBS": "1",
+        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Mispredicted non-taken conditional branch ins=
tructions retired. This precise event may be used to get the misprediction =
cost via the Retire_Latency field of PEBS. It fires on the instruction that=
 immediately follows the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_NTAKEN_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x50"
+    },
+    {
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Mispredicted taken conditional branch instruc=
tions retired. This precise event may be used to get the misprediction cost=
 via the Retire_Latency field of PEBS. It fires on the instruction that imm=
ediately follows the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Miss-predicted near indirect branch instructi=
ons retired (excluding returns)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Mispredicted indirect CALL retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Mispredicted indirect CALL retired. This prec=
ise event may be used to get the misprediction cost via the Retire_Latency =
field of PEBS. It fires on the instruction that immediately follows the mis=
predicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_CALL_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x42"
+    },
+    {
+        "BriefDescription": "Mispredicted near indirect branch instruction=
s retired (excluding returns). This precise event may be used to get the mi=
sprediction cost via the Retire_Latency field of PEBS. It fires on the inst=
ruction that immediately follows the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0xc0"
+    },
+    {
+        "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "PEBS": "1",
+        "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Mispredicted taken near branch instructions r=
etired. This precise event may be used to get the misprediction cost via th=
e Retire_Latency field of PEBS. It fires on the instruction that immediatel=
y follows the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x60"
+    },
+    {
+        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.RET",
+        "PEBS": "1",
+        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Mispredicted ret instructions retired. This p=
recise event may be used to get the misprediction cost via the Retire_Laten=
cy field of PEBS. It fires on the instruction that immediately follows the =
mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.RET_COST",
+        "PEBS": "1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x48"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 li=
ght-weight slower wakeup time but more power saving optimized state.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C01",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.2 li=
ght-weight faster wakeup time but less power saving optimized state.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C02",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 or=
 C0.2 or running a PAUSE in C0 ACPI state.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x70"
+    },
+    {
+        "BriefDescription": "Cycle counts are evenly distributed between a=
ctive threads in the Core.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
+        "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Core crystal clock cycles when this thread is=
 unhalted and the other thread is halted.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
+        "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
+        "SampleAfterValue": "25003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "CPU_CLK_UNHALTED.PAUSE",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.PAUSE",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Core crystal clock cycles. Cycle counts are e=
venly distributed between active threads in the Core.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
+        "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
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
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the eight programmable counte=
rs available for other events. Note: On all current platforms this event st=
ops counting during 'throttling (TM)' states duty off periods the processor=
 is 'halted'.  The counter update is done at a lower clock rate then the co=
re clock the overflow status bit for this counter may appear 'sticky'.  Aft=
er the counter has overflowed and software clears the overflow status bit a=
nd resets the counter to less than MAX. The reset value to the counter is n=
ot clocked immediately so the overflow status bit will flip 'high (1)' and =
generate another PMI (if enabled) after which the reset value gets clocked =
into the counter. Therefore, software will get the interrupt, read the over=
flow status bit '1 for bit 34 while the counter value is less than MAX. Sof=
tware should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -24,6 +349,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
         "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the four (eight when Hyperthr=
eading is disabled) programmable counters available for other events. Note:=
 On all current platforms this event stops counting during 'throttling (TM)=
' states duty off periods the processor is 'halted'.  The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case.",
@@ -32,6 +358,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate",
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
ng the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -39,13 +366,150 @@
     },
     {
         "BriefDescription": "Thread cycles when thread is not in halt stat=
e",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
         "SampleAfterValue": "2000003"
     },
+    {
+        "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "8",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles while L2 cache miss demand load is out=
standing.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles while memory subsystem has an outstand=
ing load.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "16",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "12",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc"
+    },
+    {
+        "BriefDescription": "Execution stalls while L2 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "5",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Total execution stalls.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "4",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles total of 1 uop is executed on all port=
s and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
+        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles total of 2 or 3 uops are executed on a=
ll ports and Reservation Station (RS) was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.2_3_PORTS_UTIL",
+        "SampleAfterValue": "2000003",
+        "UMask": "0xc"
+    },
+    {
+        "BriefDescription": "Cycles total of 2 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
+        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles total of 3 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
+        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles total of 4 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
+        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Execution stalls while memory subsystem has a=
n outstanding load.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "5",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "Cycles where the Store Buffer was full and no=
 loads caused an execution stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "2",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
+        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Cycles no uop executed while RS was not empty=
, the SB was not full and there was no outstanding load.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
+        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Instruction decoders utilized in a cycle",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x75",
+        "EventName": "INST_DECODED.DECODERS",
+        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
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
@@ -54,30 +518,322 @@
     },
     {
         "BriefDescription": "Number of instructions retired. General Count=
er - architectural event",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003"
     },
+    {
+        "BriefDescription": "INST_RETIRED.MACRO_FUSED",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.MACRO_FUSED",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Retired NOP instructions.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.NOP",
+        "PEBS": "1",
+        "PublicDescription": "Counts all retired NOP or ENDBR32/64 or PREF=
ETCHIT0/1 instructions",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
+        "Counter": "Fixed counter 0",
+        "EventName": "INST_RETIRED.PREC_DIST",
+        "PEBS": "1",
+        "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Iterations of Repeat string retired instructi=
ons.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.REP_ITERATION",
+        "PEBS": "1",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Clears speculative count",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.CLEARS_COUNT",
+        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cycles after recovery from a branch mi=
sprediction or machine clear till the first uop is issued from the resteere=
d path.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
+        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "INT_MISC.MBA_STALLS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.MBA_STALLS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.RECOVERY_CYCLES",
+        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Bubble cycles of BAClear (Unknown Branch).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "TMA slots where uops got dropped",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.UOP_DROPPING",
+        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.128BIT",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.128BIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x13"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.256BIT",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.256BIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xac"
+    },
+    {
+        "BriefDescription": "integer ADD, SUB, SAD 128-bit vector instruct=
ions.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.ADD_128",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "integer ADD, SUB, SAD 256-bit vector instruct=
ions.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.ADD_256",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.MUL_256",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.MUL_256",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.SHUFFLES",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.SHUFFLES",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.VNNI_128",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.VNNI_128",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.VNNI_256",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.VNNI_256",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "False dependencies in MOB due to partial comp=
are on address.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
+        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "The number of times that split load operation=
s are temporarily blocked because all resources for handling the split acce=
sses are in use.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.NO_SR",
+        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x88"
+    },
     {
         "BriefDescription": "Loads blocked due to overlapping with a prece=
ding store that cannot be forwarded.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
         "SampleAfterValue": "100003",
         "UMask": "0x82"
     },
+    {
+        "BriefDescription": "Counts the number of demand load dispatches t=
hat hit L1D fill buffer (FB) allocated for software prefetch.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4c",
+        "EventName": "LOAD_HIT_PREFETCH.SWPF",
+        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xa8",
+        "EventName": "LSD.CYCLES_ACTIVE",
+        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles optimal number of Uops delivered by th=
e LSD, but did not come from the decoder.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "6",
+        "EventCode": "0xa8",
+        "EventName": "LSD.CYCLES_OK",
+        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of Uops delivered by the LSD.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa8",
+        "EventName": "LSD.UOPS",
+        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of machine clears (nukes) of any type.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.COUNT",
+        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Self-modifying code (SMC) detected.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.SMC",
+        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "LFENCE instructions retired",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe0",
+        "EventName": "MISC2_RETIRED.LFENCE",
+        "PublicDescription": "number of LFENCE retired instructions",
+        "SampleAfterValue": "400009",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Increments whenever there is an update to the=
 LBR array.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcc",
+        "EventName": "MISC_RETIRED.LBR_INSERTS",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts cycles where the pipeline is stalled d=
ue to serializing operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa2",
+        "EventName": "RESOURCE_STALLS.SCOREBOARD",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were not consumed by the back-end pipeline due to lack of bac=
k-end resources, as a result of memory subsystem delays, execution units li=
mitations, or other conditions.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
-        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were not consumed by the back-end pipeline due to lack of ba=
ck-end resources, as a result of memory subsystem delays, execution units l=
imitations, or other conditions.\nThe count is distributed among unhalted l=
ogical processors (hyper-threads) who share the same physical core, in proc=
essors that support Intel Hyper-Threading Technology. Software can use this=
 event as the numerator for the Backend Bound metric (or top-level category=
) of the Top-down Microarchitecture Analysis method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were not consumed by the back-end pipeline due to lack of ba=
ck-end resources, as a result of memory subsystem delays, execution units l=
imitations, or other conditions. The count is distributed among unhalted lo=
gical processors (hyper-threads) who share the same physical core, in proce=
ssors that support Intel Hyper-Threading Technology. Software can use this =
event as the numerator for the Backend Bound metric (or top-level category)=
 of the Top-down Microarchitecture Analysis method.",
         "SampleAfterValue": "10000003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "TMA slots wasted due to incorrect speculation=
s.",
+        "Counter": "0",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
+        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
+        "Counter": "0",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "TOPDOWN.MEMORY_BOUND_SLOTS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
+        "Counter": "Fixed counter 3",
         "EventName": "TOPDOWN.SLOTS",
         "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
@@ -85,18 +841,267 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. General counter - architectural event",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.SLOTS_P",
         "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
         "SampleAfterValue": "10000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Number of non dec-by-all uops decoded by deco=
der",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x76",
+        "EventName": "UOPS_DECODED.DEC0_UOPS",
+        "PublicDescription": "This event counts the number of not dec-by-a=
ll uops decoded by decoder 0.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Uops executed on port 0",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_0",
+        "PublicDescription": "Number of uops dispatch to execution  port 0=
.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Uops executed on port 1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_1",
+        "PublicDescription": "Number of uops dispatch to execution  port 1=
.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Uops executed on ports 2, 3 and 10",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_2_3_10",
+        "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Uops executed on ports 4 and 9",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_4_9",
+        "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Uops executed on ports 5 and 11",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_5_11",
+        "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Uops executed on port 6",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_6",
+        "PublicDescription": "Number of uops dispatch to execution  port 6=
.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Uops executed on ports 7 and 8",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_7_8",
+        "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Number of uops executed on the core.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE",
+        "PublicDescription": "Counts the number of uops executed from any =
thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles at least 1 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
+        "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles at least 2 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "2",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
+        "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles at least 3 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "3",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
+        "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles at least 4 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "4",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
+        "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles where at least 1 uop was executed per-=
thread",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
+        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "2",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
+        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 3 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "3",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
+        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 4 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "4",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
+        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.STALLS",
+        "Invert": "1",
+        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of uops to be executed per-=
thread each cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.THREAD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of x87 uops dispatched.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.X87",
+        "PublicDescription": "Counts the number of x87 uops executed.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Uops that RAT issues to RS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xae",
+        "EventName": "UOPS_ISSUED.ANY",
+        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "UOPS_ISSUED.CYCLES",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xae",
+        "EventName": "UOPS_ISSUED.CYCLES",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles with retired uop(s).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.CYCLES",
+        "PublicDescription": "Counts cycles where at least one uop has ret=
ired.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired uops except the last uop of each inst=
ruction.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.HEAVY",
+        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "UOPS_RETIRED.MS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.MS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x8",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that are utilized by operations that eventually get retired (commi=
tted) by the processor pipeline. Usually, this event positively correlates =
with higher performance  for example, as measured by the instructions-per-c=
ycle metric.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.SLOTS",
-        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that are utilized by operations that eventually get retired (comm=
itted) by the processor pipeline. Usually, this event positively correlates=
 with higher performance  for example, as measured by the instructions-per-=
cycle metric.\nSoftware can use this event as the numerator for the Retirin=
g metric (or top-level category) of the Top-down Microarchitecture Analysis=
 method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that are utilized by operations that eventually get retired (comm=
itted) by the processor pipeline. Usually, this event positively correlates=
 with higher performance  for example, as measured by the instructions-per-=
cycle metric. Software can use this event as the numerator for the Retiring=
 metric (or top-level category) of the Top-down Microarchitecture Analysis =
method.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles without actually retired uops.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.STALLS",
+        "Invert": "1",
+        "PublicDescription": "This event counts cycles without actually re=
tired uops.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json=
 b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
new file mode 100644
index 000000000000..e0a45d4ea848
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
@@ -0,0 +1,3674 @@
+[
+    {
+        "BriefDescription": "Clockticks for CMS units attached to CHA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_CHACMS_CLOCKTICKS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "PublicDescription": "UNC_CHACMS_CLOCKTICKS",
+        "Unit": "CHACMS"
+    },
+    {
+        "BriefDescription": "Number of CHA clock cycles while the event is=
 enabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_CHA_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Clockticks of the uncore caching and home ag=
ent (CHA)",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts transactions that looked into the mult=
i-socket cacheline Directory state, and therefore did not send a snoop beca=
use the Directory indicated it was not needed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_CHA_DIR_LOOKUP.NO_SNP",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts  transactions that looked into the mul=
ti-socket cacheline Directory state, and sent one or more snoops, because t=
he Directory indicated it was needed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_CHA_DIR_LOOKUP.SNP",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts only multi-socket cacheline Directory =
state updates memory writes issued from the HA pipe. This does not include =
memory write requests which are for I (Invalid) or E (Exclusive) cachelines=
.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_CHA_DIR_UPDATE.HA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts only multi-socket cacheline Directory =
state updates due to memory writes issued from the TOR pipe which are the r=
esult of remote transaction hitting the SF/LLC and returning data Core2Core=
. This does not include memory write requests which are for I (Invalid) or =
E (Exclusive) cachelines.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_CHA_DIR_UPDATE.TOR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal assertion for dynamic prefetc=
h throttle (DPT).  Threshold for distress signal assertion reached in TOR o=
r IRQ (immediate cause for triggering).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_ANY",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x3",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal assertion for dynamic prefetc=
h throttle (DPT).  Threshold for distress signal assertion reached in IRQ (=
immediate cause for triggering).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_IRQ",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal assertion for dynamic prefetc=
h throttle (DPT).  Threshold for distress signal assertion reached in TOR (=
immediate cause for triggering).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_TOR",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts when a normal (Non-Isochronous) full l=
ine write is issued from the CHA to the any of the memory controller channe=
ls.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5b",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Full Line Writes Issued : ISOCH Fu=
ll Line : Counts the total number of full line writes issued from the HA in=
to the memory controller.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5b",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL_PRIORITY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Full Line Writes Issued : Partial =
Non-ISOCH : Counts the total number of full line writes issued from the HA =
into the memory controller.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5b",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Full Line Writes Issued : ISOCH Pa=
rtial : Counts the total number of full line writes issued from the HA into=
 the memory controller.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5b",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL_PRIORITY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All Requests to Remotely Homed=
 Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.ALL_REMOTE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : All transactions from Remote=
 Agents",
+        "UMask": "0x17e0ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: CRd Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.CODE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x1bd0ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests and Read Prefetc=
hes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x1bc1ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests, Read Prefetches=
, and Snoops",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Data Reads",
+        "UMask": "0x1fc1ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests to Locally Homed=
 Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_LOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Demand Data Reads, Core and =
LLC prefetches",
+        "UMask": "0x841ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests, Read Prefetches=
, and Snoops which miss the Cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Data Read Misses",
+        "UMask": "0x1fc101",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All Requests to Locally Homed =
Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCALLY_HOMED_ADDRESS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Transactions homed locally",
+        "UMask": "0xbdfff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Code Read Requests and Code Re=
ad Prefetches to Locally Homed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_CODE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x19d0ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests and Read Prefetc=
hes to Locally Homed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DATA_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x19c1ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Code Read Requests to Locally =
Homed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_CODE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x1850ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests to Locally Homed=
 Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_DATA_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x1841ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Requests to Locally Homed =
Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_RFO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : RFO Requests",
+        "UMask": "0x1848ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: LLC Prefetch Requests to Local=
ly Homed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_LLC_PF",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x189dff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All Prefetches to Locally Home=
d Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x199dff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Code Prefetches to Locally Hom=
ed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_CODE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x1910ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Prefetches to Locally Hom=
ed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_DATA_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x1981ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Prefetches to Locally Home=
d Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_RFO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : RFO Requests",
+        "UMask": "0x1908ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Requests and RFO Prefetche=
s to Locally Homed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_RFO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : RFO Requests",
+        "UMask": "0x19c8ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All Requests to Remotely Homed=
 Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTELY_HOMED_ADDRESS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Transactions homed remotely =
: Counts the number of times the LLC was accessed - this includes code, dat=
a, prefetches and hints coming from L2.  This has numerous filters availabl=
e.  Note the non-standard filtering equation.  This event will count reques=
ts that lookup the cache multiple times with multiple increments.  One must=
 ALWAYS set umask bit 0 and select a state or states to match.  Otherwise, =
the event will count nothing. : Transaction whose address resides in a remo=
te MC",
+        "UMask": "0x15dfff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Code Read/Prefetch Requests fr=
om a Remote Socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_CODE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x1a10ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Data Read/Prefetch Requests fr=
om a Remote Socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_DATA_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x1a01ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Requests/Prefetches from a=
 Remote Socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_RFO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : RFO Requests",
+        "UMask": "0x1a08ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Snoop Requests from a Remote S=
ocket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_SNP",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed",
+        "UMask": "0x1c19ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All RFO and RFO Prefetches",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.RFO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : All RFOs - Demand and Prefet=
ches",
+        "UMask": "0x1bc8ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Requests and RFO Prefetche=
s to Locally Homed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.RFO_LOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Locally HOMed RFOs - Demand =
and Prefetches",
+        "UMask": "0x9c8ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Writes to Locally Homed Memory=
 (includes writebacks from L1/L2)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.WRITE_LOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Writes",
+        "UMask": "0x842ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Writes to Remotely Homed Memor=
y (includes writebacks from L1/L2)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.WRITE_REMOTE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Remote Writes",
+        "UMask": "0x17c2ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : All Lines Victimized",
+        "UMask": "0xf",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : IA traffic : Counts the nu=
mber of lines that were victimized on a fill.  This can be filtered by the =
state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.IA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : IO traffic : Counts the nu=
mber of lines that were victimized on a fill.  This can be filtered by the =
state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.IO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - All Lines",
+        "UMask": "0x200f",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_E",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - Lines in E State"=
,
+        "UMask": "0x2002",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_F",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - Lines in F State"=
,
+        "UMask": "0x2008",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_M",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - Lines in M State"=
,
+        "UMask": "0x2001",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - Lines in S State"=
,
+        "UMask": "0x2004",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Remote - All Lines",
+        "UMask": "0x800f",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_E",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Remote - Lines in E State=
",
+        "UMask": "0x8002",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_M",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Remote - Lines in M State=
",
+        "UMask": "0x8001",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Remote - Lines in S State=
",
+        "UMask": "0x8004",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_E",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Lines in E state",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_M",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Lines in M state",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Lines in S State",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts when a RFO (the Read for Ownership iss=
ued before a  write) request hit a cacheline in the S (Shared) state.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.RFO_HIT_S",
+        "PerPkg": "1",
+        "PublicDescription": "Cbo Misc : RFO HitS",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : Local InvItoE : Count o=
f OSB snoop broadcasts. Counts by 1 per request causing OSB snoops to be br=
oadcast. Does not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.LOCAL_INVITOE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : Local Rd : Count of OSB=
 snoop broadcasts. Counts by 1 per request causing OSB snoops to be broadca=
st. Does not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.LOCAL_READ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : Off : Count of OSB snoo=
p broadcasts. Counts by 1 per request causing OSB snoops to be broadcast. D=
oes not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.OFF_PWRHEURISTIC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : Remote Rd : Count of OS=
B snoop broadcasts. Counts by 1 per request causing OSB snoops to be broadc=
ast. Does not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.REMOTE_READ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : RFO HitS Snoop Broadcas=
t : Count of OSB snoop broadcasts. Counts by 1 per request causing OSB snoo=
ps to be broadcast. Does not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.RFO_HITS_SNP_BCAST",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.ALLOC_EXCLUSIVE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.ALLOC_EXCLUSIVE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.ALLOC_SHARED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.ALLOC_SHARED",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.DEALLOC_EVCTCLN",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.DEALLOC_EVCTCLN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.DIRBACKED_ONLY",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.DIRBACKED_ONLY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.HIT_EXCLUSIVE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.HIT_EXCLUSIVE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.HIT_SHARED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.HIT_SHARED",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.INCLUSIVE_ONLY",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.INCLUSIVE_ONLY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.MISS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.MISS",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.UPDATE_EXCLUSIVE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.UPDATE_EXCLUSIVE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.UPDATE_SHARED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.UPDATE_SHARED",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.VICTIM_EXCLUSIVE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.VICTIM_EXCLUSIVE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.VICTIM_SHARED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.VICTIM_SHARED",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the total number of requests coming fr=
om a unit on this socket for exclusive ownership of a cache line without re=
ceiving data (INVITOE) to the CHA.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE",
+        "PerPkg": "1",
+        "PublicDescription": "HA Read and Write Requests : InvalItoE",
+        "UMask": "0x30",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the total number of requests coming fr=
om a unit on this socket for exclusive ownership of a cache line without re=
ceiving data (INVITOE) to the CHA.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the total number of requests coming fr=
om a remote socket for exclusive ownership of a cache line without receivin=
g data (INVITOE) to the CHA.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts read requests made into this CHA. Read=
s include all read opcodes (including RFO: the Read for Ownership issued be=
fore a  write) .",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS",
+        "PerPkg": "1",
+        "PublicDescription": "HA Read and Write Requests : Reads",
+        "UMask": "0x3",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts read requests coming from a unit on th=
is socket made into this CHA. Reads include all read opcodes (including RFO=
: the Read for Ownership issued before a  write).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts read requests coming from a remote soc=
ket made into the CHA. Reads include all read opcodes (including RFO: the R=
ead for Ownership issued before a  write).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts write requests made into the CHA, incl=
uding streaming, evictions, HitM (Reads from another core to a Modified cac=
heline), etc.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "HA Read and Write Requests : Writes",
+        "UMask": "0xc",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts  write requests coming from a unit on =
this socket made into this CHA, including streaming, evictions, HitM (Reads=
 from another core to a Modified cacheline), etc.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the total number of read requests made=
 into the Home Agent. Reads include all read opcodes (including RFO).  Writ=
es include all writes (streaming, evictions, HitM, etc).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR Inserts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All",
+        "UMask": "0xc001ffff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlush transactions from a CXL device which =
hit in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_CLFLUSH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8c7fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FsRdCur transactions from a CXL device which =
hit in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_FSRDCUR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8effd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FsRdCurPtl transactions from a CXL device whi=
ch hit in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_FSRDCURPTL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c9effd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM transactions from a CXL device which hit=
 in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_ITOM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc47fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMWr transactions from a CXL device which h=
it in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_ITOMWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc4ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "MemPushWr transactions from a CXL device whic=
h hit in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_MEMPUSHWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc6ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCiL transactions from a CXL device which hit=
 in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_WCIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c86ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WcilF transactions from a CXL device which hi=
t in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_WCILF",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c867fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WiL transactions from a CXL device which hit =
in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_WIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c87ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlush transactions from a CXL device which =
miss the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_CLFLUSH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8c7fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FsRdCur transactions from a CXL device which =
miss the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_FSRDCUR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8effe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FsRdCurPtl transactions from a CXL device whi=
ch miss the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_FSRDCURPTL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c9effe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM transactions from a CXL device which mis=
s the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_ITOM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc47fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMWr transactions from a CXL device which m=
iss the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_ITOMWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc4ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "MemPushWr transactions from a CXL device whic=
h miss the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_MEMPUSHWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc6ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCiL transactions from a CXL device which mis=
s the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_WCIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c86ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WcilF transactions from a CXL device which mi=
ss the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_WCILF",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c867fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WiL transactions from a CXL device which miss=
 the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_WIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c87ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All locally initiated requests from IA Cores"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from iA Cores",
+        "UMask": "0xc001ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlush events that are initiated from the Co=
re",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CLFlushes issued by iA Cores",
+        "UMask": "0xc8c7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read from local IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRDs issued by iA Cores",
+        "UMask": "0xc80fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read prefetch from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts; Code read prefetch from local I=
A that misses in the snoop filter",
+        "UMask": "0xc88fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read from local IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores",
+        "UMask": "0xc817ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRd PTEs issued by iA Cores due to a page wal=
k",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRDPTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRdPte issued by iA Cores due =
to a page walk",
+        "UMask": "0xc837ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read prefetch from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Prefs issued by iA Cores",
+        "UMask": "0xc897ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All locally initiated requests from IA Cores =
which hit the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Hit the LLC",
+        "UMask": "0xc001fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read from local IA that hit the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRds issued by iA Cores that H=
it the LLC",
+        "UMask": "0xc80ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read prefetch from local IA that hit the=
 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat hit the LLC",
+        "UMask": "0xc88ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All requests issued from IA cores to CXL acce=
lerator memory regions that hit the LLC.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018101",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read from local IA that hit the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores that H=
it the LLC",
+        "UMask": "0xc817fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRd PTEs issued by iA Cores due to page walks=
 that hit the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRDPTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRdPte issued by iA Cores due =
to a page walk that hit the LLC",
+        "UMask": "0xc837fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read prefetch from local IA that hit the=
 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Prefs issued by iA Cores t=
hat Hit the LLC",
+        "UMask": "0xc897fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM requests from local IA cores that hit th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by iA Cores that =
Hit LLC",
+        "UMask": "0xcc47fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch code read from loca=
l IA that hit the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefCode issued by iA Cores=
 that hit the LLC",
+        "UMask": "0xcccffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch data read from loca=
l IA that hit the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefData issued by iA Cores=
 that hit the LLC",
+        "UMask": "0xccd7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that hit the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that hit the LLC",
+        "UMask": "0xccc7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that hit the=
 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that H=
it the LLC",
+        "UMask": "0xc807fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t hit the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Hit the LLC",
+        "UMask": "0xc887fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM events that are initiated from the Core"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by iA Cores",
+        "UMask": "0xcc47ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNear requests from local IA cores",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears issued by iA Co=
res",
+        "UMask": "0xcd47ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch code read from loca=
l IA.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefCode issued by iA Cores=
",
+        "UMask": "0xcccfff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch data read from loca=
l IA.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefData issued by iA Cores=
",
+        "UMask": "0xccd7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores"=
,
+        "UMask": "0xccc7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All locally initiated requests from IA Cores =
which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Missed the LLC",
+        "UMask": "0xc001fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read from local IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRds issued by iA Cores that M=
issed the LLC",
+        "UMask": "0xc80ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CRDs from local IA cores to locally homed mem=
ory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd issued by iA Cores that Mi=
ssed the LLC - HOMed locally",
+        "UMask": "0xc80efe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read prefetch from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat Missed the LLC",
+        "UMask": "0xc88ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CRD Prefetches from local IA cores to locally=
 homed memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat Missed the LLC - HOMed locally",
+        "UMask": "0xc88efe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CRD Prefetches from local IA cores to remotel=
y homed memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat Missed the LLC - HOMed remotely",
+        "UMask": "0xc88f7e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CRDs from local IA cores to remotely homed me=
mory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd issued by iA Cores that Mi=
ssed the LLC - HOMed remotely",
+        "UMask": "0xc80f7e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All requests issued from IA cores to CXL acce=
lerator memory regions that miss the LLC.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read from local IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores that M=
issed the LLC",
+        "UMask": "0xc817fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRd PTEs issued by iA Cores due to a page wal=
k that missed the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRDPTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRdPte issued by iA Cores due =
to a page walk that missed the LLC",
+        "UMask": "0xc837fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRds and equivalent opcodes issued from an IA=
 core which miss the L3 and target memory in a CXL type 2 memory expander c=
ard.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_ACC",
+        "PerPkg": "1",
+        "PublicDescription": "DRds issued from an IA core which miss the L=
3 and target memory in a CXL type 2 memory expander card.",
+        "UMask": "0x10c8178201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRds issued by iA Cores targeting DDR Mem tha=
t Missed the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores target=
ing DDR Mem that Missed the LLC",
+        "UMask": "0xc8178601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read from local IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores that M=
issed the LLC - HOMed locally",
+        "UMask": "0xc816fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRds from local IA cores to locally homed DDR=
 addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores target=
ing DDR Mem that Missed the LLC - HOMed locally",
+        "UMask": "0xc8168601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRds from local IA cores to locally homed PMM=
 addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores target=
ing PMM Mem that Missed the LLC - HOMed locally",
+        "UMask": "0xc8168a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRds issued by iA Cores targeting PMM Mem tha=
t Missed the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores target=
ing PMM Mem that Missed the LLC",
+        "UMask": "0xc8178a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read prefetch from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Prefs issued by iA Cores t=
hat Missed the LLC",
+        "UMask": "0xc897fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "L2 data prefetches issued from an IA core whi=
ch miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8978201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRd Prefetches from local IA cores to DDR add=
resses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Prefs issued by iA Cores t=
argeting DDR Mem that Missed the LLC",
+        "UMask": "0xc8978601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read prefetch from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Inserts into the TOR from local IA cores whi=
ch miss the LLC and snoop filter with the opcode DRD_PREF, and target local=
 memory",
+        "UMask": "0xc896fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRd Prefetches from local IA cores to locally=
 homed DDR addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Prefs issued by iA Cores t=
argeting DDR Mem that Missed the LLC - HOMed locally",
+        "UMask": "0xc8968601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRd Prefetches from local IA cores to locally=
 homed PMM addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Prefs issued by iA Cores t=
argeting PMM Mem that Missed the LLC - HOMed locally",
+        "UMask": "0xc8968a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRd Prefetches from local IA cores to PMM add=
resses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Prefs issued by iA Cores t=
argeting PMM Mem that Missed the LLC",
+        "UMask": "0xc8978a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read prefetch from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Inserts into the TOR from local IA cores whi=
ch miss the LLC and snoop filter with the opcode DRD_PREF, and target remot=
e memory",
+        "UMask": "0xc8977e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRd Prefetches from local IA cores to remotel=
y homed DDR addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Prefs issued by iA Cores t=
argeting DDR Mem that Missed the LLC - HOMed remotely",
+        "UMask": "0xc8970601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRd Prefetches from local IA cores to remotel=
y homed PMM addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Prefs issued by iA Cores t=
argeting PMM Mem that Missed the LLC - HOMed remotely",
+        "UMask": "0xc8970a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read from local IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores that M=
issed the LLC - HOMed remotely",
+        "UMask": "0xc8177e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRds from local IA cores to remotely homed DD=
R addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores target=
ing DDR Mem that Missed the LLC - HOMed remotely",
+        "UMask": "0xc8170601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRds from local IA cores to remotely homed PM=
M addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores target=
ing PMM Mem that Missed the LLC - HOMed remotely",
+        "UMask": "0xc8170a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM requests from local IA cores that miss t=
he cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by iA Cores that =
Missed LLC",
+        "UMask": "0xcc47fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch code read from loca=
l IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefCode issued by iA Cores=
 that missed the LLC",
+        "UMask": "0xcccffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch data read from loca=
l IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefData issued by iA Cores=
 that missed the LLC",
+        "UMask": "0xccd7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "LLC data prefetches issued from an IA core wh=
ich miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccd78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that missed the LLC",
+        "UMask": "0xccc7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "L2 RFO prefetches issued from an IA core whic=
h miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8878201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to locally=
 homed DDR addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting DDR that missed the LLC - HOMed locally",
+        "UMask": "0xc8668601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to locally=
 homed PMM addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCILF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting PMM that missed the LLC - HOMed locally",
+        "UMask": "0xc8668a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to locally =
homed DDR addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting DDR that missed the LLC - HOMed locally",
+        "UMask": "0xc86e8601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to locally =
homed PMM addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCIL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting PMM that missed the LLC - HOMed locally",
+        "UMask": "0xc86e8a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to remotel=
y homed DDR addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting DDR that missed the LLC - HOMed remotely",
+        "UMask": "0xc8670601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to remotel=
y homed PMM addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCILF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting PMM that missed the LLC - HOMed remotely",
+        "UMask": "0xc8670a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to remotely=
 homed DDR addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting DDR that missed the LLC - HOMed remotely",
+        "UMask": "0xc86f0601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to remotely=
 homed PMM addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCIL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting PMM that missed the LLC - HOMed remotely",
+        "UMask": "0xc86f0a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC",
+        "UMask": "0xc807fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RFOs issued from an IA core which miss the L3=
 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8078201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC - HOMed locally",
+        "UMask": "0xc806fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Missed the LLC",
+        "UMask": "0xc887fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "LLC RFO prefetches issued from an IA core whi=
ch miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccc78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Missed the LLC - HOMed locally",
+        "UMask": "0xc886fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Missed the LLC - HOMed remotely",
+        "UMask": "0xc8877e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC - HOMed remotely",
+        "UMask": "0xc8077e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UCRDF requests from local IA cores that miss =
the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_UCRDF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : UCRdFs issued by iA Cores that=
 Missed LLC",
+        "UMask": "0xc877de01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from a local IA core that miss =
the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores that =
Missed the LLC",
+        "UMask": "0xc86ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA core that miss t=
he cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLF issued by iA Cores that =
Missed the LLC",
+        "UMask": "0xc867fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to DDR hom=
ed addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting DDR that missed the LLC",
+        "UMask": "0xc8678601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to PMM hom=
ed addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting PMM that missed the LLC",
+        "UMask": "0xc8678a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to DDR home=
d addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting DDR that missed the LLC",
+        "UMask": "0xc86f8601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from a local IA core to PMM hom=
ed addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting PMM that missed the LLC",
+        "UMask": "0xc86f8a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WIL requests from local IA cores that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WiLs issued by iA Cores that M=
issed LLC",
+        "UMask": "0xc87fde01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores",
+        "UMask": "0xc807ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores",
+        "UMask": "0xc887ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "SpecItoM events that are initiated from the C=
ore",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_SPECITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : SpecItoMs issued by iA Cores",
+        "UMask": "0xcc57ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbEFtoEs issued by iA Cores.  (Non Modified W=
rite Backs)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc3fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbEFtoIs issued by iA Cores .  (Non Modified =
Write Backs)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc37ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbMtoEs issued by iA Cores .  (Modified Write=
 Backs)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc2fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbMtoI requests from local IA cores",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WbMtoIs issued by iA Cores",
+        "UMask": "0xcc27ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbStoIs issued by iA Cores .  (Non Modified W=
rite Backs)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBSTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc67ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from a local IA core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WCIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores",
+        "UMask": "0xc86fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLF issued by iA Cores",
+        "UMask": "0xc867ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR inserts from local IO devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from IO Devices",
+        "UMask": "0xc001ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlush requests from IO devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CLFlushes issued by IO Devices=
",
+        "UMask": "0xc8c3ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR inserts from local IO devices which h=
it the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from IO Devices t=
hat hit the LLC",
+        "UMask": "0xc001fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMs from local IO devices which hit the cac=
he",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc43fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNears, indicating a partial write re=
quest, from IO Devices that hit the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that hit the LLC",
+        "UMask": "0xcd43fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCURs issued by IO devices which hit the =
LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that hit the LLC",
+        "UMask": "0xc8f3fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RFOs from local IO devices which hit the cach=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by IO Devices that=
 hit the LLC",
+        "UMask": "0xc803fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR ItoM inserts from local IO devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices",
+        "UMask": "0xcc43ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNears, indicating a partial write re=
quest, from IO Devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices",
+        "UMask": "0xcd43ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNear (partial write) transactions fr=
om an IO device that addresses memory on the local socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that address memory on the local sock=
et",
+        "UMask": "0xcd42ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNear (partial write) transactions fr=
om an IO device that addresses memory on a remote socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that address memory on a remote socke=
t",
+        "UMask": "0xcd437f04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM (write) transactions from an IO device t=
hat addresses memory on the local socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoM, indicating a write reque=
st, from IO Devices that address memory on the local socket",
+        "UMask": "0xcc42ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM (write) transactions from an IO device t=
hat addresses memory on a remote socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoM, indicating a write reque=
st, from IO Devices that address memory on a remote socket",
+        "UMask": "0xcc437f04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR inserts from local IO devices which m=
iss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from IO Devices t=
hat missed the LLC",
+        "UMask": "0xc001fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR ItoM inserts from local IO devices wh=
ich miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t missed the LLC",
+        "UMask": "0xcc43fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNears, indicating a partial write re=
quest, from IO Devices that missed the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd43fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCURs issued by IO devices which miss the=
 LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that missed the LLC",
+        "UMask": "0xc8f3fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR RFO inserts from local IO devices whi=
ch miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by IO Devices that=
 missed the LLC",
+        "UMask": "0xc803fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCURs issued by IO devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
",
+        "UMask": "0xc8f3ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCUR (read) transactions from an IO devic=
e that addresses memory on the local socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that addresses memory on the local socket",
+        "UMask": "0xc8f2ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCUR (read) transactions from an IO devic=
e that addresses memory on a remote socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that addresses memory on a remote socket",
+        "UMask": "0xc8f37f04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RFOs from local IO devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by IO Devices",
+        "UMask": "0xc803ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBMtoI requests from IO devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WbMtoIs issued by IO Devices",
+        "UMask": "0xcc23ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts for SF or LLC Evictions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LLC_OR_SF_EVICTIONS",
+        "PerPkg": "1",
+        "PublicDescription": "TOR allocation occurred as a result of SF/LL=
C evictions (came from the ISMQ)",
+        "UMask": "0xc001ff02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All locally initiated requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All from Local iA and IO",
+        "UMask": "0xc000ff05",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All from Local iA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_IA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All from Local iA",
+        "UMask": "0xc000ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All from Local IO",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_IO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All from Local IO",
+        "UMask": "0xc000ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All remote requests (e.g. snoops, writebacks)=
 that came from remote sockets",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.REM_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All Remote Requests",
+        "UMask": "0xc001ffc8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All snoops to this LLC that came from remote =
sockets",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.REM_SNPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All Snoops from Remote",
+        "UMask": "0xc001ff08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Occupancy for all TOR entries",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All",
+        "UMask": "0xc001ffff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlush transactions from a=
 CXL device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_CLFLUSH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8c7fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for FsRdCur transactions from a=
 CXL device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_FSRDCUR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8effd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for FsRdCurPtl transactions fro=
m a CXL device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_FSRDCURPTL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c9effd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM transactions from a CX=
L device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_ITOM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc47fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMWr transactions from a =
CXL device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_ITOMWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc4ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for MemPushWr transactions from=
 a CXL device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_MEMPUSHWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc6ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCiL transactions from a CX=
L device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_WCIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c86ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WcilF transactions from a C=
XL device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_WCILF",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c867fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WiL transactions from a CXL=
 device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_WIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c87ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlush transactions from a=
 CXL device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_CLFLUSH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8c7fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for FsRdCur transactions from a=
 CXL device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_FSRDCUR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8effe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for FsRdCurPtl transactions fro=
m a CXL device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_FSRDCURPTL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c9effe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM transactions from a CX=
L device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_ITOM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc47fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMWr transactions from a =
CXL device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_ITOMWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc4ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for MemPushWr transactions from=
 a CXL device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_MEMPUSHWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc6ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCiL transactions from a CX=
L device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_WCIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c86ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WcilF transactions from a C=
XL device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_WCILF",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c867fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WiL transactions from a CXL=
 device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_WIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c87ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts from IA Cores",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from iA Cores",
+        "UMask": "0xc001ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlush events that are ini=
tiated from the Core",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CLFlushes issued by iA Cores=
",
+        "UMask": "0xc8c7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read from local IA tha=
t miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRDs issued by iA Cores",
+        "UMask": "0xc80fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read prefetch from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Code read prefetch from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc88fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read from local IA tha=
t miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores",
+        "UMask": "0xc817ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRd PTEs issued by iA Cores=
 due to a page walk",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRDPTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRdPte issued by iA Cores du=
e to a page walk",
+        "UMask": "0xc837ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read prefetch from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
",
+        "UMask": "0xc897ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts from IA Cores which hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from iA Cores t=
hat Hit the LLC",
+        "UMask": "0xc001fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read from local IA tha=
t hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that=
 Hit the LLC",
+        "UMask": "0xc80ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read prefetch from loc=
al IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that hit the LLC",
+        "UMask": "0xc88ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All requests issued from IA=
 cores to CXL accelerator memory regions that hit the LLC.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018101",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read from local IA tha=
t hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that=
 Hit the LLC",
+        "UMask": "0xc817fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRd PTEs issued by iA Cores=
 due to page walks that hit the LLC",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRDPTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRdPte issued by iA Cores du=
e to a page walk that hit the LLC",
+        "UMask": "0xc837fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read prefetch from loc=
al IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 that Hit the LLC",
+        "UMask": "0xc897fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM requests from local IA=
 cores that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by iA Cores tha=
t Hit LLC",
+        "UMask": "0xcc47fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch c=
ode read from local IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefCode issued by iA Cor=
es that hit the LLC",
+        "UMask": "0xcccffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch d=
ata read from local IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefData issued by iA Cor=
es that hit the LLC",
+        "UMask": "0xccd7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch r=
ead for ownership from local IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s that hit the LLC",
+        "UMask": "0xccc7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Hit the LLC",
+        "UMask": "0xc807fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
 that Hit the LLC",
+        "UMask": "0xc887fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM events that are initia=
ted from the Core",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by iA Cores",
+        "UMask": "0xcc47ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNear requests from=
 local IA cores",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears issued by iA =
Cores",
+        "UMask": "0xcd47ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch c=
ode read from local IA.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefCode issued by iA Cor=
es",
+        "UMask": "0xcccfff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch d=
ata read from local IA.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefData issued by iA Cor=
es",
+        "UMask": "0xccd7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch r=
ead for ownership from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s",
+        "UMask": "0xccc7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts from IA Cores which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from iA Cores t=
hat Missed the LLC",
+        "UMask": "0xc001fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read from local IA tha=
t miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that=
 Missed the LLC",
+        "UMask": "0xc80ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CRDs from local IA cores to=
 locally homed memory",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd issued by iA Cores that =
Missed the LLC - HOMed locally",
+        "UMask": "0xc80efe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read prefetch from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that Missed the LLC",
+        "UMask": "0xc88ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CRD Prefetches from local I=
A cores to locally homed memory",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that Missed the LLC - HOMed locally",
+        "UMask": "0xc88efe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CRD Prefetches from local I=
A cores to remotely homed memory",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that Missed the LLC - HOMed remotely",
+        "UMask": "0xc88f7e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CRDs from local IA cores to=
 remotely homed memory",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd issued by iA Cores that =
Missed the LLC - HOMed remotely",
+        "UMask": "0xc80f7e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All requests issued from IA=
 cores to CXL accelerator memory regions that miss the LLC.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read from local IA tha=
t miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that=
 Missed the LLC",
+        "UMask": "0xc817fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRd PTEs issued by iA Cores=
 due to a page walk that missed the LLC",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRDPTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRdPte issued by iA Cores du=
e to a page walk that missed the LLC",
+        "UMask": "0xc837fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRds and equivalent opcodes=
 issued from an IA core which miss the L3 and target memory in a CXL type 2=
 memory expander card.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8178201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRds issued by iA Cores tar=
geting DDR Mem that Missed the LLC",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores targ=
eting DDR Mem that Missed the LLC",
+        "UMask": "0xc8178601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read from local IA tha=
t miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that=
 Missed the LLC - HOMed locally",
+        "UMask": "0xc816fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRds from local IA cores to=
 locally homed DDR addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores targ=
eting DDR Mem that Missed the LLC - HOMed locally",
+        "UMask": "0xc8168601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRds from local IA cores to=
 locally homed PMM addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores targ=
eting PMM Mem that Missed the LLC - HOMed locally",
+        "UMask": "0xc8168a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRds issued by iA Cores tar=
geting PMM Mem that Missed the LLC",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores targ=
eting PMM Mem that Missed the LLC",
+        "UMask": "0xc8178a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read prefetch from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 that Missed the LLC",
+        "UMask": "0xc897fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for L2 data prefetches issued f=
rom an IA core which miss the L3 and target memory in a CXL type 2 accelera=
tor.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8978201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRd Prefetches from local I=
A cores to DDR addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 targeting DDR Mem that Missed the LLC",
+        "UMask": "0xc8978601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read prefetch from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Data read prefetch from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc896fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRd Prefetches from local I=
A cores to locally homed DDR addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_LOCAL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 targeting DDR Mem that Missed the LLC - HOMed locally",
+        "UMask": "0xc8968601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRd Prefetches from local I=
A cores to locally homed PMM addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_LOCAL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 targeting PMM Mem that Missed the LLC - HOMed locally",
+        "UMask": "0xc8968a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRd Prefetches from local I=
A cores to PMM addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 targeting PMM Mem that Missed the LLC",
+        "UMask": "0xc8978a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read prefetch from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Data read prefetch from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc8977e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRd Prefetches from local I=
A cores to remotely homed DDR addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_REMOTE_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 targeting DDR Mem that Missed the LLC - HOMed remotely",
+        "UMask": "0xc8970601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRd Prefetches from local I=
A cores to remotely homed PMM addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_REMOTE_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 targeting PMM Mem that Missed the LLC - HOMed remotely",
+        "UMask": "0xc8970a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read from local IA tha=
t miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that=
 Missed the LLC - HOMed remotely",
+        "UMask": "0xc8177e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRds from local IA cores to=
 remotely homed DDR addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores targ=
eting DDR Mem that Missed the LLC - HOMed remotely",
+        "UMask": "0xc8170601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRds from local IA cores to=
 remotely homed PMM addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores targ=
eting PMM Mem that Missed the LLC - HOMed remotely",
+        "UMask": "0xc8170a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM requests from local IA=
 cores that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by iA Cores tha=
t Missed LLC",
+        "UMask": "0xcc47fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch c=
ode read from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefCode issued by iA Cor=
es that missed the LLC",
+        "UMask": "0xcccffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch d=
ata read from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefData issued by iA Cor=
es that missed the LLC",
+        "UMask": "0xccd7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for LLC data prefetches issued =
from an IA core which miss the L3 and target memory in a CXL type 2 acceler=
ator.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccd78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch r=
ead for ownership from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s that missed the LLC",
+        "UMask": "0xccc7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for L2 RFO prefetches issued fr=
om an IA core which miss the L3 and target memory in a CXL type 2 accelerat=
or.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8878201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to locally homed DDR addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting DDR that missed the LLC - HOMed locally",
+        "UMask": "0xc8668601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to locally homed PMM addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCILF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting PMM that missed the LLC - HOMed locally",
+        "UMask": "0xc8668a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to locally homed DDR addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting DDR that missed the LLC - HOMed locally",
+        "UMask": "0xc86e8601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to locally homed PMM addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCIL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting PMM that missed the LLC - HOMed locally",
+        "UMask": "0xc86e8a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to remotely homed DDR addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting DDR that missed the LLC - HOMed remotely",
+        "UMask": "0xc8670601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to remotely homed PMM addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCILF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting PMM that missed the LLC - HOMed remotely",
+        "UMask": "0xc8670a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to remotely homed DDR addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting DDR that missed the LLC - HOMed remotely",
+        "UMask": "0xc86f0601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to remotely homed PMM addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCIL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting PMM that missed the LLC - HOMed remotely",
+        "UMask": "0xc86f0a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Missed the LLC",
+        "UMask": "0xc807fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for RFOs issued from an IA core=
 which miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8078201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Missed the LLC - HOMed locally",
+        "UMask": "0xc806fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
 that Missed the LLC",
+        "UMask": "0xc887fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for LLC RFO prefetches issued f=
rom an IA core which miss the L3 and target memory in a CXL type 2 accelera=
tor.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccc78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
 that Missed the LLC - HOMed locally",
+        "UMask": "0xc886fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
 that Missed the LLC - HOMed remotely",
+        "UMask": "0xc8877e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Missed the LLC - HOMed remotely",
+        "UMask": "0xc8077e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for UCRDF requests from local I=
A cores that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_UCRDF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : UCRdFs issued by iA Cores th=
at Missed LLC",
+        "UMask": "0xc877de01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from a local =
IA core that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tha=
t Missed the LLC",
+        "UMask": "0xc86ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A core that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLF issued by iA Cores tha=
t Missed the LLC",
+        "UMask": "0xc867fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to DDR homed addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting DDR that missed the LLC",
+        "UMask": "0xc8678601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to PMM homed addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting PMM that missed the LLC",
+        "UMask": "0xc8678a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to DDR homed addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting DDR that missed the LLC",
+        "UMask": "0xc86f8601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from a local =
IA core to PMM homed addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting PMM that missed the LLC",
+        "UMask": "0xc86f8a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WIL requests from local IA =
cores that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WiLs issued by iA Cores that=
 Missed LLC",
+        "UMask": "0xc87fde01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores",
+        "UMask": "0xc807ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
",
+        "UMask": "0xc887ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for SpecItoM events that are in=
itiated from the Core",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_SPECITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : SpecItoMs issued by iA Cores=
",
+        "UMask": "0xcc57ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WbMtoI requests from local =
IA cores",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WbMtoIs issued by iA Cores",
+        "UMask": "0xcc27ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from a local =
IA core",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores",
+        "UMask": "0xc86fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A core",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLF issued by iA Cores",
+        "UMask": "0xc867ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR inserts from local =
IO devices",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
",
+        "UMask": "0xc001ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlush requests from IO de=
vices",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CLFlushes issued by IO Devic=
es",
+        "UMask": "0xc8c3ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR inserts from local =
IO devices which hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 that hit the LLC",
+        "UMask": "0xc001fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMs from local IO devices=
 which hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat Hit the LLC",
+        "UMask": "0xcc43fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNears, indicating =
a partial write request, from IO Devices that hit the LLC",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that hit the LLC",
+        "UMask": "0xcd43fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCURs issued by IO devi=
ces which hit the LLC",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that hit the LLC",
+        "UMask": "0xc8f3fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for RFOs from local IO devices =
which hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by IO Devices th=
at hit the LLC",
+        "UMask": "0xc803fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR ItoM inserts from l=
ocal IO devices",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices",
+        "UMask": "0xcc43ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNears, indicating =
a partial write request, from IO Devices",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices",
+        "UMask": "0xcd43ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR inserts from local =
IO devices which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 that missed the LLC",
+        "UMask": "0xc001fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR ItoM inserts from l=
ocal IO devices which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat missed the LLC",
+        "UMask": "0xcc43fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNears, indicating =
a partial write request, from IO Devices that missed the LLC",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd43fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNear transactions =
from an IO device on the local socket that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR_LOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd42fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNear transactions =
from an IO device on a remote socket that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR_REMOTE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd437e04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM transactions from an I=
O device on the local socket that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM_LOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat missed the LLC",
+        "UMask": "0xcc42fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM transactions from an I=
O device on a remote socket that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM_REMOTE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat missed the LLC",
+        "UMask": "0xcc437e04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCURs issued by IO devi=
ces which miss the LLC",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that missed the LLC",
+        "UMask": "0xc8f3fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCUR transactions from =
an IO device on the local socket that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR_LOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that missed the LLC",
+        "UMask": "0xc8f2fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCUR transactions from =
an IO device on a remote socket that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR_REMOTE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that missed the LLC",
+        "UMask": "0xc8f37e04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR RFO inserts from lo=
cal IO devices which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by IO Devices th=
at missed the LLC",
+        "UMask": "0xc803fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCURs issued by IO devi=
ces",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es",
+        "UMask": "0xc8f3ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for RFOs from local IO devices"=
,
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by IO Devices",
+        "UMask": "0xc803ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WBMtoI requests from IO dev=
ices",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WbMtoIs issued by IO Devices=
",
+        "UMask": "0xcc23ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All from Local iA and IO",
+        "UMask": "0xc000ff05",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All from Local iA",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All from Local iA",
+        "UMask": "0xc000ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All from Local IO",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All from Local IO",
+        "UMask": "0xc000ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All remote requests (e.g. s=
noops, writebacks) that came from remote sockets",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.REM_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All Remote Requests",
+        "UMask": "0xc001ffc8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All snoops to this LLC that=
 came from remote sockets",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.REM_SNPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All Snoops from Remote",
+        "UMask": "0xc001ff08",
+        "Unit": "CHA"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cxl.json b=
/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cxl.json
new file mode 100644
index 000000000000..383a5ba5a697
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cxl.json
@@ -0,0 +1,31 @@
+[
+    {
+        "BriefDescription": "B2CXL Clockticks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_B2CXL_CLOCKTICKS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "B2CXL"
+    },
+    {
+        "BriefDescription": "Number of Allocation to Mem Data Packing buff=
er",
+        "Counter": "4,5,6,7",
+        "EventCode": "0x41",
+        "EventName": "UNC_CXLCM_RxC_PACK_BUF_INSERTS.MEM_DATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CXLCM"
+    },
+    {
+        "BriefDescription": "Number of Allocation to M2S Data AGF",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_CXLDP_TxC_AGF_INSERTS.M2S_DATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CXLDP"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconne=
ct.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.=
json
new file mode 100644
index 000000000000..856ee985ecd4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
@@ -0,0 +1,1849 @@
+[
+    {
+        "BriefDescription": "Clockticks of the mesh to memory (B2CMI)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_B2CMI_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of time D2C was not honoure=
d by egress due to directory state constraints",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_B2CMI_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of times B2CMI egress did D=
2C (direct to core)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_B2CMI_DIRECT2CORE_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of times D2C wasn't honoure=
d even though the incoming request had d2c set for non cisgress txn",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_B2CMI_DIRECT2CORE_TXN_OVERRIDE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of d2k wasn't done due to c=
redit constraints",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_NOT_TAKEN_CREDITS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Direct to UPI Transactions - Ignored due to l=
ack of credits : All : Counts the number of d2k wasn't done due to credit c=
onstraints",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_NOT_TAKEN_CREDITS.EGRESS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of time D2K was not honoure=
d by egress due to directory state constraints",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_NOT_TAKEN_DIRSTATE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Cycles when Direct2UPI was Disabled : Egress =
Ignored D2U : Counts the number of time D2K was not honoured by egress due =
to directory state constraints",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_NOT_TAKEN_DIRSTATE.EGRESS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of times egress did D2K (Di=
rect to KTI)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of times D2K wasn't honoure=
d even though the incoming request had d2k set for non cisgress txn",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_TXN_OVERRIDE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit Clean",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.CLEAN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x38",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On NonDirty Line in A State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.CLEAN_A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On NonDirty Line in I State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.CLEAN_I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On NonDirty Line in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.CLEAN_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit Dirty (modified)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.DIRTY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On Dirty Line in A State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.DIRTY_A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On Dirty Line in I State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.DIRTY_I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On Dirty Line in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.DIRTY_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of 1lm or 2lm hit read data=
 returns to egress with any directory to non persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_B2CMI_DIRECTORY_LOOKUP.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of 1lm or 2lm hit read data=
 returns to egress with directory A to non persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_B2CMI_DIRECTORY_LOOKUP.STATE_A",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of 1lm or 2lm hit read data=
 returns to egress with directory I to non persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_B2CMI_DIRECTORY_LOOKUP.STATE_I",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of 1lm or 2lm hit read data=
 returns to egress with directory S to non persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_B2CMI_DIRECTORY_LOOKUP.STATE_S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of 1lm or 2lm hit read  da=
ta returns to egress with directory S to non persistent memory",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss Clean",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.CLEAN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x38",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On NonDirty Line in A State"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.CLEAN_A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On NonDirty Line in I State"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.CLEAN_I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On NonDirty Line in S State"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.CLEAN_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss Dirty (modified)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.DIRTY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On Dirty Line in A State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.DIRTY_A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On Dirty Line in I State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.DIRTY_I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On Dirty Line in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.DIRTY_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any A2I Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.A2I",
+        "PerPkg": "1",
+        "UMask": "0x320",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any A2S Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.A2S",
+        "PerPkg": "1",
+        "UMask": "0x340",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts cisgress directory updates",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.ANY",
+        "PerPkg": "1",
+        "UMask": "0x301",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts any 1lm or 2lm hit data return that wo=
uld result in directory update to non persistent memory (DRAM)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.HIT_ANY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x101",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in near memory to the A stat=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.HIT_X2A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x114",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in near memory to the I stat=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.HIT_X2I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x128",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in near memory to the S stat=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.HIT_X2S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x142",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any I2A Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.I2A",
+        "PerPkg": "1",
+        "UMask": "0x304",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any I2S Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.I2S",
+        "PerPkg": "1",
+        "UMask": "0x302",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in far memory to the A state=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.MISS_X2A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x214",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in far memory to the I state=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.MISS_X2I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x228",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in far memory to the S state=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.MISS_X2S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x242",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any S2A Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.S2A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x310",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any S2I Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.S2I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x308",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update to the A state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.X2A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x314",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update to the I state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.X2I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x328",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update to the S state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.X2S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x342",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts any read",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_B2CMI_IMC_READS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x104",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts normal reads issue to CMI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_B2CMI_IMC_READS.NORMAL",
+        "PerPkg": "1",
+        "UMask": "0x101",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Count reads to NM region",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_B2CMI_IMC_READS.TO_DDR_AS_CACHE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x110",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts reads to 1lm non persistent memory reg=
ions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_B2CMI_IMC_READS.TO_DDR_AS_MEM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x108",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "All Writes - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.ALL",
+        "PerPkg": "1",
+        "UMask": "0x110",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Full Non-ISOCH - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.FULL",
+        "PerPkg": "1",
+        "UMask": "0x101",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Non-Inclusive - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.NI",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Non-Inclusive Miss - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.NI_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Partial Non-ISOCH - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.PARTIAL",
+        "PerPkg": "1",
+        "UMask": "0x102",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "DDR, acting as Cache - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.TO_DDR_AS_CACHE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x140",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "DDR - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.TO_DDR_AS_MEM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x120",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : UPI - Ch 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x56",
+        "EventName": "UNC_B2CMI_PREFCAM_INSERTS.CH0_UPI",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : XPT - Ch 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x56",
+        "EventName": "UNC_B2CMI_PREFCAM_INSERTS.CH0_XPT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : UPI - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x56",
+        "EventName": "UNC_B2CMI_PREFCAM_INSERTS.UPI_ALLCH",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : XPT -All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x56",
+        "EventName": "UNC_B2CMI_PREFCAM_INSERTS.XPT_ALLCH",
+        "PerPkg": "1",
+        "PublicDescription": "Prefetch CAM Inserts : XPT - All Channels",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_B2CMI_PREFCAM_OCCUPANCY.CH0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads and WRNI which were a hi=
t",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.ALL",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads which were a hit clean",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.RD_CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads which were a hit dirty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.RD_DIRTY",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm WRNI which were a hit clean",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.WR_CLEAN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm WRNI which were a hit dirty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.WR_DIRTY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm second way read miss for a WrN=
I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm second way read miss for a WrN=
I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.DIRTY",
+        "PerPkg": "1",
+        "UMask": "0xa",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm second way read miss for a Rd"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.RD_2WAY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads which were a miss and th=
e cache line is unmodified",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.RD_CLEAN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads which were a miss and th=
e cache line is modified",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.RD_DIRTY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm second way read miss for a WrN=
I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.WR_2WAY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm WRNI which were a miss and the=
 cache line is unmodified",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.WR_CLEAN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm WRNI which were a miss and the=
 cache line is modified",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.WR_DIRTY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Tracker Inserts : Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_B2CMI_TRACKER_INSERTS.CH0",
+        "PerPkg": "1",
+        "UMask": "0x104",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_B2CMI_TRACKER_OCCUPANCY.CH0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Write Tracker Inserts : Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_B2CMI_WR_TRACKER_INSERTS.CH0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "UNC_B2HOT_CLOCKTICKS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_B2HOT_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Clockticks for the B2HOT unit",
+        "UMask": "0x1",
+        "Unit": "B2HOT"
+    },
+    {
+        "BriefDescription": "Number of uclks in domain",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_B2UPI_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "B2UPI"
+    },
+    {
+        "BriefDescription": "Total Write Cache Occupancy : Mem",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0F",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.MEM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "IRP Clockticks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_I_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound read requests received by the IRP and=
 inserted into the FAF queue",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_I_FAF_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "FAF occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_I_FAF_OCCUPANCY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1 : Lost Forward : Snoop pu=
lled away ownership before a write was committed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_I_MISC1.LOST_FWD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound write (fast path) requests to coheren=
t memory, received by the IRP resulting in write ownership requests issued =
by IRP to the mesh.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "MDF Clockticks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_MDF_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of packets bypassing the ingress queue=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_MDF_RxR_BYPASS.AD_BNC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of packets bypassing the ingress queue=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_MDF_RxR_BYPASS.AD_CRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of packets bypassing the ingress queue=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_MDF_RxR_BYPASS.AK",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of packets bypassing the ingress queue=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_MDF_RxR_BYPASS.BL_BNC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of packets bypassing the ingress queue=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_MDF_RxR_BYPASS.BL_CRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of packets bypassing the ingress queue=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_MDF_RxR_BYPASS.IV",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of allocations into the Ingress  used =
to queue up requests from the mesh (AD_BNC)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_MDF_RxR_INSERTS.AD_BNC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of allocations into the Ingress  used =
to queue up requests from the mesh (AD)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_MDF_RxR_INSERTS.AD_CRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of allocations into the Ingress  used =
to queue up requests from the mesh (AK)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_MDF_RxR_INSERTS.AK",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of allocations into the Ingress  used =
to queue up requests from the mesh (BL_BNC)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_MDF_RxR_INSERTS.BL_BNC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of allocations into the Ingress  used =
to queue up requests from the mesh (BL_CRD)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_MDF_RxR_INSERTS.BL_CRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of allocations into the Ingress  used =
to queue up requests from the mesh (IV)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_MDF_RxR_INSERTS.IV",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Occupancy counts for the Ingress buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_MDF_RxR_OCCUPANCY.AD_BNC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Occupancy counts for the Ingress buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_MDF_RxR_OCCUPANCY.AD_CRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Occupancy counts for the Ingress buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_MDF_RxR_OCCUPANCY.AK",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Occupancy counts for the Ingress buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_MDF_RxR_OCCUPANCY.BL_BNC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Occupancy counts for the Ingress buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_MDF_RxR_OCCUPANCY.BL_CRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Occupancy counts for the Ingress buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_MDF_RxR_OCCUPANCY.IV",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Egress bypasses for for AD_BNC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_MDF_TxR_BYPASS.AD_BNC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Egress bypasses for for AD_CRD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_MDF_TxR_BYPASS.AD_CRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Egress bypasses for for AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_MDF_TxR_BYPASS.AK",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Egress bypasses for for BL_BNC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_MDF_TxR_BYPASS.BL_BNC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Egress bypasses for for BL_CRD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_MDF_TxR_BYPASS.BL_CRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Egress bypasses for for IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_MDF_TxR_BYPASS.IV",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of egress inserts for for AD_BNC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_MDF_TxR_INSERTS.AD_BNC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of egress inserts for for AD_CRD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_MDF_TxR_INSERTS.AD_CRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of egress inserts for for AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_MDF_TxR_INSERTS.AK",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of egress inserts for for BL_BNC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_MDF_TxR_INSERTS.BL_BNC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of egress inserts for for BL_CRD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_MDF_TxR_INSERTS.BL_CRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of egress inserts for for IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_MDF_TxR_INSERTS.IV",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Egress occupancy for for AD_BNC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_MDF_TxR_OCCUPANCY.AD_BNC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Egress occupancy for for AD_CRD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_MDF_TxR_OCCUPANCY.AD_CRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Egress occupancy for for AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_MDF_TxR_OCCUPANCY.AK",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Egress occupancy for for BL_BNC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_MDF_TxR_OCCUPANCY.BL_BNC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Egress occupancy for for BL_CRD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_MDF_TxR_OCCUPANCY.BL_CRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Egress occupancy for for IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_MDF_TxR_OCCUPANCY.IV",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of UPI LL clock cycles while the event=
 is enabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_UPI_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of kfclks",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Cycles in L1 : Number of UPI qfclk cycles spe=
nt in L1 power mode.  L1 is a mode that totally shuts down a UPI link.  Use=
 edge detect to count the number of instances when the UPI link entered L1.=
  Link power states are per link and per direction, so for example the Tx d=
irection could be in one state while Rx was in another. Because L1 totally =
shuts down the link, it takes a good amount of time to exit this mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_UPI_L1_POWER_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xe",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Bypass, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10e",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Standard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Standard, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10f",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Reque=
st",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.REQ",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Reque=
st, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.REQ_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x108",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - Conflict",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSPCNFLT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1aa",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - Invalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSPI",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x12a",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_DATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xc",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - Data, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_DATA_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10c",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - No Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_NODATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xa",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - No Data, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_NODATA_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10a",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Snoop=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.SNP",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Snoop=
, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.SNP_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x109",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Write=
back",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.WB",
+        "PerPkg": "1",
+        "UMask": "0xd",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Write=
back, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.WB_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10d",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : All Data : Shows legal=
 flit time (hides impact of L0p and L0c).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.ALL_DATA",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Null FLITs received from any slot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.ALL_NULL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Valid Flits Received : Null FLITs received f=
rom any slot",
+        "UMask": "0x27",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Data : Shows legal fli=
t time (hides impact of L0p and L0c). : Count Data Flits (which consume all=
 slots), but how much to count is based on Slot0-2 mask, so count can be 0-=
3 depending on which slots are enabled for counting..",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.DATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Idle : Shows legal fli=
t time (hides impact of L0p and L0c).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.IDLE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x47",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : LLCRD Not Empty : Show=
s legal flit time (hides impact of L0p and L0c). : Enables counting of LLCR=
D (with non-zero payload). This only applies to slot 2 since LLCRD is only =
allowed in slot 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.LLCRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : LLCTRL : Shows legal f=
lit time (hides impact of L0p and L0c). : Equivalent to an idle packet.  En=
ables counting of slot 0 LLCTRL messages.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.LLCTRL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : All Non Data : Shows l=
egal flit time (hides impact of L0p and L0c).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.NON_DATA",
+        "PerPkg": "1",
+        "UMask": "0x97",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Slot NULL or LLCRD Emp=
ty : Shows legal flit time (hides impact of L0p and L0c). : LLCRD with all =
zeros is treated as NULL. Slot 1 is not treated as NULL if slot 0 is a dual=
 slot. This can apply to slot 0,1, or 2.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.NULL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Protocol Header : Show=
s legal flit time (hides impact of L0p and L0c). : Enables count of protoco=
l headers in slot 0,1,2 (depending on slot uMask bits)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.PROTHDR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Slot 0 : Shows legal f=
lit time (hides impact of L0p and L0c). : Count Slot 0 - Other mask bits de=
termine types of headers to count.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Slot 1 : Shows legal f=
lit time (hides impact of L0p and L0c). : Count Slot 1 - Other mask bits de=
termine types of headers to count.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Slot 2 : Shows legal f=
lit time (hides impact of L0p and L0c). : Count Slot 2 - Other mask bits de=
termine types of headers to count.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 0 : Number=
 of allocations into the UPI Rx Flit Buffer.  Generally, when data is trans=
mitted across UPI, it will bypass the RxQ and pass directly to the ring int=
erface.  If things back up getting transmitted onto the ring, however, it m=
ay need to allocate into this buffer, thus increasing the latency.  This ev=
ent can be used in conjunction with the Flit Buffer Occupancy event in orde=
r to calculate the average flit buffer lifetime.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 1 : Number=
 of allocations into the UPI Rx Flit Buffer.  Generally, when data is trans=
mitted across UPI, it will bypass the RxQ and pass directly to the ring int=
erface.  If things back up getting transmitted onto the ring, however, it m=
ay need to allocate into this buffer, thus increasing the latency.  This ev=
ent can be used in conjunction with the Flit Buffer Occupancy event in orde=
r to calculate the average flit buffer lifetime.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 2 : Number=
 of allocations into the UPI Rx Flit Buffer.  Generally, when data is trans=
mitted across UPI, it will bypass the RxQ and pass directly to the ring int=
erface.  If things back up getting transmitted onto the ring, however, it m=
ay need to allocate into this buffer, thus increasing the latency.  This ev=
ent can be used in conjunction with the Flit Buffer Occupancy event in orde=
r to calculate the average flit buffer lifetime.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets : Slot 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets : Slot 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets : Slot 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xe",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10e",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Standard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Standard, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10f",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Requ=
est",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.REQ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Requ=
est, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.REQ_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x108",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - Conflict",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSPCNFLT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1aa",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - Invalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSPI",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x12a",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_DATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xc",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - Data, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_DATA_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10c",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - No Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_NODATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xa",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - No Data, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_NODATA_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10a",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Snoo=
p",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.SNP",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Snoo=
p, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.SNP_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x109",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Writ=
eback",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.WB",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xd",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Writ=
eback, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.WB_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10d",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : All Data : Counts number o=
f data flits across this UPI link.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.ALL_DATA",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "All Null Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.ALL_NULL",
+        "PerPkg": "1",
+        "PublicDescription": "Valid Flits Sent : Idle",
+        "UMask": "0x27",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Data : Shows legal flit ti=
me (hides impact of L0p and L0c). : Count Data Flits (which consume all slo=
ts), but how much to count is based on Slot0-2 mask, so count can be 0-3 de=
pending on which slots are enabled for counting..",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.DATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Idle : Shows legal flit ti=
me (hides impact of L0p and L0c).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.IDLE",
+        "PerPkg": "1",
+        "UMask": "0x47",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : LLCRD Not Empty : Shows le=
gal flit time (hides impact of L0p and L0c). : Enables counting of LLCRD (w=
ith non-zero payload). This only applies to slot 2 since LLCRD is only allo=
wed in slot 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.LLCRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : LLCTRL : Shows legal flit =
time (hides impact of L0p and L0c). : Equivalent to an idle packet.  Enable=
s counting of slot 0 LLCTRL messages.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.LLCTRL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : All Non Data : Shows legal=
 flit time (hides impact of L0p and L0c).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.NON_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Valid Flits Sent : Null FLITs transmitted to=
 any slot",
+        "UMask": "0x97",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Slot NULL or LLCRD Empty :=
 Shows legal flit time (hides impact of L0p and L0c). : LLCRD with all zero=
s is treated as NULL. Slot 1 is not treated as NULL if slot 0 is a dual slo=
t. This can apply to slot 0,1, or 2.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.NULL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Protocol Header : Shows le=
gal flit time (hides impact of L0p and L0c). : Enables count of protocol he=
aders in slot 0,1,2 (depending on slot uMask bits)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.PROTHDR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Slot 0 : Shows legal flit =
time (hides impact of L0p and L0c). : Count Slot 0 - Other mask bits determ=
ine types of headers to count.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Slot 1 : Shows legal flit =
time (hides impact of L0p and L0c). : Count Slot 1 - Other mask bits determ=
ine types of headers to count.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Slot 2 : Shows legal flit =
time (hides impact of L0p and L0c). : Count Slot 2 - Other mask bits determ=
ine types of headers to count.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Allocations : Number of alloca=
tions into the UPI Tx Flit Buffer.  Generally, when data is transmitted acr=
oss UPI, it will bypass the TxQ and pass directly to the link.  However, th=
e TxQ will be used with L0p and when LLR occurs, increasing latency to tran=
sfer out to the link.  This event can be used in conjunction with the Flit =
Buffer Occupancy event in order to calculate the average flit buffer lifeti=
me.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_UPI_TxL_INSERTS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Occupancy : Accumulates the nu=
mber of flits in the TxQ.  Generally, when data is transmitted across UPI, =
it will bypass the TxQ and pass directly to the link.  However, the TxQ wil=
l be used with L0p and when LLR occurs, increasing latency to transfer out =
to the link. This can be used with the cycles not empty event to track aver=
age occupancy, or the allocations event to track average lifetime in the Tx=
Q.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_UPI_TxL_OCCUPANCY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json b/=
tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
new file mode 100644
index 000000000000..cffb9d94b53d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
@@ -0,0 +1,1901 @@
+[
+    {
+        "BriefDescription": "IIO Clockticks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_IIO_CLOCKTICKS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff0ff",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010010",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020020",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040040",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080080",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card.",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card.",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Counts once for every 4 bytes read from this =
card to memory.  This event does include reads to IO.",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x7002004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x7004004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x7008004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x7010004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x7020004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x7040004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x7080004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Counts once for every 4 bytes written from th=
is card to memory.  This event does include writes to IO.",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x7002001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x7004001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x7008001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x7010001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x7020001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x7040001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x7080001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Counts once for every 4 bytes written from th=
is card to a peer device's IO space.",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB Hits to a 1G Page",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.1G_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB Hits to a 2M Page",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.2M_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB Hits to a 4K Page",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.4K_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB lookups all",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.ALL_LOOKUPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Context cache hits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.CTXT_CACHE_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Context cache lookups",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.CTXT_CACHE_LOOKUPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB lookups first",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.FIRST_LOOKUPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB Fills (same as IOTLB miss)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.MISSES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOMMU memory access (both low and high priori=
ty)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.NUM_MEM_ACCESSES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0xc0",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOMMU high priority memory access",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.NUM_MEM_ACCESSES_HIGH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOMMU low priority memory access",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.NUM_MEM_ACCESSES_LOW",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache Hit to a 1G page=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_1G_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache Hit to a 256T pa=
ge",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_256T_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache Hit to a 2M page=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_2M_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache Hit to a 512G pa=
ge",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_512G_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache fill",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_CACHE_FILLS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache lookup",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_CACHE_LOOKUPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Cycles PWT full",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.CYC_PWT_FULL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Interrupt Entry cache hit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.INT_CACHE_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Interrupt Entry cache lookup",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.INT_CACHE_LOOKUPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Context Cache invalidation events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_CTXT_CACHE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Interrupt Entry Cache invalidation events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_INT_CACHE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB invalidation events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_IOTLB",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PASID Cache invalidation events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_PASID_CACHE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Occupancy of outbound request queue : To devi=
ce : Counts number of outbound requests/completions IIO is currently proces=
sing",
+        "Counter": "2,3",
+        "EventCode": "0xc5",
+        "EventName": "UNC_IIO_NUM_OUSTANDING_REQ_FROM_CPU.TO_IO",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Passing data to be written",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.DATA",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x700f020",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Issuing final read or write of line",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.FINAL_RD_WR",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x700f008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Processing response from IOMMU",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.IOMMU_HIT",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x700f002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Issuing to IOMMU",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.IOMMU_REQ",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x700f001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Request Ownership",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.REQ_OWN",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x700f004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Writing line",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.WR",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x700f010",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.ABORT",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff080",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.CONFINED_P2P",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff040",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.LOC_P2P",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff020",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MCAST",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MEM",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MSGB",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.REM_P2P",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff010",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "All 9 bits of Page Walk Tracker Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_IIO_PWT_OCCUPANCY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) reading from this card.",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card.",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080002",
+        "Unit": "IIO"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.jso=
n b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
new file mode 100644
index 000000000000..08e410b9b0a2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
@@ -0,0 +1,449 @@
+[
+    {
+        "BriefDescription": "DRAM Activate Count : Counts the number of DR=
AM Activate commands sent on this channel.  Activate commands are issued to=
 open up a page on the DRAM devices so that it can be read or written to wi=
th a CAS.  One can calculate the number of Page Misses by subtracting the n=
umber of Page Miss precharges from the number of Activates.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.ALL",
+        "PerPkg": "1",
+        "UMask": "0xf7",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count : Read transaction on Pag=
e Empty or Page Miss : Counts the number of DRAM Activate commands sent on =
this channel.  Activate commands are issued to open up a page on the DRAM d=
evices so that it can be read or written to with a CAS.  One can calculate =
the number of Page Misses by subtracting the number of Page Miss precharges=
 from the number of Activates.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count : Underfill Read transact=
ion on Page Empty or Page Miss : Counts the number of DRAM Activate command=
s sent on this channel.  Activate commands are issued to open up a page on =
the DRAM devices so that it can be read or written to with a CAS.  One can =
calculate the number of Page Misses by subtracting the number of Page Miss =
precharges from the number of Activates.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.UFILL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count : Write transaction on Pa=
ge Empty or Page Miss : Counts the number of DRAM Activate commands sent on=
 this channel.  Activate commands are issued to open up a page on the DRAM =
devices so that it can be read or written to with a CAS.  One can calculate=
 the number of Page Misses by subtracting the number of Page Miss precharge=
s from the number of Activates.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0, all CAS operation=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.ALL",
+        "PerPkg": "1",
+        "UMask": "0xff",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0, all reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD",
+        "PerPkg": "1",
+        "UMask": "0xcf",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 regular reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_REG",
+        "PerPkg": "1",
+        "UMask": "0xc1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0, all writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.WR",
+        "PerPkg": "1",
+        "UMask": "0xf0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 regular writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.WR_NONPRE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xd0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 auto-precharge wri=
tes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.WR_PRE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xe0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1, all CAS operation=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.ALL",
+        "PerPkg": "1",
+        "UMask": "0xff",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1, all reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD",
+        "PerPkg": "1",
+        "UMask": "0xcf",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 regular reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_REG",
+        "PerPkg": "1",
+        "UMask": "0xc1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1, all writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.WR",
+        "PerPkg": "1",
+        "UMask": "0xf0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 regular writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.WR_NONPRE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xd0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 auto-precharge wri=
tes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.WR_PRE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xe0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM DCLK clock cycles while the ev=
ent is enabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM Clockticks",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM HCLK clock cycles while the ev=
ent is enabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_HCLOCKTICKS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM Clockticks",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.ALL",
+        "PerPkg": "1",
+        "UMask": "0xff",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to (=
?) : Counts the number of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.PGT",
+        "PerPkg": "1",
+        "UMask": "0xf8",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.UFILL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read buffer inserts on subchannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_M_RDB_INSERTS.SCH0",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read buffer inserts on subchannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_M_RDB_INSERTS.SCH1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read buffer occupancy on subchannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_M_RDB_OCCUPANCY_SCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read buffer occupancy on subchannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_M_RDB_OCCUPANCY_SCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Allocations : Counts the n=
umber of allocations into the Read Pending Queue.  This queue is used to sc=
hedule reads out to the memory controller and to track the requests.  Reque=
sts allocate into the RPQ soon after they enter the memory controller, and =
need credits for an entry in this buffer before being sent from the HA to t=
he iMC.  They deallocate after the CAS command has been issued to memory.  =
This includes both ISOCH and non-ISOCH requests.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.PCH0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x50",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Allocations : Counts the n=
umber of allocations into the Read Pending Queue.  This queue is used to sc=
hedule reads out to the memory controller and to track the requests.  Reque=
sts allocate into the RPQ soon after they enter the memory controller, and =
need credits for an entry in this buffer before being sent from the HA to t=
he iMC.  They deallocate after the CAS command has been issued to memory.  =
This includes both ISOCH and non-ISOCH requests.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.PCH1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xa0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue inserts for subchannel 0, =
pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.SCH0_PCH0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue inserts for subchannel 0, =
pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.SCH0_PCH1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue inserts for subchannel 1, =
pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.SCH1_PCH0",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue inserts for subchannel 1, =
pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.SCH1_PCH1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read pending queue occupancy for subchannel 0=
, pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_SCH0_PCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read pending queue occupancy for subchannel 0=
, pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x81",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_SCH0_PCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read pending queue occupancy for subchannel 1=
, pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_SCH1_PCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read pending queue occupancy for subchannel 1=
, pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_SCH1_PCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.PCH0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x50",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.PCH1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xa0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue inserts for subchannel 0,=
 pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.SCH0_PCH0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue inserts for subchannel 0,=
 pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.SCH0_PCH1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue inserts for subchannel 1,=
 pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.SCH1_PCH0",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue inserts for subchannel 1,=
 pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.SCH1_PCH1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write pending queue occupancy for subchannel =
0, pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_SCH0_PCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write pending queue occupancy for subchannel =
0, pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x85",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_SCH0_PCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write pending queue occupancy for subchannel =
1, pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_SCH1_PCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write pending queue occupancy for subchannel =
1, pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x87",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_SCH1_PCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-power.json=
 b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-power.json
new file mode 100644
index 000000000000..02e59f64a544
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-power.json
@@ -0,0 +1,11 @@
+[
+    {
+        "BriefDescription": "PCU Clockticks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_P_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "PCU Clockticks:  The PCU runs off a fixed 1 =
GHz clock.  This event counts the number of pclk cycles measured while the =
counter was enabled.  The pclk, like the Memory Controller's dclk, counts a=
t a constant rate making it a good measure of actual wall time.",
+        "Unit": "PCU"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/virtual-memory.js=
on b/tools/perf/pmu-events/arch/x86/graniterapids/virtual-memory.json
index 8784c97b7534..609a9549cbf3 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/virtual-memory.json
@@ -1,26 +1,185 @@
 [
+    {
+        "BriefDescription": "Loads that miss the DTLB and hit the STLB.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a demand load.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
         "UMask": "0xe"
     },
+    {
+        "BriefDescription": "Page walks completed due to a demand data loa=
d to a 1G page.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data loa=
d to a 2M/4M page.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data loa=
d to a 4K page.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of page walks outstanding for a demand=
 load in the PMH each cycle.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Stores that miss the DTLB and hit the STLB.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a store.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "Store misses in all TLB levels causes a page =
walk that completes. (All page sizes)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
         "UMask": "0xe"
     },
+    {
+        "BriefDescription": "Page walks completed due to a demand data sto=
re to a 1G page.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data sto=
re to a 2M/4M page.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data sto=
re to a 4K page.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of page walks outstanding for a store =
in the PMH each cycle.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Instruction fetch requests that miss the ITLB=
 and hit the STLB.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.STLB_HIT",
+        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for code (instruction fetch) request.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_ACTIVE",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
         "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (2M/4M)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of page walks outstanding for an outst=
anding code request in the PMH each cycle.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 53c16bb56fdf..2fc3cc4d7f5a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -11,7 +11,7 @@ GenuineIntel-6-CF,v1.09,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.03,grandridge,core
-GenuineIntel-6-A[DE],v1.01,graniterapids,core
+GenuineIntel-6-A[DE],v1.02,graniterapids,core
 GenuineIntel-6-(3C|45|46),v35,haswell,core
 GenuineIntel-6-3F,v28,haswellx,core
 GenuineIntel-6-7[DE],v1.21,icelake,core
--=20
2.45.2.627.g7a2c4fd464-goog

