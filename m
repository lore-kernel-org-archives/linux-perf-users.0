Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651481BBBCB
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907715; cv=none; b=h+P9KduO55NkYM448rjcwdoHp3nA1uiaighB4G66EQPxRoLCjaLaCNqGQFFujZO26Y9JdtNJS5U7Ski7pchwy+zs8SGjFVllMmW6xVdJ27Q4o/7qVqRQbHCI++iugjr+7mgcF+HKqW7+OShgsbeW3FOWOQuiMoIepMcIRxDwizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907715; c=relaxed/simple;
	bh=xaU9b9dqKt9MkKjNvYWJtw8j511KOxjnqLAd0kzEvqw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=BjCbWlMK4uINvXGEdaI+uDHun3cmfU2mV3mHet6enHcoTV7vl4fL2NMbtev6OQfi61kslHMcFMr7tNR2n9AztyQ6ewXOtc5AVqpUE7nGGnuXoY+WV7r/eVp0UrcSOrwabHZAOZx0fxca8bpMf9llV0Mf2NyQcexec3KUMYU4/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J5YhMXv7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J5YhMXv7"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c7c3069ee0so1366132a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718907628; x=1719512428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHr/464wvnja97UG78bFmXtVF9myz3EoN0mAPJLAPgw=;
        b=J5YhMXv7veM464NhKLMpLikNeutoGE7jg7HaSdPPeD6eELR6efRDLKTOmmaAww7vil
         cR+AJgB61OcCEyUgZN790LIR3Pr0skRJIdA3HoARWYAbt4Zhbg1bsTYTaRqz4cbiEMMk
         wim9is8+m0ZExS47BBNWnxwdLxtqRu2qU+O5fiWsACZHWGy+AFNUFcWhJHu0we/MJrYe
         Tf91bJD4HkGXmeTt+Odt8/J9R9+0AEuHGtF/6bUWvvH2ExDbaP4tof+/juaAne3Oj00Q
         cnoJyIavGYWxYCOd5MSXZDHk6eV/RL2BGkdMRHo0TQjoJ7vY0SmptdhkgXOJb+imZJbu
         FkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907628; x=1719512428;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pHr/464wvnja97UG78bFmXtVF9myz3EoN0mAPJLAPgw=;
        b=EZPySTYAtzYUcoiPsCW0vnuQbSlDlLS8sH4Ns6c8FKcZTHQGGrBtfL2zaNPs5YRmUW
         5OHoGbdRus3N/dSuOpy9KZDu3JpvkOjueRxXvFe0ZVcObuiu3zMT0+1l10jOkvYe2I0h
         74gvD3kSxkyVjNZ/bl3D0V02l9uCOxZTk5nXloWuN+ne0rOf5aY9NHh92ciwdQsrbfH+
         mV19LuqxkxbMhFV2cieleqmXU5fXB0U1PX0P57WQA8taSVGPDS+WLG07mehttrEa0RKe
         hHTAv9gOOm/KgMivahyxTEUDvT0UJwgAPjHG0Mo5iymDsfDrxq5h8sQ18W8pSbyjz2XU
         Zz3g==
X-Forwarded-Encrypted: i=1; AJvYcCUtHx1IHeJpKe3E7B5CU4Fy3QZD5KsIkTifZNGOXt35wXZbz5H+6At5N1Jiy4XPCE/kRNxe8NKOKKLO5gKupKTa9N/8LcvDOAFrrEUCGCI80w==
X-Gm-Message-State: AOJu0YygqZvsWebc4PDhJ/APmGdKhffphMv7NdD0kM4YJdz4v+yfj/I6
	lW8DyihrV6iBYayquNbwNj7nO33c9AI3c6GZRZAY9adJetmjGMsrLcV1MS8mWH6mTq6zpANk3OC
	prVOo+w==
X-Google-Smtp-Source: AGHT+IH1sm9s6wfiprdjAAU7DPY+J2uN6ti561CrPlw7SmrBPuJIoYszWQ4FQ5aMc1OLfAYDWgcFhC2WCrde
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a6b7:dc01:68ba:649])
 (user=irogers job=sendgmr) by 2002:a17:90a:88e:b0:2c2:e786:8eeb with SMTP id
 98e67ed59e1d1-2c7b5dae77emr16170a91.8.1718907628338; Thu, 20 Jun 2024
 11:20:28 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:17:45 -0700
In-Reply-To: <20240620181752.3945845-1-irogers@google.com>
Message-Id: <20240620181752.3945845-32-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240620181752.3945845-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v2 31/37] perf vendor events: Add/update skylake events/metrics
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

Update events from v58 to v59.
Update TMA metrics from v4.7 to v4.8.

Bring in the event updates v59:
https://github.com/intel/perfmon/commit/5d36f1835b02f056031a06e777e4bf54a59=
64930

The TMA 4.8 information was added in:
https://github.com/intel/perfmon/commit/59194d4d90ca50a3fcb2de0d82b9f6fc0c9=
a5736

Add counter information. The most recent RFC patch set using this
information:
https://lore.kernel.org/lkml/20240412210756.309828-1-weilin.wang@intel.com/

Adds the event SW_PREFETCH_ACCESS.ANY.

Co-authored-by: Weilin Wang <weilin.wang@intel.com>
Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../pmu-events/arch/x86/skylake/cache.json    | 250 ++++++++++++++++++
 .../pmu-events/arch/x86/skylake/counter.json  |  22 ++
 .../arch/x86/skylake/floating-point.json      |  10 +
 .../pmu-events/arch/x86/skylake/frontend.json |  49 ++++
 .../pmu-events/arch/x86/skylake/memory.json   | 131 +++++++++
 .../arch/x86/skylake/metricgroups.json        |  13 +
 .../pmu-events/arch/x86/skylake/other.json    |   2 +
 .../pmu-events/arch/x86/skylake/pipeline.json | 103 +++++++-
 .../arch/x86/skylake/skl-metrics.json         | 196 ++++++++------
 .../arch/x86/skylake/uncore-cache.json        |  23 ++
 .../arch/x86/skylake/uncore-interconnect.json |   8 +
 .../arch/x86/skylake/uncore-other.json        |  10 -
 .../arch/x86/skylake/virtual-memory.json      |  28 ++
 14 files changed, 756 insertions(+), 91 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/skylake/counter.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore-other.jso=
n

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 30a3966d02b7..70631bcfa8eb 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -29,7 +29,7 @@ GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.23,sapphirerapids,core
 GenuineIntel-6-AF,v1.04,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
-GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v58,skylake,core
+GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.33,skylakex,core
 GenuineIntel-6-86,v1.22,snowridgex,core
 GenuineIntel-6-8[CD],v1.15,tigerlake,core
diff --git a/tools/perf/pmu-events/arch/x86/skylake/cache.json b/tools/perf=
/pmu-events/arch/x86/skylake/cache.json
index ce592d871949..3dd61a325859 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "L1D data line replacements",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
         "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Number of times a request needed a FB entry b=
ut there was no entry available for it. That is the FB unavailability was d=
ominant reason for blocking the request. A request includes cacheable/uncac=
heable demands that is load, store or SW prefetch.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
         "PublicDescription": "Number of times a request needed a FB (Fill =
Buffer) entry but there was no entry available for it. A request includes c=
acheable/uncacheable demands that are load, store or SW prefetch instructio=
ns.",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "L1D miss outstandings duration in cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
         "PublicDescription": "Counts duration of L1D miss outstanding, tha=
t is each cycle number of Fill Buffers (FB) outstanding required by Demand =
Reads. FB either is held by demand loads, or it is held by non-demand loads=
 and gets hit at least once by demand. The valid outstanding interval is de=
fined until the FB deallocation by one of the following ways: from FB alloc=
ation, if FB is allocated by demand from the demand Hit FB, if it is alloca=
ted by hardware or software prefetch.Note: In the L1D, a Demand Read contai=
ns cacheable or noncacheable demand loads, including ones causing cache-lin=
e splits and reads due to page walks resulted from any request type.",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Cycles with L1D load Misses outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
@@ -35,6 +39,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles with L1D load Misses outstanding from =
any thread on physical core.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES_ANY",
@@ -43,6 +48,7 @@
     },
     {
         "BriefDescription": "L2 cache lines filling L2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ALL",
         "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
@@ -51,6 +57,7 @@
     },
     {
         "BriefDescription": "Counts the number of lines that are evicted b=
y L2 cache when triggered by an L2 cache fill. Those lines are in Modified =
state. Modified lines are written back to L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.NON_SILENT",
         "SampleAfterValue": "200003",
@@ -58,6 +65,7 @@
     },
     {
         "BriefDescription": "Counts the number of lines that are silently =
dropped by L2 cache when triggered by an L2 cache fill. These lines are typ=
ically in Shared or Exclusive state. A non-threaded event.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.SILENT",
         "SampleAfterValue": "200003",
@@ -65,6 +73,7 @@
     },
     {
         "BriefDescription": "Counts the number of lines that have been har=
dware prefetched but not used and now evicted by L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.USELESS_HWPF",
         "SampleAfterValue": "200003",
@@ -72,6 +81,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
L2_LINES_OUT.USELESS_HWPF",
+        "Counter": "0,1,2,3",
         "Deprecated": "1",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.USELESS_PREF",
@@ -80,6 +90,7 @@
     },
     {
         "BriefDescription": "L2 code requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
         "PublicDescription": "Counts the total number of L2 code requests.=
",
@@ -88,6 +99,7 @@
     },
     {
         "BriefDescription": "Demand Data Read requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
         "PublicDescription": "Counts the number of demand Data Read reques=
ts (including requests from L1D hardware prefetchers). These loads may hit =
or miss L2 cache. Only non rejected loads are counted.",
@@ -96,6 +108,7 @@
     },
     {
         "BriefDescription": "Demand requests that miss L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
         "PublicDescription": "Demand requests that miss L2 cache.",
@@ -104,6 +117,7 @@
     },
     {
         "BriefDescription": "Demand requests to L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_REFERENCES",
         "PublicDescription": "Demand requests to L2 cache.",
@@ -112,6 +126,7 @@
     },
     {
         "BriefDescription": "Requests from the L1/L2/L3 hardware prefetche=
rs or Load software prefetches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_PF",
         "PublicDescription": "Counts the total number of requests from the=
 L2 hardware prefetchers.",
@@ -120,6 +135,7 @@
     },
     {
         "BriefDescription": "RFO requests to L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
         "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
@@ -128,6 +144,7 @@
     },
     {
         "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
         "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
@@ -136,6 +153,7 @@
     },
     {
         "BriefDescription": "L2 cache misses when fetching instructions",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
         "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
@@ -144,6 +162,7 @@
     },
     {
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
         "PublicDescription": "Counts the number of demand Data Read reques=
ts, initiated by load instructions, that hit L2 cache",
@@ -152,6 +171,7 @@
     },
     {
         "BriefDescription": "Demand Data Read miss L2, no rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
         "PublicDescription": "Counts the number of demand Data Read reques=
ts that miss L2 cache. Only not rejected loads are counted.",
@@ -160,6 +180,7 @@
     },
     {
         "BriefDescription": "All requests that miss L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
         "PublicDescription": "All requests that miss L2 cache.",
@@ -168,6 +189,7 @@
     },
     {
         "BriefDescription": "Requests from the L1/L2/L3 hardware prefetche=
rs or Load software prefetches that hit L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.PF_HIT",
         "PublicDescription": "Counts requests from the L1/L2/L3 hardware p=
refetchers or Load software prefetches that hit L2 cache.",
@@ -176,6 +198,7 @@
     },
     {
         "BriefDescription": "Requests from the L1/L2/L3 hardware prefetche=
rs or Load software prefetches that miss L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.PF_MISS",
         "PublicDescription": "Counts requests from the L1/L2/L3 hardware p=
refetchers or Load software prefetches that miss L2 cache.",
@@ -184,6 +207,7 @@
     },
     {
         "BriefDescription": "All L2 requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
         "PublicDescription": "All L2 requests.",
@@ -192,6 +216,7 @@
     },
     {
         "BriefDescription": "RFO requests that hit L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
         "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
@@ -200,6 +225,7 @@
     },
     {
         "BriefDescription": "RFO requests that miss L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
         "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
@@ -208,6 +234,7 @@
     },
     {
         "BriefDescription": "L2 writebacks that access L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.L2_WB",
         "PublicDescription": "Counts L2 writebacks that access L2 cache.",
@@ -216,6 +243,7 @@
     },
     {
         "BriefDescription": "Core-originated cacheable demand requests mis=
sed L3",
+        "Counter": "0,1,2,3",
         "Errata": "SKL057",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
@@ -225,6 +253,7 @@
     },
     {
         "BriefDescription": "Core-originated cacheable demand requests tha=
t refer to L3",
+        "Counter": "0,1,2,3",
         "Errata": "SKL057",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
@@ -234,6 +263,7 @@
     },
     {
         "BriefDescription": "Retired load instructions.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
@@ -244,6 +274,7 @@
     },
     {
         "BriefDescription": "Retired store instructions.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
@@ -254,6 +285,7 @@
     },
     {
         "BriefDescription": "All retired memory instructions.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_INST_RETIRED.ANY",
@@ -264,6 +296,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with locked access.=
",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
@@ -273,6 +306,7 @@
     },
     {
         "BriefDescription": "Retired load instructions that split across a=
 cacheline boundary.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
@@ -283,6 +317,7 @@
     },
     {
         "BriefDescription": "Retired store instructions that split across =
a cacheline boundary.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
@@ -293,6 +328,7 @@
     },
     {
         "BriefDescription": "Retired load instructions that miss the STLB.=
",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
@@ -303,6 +339,7 @@
     },
     {
         "BriefDescription": "Retired store instructions that miss the STLB=
.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
@@ -313,6 +350,7 @@
     },
     {
         "BriefDescription": "Retired load instructions which data sources =
were L3 and cross-core snoop hits in on-pkg core cache",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT",
@@ -323,6 +361,7 @@
     },
     {
         "BriefDescription": "Retired load instructions which data sources =
were HitM responses from shared L3",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
@@ -333,6 +372,7 @@
     },
     {
         "BriefDescription": "Retired load instructions which data sources =
were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
@@ -342,6 +382,7 @@
     },
     {
         "BriefDescription": "Retired load instructions which data sources =
were hits in L3 without snoops required",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
@@ -352,6 +393,7 @@
     },
     {
         "BriefDescription": "Retired instructions with at least 1 uncachea=
ble load or lock.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD4",
         "EventName": "MEM_LOAD_MISC_RETIRED.UC",
@@ -361,6 +403,7 @@
     },
     {
         "BriefDescription": "Retired load instructions which data sources =
were load missed L1 but hit FB due to preceding miss to the same cache line=
 with data not ready",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_RETIRED.FB_HIT",
@@ -371,6 +414,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with L1 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
@@ -381,6 +425,7 @@
     },
     {
         "BriefDescription": "Retired load instructions missed L1 cache as =
data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_RETIRED.L1_MISS",
@@ -391,6 +436,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with L2 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
@@ -401,6 +447,7 @@
     },
     {
         "BriefDescription": "Retired load instructions missed L2 cache as =
data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
@@ -411,6 +458,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with L3 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_RETIRED.L3_HIT",
@@ -421,6 +469,7 @@
     },
     {
         "BriefDescription": "Retired load instructions missed L3 cache as =
data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_RETIRED.L3_MISS",
@@ -431,6 +480,7 @@
     },
     {
         "BriefDescription": "Demand and prefetch data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.ALL_DATA_RD",
         "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
@@ -439,6 +489,7 @@
     },
     {
         "BriefDescription": "Any memory transaction that reached the SQ.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
         "PublicDescription": "Counts memory transactions reached the super=
 queue including requests initiated by the core, all L3 prefetches, page wa=
lks, etc..",
@@ -447,6 +498,7 @@
     },
     {
         "BriefDescription": "Cacheable and non-cacheable code read request=
s",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
         "PublicDescription": "Counts both cacheable and non-cacheable code=
 read requests.",
@@ -455,6 +507,7 @@
     },
     {
         "BriefDescription": "Demand Data Read requests sent to uncore",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
         "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
@@ -463,6 +516,7 @@
     },
     {
         "BriefDescription": "Demand RFO requests including regular RFOs, l=
ocks, ItoM",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
         "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM.",
@@ -471,6 +525,7 @@
     },
     {
         "BriefDescription": "Offcore requests buffer cannot take more entr=
ies for this thread core.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "OFFCORE_REQUESTS_BUFFER.SQ_FULL",
         "PublicDescription": "Counts the number of cases when the offcore =
requests buffer cannot take more entries for the core. This can happen when=
 the superqueue does not contain eligible entries, or when L1D writeback pe=
nding FIFO requests is full.Note: Writeback pending FIFO has six entries.",
@@ -479,6 +534,7 @@
     },
     {
         "BriefDescription": "Offcore outstanding cacheable Core Data Read =
transactions in SuperQueue (SQ), queue to uncore",
+        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
         "PublicDescription": "Counts the number of offcore outstanding cac=
heable Core Data Read transactions in the super queue every cycle. A transa=
ction is considered to be in the Offcore outstanding state between L2 miss =
and transaction completion sent to requestor (SQ de-allocation). See corres=
ponding Umask under OFFCORE_REQUESTS.",
@@ -487,6 +543,7 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding cacheable Cor=
e Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
@@ -496,6 +553,7 @@
     },
     {
         "BriefDescription": "Cycles with offcore outstanding Code Reads tr=
ansactions in the SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE=
_RD",
@@ -505,6 +563,7 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding Demand Data R=
ead transactions are present in SuperQueue (SQ), queue to uncore",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
@@ -514,6 +573,7 @@
     },
     {
         "BriefDescription": "Cycles with offcore outstanding demand rfo re=
ads transactions in SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
@@ -523,6 +583,7 @@
     },
     {
         "BriefDescription": "Offcore outstanding Code Reads transactions i=
n the SuperQueue (SQ), queue to uncore, every cycle.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
         "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
@@ -531,6 +592,7 @@
     },
     {
         "BriefDescription": "Offcore outstanding Demand Data Read transact=
ions in uncore queue.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
         "PublicDescription": "Counts the number of offcore outstanding Dem=
and Data Read transactions in the super queue (SQ) every cycle. A transacti=
on is considered to be in the Offcore outstanding state between L2 miss and=
 transaction completion sent to requestor. See the corresponding Umask unde=
r OFFCORE_REQUESTS.Note: A prefetch promoted to Demand is counted from the =
promotion point.",
@@ -539,6 +601,7 @@
     },
     {
         "BriefDescription": "Cycles with at least 6 offcore outstanding De=
mand Data Read transactions in uncore queue.",
+        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD_GE_6",
@@ -547,6 +610,7 @@
     },
     {
         "BriefDescription": "Offcore outstanding demand rfo reads transact=
ions in SuperQueue (SQ), queue to uncore, every cycle",
+        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
         "PublicDescription": "Counts the number of offcore outstanding RFO=
 (store) transactions in the super queue (SQ) every cycle. A transaction is=
 considered to be in the Offcore outstanding state between L2 miss and tran=
saction completion sent to requestor (SQ de-allocation). See corresponding =
Umask under OFFCORE_REQUESTS.",
@@ -555,6 +619,7 @@
     },
     {
         "BriefDescription": "Offcore response can be programmed only with =
a specific pair of event select and counter MSR, and with specific event co=
des and predefine mask bit value in a dedicated MSR to specify attributes o=
f the offcore transaction",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -563,6 +628,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads have any respons=
e type.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -572,6 +638,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -581,6 +648,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -590,6 +658,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -599,6 +668,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -608,6 +678,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -617,6 +688,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -626,6 +698,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -635,6 +708,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -644,6 +718,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SNOOP_HITM"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -653,6 +728,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SNOOP_HIT_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -662,6 +738,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SNOOP_MISS"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -671,6 +748,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SNOOP_NONE"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -680,6 +758,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SNOOP_NOT_N=
EEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -689,6 +768,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -698,6 +778,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -707,6 +788,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SNOOP_HITM"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -716,6 +798,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SNOOP_HIT_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -725,6 +808,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SNOOP_MISS"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -734,6 +818,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SNOOP_NONE"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -743,6 +828,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SNOOP_NOT_N=
EEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -752,6 +838,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -761,6 +848,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -770,6 +858,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SNOOP_HITM"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -779,6 +868,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SNOOP_HIT_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -788,6 +878,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SNOOP_MISS"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -797,6 +888,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SNOOP_NONE"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -806,6 +898,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SNOOP_NOT_N=
EEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -815,6 +908,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -824,6 +918,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.ANY_=
SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -833,6 +928,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SNOO=
P_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -842,6 +938,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SNOO=
P_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -851,6 +948,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SNOO=
P_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -860,6 +958,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SNOO=
P_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -869,6 +968,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SNOO=
P_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -878,6 +978,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SPL_=
HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -887,6 +988,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.ANY_SN=
OOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -896,6 +998,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -905,6 +1008,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -914,6 +1018,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -923,6 +1028,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -932,6 +1038,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -941,6 +1048,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SPL_HI=
T",
         "MSRIndex": "0x1a6,0x1a7",
@@ -950,6 +1058,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads have any response ty=
pe.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -959,6 +1068,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -968,6 +1078,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -977,6 +1088,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -986,6 +1098,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -995,6 +1108,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1004,6 +1118,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1013,6 +1128,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1022,6 +1138,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1031,6 +1148,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SNOOP_HITM"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1040,6 +1158,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SNOOP_HIT_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1049,6 +1168,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SNOOP_MISS"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1058,6 +1178,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SNOOP_NONE"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1067,6 +1188,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SNOOP_NOT_N=
EEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1076,6 +1198,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1085,6 +1208,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1094,6 +1218,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SNOOP_HITM"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1103,6 +1228,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SNOOP_HIT_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1112,6 +1238,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SNOOP_MISS"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1121,6 +1248,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SNOOP_NONE"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1130,6 +1258,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SNOOP_NOT_N=
EEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1139,6 +1268,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1148,6 +1278,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1157,6 +1288,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SNOOP_HITM"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1166,6 +1298,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SNOOP_HIT_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1175,6 +1308,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SNOOP_MISS"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1184,6 +1318,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SNOOP_NONE"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1193,6 +1328,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SNOOP_NOT_N=
EEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1202,6 +1338,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1211,6 +1348,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.ANY_=
SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1220,6 +1358,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1229,6 +1368,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1238,6 +1378,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1247,6 +1388,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1256,6 +1398,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1265,6 +1408,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SPL_=
HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1274,6 +1418,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.ANY_SN=
OOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1283,6 +1428,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1292,6 +1438,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1301,6 +1448,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1310,6 +1458,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1319,6 +1468,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1328,6 +1478,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SPL_HI=
T",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1337,6 +1488,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs) have any=
 response type.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1346,6 +1498,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1355,6 +1508,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1364,6 +1518,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1373,6 +1528,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1382,6 +1538,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1391,6 +1548,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1400,6 +1558,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1409,6 +1568,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1418,6 +1578,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1427,6 +1588,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SNOOP_HIT_NO_FW=
D",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1436,6 +1598,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1445,6 +1608,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1454,6 +1618,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SNOOP_NOT_NEEDE=
D",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1463,6 +1628,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1472,6 +1638,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1481,6 +1648,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1490,6 +1658,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SNOOP_HIT_NO_FW=
D",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1499,6 +1668,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1508,6 +1678,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1517,6 +1688,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SNOOP_NOT_NEEDE=
D",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1526,6 +1698,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1535,6 +1708,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1544,6 +1718,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1553,6 +1728,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SNOOP_HIT_NO_FW=
D",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1562,6 +1738,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1571,6 +1748,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1580,6 +1758,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SNOOP_NOT_NEEDE=
D",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1589,6 +1768,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1598,6 +1778,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.ANY_SNOO=
P",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1607,6 +1788,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SNOOP_HI=
TM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1616,6 +1798,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SNOOP_HI=
T_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1625,6 +1808,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SNOOP_MI=
SS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1634,6 +1818,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SNOOP_NO=
NE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1643,6 +1828,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SNOOP_NO=
T_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1652,6 +1838,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SPL_HIT"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1661,6 +1848,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.ANY_SNOOP"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1670,6 +1858,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SNOOP_HITM=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1679,6 +1868,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SNOOP_HIT_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1688,6 +1878,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SNOOP_MISS=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1697,6 +1888,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SNOOP_NONE=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1706,6 +1898,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SNOOP_NOT_=
NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1715,6 +1908,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1724,6 +1918,7 @@
     },
     {
         "BriefDescription": "Counts any other requests have any response t=
ype.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1733,6 +1928,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1742,6 +1938,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1751,6 +1948,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1760,6 +1958,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1769,6 +1968,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1778,6 +1978,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1787,6 +1988,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1796,6 +1998,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1805,6 +2008,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1814,6 +2018,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1823,6 +2028,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1832,6 +2038,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1841,6 +2048,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1850,6 +2058,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1859,6 +2068,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1868,6 +2078,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1877,6 +2088,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1886,6 +2098,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1895,6 +2108,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1904,6 +2118,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1913,6 +2128,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1922,6 +2138,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1931,6 +2148,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1940,6 +2158,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1949,6 +2168,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1958,6 +2178,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1967,6 +2188,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1976,6 +2198,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1985,6 +2208,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1994,6 +2218,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -2003,6 +2228,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -2012,6 +2238,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -2021,6 +2248,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -2030,6 +2258,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -2039,6 +2268,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -2048,6 +2278,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -2057,6 +2288,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -2066,6 +2298,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_HIT_NO_FW=
D",
         "MSRIndex": "0x1a6,0x1a7",
@@ -2075,6 +2308,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -2084,6 +2318,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -2093,6 +2328,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NOT_NEEDE=
D",
         "MSRIndex": "0x1a6,0x1a7",
@@ -2102,6 +2338,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -2111,14 +2348,24 @@
     },
     {
         "BriefDescription": "Number of cache line split locks sent to unco=
re.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xF4",
         "EventName": "SQ_MISC.SPLIT_LOCK",
         "PublicDescription": "Counts the number of cache line split locks =
sent to the uncore.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
+    {
+        "BriefDescription": "Counts the number of PREFETCHNTA, PREFETCHW, =
PREFETCHT0, PREFETCHT1 or PREFETCHT2 instructions executed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "SW_PREFETCH_ACCESS.ANY",
+        "SampleAfterValue": "2000003",
+        "UMask": "0xf"
+    },
     {
         "BriefDescription": "Number of PREFETCHNTA instructions executed."=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "SW_PREFETCH_ACCESS.NTA",
         "SampleAfterValue": "2000003",
@@ -2126,6 +2373,7 @@
     },
     {
         "BriefDescription": "Number of PREFETCHW instructions executed.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
         "SampleAfterValue": "2000003",
@@ -2133,6 +2381,7 @@
     },
     {
         "BriefDescription": "Number of PREFETCHT0 instructions executed.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "SW_PREFETCH_ACCESS.T0",
         "SampleAfterValue": "2000003",
@@ -2140,6 +2389,7 @@
     },
     {
         "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructio=
ns executed.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "SW_PREFETCH_ACCESS.T1_T2",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/counter.json b/tools/pe=
rf/pmu-events/arch/x86/skylake/counter.json
new file mode 100644
index 000000000000..1be6522e2bbc
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/skylake/counter.json
@@ -0,0 +1,22 @@
+[
+    {
+        "Unit": "core",
+        "CountersNumFixed": "3",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "CBOX",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "2"
+    },
+    {
+        "Unit": "ARB",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "2"
+    },
+    {
+        "Unit": "cbox_0",
+        "CountersNumFixed": 1,
+        "CountersNumGeneric": "0"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/skylake/floating-point.json b/t=
ools/perf/pmu-events/arch/x86/skylake/floating-point.json
index 5891bd74af60..f1ecda8aed07 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/floating-point.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts once for most SIMD 128-bit packed comp=
utational double precision floating-point instructions retired. Counts twic=
e for DPP and FM(N)ADD/SUB instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
         "PublicDescription": "Counts once for most SIMD 128-bit packed com=
putational double precision floating-point instructions retired; some instr=
uctions will count twice as noted below.  Each count represents 2 computati=
on operations, one for each element.  Applies to packed double precision fl=
oating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT DP=
P FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perf=
orm 2 calculations per element. The DAZ and FTZ flags in the MXCSR register=
 need to be set when using these events.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Counts once for most SIMD 128-bit packed comp=
utational single precision floating-point instruction retired. Counts twice=
 for DPP and FM(N)ADD/SUB instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
         "PublicDescription": "Counts once for most SIMD 128-bit packed com=
putational single precision floating-point instructions retired; some instr=
uctions will count twice as noted below.  Each count represents 4 computati=
on operations, one for each element.  Applies to packed single precision fl=
oating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RS=
QRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as=
 they perform 2 calculations per element. The DAZ and FTZ flags in the MXCS=
R register need to be set when using these events.",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Counts once for most SIMD 256-bit packed doub=
le computational precision floating-point instructions retired. Counts twic=
e for DPP and FM(N)ADD/SUB instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
         "PublicDescription": "Counts once for most SIMD 256-bit packed dou=
ble computational precision floating-point instructions retired; some instr=
uctions will count twice as noted below.  Each count represents 4 computati=
on operations, one for each element.  Applies to packed double precision fl=
oating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT FM=
(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 calcul=
ations per element. The DAZ and FTZ flags in the MXCSR register need to be =
set when using these events.",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Counts once for most SIMD 256-bit packed sing=
le computational precision floating-point instructions retired. Counts twic=
e for DPP and FM(N)ADD/SUB instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
         "PublicDescription": "Counts once for most SIMD 256-bit packed sin=
gle computational precision floating-point instructions retired; some instr=
uctions will count twice as noted below.  Each count represents 8 computati=
on operations, one for each element.  Applies to packed single precision fl=
oating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RS=
QRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as=
 they perform 2 calculations per element. The DAZ and FTZ flags in the MXCS=
R register need to be set when using these events.",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single and 256-bit packed double precision FP instructions retired; some =
instructions will count twice as noted below.  Each count represents 2 or/a=
nd 4 computation operations, 1 for each element.  Applies to SSE* and AVX* =
packed single precision and packed double precision FP instructions: ADD SU=
B HADD HSUB SUBADD MUL DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DP=
P and FM(N)ADD/SUB count twice as they perform 2 calculations per element."=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.4_FLOPS",
         "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events."=
,
@@ -41,6 +46,7 @@
     },
     {
         "BriefDescription": "Counts once for most SIMD scalar computationa=
l floating-point instructions retired. Counts twice for DPP and FM(N)ADD/SU=
B instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
         "PublicDescription": "Counts once for most SIMD scalar computation=
al single precision and double precision floating-point instructions retire=
d; some instructions will count twice as noted below.  Each count represent=
s 1 computational operation. Applies to SIMD scalar single precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.=
  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per =
element. The DAZ and FTZ flags in the MXCSR register need to be set when us=
ing these events.",
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "Counts once for most SIMD scalar computationa=
l double precision floating-point instructions retired. Counts twice for DP=
P and FM(N)ADD/SUB instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
         "PublicDescription": "Counts once for most SIMD scalar computation=
al double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 1 computational ope=
ration. Applies to SIMD scalar double precision floating-point instructions=
: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions cou=
nt twice as they perform 2 calculations per element. The DAZ and FTZ flags =
in the MXCSR register need to be set when using these events.",
@@ -57,6 +64,7 @@
     },
     {
         "BriefDescription": "Counts once for most SIMD scalar computationa=
l single precision floating-point instructions retired. Counts twice for DP=
P and FM(N)ADD/SUB instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
         "PublicDescription": "Counts once for most SIMD scalar computation=
al single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 1 computational ope=
ration. Applies to SIMD scalar single precision floating-point instructions=
: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instru=
ctions count twice as they perform 2 calculations per element. The DAZ and =
FTZ flags in the MXCSR register need to be set when using these events.",
@@ -65,6 +73,7 @@
     },
     {
         "BriefDescription": "Number of any Vector retired FP arithmetic in=
structions",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.VECTOR",
         "SampleAfterValue": "2000003",
@@ -72,6 +81,7 @@
     },
     {
         "BriefDescription": "Cycles with any input/output SSE or FP assist=
",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.ANY",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/frontend.json b/tools/p=
erf/pmu-events/arch/x86/skylake/frontend.json
index d6f543471b24..0e1dedce00f2 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/frontend.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the total number when the front end is=
 resteered, mainly when the BPU cannot provide a correct prediction and thi=
s is corrected by other branch handling mechanisms at the front end.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.ANY",
         "PublicDescription": "Counts the number of times the front-end is =
resteered when it finds a branch instruction in a fetch line. This occurs f=
or the first time a branch instruction is fetched or when the branch is not=
 tracked by the BPU (Branch Prediction Unit) anymore.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction. [This event is alias to ILD_STALL.LCP]",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.LCP",
         "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk. [This event is=
 alias to ILD_STALL.LCP]",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switches",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAB",
         "EventName": "DSB2MITE_SWITCHES.COUNT",
         "PublicDescription": "This event counts the number of the Decode S=
tream Buffer (DSB)-to-MITE switches including all misses because of missing=
 Decode Stream Buffer (DSB) cache and u-arch forced misses. Note: Invoking =
MITE requires two or three cycles delay.",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switch tru=
e penalty cycles.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAB",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
         "PublicDescription": "Counts Decode Stream Buffer (DSB)-to-MITE sw=
itch true penalty cycles. These cycles do not include uops routed through b=
ecause of the switch itself, for example, when Instruction Decode Queue (ID=
Q) pre-allocation is unavailable, or Instruction Decode Queue (IDQ) is full=
. SBD-to-MITE switch true penalty cycles happen after the merge mux (MM) re=
ceives Decode Stream Buffer (DSB) Sync-indication until receiving the first=
 MITE uop. MM is placed before Instruction Decode Queue (IDQ) to merge uops=
 being fed from the MITE and Decode Stream Buffer (DSB) paths. Decode Strea=
m Buffer (DSB) inserts the Sync-indication whenever a Decode Stream Buffer =
(DSB)-to-MITE switch occurs.Penalty: A Decode Stream Buffer (DSB) hit follo=
wed by a Decode Stream Buffer (DSB) miss can cost up to six cycles in which=
 no uops are delivered to the IDQ. Most often, such switches from the Decod=
e Stream Buffer (DSB) to the legacy pipeline cost 02 cycles.",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Retired Instructions who experienced DSB miss=
.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
         "MSRIndex": "0x3F7",
@@ -44,6 +49,7 @@
     },
     {
         "BriefDescription": "Retired Instructions who experienced a critic=
al DSB miss.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.DSB_MISS",
         "MSRIndex": "0x3F7",
@@ -55,6 +61,7 @@
     },
     {
         "BriefDescription": "Retired Instructions who experienced iTLB tru=
e miss.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.ITLB_MISS",
         "MSRIndex": "0x3F7",
@@ -66,6 +73,7 @@
     },
     {
         "BriefDescription": "Retired Instructions who experienced Instruct=
ion L1 Cache true miss.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.L1I_MISS",
         "MSRIndex": "0x3F7",
@@ -76,6 +84,7 @@
     },
     {
         "BriefDescription": "Retired Instructions who experienced Instruct=
ion L2 Cache true miss.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.L2_MISS",
         "MSRIndex": "0x3F7",
@@ -86,6 +95,7 @@
     },
     {
         "BriefDescription": "Retired instructions after front-end starvati=
on of at least 1 cycle",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
         "MSRIndex": "0x3F7",
@@ -97,6 +107,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 128 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
         "MSRIndex": "0x3F7",
@@ -107,6 +118,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 16 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
         "MSRIndex": "0x3F7",
@@ -118,6 +130,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 2 cycles w=
hich was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
         "MSRIndex": "0x3F7",
@@ -128,6 +141,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 256 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
         "MSRIndex": "0x3F7",
@@ -138,6 +152,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end had at least 1 bubble-slot for a period of 2=
 cycles which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
         "MSRIndex": "0x3F7",
@@ -149,6 +164,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end had at least 2 bubble-slots for a period of =
2 cycles which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_2",
         "MSRIndex": "0x3F7",
@@ -159,6 +175,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end had at least 3 bubble-slots for a period of =
2 cycles which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_3",
         "MSRIndex": "0x3F7",
@@ -169,6 +186,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 32 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
         "MSRIndex": "0x3F7",
@@ -180,6 +198,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 4 cycles w=
hich was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
         "MSRIndex": "0x3F7",
@@ -190,6 +209,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 512 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
         "MSRIndex": "0x3F7",
@@ -200,6 +220,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 64 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
         "MSRIndex": "0x3F7",
@@ -210,6 +231,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 8 cycles w=
hich was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
         "MSRIndex": "0x3F7",
@@ -221,6 +243,7 @@
     },
     {
         "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "FRONTEND_RETIRED.STLB_MISS",
         "MSRIndex": "0x3F7",
@@ -232,6 +255,7 @@
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE_16B.IFDATA_STALL",
         "PublicDescription": "Cycles where a code line fetch is stalled du=
e to an L1 instruction cache miss. The legacy decode pipeline works at a 16=
 Byte granularity.",
@@ -240,6 +264,7 @@
     },
     {
         "BriefDescription": "Instruction fetch tag lookups that hit in the=
 instruction cache (L1I). Counts at 64-byte cache-line granularity.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_64B.IFTAG_HIT",
         "SampleAfterValue": "200003",
@@ -247,6 +272,7 @@
     },
     {
         "BriefDescription": "Instruction fetch tag lookups that miss in th=
e instruction cache (L1I). Counts at 64-byte cache-line granularity.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_64B.IFTAG_MISS",
         "SampleAfterValue": "200003",
@@ -254,6 +280,7 @@
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss. [This event is alias to ICACHE_TAG.STALLS]",
+        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_64B.IFTAG_STALL",
         "SampleAfterValue": "200003",
@@ -261,6 +288,7 @@
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss. [This event is alias to ICACHE_64B.IFTAG_STAL=
L]",
+        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_TAG.STALLS",
         "SampleAfterValue": "200003",
@@ -268,6 +296,7 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 or more Uops [This event is alias to IDQ.DSB_CYCLES_OK]",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_4_UOPS",
@@ -277,6 +306,7 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop [This event is alias to IDQ.DSB_CYCLES_ANY]",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_ANY_UOPS",
@@ -286,6 +316,7 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering 4 Uops",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_MITE_CYCLES_4_UOPS",
@@ -295,6 +326,7 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering any Uop",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_MITE_CYCLES_ANY_UOPS",
@@ -304,6 +336,7 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) from Decode Stream Buffer (DSB) path",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES",
@@ -313,6 +346,7 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop [This event is alias to IDQ.ALL_DSB_CYCLES_ANY_UOPS]",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_ANY",
@@ -322,6 +356,7 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 or more Uops [This event is alias to IDQ.ALL_DSB_CYCLES_4_UOPS]",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
@@ -331,6 +366,7 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path. Countin=
g includes uops that may 'bypass' the IDQ.",
@@ -339,6 +375,7 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) from MITE path",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES",
@@ -348,6 +385,7 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. Counting includes uops that m=
ay 'bypass' the IDQ. This also means that uops are not being delivered from=
 the Decode Stream Buffer (DSB).",
@@ -356,6 +394,7 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES",
@@ -365,6 +404,7 @@
     },
     {
         "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequencer (MS) is busy",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_CYCLES",
@@ -374,6 +414,7 @@
     },
     {
         "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_MITE_UOPS",
         "PublicDescription": "Counts the number of uops initiated by MITE =
and delivered to Instruction Decode Queue (IDQ) while the Microcode Sequenc=
er (MS) is busy. Counting includes uops that may 'bypass' the IDQ.",
@@ -382,6 +423,7 @@
     },
     {
         "BriefDescription": "Number of switches from DSB (Decode Stream Bu=
ffer) or MITE (legacy decode pipeline) to the Microcode Sequencer",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -392,6 +434,7 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequencer (MS) is busy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
         "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS). Any instruction over 4 uops will be delivere=
d by the MS. Some instructions such as transcendentals may additionally gen=
erate uops from the MS.",
@@ -400,6 +443,7 @@
     },
     {
         "BriefDescription": "Uops not delivered to Resource Allocation Tab=
le (RAT) per thread when backend of the machine is not stalled",
+        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
         "PublicDescription": "Counts the number of uops not delivered to R=
esource Allocation Table (RAT) per thread adding 4  x when Resource Allocat=
ion Table (RAT) is not stalled and Instruction Decode Queue (IDQ) delivers =
x uops to Resource Allocation Table (RAT) (where x belongs to {0,1,2,3}). C=
ounting does not cover cases when: a. IDQ-Resource Allocation Table (RAT) p=
ipe serves the other thread. b. Resource Allocation Table (RAT) is stalled =
for the thread (including uop drops and clear BE conditions).  c. Instructi=
on Decode Queue (IDQ) delivers four uops.",
@@ -408,6 +452,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when 4 or more uops are not=
 delivered to Resource Allocation Table (RAT) when backend of the machine i=
s not stalled",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
@@ -417,6 +462,7 @@
     },
     {
         "BriefDescription": "Counts cycles FE delivered 4 uops or Resource=
 Allocation Table (RAT) was stalling FE.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
@@ -426,6 +472,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when 3 or more uops are not=
 delivered to Resource Allocation Table (RAT) when backend of the machine i=
s not stalled",
+        "Counter": "0,1,2,3",
         "CounterMask": "3",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_1_UOP_DELIV.CORE",
@@ -435,6 +482,7 @@
     },
     {
         "BriefDescription": "Cycles with less than 2 uops delivered by the=
 front end.",
+        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_2_UOP_DELIV.CORE",
@@ -444,6 +492,7 @@
     },
     {
         "BriefDescription": "Cycles with less than 3 uops delivered by the=
 front end.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_3_UOP_DELIV.CORE",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/memory.json b/tools/per=
f/pmu-events/arch/x86/skylake/memory.json
index f047862f9735..5e61d3e291ca 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Cycles while L3 cache miss demand load is out=
standing.",
+        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L3_MISS",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Execution stalls while L3 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to any reasons (multiple categories may count as one).",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC8",
         "EventName": "HLE_RETIRED.ABORTED",
         "PEBS": "1",
@@ -26,6 +29,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to unfriendly events (such as interrupts).",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC8",
         "EventName": "HLE_RETIRED.ABORTED_EVENTS",
         "SampleAfterValue": "2000003",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to various memory events (e.g., read/write capacity and conflicts).",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC8",
         "EventName": "HLE_RETIRED.ABORTED_MEM",
         "SampleAfterValue": "2000003",
@@ -40,6 +45,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to incompatible memory type",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC8",
         "EventName": "HLE_RETIRED.ABORTED_MEMTYPE",
         "PublicDescription": "Number of times an HLE execution aborted due=
 to incompatible memory type.",
@@ -48,6 +54,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to hardware timer expiration.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC8",
         "EventName": "HLE_RETIRED.ABORTED_TIMER",
         "SampleAfterValue": "2000003",
@@ -55,6 +62,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to HLE-unfriendly instructions and certain unfriendly events (such as AD as=
sists etc.).",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC8",
         "EventName": "HLE_RETIRED.ABORTED_UNFRIENDLY",
         "SampleAfterValue": "2000003",
@@ -62,6 +70,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution successfully=
 committed",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC8",
         "EventName": "HLE_RETIRED.COMMIT",
         "PublicDescription": "Number of times HLE commit succeeded.",
@@ -70,6 +79,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution started.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC8",
         "EventName": "HLE_RETIRED.START",
         "PublicDescription": "Number of times we entered an HLE region. Do=
es not count nested transactions.",
@@ -78,6 +88,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
+        "Counter": "0,1,2,3",
         "Errata": "SKL089",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
@@ -87,6 +98,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
@@ -99,6 +111,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 16 cycles.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
@@ -111,6 +124,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
@@ -123,6 +137,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 32 cycles.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
@@ -135,6 +150,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 4 cycles.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
@@ -147,6 +163,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 512 cycles.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
@@ -159,6 +176,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 64 cycles.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
@@ -171,6 +189,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 8 cycles.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
@@ -183,6 +202,7 @@
     },
     {
         "BriefDescription": "Demand Data Read requests who miss L3 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
         "PublicDescription": "Demand Data Read requests who miss L3 cache.=
",
@@ -191,6 +211,7 @@
     },
     {
         "BriefDescription": "Cycles with at least 1 Demand Data Read reque=
sts who miss L3 cache in the superQ.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_L3_MISS_DEM=
AND_DATA_RD",
@@ -199,6 +220,7 @@
     },
     {
         "BriefDescription": "Counts number of Offcore outstanding Demand D=
ata Read requests that miss L3 cache in the superQ every cycle.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD"=
,
         "SampleAfterValue": "2000003",
@@ -206,6 +228,7 @@
     },
     {
         "BriefDescription": "Cycles with at least 6 Demand Data Read reque=
sts that miss L3 cache in the superQ.",
+        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD_=
GE_6",
@@ -214,6 +237,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NON_DRA=
M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -223,6 +247,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SNOOP_NON_D=
RAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -232,6 +257,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SNOOP_NON_D=
RAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -241,6 +267,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SNOOP_NON_D=
RAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -250,6 +277,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -259,6 +287,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -268,6 +297,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -277,6 +307,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -286,6 +317,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -295,6 +327,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_NON_DR=
AM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -304,6 +337,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -313,6 +347,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -322,6 +357,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.A=
NY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -331,6 +367,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -340,6 +377,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -349,6 +387,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -358,6 +397,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -367,6 +407,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -376,6 +417,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -385,6 +427,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
PL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -394,6 +437,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SNOO=
P_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -403,6 +447,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -412,6 +457,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NON_DRA=
M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -421,6 +467,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SNOOP_NON_D=
RAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -430,6 +477,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SNOOP_NON_D=
RAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -439,6 +487,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SNOOP_NON_D=
RAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -448,6 +497,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -457,6 +507,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -466,6 +517,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -475,6 +527,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -484,6 +537,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -493,6 +547,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_NON_DR=
AM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -502,6 +557,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -511,6 +567,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -520,6 +577,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.A=
NY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -529,6 +587,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -538,6 +597,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -547,6 +607,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -556,6 +617,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -565,6 +627,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -574,6 +637,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -583,6 +647,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
PL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -592,6 +657,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -601,6 +667,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -610,6 +677,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -619,6 +687,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SNOOP_NON_DRAM"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -628,6 +697,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SNOOP_NON_DRAM"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -637,6 +707,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SNOOP_NON_DRAM"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -646,6 +717,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -655,6 +727,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -664,6 +737,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_HIT_NO_FWD=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -673,6 +747,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -682,6 +757,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -691,6 +767,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -700,6 +777,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_NOT_NEEDED=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -709,6 +787,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -718,6 +797,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.ANY_S=
NOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -727,6 +807,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -736,6 +817,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -745,6 +827,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -754,6 +837,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -763,6 +847,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -772,6 +857,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -781,6 +867,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SPL_H=
IT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -790,6 +877,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SNOOP_NO=
N_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -799,6 +887,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SNOOP_NON_=
DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -808,6 +897,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -817,6 +907,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -826,6 +917,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -835,6 +927,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -844,6 +937,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
@@ -853,6 +947,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -862,6 +957,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -871,6 +967,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -880,6 +977,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -889,6 +987,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -898,6 +997,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -907,6 +1007,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -916,6 +1017,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.ANY_SNOOP"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -925,6 +1027,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_HITM=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -934,6 +1037,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_HIT_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -943,6 +1047,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_MISS=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -952,6 +1057,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NONE=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -961,6 +1067,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NON_=
DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -970,6 +1077,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NOT_=
NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -979,6 +1087,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SPL_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -988,6 +1097,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SNOOP_NON_DRA=
M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -997,6 +1107,7 @@
     },
     {
         "BriefDescription": "Counts any other requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NON_DRAM"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -1006,6 +1117,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to any reasons (multiple categories may count as one).",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC9",
         "EventName": "RTM_RETIRED.ABORTED",
         "PEBS": "2",
@@ -1015,6 +1127,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to none of the previous 4 categories (e.g. interrupt)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC9",
         "EventName": "RTM_RETIRED.ABORTED_EVENTS",
         "PublicDescription": "Number of times an RTM execution aborted due=
 to none of the previous 4 categories (e.g. interrupt).",
@@ -1023,6 +1136,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to various memory events (e.g. read/write capacity and conflicts)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC9",
         "EventName": "RTM_RETIRED.ABORTED_MEM",
         "PublicDescription": "Number of times an RTM execution aborted due=
 to various memory events (e.g. read/write capacity and conflicts).",
@@ -1031,6 +1145,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to incompatible memory type",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC9",
         "EventName": "RTM_RETIRED.ABORTED_MEMTYPE",
         "PublicDescription": "Number of times an RTM execution aborted due=
 to incompatible memory type.",
@@ -1039,6 +1154,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to uncommon conditions.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC9",
         "EventName": "RTM_RETIRED.ABORTED_TIMER",
         "SampleAfterValue": "2000003",
@@ -1046,6 +1162,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to HLE-unfriendly instructions",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC9",
         "EventName": "RTM_RETIRED.ABORTED_UNFRIENDLY",
         "PublicDescription": "Number of times an RTM execution aborted due=
 to HLE-unfriendly instructions.",
@@ -1054,6 +1171,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution successfully=
 committed",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC9",
         "EventName": "RTM_RETIRED.COMMIT",
         "PublicDescription": "Number of times RTM commit succeeded.",
@@ -1062,6 +1180,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution started.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC9",
         "EventName": "RTM_RETIRED.START",
         "PublicDescription": "Number of times we entered an RTM region. Do=
es not count nested transactions.",
@@ -1070,6 +1189,7 @@
     },
     {
         "BriefDescription": "Counts the number of times a class of instruc=
tions that may cause a transactional abort was executed. Since this is the =
count of execution, it may not always cause a transactional abort.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC1",
         "SampleAfterValue": "2000003",
@@ -1077,6 +1197,7 @@
     },
     {
         "BriefDescription": "Counts the number of times a class of instruc=
tions (e.g., vzeroupper) that may cause a transactional abort was executed =
inside a transactional region",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC2",
         "PublicDescription": "Unfriendly TSX abort triggered by a vzeroupp=
er instruction.",
@@ -1085,6 +1206,7 @@
     },
     {
         "BriefDescription": "Counts the number of times an instruction exe=
cution caused the transactional nest count supported to be exceeded",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC3",
         "PublicDescription": "Unfriendly TSX abort triggered by a nest cou=
nt that is too deep.",
@@ -1093,6 +1215,7 @@
     },
     {
         "BriefDescription": "Counts the number of times a XBEGIN instructi=
on was executed inside an HLE transactional region.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC4",
         "PublicDescription": "RTM region detected inside HLE.",
@@ -1101,6 +1224,7 @@
     },
     {
         "BriefDescription": "Counts the number of times an HLE XACQUIRE in=
struction was executed inside an RTM transactional region",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC5",
         "PublicDescription": "Counts the number of times an HLE XACQUIRE i=
nstruction was executed inside an RTM transactional region.",
@@ -1109,6 +1233,7 @@
     },
     {
         "BriefDescription": "Number of times a transactional abort was sig=
naled due to a data capacity limitation for transactional reads or writes."=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CAPACITY",
         "SampleAfterValue": "2000003",
@@ -1116,6 +1241,7 @@
     },
     {
         "BriefDescription": "Number of times a transactional abort was sig=
naled due to a data conflict on a transactionally accessed address",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CONFLICT",
         "PublicDescription": "Number of times a TSX line had a cache confl=
ict.",
@@ -1124,6 +1250,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE transactional executio=
n aborted due to XRELEASE lock not satisfying the address and value require=
ments in the elision buffer",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_MISMATCH",
         "PublicDescription": "Number of times a TSX Abort was triggered du=
e to release/commit but data and address mismatch.",
@@ -1132,6 +1259,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE transactional executio=
n aborted due to NoAllocatedElisionBuffer being non-zero.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_NOT_EMPTY",
         "PublicDescription": "Number of times a TSX Abort was triggered du=
e to commit but Lock Buffer not empty.",
@@ -1140,6 +1268,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE transactional executio=
n aborted due to an unsupported read alignment from the elision buffer.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_UNSUPPORTED_ALIGNMEN=
T",
         "PublicDescription": "Number of times a TSX Abort was triggered du=
e to attempting an unsupported alignment from Lock Buffer.",
@@ -1148,6 +1277,7 @@
     },
     {
         "BriefDescription": "Number of times a HLE transactional region ab=
orted due to a non XRELEASE prefixed instruction writing to an elided lock =
in the elision buffer",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_STORE_TO_ELIDED_LOCK",
         "PublicDescription": "Number of times a TSX Abort was triggered du=
e to a non-release/commit store to lock.",
@@ -1156,6 +1286,7 @@
     },
     {
         "BriefDescription": "Number of times HLE lock could not be elided =
due to ElisionBufferAvailable being zero.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.HLE_ELISION_BUFFER_FULL",
         "PublicDescription": "Number of times we could not allocate Lock B=
uffer.",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/metricgroups.json b/too=
ls/perf/pmu-events/arch/x86/skylake/metricgroups.json
index 5452a1448ded..3a88260194d1 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/metricgroups.json
@@ -5,7 +5,20 @@
     "BigFootprint": "Grouping from Top-down Microarchitecture Analysis Met=
rics spreadsheet",
     "BrMispredicts": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
     "Branches": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "BvBC": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvBO": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvCB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvFB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvIO": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvML": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMP": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMS": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMT": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvOB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvUW": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "CacheHits": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
+    "CacheMisses": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
     "CodeGen": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "Compute": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "Cor": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/other.json b/tools/perf=
/pmu-events/arch/x86/skylake/other.json
index d75d53279b4e..f14eeeb85d39 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/other.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/other.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Number of hardware interrupts received by the=
 processor.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "HW_INTERRUPTS.RECEIVED",
         "PublicDescription": "Counts the number of hardware interruptions =
received by the processor.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "MEMORY_DISAMBIGUATION.HISTORY_RESET",
+        "Counter": "0,1,2,3",
         "EventCode": "0x09",
         "EventName": "MEMORY_DISAMBIGUATION.HISTORY_RESET",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/skylake/pipeline.json
index fe202d1e368a..6d57930afbfd 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations. Accounts for integer and floating-point oper=
ations.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x14",
         "EventName": "ARITH.DIVIDER_ACTIVE",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "All (macro) branch instructions retired.",
+        "Counter": "0,1,2,3",
         "Errata": "SKL091",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "All (macro) branch instructions retired.",
+        "Counter": "0,1,2,3",
         "Errata": "SKL091",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES_PEBS",
@@ -27,6 +30,7 @@
     },
     {
         "BriefDescription": "Conditional branch instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.CONDITIONAL]",
+        "Counter": "0,1,2,3",
         "Errata": "SKL091",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.COND",
@@ -36,6 +40,7 @@
     },
     {
         "BriefDescription": "Conditional branch instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.COND]",
+        "Counter": "0,1,2,3",
         "Errata": "SKL091",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
@@ -46,6 +51,7 @@
     },
     {
         "BriefDescription": "Not taken branch instructions retired.",
+        "Counter": "0,1,2,3",
         "Errata": "SKL091",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_NTAKEN",
@@ -55,6 +61,7 @@
     },
     {
         "BriefDescription": "Far branch instructions retired.",
+        "Counter": "0,1,2,3",
         "Errata": "SKL091",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
@@ -65,6 +72,7 @@
     },
     {
         "BriefDescription": "Direct and indirect near call instructions re=
tired.",
+        "Counter": "0,1,2,3",
         "Errata": "SKL091",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
@@ -75,6 +83,7 @@
     },
     {
         "BriefDescription": "Return instructions retired.",
+        "Counter": "0,1,2,3",
         "Errata": "SKL091",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
@@ -85,6 +94,7 @@
     },
     {
         "BriefDescription": "Taken branch instructions retired.",
+        "Counter": "0,1,2,3",
         "Errata": "SKL091",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
@@ -95,6 +105,7 @@
     },
     {
         "BriefDescription": "Not taken branch instructions retired.",
+        "Counter": "0,1,2,3",
         "Errata": "SKL091",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NOT_TAKEN",
@@ -104,6 +115,7 @@
     },
     {
         "BriefDescription": "Speculative and retired mispredicted macro co=
nditional branches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_BRANCHES",
         "PublicDescription": "This event counts both taken and not taken s=
peculative and retired mispredicted branch instructions.",
@@ -112,6 +124,7 @@
     },
     {
         "BriefDescription": "Speculative mispredicted indirect branches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.INDIRECT",
         "PublicDescription": "Counts speculatively miss-predicted indirect=
 branches at execution time. Counts for indirect near CALL or JMP instructi=
ons (RET excluded).",
@@ -120,6 +133,7 @@
     },
     {
         "BriefDescription": "All mispredicted macro branch instructions re=
tired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path.",
@@ -127,6 +141,7 @@
     },
     {
         "BriefDescription": "Mispredicted macro branch instructions retire=
d.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_PEBS",
         "PEBS": "2",
@@ -136,6 +151,7 @@
     },
     {
         "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -145,6 +161,7 @@
     },
     {
         "BriefDescription": "Mispredicted direct and indirect near call in=
structions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -154,6 +171,7 @@
     },
     {
         "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -162,6 +180,7 @@
     },
     {
         "BriefDescription": "Core crystal clock cycles when this thread is=
 unhalted and the other thread is halted.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "25003",
@@ -169,6 +188,7 @@
     },
     {
         "BriefDescription": "Core crystal clock cycles when the thread is =
unhalted.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK",
         "SampleAfterValue": "25003",
@@ -177,6 +197,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core crystal clock cycles when at least one t=
hread on the physical core is unhalted.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY",
         "SampleAfterValue": "25003",
@@ -184,6 +205,7 @@
     },
     {
         "BriefDescription": "Core crystal clock cycles when this thread is=
 unhalted and the other thread is halted.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "25003",
@@ -191,6 +213,7 @@
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
can approximate elapsed time while the core was not in a halt state. This e=
vent has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is c=
ounted on a dedicated fixed counter, leaving the four (eight when Hyperthre=
ading is disabled) programmable counters available for other events. Note: =
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
@@ -198,6 +221,7 @@
     },
     {
         "BriefDescription": "Core crystal clock cycles when the thread is =
unhalted.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
         "SampleAfterValue": "25003",
@@ -206,6 +230,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core crystal clock cycles when at least one t=
hread on the physical core is unhalted.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK_ANY",
         "SampleAfterValue": "25003",
@@ -213,6 +238,7 @@
     },
     {
         "BriefDescription": "Counts when there is a transition from ring 1=
, 2 or 3 to ring 0.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x3C",
@@ -222,6 +248,7 @@
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
ng the four (eight when Hyperthreading is disabled) programmable counters a=
vailable for other events.",
         "SampleAfterValue": "2000003",
@@ -230,12 +257,14 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the p=
hysical core is not in halt state.",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Thread cycles when thread is not in halt stat=
e",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
@@ -244,12 +273,14 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the p=
hysical core is not in halt state.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P_ANY",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
+        "Counter": "0,1,2,3",
         "CounterMask": "8",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
@@ -258,6 +289,7 @@
     },
     {
         "BriefDescription": "Cycles while L2 cache miss demand load is out=
standing.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
@@ -266,6 +298,7 @@
     },
     {
         "BriefDescription": "Cycles while memory subsystem has an outstand=
ing load.",
+        "Counter": "0,1,2,3",
         "CounterMask": "16",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
@@ -274,6 +307,7 @@
     },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "12",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
@@ -282,6 +316,7 @@
     },
     {
         "BriefDescription": "Execution stalls while L2 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
@@ -290,6 +325,7 @@
     },
     {
         "BriefDescription": "Execution stalls while memory subsystem has a=
n outstanding load.",
+        "Counter": "0,1,2,3",
         "CounterMask": "20",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_MEM_ANY",
@@ -298,6 +334,7 @@
     },
     {
         "BriefDescription": "Total execution stalls.",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
@@ -306,6 +343,7 @@
     },
     {
         "BriefDescription": "Cycles total of 1 uop is executed on all port=
s and Reservation Station was not empty.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
         "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
@@ -314,6 +352,7 @@
     },
     {
         "BriefDescription": "Cycles total of 2 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
         "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
@@ -322,6 +361,7 @@
     },
     {
         "BriefDescription": "Cycles total of 3 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
         "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
@@ -330,6 +370,7 @@
     },
     {
         "BriefDescription": "Cycles total of 4 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
         "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
@@ -338,6 +379,7 @@
     },
     {
         "BriefDescription": "Cycles where the Store Buffer was full and no=
 outstanding load.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
         "SampleAfterValue": "2000003",
@@ -345,6 +387,7 @@
     },
     {
         "BriefDescription": "Cycles where no uops were executed, the Reser=
vation Station was not empty, the Store Buffer was full and there was no ou=
tstanding load.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
         "PublicDescription": "Counts cycles during which no uops were exec=
uted on all ports and Reservation Station (RS) was not empty.",
@@ -353,6 +396,7 @@
     },
     {
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction. [This event is alias to DECODE.LCP]",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
         "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk. [This event is=
 alias to DECODE.LCP]",
@@ -361,6 +405,7 @@
     },
     {
         "BriefDescription": "Instruction decoders utilized in a cycle",
+        "Counter": "0,1,2,3",
         "EventCode": "0x55",
         "EventName": "INST_DECODED.DECODERS",
         "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
@@ -369,6 +414,7 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "Counts the number of instructions retired fr=
om execution. For instructions that consist of multiple micro-ops, Counts t=
he retirement of the last micro-op of the instruction. Counting continues d=
uring hardware interrupts, traps, and inside interrupt handlers. Notes: INS=
T_RETIRED.ANY is counted by a designated fixed counter, leaving the four (e=
ight when Hyperthreading is disabled) programmable counters available for o=
ther events. INST_RETIRED.ANY_P is counted by a programmable counter and it=
 is an architectural performance event. Counting: Faulting executions of GE=
TSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
         "SampleAfterValue": "2000003",
@@ -376,6 +422,7 @@
     },
     {
         "BriefDescription": "Number of instructions retired. General Count=
er - architectural event",
+        "Counter": "0,1,2,3",
         "Errata": "SKL091, SKL044",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
@@ -384,15 +431,17 @@
     },
     {
         "BriefDescription": "Number of all retired NOP instructions.",
+        "Counter": "0,1,2,3",
         "Errata": "SKL091, SKL044",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.NOP",
-        "PEBS": "2",
+        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Precise instruction retired event with HW to =
reduce effect of PEBS shadow in IP distribution",
+        "Counter": "1",
         "Errata": "SKL091, SKL044",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.PREC_DIST",
@@ -403,6 +452,7 @@
     },
     {
         "BriefDescription": "Number of cycles using always true condition =
applied to  PEBS instructions retired event.",
+        "Counter": "0,2,3",
         "CounterMask": "10",
         "Errata": "SKL091, SKL044",
         "EventCode": "0xC0",
@@ -415,6 +465,7 @@
     },
     {
         "BriefDescription": "Clears speculative count",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x0D",
@@ -425,6 +476,7 @@
     },
     {
         "BriefDescription": "Cycles the issue-stage is waiting for front-e=
nd to fetch from resteered path following branch misprediction or machine c=
lear events.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
         "SampleAfterValue": "2000003",
@@ -432,6 +484,7 @@
     },
     {
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread (e.g. misprediction or me=
mory nuke)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
         "PublicDescription": "Core cycles the Resource allocator was stall=
ed due to recovery from an earlier branch misprediction or machine clear ev=
ent.",
@@ -441,6 +494,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for any thread running on the physical co=
re (e.g. misprediction or memory nuke).",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RECOVERY_CYCLES_ANY",
         "SampleAfterValue": "2000003",
@@ -448,6 +502,7 @@
     },
     {
         "BriefDescription": "The number of times that split load operation=
s are temporarily blocked because all resources for handling the split acce=
sses are in use",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
         "PublicDescription": "The number of times that split load operatio=
ns are temporarily blocked because all resources for handling the split acc=
esses are in use.",
@@ -456,6 +511,7 @@
     },
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
@@ -464,6 +520,7 @@
     },
     {
         "BriefDescription": "False dependencies in MOB due to partial comp=
are on address.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x07",
         "EventName": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS",
         "PublicDescription": "Counts false dependencies in MOB when the pa=
rtial comparison upon loose net check and dependency was resolved by the En=
hanced Loose net mechanism. This may not result in high performance penalti=
es. Loose net checks can fail when loads and stores are 4k aliased.",
@@ -472,6 +529,7 @@
     },
     {
         "BriefDescription": "Demand load dispatches that hit L1D fill buff=
er (FB) allocated for software prefetch.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4C",
         "EventName": "LOAD_HIT_PRE.SW_PF",
         "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
@@ -480,6 +538,7 @@
     },
     {
         "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn'=
t come from the decoder. [This event is alias to LSD.CYCLES_OK]",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_4_UOPS",
@@ -489,6 +548,7 @@
     },
     {
         "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_ACTIVE",
@@ -498,6 +558,7 @@
     },
     {
         "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn'=
t come from the decoder. [This event is alias to LSD.CYCLES_4_UOPS]",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_OK",
@@ -507,6 +568,7 @@
     },
     {
         "BriefDescription": "Number of Uops delivered by the LSD.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA8",
         "EventName": "LSD.UOPS",
         "PublicDescription": "Number of uops delivered to the back-end by =
the LSD(Loop Stream Detector).",
@@ -515,6 +577,7 @@
     },
     {
         "BriefDescription": "Number of machine clears (nukes) of any type.=
",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xC3",
@@ -524,6 +587,7 @@
     },
     {
         "BriefDescription": "Self-modifying code (SMC) detected.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
@@ -532,6 +596,7 @@
     },
     {
         "BriefDescription": "Number of times a microcode assist is invoked=
 by HW other than FP-assist. Examples include AD (page Access Dirty) and AV=
X* related assists.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.ANY",
         "SampleAfterValue": "100003",
@@ -539,6 +604,7 @@
     },
     {
         "BriefDescription": "Cycles where the pipeline is stalled due to s=
erializing operations.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x59",
         "EventName": "PARTIAL_RAT_STALLS.SCOREBOARD",
         "PublicDescription": "This event counts cycles during which the mi=
crocode scoreboard stalls happen.",
@@ -547,6 +613,7 @@
     },
     {
         "BriefDescription": "Resource-related stall cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.ANY",
         "PublicDescription": "Counts resource-related stall cycles.",
@@ -555,6 +622,7 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.SB",
         "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
@@ -563,6 +631,7 @@
     },
     {
         "BriefDescription": "Increments whenever there is an update to the=
 LBR array.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCC",
         "EventName": "ROB_MISC_EVENTS.LBR_INSERTS",
         "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
@@ -571,6 +640,7 @@
     },
     {
         "BriefDescription": "Number of retired PAUSE instructions (that do=
 not end up with a VMExit to the VMM; TSX aborted Instructions may be count=
ed). This event is not supported on first SKL and KBL products.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCC",
         "EventName": "ROB_MISC_EVENTS.PAUSE_INST",
         "SampleAfterValue": "2000003",
@@ -578,6 +648,7 @@
     },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5E",
         "EventName": "RS_EVENTS.EMPTY_CYCLES",
         "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for the thread.; Note: In ST-mode, not active thread s=
hould drive 0. This is usually caused by severely costly branch mispredicti=
ons, or allocator/FE issues.",
@@ -586,6 +657,7 @@
     },
     {
         "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty. Could be useful to precisely locate Frontend Latency=
 Bound issues.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x5E",
@@ -597,6 +669,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_0",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o port 0.",
@@ -605,6 +678,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_1",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o port 1.",
@@ -613,6 +687,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_2",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o port 2.",
@@ -621,6 +696,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_3",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o port 3.",
@@ -629,6 +705,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_4",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o port 4.",
@@ -637,6 +714,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_5",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o port 5.",
@@ -645,6 +723,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_6",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o port 6.",
@@ -653,6 +732,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_7",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o port 7.",
@@ -661,6 +741,7 @@
     },
     {
         "BriefDescription": "Number of uops executed on the core.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE",
         "PublicDescription": "Number of uops executed from any thread.",
@@ -669,6 +750,7 @@
     },
     {
         "BriefDescription": "Cycles at least 1 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
@@ -677,6 +759,7 @@
     },
     {
         "BriefDescription": "Cycles at least 2 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
@@ -685,6 +768,7 @@
     },
     {
         "BriefDescription": "Cycles at least 3 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3",
         "CounterMask": "3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
@@ -693,6 +777,7 @@
     },
     {
         "BriefDescription": "Cycles at least 4 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
@@ -701,6 +786,7 @@
     },
     {
         "BriefDescription": "Cycles with no micro-ops executed from any th=
read on physical core.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_NONE",
@@ -710,6 +796,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 1 uop was executed per-=
thread",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC",
@@ -719,6 +806,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC",
@@ -728,6 +816,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 3 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3",
         "CounterMask": "3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC",
@@ -737,6 +826,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 4 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_4_UOPS_EXEC",
@@ -746,6 +836,7 @@
     },
     {
         "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.STALL_CYCLES",
@@ -756,6 +847,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops to be executed per-=
thread each cycle.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.THREAD",
         "PublicDescription": "Number of uops to be executed per-thread eac=
h cycle.",
@@ -764,6 +856,7 @@
     },
     {
         "BriefDescription": "Counts the number of x87 uops dispatched.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.X87",
         "PublicDescription": "Counts the number of x87 uops executed.",
@@ -772,6 +865,7 @@
     },
     {
         "BriefDescription": "Uops that Resource Allocation Table (RAT) iss=
ues to Reservation Station (RS)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.ANY",
         "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
@@ -780,6 +874,7 @@
     },
     {
         "BriefDescription": "Number of slow LEA uops being allocated. A uo=
p is generally considered SlowLea if it has 3 sources (e.g. 2 sources + imm=
ediate) regardless if as a result of LEA instruction or not.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.SLOW_LEA",
         "SampleAfterValue": "2000003",
@@ -787,6 +882,7 @@
     },
     {
         "BriefDescription": "Cycles when Resource Allocation Table (RAT) d=
oes not issue Uops to Reservation Station (RS) for the thread",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.STALL_CYCLES",
@@ -797,6 +893,7 @@
     },
     {
         "BriefDescription": "Uops inserted at issue-stage in order to pres=
erve upper bits of vector registers.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.VECTOR_WIDTH_MISMATCH",
         "PublicDescription": "Counts the number of Blend Uops issued by th=
e Resource Allocation Table (RAT) to the reservation station (RS) in order =
to preserve upper bits of vector registers. Starting with the Skylake micro=
architecture, these Blend uops are needed since every Intel SSE instruction=
 executed in Dirty Upper State needs to preserve bits 128-255 of the destin=
ation register. For more information, refer to Mixing Intel AVX and Intel S=
SE Code section of the Optimization Guide.",
@@ -805,6 +902,7 @@
     },
     {
         "BriefDescription": "Number of macro-fused uops retired. (non prec=
ise)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MACRO_FUSED",
         "PublicDescription": "Counts the number of macro-fused uops retire=
d. (non precise)",
@@ -813,6 +911,7 @@
     },
     {
         "BriefDescription": "Retirement slots used.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
         "PublicDescription": "Counts the retirement slots used.",
@@ -821,6 +920,7 @@
     },
     {
         "BriefDescription": "Cycles without actually retired uops.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
@@ -831,6 +931,7 @@
     },
     {
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
+        "Counter": "0,1,2,3",
         "CounterMask": "16",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tool=
s/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 3af71b84bb9d..4e954fe8547c 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -89,7 +89,7 @@
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
         "MetricExpr": "34 * (FP_ASSIST.ANY + OTHER_ASSISTS.ANY) / tma_info=
_thread_slots",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
+        "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequence=
r_group",
         "MetricName": "tma_assists",
         "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
         "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: OTHER_ASSISTS.AN=
Y",
@@ -98,7 +98,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricExpr": "1 - tma_frontend_bound - (UOPS_ISSUED.ANY + 4 * (IN=
T_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) /=
 tma_info_thread_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "BvOB;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "MetricgroupNoGroup": "TopdownL1",
@@ -119,7 +119,7 @@
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * tma_bad_speculation",
-        "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group=
;tma_bad_speculation_group;tma_issueBM",
+        "MetricGroup": "BadSpec;BrMispredicts;BvMP;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
@@ -157,7 +157,7 @@
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(18.5 * tma_info_system_core_frequency * MEM_LOAD_L=
3_HIT_RETIRED.XSNP_HITM + 16.5 * tma_info_system_core_frequency * MEM_LOAD_=
L3_HIT_RETIRED.XSNP_MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED=
.L1_MISS / 2) / tma_info_thread_clks",
-        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
+        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS. Re=
lated metrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma=
_remote_cache",
@@ -178,7 +178,7 @@
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "16.5 * tma_info_system_core_frequency * MEM_LOAD_L3=
_HIT_RETIRED.XSNP_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_=
MISS / 2) / tma_info_thread_clks",
-        "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
+        "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issu=
eSyncxn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_HIT_PS. Related metrics: tma_contested_accesses, tma=
_false_sharing, tma_machine_clears, tma_remote_cache",
@@ -196,7 +196,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
         "MetricExpr": "ARITH.DIVIDER_ACTIVE / tma_info_thread_clks",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
+        "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
         "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
@@ -227,14 +227,14 @@
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
         "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_mis=
ses, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_ban=
dwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "min(9 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE=
_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
-        "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
l1_bound_group",
+        "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_l1_bound_group",
         "MetricName": "tma_dtlb_load",
         "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_me=
mory_synchronization",
@@ -243,7 +243,7 @@
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
         "MetricExpr": "(9 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_core_clks",
-        "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
store_bound_group",
+        "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_store_bound_group",
         "MetricName": "tma_dtlb_store",
         "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_memory_synchroniz=
ation",
@@ -253,7 +253,7 @@
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "22 * tma_info_system_core_frequency * OFFCORE_RESPO=
NSE.DEMAND_RFO.L3_HIT.SNOOP_HITM / tma_info_thread_clks",
-        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
+        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: MEM_LOAD_L3_HIT_=
RETIRED.XSNP_HITM_PS;OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM. Related=
 metrics: tma_contested_accesses, tma_data_sharing, tma_machine_clears, tma=
_remote_cache",
@@ -263,7 +263,7 @@
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu@L1D_PE=
ND_MISS.FB_FULL\\,cmask\\=3D1@ / tma_info_thread_clks",
-        "MetricGroup": "MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;tma_is=
sueSL;tma_issueSmSt;tma_l1_bound_group",
+        "MetricGroup": "BvMS;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
         "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_bottleneck_cache_memory_bandwi=
dth, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store=
_latency, tma_streaming_stores",
@@ -276,7 +276,7 @@
         "MetricName": "tma_fetch_bandwidth",
         "MetricThreshold": "tma_fetch_bandwidth > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tm=
a_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
@@ -291,6 +291,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_heavy_operations - tma_microcode_sequencer",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_heavy_operations_group;=
tma_issueD0",
         "MetricName": "tma_few_uops_instructions",
@@ -319,7 +320,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
-        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ / UOPS_RETIRED.RETIRE_SLOTS",
+        "MetricExpr": "FP_ARITH_INST_RETIRED.SCALAR / UOPS_RETIRED.RETIRE_=
SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
         "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -329,7 +330,7 @@
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umas=
k\\=3D0x3c@ / UOPS_RETIRED.RETIRE_SLOTS",
+        "MetricExpr": "FP_ARITH_INST_RETIRED.VECTOR / UOPS_RETIRED.RETIRE_=
SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
         "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -357,7 +358,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_thread_slots=
",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "BvFB;BvIO;PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "MetricgroupNoGroup": "TopdownL1",
@@ -367,7 +368,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
         "MetricExpr": "tma_light_operations * UOPS_RETIRED.MACRO_FUSED / U=
OPS_RETIRED.RETIRE_SLOTS",
-        "MetricGroup": "Branches;Pipeline;TopdownL3;tma_L3_group;tma_light=
_operations_group",
+        "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_fused_instructions",
         "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of =
legacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Ot=
her_Light_Ops in MTL!)}",
@@ -386,7 +387,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
         "MetricExpr": "(ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_16B.IFDAT=
A_STALL\\,cmask\\=3D1\\,edge@) / tma_info_thread_clks",
-        "MetricGroup": "BigFootprint;FetchLat;IcMiss;TopdownL3;tma_L3_grou=
p;tma_fetch_latency_group",
+        "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
@@ -427,6 +428,14 @@
         "MetricName": "tma_info_botlnk_l0_core_bound_likely",
         "MetricThreshold": "tma_info_botlnk_l0_core_bound_likely > 0.5"
     },
+    {
+        "BriefDescription": "Total pipeline cost of DSB (uop cache) hits -=
 subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_bandwidth + tma_fetch_latency)) * (tma_dsb / (tma_dsb + tma_mite=
)))",
+        "MetricGroup": "DSB;FetchBW;tma_issueFB",
+        "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
+        "MetricThreshold": "tma_info_botlnk_l2_dsb_bandwidth > 10",
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) hits =
- subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb_s=
witches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_front=
end_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp"
+    },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
         "MetricConstraint": "NO_GROUP_EVENTS",
@@ -434,7 +443,7 @@
         "MetricGroup": "DSBmiss;Fed;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_misses",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
-        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, tma_info_in=
st_mix_iptb, tma_lcp"
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_=
frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp"
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
@@ -444,40 +453,34 @@
         "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
         "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: "
     },
-    {
-        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the baseline operations not covered by Branching_Overhead nor Irregular_O=
verhead.",
-        "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCHES=
 + BR_INST_RETIRED.NEAR_CALL) / tma_info_thread_slots - tma_microcode_seque=
ncer / (tma_few_uops_instructions + tma_microcode_sequencer) * (tma_assists=
 / tma_microcode_sequencer) * tma_heavy_operations)",
-        "MetricGroup": "Ret",
-        "MetricName": "tma_info_bottleneck_base_non_br",
-        "MetricThreshold": "tma_info_bottleneck_base_non_br > 20"
-    },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
-        "MetricGroup": "BigFootprint;Fed;Frontend;IcMiss;MemoryTLB",
+        "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
         "MetricName": "tma_info_bottleneck_big_code",
         "MetricThreshold": "tma_info_bottleneck_big_code > 20"
     },
     {
-        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * ((BR_INST_RETIRED.ALL_BRANCHES + BR_INST_RETI=
RED.NEAR_CALL) / tma_info_thread_slots)",
-        "MetricGroup": "Ret",
+        "BriefDescription": "Total pipeline cost of instructions used for =
program control-flow - a subset of the Retiring category in TMA",
+        "MetricExpr": "100 * ((BR_INST_RETIRED.ALL_BRANCHES + 2 * BR_INST_=
RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slots)",
+        "MetricGroup": "BvBO;Ret",
         "MetricName": "tma_info_bottleneck_branching_overhead",
-        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 5"
+        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 5",
+        "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)"
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_4k_aliasing + tma_dtlb_load + tma_=
fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
-        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_4k_aliasing + tma_dtlb_load + tma_=
fb_full + tma_l1_hit_latency + tma_lock_latency + tma_split_loads + tma_sto=
re_fwd_blk)))",
+        "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
         "MetricName": "tma_info_bottleneck_cache_memory_bandwidth",
         "MetricThreshold": "tma_info_bottleneck_cache_memory_bandwidth > 2=
0",
         "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full"
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_store_bound / (tma_dram_bou=
nd + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_=
store_latency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tm=
a_store_latency)))",
-        "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_store_bound / (tma_dram_bou=
nd + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_=
store_latency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tm=
a_store_latency)) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tm=
a_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_l1_hit_=
latency / (tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_l1_hit_laten=
cy + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
+        "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_info_bottleneck_cache_memory_latency",
         "MetricThreshold": "tma_info_bottleneck_cache_memory_latency > 20"=
,
         "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency"
@@ -485,23 +488,23 @@
     {
         "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
         "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_ports_utilization + tma_serializing_operation) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_ports_utilization + tma_serializin=
g_operation)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
-        "MetricGroup": "Cor;tma_issueComp",
+        "MetricGroup": "BvCB;Cor;tma_issueComp",
         "MetricName": "tma_info_bottleneck_compute_bound_est",
         "MetricThreshold": "tma_info_bottleneck_compute_bound_est > 20",
         "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: "
     },
     {
-        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - tma_mi=
crocode_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) *=
 (tma_assists / tma_microcode_sequencer) * tma_fetch_latency * (tma_ms_swit=
ches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_resteer=
s * (10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_misp=
redicts)) / (tma_clears_resteers + tma_mispredicts_resteers + tma_unknown_b=
ranches)) / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + t=
ma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_bottleneck_big_code=
",
-        "MetricGroup": "Fed;FetchBW;Frontend",
+        "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
         "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
         "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 20"
     },
     {
         "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
         "MetricExpr": "100 * (tma_microcode_sequencer / (tma_few_uops_inst=
ructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_sequence=
r) * tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_clea=
rs_resteers + tma_mispredicts_resteers * (10 * tma_microcode_sequencer * tm=
a_other_mispredicts / tma_branch_mispredicts)) / (tma_clears_resteers + tma=
_mispredicts_resteers + tma_unknown_branches)) / (tma_branch_resteers + tma=
_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_swit=
ches) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_m=
ispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other_nukes =
/ tma_other_nukes + tma_core_bound * (tma_serializing_operation + tma_core_=
bound * RS_EVENTS.EMPTY_CYCLES / tma_info_thread_clks * tma_ports_utilized_=
0) / (tma_divider + tma_ports_utilization + tma_serializing_operation) + tm=
a_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_sequence=
r) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
-        "MetricGroup": "Bad;Cor;Ret;tma_issueMS",
+        "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
         "MetricName": "tma_info_bottleneck_irregular_overhead",
         "MetricThreshold": "tma_info_bottleneck_irregular_overhead > 10",
         "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches"
@@ -509,8 +512,8 @@
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tm=
a_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_=
fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma_dram_bound + tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_dtlb_store /=
 (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_latency=
)))",
-        "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tm=
a_dtlb_load + tma_fb_full + tma_l1_hit_latency + tma_lock_latency + tma_spl=
it_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma=
_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)=
) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tma_split_store=
s + tma_store_latency)))",
+        "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_info_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
         "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store, tma_info_bottleneck_memory_synchronization"
@@ -518,7 +521,7 @@
     {
         "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
         "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (t=
ma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma_d=
ata_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_stores =
+ tma_store_latency - tma_store_latency)) + tma_machine_clears * (1 - tma_o=
ther_nukes / tma_other_nukes))",
-        "MetricGroup": "Mem;Offcore;tma_issueTLB",
+        "MetricGroup": "BvMS;Mem;Offcore;tma_issueTLB",
         "MetricName": "tma_info_bottleneck_memory_synchronization",
         "MetricThreshold": "tma_info_bottleneck_memory_synchronization > 1=
0",
         "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_dtlb_load, tma_dtlb_store, tma_info_bottleneck_me=
mory_data_tlbs"
@@ -527,18 +530,25 @@
         "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switc=
hes + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
         "MetricName": "tma_info_bottleneck_mispredictions",
         "MetricThreshold": "tma_info_bottleneck_mispredictions > 20",
         "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers"
     },
     {
-        "BriefDescription": "Total pipeline cost of remaining bottlenecks =
(apart from those listed in the Info.Bottlenecks metrics class)",
-        "MetricExpr": "100 - (tma_info_bottleneck_big_code + tma_info_bott=
leneck_instruction_fetch_bw + tma_info_bottleneck_mispredictions + tma_info=
_bottleneck_cache_memory_bandwidth + tma_info_bottleneck_cache_memory_laten=
cy + tma_info_bottleneck_memory_data_tlbs + tma_info_bottleneck_memory_sync=
hronization + tma_info_bottleneck_compute_bound_est + tma_info_bottleneck_i=
rregular_overhead + tma_info_bottleneck_branching_overhead + tma_info_bottl=
eneck_base_non_br)",
-        "MetricGroup": "Cor;Offcore",
+        "BriefDescription": "Total pipeline cost of remaining bottlenecks =
in the back-end",
+        "MetricExpr": "100 - (tma_info_bottleneck_big_code + tma_info_bott=
leneck_instruction_fetch_bw + tma_info_bottleneck_mispredictions + tma_info=
_bottleneck_cache_memory_bandwidth + tma_info_bottleneck_cache_memory_laten=
cy + tma_info_bottleneck_memory_data_tlbs + tma_info_bottleneck_memory_sync=
hronization + tma_info_bottleneck_compute_bound_est + tma_info_bottleneck_i=
rregular_overhead + tma_info_bottleneck_branching_overhead + tma_info_bottl=
eneck_useful_work)",
+        "MetricGroup": "BvOB;Cor;Offcore",
         "MetricName": "tma_info_bottleneck_other_bottlenecks",
         "MetricThreshold": "tma_info_bottleneck_other_bottlenecks > 20",
-        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 (apart from those listed in the Info.Bottlenecks metrics class). Examples =
include data-dependencies (Core Bound when Low ILP) and other unlisted memo=
ry-related stalls."
+        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls."
+    },
+    {
+        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead.",
+        "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCHES=
 + 2 * BR_INST_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slot=
s - tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_se=
quencer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)"=
,
+        "MetricGroup": "BvUW;Ret",
+        "MetricName": "tma_info_bottleneck_useful_work",
+        "MetricThreshold": "tma_info_bottleneck_useful_work > 20"
     },
     {
         "BriefDescription": "Fraction of branches that are CALL or RET",
@@ -592,7 +602,7 @@
     },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0x3c@) =
/ (2 * tma_info_core_core_clks)",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + FP_ARITH_INST_RETIR=
ED.VECTOR) / (2 * tma_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
         "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
@@ -609,7 +619,7 @@
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_frontend_dsb_coverage",
         "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 4 > 0.35",
-        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_inst_mix_iptb, tma_lcp"
+        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_inst_mix_iptb, tma_lcp"
     },
     {
         "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
@@ -670,7 +680,7 @@
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "INST_RETIRED.ANY / (cpu@FP_ARITH_INST_RETIRED.SCALA=
R_SINGLE\\,umask\\=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\=
,umask\\=3D0x3c@)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR + =
FP_ARITH_INST_RETIRED.VECTOR)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
         "MetricThreshold": "tma_info_inst_mix_iparith < 10",
@@ -752,12 +762,12 @@
         "MetricThreshold": "tma_info_inst_mix_ipswpf < 100"
     },
     {
-        "BriefDescription": "Instruction per taken branch",
+        "BriefDescription": "Instructions per taken branch",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
         "MetricName": "tma_info_inst_mix_iptb",
         "MetricThreshold": "tma_info_inst_mix_iptb < 9",
-        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tm=
a_info_frontend_dsb_coverage, tma_lcp"
+        "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth=
, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
@@ -790,7 +800,7 @@
         "MetricName": "tma_info_memory_fb_hpki"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l1d_cache_fill_bw"
@@ -808,7 +818,7 @@
         "MetricName": "tma_info_memory_l1mpki_load"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
         "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l2_cache_fill_bw"
@@ -844,13 +854,19 @@
         "MetricName": "tma_info_memory_l2mpki_load"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Offcore requests (L2 cache miss) per kilo ins=
truction for demand RFOs",
+        "MetricExpr": "1e3 * OFFCORE_REQUESTS.DEMAND_RFO / INST_RETIRED.AN=
Y",
+        "MetricGroup": "CacheMisses;Offcore",
+        "MetricName": "tma_info_memory_l2mpki_rfo"
+    },
+    {
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
         "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
         "MetricGroup": "Mem;MemoryBW;Offcore",
         "MetricName": "tma_info_memory_l3_cache_access_bw"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
         "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l3_cache_fill_bw"
@@ -925,11 +941,23 @@
         "MetricName": "tma_info_memory_tlb_store_stlb_mpki"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per core",
         "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
     },
+    {
+        "BriefDescription": "Average number of uops fetched from DSB per c=
ycle",
+        "MetricExpr": "IDQ.DSB_UOPS / IDQ.DSB_CYCLES_ANY",
+        "MetricGroup": "Fed;FetchBW",
+        "MetricName": "tma_info_pipeline_fetch_dsb"
+    },
+    {
+        "BriefDescription": "Average number of uops fetched from MITE per =
cycle",
+        "MetricExpr": "IDQ.MITE_UOPS / IDQ.MITE_CYCLES",
+        "MetricGroup": "Fed;FetchBW",
+        "MetricName": "tma_info_pipeline_fetch_mite"
+    },
     {
         "BriefDescription": "Instructions per a microcode Assist invocatio=
n",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ASSIST.ANY + OTHER_ASSISTS.A=
NY)",
@@ -952,13 +980,13 @@
     },
     {
         "BriefDescription": "Average CPU Utilization (percentage)",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "tma_info_system_cpus_utilized / #num_cpus_online",
         "MetricGroup": "HPC;Summary",
         "MetricName": "tma_info_system_cpu_utilization"
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "#num_cpus_online * tma_info_system_cpu_utilization"=
,
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized"
     },
@@ -1068,7 +1096,7 @@
         "MetricThreshold": "tma_info_thread_uoppi > 1.05"
     },
     {
-        "BriefDescription": "Instruction per taken branch",
+        "BriefDescription": "Uops per taken branch",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / BR_INST_RETIRED.NEAR_TA=
KEN",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "tma_info_thread_uptb",
@@ -1077,7 +1105,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
         "MetricExpr": "ICACHE_TAG.STALLS / tma_info_thread_clks",
-        "MetricGroup": "BigFootprint;FetchLat;MemoryTLB;TopdownL3;tma_L3_g=
roup;tma_fetch_latency_group",
+        "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
@@ -1092,11 +1120,20 @@
         "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 data cache.  The L1 data cache typical=
ly has the shortest latency.  However; in certain cases like loads blocked =
on older stores; a load might suffer due to high latency even though it is =
being satisfied by the L1. Another example is loads who miss in the TLB. Th=
ese cases are characterized by execution unit stalls; while some non-comple=
ted demand load lives in the machine without having that demand load missin=
g the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT_PS;MEM_LOAD_RETIRED.FB=
_HIT_PS. Related metrics: tma_clears_resteers, tma_machine_clears, tma_micr=
ocode_sequencer, tma_ms_switches, tma_ports_utilized_1",
         "ScaleUnit": "100%"
     },
+    {
+        "BriefDescription": "This metric roughly estimates fraction of cyc=
les with demand load accesses that hit the L1 cache",
+        "MetricExpr": "min(2 * (MEM_INST_RETIRED.ALL_LOADS - MEM_LOAD_RETI=
RED.FB_HIT - MEM_LOAD_RETIRED.L1_MISS) * 20 / 100, max(CYCLE_ACTIVITY.CYCLE=
S_MEM_ANY - CYCLE_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
+        "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_l1_bound=
_group",
+        "MetricName": "tma_l1_hit_latency",
+        "MetricThreshold": "tma_l1_hit_latency > 0.1 & (tma_l1_bound > 0.1=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles with demand load accesses that hit the L1 cache. The short latency of =
the L1 data cache may be exposed in pointer-chasing memory access patterns =
as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) / (MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + cpu@L1D_PEND_MISS.FB_FULL\\,cm=
ask\\=3D1@) * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_M=
ISS) / tma_info_thread_clks)",
-        "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
+        "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT_PS",
@@ -1114,7 +1151,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
         "MetricExpr": "6.5 * tma_info_system_core_frequency * (MEM_LOAD_RE=
TIRED.L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2)=
) / tma_info_thread_clks",
-        "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_=
l3_bound_group",
+        "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_info_bottleneck_cache_memory_latency, tma_mem_latency",
@@ -1126,7 +1163,7 @@
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
         "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, t=
ma_info_inst_mix_iptb",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
         "ScaleUnit": "100%"
     },
     {
@@ -1171,14 +1208,14 @@
         "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
         "MetricName": "tma_lock_latency",
         "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS_PS. Related metrics: tma_store_latency",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS. Related metrics: tma_store_latency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_bad_speculation - tma_branch_mispredicts",
-        "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group=
;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
+        "MetricGroup": "BadSpec;BvMS;MachineClears;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
         "MetricName": "tma_machine_clears",
         "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation=
 > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
@@ -1188,7 +1225,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_dram_b=
ound_group;tma_issueBW",
+        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
         "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_fb_full, tma_info_bottleneck_cache=
_memory_bandwidth, tma_info_system_dram_bw_use, tma_sq_full",
@@ -1197,7 +1234,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory - DRA=
M ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
-        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_dram_=
bound_group;tma_issueLat",
+        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
         "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_info_bottleneck_cache_memory_latency, tma_l3_hit_la=
tency",
@@ -1224,6 +1261,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY * IDQ.M=
S_UOPS / tma_info_thread_slots",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
         "MetricName": "tma_microcode_sequencer",
@@ -1234,7 +1272,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_inf=
o_thread_clks",
-        "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueBM",
+        "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_group;=
tma_branch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
         "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_branch_mispredicts, tma_info_bad_spec_branch_misprediction_cost=
, tma_info_bottleneck_mispredictions",
@@ -1270,7 +1308,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
         "MetricExpr": "tma_light_operations * (BR_INST_RETIRED.ALL_BRANCHE=
S - UOPS_RETIRED.MACRO_FUSED) / UOPS_RETIRED.RETIRE_SLOTS",
-        "MetricGroup": "Branches;Pipeline;TopdownL3;tma_L3_group;tma_light=
_operations_group",
+        "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_non_fused_branches",
         "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
@@ -1279,7 +1317,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
         "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / UOPS_RETI=
RED.RETIRE_SLOTS",
-        "MetricGroup": "Pipeline;TopdownL4;tma_L4_group;tma_other_light_op=
s_group",
+        "MetricGroup": "BvBO;Pipeline;TopdownL4;tma_L4_group;tma_other_lig=
ht_ops_group",
         "MetricName": "tma_nop_instructions",
         "MetricThreshold": "tma_nop_instructions > 0.1 & (tma_other_light_=
ops > 0.3 & tma_light_operations > 0.6)",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
@@ -1297,7 +1335,7 @@
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types).",
         "MetricExpr": "max(tma_branch_mispredicts * (1 - BR_MISP_RETIRED.A=
LL_BRANCHES / (INT_MISC.CLEARS_COUNT - MACHINE_CLEARS.COUNT)), 0.0001)",
-        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricGroup": "BrMispredicts;BvIO;TopdownL3;tma_L3_group;tma_bran=
ch_mispredicts_group",
         "MetricName": "tma_other_mispredicts",
         "MetricThreshold": "tma_other_mispredicts > 0.05 & (tma_branch_mis=
predicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
@@ -1305,7 +1343,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
.",
         "MetricExpr": "max(tma_machine_clears * (1 - MACHINE_CLEARS.MEMORY=
_ORDERING / MACHINE_CLEARS.COUNT), 0.0001)",
-        "MetricGroup": "Machine_Clears;TopdownL3;tma_L3_group;tma_machine_=
clears_group",
+        "MetricGroup": "BvIO;Machine_Clears;TopdownL3;tma_L3_group;tma_mac=
hine_clears_group",
         "MetricName": "tma_other_nukes",
         "MetricThreshold": "tma_other_nukes > 0.05 & (tma_machine_clears >=
 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
@@ -1393,7 +1431,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(EXE_ACTIVITY.EXE_BOUND_0_PORTS + tma_core_bound * =
RS_EVENTS.EMPTY_CYCLES) / tma_info_thread_clks * (CYCLE_ACTIVITY.STALLS_TOT=
AL - CYCLE_ACTIVITY.STALLS_MEM_ANY) / tma_info_thread_clks",
+        "MetricExpr": "EXE_ACTIVITY.EXE_BOUND_0_PORTS / tma_info_thread_cl=
ks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1421,7 +1459,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
         "MetricExpr": "(UOPS_EXECUTED.CORE_CYCLES_GE_3 / 2 if #SMT_on else=
 UOPS_EXECUTED.CORE_CYCLES_GE_3) / tma_info_core_core_clks",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
+        "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
         "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
@@ -1429,7 +1467,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_thread_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "BvUW;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "MetricgroupNoGroup": "TopdownL1",
@@ -1439,7 +1477,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
         "MetricExpr": "PARTIAL_RAT_STALLS.SCOREBOARD / tma_info_thread_clk=
s",
-        "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup;tma_issueSO",
+        "MetricGroup": "BvIO;PortsUtil;TopdownL3;tma_L3_group;tma_core_bou=
nd_group;tma_issueSO",
         "MetricName": "tma_serializing_operation",
         "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_core_bo=
und > 0.1 & tma_backend_bound > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: PARTIAL_RAT_STALLS.SCOREBOARD. Related me=
trics: tma_ms_switches",
@@ -1467,7 +1505,7 @@
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
         "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / tma_info_core_core_clks",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueB=
W;tma_l3_bound_group",
+        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_bottleneck_cache_memory_bandwidth, tma_info_system_dram_bw_use, =
tma_mem_bandwidth",
@@ -1495,7 +1533,7 @@
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_INST_RETIRED.LOCK_=
LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_LOADS / M=
EM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
-        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_issue=
RFO;tma_issueSL;tma_store_bound_group",
+        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
issueRFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
         "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
@@ -1528,7 +1566,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
         "MetricExpr": "9 * BACLEARS.ANY / tma_info_thread_clks",
-        "MetricGroup": "BigFootprint;FetchLat;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group",
+        "MetricGroup": "BigFootprint;BvBC;FetchLat;TopdownL4;tma_L4_group;=
tma_branch_resteers_group",
         "MetricName": "tma_unknown_branches",
         "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit) hence called Unknown Bran=
ches. Sample with: BACLEARS.ANY",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/uncore-cache.json b/too=
ls/perf/pmu-events/arch/x86/skylake/uncore-cache.json
index b4e061477c1a..46ba98ab3ba4 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/uncore-cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in E or S-state",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_ES",
         "PerPkg": "1",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in I-state",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_I",
         "PerPkg": "1",
@@ -19,6 +21,7 @@
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in M-state",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_M",
         "PerPkg": "1",
@@ -28,6 +31,7 @@
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in MESI-state",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_MESI",
         "PerPkg": "1",
@@ -37,6 +41,7 @@
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in E or S-state",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_ES",
         "PerPkg": "1",
@@ -46,6 +51,7 @@
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in I-state",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_I",
         "PerPkg": "1",
@@ -55,6 +61,7 @@
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in any MESI-state",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_MESI",
         "PerPkg": "1",
@@ -64,6 +71,7 @@
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in E or S-state",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_ES",
         "PerPkg": "1",
@@ -73,6 +81,7 @@
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in M-state",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_M",
         "PerPkg": "1",
@@ -82,6 +91,7 @@
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in MESI-state",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_MESI",
         "PerPkg": "1",
@@ -91,6 +101,7 @@
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which hits a modified line in some proces=
sor core.",
+        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_XCORE",
         "PerPkg": "1",
@@ -99,6 +110,7 @@
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which hits a non-modified line in some pr=
ocessor core.",
+        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_XCORE",
         "PerPkg": "1",
@@ -107,6 +119,7 @@
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction =
which misses in some processor core.",
+        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
         "PerPkg": "1",
@@ -115,10 +128,20 @@
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which misses in some processor core.",
+        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_XCORE",
         "PerPkg": "1",
         "UMask": "0x41",
         "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les",
+        "Counter": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "PublicDescription": "This 48-bit fixed counter counts the UCLK cy=
cles.",
+        "Unit": "cbox_0"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/skylake/uncore-interconnect.jso=
n b/tools/perf/pmu-events/arch/x86/skylake/uncore-interconnect.json
index fe7e19717371..6b9fbed5847c 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/uncore-interconnect.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop, Core aperture, etc.",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
         "PerPkg": "1",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Number of all Core entries outstanding for th=
e memory controller. The outstanding interval starts after LLC miss till re=
turn of first data chunk. Accounts for Coherent and non-coherent traffic.",
+        "Counter": "0",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
         "PerPkg": "1",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Cycles with at least one request outstanding =
is waiting for data return from memory controller. Account for coherent and=
 non-coherent requests initiated by IA Cores, Processor Graphics Unit, or L=
LC.",
+        "Counter": "0",
         "CounterMask": "1",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
@@ -26,6 +29,7 @@
     },
     {
         "BriefDescription": "Number of Core Data Read entries outstanding =
for the memory controller. The outstanding interval starts after LLC miss t=
ill return of first data chunk.",
+        "Counter": "0",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.DATA_READ",
         "PerPkg": "1",
@@ -34,6 +38,7 @@
     },
     {
         "BriefDescription": "UNC_ARB_TRK_REQUESTS.ALL",
+        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
         "PerPkg": "1",
@@ -42,6 +47,7 @@
     },
     {
         "BriefDescription": "Number of Core coherent Data Read requests se=
nt to memory controller whose data is returned directly to requesting agent=
.",
+        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.DATA_READ",
         "PerPkg": "1",
@@ -50,6 +56,7 @@
     },
     {
         "BriefDescription": "Number of Core coherent Data Read requests se=
nt to memory controller whose data is returned directly to requesting agent=
.",
+        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.DRD_DIRECT",
         "PerPkg": "1",
@@ -58,6 +65,7 @@
     },
     {
         "BriefDescription": "Number of Writes allocated - any write transa=
ctions: full/partials writes and evictions.",
+        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.WRITES",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/skylake/uncore-other.json
deleted file mode 100644
index 58be90d7cc93..000000000000
--- a/tools/perf/pmu-events/arch/x86/skylake/uncore-other.json
+++ /dev/null
@@ -1,10 +0,0 @@
-[
-    {
-        "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les",
-        "EventCode": "0xff",
-        "EventName": "UNC_CLOCK.SOCKET",
-        "PerPkg": "1",
-        "PublicDescription": "This 48-bit fixed counter counts the UCLK cy=
cles.",
-        "Unit": "CLOCK"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json b/t=
ools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
index 73feadaf7674..ad33fff57c03 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Load misses in all DTLB levels that cause pag=
e walks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.MISS_CAUSES_A_WALK",
         "PublicDescription": "Counts demand data loads that caused a page =
walk of any page size (4K/2M/4M/1G). This implies it missed in all TLB leve=
ls, but the walk need not have completed.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Loads that miss the DTLB and hit the STLB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a load. EPT page walk duration are excluded in Skylake.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
@@ -26,6 +29,7 @@
     },
     {
         "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
@@ -34,6 +38,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to a demand data load=
 to a 1G page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
         "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
@@ -42,6 +47,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to a demand data load=
 to a 2M/4M page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
@@ -50,6 +56,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to a demand data load=
 to a 4K page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
@@ -58,6 +65,7 @@
     },
     {
         "BriefDescription": "Counts 1 per cycle for each PMH that is busy =
with a page walk for a load. EPT page walk duration are excluded in Skylake=
.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
         "PublicDescription": "Counts 1 per cycle for each PMH that is busy=
 with a page walk for a load. EPT page walk duration are excluded in Skylak=
e microarchitecture.",
@@ -66,6 +74,7 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause pa=
ge walks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.MISS_CAUSES_A_WALK",
         "PublicDescription": "Counts demand data stores that caused a page=
 walk of any page size (4K/2M/4M/1G). This implies it missed in all TLB lev=
els, but the walk need not have completed.",
@@ -74,6 +83,7 @@
     },
     {
         "BriefDescription": "Stores that miss the DTLB and hit the STLB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
         "PublicDescription": "Stores that miss the DTLB (Data TLB) and hit=
 the STLB (2nd Level TLB).",
@@ -82,6 +92,7 @@
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a store. EPT page walk duration are excluded in Skylake.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
@@ -91,6 +102,7 @@
     },
     {
         "BriefDescription": "Store misses in all TLB levels causes a page =
walk that completes. (All page sizes)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
@@ -99,6 +111,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to a demand data stor=
e to a 1G page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
         "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
@@ -107,6 +120,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to a demand data stor=
e to a 2M/4M page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
@@ -115,6 +129,7 @@
     },
     {
         "BriefDescription": "Page walk completed due to a demand data stor=
e to a 4K page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
@@ -123,6 +138,7 @@
     },
     {
         "BriefDescription": "Counts 1 per cycle for each PMH that is busy =
with a page walk for a store. EPT page walk duration are excluded in Skylak=
e.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
         "PublicDescription": "Counts 1 per cycle for each PMH that is busy=
 with a page walk for a store. EPT page walk duration are excluded in Skyla=
ke microarchitecture.",
@@ -131,6 +147,7 @@
     },
     {
         "BriefDescription": "Counts 1 per cycle for each PMH that is busy =
with a EPT (Extended Page Table) walk for any request type.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4f",
         "EventName": "EPT.WALK_PENDING",
         "PublicDescription": "Counts cycles for each PMH (Page Miss Handle=
r) that is busy with an EPT (Extended Page Table) walk for any request type=
.",
@@ -139,6 +156,7 @@
     },
     {
         "BriefDescription": "Flushing of the Instruction TLB (ITLB) pages,=
 includes 4k/2M/4M pages.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAE",
         "EventName": "ITLB.ITLB_FLUSH",
         "PublicDescription": "Counts the number of flushes of the big or s=
mall ITLB pages. Counting include both TLB Flush (covering all sets) and TL=
B Set Clear (set-specific).",
@@ -147,6 +165,7 @@
     },
     {
         "BriefDescription": "Misses at all ITLB levels that cause page wal=
ks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.MISS_CAUSES_A_WALK",
         "PublicDescription": "Counts page walks of any page size (4K/2M/4M=
/1G) caused by a code fetch. This implies it missed in the ITLB and further=
 levels of TLB, but the walk need not have completed.",
@@ -155,6 +174,7 @@
     },
     {
         "BriefDescription": "Instruction fetch requests that miss the ITLB=
 and hit the STLB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT",
         "SampleAfterValue": "100003",
@@ -162,6 +182,7 @@
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for code (instruction fetch) request. EPT page walk duration are e=
xcluded in Skylake.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_ACTIVE",
@@ -171,6 +192,7 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
@@ -179,6 +201,7 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (1G)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_1G",
         "PublicDescription": "Counts completed page walks (1G page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
@@ -187,6 +210,7 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (2M/4M)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
@@ -195,6 +219,7 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
@@ -203,6 +228,7 @@
     },
     {
         "BriefDescription": "Counts 1 per cycle for each PMH that is busy =
with a page walk for an instruction fetch request. EPT page walk duration a=
re excluded in Skylake.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_PENDING",
         "PublicDescription": "Counts 1 per cycle for each PMH (Page Miss H=
andler) that is busy with a page walk for an instruction fetch request. EPT=
 page walk duration are excluded in Skylake microarchitecture.",
@@ -211,6 +237,7 @@
     },
     {
         "BriefDescription": "DTLB flush attempts of the thread-specific en=
tries",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSH.DTLB_THREAD",
         "PublicDescription": "Counts the number of DTLB flush attempts of =
the thread-specific entries.",
@@ -219,6 +246,7 @@
     },
     {
         "BriefDescription": "STLB flush attempts",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSH.STLB_ANY",
         "PublicDescription": "Counts the number of any STLB flush attempts=
 (such as entire, VPID, PCID, InvPage, CR3 write, etc.).",
--=20
2.45.2.627.g7a2c4fd464-goog

