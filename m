Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36421A8F89
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738954376; cv=none; b=niJjdxf6oco5wD/O/0vPXP79TokiRSyRXnpFpcv/C9jCZzRCFbu+m2VD1wsp/ARbyTREv4c5k2hAlFdBtqAR7vNMKAT5D8l85fHOTsJMY8XUvwk4S5O3kp38Gg70V2SpDqHL1s7+EQxCNLsUFijb6VwX7tHHYZnt2rb0Ykii38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738954376; c=relaxed/simple;
	bh=G6uNzCS+U65ZOA5d0lIWDuFrcWcMa1a3IVhQYnpYUNk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=C4g+du5uYhOIP62G0KanDP4qwqxrDoPtlzp/+pPK93o2rwb2tezHkpIPlV8V3OX/eTnX4oAurE5L1DmQBxOmBl6VMFcCFinHW99/Ebl94AYL0Qeurf9QO4ytfwrxxVG/owc8cS84jTqvJPf7rKRoJZXcLhUsm5mml0tiAbIlqfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KUfj+SXK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KUfj+SXK"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e549b6c54a0so3497881276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 10:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738954345; x=1739559145; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pZTCVSv5Wv2E2u/kHVMmbHwD0FrkClTAzbMoTXgy/I=;
        b=KUfj+SXK6T0yDN3ZekzoRBuSOghdATWDtHmAwlJg50whEJeIAUfkQaSc6hh470ivMf
         aPFZG/gwS9jh4n664LqLYl8CTmJWCgRZcLKgVFwtV2Yr24FGEzHf8utq09amqrkQ7ICk
         UKCX3ksmOJwjrVIKhUwXk+AMHraiRv40S53UUcQKCVMB8Ak6uXOojHma5sze5z5MynsN
         HYFzpANLt43W2hdhhwtsmi2ZPHqktV5amR+a9m2WOZiF0fTby1XMoaG8I/MpIHYXiMr4
         uxDio/XDpRoQYsoEfkFWrtqbp0sEp+WhvMhtUHScCZ+AasaCX7xjAF+9N5M84N6BV8ch
         L1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738954345; x=1739559145;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2pZTCVSv5Wv2E2u/kHVMmbHwD0FrkClTAzbMoTXgy/I=;
        b=LszhH6BbyAMLl0IR2UNwHR+pOQnlIXcbPmz5Lxwrs4O5yBOOhLN2LuYutW3RClo+4U
         GbN2fI/syHj+08zbgVT/xVVrOxHGIluabsx/UD7NzO+59un7obBIhXY0GApQ9qfiZF4T
         vpBlihYsNpzLNcqYqBQmSngerjbtkArKzsxiDnEcUjdqCYST3mQqBA7T0NOoHoedbS70
         e6UnCM58VMpbnsDVeMlnTrqY+11OL8cOXdX3VCifz1d5eP7dd3Xw5h9yn/dGj/klXkg2
         ifiSD9V9O5TWrggBFw3Fif+lRRbiThgcZFqCpFVGCeDbVsm1qMoNHeZV35+OtI2wqTRY
         FmVA==
X-Forwarded-Encrypted: i=1; AJvYcCX04TEWzcsOuwKriU3DZh4sMi2wf3wne3CzH8wJ9XtEy1fJGqPA1gxXoha3fn+g0xVNflHZC7+d6rxrgP2l+L1r@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa9vNxjPd4rIrdiYy/r4VyJV5Pq5TdvRG3Sel6aq8hmKt/yd6/
	DC1lOJc74LZi4Hv9om4sCP1BbOjRAQ31wLgNtUbyt1fmk3MaZbWoSVBJWncMcbs/VGOZPrG5MMo
	vbvtfOw==
X-Google-Smtp-Source: AGHT+IF40ZbNsAak4A3rZpVVWBeCzvD4oZwUnOZLF2/g6eon0BN0Qnrx8bSkhfxHYelliDJDvMzGnl4Pjyon
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:79e4:4a45:1e80:ace5])
 (user=irogers job=sendgmr) by 2002:a05:6902:1685:b0:e5b:3ddb:3e18 with SMTP
 id 3f1490d57ef6-e5b4623fe8cmr43304276.5.1738954345192; Fri, 07 Feb 2025
 10:52:25 -0800 (PST)
Date: Fri,  7 Feb 2025 10:51:40 -0800
In-Reply-To: <20250207185154.824433-1-irogers@google.com>
Message-Id: <20250207185154.824433-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207185154.824433-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v7 11/24] perf vendor events: Update/add Graniterapids events/metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.02 to v1.06.
Add TMA metrics 5.02.

Bring in the event updates v1.06:
https://github.com/intel/perfmon/commit/de5502e51a86b0cf42d0807d4e8ed3c6299=
b4e6c
https://github.com/intel/perfmon/commit/79b9e512eab58641941a0b8d10ffe75914a=
87e17
https://github.com/intel/perfmon/commit/bc74a895e461b5ac720559da667e83a8fed=
f7829

The TMA 5.02 addition is from (with subsequent fixes):
https://github.com/intel/perfmon/commit/1d72913b2d938781fb28f3cc3507aaec5c2=
2d782

Update uncore IIO events umask with the change:
https://github.com/intel/perfmon/commit/d78e8a166537c9ceab4f2e901dc96c53667=
a2174
which should address an issue originally raised by Michael Petlan:
Reported-by: Michael Petlan <mpetlan@redhat.com>
Closes: https://lore.kernel.org/all/alpine.LRH.2.20.2401300733310.11354@Die=
go/

Co-developed-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/graniterapids/cache.json         |  130 +-
 .../arch/x86/graniterapids/counter.json       |   24 +-
 .../arch/x86/graniterapids/frontend.json      |   24 +-
 .../arch/x86/graniterapids/gnr-metrics.json   | 2325 +++++++++++++++++
 .../arch/x86/graniterapids/memory.json        |  121 +-
 .../arch/x86/graniterapids/metricgroups.json  |  145 +
 .../arch/x86/graniterapids/other.json         |  109 +
 .../arch/x86/graniterapids/pipeline.json      |   40 +-
 .../arch/x86/graniterapids/uncore-cache.json  |   48 +-
 .../arch/x86/graniterapids/uncore-cxl.json    |    2 -
 .../graniterapids/uncore-interconnect.json    |   87 +
 .../arch/x86/graniterapids/uncore-io.json     |  280 +-
 .../arch/x86/graniterapids/uncore-memory.json |  122 +-
 .../arch/x86/graniterapids/uncore-power.json  |   98 +
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 15 files changed, 3294 insertions(+), 263 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/gnr-metric=
s.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/metricgrou=
ps.json

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json b/tool=
s/perf/pmu-events/arch/x86/graniterapids/cache.json
index b56066274813..d155da8610d8 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
@@ -83,11 +83,11 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache when triggered by an L2 cache fill.",
+        "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache.",
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.SILENT",
-        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache when triggered by an L2 cache fill. These lines are ty=
pically in Shared or Exclusive state. A non-threaded event.",
+        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
@@ -320,7 +320,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW.",
         "SampleAfterValue": "1000003",
         "UMask": "0x81"
@@ -331,7 +330,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired store instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x82"
@@ -342,7 +340,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ANY",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores.",
         "SampleAfterValue": "1000003",
         "UMask": "0x83"
@@ -353,7 +350,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with locked=
 access.",
         "SampleAfterValue": "100007",
         "UMask": "0x21"
@@ -364,7 +360,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x41"
@@ -375,7 +370,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
-        "PEBS": "1",
         "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x42"
@@ -386,7 +380,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_HIT_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Number of retired load instructions with a c=
lean hit in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x9"
@@ -397,7 +390,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_HIT_STORES",
-        "PEBS": "1",
         "PublicDescription": "Number of retired store instructions that hi=
t in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0xa"
@@ -408,7 +400,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x11"
@@ -419,7 +410,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
-        "PEBS": "1",
         "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x12"
@@ -439,7 +429,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
         "SampleAfterValue": "20011",
         "UMask": "0x4"
@@ -450,7 +439,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x1"
@@ -461,7 +449,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were hits in L3 without snoops required.",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
@@ -472,7 +459,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x2"
@@ -483,7 +469,6 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
-        "PEBS": "1",
         "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -494,7 +479,6 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -504,7 +488,6 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD",
-        "PEBS": "1",
         "PublicDescription": "Retired load instructions whose data sources=
 was forwarded from a remote cache.",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
@@ -515,7 +498,6 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -525,7 +507,6 @@
         "Data_LA": "1",
         "EventCode": "0xd4",
         "EventName": "MEM_LOAD_MISC_RETIRED.UC",
-        "PEBS": "1",
         "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock).",
         "SampleAfterValue": "100007",
         "UMask": "0x4"
@@ -536,7 +517,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.FB_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready.",
         "SampleAfterValue": "100007",
         "UMask": "0x40"
@@ -547,7 +527,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
@@ -558,7 +537,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
@@ -569,7 +547,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
@@ -580,7 +557,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources.",
         "SampleAfterValue": "100021",
         "UMask": "0x10"
@@ -591,7 +567,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache.",
         "SampleAfterValue": "100021",
         "UMask": "0x4"
@@ -602,7 +577,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache.",
         "SampleAfterValue": "50021",
         "UMask": "0x20"
@@ -664,6 +638,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads that resulted in a s=
noop that hit in another core, which did not forward the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another core's caches which forwarded the unmodified data to th=
e requesting core.",
         "Counter": "0,1,2,3",
@@ -674,6 +658,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y a cache on a remote socket where a snoop hit a modified line in another c=
ore's caches which forwarded the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_CACHE.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1030000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y a cache on a remote socket where a snoop hit in another core's caches whi=
ch forwarded the unmodified data to the requesting core.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_CACHE.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x830000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit in=
 the L3 or were snooped from another core's caches on the same socket.",
         "Counter": "0,1,2,3",
@@ -704,6 +708,76 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that resulted in a snoop hit a modified line in another core's caches w=
hich forwarded the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C4477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by a cache on a remote socket where a snoop was sent=
 and data was returned (Modified or Not Modified).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1830004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by a cache on a remote socket where a snoop hit a mo=
dified line in another core's caches which forwarded the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1030004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by a cache on a remote socket where a snoop hit in a=
nother core's caches which forwarded the unmodified data to the requesting =
core.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x830004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that hit a modified line in a distant L3 Cache or were snooped from a d=
istant core's L1/L2 caches on this socket when the system is in SNC (sub-NU=
MA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1008004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that either hit a non-modified line in a distant L3 Cache or were snoop=
ed from a distant core's L1/L2 caches on this socket when the system is in =
SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x808004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO), hard=
ware prefetch RFOs (which bring data to L2), and software prefetches for ex=
clusive ownership (PREFETCHW) that hit to a (M)odified cacheline in the L3 =
or snoop filter.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.RFO_TO_CORE.L3_HIT_M",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F80040022",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Any memory transaction that reached the SQ.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/counter.json b/to=
ols/perf/pmu-events/arch/x86/graniterapids/counter.json
index 250781a8ca64..137da7efa8b1 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/counter.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/counter.json
@@ -19,6 +19,16 @@
         "CountersNumFixed": "0",
         "CountersNumGeneric": "4"
     },
+    {
+        "Unit": "CXLCM",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 8
+    },
+    {
+        "Unit": "CXLDP",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    },
     {
         "Unit": "B2HOT",
         "CountersNumFixed": "0",
@@ -52,26 +62,16 @@
     {
         "Unit": "PCU",
         "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
+        "CountersNumGeneric": "4"
     },
     {
         "Unit": "CHACMS",
         "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
+        "CountersNumGeneric": "4"
     },
     {
         "Unit": "MDF",
         "CountersNumFixed": "0",
         "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "CXLCM",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 8
-    },
-    {
-        "Unit": "CXLDP",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/frontend.json
index 663c1a0e55a2..dc81055941b1 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
@@ -41,7 +41,6 @@
         "EventName": "FRONTEND_RETIRED.ANY_ANT",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x9",
-        "PEBS": "1",
         "PublicDescription": "Always Not Taken (ANT) conditional retired b=
ranches (no BTB entry and not mispredicted)",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -53,7 +52,6 @@
         "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x1",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -65,7 +63,6 @@
         "EventName": "FRONTEND_RETIRED.DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x11",
-        "PEBS": "1",
         "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -77,7 +74,6 @@
         "EventName": "FRONTEND_RETIRED.ITLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x14",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -89,7 +85,6 @@
         "EventName": "FRONTEND_RETIRED.L1I_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x12",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -101,7 +96,6 @@
         "EventName": "FRONTEND_RETIRED.L2_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x13",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -113,7 +107,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600106",
-        "PEBS": "1",
         "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -125,7 +118,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x608006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -137,7 +129,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x601006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -149,7 +140,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600206",
-        "PEBS": "1",
         "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -161,7 +151,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x610006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -173,7 +162,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x100206",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -185,7 +173,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x602006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -197,7 +184,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600406",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -209,7 +195,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x620006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -221,7 +206,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x604006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -233,7 +217,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600806",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -244,8 +227,7 @@
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATE_SWPF",
         "MSRIndex": "0x3F7",
-        "MSRValue": "0x9",
-        "PEBS": "1",
+        "MSRValue": "0xA",
         "PublicDescription": "Number of Instruction Cache demand miss in s=
hadow of an on-going i-fetch cache-line triggered by PREFETCHIT0/1 instruct=
ions",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -257,7 +239,6 @@
         "EventName": "FRONTEND_RETIRED.MISP_ANT",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x9",
-        "PEBS": "1",
         "PublicDescription": "ANT retired branches that got just mispredic=
ted",
         "SampleAfterValue": "100007",
         "UMask": "0x2"
@@ -269,7 +250,6 @@
         "EventName": "FRONTEND_RETIRED.MS_FLOWS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
-        "PEBS": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
     },
@@ -280,7 +260,6 @@
         "EventName": "FRONTEND_RETIRED.STLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x15",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
@@ -292,7 +271,6 @@
         "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x17",
-        "PEBS": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x3"
     },
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json =
b/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
new file mode 100644
index 000000000000..a345b6874606
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
@@ -0,0 +1,2325 @@
+[
+    {
+        "BriefDescription": "C1 residency percent per core",
+        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C1_Core_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "C2 residency percent per package",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C2_Pkg_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "C6 residency percent per core",
+        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Core_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "C6 residency percent per package",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Pkg_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duration_=
time / 1e9",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
+    {
+        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
+        "MetricName": "cpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "The average number of cores that are in cstat=
e C0 as observed by the power control unit (PCU)",
+        "MetricExpr": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C0 / pcu_0@UNC_P_=
CLOCKTICKS@ * #num_packages",
+        "MetricGroup": "cpu_cstate",
+        "MetricName": "cpu_cstate_c0"
+    },
+    {
+        "BriefDescription": "The average number of cores are in cstate C6 =
as observed by the power control unit (PCU)",
+        "MetricExpr": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C6 / pcu_0@UNC_P_=
CLOCKTICKS@ * #num_packages",
+        "MetricGroup": "cpu_cstate",
+        "MetricName": "cpu_cstate_c6"
+    },
+    {
+        "BriefDescription": "CPU operating frequency (in GHz)",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC =
* #SYSTEM_TSC_FREQ / 1e9",
+        "MetricName": "cpu_operating_frequency",
+        "ScaleUnit": "1GHz"
+    },
+    {
+        "BriefDescription": "Percentage of time spent in the active CPU po=
wer state C0",
+        "MetricExpr": "tma_info_system_cpus_utilized",
+        "MetricName": "cpu_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
+        "MetricName": "dtlb_2nd_level_load_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions",
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricName": "dtlb_2nd_level_store_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Bandwidth observed by the integrated I/O traf=
fic controller (IIO) of IO reads that are initiated by end device controlle=
rs that are requesting memory from the CPU",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.ALL_PARTS * 4 / 1e=
6 / duration_time",
+        "MetricName": "iio_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth observed by the integrated I/O traf=
fic controller (IIO) of IO writes that are initiated by end device controll=
ers that are writing memory to the CPU",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.ALL_PARTS * 4 / 1=
e6 / duration_time",
+        "MetricName": "iio_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e6 / durati=
on_time",
+        "MetricName": "io_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the local CPU socket"=
,
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_LOCAL * 64 / 1e6 / =
duration_time",
+        "MetricName": "io_bandwidth_read_local",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from a remote CPU socket",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_REMOTE * 64 / 1e6 /=
 duration_time",
+        "MetricName": "io_bandwidth_read_remote",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM + UNC_CHA_TOR_INSERTS.=
IO_ITOMCACHENEAR) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the local CPU socket",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM_LOCAL + UNC_CHA_TOR_IN=
SERTS.IO_ITOMCACHENEAR_LOCAL) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_write_local",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to a remote CPU socket",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM_REMOTE + UNC_CHA_TOR_I=
NSERTS.IO_ITOMCACHENEAR_REMOTE) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_write_remote",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
+        "MetricName": "itlb_2nd_level_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 in L1 instruction cache (includes prefetches) to the total number of compl=
eted instructions",
+        "MetricExpr": "L2_RQSTS.ALL_CODE_RD / INST_RETIRED.ANY",
+        "MetricName": "l1_i_code_read_misses_with_prefetches_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of demand load requests hitti=
ng in L1 data cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_RETIRED.L1_HIT / INST_RETIRED.ANY",
+        "MetricName": "l1d_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of requests missing L1 data c=
ache (includes data+rfo w/ prefetches) to the total number of completed ins=
tructions",
+        "MetricExpr": "L1D.REPLACEMENT / INST_RETIRED.ANY",
+        "MetricName": "l1d_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read request missing =
L2 cache to the total number of completed instructions",
+        "MetricExpr": "L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_code_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed demand load requ=
ests hitting in L2 cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed data read reques=
t missing L2 cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_data_read_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of requests missing L2 cache =
(includes code+data+rfo w/ prefetches) to the total number of completed ins=
tructions",
+        "MetricExpr": "L2_LINES_IN.ALL / INST_RETIRED.ANY",
+        "MetricName": "l2_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD / INST_RETIRED.ANY"=
,
+        "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of data read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA + UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF) / INST_RETI=
RED.ANY",
+        "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) in nano seconds",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (UNC_CHA_CLOCKTICKS / (source_count(UNC_CHA_TOR_=
OCCUPANCY.IA_MISS_DRD) * #num_packages)) * duration_time",
+        "MetricName": "llc_demand_data_read_miss_latency",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to local memory in nano=
 seconds",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL / UN=
C_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL) / (UNC_CHA_CLOCKTICKS / (source_count(=
UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL) * #num_packages)) * duration_time"=
,
+        "MetricName": "llc_demand_data_read_miss_latency_for_local_request=
s",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to remote memory in nan=
o seconds",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE / U=
NC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE) / (UNC_CHA_CLOCKTICKS / (source_coun=
t(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE) * #num_packages)) * duration_ti=
me",
+        "MetricName": "llc_demand_data_read_miss_latency_for_remote_reques=
ts",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to DRAM in nano seconds=
",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_DDR) / (UNC_CHA_CLOCKTICKS / (source_count(UNC_=
CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR) * #num_packages)) * duration_time",
+        "MetricName": "llc_demand_data_read_miss_to_dram_latency",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to local memory",
+        "MetricExpr": "UNC_CHA_REQUESTS.READS_LOCAL * 64 / 1e6 / duration_=
time",
+        "MetricName": "llc_miss_local_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to local memory",
+        "MetricExpr": "UNC_CHA_REQUESTS.WRITES_LOCAL * 64 / 1e6 / duration=
_time",
+        "MetricName": "llc_miss_local_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to remote memory",
+        "MetricExpr": "UNC_CHA_REQUESTS.READS_REMOTE * 64 / 1e6 / duration=
_time",
+        "MetricName": "llc_miss_remote_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to remote memory",
+        "MetricExpr": "UNC_CHA_REQUESTS.WRITES_REMOTE * 64 / 1e6 / duratio=
n_time",
+        "MetricName": "llc_miss_remote_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "The ratio of number of completed memory load =
instructions to the total number completed instructions",
+        "MetricExpr": "MEM_INST_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
+        "MetricName": "loads_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "DDR memory read bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_CAS_COUNT_SCH0.RD + UNC_M_CAS_COUNT_SCH1.RD)=
 * 64 / 1e6 / duration_time",
+        "MetricName": "memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_CAS_COUNT_SCH0.RD + UNC_M_CAS_COUNT_SCH1.RD =
+ UNC_M_CAS_COUNT_SCH0.WR + UNC_M_CAS_COUNT_SCH1.WR) * 64 / 1e6 / duration_=
time",
+        "MetricName": "memory_bandwidth_total",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory write bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_CAS_COUNT_SCH0.WR + UNC_M_CAS_COUNT_SCH1.WR)=
 * 64 / 1e6 / duration_time",
+        "MetricName": "memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL + UNC_CHA_TO=
R_INSERTS.IA_MISS_DRD_PREF_LOCAL) / (UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL =
+ UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL + UNC_CHA_TOR_INSERTS.IA_MISS_=
DRD_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE)",
+        "MetricName": "numa_reads_addressed_to_local_dram",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE + UNC_CHA_T=
OR_INSERTS.IA_MISS_DRD_PREF_REMOTE) / (UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCA=
L + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL + UNC_CHA_TOR_INSERTS.IA_MIS=
S_DRD_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE)",
+        "MetricName": "numa_reads_addressed_to_remote_dram",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uops delivered from decoded instruction cache=
 (decoded stream buffer or DSB) as a percent of total uops delivered to Ins=
truction Decode Queue",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.=
MS_UOPS + LSD.UOPS)",
+        "MetricName": "percent_uops_delivered_from_decoded_icache",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uops delivered from legacy decode pipeline (M=
icro-instruction Translation Engine or MITE) as a percent of total uops del=
ivered to Instruction Decode Queue",
+        "MetricExpr": "IDQ.MITE_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ=
.MS_UOPS + LSD.UOPS)",
+        "MetricName": "percent_uops_delivered_from_legacy_decode_pipeline"=
,
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uops delivered from microcode sequencer (MS) =
as a percent of total uops delivered to Instruction Decode Queue",
+        "MetricExpr": "IDQ.MS_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.M=
S_UOPS + LSD.UOPS)",
+        "MetricName": "percent_uops_delivered_from_microcode_sequencer",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of cycles spent in System Manageme=
nt Interrupts.",
+        "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0=
 else 0)",
+        "MetricGroup": "smi",
+        "MetricName": "smi_cycles",
+        "MetricThreshold": "smi_cycles > 0.1",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Number of SMI interrupts.",
+        "MetricExpr": "msr@smi@",
+        "MetricGroup": "smi",
+        "MetricName": "smi_num",
+        "ScaleUnit": "1SMI#"
+    },
+    {
+        "BriefDescription": "The ratio of number of completed memory store=
 instructions to the total number completed instructions",
+        "MetricExpr": "MEM_INST_RETIRED.ALL_STORES / INST_RETIRED.ANY",
+        "MetricName": "stores_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations",
+        "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5_11 + UOPS_DISPATCHED.PORT_6) / (5 * tma_info_core_co=
re_clks)",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
+        "MetricName": "tma_alu_op_utilization",
+        "MetricThreshold": "tma_alu_op_utilization > 0.4",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the Advanced Matrix eXtensions (AMX) execution engine was busy with tile =
(arithmetic) operations",
+        "MetricExpr": "EXE.AMX_BUSY / tma_info_core_core_clks",
+        "MetricGroup": "BvCB;Compute;HPC;Server;TopdownL3;tma_L3_group;tma=
_core_bound_group",
+        "MetricName": "tma_amx_busy",
+        "MetricThreshold": "tma_amx_busy > 0.5 & tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
+        "MetricExpr": "78 * ASSISTS.ANY / tma_info_thread_slots",
+        "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequence=
r_group",
+        "MetricName": "tma_assists",
+        "MetricThreshold": "tma_assists > 0.1 & tma_microcode_sequencer > =
0.05 & tma_heavy_operations > 0.1",
+        "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists",
+        "MetricExpr": "63 * ASSISTS.SSE_AVX_MIX / tma_info_thread_slots",
+        "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
+        "MetricName": "tma_avx_assists",
+        "MetricThreshold": "tma_avx_assists > 0.1",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
+        "MetricGroup": "BvOB;Default;TmaL1;TopdownL1;tma_L1_group",
+        "MetricName": "tma_backend_bound",
+        "MetricThreshold": "tma_backend_bound > 0.2",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + t=
ma_retiring), 0)",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
+        "MetricName": "tma_bad_speculation",
+        "MetricThreshold": "tma_bad_speculation > 0.15",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_icache_misses + tma_itlb_misses =
+ tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches)",
+        "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
+        "MetricName": "tma_bottleneck_big_code",
+        "MetricThreshold": "tma_bottleneck_big_code > 20"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instructions used for =
program control-flow - a subset of the Retiring category in TMA",
+        "MetricExpr": "100 * ((BR_INST_RETIRED.ALL_BRANCHES + 2 * BR_INST_=
RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slots)",
+        "MetricGroup": "BvBO;Ret",
+        "MetricName": "tma_bottleneck_branching_overhead",
+        "MetricThreshold": "tma_bottleneck_branching_overhead > 5",
+        "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dr=
am_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_store_fwd_blk + tm=
a_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_fb_full)=
))",
+        "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricName": "tma_bottleneck_cache_memory_bandwidth",
+        "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + =
tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_l1_=
latency_dependency / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_de=
pendency + tma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_=
bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_d=
ram_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_st=
ore_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_load=
s + tma_fb_full)) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tma_=
l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_split_l=
oads / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_dependency + tma=
_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_bound * (tma_s=
tore_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_split_stores / (tma_store_latency + tma_false_sha=
ring + tma_split_stores + tma_streaming_stores + tma_dtlb_store)) + tma_mem=
ory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound =
+ tma_dram_bound + tma_store_bound)) * (tma_store_latency / (tma_store_late=
ncy + tma_false_sharing + tma_split_stores + tma_streaming_stores + tma_dtl=
b_store)))",
+        "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
+        "MetricName": "tma_bottleneck_cache_memory_latency",
+        "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency"
+    },
+    {
+        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
+        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_serializing_operation + tma_amx_busy + tma_ports_utilization) + tma_c=
ore_bound * tma_amx_busy / (tma_divider + tma_serializing_operation + tma_a=
mx_busy + tma_ports_utilization) + tma_core_bound * (tma_ports_utilization =
/ (tma_divider + tma_serializing_operation + tma_amx_busy + tma_ports_utili=
zation)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_utili=
zed_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
+        "MetricGroup": "BvCB;Cor;tma_issueComp",
+        "MetricName": "tma_bottleneck_compute_bound_est",
+        "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
+        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
+        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses + t=
ma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) - (1 - I=
NST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.MS\\,cmask\\=3D0x1@) * (tma_fe=
tch_latency * (tma_ms_switches + tma_branch_resteers * (tma_clears_resteers=
 + tma_mispredicts_resteers * tma_other_mispredicts / tma_branch_mispredict=
s) / (tma_mispredicts_resteers + tma_clears_resteers + tma_unknown_branches=
)) / (tma_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_sw=
itches + tma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_ms / (tma_=
mite + tma_dsb + tma_ms))) - tma_bottleneck_big_code",
+        "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
+        "MetricName": "tma_bottleneck_instruction_fetch_bw",
+        "MetricThreshold": "tma_bottleneck_instruction_fetch_bw > 20"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
+        "MetricExpr": "100 * ((1 - INST_RETIRED.REP_ITERATION / cpu@UOPS_R=
ETIRED.MS\\,cmask\\=3D0x1@) * (tma_fetch_latency * (tma_ms_switches + tma_b=
ranch_resteers * (tma_clears_resteers + tma_mispredicts_resteers * tma_othe=
r_mispredicts / tma_branch_mispredicts) / (tma_mispredicts_resteers + tma_c=
lears_resteers + tma_unknown_branches)) / (tma_icache_misses + tma_itlb_mis=
ses + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) +=
 tma_fetch_bandwidth * tma_ms / (tma_mite + tma_dsb + tma_ms)) + 10 * tma_m=
icrocode_sequencer * tma_other_mispredicts / tma_branch_mispredicts * tma_b=
ranch_mispredicts + tma_machine_clears * tma_other_nukes / tma_other_nukes =
+ tma_core_bound * (tma_serializing_operation + RS.EMPTY_RESOURCE / tma_inf=
o_thread_clks * tma_ports_utilized_0) / (tma_divider + tma_serializing_oper=
ation + tma_amx_busy + tma_ports_utilization) + tma_microcode_sequencer / (=
tma_few_uops_instructions + tma_microcode_sequencer) * (tma_assists / tma_m=
icrocode_sequencer) * tma_heavy_operations)",
+        "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
+        "MetricName": "tma_bottleneck_irregular_overhead",
+        "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
+        "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (=
tma_dtlb_load / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_depende=
ncy + tma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_bound=
 * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dra=
m_bound + tma_store_bound)) * (tma_dtlb_store / (tma_store_latency + tma_fa=
lse_sharing + tma_split_stores + tma_streaming_stores + tma_dtlb_store)))",
+        "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
+        "MetricName": "tma_bottleneck_memory_data_tlbs",
+        "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * =
(tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) * tma_remote_cach=
e / (tma_local_mem + tma_remote_mem + tma_remote_cache) + tma_l3_bound / (t=
ma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_boun=
d) * (tma_contested_accesses + tma_data_sharing) / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / =
(tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bo=
und) * tma_false_sharing / (tma_store_latency + tma_false_sharing + tma_spl=
it_stores + tma_streaming_stores + tma_dtlb_store - tma_store_latency)) + t=
ma_machine_clears * (1 - tma_other_nukes / tma_other_nukes))",
+        "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
+        "MetricName": "tma_bottleneck_memory_synchronization",
+        "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
+        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_contested_accesses, tma_data_sharing, tma_false_s=
haring, tma_machine_clears, tma_remote_cache"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses=
 + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches))",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
+        "MetricName": "tma_bottleneck_mispredictions",
+        "MetricThreshold": "tma_bottleneck_mispredictions > 20",
+        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of remaining bottlenecks =
in the back-end",
+        "MetricExpr": "100 - (tma_bottleneck_big_code + tma_bottleneck_ins=
truction_fetch_bw + tma_bottleneck_mispredictions + tma_bottleneck_cache_me=
mory_bandwidth + tma_bottleneck_cache_memory_latency + tma_bottleneck_memor=
y_data_tlbs + tma_bottleneck_memory_synchronization + tma_bottleneck_comput=
e_bound_est + tma_bottleneck_irregular_overhead + tma_bottleneck_branching_=
overhead + tma_bottleneck_useful_work)",
+        "MetricGroup": "BvOB;Cor;Offcore",
+        "MetricName": "tma_bottleneck_other_bottlenecks",
+        "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
+        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead",
+        "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCHES=
 + 2 * BR_INST_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slot=
s - tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_se=
quencer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)"=
,
+        "MetricGroup": "BvUW;Ret",
+        "MetricName": "tma_bottleneck_useful_work",
+        "MetricThreshold": "tma_bottleneck_useful_work > 20"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * sl=
ots",
+        "MetricGroup": "BadSpec;BrMispredicts;BvMP;Default;TmaL2;TopdownL2=
;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
+        "MetricName": "tma_branch_mispredicts",
+        "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: =
tma_bottleneck_mispredictions, tma_info_bad_spec_branch_misprediction_cost,=
 tma_mispredicts_resteers",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
+        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clk=
s + tma_unknown_branches",
+        "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
+        "MetricName": "tma_branch_resteers",
+        "MetricThreshold": "tma_branch_resteers > 0.05 & tma_fetch_latency=
 > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES. Related metrics: tma_l3_hit_latency, tma_store_latency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings)",
+        "MetricExpr": "CPU_CLK_UNHALTED.C01 / tma_info_thread_clks",
+        "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
+        "MetricName": "tma_c01_wait",
+        "MetricThreshold": "tma_c01_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings)",
+        "MetricExpr": "CPU_CLK_UNHALTED.C02 / tma_info_thread_clks",
+        "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
+        "MetricName": "tma_c02_wait",
+        "MetricThreshold": "tma_c02_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
+        "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
+        "MetricName": "tma_cisc",
+        "MetricThreshold": "tma_cisc > 0.1 & tma_microcode_sequencer > 0.0=
5 & tma_heavy_operations > 0.1",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
+        "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation) =
* INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clks",
+        "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
+        "MetricName": "tma_clears_resteers",
+        "MetricThreshold": "tma_clears_resteers > 0.05 & tma_branch_restee=
rs > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears. Sam=
ple with: INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound, tma=
_machine_clears, tma_microcode_sequencer, tma_ms_switches",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that hit in the L2 cache",
+        "MetricExpr": "max(0, FRONTEND_RETIRED.L1I_MISS * FRONTEND_RETIRED=
.L1I_MISS:R / tma_info_thread_clks - tma_code_l2_miss)",
+        "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
+        "MetricName": "tma_code_l2_hit",
+        "MetricThreshold": "tma_code_l2_hit > 0.05 & tma_icache_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that miss in the L2 cache",
+        "MetricExpr": "FRONTEND_RETIRED.L2_MISS * FRONTEND_RETIRED.L2_MISS=
:R / tma_info_thread_clks",
+        "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
+        "MetricName": "tma_code_l2_miss",
+        "MetricThreshold": "tma_code_l2_miss > 0.05 & tma_icache_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) ITLB was missed by instructions fetches, th=
at later on hit in second-level TLB (STLB)",
+        "MetricExpr": "max(0, FRONTEND_RETIRED.ITLB_MISS * FRONTEND_RETIRE=
D.ITLB_MISS:R / tma_info_thread_clks - tma_code_stlb_miss)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
+        "MetricName": "tma_code_stlb_hit",
+        "MetricThreshold": "tma_code_stlb_hit > 0.05 & tma_itlb_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by instruction fetches, perfor=
ming a hardware page walk",
+        "MetricExpr": "FRONTEND_RETIRED.STLB_MISS * FRONTEND_RETIRED.STLB_=
MISS:R / tma_info_thread_clks",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
+        "MetricName": "tma_code_stlb_miss",
+        "MetricThreshold": "tma_code_stlb_miss > 0.05 & tma_itlb_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for (instruction) code accesses",
+        "MetricExpr": "ITLB_MISSES.WALK_ACTIVE / tma_info_thread_clks * IT=
LB_MISSES.WALK_COMPLETED_2M_4M / (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISS=
ES.WALK_COMPLETED_2M_4M)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
+        "MetricName": "tma_code_stlb_miss_2m",
+        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 (instruction) code accesses",
+        "MetricExpr": "ITLB_MISSES.WALK_ACTIVE / tma_info_thread_clks * IT=
LB_MISSES.WALK_COMPLETED_4K / (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISSES.=
WALK_COMPLETED_2M_4M)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
+        "MetricName": "tma_code_stlb_miss_4k",
+        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by non-taken conditional bran=
ches",
+        "MetricExpr": "BR_MISP_RETIRED.COND_NTAKEN_COST * BR_MISP_RETIRED.=
COND_NTAKEN_COST:R / tma_info_thread_clks",
+        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricName": "tma_cond_nt_mispredicts",
+        "MetricThreshold": "tma_cond_nt_mispredicts > 0.05 & tma_branch_mi=
spredicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to misprediction by taken conditional branches",
+        "MetricExpr": "BR_MISP_RETIRED.COND_TAKEN_COST * BR_MISP_RETIRED.C=
OND_TAKEN_COST:R / tma_info_thread_clks",
+        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricName": "tma_cond_tk_mispredicts",
+        "MetricThreshold": "tma_cond_tk_mispredicts > 0.05 & tma_branch_mi=
spredicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
+        "MetricExpr": "((min(MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS * MEM_LOAD_=
L3_HIT_RETIRED.XSNP_MISS:R, MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS * (79 * tma_i=
nfo_system_core_frequency) - 4.4 * tma_info_system_core_frequency) if 0 < M=
EM_LOAD_L3_HIT_RETIRED.XSNP_MISS:R else MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS *=
 (79 * tma_info_system_core_frequency) - 4.4 * tma_info_system_core_frequen=
cy) + (min(MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * MEM_LOAD_L3_HIT_RETIRED.XSNP_=
FWD:R, MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (81 * tma_info_system_core_freque=
ncy) - 4.4 * tma_info_system_core_frequency) if 0 < MEM_LOAD_L3_HIT_RETIRED=
.XSNP_FWD:R else MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (81 * tma_info_system_c=
ore_frequency) - 4.4 * tma_info_system_core_frequency) * (OCR.DEMAND_DATA_R=
D.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DA=
TA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOA=
D_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
+        "MetricName": "tma_contested_accesses",
+        "MetricThreshold": "tma_contested_accesses > 0.05 & tma_l3_bound >=
 0.05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD, MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related =
metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_false=
_sharing, tma_machine_clears, tma_remote_cache",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
+        "MetricGroup": "Backend;Compute;Default;TmaL2;TopdownL2;tma_L2_gro=
up;tma_backend_bound_group",
+        "MetricName": "tma_core_bound",
+        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2=
",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
+        "MetricExpr": "((min(MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD * MEM_LOA=
D_L3_HIT_RETIRED.XSNP_NO_FWD:R, MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD * (79 *=
 tma_info_system_core_frequency) - 4.4 * tma_info_system_core_frequency) if=
 0 < MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD:R else MEM_LOAD_L3_HIT_RETIRED.XSN=
P_NO_FWD * (79 * tma_info_system_core_frequency) - 4.4 * tma_info_system_co=
re_frequency) + (min(MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * MEM_LOAD_L3_HIT_RET=
IRED.XSNP_FWD:R, MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (79 * tma_info_system_c=
ore_frequency) - 4.4 * tma_info_system_core_frequency) if 0 < MEM_LOAD_L3_H=
IT_RETIRED.XSNP_FWD:R else MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (79 * tma_inf=
o_system_core_frequency) - 4.4 * tma_info_system_core_frequency) * (1 - OCR=
.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM +=
 OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB=
_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issu=
eSyncxn;tma_l3_bound_group",
+        "MetricName": "tma_data_sharing",
+        "MetricThreshold": "tma_data_sharing > 0.05 & tma_l3_bound > 0.05 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_synch=
ronization, tma_contested_accesses, tma_false_sharing, tma_machine_clears, =
tma_remote_cache",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
+        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D0x1@ - cpu@I=
NST_DECODED.DECODERS\\,cmask\\=3D0x2@) / tma_info_core_core_clks / 2",
+        "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
+        "MetricName": "tma_decoder0_alone",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & tma_mite > 0.1 & tm=
a_fetch_bandwidth > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
+        "MetricExpr": "ARITH.DIV_ACTIVE / tma_info_thread_clks",
+        "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
+        "MetricName": "tma_divider",
+        "MetricThreshold": "tma_divider > 0.2 & tma_core_bound > 0.1 & tma=
_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIV_ACTIVE",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
+        "MetricExpr": "MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_thread_cl=
ks",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
+        "MetricName": "tma_dram_bound",
+        "MetricThreshold": "tma_dram_bound > 0.1 & tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
+        "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / tma_info=
_core_core_clks / 2",
+        "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
+        "MetricName": "tma_dsb",
+        "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_thread_=
clks",
+        "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
+        "MetricName": "tma_dsb_switches",
+        "MetricThreshold": "tma_dsb_switches > 0.05 & tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwi=
dth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_inf=
o_inst_mix_iptb, tma_lcp",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
+        "MetricExpr": "(min(MEM_INST_RETIRED.STLB_HIT_LOADS * MEM_INST_RET=
IRED.STLB_HIT_LOADS:R, MEM_INST_RETIRED.STLB_HIT_LOADS * 7) if 0 < MEM_INST=
_RETIRED.STLB_HIT_LOADS:R else MEM_INST_RETIRED.STLB_HIT_LOADS * 7) / tma_i=
nfo_thread_clks + tma_load_stlb_miss",
+        "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_l1_bound_group",
+        "MetricName": "tma_dtlb_load",
+        "MetricThreshold": "tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma=
_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS. Related metrics: tma_=
bottleneck_memory_data_tlbs, tma_dtlb_store",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
+        "MetricExpr": "(min(MEM_INST_RETIRED.STLB_HIT_STORES * MEM_INST_RE=
TIRED.STLB_HIT_STORES:R, MEM_INST_RETIRED.STLB_HIT_STORES * 7) if 0 < MEM_I=
NST_RETIRED.STLB_HIT_STORES:R else MEM_INST_RETIRED.STLB_HIT_STORES * 7) / =
tma_info_thread_clks + tma_store_stlb_miss",
+        "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_store_bound_group",
+        "MetricName": "tma_dtlb_store",
+        "MetricThreshold": "tma_dtlb_store > 0.05 & tma_store_bound > 0.2 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES. Related metrics: tma_bottleneck_mem=
ory_data_tlbs, tma_dtlb_load",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
+        "MetricExpr": "(170 * tma_info_system_core_frequency * cpu@OCR.DEM=
AND_RFO.L3_MISS\\,offcore_rsp\\=3D0x103b800002@ + 81 * tma_info_system_core=
_frequency * OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM) / tma_info_thread_clks",
+        "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
+        "MetricName": "tma_false_sharing",
+        "MetricThreshold": "tma_false_sharing > 0.05 & tma_store_bound > 0=
.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_bottleneck_memory_synchronization, t=
ma_contested_accesses, tma_data_sharing, tma_machine_clears, tma_remote_cac=
he",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
+        "MetricExpr": "L1D_PEND_MISS.FB_FULL / tma_info_thread_clks",
+        "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
+        "MetricName": "tma_fb_full",
+        "MetricThreshold": "tma_fb_full > 0.3",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_bottleneck_cache_memory_bandwidth, =
tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store_late=
ncy, tma_streaming_stores",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
+        "MetricGroup": "Default;FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_gr=
oup;tma_frontend_bound_group;tma_issueFB",
+        "MetricName": "tma_fetch_bandwidth",
+        "MetricThreshold": "tma_fetch_bandwidth > 0.2",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1, FRONTEND_RETIRED.LATE=
NCY_GE_1, FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switches,=
 tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_=
frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.U=
OP_DROPPING / tma_info_thread_slots",
+        "MetricGroup": "Default;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_=
frontend_bound_group",
+        "MetricName": "tma_fetch_latency",
+        "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16, FRONTEND_RETIRED.LATENCY_GE_8",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or more =
uops",
+        "MetricExpr": "max(0, tma_heavy_operations - tma_microcode_sequenc=
er)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_heavy_operations_group;=
tma_issueD0",
+        "MetricName": "tma_few_uops_instructions",
+        "MetricThreshold": "tma_few_uops_instructions > 0.05 & tma_heavy_o=
perations > 0.1",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or more=
 uops. This highly-correlates with the number of uops in such instructions.=
 Related metrics: tma_decoder0_alone",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
+        "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
+        "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
+        "MetricName": "tma_fp_arith",
+        "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > 0.=
6",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Floating Point (FP) Assists"=
,
+        "MetricExpr": "30 * ASSISTS.FP / tma_info_thread_slots",
+        "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
+        "MetricName": "tma_fp_assists",
+        "MetricThreshold": "tma_fp_assists > 0.1",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Floating-Point Divider unit was active",
+        "MetricExpr": "ARITH.FPDIV_ACTIVE / tma_info_thread_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
+        "MetricName": "tma_fp_divider",
+        "MetricThreshold": "tma_fp_divider > 0.2 & tma_divider > 0.2 & tma=
_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + FP_ARITH_INST_RETIR=
ED2.SCALAR) / (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
+        "MetricName": "tma_fp_scalar",
+        "MetricThreshold": "tma_fp_scalar > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vector_2=
56b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.VECTOR + FP_ARITH_INST_RETIR=
ED2.VECTOR) / (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
+        "MetricName": "tma_fp_vector",
+        "MetricThreshold": "tma_fp_vector > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6=
, tma_ports_utilized_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.128B_PACKED_HALF=
) / (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
+        "MetricName": "tma_fp_vector_128b",
+        "MetricThreshold": "tma_fp_vector_128b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized=
_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.256B_PACKED_HALF=
) / (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
+        "MetricName": "tma_fp_vector_256b",
+        "MetricThreshold": "tma_fp_vector_256b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_fp_vector_512b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized=
_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 512-bit wide vectors",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.512B_PACKED_HALF=
) / (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
+        "MetricName": "tma_fp_vector_512b",
+        "MetricThreshold": "tma_fp_vector_512b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 512-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vecto=
r_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UO=
P_DROPPING / tma_info_thread_slots",
+        "MetricGroup": "BvFB;BvIO;Default;PGO;TmaL1;TopdownL1;tma_L1_group=
",
+        "MetricName": "tma_frontend_bound",
+        "MetricThreshold": "tma_frontend_bound > 0.15",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions , where one uop can represent mul=
tiple contiguous instructions",
+        "MetricExpr": "tma_light_operations * INST_RETIRED.MACRO_FUSED / (=
tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
+        "MetricName": "tma_fused_instructions",
+        "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions , where one uop can represent mu=
ltiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of l=
egacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Oth=
er_Light_Ops in MTL!)}",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations , instructions that require =
two or more uops or micro-coded sequences",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
+        "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;tma_re=
tiring_group",
+        "MetricName": "tma_heavy_operations",
+        "MetricThreshold": "tma_heavy_operations > 0.1",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations , instructions that require=
 two or more uops or micro-coded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.([ICL+] Note this may overcount=
 due to approximation using indirect events; [ADL+]). Sample with: UOPS_RET=
IRED.HEAVY",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
+        "MetricExpr": "ICACHE_DATA.STALLS / tma_info_thread_clks",
+        "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
+        "MetricName": "tma_icache_misses",
+        "MetricThreshold": "tma_icache_misses > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS, FRONTEND_RETIRED.L1I_MISS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect CALL instructions=
",
+        "MetricExpr": "BR_MISP_RETIRED.INDIRECT_CALL_COST * BR_MISP_RETIRE=
D.INDIRECT_CALL_COST:R / tma_info_thread_clks",
+        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricName": "tma_ind_call_mispredicts",
+        "MetricThreshold": "tma_ind_call_mispredicts > 0.05 & tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect JMP instructions"=
,
+        "MetricExpr": "max((BR_MISP_RETIRED.INDIRECT_COST * BR_MISP_RETIRE=
D.INDIRECT_COST:R - BR_MISP_RETIRED.INDIRECT_CALL_COST * BR_MISP_RETIRED.IN=
DIRECT_CALL_COST:R) / tma_info_thread_clks, 0)",
+        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricName": "tma_ind_jump_mispredicts",
+        "MetricThreshold": "tma_ind_jump_mispredicts > 0.05 & tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Branch Misprediction Cost: Cycles representin=
g fraction of TMA slots wasted per non-speculative branch misprediction (re=
tired JEClear)",
+        "MetricExpr": "tma_bottleneck_mispredictions * tma_info_thread_slo=
ts / 6 / BR_MISP_RETIRED.ALL_BRANCHES / 100",
+        "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
+        "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
+        "PublicDescription": "Branch Misprediction Cost: Cycles representi=
ng fraction of TMA slots wasted per non-speculative branch misprediction (r=
etired JEClear). Related metrics: tma_bottleneck_mispredictions, tma_branch=
_mispredicts, tma_mispredicts_resteers"
+    },
+    {
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_NTAKEN",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_ntaken < 200"
+    },
+    {
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional taken branches (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_taken < 200"
+    },
+    {
+        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_indirect",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1000"
+    },
+    {
+        "BriefDescription": "Instructions per retired Mispredicts for retu=
rn branches (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RET",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_ret",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_ret < 500"
+    },
+    {
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmispredict",
+        "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200"
+    },
+    {
+        "BriefDescription": "Speculative to Retired ratio of all clears (c=
overing Mispredicts and nukes)",
+        "MetricExpr": "INT_MISC.CLEARS_COUNT / (BR_MISP_RETIRED.ALL_BRANCH=
ES + MACHINE_CLEARS.COUNT)",
+        "MetricGroup": "BrMispredicts",
+        "MetricName": "tma_info_bad_spec_spec_clears_ratio"
+    },
+    {
+        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_system_smt_2t=
_utilization > 0.5 else 0)",
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "tma_info_botlnk_l0_core_bound_likely",
+        "MetricThreshold": "tma_info_botlnk_l0_core_bound_likely > 0.5"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of DSB (uop cache) hits -=
 subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_latency + tma_fetch_bandwidth)) * (tma_dsb / (tma_mite + tma_dsb=
 + tma_ms)))",
+        "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
+        "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
+        "MetricThreshold": "tma_info_botlnk_l2_dsb_bandwidth > 10",
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) hits =
- subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb_s=
witches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_front=
end_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + t=
ma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_mite / (tma_mite + t=
ma_dsb + tma_ms))",
+        "MetricGroup": "DSBmiss;Fed;tma_issueFB",
+        "MetricName": "tma_info_botlnk_l2_dsb_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_=
frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + =
tma_lcp + tma_dsb_switches))",
+        "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
+        "MetricName": "tma_info_botlnk_l2_ic_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are CALL or RET",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_callret"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
+        "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL_B=
RANCHES",
+        "MetricGroup": "Bad;Branches;CodeGen;PGO",
+        "MetricName": "tma_info_branches_cond_nt"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are taken condition=
als",
+        "MetricExpr": "BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_BR=
ANCHES",
+        "MetricGroup": "Bad;Branches;CodeGen;PGO",
+        "MetricName": "tma_info_branches_cond_tk"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_=
TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_jump"
+    },
+    {
+        "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
+        "MetricExpr": "1 - (tma_info_branches_cond_nt + tma_info_branches_=
cond_tk + tma_info_branches_callret + tma_info_branches_jump)",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_other_branches"
+    },
+    {
+        "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
+        "MetricExpr": "(CPU_CLK_UNHALTED.DISTRIBUTED if #SMT_on else tma_i=
nfo_thread_clks)",
+        "MetricGroup": "SMT",
+        "MetricName": "tma_info_core_core_clks"
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_core_clks",
+        "MetricGroup": "Ret;SMT;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_core_coreipc"
+    },
+    {
+        "BriefDescription": "uops Executed per Cycle",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / tma_info_thread_clks",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_core_epc"
+    },
+    {
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / tma_info_core_core_clks",
+        "MetricGroup": "Flops;Ret",
+        "MetricName": "tma_info_core_flopc"
+    },
+    {
+        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
+        "MetricExpr": "(FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED.P=
ORT_1 + FP_ARITH_DISPATCHED.PORT_5) / (2 * tma_info_core_core_clks)",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_core_fp_arith_utilization",
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)"
+    },
+    {
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D0x1@",
+        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
+        "MetricName": "tma_info_core_ilp"
+    },
+    {
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
+        "MetricExpr": "IDQ.DSB_UOPS / UOPS_ISSUED.ANY",
+        "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
+        "MetricName": "tma_info_frontend_dsb_coverage",
+        "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 6 > 0.35",
+        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_inst_mix_iptb, tma_lcp"
+    },
+    {
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_SWI=
TCHES.PENALTY_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
+        "MetricGroup": "DSBmiss",
+        "MetricName": "tma_info_frontend_dsb_switch_cost"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to retired DSB misses",
+        "MetricExpr": "FRONTEND_RETIRED.ANY_DSB_MISS * FRONTEND_RETIRED.AN=
Y_DSB_MISS:R / tma_info_thread_clks",
+        "MetricGroup": "DSBmiss;Fed;FetchLat",
+        "MetricName": "tma_info_frontend_dsb_switches_ret",
+        "MetricThreshold": "tma_info_frontend_dsb_switches_ret > 0.05"
+    },
+    {
+        "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
+        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D0=
x1@",
+        "MetricGroup": "Fed;FetchBW",
+        "MetricName": "tma_info_frontend_fetch_upc"
+    },
+    {
+        "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
+        "MetricExpr": "ICACHE_DATA.STALLS / ICACHE_DATA.STALL_PERIODS",
+        "MetricGroup": "Fed;FetchLat;IcMiss",
+        "MetricName": "tma_info_frontend_icache_miss_latency"
+    },
+    {
+        "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "tma_info_frontend_ipdsb_miss_ret",
+        "MetricThreshold": "tma_info_frontend_ipdsb_miss_ret < 50"
+    },
+    {
+        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "tma_info_inst_mix_instructions / BACLEARS.ANY",
+        "MetricGroup": "Fed",
+        "MetricName": "tma_info_frontend_ipunknown_branch"
+    },
+    {
+        "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
+        "MetricExpr": "1e3 * FRONTEND_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_frontend_l2mpki_code"
+    },
+    {
+        "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
+        "MetricExpr": "1e3 * L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_frontend_l2mpki_code_all"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to retired operations that invoke th=
e Microcode Sequencer",
+        "MetricExpr": "FRONTEND_RETIRED.MS_FLOWS * FRONTEND_RETIRED.MS_FLO=
WS:R / tma_info_thread_clks",
+        "MetricGroup": "Fed;FetchLat;MicroSeq",
+        "MetricName": "tma_info_frontend_ms_latency_ret",
+        "MetricThreshold": "tma_info_frontend_ms_latency_ret > 0.05"
+    },
+    {
+        "BriefDescription": "Taken Branches retired Per Cycle",
+        "MetricExpr": "BR_INST_RETIRED.NEAR_TAKEN / tma_info_thread_clks",
+        "MetricGroup": "Branches;FetchBW",
+        "MetricName": "tma_info_frontend_tbpc"
+    },
+    {
+        "BriefDescription": "Average number of cycles the front-end was de=
layed due to an Unknown Branch detection",
+        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / cpu@INT_MISC.UNKNO=
WN_BRANCH_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
+        "MetricGroup": "Fed",
+        "MetricName": "tma_info_frontend_unknown_branch_cost",
+        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to retired branches who got branch a=
ddress clears",
+        "MetricExpr": "FRONTEND_RETIRED.UNKNOWN_BRANCH * FRONTEND_RETIRED.=
UNKNOWN_BRANCH:R / tma_info_thread_clks",
+        "MetricGroup": "Fed;FetchLat",
+        "MetricName": "tma_info_frontend_unknown_branches_ret"
+    },
+    {
+        "BriefDescription": "Branch instructions per taken branch",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
+        "MetricGroup": "Branches;Fed;PGO",
+        "MetricName": "tma_info_inst_mix_bptkbranch"
+    },
+    {
+        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
+        "MetricGroup": "Summary;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_inst_mix_instructions",
+        "PublicDescription": "Total number of retired Instructions. Sample=
 with: INST_RETIRED.PREC_DIST"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR + =
FP_ARITH_INST_RETIRED2.SCALAR + (FP_ARITH_INST_RETIRED.VECTOR + FP_ARITH_IN=
ST_RETIRED2.VECTOR))",
+        "MetricGroup": "Flops;InsType",
+        "MetricName": "tma_info_inst_mix_iparith",
+        "MetricThreshold": "tma_info_inst_mix_iparith < 10",
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D2.128B_PACKED_HALF)",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "tma_info_inst_mix_iparith_avx128",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D2.256B_PACKED_HALF)",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "tma_info_inst_mix_iparith_avx256",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.512B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D2.512B_PACKED_HALF)",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "tma_info_inst_mix_iparith_avx512",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx512 < 10",
+        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). Values < 1 are poss=
ible due to intentional FMA double counting"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_DOU=
BLE",
+        "MetricGroup": "Flops;FpScalar;InsType",
+        "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
+        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Half-Pr=
ecision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED2.SCALAR",
+        "MetricGroup": "Flops;FpScalar;InsType;Server",
+        "MetricName": "tma_info_inst_mix_iparith_scalar_hp",
+        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_hp < 10",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Half-P=
recision instruction (lower number means higher occurrence rate). Values < =
1 are possible due to intentional FMA double counting"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_SIN=
GLE",
+        "MetricGroup": "Flops;FpScalar;InsType",
+        "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
+        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting"
+    },
+    {
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Branches;Fed;InsType",
+        "MetricName": "tma_info_inst_mix_ipbranch",
+        "MetricThreshold": "tma_info_inst_mix_ipbranch < 8"
+    },
+    {
+        "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "MetricGroup": "Branches;Fed;PGO",
+        "MetricName": "tma_info_inst_mix_ipcall",
+        "MetricThreshold": "tma_info_inst_mix_ipcall < 200"
+    },
+    {
+        "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (cpu@FP_ARITH_INST_RETIRED.SCALA=
R_SINGLE\\,umask\\=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE +=
 4 * cpu@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * c=
pu@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARI=
TH_INST_RETIRED.512B_PACKED_SINGLE)",
+        "MetricGroup": "Flops;InsType",
+        "MetricName": "tma_info_inst_mix_ipflop",
+        "MetricThreshold": "tma_info_inst_mix_ipflop < 10"
+    },
+    {
+        "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
+        "MetricGroup": "InsType",
+        "MetricName": "tma_info_inst_mix_ipload",
+        "MetricThreshold": "tma_info_inst_mix_ipload < 3"
+    },
+    {
+        "BriefDescription": "Instructions per PAUSE (lower number means hi=
gher occurrence rate)",
+        "MetricExpr": "tma_info_inst_mix_instructions / CPU_CLK_UNHALTED.P=
AUSE_INST",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "tma_info_inst_mix_ippause"
+    },
+    {
+        "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
+        "MetricGroup": "InsType",
+        "MetricName": "tma_info_inst_mix_ipstore",
+        "MetricThreshold": "tma_info_inst_mix_ipstore < 8"
+    },
+    {
+        "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
+        "MetricExpr": "INST_RETIRED.ANY / SW_PREFETCH_ACCESS.ANY",
+        "MetricGroup": "Prefetches",
+        "MetricName": "tma_info_inst_mix_ipswpf",
+        "MetricThreshold": "tma_info_inst_mix_ipswpf < 100"
+    },
+    {
+        "BriefDescription": "Instructions per taken branch",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
+        "MetricName": "tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 6 * 2 + 1",
+        "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth=
, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_l1d_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw_2t"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_l2_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l2_cache_fill_bw_2t"
+    },
+    {
+        "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
+        "MetricExpr": "1e3 * L2_LINES_OUT.NON_SILENT / tma_info_inst_mix_i=
nstructions",
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_core_l2_evictions_nonsilent_pki"
+    },
+    {
+        "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
+        "MetricExpr": "1e3 * L2_LINES_OUT.SILENT / tma_info_inst_mix_instr=
uctions",
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_core_l2_evictions_silent_pki"
+    },
+    {
+        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_l3_cache_access_bw",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_core_l3_cache_access_bw_2t"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_l3_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l3_cache_fill_bw_2t"
+    },
+    {
+        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
+        "MetricGroup": "CacheHits;Mem",
+        "MetricName": "tma_info_memory_fb_hpki"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / tma_info_system_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l1d_cache_fill_bw"
+    },
+    {
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheHits;Mem",
+        "MetricName": "tma_info_memory_l1mpki"
+    },
+    {
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.AN=
Y",
+        "MetricGroup": "CacheHits;Mem",
+        "MetricName": "tma_info_memory_l1mpki_load"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / tma_info_system_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l2_cache_fill_bw"
+    },
+    {
+        "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
+        "MetricExpr": "1e3 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST_=
RETIRED.ANY",
+        "MetricGroup": "CacheHits;Mem",
+        "MetricName": "tma_info_memory_l2hpki_all"
+    },
+    {
+        "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
+        "MetricGroup": "CacheHits;Mem",
+        "MetricName": "tma_info_memory_l2hpki_load"
+    },
+    {
+        "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Backend;CacheHits;Mem",
+        "MetricName": "tma_info_memory_l2mpki"
+    },
+    {
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheHits;Mem;Offcore",
+        "MetricName": "tma_info_memory_l2mpki_all"
+    },
+    {
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
+        "MetricGroup": "CacheHits;Mem",
+        "MetricName": "tma_info_memory_l2mpki_load"
+    },
+    {
+        "BriefDescription": "Offcore requests (L2 cache miss) per kilo ins=
truction for demand RFOs",
+        "MetricExpr": "1e3 * L2_RQSTS.RFO_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Offcore",
+        "MetricName": "tma_info_memory_l2mpki_rfo"
+    },
+    {
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / tma_info=
_system_time",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_l3_cache_access_bw"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / tma_info_system=
_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_l3_cache_fill_bw"
+    },
+    {
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_l3mpki"
+    },
+    {
+        "BriefDescription": "Average Parallel L2 cache miss data reads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD / OFFCORE_REQU=
ESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_latency_data_l2_mlp"
+    },
+    {
+        "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
+        "MetricGroup": "LockCont;Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_latency_load_l2_miss_latency"
+    },
+    {
+        "BriefDescription": "Average Parallel L2 cache miss demand Loads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D0x1@",
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_latency_load_l2_mlp"
+    },
+    {
+        "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD=
 / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_latency_load_l3_miss_latency"
+    },
+    {
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / MEM_LOAD_COMPLETED.L1_MISS_=
ANY",
+        "MetricGroup": "Mem;MemoryBound;MemoryLat",
+        "MetricName": "tma_info_memory_load_miss_real_latency"
+    },
+    {
+        "BriefDescription": "\"Bus lock\" per kilo instruction",
+        "MetricExpr": "1e3 * SQ_MISC.BUS_LOCK / INST_RETIRED.ANY",
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_mix_bus_lock_pki"
+    },
+    {
+        "BriefDescription": "Off-core accesses per kilo instruction for mo=
dified write requests",
+        "MetricExpr": "1e3 * OCR.MODIFIED_WRITE.ANY_RESPONSE / tma_info_in=
st_mix_instructions",
+        "MetricGroup": "Offcore",
+        "MetricName": "tma_info_memory_mix_offcore_mwrite_any_pki"
+    },
+    {
+        "BriefDescription": "Off-core accesses per kilo instruction for re=
ads-to-core requests (speculative; including in-core HW prefetches)",
+        "MetricExpr": "1e3 * OCR.READS_TO_CORE.ANY_RESPONSE / tma_info_ins=
t_mix_instructions",
+        "MetricGroup": "CacheHits;Offcore",
+        "MetricName": "tma_info_memory_mix_offcore_read_any_pki"
+    },
+    {
+        "BriefDescription": "L3 cache misses per kilo instruction for read=
s-to-core requests (speculative; including in-core HW prefetches)",
+        "MetricExpr": "1e3 * OCR.READS_TO_CORE.L3_MISS / tma_info_inst_mix=
_instructions",
+        "MetricGroup": "Offcore",
+        "MetricName": "tma_info_memory_mix_offcore_read_l3m_pki"
+    },
+    {
+        "BriefDescription": "Un-cacheable retired load per kilo instructio=
n",
+        "MetricExpr": "1e3 * MEM_LOAD_MISC_RETIRED.UC / INST_RETIRED.ANY",
+        "MetricGroup": "Mem",
+        "MetricName": "tma_info_memory_mix_uc_load_pki"
+    },
+    {
+        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound",
+        "MetricName": "tma_info_memory_mlp",
+        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
+    },
+    {
+        "BriefDescription": "Rate of L2 HW prefetched lines that were not =
used by demand accesses",
+        "MetricExpr": "L2_LINES_OUT.USELESS_HWPF / (L2_LINES_OUT.SILENT + =
L2_LINES_OUT.NON_SILENT)",
+        "MetricGroup": "Prefetches",
+        "MetricName": "tma_info_memory_prefetches_useless_hwpf",
+        "MetricThreshold": "tma_info_memory_prefetches_useless_hwpf > 0.15=
"
+    },
+    {
+        "BriefDescription": "Average DRAM BW for Reads-to-Core (R2C) cover=
ing for memory attached to local- and remote-socket",
+        "MetricExpr": "64 * OCR.READS_TO_CORE.DRAM / 1e9 / tma_info_system=
_time",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
+        "MetricName": "tma_info_memory_soc_r2c_dram_bw",
+        "PublicDescription": "Average DRAM BW for Reads-to-Core (R2C) cove=
ring for memory attached to local- and remote-socket. See R2C_Offcore_BW"
+    },
+    {
+        "BriefDescription": "Average L3-cache miss BW for Reads-to-Core (R=
2C)",
+        "MetricExpr": "64 * OCR.READS_TO_CORE.L3_MISS / 1e9 / tma_info_sys=
tem_time",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
+        "MetricName": "tma_info_memory_soc_r2c_l3m_bw",
+        "PublicDescription": "Average L3-cache miss BW for Reads-to-Core (=
R2C). This covering going to DRAM or other memory off-chip memory tears. Se=
e R2C_Offcore_BW"
+    },
+    {
+        "BriefDescription": "Average Off-core access BW for Reads-to-Core =
(R2C)",
+        "MetricExpr": "64 * OCR.READS_TO_CORE.ANY_RESPONSE / 1e9 / tma_inf=
o_system_time",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
+        "MetricName": "tma_info_memory_soc_r2c_offcore_bw",
+        "PublicDescription": "Average Off-core access BW for Reads-to-Core=
 (R2C). R2C account for demand or prefetch load/RFO/code access that fill d=
ata into the Core caches"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
+        "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricGroup": "Fed;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_code_stlb_mpki"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to STLB misses by demand loads",
+        "MetricExpr": "MEM_INST_RETIRED.STLB_MISS_LOADS * MEM_INST_RETIRED=
.STLB_MISS_LOADS:R / tma_info_thread_clks",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_load_stlb_miss_ret",
+        "MetricThreshold": "tma_info_memory_tlb_load_stlb_miss_ret > 0.05"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
+        "MetricExpr": "1e3 * DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRE=
D.ANY",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_load_stlb_mpki"
+    },
+    {
+        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (4 * tma_info_core_core_clks)",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_page_walks_utilization",
+        "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to STLB misses by demand stores",
+        "MetricExpr": "MEM_INST_RETIRED.STLB_MISS_STORES * MEM_INST_RETIRE=
D.STLB_MISS_STORES:R / tma_info_thread_clks",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_store_stlb_miss_ret",
+        "MetricThreshold": "tma_info_memory_tlb_store_stlb_miss_ret > 0.05=
"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
+        "MetricExpr": "1e3 * DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIR=
ED.ANY",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_store_stlb_mpki"
+    },
+    {
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per core",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D0x1@)",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "tma_info_pipeline_execute"
+    },
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
+        "MetricExpr": "IDQ.MITE_UOPS / IDQ.MITE_CYCLES_ANY",
+        "MetricGroup": "Fed;FetchBW",
+        "MetricName": "tma_info_pipeline_fetch_mite"
+    },
+    {
+        "BriefDescription": "Instructions per a microcode Assist invocatio=
n",
+        "MetricExpr": "INST_RETIRED.ANY / ASSISTS.ANY",
+        "MetricGroup": "MicroSeq;Pipeline;Ret;Retire",
+        "MetricName": "tma_info_pipeline_ipassist",
+        "MetricThreshold": "tma_info_pipeline_ipassist < 100000",
+        "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)"
+    },
+    {
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D0x1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "tma_info_pipeline_retire"
+    },
+    {
+        "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
+        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.SLOTS=
\\,cmask\\=3D0x1@",
+        "MetricGroup": "MicroSeq;Pipeline;Ret",
+        "MetricName": "tma_info_pipeline_strings_cycles",
+        "MetricThreshold": "tma_info_pipeline_strings_cycles > 0.1"
+    },
+    {
+        "BriefDescription": "Fraction of cycles the processor is waiting y=
et unhalted; covering legacy PAUSE instruction, as well as C0.1 / C0.2 powe=
r-performance optimized states",
+        "MetricExpr": "CPU_CLK_UNHALTED.C0_WAIT / tma_info_thread_clks",
+        "MetricGroup": "C0Wait",
+        "MetricName": "tma_info_system_c0_wait",
+        "MetricThreshold": "tma_info_system_c0_wait > 0.05"
+    },
+    {
+        "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
+        "MetricGroup": "Power;Summary",
+        "MetricName": "tma_info_system_core_frequency"
+    },
+    {
+        "BriefDescription": "Average CPU Utilization (percentage)",
+        "MetricExpr": "tma_info_system_cpus_utilized / #num_cpus_online",
+        "MetricGroup": "HPC;Summary",
+        "MetricName": "tma_info_system_cpu_utilization"
+    },
+    {
+        "BriefDescription": "Average number of utilized CPUs",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_cpus_utilized"
+    },
+    {
+        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT_SCH0.RD + UNC_M_CAS_COUNT_SCH=
1.RD + UNC_M_CAS_COUNT_SCH0.WR + UNC_M_CAS_COUNT_SCH1.WR) / 1e9 / tma_info_=
system_time",
+        "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
+        "MetricName": "tma_info_system_dram_bw_use",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_cache_memory_ban=
dwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full"
+    },
+    {
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / 1e9 / tma_info_system_time",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_system_gflops",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width"
+    },
+    {
+        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Reads [GB / sec]",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e9 / tma_in=
fo_system_time",
+        "MetricGroup": "IoBW;MemOffcore;Server;SoC",
+        "MetricName": "tma_info_system_io_read_bw",
+        "PublicDescription": "Average IO (network or disk) Bandwidth Use f=
or Reads [GB / sec]. Bandwidth of IO reads that are initiated by end device=
 controllers that are requesting memory from the CPU"
+    },
+    {
+        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Writes [GB / sec]",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM + UNC_CHA_TOR_INSERTS.=
IO_ITOMCACHENEAR) * 64 / 1e9 / tma_info_system_time",
+        "MetricGroup": "IoBW;MemOffcore;Server;SoC",
+        "MetricName": "tma_info_system_io_write_bw",
+        "PublicDescription": "Average IO (network or disk) Bandwidth Use f=
or Writes [GB / sec]. Bandwidth of IO writes that are initiated by end devi=
ce controllers that are writing memory to the CPU"
+    },
+    {
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
+        "MetricGroup": "Branches;OS",
+        "MetricName": "tma_info_system_ipfarbranch",
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1000000"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_system_kernel_cpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_system_kernel_utilization",
+        "MetricThreshold": "tma_info_system_kernel_utilization > 0.05"
+    },
+    {
+        "BriefDescription": "Average latency of data read request to exter=
nal DRAM memory [in nanoseconds]",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_DDR) / cha_0@event\\=3D0x0@",
+        "MetricGroup": "MemOffcore;MemoryLat;Server;SoC",
+        "MetricName": "tma_info_system_mem_dram_read_latency",
+        "PublicDescription": "Average latency of data read request to exte=
rnal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 data=
-read prefetches"
+    },
+    {
+        "BriefDescription": "Average number of parallel data read requests=
 to external memory",
+        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / cha@UNC_CHA_TOR=
_OCCUPANCY.IA_MISS_DRD\\,thresh\\=3D0x1@",
+        "MetricGroup": "Mem;MemoryBW;SoC",
+        "MetricName": "tma_info_system_mem_parallel_reads",
+        "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches"
+    },
+    {
+        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P / CPU_CLK_UNHALTED.THREAD=
",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_mux",
+        "MetricThreshold": "tma_info_system_mux > 1.1 | tma_info_system_mu=
x < 0.9"
+    },
+    {
+        "BriefDescription": "Total package Power in Watts",
+        "MetricExpr": "(power@energy\\-pkg@ * 61 + 15.6 * power@energy\\-r=
am@) / (duration_time * 1e6)",
+        "MetricGroup": "Power;SoC",
+        "MetricName": "tma_info_system_power"
+    },
+    {
+        "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
+        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_U=
NHALTED.REF_DISTRIBUTED if #SMT_on else 0)",
+        "MetricGroup": "SMT",
+        "MetricName": "tma_info_system_smt_2t_utilization"
+    },
+    {
+        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
+        "MetricExpr": "cha_0@event\\=3D0x0@",
+        "MetricGroup": "SoC",
+        "MetricName": "tma_info_system_socket_clks"
+    },
+    {
+        "BriefDescription": "Run duration time in seconds",
+        "MetricExpr": "duration_time",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_time",
+        "MetricThreshold": "tma_info_system_time < 1"
+    },
+    {
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_system_turbo_utilization"
+    },
+    {
+        "BriefDescription": "Measured Average Uncore Frequency for the SoC=
 [GHz]",
+        "MetricExpr": "tma_info_system_socket_clks / 1e9 / tma_info_system=
_time",
+        "MetricGroup": "SoC",
+        "MetricName": "tma_info_system_uncore_frequency"
+    },
+    {
+        "BriefDescription": "Cross-socket Ultra Path Interconnect (UPI) da=
ta transmit bandwidth for data only [MB / sec]",
+        "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 64 / 9 / 1e6",
+        "MetricGroup": "Server;SoC",
+        "MetricName": "tma_info_system_upi_data_transmit_bw"
+    },
+    {
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "Pipeline",
+        "MetricName": "tma_info_thread_clks"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
+        "MetricExpr": "1 / tma_info_thread_ipc",
+        "MetricGroup": "Mem;Pipeline",
+        "MetricName": "tma_info_thread_cpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "The ratio of Executed- by Issued-Uops",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
+        "MetricGroup": "Cor;Pipeline",
+        "MetricName": "tma_info_thread_execute_per_issue",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage"
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_thread_clks",
+        "MetricGroup": "Ret;Summary",
+        "MetricName": "tma_info_thread_ipc"
+    },
+    {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
+        "MetricExpr": "slots",
+        "MetricGroup": "TmaL1;tma_L1_group",
+        "MetricName": "tma_info_thread_slots"
+    },
+    {
+        "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
+        "MetricExpr": "(tma_info_thread_slots / (slots / 2) if #SMT_on els=
e 1)",
+        "MetricGroup": "SMT;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_thread_slots_utilization"
+    },
+    {
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / INST_RETIRED=
.ANY",
+        "MetricGroup": "Pipeline;Ret;Retire",
+        "MetricName": "tma_info_thread_uoppi",
+        "MetricThreshold": "tma_info_thread_uoppi > 1.05"
+    },
+    {
+        "BriefDescription": "Uops per taken branch",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / BR_INST_RETI=
RED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fed;FetchBW",
+        "MetricName": "tma_info_thread_uptb",
+        "MetricThreshold": "tma_info_thread_uptb < 6 * 1.5"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Integer Divider unit was active",
+        "MetricExpr": "tma_divider - tma_fp_divider",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
+        "MetricName": "tma_int_divider",
+        "MetricThreshold": "tma_int_divider > 0.2 & tma_divider > 0.2 & tm=
a_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents overall Integer (Int) =
select operations fraction the CPU has executed (retired)",
+        "MetricExpr": "tma_int_vector_128b + tma_int_vector_256b",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_int_operations",
+        "MetricThreshold": "tma_int_operations > 0.1 & tma_light_operation=
s > 0.6",
+        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents 128-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired",
+        "MetricExpr": "(INT_VEC_RETIRED.ADD_128 + INT_VEC_RETIRED.VNNI_128=
) / (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
+        "MetricName": "tma_int_vector_128b",
+        "MetricThreshold": "tma_int_vector_128b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents 128-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_256b, tma=
_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents 256-bit vector Integer=
 ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fraction=
 the CPU has retired",
+        "MetricExpr": "(INT_VEC_RETIRED.ADD_256 + INT_VEC_RETIRED.MUL_256 =
+ INT_VEC_RETIRED.VNNI_256) / (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
+        "MetricName": "tma_int_vector_256b",
+        "MetricThreshold": "tma_int_vector_256b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fractio=
n the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_f=
p_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
+        "MetricExpr": "ICACHE_TAG.STALLS / tma_info_thread_clks",
+        "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
+        "MetricName": "tma_itlb_misses",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS, FRONTEND_RETIRED.ITLB_MISS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 Data (L1D) cache",
+        "MetricExpr": "max((EXE_ACTIVITY.BOUND_ON_LOADS - MEMORY_ACTIVITY.=
STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
+        "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_issueL1;tma_issueMC;tma_memory_bound_group",
+        "MetricName": "tma_l1_bound",
+        "MetricThreshold": "tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & =
tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1D. Another example is loads who miss in the TLB.=
 These cases are characterized by execution unit stalls; while some non-com=
pleted demand load lives in the machine without having that demand load mis=
sing the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT. Related metrics: t=
ma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tma_ms_swi=
tches, tma_ports_utilized_1",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric([SKL+] roughly; [LNL]) estimates =
fraction of cycles with demand load accesses that hit the L1D cache",
+        "MetricExpr": "min(2 * (MEM_INST_RETIRED.ALL_LOADS - MEM_LOAD_RETI=
RED.FB_HIT - MEM_LOAD_RETIRED.L1_MISS) * 20 / 100, max(CYCLE_ACTIVITY.CYCLE=
S_MEM_ANY - MEMORY_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
+        "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_l1_bound=
_group",
+        "MetricName": "tma_l1_latency_dependency",
+        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & tma_l1_bound=
 > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache. The s=
hort latency of the L1D cache may be exposed in pointer-chasing memory acce=
ss patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
+        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L1D_MISS - MEMORY_ACTIVITY.=
STALLS_L2_MISS) / tma_info_thread_clks",
+        "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
+        "MetricName": "tma_l2_bound",
+        "MetricThreshold": "tma_l2_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L2 cache under unloaded scenarios (poss=
ibly L2 latency limited)",
+        "MetricExpr": "(min(MEM_LOAD_RETIRED.L2_HIT * MEM_LOAD_RETIRED.L2_=
HIT:R, MEM_LOAD_RETIRED.L2_HIT * (4.4 * tma_info_system_core_frequency)) if=
 0 < MEM_LOAD_RETIRED.L2_HIT:R else MEM_LOAD_RETIRED.L2_HIT * (4.4 * tma_in=
fo_system_core_frequency)) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRE=
D.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l2_bound_grou=
p",
+        "MetricName": "tma_l2_hit_latency",
+        "MetricThreshold": "tma_l2_hit_latency > 0.05 & tma_l2_bound > 0.0=
5 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L2 cache under unloaded scenarios (pos=
sibly L2 latency limited).  Avoiding L1 cache misses (i.e. L1 misses/L2 hit=
s) will improve the latency. Sample with: MEM_LOAD_RETIRED.L2_HIT",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_ACTIVITY.S=
TALLS_L3_MISS) / tma_info_thread_clks",
+        "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
+        "MetricName": "tma_l3_bound",
+        "MetricThreshold": "tma_l3_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
+        "MetricExpr": "(min(MEM_LOAD_RETIRED.L3_HIT * MEM_LOAD_RETIRED.L3_=
HIT:R, MEM_LOAD_RETIRED.L3_HIT * (37 * tma_info_system_core_frequency) - 4.=
4 * tma_info_system_core_frequency) if 0 < MEM_LOAD_RETIRED.L3_HIT:R else M=
EM_LOAD_RETIRED.L3_HIT * (37 * tma_info_system_core_frequency) - 4.4 * tma_=
info_system_core_frequency) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIR=
ED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
+        "MetricName": "tma_l3_hit_latency",
+        "MetricThreshold": "tma_l3_hit_latency > 0.1 & tma_l3_bound > 0.05=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT. Related metrics: tma_b=
ottleneck_cache_memory_latency, tma_branch_resteers, tma_mem_latency, tma_s=
tore_latency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
+        "MetricExpr": "DECODE.LCP / tma_info_thread_clks",
+        "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
+        "MetricName": "tma_lcp",
+        "MetricThreshold": "tma_lcp > 0.05 & tma_fetch_latency > 0.1 & tma=
_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. Related metr=
ics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidt=
h, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_info_=
inst_mix_iptb",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations , instructions that require =
no more than one uop (micro-operation)",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
+        "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;tma_re=
tiring_group",
+        "MetricName": "tma_light_operations",
+        "MetricThreshold": "tma_light_operations > 0.6",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations , instructions that require=
 no more than one uop (micro-operation). This correlates with total number =
of instructions used by the program. A uops-per-instruction (see UopPI metr=
ic) ratio of 1 or less should be expected for decently optimized code runni=
ng on Intel Core/Xeon products. While this often indicates efficient X86 in=
structions were executed; high value does not necessarily mean better perfo=
rmance cannot be achieved. ([ICL+] Note this may undercount due to approxim=
ation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIST=
",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3_10 / (3 * tma_info_core_co=
re_clks)",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
+        "MetricName": "tma_load_op_utilization",
+        "MetricThreshold": "tma_load_op_utilization > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port for Load operations. Sample with: =
UOPS_DISPATCHED.PORT_2_3_10",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) DTLB was missed by load accesses, that late=
r on hit in second-level TLB (STLB)",
+        "MetricExpr": "max(0, tma_dtlb_load - tma_load_stlb_miss)",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
+        "MetricName": "tma_load_stlb_hit",
+        "MetricThreshold": "tma_load_stlb_hit > 0.05 & tma_dtlb_load > 0.1=
 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by load accesses, performing a=
 hardware page walk",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_thread_clks=
",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
+        "MetricName": "tma_load_stlb_miss",
+        "MetricThreshold": "tma_load_stlb_miss > 0.05 & tma_dtlb_load > 0.=
1 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_1G / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_1g",
+        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPL=
ETED_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_2m",
+        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_4K / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_4k",
+        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
+        "MetricExpr": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * MEM_LOAD_L3_M=
ISS_RETIRED.LOCAL_DRAM:R * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS / 2) / tma_info_thread_clks",
+        "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
+        "MetricName": "tma_local_mem",
+        "MetricThreshold": "tma_local_mem > 0.1 & tma_mem_latency > 0.1 & =
tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.LOCAL_DRAM",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
+        "MetricExpr": "MEM_INST_RETIRED.LOCK_LOADS * MEM_INST_RETIRED.LOCK=
_LOADS:R / tma_info_thread_clks",
+        "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
+        "MetricName": "tma_lock_latency",
+        "MetricThreshold": "tma_lock_latency > 0.2 & tma_l1_bound > 0.1 & =
tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS. Related metrics: tma_store_latency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "max(0, tma_bad_speculation - tma_branch_mispredicts=
)",
+        "MetricGroup": "BadSpec;BvMS;Default;MachineClears;TmaL2;TopdownL2=
;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
+        "MetricName": "tma_machine_clears",
+        "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation=
 > 0.15",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_bottleneck_memory_synchronization, tma_clears_resteers, tma_contested_a=
ccesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_s=
equencer, tma_ms_switches, tma_remote_cache",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to memory bandwidth Allocation=
 feature (RDT's memory bandwidth throttling)",
+        "MetricExpr": "INT_MISC.MBA_STALLS / tma_info_thread_clks",
+        "MetricGroup": "MemoryBW;Offcore;Server;TopdownL5;tma_L5_group;tma=
_mem_bandwidth_group",
+        "MetricName": "tma_mba_stalls",
+        "MetricThreshold": "tma_mba_stalls > 0.1 & tma_mem_bandwidth > 0.2=
 & tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2"=
,
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.DATA_RD\\,cmask\\=3D0x4@) / tma_info_thread_clks",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
+        "MetricName": "tma_mem_bandwidth",
+        "MetricThreshold": "tma_mem_bandwidth > 0.2 & tma_dram_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_bottleneck_cache_memory_bandwidth,=
 tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory - DRA=
M ([SPR-HBM] and/or HBM)",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
+        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
+        "MetricName": "tma_mem_latency",
+        "MetricThreshold": "tma_mem_latency > 0.1 & tma_dram_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_bottleneck_cache_memory_latency, tma_l3_hit_latency=
",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
+        "MetricGroup": "Backend;Default;TmaL2;TopdownL2;tma_L2_group;tma_b=
ackend_bound_group",
+        "MetricName": "tma_memory_bound",
+        "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
+        "MetricExpr": "13 * MISC2_RETIRED.LFENCE / tma_info_thread_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
+        "MetricName": "tma_memory_fence",
+        "MetricThreshold": "tma_memory_fence > 0.05 & tma_serializing_oper=
ation > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations , uops for memory load or store ac=
cesses",
+        "MetricExpr": "tma_light_operations * MEM_UOP_RETIRED.ANY / (tma_r=
etiring * tma_info_thread_slots)",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_memory_operations",
+        "MetricThreshold": "tma_memory_operations > 0.1 & tma_light_operat=
ions > 0.6",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
+        "MetricExpr": "UOPS_RETIRED.MS / tma_info_thread_slots",
+        "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
+        "MetricName": "tma_microcode_sequencer",
+        "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_ope=
rations > 0.1",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: UOPS_RETIRED.MS. Related metrics: tma_bottleneck_i=
rregular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clears, t=
ma_ms_switches",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
+        "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * INT_=
MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clks",
+        "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_group;=
tma_branch_resteers_group;tma_issueBM",
+        "MetricName": "tma_mispredicts_resteers",
+        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & tma_branch_r=
esteers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_bottleneck_mispredictions, tma_branch_mispredicts, tma_info_bad=
_spec_branch_misprediction_cost",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
+        "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / tma_in=
fo_core_core_clks / 2",
+        "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
+        "MetricName": "tma_mite",
+        "MetricThreshold": "tma_mite > 0.1 & tma_fetch_bandwidth > 0.2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued , the Count Do=
main; [ADL+] cycles)",
+        "MetricExpr": "160 * ASSISTS.SSE_AVX_MIX / tma_info_thread_clks",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_issueMV;tma_ports_utili=
zed_0_group",
+        "MetricName": "tma_mixing_vectors",
+        "MetricThreshold": "tma_mixing_vectors > 0.05",
+        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued , the Count D=
omain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investigat=
ing. Read more in Appendix B1 of the Optimizations Guide for this topic. Re=
lated metrics: tma_ms_switches",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details",
+        "MetricExpr": "max(IDQ.MS_CYCLES_ANY, cpu@UOPS_RETIRED.MS\\,cmask\=
\=3D0x1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY)) / tma_info_core_core_clk=
s / 2",
+        "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_fetch_bandwidt=
h_group",
+        "MetricName": "tma_ms",
+        "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
+        "MetricExpr": "3 * cpu@UOPS_RETIRED.MS\\,cmask\\=3D0x1\\,edge\\=3D=
0x1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY) / tma_info_thread_clks",
+        "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
+        "MetricName": "tma_ms_switches",
+        "MetricThreshold": "tma_ms_switches > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_bottlene=
ck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clear=
s, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_operation",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
+        "MetricExpr": "tma_light_operations * (BR_INST_RETIRED.ALL_BRANCHE=
S - INST_RETIRED.MACRO_FUSED) / (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
+        "MetricName": "tma_non_fused_branches",
+        "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
+        "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * tma_info_thread_slots)",
+        "MetricGroup": "BvBO;Pipeline;TopdownL4;tma_L4_group;tma_other_lig=
ht_ops_group",
+        "MetricName": "tma_nop_instructions",
+        "MetricThreshold": "tma_nop_instructions > 0.1 & tma_other_light_o=
ps > 0.3 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes",
+        "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_i=
nt_operations + tma_memory_operations + tma_fused_instructions + tma_non_fu=
sed_branches))",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_other_light_ops",
+        "MetricThreshold": "tma_other_light_ops > 0.3 & tma_light_operatio=
ns > 0.6",
+        "PublicDescription": "This metric represents the remaining light u=
ops fraction the CPU has executed - remaining means not covered by other si=
bling nodes. May undercount due to FMA double counting",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types)",
+        "MetricExpr": "max(tma_branch_mispredicts * (1 - BR_MISP_RETIRED.A=
LL_BRANCHES / (INT_MISC.CLEARS_COUNT - MACHINE_CLEARS.COUNT)), 0.0001)",
+        "MetricGroup": "BrMispredicts;BvIO;TopdownL3;tma_L3_group;tma_bran=
ch_mispredicts_group",
+        "MetricName": "tma_other_mispredicts",
+        "MetricThreshold": "tma_other_mispredicts > 0.05 & tma_branch_misp=
redicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
",
+        "MetricExpr": "max(tma_machine_clears * (1 - MACHINE_CLEARS.MEMORY=
_ORDERING / MACHINE_CLEARS.COUNT), 0.0001)",
+        "MetricGroup": "BvIO;Machine_Clears;TopdownL3;tma_L3_group;tma_mac=
hine_clears_group",
+        "MetricName": "tma_other_nukes",
+        "MetricThreshold": "tma_other_nukes > 0.05 & tma_machine_clears > =
0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Page Faults",
+        "MetricExpr": "99 * ASSISTS.PAGE_FAULT / tma_info_thread_slots",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_assists_group",
+        "MetricName": "tma_page_faults",
+        "MetricThreshold": "tma_page_faults > 0.05",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch)",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / tma_info_core_core_clks",
+        "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
+        "MetricName": "tma_port_0",
+        "MetricThreshold": "tma_port_0 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512=
b, tma_int_vector_128b, tma_int_vector_256b, tma_port_1, tma_port_6, tma_po=
rts_utilized_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU)",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / tma_info_core_core_clks",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
+        "MetricName": "tma_port_1",
+        "MetricThreshold": "tma_port_1 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_ve=
ctor_256b, tma_port_0, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simple=
 ALU)",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / tma_info_core_core_clks",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
+        "MetricName": "tma_port_6",
+        "MetricThreshold": "tma_port_6 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_1. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b=
, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_por=
ts_utilized_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (EX=
E_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_3_PORTS_UTIL)) / tm=
a_info_thread_clks if ARITH.DIV_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - EXE_=
ACTIVITY.BOUND_ON_LOADS else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EX=
E_ACTIVITY.2_3_PORTS_UTIL) / tma_info_thread_clks)",
+        "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
+        "MetricName": "tma_ports_utilization",
+        "MetricThreshold": "tma_ports_utilization > 0.15 & tma_core_bound =
> 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
+        "MetricExpr": "max(EXE_ACTIVITY.EXE_BOUND_0_PORTS - RESOURCE_STALL=
S.SCOREBOARD, 0) / tma_info_thread_clks",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
+        "MetricName": "tma_ports_utilized_0",
+        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_thread_clks",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
+        "MetricName": "tma_ports_utilized_1",
+        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL. Related m=
etrics: tma_l1_bound",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
+        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_thread_clks",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
+        "MetricName": "tma_ports_utilized_2",
+        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_=
int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
+        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_thread_clks",
+        "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
+        "MetricName": "tma_ports_utilized_3m",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
+        "MetricExpr": "(MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * MEM_LOAD_L3=
_MISS_RETIRED.REMOTE_HITM:R + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * MEM_LOA=
D_L3_MISS_RETIRED.REMOTE_FWD:R) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_is=
sueSyncxn;tma_mem_latency_group",
+        "MetricName": "tma_remote_cache",
+        "MetricThreshold": "tma_remote_cache > 0.05 & tma_mem_latency > 0.=
1 & tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. Sample with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM, MEM=
_LOAD_L3_MISS_RETIRED.REMOTE_FWD. Related metrics: tma_bottleneck_memory_sy=
nchronization, tma_contested_accesses, tma_data_sharing, tma_false_sharing,=
 tma_machine_clears",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
+        "MetricExpr": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * MEM_LOAD_L3_=
MISS_RETIRED.REMOTE_DRAM:R * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRE=
D.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
+        "MetricName": "tma_remote_mem",
+        "MetricThreshold": "tma_remote_mem > 0.1 & tma_mem_latency > 0.1 &=
 tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.REMOTE_DRAM",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by (indirect) RET instruction=
s",
+        "MetricExpr": "BR_MISP_RETIRED.RET_COST * BR_MISP_RETIRED.RET_COST=
:R / tma_info_thread_clks",
+        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricName": "tma_ret_mispredicts",
+        "MetricThreshold": "tma_ret_mispredicts > 0.05 & tma_branch_mispre=
dicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
+        "MetricGroup": "BvUW;Default;TmaL1;TopdownL1;tma_L1_group",
+        "MetricName": "tma_retiring",
+        "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.SLOTS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
+        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_thread_clks +=
 tma_c02_wait",
+        "MetricGroup": "BvIO;PortsUtil;TopdownL3;tma_L3_group;tma_core_bou=
nd_group;tma_issueSO",
+        "MetricName": "tma_serializing_operation",
+        "MetricThreshold": "tma_serializing_operation > 0.1 & tma_core_bou=
nd > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD. Related metri=
cs: tma_ms_switches",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring Shuffle operations of 256-bit vector size (FP or Int=
eger)",
+        "MetricExpr": "tma_light_operations * INT_VEC_RETIRED.SHUFFLES / (=
tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_other_ligh=
t_ops_group",
+        "MetricName": "tma_shuffles_256b",
+        "MetricThreshold": "tma_shuffles_256b > 0.1 & tma_other_light_ops =
> 0.3 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
+        "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / tma_info_thread_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
+        "MetricName": "tma_slow_pause",
+        "MetricThreshold": "tma_slow_pause > 0.05 & tma_serializing_operat=
ion > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTED.=
PAUSE_INST",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
+        "MetricExpr": "(min(MEM_INST_RETIRED.SPLIT_LOADS * MEM_INST_RETIRE=
D.SPLIT_LOADS:R, MEM_INST_RETIRED.SPLIT_LOADS * tma_info_memory_load_miss_r=
eal_latency) if 0 < MEM_INST_RETIRED.SPLIT_LOADS:R else MEM_INST_RETIRED.SP=
LIT_LOADS * tma_info_memory_load_miss_real_latency) / tma_info_thread_clks"=
,
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_split_loads",
+        "MetricThreshold": "tma_split_loads > 0.3",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricExpr": "(min(MEM_INST_RETIRED.SPLIT_STORES * MEM_INST_RETIR=
ED.SPLIT_STORES:R, MEM_INST_RETIRED.SPLIT_STORES) if 0 < MEM_INST_RETIRED.S=
PLIT_STORES:R else MEM_INST_RETIRED.SPLIT_STORES) / tma_info_thread_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
+        "MetricName": "tma_split_stores",
+        "MetricThreshold": "tma_split_stores > 0.2 & tma_store_bound > 0.2=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
+        "MetricExpr": "(XQ.FULL_CYCLES + L1D_PEND_MISS.L2_STALLS) / tma_in=
fo_thread_clks",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
+        "MetricName": "tma_sq_full",
+        "MetricThreshold": "tma_sq_full > 0.3 & tma_l3_bound > 0.05 & tma_=
memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, tma_m=
em_bandwidth",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
+        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_thread_clks=
",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
+        "MetricName": "tma_store_bound",
+        "MetricThreshold": "tma_store_bound > 0.2 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
+        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_store_fwd_blk",
+        "MetricThreshold": "tma_store_fwd_blk > 0.1 & tma_l1_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
+        "MetricExpr": "(MEM_STORE_RETIRED.L2_HIT * 10 * (1 - MEM_INST_RETI=
RED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_=
LOADS / MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE=
_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
+        "MetricGroup": "BvML;LockCont;MemoryLat;Offcore;TopdownL4;tma_L4_g=
roup;tma_issueRFO;tma_issueSL;tma_store_bound_group",
+        "MetricName": "tma_store_latency",
+        "MetricThreshold": "tma_store_latency > 0.1 & tma_store_bound > 0.=
2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_branch_resteers, tma_fb_full, tma_l=
3_hit_latency, tma_lock_latency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
+        "MetricExpr": "(UOPS_DISPATCHED.PORT_4_9 + UOPS_DISPATCHED.PORT_7_=
8) / (4 * tma_info_core_core_clks)",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
+        "MetricName": "tma_store_op_utilization",
+        "MetricThreshold": "tma_store_op_utilization > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port for Store operations. Sample with:=
 UOPS_DISPATCHED.PORT_7_8",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the TLB was missed by store accesses, hitting in the second-l=
evel TLB (STLB)",
+        "MetricExpr": "max(0, tma_dtlb_store - tma_store_stlb_miss)",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
+        "MetricName": "tma_store_stlb_hit",
+        "MetricThreshold": "tma_store_stlb_hit > 0.05 & tma_dtlb_store > 0=
.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > =
0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the STLB was missed by store accesses, performing a hardware page wal=
k",
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_core_=
clks",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
+        "MetricName": "tma_store_stlb_miss",
+        "MetricThreshold": "tma_store_stlb_miss > 0.05 & tma_dtlb_store > =
0.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound >=
 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_1G / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_1g",
+        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_2M_4M / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_C=
OMPLETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_2m",
+        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_4K / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_4k",
+        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to Streaming store memory accesses; Streaming store optimize out a =
read request required by RFO stores",
+        "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / tma_info_thread=
_clks",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueS=
mSt;tma_store_bound_group",
+        "MetricName": "tma_streaming_stores",
+        "MetricThreshold": "tma_streaming_stores > 0.2 & tma_store_bound >=
 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE. Related metrics: tma=
_fb_full",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
+        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / tma_info_thread_cl=
ks",
+        "MetricGroup": "BigFootprint;BvBC;FetchLat;TopdownL4;tma_L4_group;=
tma_branch_resteers_group",
+        "MetricName": "tma_unknown_branches",
+        "MetricThreshold": "tma_unknown_branches > 0.05 & tma_branch_reste=
ers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit) hence called Unknown Bran=
ches. Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
+        "MetricExpr": "tma_retiring * UOPS_EXECUTED.X87 / UOPS_EXECUTED.TH=
READ",
+        "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
+        "MetricName": "tma_x87_use",
+        "MetricThreshold": "tma_x87_use > 0.1 & tma_fp_arith > 0.2 & tma_l=
ight_operations > 0.6",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uncore operating frequency in GHz",
+        "MetricExpr": "UNC_CHA_CLOCKTICKS / (source_count(UNC_CHA_CLOCKTIC=
KS) * #num_packages) / 1e9 / duration_time",
+        "MetricName": "uncore_frequency",
+        "ScaleUnit": "1GHz"
+    },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data r=
eceive bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / 1e=
6 / duration_time",
+        "MetricName": "upi_data_receive_bw",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data t=
ransmit bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e=
6 / duration_time",
+        "MetricName": "upi_data_transmit_bw",
+        "ScaleUnit": "1MB/s"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/memory.json b/too=
ls/perf/pmu-events/arch/x86/graniterapids/memory.json
index 38b74c6752c2..5da5a10275ba 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/memory.json
@@ -72,7 +72,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x400",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency.",
         "SampleAfterValue": "53",
         "UMask": "0x1"
@@ -85,7 +84,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "1009",
         "UMask": "0x1"
@@ -98,7 +96,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "20011",
         "UMask": "0x1"
@@ -111,7 +108,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x800",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency.",
         "SampleAfterValue": "23",
         "UMask": "0x1"
@@ -124,7 +120,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "503",
         "UMask": "0x1"
@@ -137,7 +132,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -150,7 +144,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
@@ -163,7 +156,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "101",
         "UMask": "0x1"
@@ -176,7 +168,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "2003",
         "UMask": "0x1"
@@ -189,7 +180,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "50021",
         "UMask": "0x1"
@@ -200,7 +190,6 @@
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
-        "PEBS": "2",
         "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
@@ -245,6 +234,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches and t=
he cacheline is homed locally.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F04C04477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that missed the L3 Cache and were supplied by the local socket (DRAM or=
 PMM), whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PM=
M or DRAM accesses that are controlled by the close or distant SNC Cluster.=
  It does not count misses to the L3 which go to Local CXL Type 2 Memory or=
 Local Non DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL_SOCKET",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x70CC04477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data read requests that miss th=
e L3 cache.",
         "Counter": "0,1,2,3",
@@ -271,5 +280,95 @@
         "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED",
+        "PublicDescription": "Counts the number of times RTM abort was tri=
ggered.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted due =
to none of the previous 3 categories (e.g. interrupt)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED_EVENTS",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to none of the previous 3 categories (e.g. interrupt).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted due =
to various memory events (e.g. read/write capacity and conflicts)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED_MEM",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to various memory events (e.g. read/write capacity and conflict=
s).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted due =
to incompatible memory type",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED_MEMTYPE",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to incompatible memory type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted due =
to HLE-unfriendly instructions",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED_UNFRIENDLY",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to HLE-unfriendly instructions.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution successfully=
 committed",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.COMMIT",
+        "PublicDescription": "Counts the number of times RTM commit succee=
ded.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution started.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.START",
+        "PublicDescription": "Counts the number of times we entered an RTM=
 region. Does not count nested transactions.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "TX_MEM.ABORT_CAPACITY_READ",
+        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional reads",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional writes.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
+        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional writes.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of times a transactional abort was sig=
naled due to a data conflict on a transactionally accessed address",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "TX_MEM.ABORT_CONFLICT",
+        "PublicDescription": "Counts the number of times a TSX line had a =
cache conflict.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json=
 b/tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json
new file mode 100644
index 000000000000..9129fb7b7ce4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json
@@ -0,0 +1,145 @@
+{
+    "Backend": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
+    "Bad": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "BadSpec": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
+    "BigFootprint": "Grouping from Top-down Microarchitecture Analysis Met=
rics spreadsheet",
+    "BrMispredicts": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
+    "Branches": "Grouping from Top-down Microarchitecture Analysis Metrics=
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
+    "C0Wait": "Grouping from Top-down Microarchitecture Analysis Metrics s=
preadsheet",
+    "CacheHits": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
+    "CacheMisses": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
+    "CodeGen": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
+    "Compute": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
+    "Cor": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "DSB": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "DSBmiss": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
+    "DataSharing": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
+    "Fed": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "FetchBW": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
+    "FetchLat": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "Flops": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
+    "FpScalar": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "FpVector": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "Frontend": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "HPC": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "IcMiss": "Grouping from Top-down Microarchitecture Analysis Metrics s=
preadsheet",
+    "InsType": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
+    "IntVector": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
+    "IoBW": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "L2Evicts": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "LSD": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "LockCont": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "MachineClears": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
+    "Machine_Clears": "Grouping from Top-down Microarchitecture Analysis M=
etrics spreadsheet",
+    "Mem": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "MemOffcore": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
+    "MemoryBW": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "MemoryBound": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
+    "MemoryLat": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
+    "MemoryTLB": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
+    "Memory_BW": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
+    "Memory_Lat": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
+    "MicroSeq": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "OS": "Grouping from Top-down Microarchitecture Analysis Metrics sprea=
dsheet",
+    "Offcore": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
+    "PGO": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "Pipeline": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "PortsUtil": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
+    "Power": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
+    "Prefetches": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
+    "Ret": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "Retire": "Grouping from Top-down Microarchitecture Analysis Metrics s=
preadsheet",
+    "SMT": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "Server": "Grouping from Top-down Microarchitecture Analysis Metrics s=
preadsheet",
+    "Snoop": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
+    "SoC": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "Summary": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
+    "TmaL1": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
+    "TmaL2": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
+    "TmaL3mem": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "TopdownL1": "Metrics for top-down breakdown at level 1",
+    "TopdownL2": "Metrics for top-down breakdown at level 2",
+    "TopdownL3": "Metrics for top-down breakdown at level 3",
+    "TopdownL4": "Metrics for top-down breakdown at level 4",
+    "TopdownL5": "Metrics for top-down breakdown at level 5",
+    "TopdownL6": "Metrics for top-down breakdown at level 6",
+    "tma_L1_group": "Metrics for top-down breakdown at level 1",
+    "tma_L2_group": "Metrics for top-down breakdown at level 2",
+    "tma_L3_group": "Metrics for top-down breakdown at level 3",
+    "tma_L4_group": "Metrics for top-down breakdown at level 4",
+    "tma_L5_group": "Metrics for top-down breakdown at level 5",
+    "tma_L6_group": "Metrics for top-down breakdown at level 6",
+    "tma_alu_op_utilization_group": "Metrics contributing to tma_alu_op_ut=
ilization category",
+    "tma_assists_group": "Metrics contributing to tma_assists category",
+    "tma_backend_bound_group": "Metrics contributing to tma_backend_bound =
category",
+    "tma_bad_speculation_group": "Metrics contributing to tma_bad_speculat=
ion category",
+    "tma_branch_mispredicts_group": "Metrics contributing to tma_branch_mi=
spredicts category",
+    "tma_branch_resteers_group": "Metrics contributing to tma_branch_reste=
ers category",
+    "tma_code_stlb_miss_group": "Metrics contributing to tma_code_stlb_mis=
s category",
+    "tma_core_bound_group": "Metrics contributing to tma_core_bound catego=
ry",
+    "tma_divider_group": "Metrics contributing to tma_divider category",
+    "tma_dram_bound_group": "Metrics contributing to tma_dram_bound catego=
ry",
+    "tma_dtlb_load_group": "Metrics contributing to tma_dtlb_load category=
",
+    "tma_dtlb_store_group": "Metrics contributing to tma_dtlb_store catego=
ry",
+    "tma_fetch_bandwidth_group": "Metrics contributing to tma_fetch_bandwi=
dth category",
+    "tma_fetch_latency_group": "Metrics contributing to tma_fetch_latency =
category",
+    "tma_fp_arith_group": "Metrics contributing to tma_fp_arith category",
+    "tma_fp_vector_group": "Metrics contributing to tma_fp_vector category=
",
+    "tma_frontend_bound_group": "Metrics contributing to tma_frontend_boun=
d category",
+    "tma_heavy_operations_group": "Metrics contributing to tma_heavy_opera=
tions category",
+    "tma_icache_misses_group": "Metrics contributing to tma_icache_misses =
category",
+    "tma_int_operations_group": "Metrics contributing to tma_int_operation=
s category",
+    "tma_issue2P": "Metrics related by the issue $issue2P",
+    "tma_issueBM": "Metrics related by the issue $issueBM",
+    "tma_issueBW": "Metrics related by the issue $issueBW",
+    "tma_issueComp": "Metrics related by the issue $issueComp",
+    "tma_issueD0": "Metrics related by the issue $issueD0",
+    "tma_issueFB": "Metrics related by the issue $issueFB",
+    "tma_issueFL": "Metrics related by the issue $issueFL",
+    "tma_issueL1": "Metrics related by the issue $issueL1",
+    "tma_issueLat": "Metrics related by the issue $issueLat",
+    "tma_issueMC": "Metrics related by the issue $issueMC",
+    "tma_issueMS": "Metrics related by the issue $issueMS",
+    "tma_issueMV": "Metrics related by the issue $issueMV",
+    "tma_issueRFO": "Metrics related by the issue $issueRFO",
+    "tma_issueSL": "Metrics related by the issue $issueSL",
+    "tma_issueSO": "Metrics related by the issue $issueSO",
+    "tma_issueSmSt": "Metrics related by the issue $issueSmSt",
+    "tma_issueSpSt": "Metrics related by the issue $issueSpSt",
+    "tma_issueSyncxn": "Metrics related by the issue $issueSyncxn",
+    "tma_issueTLB": "Metrics related by the issue $issueTLB",
+    "tma_itlb_misses_group": "Metrics contributing to tma_itlb_misses cate=
gory",
+    "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category",
+    "tma_l2_bound_group": "Metrics contributing to tma_l2_bound category",
+    "tma_l3_bound_group": "Metrics contributing to tma_l3_bound category",
+    "tma_light_operations_group": "Metrics contributing to tma_light_opera=
tions category",
+    "tma_load_op_utilization_group": "Metrics contributing to tma_load_op_=
utilization category",
+    "tma_load_stlb_miss_group": "Metrics contributing to tma_load_stlb_mis=
s category",
+    "tma_machine_clears_group": "Metrics contributing to tma_machine_clear=
s category",
+    "tma_mem_bandwidth_group": "Metrics contributing to tma_mem_bandwidth =
category",
+    "tma_mem_latency_group": "Metrics contributing to tma_mem_latency cate=
gory",
+    "tma_memory_bound_group": "Metrics contributing to tma_memory_bound ca=
tegory",
+    "tma_microcode_sequencer_group": "Metrics contributing to tma_microcod=
e_sequencer category",
+    "tma_mite_group": "Metrics contributing to tma_mite category",
+    "tma_other_light_ops_group": "Metrics contributing to tma_other_light_=
ops category",
+    "tma_ports_utilization_group": "Metrics contributing to tma_ports_util=
ization category",
+    "tma_ports_utilized_0_group": "Metrics contributing to tma_ports_utili=
zed_0 category",
+    "tma_ports_utilized_3m_group": "Metrics contributing to tma_ports_util=
ized_3m category",
+    "tma_retiring_group": "Metrics contributing to tma_retiring category",
+    "tma_serializing_operation_group": "Metrics contributing to tma_serial=
izing_operation category",
+    "tma_store_bound_group": "Metrics contributing to tma_store_bound cate=
gory",
+    "tma_store_op_utilization_group": "Metrics contributing to tma_store_o=
p_utilization category",
+    "tma_store_stlb_miss_group": "Metrics contributing to tma_store_stlb_m=
iss category"
+}
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/other.json b/tool=
s/perf/pmu-events/arch/x86/graniterapids/other.json
index 8b9b3c920934..8df37f303273 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/other.json
@@ -1,4 +1,13 @@
 [
+    {
+        "BriefDescription": "Count all other hardware assists or traps tha=
t are not necessarily architecturally exposed (through a software handler) =
beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-eve=
nts. the event also counts for Machine Ordering count.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.HARDWARE",
+        "PublicDescription": "Count all other hardware assists or traps th=
at are not necessarily architecturally exposed (through a software handler)=
 beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-ev=
ents.  This includes, but not limited to, assists at EXE or MEM uop writeba=
ck like AVX* load/store/gather/scatter (non-FP GSSE-assist ) , assists gene=
rated by ROB like PEBS and RTIT, Uncore trap, RAR (Remote Action Request) a=
nd CET (Control flow Enforcement Technology) assists. the event also counts=
 for Machine Ordering count.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "ASSISTS.PAGE_FAULT",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -65,6 +74,36 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In S=
NC Mode counts only those DRAM accesses that are controlled by the close SN=
C Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x730000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F3FFC0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM.",
         "Counter": "0,1,2,3",
@@ -115,6 +154,66 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, unless in Sub NUMA =
Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are co=
ntrolled by the close SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, whether or not in S=
ub NUMA Cluster(SNC) Mode.  In SNC Mode counts DRAM accesses that are contr=
olled by the close or distant SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x70C004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches and w=
ere supplied by a remote socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F33004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x730004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM or PMM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_MEMORY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x733004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM on a distant memory controller of this socke=
t when the system is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.SNC_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x708004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3",
@@ -125,6 +224,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts Demand RFOs, ItoM's, PREFECTHW's, Hard=
ware RFO Prefetches to the L1/L2 and Streaming stores that likely resulted =
in a store to Memory (DRAM or PMM)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.WRITE_ESTIMATE.MEMORY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0xFBFF80822",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
index 0ef9daf64e2e..da6478607984 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
@@ -32,7 +32,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
         "PublicDescription": "Counts all branch instructions retired.",
         "SampleAfterValue": "400009"
     },
@@ -41,7 +40,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
-        "PEBS": "1",
         "PublicDescription": "Counts conditional branch instructions retir=
ed.",
         "SampleAfterValue": "400009",
         "UMask": "0x11"
@@ -51,7 +49,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_NTAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts not taken branch instructions retired=
.",
         "SampleAfterValue": "400009",
         "UMask": "0x10"
@@ -61,7 +58,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts taken conditional branch instructions=
 retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1"
@@ -71,7 +67,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "PEBS": "1",
         "PublicDescription": "Counts far branch instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x40"
@@ -81,7 +76,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
-        "PEBS": "1",
         "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch.",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
@@ -91,7 +85,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PEBS": "1",
         "PublicDescription": "Counts both direct and indirect near call in=
structions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x2"
@@ -101,7 +94,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PEBS": "1",
         "PublicDescription": "Counts return instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
@@ -111,7 +103,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts taken branch instructions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x20"
@@ -121,7 +112,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
         "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path.",
         "SampleAfterValue": "400009"
     },
@@ -130,7 +120,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_COST",
-        "PEBS": "1",
         "SampleAfterValue": "400009",
         "UMask": "0x44"
     },
@@ -139,7 +128,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
-        "PEBS": "1",
         "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x11"
@@ -149,7 +137,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_COST",
-        "PEBS": "1",
         "SampleAfterValue": "400009",
         "UMask": "0x51"
     },
@@ -158,7 +145,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken.",
         "SampleAfterValue": "400009",
         "UMask": "0x10"
@@ -168,7 +154,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN_COST",
-        "PEBS": "1",
         "SampleAfterValue": "400009",
         "UMask": "0x50"
     },
@@ -177,7 +162,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1"
@@ -187,7 +171,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN_COST",
-        "PEBS": "1",
         "SampleAfterValue": "400009",
         "UMask": "0x41"
     },
@@ -196,7 +179,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
-        "PEBS": "1",
         "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch.",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
@@ -206,7 +188,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
-        "PEBS": "1",
         "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect.",
         "SampleAfterValue": "400009",
         "UMask": "0x2"
@@ -216,7 +197,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL_COST",
-        "PEBS": "1",
         "SampleAfterValue": "400009",
         "UMask": "0x42"
     },
@@ -225,7 +205,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_COST",
-        "PEBS": "1",
         "SampleAfterValue": "100003",
         "UMask": "0xc0"
     },
@@ -234,7 +213,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken.",
         "SampleAfterValue": "400009",
         "UMask": "0x20"
@@ -244,7 +222,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN_COST",
-        "PEBS": "1",
         "SampleAfterValue": "400009",
         "UMask": "0x60"
     },
@@ -253,7 +230,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
-        "PEBS": "1",
         "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
@@ -263,7 +239,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET_COST",
-        "PEBS": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x48"
     },
@@ -511,7 +486,6 @@
         "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
@@ -521,7 +495,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003"
     },
@@ -530,7 +503,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -539,7 +511,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired NOP or ENDBR32/64 or PREF=
ETCHIT0/1 instructions",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -548,7 +519,6 @@
         "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.PREC_DIST",
-        "PEBS": "1",
         "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
@@ -558,7 +528,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PEBS": "1",
         "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
@@ -788,6 +757,15 @@
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa2",
+        "EventName": "RESOURCE_STALLS.SB",
+        "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Counts cycles where the pipeline is stalled d=
ue to serializing operations.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json=
 b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
index e0a45d4ea848..53055986534d 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
@@ -9,6 +9,16 @@
         "PublicDescription": "UNC_CHACMS_CLOCKTICKS",
         "Unit": "CHACMS"
     },
+    {
+        "BriefDescription": "Counts the number of cycles FAST trigger is r=
eceived from the global FAST distress wire.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHACMS_RING_SRC_THRTL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "CHACMS"
+    },
     {
         "BriefDescription": "Number of CHA clock cycles while the event is=
 enabled",
         "Counter": "0,1,2,3",
@@ -843,6 +853,16 @@
         "UMask": "0x8",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "Ingress (from CMS) Occupancy : IRQ : Counts n=
umber of entries in the specified Ingress queue in each cycle.",
+        "Counter": "0",
+        "EventCode": "0x11",
+        "EventName": "UNC_CHA_RxC_OCCUPANCY.IRQ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "All TOR Inserts",
         "Counter": "0,1,2,3",
@@ -1056,7 +1076,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Code read from local IA that miss the cache",
+        "BriefDescription": "Code read from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD",
@@ -1076,7 +1096,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data read from local IA that miss the cache",
+        "BriefDescription": "Data read from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD",
@@ -1096,7 +1116,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data read prefetch from local IA that miss th=
e cache",
+        "BriefDescription": "Data read prefetch from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_PREF",
@@ -1276,7 +1296,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that miss the cache",
+        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFRFO",
@@ -1405,7 +1425,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data read from local IA that miss the cache",
+        "BriefDescription": "Data read from local IA that miss the cache a=
nd targets local memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL",
@@ -1476,7 +1496,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data read prefetch from local IA that miss th=
e cache",
+        "BriefDescription": "Data read prefetch from local IA that miss th=
e cache and targets local memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL",
@@ -1518,7 +1538,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data read prefetch from local IA that miss th=
e cache",
+        "BriefDescription": "Data read prefetch from local IA that miss th=
e cache and targets remote memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE",
@@ -1549,7 +1569,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data read from local IA that miss the cache",
+        "BriefDescription": "Data read from local IA that miss the cache a=
nd targets remote memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE",
@@ -1741,7 +1761,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "BriefDescription": "Read for ownership from local IA that miss th=
e LLC targeting local memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_LOCAL",
@@ -1770,7 +1790,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the LLC targeting local memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_LOCAL",
@@ -1780,7 +1800,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the LLC targeting remote memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_REMOTE",
@@ -1790,7 +1810,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "BriefDescription": "Read for ownership from local IA that miss th=
e LLC targeting remote memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_REMOTE",
@@ -1882,7 +1902,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "BriefDescription": "Read for ownership from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO",
@@ -1892,7 +1912,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "BriefDescription": "Read for ownership prefetch from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO_PREF",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cxl.json b=
/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cxl.json
index 383a5ba5a697..43e094c233cc 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cxl.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cxl.json
@@ -13,7 +13,6 @@
         "Counter": "4,5,6,7",
         "EventCode": "0x41",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_INSERTS.MEM_DATA",
-        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x10",
         "Unit": "CXLCM"
@@ -23,7 +22,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLDP_TxC_AGF_INSERTS.M2S_DATA",
-        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x20",
         "Unit": "CXLDP"
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconne=
ct.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.=
json
index 856ee985ecd4..5c50275c79b0 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
@@ -808,6 +808,26 @@
         "PerPkg": "1",
         "Unit": "IRP"
     },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.FAST_REJ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.FAST_REQ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Misc Events - Set 1 : Lost Forward : Snoop pu=
lled away ownership before a write was committed",
         "Counter": "0,1,2,3",
@@ -818,6 +838,46 @@
         "UMask": "0x10",
         "Unit": "IRP"
     },
+    {
+        "BriefDescription": "Snoop Hit E/S responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_ES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x74",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Hit I responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x72",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Hit M responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_M",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop miss responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x71",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Inbound write (fast path) requests to coheren=
t memory, received by the IRP resulting in write ownership requests issued =
by IRP to the mesh.",
         "Counter": "0,1,2,3",
@@ -1550,6 +1610,33 @@
         "UMask": "0x4",
         "Unit": "UPI"
     },
+    {
+        "BriefDescription": "Cycles in L0p",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_POWER_CYCLES_LL_ENTER",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES_LL_ENTER",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_POWER_CYCLES_M3_EXIT",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES_M3_EXIT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
     {
         "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json b/=
tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
index cffb9d94b53d..886b99a971be 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
@@ -17,7 +17,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -29,7 +29,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -41,7 +41,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -53,7 +53,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -65,7 +65,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -77,7 +77,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -89,7 +89,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -101,7 +101,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -113,7 +113,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -125,7 +125,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff0ff",
+        "UMask": "0xff",
         "Unit": "IIO"
     },
     {
@@ -137,7 +137,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -149,7 +149,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -161,7 +161,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -173,7 +173,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -185,7 +185,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010010",
+        "UMask": "0x10",
         "Unit": "IIO"
     },
     {
@@ -197,7 +197,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020020",
+        "UMask": "0x20",
         "Unit": "IIO"
     },
     {
@@ -209,7 +209,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040040",
+        "UMask": "0x40",
         "Unit": "IIO"
     },
     {
@@ -221,7 +221,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080080",
+        "UMask": "0x80",
         "Unit": "IIO"
     },
     {
@@ -233,7 +233,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -245,7 +245,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -257,7 +257,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -269,7 +269,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -281,7 +281,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -293,7 +293,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -305,7 +305,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -317,7 +317,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -329,7 +329,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -341,7 +341,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -352,7 +352,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -363,7 +363,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -374,7 +374,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -385,7 +385,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -396,7 +396,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -407,7 +407,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -418,7 +418,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -429,7 +429,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -440,7 +440,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -451,7 +451,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -462,7 +462,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -473,7 +473,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -484,7 +484,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x02",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -495,7 +495,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x04",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -506,7 +506,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x08",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -517,7 +517,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x10",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -528,7 +528,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x20",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -539,7 +539,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x40",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -550,7 +550,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x80",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -561,7 +561,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -572,7 +572,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -583,7 +583,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x02",
-        "UMask": "0x7002001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -594,7 +594,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x04",
-        "UMask": "0x7004001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -605,7 +605,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x08",
-        "UMask": "0x7008001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -616,7 +616,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x10",
-        "UMask": "0x7010001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -627,7 +627,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x20",
-        "UMask": "0x7020001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -638,7 +638,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x40",
-        "UMask": "0x7040001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -649,7 +649,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x80",
-        "UMask": "0x7080001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -661,7 +661,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -673,7 +673,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -685,7 +685,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -697,7 +697,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -709,7 +709,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -721,7 +721,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -733,7 +733,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -745,7 +745,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -757,7 +757,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -769,7 +769,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -781,7 +781,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -793,7 +793,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -805,7 +805,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -817,7 +817,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -829,7 +829,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -841,7 +841,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -853,7 +853,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1129,7 +1129,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1141,7 +1141,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x700f020",
+        "UMask": "0x20",
         "Unit": "IIO"
     },
     {
@@ -1153,7 +1153,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x700f008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1165,7 +1165,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x700f002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1177,7 +1177,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x700f001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1189,7 +1189,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x700f004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1201,7 +1201,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x700f010",
+        "UMask": "0x10",
         "Unit": "IIO"
     },
     {
@@ -1213,7 +1213,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff080",
+        "UMask": "0x80",
         "Unit": "IIO"
     },
     {
@@ -1225,7 +1225,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff040",
+        "UMask": "0x40",
         "Unit": "IIO"
     },
     {
@@ -1237,7 +1237,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff020",
+        "UMask": "0x20",
         "Unit": "IIO"
     },
     {
@@ -1249,7 +1249,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1261,7 +1261,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1273,7 +1273,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1285,7 +1285,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff010",
+        "UMask": "0x10",
         "Unit": "IIO"
     },
     {
@@ -1297,7 +1297,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1318,7 +1318,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1329,7 +1329,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1340,7 +1340,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1351,7 +1351,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1362,7 +1362,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1373,7 +1373,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1384,7 +1384,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1395,7 +1395,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1406,7 +1406,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1417,7 +1417,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1428,7 +1428,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1439,7 +1439,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1450,7 +1450,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1461,7 +1461,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1472,7 +1472,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1483,7 +1483,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1494,7 +1494,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1505,7 +1505,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1516,7 +1516,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1527,7 +1527,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1538,7 +1538,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1549,7 +1549,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1560,7 +1560,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1571,7 +1571,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1582,7 +1582,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1593,7 +1593,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1604,7 +1604,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1615,7 +1615,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1626,7 +1626,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1637,7 +1637,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1648,7 +1648,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1659,7 +1659,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1670,7 +1670,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1681,7 +1681,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1692,7 +1692,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1703,7 +1703,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1715,7 +1715,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1727,7 +1727,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1739,7 +1739,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1751,7 +1751,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1763,7 +1763,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1775,7 +1775,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1787,7 +1787,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1799,7 +1799,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1811,7 +1811,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1823,7 +1823,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1835,7 +1835,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1847,7 +1847,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1859,7 +1859,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1871,7 +1871,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1883,7 +1883,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1895,7 +1895,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080002",
+        "UMask": "0x2",
         "Unit": "IIO"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.jso=
n b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
index 08e410b9b0a2..5f4783ff6ce5 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
@@ -169,7 +169,7 @@
         "Unit": "IMC"
     },
     {
-        "BriefDescription": "Number of DRAM DCLK clock cycles while the ev=
ent is enabled",
+        "BriefDescription": "Number of DRAM DCLK clock cycles while the ev=
ent is enabled.  DCLK is 1/4 of DRAM data rate.",
         "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_M_CLOCKTICKS",
@@ -188,6 +188,104 @@
         "PublicDescription": "DRAM Clockticks",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x8",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x10",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x20",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x40",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x80",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e and all pages are closed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_M_POWER_CHANNEL_PPD_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
         "Counter": "0,1,2,3",
@@ -358,6 +456,28 @@
         "PerPkg": "1",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "subevent0 - # of cycles all ranks were in SR =
subevent1 - # of times all ranks went into SR subevent2 -# of times  ps_sr_=
active asserted (SRE) subevent3 - # of times ps_sr_active deasserted (SRX) =
subevent4 - # of times PS-&>Refresh ps_sr_req asserted (SRE) subevent5 - # =
of times PS-&>Refresh ps_sr_req deasserted (SRX) subevent6 - # of cycles PS=
Ctrlr FSM was in FATAL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_M_SELF_REFRESH.ENTER_SUCCESS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_SELF_REFRESH.ENTER_SUCCESS",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles all ranks were in SR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_M_SELF_REFRESH.ENTER_SUCCESS_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "Write Pending Queue Allocations",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-power.json=
 b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-power.json
index 02e59f64a544..9ea852ef190e 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-power.json
@@ -7,5 +7,103 @@
         "PerPkg": "1",
         "PublicDescription": "PCU Clockticks:  The PCU runs off a fixed 1 =
GHz clock.  This event counts the number of pclk cycles measured while the =
counter was enabled.  The pclk, like the Memory Controller's dclk, counts a=
t a constant rate making it a good measure of actual wall time.",
         "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Thermal Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Thermal Strongest Upper Limit Cycles : Numbe=
r of cycles any frequency is reduced due to a thermal limit.  Count only if=
 throttling is occurring.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Power Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Power Strongest Upper Limit Cycles : Counts =
the number of cycles when power is the upper limit on frequency.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Cycles spent changing Frequency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x74",
+        "EventName": "UNC_P_FREQ_TRANS_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cycles spent changing Frequency : Counts the=
 number of cycles when the system is changing frequency.  This can not be f=
iltered by thread ID.  One can also use it with the occupancy counter that =
monitors number of threads in C0 to estimate the performance impact that fr=
equency transitions had on the system.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C2E",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2b",
+        "EventName": "UNC_P_PKG_RESIDENCY_C2E_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Package C State Residency - C2E : Counts the=
 number of cycles when the package was in C2E.  This event can be used in c=
onjunction with edge detect to count C2E entrances (or exits using invert).=
  Residency events do not include transition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2d",
+        "EventName": "UNC_P_PKG_RESIDENCY_C6_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Package C State Residency - C6 : Counts the =
number of cycles when the package was in C6.  This event can be used in con=
junction with edge detect to count C6 entrances (or exits using invert).  R=
esidency events do not include transition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cores in C0 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cores in C3 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C6",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cores in C6 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "External Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0a",
+        "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "External Prochot : Counts the number of cycl=
es that we are in external PROCHOT mode.  This mode is triggered when a sen=
sor off the die determines that something off-die (like DRAM) is too hot an=
d must throttle to avoid damaging the chip.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Internal Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x09",
+        "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Internal Prochot : Counts the number of cycl=
es that we are in Internal PROCHOT mode.  This mode is triggered when a sen=
sor on the die determines that we are too hot and must throttle to avoid da=
maging the chip.",
+        "Unit": "PCU"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 2cd9296f0f12..213f49e585bc 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-CF,v1.11,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.05,grandridge,core
-GenuineIntel-6-A[DE],v1.02,graniterapids,core
+GenuineIntel-6-A[DE],v1.06,graniterapids,core
 GenuineIntel-6-(3C|45|46),v35,haswell,core
 GenuineIntel-6-3F,v28,haswellx,core
 GenuineIntel-6-7[DE],v1.22,icelake,core
--=20
2.48.1.502.g6dc24dfdaf-goog

