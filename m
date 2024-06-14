Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0618755C
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Jun 2024 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406278; cv=none; b=gceYwH2khY90k6F+PpiBox1mjWtT+bAo7IWnx0NsoVXZetz0mqRPJyhEU3C9hbMnYJsNAr16rFcMz+QiDfzQ+BIA4RFtgcJD1pKyym7oBTq2VyAjqDELlbLV/nEd82/CTAii+yhi8d8aoiqr+F6l1dEmSIhUVCYYGxWSuf78jVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406278; c=relaxed/simple;
	bh=QbxBzQMsMth7FdzZMDN/g8STKGS46zltsGgchzPvBhs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Mxmzmf/DdnUSwCGq7qvee71bluio6vnw01xhLcxIes+NqAZVJJ6C62ocpT9GKBzfK56D+RGg/d1aE6r48/ntH6QE3PTLeKFmZYIbMgqq2qAUnYeLTE+J8GH2GxLJ9ADz+VnEBrYCecznNGqlu9upvDkksKfqaV1qDqQhvIpYV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QppaPzgZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QppaPzgZ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-632e098ab42so14712417b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jun 2024 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718406245; x=1719011045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiRLbTd+mDgXe4odVHMMZqZhPcoMwYLDRhWl4eDZ70E=;
        b=QppaPzgZdZNiXLp8Nvp5FJn0pxHZNsU+m/48r02+WruJplcrv5MSdIVZGH/Piblg4Q
         qjYvwtAjK3Hbn7JRirQwbFyXRf8Ga6OtambGJS+e6pk49hjEQOpzevfejsiCUt+bv+61
         vx61ZGYs6U0UHDphsqWdgCllVoVqBx+XKhrzw1Ysdfky46ywVW3hui8CINkwcUUSzQIG
         uTujXm0w5UvYx3ZTN+bDt2ncDeOLtyO7WyqlkWHA68MuhxizK8uaqG3Y4u2CeXL91NKR
         haabRC3gJY4QWii+mazYvjsimcCaBSdLT8ewDAw0bCpanZPfu2lX1yi+fa0j3EMNNdKA
         5QQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718406245; x=1719011045;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YiRLbTd+mDgXe4odVHMMZqZhPcoMwYLDRhWl4eDZ70E=;
        b=NOy6ePzm9GGQS+rzzoWLDYf0kDfap4zQRFZpDdvR/8QWLmJKG2QXE9onFev3RfIIJW
         ox7U+GSirbzTkIr8rX+/DHLjKwjq4fDYTD1to5bBeg8AYr8uRcanIyvctB58g/qrpviW
         LGr3O4ZLCODcBpjolhxDAmHOHwWFsfNo8coVfvkkMSrU28dE7KoSRwDBlZ/M21BiOWw4
         OwZqpCyGA7O2t0Map07F+FbIf1ZNl4Lx11KH3UkNS7D+UECtzEceyHw+WBimF505IYGB
         WS6Uzj9W0rvBvCPDnWKsKhUG4lEYoSqAVJP5KYTZnnpvrek8VaHqFQ8nXUwaQQ3DXRrj
         QDlw==
X-Forwarded-Encrypted: i=1; AJvYcCXD/ntRxSqV9h/MrKSaQdXmNnHp2AXewaWVqHctbqZagEDiPvz1t3UwsPDLtxCQxo+0/9mkuIkSfiq8HHw/PrneHHUP2jRi6bum8BT4rYclLQ==
X-Gm-Message-State: AOJu0YzlatNF45WifYmf2O8FH8gFzCK3RYNEyCD0IQJ7kiSEA8HOYqzr
	+sxANGxmC75FSpTkjB0RUQDETt0rCJNuQUEw1D/0W07kKsV7/sjSZgcBG0iSVBOvhSTrqJb4oGU
	RJ2PhTg==
X-Google-Smtp-Source: AGHT+IHI7316RQBtshIHU9VvJdxNGbS3DaqveosSVTQanv4RxsM6sCiqd67MVXhhe5sfIcjYrJ/gfYMJV7wq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:714a:5e65:12a1:603])
 (user=irogers job=sendgmr) by 2002:a05:690c:700e:b0:627:a962:4252 with SMTP
 id 00721157ae682-63224613c12mr8824227b3.7.1718406244781; Fri, 14 Jun 2024
 16:04:04 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:01:38 -0700
In-Reply-To: <20240614230146.3783221-1-irogers@google.com>
Message-Id: <20240614230146.3783221-31-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240614230146.3783221-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v1 30/37] perf vendor events: Add silvermont counter information
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
 .../pmu-events/arch/x86/silvermont/cache.json | 77 +++++++++++++++++++
 .../arch/x86/silvermont/counter.json          |  7 ++
 .../arch/x86/silvermont/floating-point.json   |  1 +
 .../arch/x86/silvermont/frontend.json         |  8 ++
 .../arch/x86/silvermont/memory.json           |  1 +
 .../pmu-events/arch/x86/silvermont/other.json |  2 +
 .../arch/x86/silvermont/pipeline.json         | 34 ++++++++
 .../arch/x86/silvermont/virtual-memory.json   |  7 ++
 8 files changed, 137 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/silvermont/counter.json

diff --git a/tools/perf/pmu-events/arch/x86/silvermont/cache.json b/tools/p=
erf/pmu-events/arch/x86/silvermont/cache.json
index 818e0664a3a6..5e5e2170fd8f 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/cache.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of request that were not ac=
cepted into the L2Q because the L2Q is FULL.",
+        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ALL",
         "PublicDescription": "Counts the number of (demand and L1 prefetch=
ers) core requests rejected by the L2Q due to a full or nearly full w condi=
tion which likely indicates back pressure from L2Q.  It also counts request=
s that would have gone directly to the XQ, but are rejected due to a full o=
r nearly full condition, indicating back pressure from the IDI link.  The L=
2Q may also reject transactions  from a core to insure fairness between cor=
es, or to delay a core?s dirty eviction when the address conflicts incoming=
 external snoops.  (Note that L2 prefetcher requests that are dropped are n=
ot counted by this event.)",
@@ -8,6 +9,7 @@
     },
     {
         "BriefDescription": "Cycles code-fetch stalled due to an outstandi=
ng ICache miss.",
+        "Counter": "0,1",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ICACHE_FILL_PENDING_CYCLES",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ICache miss. That is, the decoder queue is able to accept byt=
es, but the fetch unit is unable to provide bytes due to an ICache miss.  N=
ote: this event is not the same as the total number of cycles spent retriev=
ing instruction cache lines from the memory hierarchy.\r\nCounts cycles tha=
t fetch is stalled due to any reason. That is, the decoder queue is able to=
 accept bytes, but the fetch unit is unable to provide bytes.  This will in=
clude cycles due to an ITLB miss, ICache miss and other events.",
@@ -16,6 +18,7 @@
     },
     {
         "BriefDescription": "Counts the number of request from the L2 that=
 were not accepted into the XQ",
+        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_XQ.ALL",
         "PublicDescription": "This event counts the number of demand and p=
refetch transactions that the L2 XQ rejects due to a full or near full cond=
ition which likely indicates back pressure from the IDI link. The XQ may re=
ject transactions from the L2Q (non-cacheable requests), BBS (L2 misses) an=
d WOB (L2 write-back victims).",
@@ -23,6 +26,7 @@
     },
     {
         "BriefDescription": "L2 cache request misses",
+        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PublicDescription": "This event counts the total number of L2 cac=
he references and the number of L2 cache misses respectively.",
@@ -31,6 +35,7 @@
     },
     {
         "BriefDescription": "L2 cache requests from this core",
+        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "This event counts requests originating from =
the core that references a cache line in the L2 cache.",
@@ -39,6 +44,7 @@
     },
     {
         "BriefDescription": "All Loads",
+        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PublicDescription": "This event counts the number of load ops ret=
ired.",
@@ -47,6 +53,7 @@
     },
     {
         "BriefDescription": "All Stores",
+        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PublicDescription": "This event counts the number of store ops re=
tired.",
@@ -55,6 +62,7 @@
     },
     {
         "BriefDescription": "Cross core or cross module hitm",
+        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.HITM",
         "PEBS": "1",
@@ -64,6 +72,7 @@
     },
     {
         "BriefDescription": "Loads missed L1",
+        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L1_MISS_LOADS",
         "PublicDescription": "This event counts the number of load ops ret=
ired that miss in L1 Data cache. Note that prefetch misses will not be coun=
ted.",
@@ -72,6 +81,7 @@
     },
     {
         "BriefDescription": "Loads hit L2",
+        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L2_HIT_LOADS",
         "PEBS": "1",
@@ -81,6 +91,7 @@
     },
     {
         "BriefDescription": "Loads missed L2",
+        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L2_MISS_LOADS",
         "PEBS": "1",
@@ -90,6 +101,7 @@
     },
     {
         "BriefDescription": "Loads missed UTLB",
+        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.UTLB_MISS",
         "PublicDescription": "This event counts the number of load ops ret=
ired that had UTLB miss.",
@@ -98,6 +110,7 @@
     },
     {
         "BriefDescription": "Offcore response can be programmed only with =
a specific pair of event select and counter MSR, and with specific event co=
des and predefine mask bit value in a dedicated MSR to specify attributes o=
f the offcore transaction",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -106,6 +119,7 @@
     },
     {
         "BriefDescription": "Counts any code reads (demand & prefetch) tha=
t have any response type.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -115,6 +129,7 @@
     },
     {
         "BriefDescription": "Counts any code reads (demand & prefetch) tha=
t miss L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -124,6 +139,7 @@
     },
     {
         "BriefDescription": "Counts any code reads (demand & prefetch) tha=
t hit in the other module where modified copies were found in other core's =
L1 cache.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -133,6 +149,7 @@
     },
     {
         "BriefDescription": "Counts any code reads (demand & prefetch) tha=
t miss L2 and the snoops to sibling cores hit in either E/S state and the l=
ine is not forwarded.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_MISS.HIT_OTHER_CORE_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -142,6 +159,7 @@
     },
     {
         "BriefDescription": "Counts any code reads (demand & prefetch) tha=
t miss L2 with a snoop miss response.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -151,6 +169,7 @@
     },
     {
         "BriefDescription": "Counts any data read (demand & prefetch) that=
 have any response type.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -160,6 +179,7 @@
     },
     {
         "BriefDescription": "Counts any data read (demand & prefetch) that=
 miss L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -169,6 +189,7 @@
     },
     {
         "BriefDescription": "Counts any data read (demand & prefetch) that=
 hit in the other module where modified copies were found in other core's L=
1 cache.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -178,6 +199,7 @@
     },
     {
         "BriefDescription": "Counts any data read (demand & prefetch) that=
 miss L2 and the snoops to sibling cores hit in either E/S state and the li=
ne is not forwarded.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.HIT_OTHER_CORE_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -187,6 +209,7 @@
     },
     {
         "BriefDescription": "Counts any data read (demand & prefetch) that=
 miss L2 with a snoop miss response.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -196,6 +219,7 @@
     },
     {
         "BriefDescription": "Counts any request that have any response typ=
e.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -205,6 +229,7 @@
     },
     {
         "BriefDescription": "Counts any request that hit in the other modu=
le where modified copies were found in other core's L1 cache.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -214,6 +239,7 @@
     },
     {
         "BriefDescription": "Counts any request that miss L2 and the snoop=
s to sibling cores hit in either E/S state and the line is not forwarded.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS.HIT_OTHER_CORE_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -223,6 +249,7 @@
     },
     {
         "BriefDescription": "Counts any request that miss L2 with a snoop =
miss response.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -232,6 +259,7 @@
     },
     {
         "BriefDescription": "Counts any rfo reads (demand & prefetch) that=
 have any response type.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -241,6 +269,7 @@
     },
     {
         "BriefDescription": "Counts any rfo reads (demand & prefetch) that=
 miss L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -250,6 +279,7 @@
     },
     {
         "BriefDescription": "Counts any rfo reads (demand & prefetch) that=
 hit in the other module where modified copies were found in other core's L=
1 cache.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -259,6 +289,7 @@
     },
     {
         "BriefDescription": "Counts any rfo reads (demand & prefetch) that=
 miss L2 and the snoops to sibling cores hit in either E/S state and the li=
ne is not forwarded.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.HIT_OTHER_CORE_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -268,6 +299,7 @@
     },
     {
         "BriefDescription": "Counts any rfo reads (demand & prefetch) that=
 miss L2 with a snoop miss response.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -277,6 +309,7 @@
     },
     {
         "BriefDescription": "Counts writeback (modified to exclusive) that=
 miss L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -286,6 +319,7 @@
     },
     {
         "BriefDescription": "Counts writeback (modified to exclusive) that=
 miss L2 with no details on snoop-related information.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_MISS.NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
@@ -295,6 +329,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch instruction ca=
cheline that have any response type.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -304,6 +339,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch instruction ca=
cheline that miss L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -313,6 +349,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch instruction ca=
cheline that miss L2 and the snoops to sibling cores hit in either E/S stat=
e and the line is not forwarded.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_MISS.HIT_OTHER_CO=
RE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -322,6 +359,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch instruction ca=
cheline that miss L2 with a snoop miss response.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -331,6 +369,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch instruction ca=
cheline that are are outstanding, per cycle, from the time of the L2 miss t=
o when any response is received.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -340,6 +379,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch data read that=
 have any response type.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -349,6 +389,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch data read that=
 miss L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -358,6 +399,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch data read that=
 hit in the other module where modified copies were found in other core's L=
1 cache.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.HITM_OTHER_C=
ORE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -367,6 +409,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch data read that=
 miss L2 and the snoops to sibling cores hit in either E/S state and the li=
ne is not forwarded.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.HIT_OTHER_CO=
RE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -376,6 +419,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch data read that=
 miss L2 with a snoop miss response.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -385,6 +429,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch data read that=
 are are outstanding, per cycle, from the time of the L2 miss to when any r=
esponse is received.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -394,6 +439,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch RFOs that miss=
 L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -403,6 +449,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch RFOs that hit =
in the other module where modified copies were found in other core's L1 cac=
he.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.HITM_OTHER_CORE"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -412,6 +459,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch RFOs that miss=
 L2 and the snoops to sibling cores hit in either E/S state and the line is=
 not forwarded.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.HIT_OTHER_CORE_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -421,6 +469,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch RFOs that miss=
 L2 with a snoop miss response.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -430,6 +479,7 @@
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch RFOs that are =
are outstanding, per cycle, from the time of the L2 miss to when any respon=
se is received.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -439,6 +489,7 @@
     },
     {
         "BriefDescription": "Counts demand reads of partial cache lines (i=
ncluding UC and WC) that miss L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -448,6 +499,7 @@
     },
     {
         "BriefDescription": "Countsof demand RFO requests to write to part=
ial cache lines that miss L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -457,6 +509,7 @@
     },
     {
         "BriefDescription": "Counts DCU hardware prefetcher data read that=
 have any response type.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -466,6 +519,7 @@
     },
     {
         "BriefDescription": "Counts DCU hardware prefetcher data read that=
 miss L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -475,6 +529,7 @@
     },
     {
         "BriefDescription": "Counts DCU hardware prefetcher data read that=
 hit in the other module where modified copies were found in other core's L=
1 cache.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -484,6 +539,7 @@
     },
     {
         "BriefDescription": "Counts DCU hardware prefetcher data read that=
 miss L2 and the snoops to sibling cores hit in either E/S state and the li=
ne is not forwarded.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -493,6 +549,7 @@
     },
     {
         "BriefDescription": "Counts DCU hardware prefetcher data read that=
 miss L2 with a snoop miss response.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -502,6 +559,7 @@
     },
     {
         "BriefDescription": "Counts code reads generated by L2 prefetchers=
 that miss L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -511,6 +569,7 @@
     },
     {
         "BriefDescription": "Counts code reads generated by L2 prefetchers=
 that miss L2 and the snoops to sibling cores hit in either E/S state and t=
he line is not forwarded.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_MISS.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -520,6 +579,7 @@
     },
     {
         "BriefDescription": "Counts code reads generated by L2 prefetchers=
 that miss L2 with a snoop miss response.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -529,6 +589,7 @@
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by L2 p=
refetchers that miss L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -538,6 +599,7 @@
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by L2 p=
refetchers that hit in the other module where modified copies were found in=
 other core's L1 cache.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -547,6 +609,7 @@
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by L2 p=
refetchers that miss L2 and the snoops to sibling cores hit in either E/S s=
tate and the line is not forwarded.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -556,6 +619,7 @@
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by L2 p=
refetchers that miss L2 with a snoop miss response.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -565,6 +629,7 @@
     },
     {
         "BriefDescription": "Counts RFO requests generated by L2 prefetche=
rs that miss L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -574,6 +639,7 @@
     },
     {
         "BriefDescription": "Counts RFO requests generated by L2 prefetche=
rs that hit in the other module where modified copies were found in other c=
ore's L1 cache.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -583,6 +649,7 @@
     },
     {
         "BriefDescription": "Counts RFO requests generated by L2 prefetche=
rs that miss L2 and the snoops to sibling cores hit in either E/S state and=
 the line is not forwarded.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.HIT_OTHER_CORE_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -592,6 +659,7 @@
     },
     {
         "BriefDescription": "Counts RFO requests generated by L2 prefetche=
rs that miss L2 with a snoop miss response.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -601,6 +669,7 @@
     },
     {
         "BriefDescription": "Counts streaming store that miss L2.",
+        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -610,6 +679,7 @@
     },
     {
         "BriefDescription": "Any reissued load uops",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.ANY_LD",
         "PublicDescription": "This event counts the number of load uops re=
issued from Rehabq.",
@@ -618,6 +688,7 @@
     },
     {
         "BriefDescription": "Any reissued store uops",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.ANY_ST",
         "PublicDescription": "This event counts the number of store uops r=
eissued from Rehabq.",
@@ -626,6 +697,7 @@
     },
     {
         "BriefDescription": "Loads blocked due to store data not ready",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.LD_BLOCK_STD_NOTREADY",
         "PublicDescription": "This event counts the cases where a forward =
was technically possible, but did not occur because the store data was not =
available at the right time.",
@@ -634,6 +706,7 @@
     },
     {
         "BriefDescription": "Loads blocked due to store forward restrictio=
n",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.LD_BLOCK_ST_FORWARD",
         "PEBS": "1",
@@ -643,6 +716,7 @@
     },
     {
         "BriefDescription": "Load uops that split cache line boundary",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.LD_SPLITS",
         "PEBS": "1",
@@ -652,6 +726,7 @@
     },
     {
         "BriefDescription": "Uops with lock semantics",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.LOCK",
         "PublicDescription": "This event counts the number of retired memo=
ry operations with lock semantics. These are either implicit locked instruc=
tions such as the XCHG instruction or instructions with an explicit LOCK pr=
efix (0xF0).",
@@ -660,6 +735,7 @@
     },
     {
         "BriefDescription": "Store address buffer full",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.STA_FULL",
         "PublicDescription": "This event counts the number of retired stor=
es that are delayed because there is not a store address buffer available."=
,
@@ -668,6 +744,7 @@
     },
     {
         "BriefDescription": "Store uops that split cache line boundary",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.ST_SPLITS",
         "PublicDescription": "This event counts the number of retire store=
s that experienced cache line boundary splits.",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/counter.json b/tools=
/perf/pmu-events/arch/x86/silvermont/counter.json
new file mode 100644
index 000000000000..eb89b55f31bd
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/silvermont/counter.json
@@ -0,0 +1,7 @@
+[
+    {
+        "Unit": "core",
+        "CountersNumFixed": "4",
+        "CountersNumGeneric": "2"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json =
b/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
index f2b1e8f08d68..aa4faf110512 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Stalls due to FP assists",
+        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.FP_ASSIST",
         "PublicDescription": "This event counts the number of times that p=
ipeline stalled due to FP operations needing assists.",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json b/tool=
s/perf/pmu-events/arch/x86/silvermont/frontend.json
index cd6ed3f59e26..fc6cfb291249 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of baclears",
+        "Counter": "0,1",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.ALL",
         "PublicDescription": "The BACLEARS event counts the number of time=
s the front end is resteered, mainly when the Branch Prediction Unit cannot=
 provide a correct prediction and this is corrected by the Branch Address C=
alculator at the front end.  The BACLEARS.ANY event counts the number of ba=
clears for any type of branch.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Counts the number of JCC baclears",
+        "Counter": "0,1",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.COND",
         "PublicDescription": "The BACLEARS event counts the number of time=
s the front end is resteered, mainly when the Branch Prediction Unit cannot=
 provide a correct prediction and this is corrected by the Branch Address C=
alculator at the front end.  The BACLEARS.COND event counts the number of J=
CC (Jump on Conditional Code) baclears.",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Counts the number of RETURN baclears",
+        "Counter": "0,1",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.RETURN",
         "PublicDescription": "The BACLEARS event counts the number of time=
s the front end is resteered, mainly when the Branch Prediction Unit cannot=
 provide a correct prediction and this is corrected by the Branch Address C=
alculator at the front end.  The BACLEARS.RETURN event counts the number of=
 RETURN baclears.",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Counts the number of times a decode restricti=
on reduced the decode throughput due to wrong instruction length prediction=
",
+        "Counter": "0,1",
         "EventCode": "0xE9",
         "EventName": "DECODE_RESTRICTION.PREDECODE_WRONG",
         "PublicDescription": "Counts the number of times a decode restrict=
ion reduced the decode throughput due to wrong instruction length predictio=
n.",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Instruction fetches",
+        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
         "PublicDescription": "This event counts all instruction fetches, n=
ot including most uncacheable\r\nfetches.",
@@ -41,6 +46,7 @@
     },
     {
         "BriefDescription": "Instruction fetches from Icache",
+        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.HIT",
         "PublicDescription": "This event counts all instruction fetches fr=
om the instruction cache.",
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "Icache miss",
+        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "PublicDescription": "This event counts all instruction fetches th=
at miss the Instruction cache or produce memory requests. This includes unc=
acheable fetches. An instruction fetch miss is counted only once and not on=
ce for every cycle it is outstanding.",
@@ -57,6 +64,7 @@
     },
     {
         "BriefDescription": "Counts the number of times entered into a uco=
de flow in the FEC.  Includes inserted flows due to front-end detected faul=
ts or assists.  Speculative count.",
+        "Counter": "0,1",
         "EventCode": "0xE7",
         "EventName": "MS_DECODED.MS_ENTRY",
         "PublicDescription": "Counts the number of times the MSROM starts =
a flow of UOPS. It does not count every time a UOP is read from the microco=
de ROM.  The most common case that this counts is when a micro-coded instru=
ction is encountered by the front end of the machine.  Other cases include =
when an instruction encounters a fault, trap, or microcode assist of any so=
rt.  The event will count MSROM startups for UOPS that are speculative, and=
 subsequently cleared by branch mispredict or machine clear.  Background: U=
OPS are produced by two mechanisms.  Either they are generated by hardware =
that decodes instructions into UOPS, or they are delivered by a ROM (called=
 the MSROM) that holds UOPS associated with a specific instruction.  MSROM =
UOPS might also be delivered in response to some condition such as a fault =
or other exceptional condition.  This event is an excellent mechanism for d=
etecting instructions that require the use of MSROM instructions.",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/memory.json b/tools/=
perf/pmu-events/arch/x86/silvermont/memory.json
index 15ea45187210..0f5fba43da4c 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/memory.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Stalls due to Memory ordering",
+        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "PublicDescription": "This event counts the number of times that p=
ipeline was cleared due to memory ordering issues.",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/other.json b/tools/p=
erf/pmu-events/arch/x86/silvermont/other.json
index cff113adb823..4db59d84c144 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/other.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/other.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Cycles code-fetch stalled due to any reason."=
,
+        "Counter": "0,1",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ALL",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
ny reason. That is, the decoder queue is able to accept bytes, but the fetc=
h unit is unable to provide bytes.  This will include cycles due to an ITLB=
 miss, ICache miss and other events.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Cycles code-fetch stalled due to an outstandi=
ng ITLB miss.",
+        "Counter": "0,1",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ITLB_FILL_PENDING_CYCLES",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ITLB miss. That is, the decoder queue is able to accept bytes=
, but the fetch unit is unable to provide bytes due to an ITLB miss.  Note:=
 this event is not the same as page walk cycles to retrieve an instruction =
translation.",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/silvermont/pipeline.json
index 2d4214bf9e39..48ca8bb2656b 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of branch instructions reti=
red...",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Counts the number of taken branch instruction=
s retired",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_TAKEN_BRANCHES",
         "PEBS": "2",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CALL",
         "PEBS": "1",
@@ -27,6 +30,7 @@
     },
     {
         "BriefDescription": "Counts the number of far branch instructions =
retired",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
@@ -36,6 +40,7 @@
     },
     {
         "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
         "PEBS": "1",
@@ -45,6 +50,7 @@
     },
     {
         "BriefDescription": "Counts the number of JCC branch instructions =
retired",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.JCC",
         "PEBS": "1",
@@ -54,6 +60,7 @@
     },
     {
         "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
@@ -63,6 +70,7 @@
     },
     {
         "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
         "PEBS": "1",
@@ -72,6 +80,7 @@
     },
     {
         "BriefDescription": "Counts the number of near RET branch instruct=
ions retired",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.RETURN",
         "PEBS": "1",
@@ -81,6 +90,7 @@
     },
     {
         "BriefDescription": "Counts the number of taken JCC branch instruc=
tions retired",
+        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
         "PEBS": "1",
@@ -90,6 +100,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -98,6 +109,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
         "PEBS": "1",
@@ -107,6 +119,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted JCC branch =
instructions retired",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.JCC",
         "PEBS": "1",
@@ -116,6 +129,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
@@ -125,6 +139,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.RETURN",
         "PEBS": "1",
@@ -134,6 +149,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted taken JCC b=
ranch instructions retired",
+        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
         "PEBS": "1",
@@ -143,6 +159,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. This event is a component in many key event ratios.=
  The core frequency may change from time to time. For this reason this eve=
nt may have a changing ratio with regards to time. In systems with a consta=
nt core frequency, this event can give you a measurement of the elapsed tim=
e while the core was not in halt state by dividing the event count by the c=
ore frequency. This event is architecturally defined and is a designated fi=
xed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P use the cor=
e frequency which may change from time to time.  CPU_CLK_UNHALTE.REF_TSC an=
d CPU_CLK_UNHALTED.REF are not affected by core frequency changes but count=
s as if the core is running at the maximum frequency all the time.  The fix=
ed events are CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TSC and the pr=
ogrammable events are CPU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHALTED.REF.",
         "SampleAfterValue": "2000003",
@@ -150,6 +167,7 @@
     },
     {
         "BriefDescription": "Core cycles when core is not halted",
+        "Counter": "0,1",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
         "PublicDescription": "This event counts the number of core cycles =
while the core is not in a halt state. The core enters the halt state when =
it is running the HLT instruction. In mobile systems the core frequency may=
 change from time to time. For this reason this event may have a changing r=
atio with regards to time.",
@@ -157,6 +175,7 @@
     },
     {
         "BriefDescription": "Reference cycles when core is not halted",
+        "Counter": "0,1",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF",
         "PublicDescription": "This event counts the number of reference cy=
cles that the core is not in a halt state. The core enters the halt state w=
hen it is running the HLT instruction. In mobile systems the core frequency=
 may change from time. This event is not affected by core frequency changes=
 but counts as if the core is running at the maximum frequency all the time=
.",
@@ -165,6 +184,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles",
+        "Counter": "Fixed counter 3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles while =
the core is not in a halt state. The core enters the halt state when it is =
running the HLT instruction. This event is a component in many key event ra=
tios.  The core frequency may change from time. This event is not affected =
by core frequency changes but counts as if the core is running at the maxim=
um frequency all the time.  Divide this event count by core frequency to de=
termine the elapsed time while the core was not in halt state.  Divide this=
 event count by core frequency to determine the elapsed time while the core=
 was not in halt state.  This event is architecturally defined and is a des=
ignated fixed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P u=
se the core frequency which may change from time to time.  CPU_CLK_UNHALTE.=
REF_TSC and CPU_CLK_UNHALTED.REF are not affected by core frequency changes=
 but counts as if the core is running at the maximum frequency all the time=
.  The fixed events are CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TSC =
and the programmable events are CPU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHALTE=
D.REF.",
         "SampleAfterValue": "2000003",
@@ -172,6 +192,7 @@
     },
     {
         "BriefDescription": "Cycles the divider is busy.  Does not imply a=
 stall waiting for the divider.",
+        "Counter": "0,1",
         "EventCode": "0xCD",
         "EventName": "CYCLES_DIV_BUSY.ALL",
         "PublicDescription": "Cycles the divider is busy.This event counts=
 the cycles when the divide unit is unable to accept a new divide UOP becau=
se it is busy processing a previously dispatched UOP. The cycles will be co=
unted irrespective of whether or not another divide UOP is waiting to enter=
 the divide unit (from the RS). This event might count cycles while a divid=
e is in progress even if the RS is empty.  The divide instruction is one of=
 the longest latency instructions in the machine.  Hence, it has a special =
event associated with it to help determine if divides are delaying the reti=
rement of instructions.",
@@ -180,6 +201,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired",
+        "Counter": "Fixed counter 1",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions=
 that retire.  For instructions that consist of multiple micro-ops, this ev=
ent counts exactly once, as the last micro-op of the instruction retires.  =
The event continues counting while instructions retire, including during in=
terrupt service routines caused by hardware interrupts, faults or traps.  B=
ackground: Modern microprocessors employ extensive pipelining and speculati=
ve techniques.  Since sometimes an instruction is started but never complet=
ed, the notion of \"retirement\" is introduced.  A retired instruction is o=
ne that commits its states. Or stated differently, an instruction might be =
abandoned at some point. No instruction is truly finished until it retires.=
  This counter measures the number of completed instructions.  The fixed ev=
ent is INST_RETIRED.ANY and the programmable event is INST_RETIRED.ANY_P.",
         "SampleAfterValue": "2000003",
@@ -187,6 +209,7 @@
     },
     {
         "BriefDescription": "Instructions retired",
+        "Counter": "0,1",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
         "PublicDescription": "This event counts the number of instructions=
 that retire execution. For instructions that consist of multiple micro-ops=
, this event counts the retirement of the last micro-op of the instruction.=
 The counter continues counting during hardware interrupts, traps, and insi=
de interrupt handlers.",
@@ -194,6 +217,7 @@
     },
     {
         "BriefDescription": "Counts all machine clears",
+        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.ALL",
         "PublicDescription": "Machine clears happen when something happens=
 in the machine that causes the hardware to need to take special care to ge=
t the right answer. When such a condition is signaled on an instruction, th=
e front end of the machine is notified that it must restart, so no more ins=
tructions will be decoded from the current path.  All instructions \"older\=
" than this one will be allowed to finish.  This instruction and all \"youn=
ger\" instructions must be cleared, since they must not be allowed to compl=
ete.  Essentially, the hardware waits until the problematic instruction is =
the oldest instruction in the machine.  This means all older instructions a=
re retired, and all pending stores (from older instructions) are completed.=
  Then the new path of instructions from the front end are allowed to start=
 into the machine.  There are many conditions that might cause a machine cl=
ear (including the receipt of an interrupt, or a trap or a fault).  All tho=
se conditions (including but not limited to MACHINE_CLEARS.MEMORY_ORDERING,=
 MACHINE_CLEARS.SMC, and MACHINE_CLEARS.FP_ASSIST) are captured in the ANY =
event. In addition, some conditions can be specifically counted (i.e. SMC, =
MEMORY_ORDERING, FP_ASSIST).  However, the sum of SMC, MEMORY_ORDERING, and=
 FP_ASSIST machine clears will not necessarily equal the number of ANY.",
@@ -202,6 +226,7 @@
     },
     {
         "BriefDescription": "Self-Modifying Code detected",
+        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "PublicDescription": "This event counts the number of times that a=
 program writes to a code section. Self-modifying code causes a severe pena=
lty in all Intel? architecture processors.",
@@ -210,6 +235,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles when no uops are =
allocated for any reason.",
+        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.ALL",
         "PublicDescription": "The NO_ALLOC_CYCLES.ALL event counts the num=
ber of cycles when the front-end does not provide any instructions to be al=
located for any reason. This event indicates the cycles where an allocation=
 stalls occurs, and no UOPS are allocated in that cycle.",
@@ -218,6 +244,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles when no uops are =
allocated and the alloc pipe is stalled waiting for a mispredicted jump to =
retire.  After the misprediction is detected, the front end will start imme=
diately but the allocate pipe stalls until the mispredicted",
+        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.MISPREDICTS",
         "PublicDescription": "Counts the number of cycles when no uops are=
 allocated and the alloc pipe is stalled waiting for a mispredicted jump to=
 retire.  After the misprediction is detected, the front end will start imm=
ediately but the allocate pipe stalls until the mispredicted.",
@@ -226,6 +253,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles when no uops are =
allocated, the IQ is empty, and no other condition is blocking allocation."=
,
+        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.NOT_DELIVERED",
         "PublicDescription": "The NO_ALLOC_CYCLES.NOT_DELIVERED event is u=
sed to measure front-end inefficiencies, i.e. when front-end of the machine=
 is not delivering micro-ops to the back-end and the back-end is not stalle=
d. This event can be used to identify if the machine is truly front-end bou=
nd.  When this event occurs, it is an indication that the front-end of the =
machine is operating at less than its theoretical peak performance.  Backgr=
ound: We can think of the processor pipeline as being divided into 2 broade=
r parts: Front-end and Back-end. Front-end is responsible for fetching the =
instruction, decoding into micro-ops (uops) in machine understandable forma=
t and putting them into a micro-op queue to be consumed by back end. The ba=
ck-end then takes these micro-ops, allocates the required resources.  When =
all resources are ready, micro-ops are executed. If the back-end is not rea=
dy to accept micro-ops from the front-end, then we do not want to count the=
se as front-end bottlenecks.  However, whenever we have bottlenecks in the =
back-end, we will have allocation unit stalls and eventually forcing the fr=
ont-end to wait until the back-end is ready to receive more UOPS. This even=
t counts the cycles only when back-end is requesting more uops and front-en=
d is not able to provide them. Some examples of conditions that cause front=
-end efficiencies are: Icache misses, ITLB misses, and decoder restrictions=
 that limit the front-end bandwidth.",
@@ -234,6 +262,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles when no uops are =
allocated and a RATstall is asserted.",
+        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.RAT_STALL",
         "SampleAfterValue": "200003",
@@ -241,6 +270,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles when no uops are =
allocated and the ROB is full (less than 2 entries available)",
+        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.ROB_FULL",
         "PublicDescription": "Counts the number of cycles when no uops are=
 allocated and the ROB is full (less than 2 entries available).",
@@ -249,6 +279,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the Alloc pipelin=
e is stalled when any one of the RSs (IEC, FPC and MEC) is full. This event=
 is a superset of all the individual RS stall event counts.",
+        "Counter": "0,1",
         "EventCode": "0xCB",
         "EventName": "RS_FULL_STALL.ALL",
         "SampleAfterValue": "200003",
@@ -256,6 +287,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles and allocation pi=
peline is stalled and is waiting for a free MEC reservation station entry. =
 The cycles should be appropriately counted in case of the cracked ops e.g.=
 In case of a cracked load-op, the load portion is sent to M",
+        "Counter": "0,1",
         "EventCode": "0xCB",
         "EventName": "RS_FULL_STALL.MEC",
         "PublicDescription": "Counts the number of cycles and allocation p=
ipeline is stalled and is waiting for a free MEC reservation station entry.=
  The cycles should be appropriately counted in case of the cracked ops e.g=
. In case of a cracked load-op, the load portion is sent to M.",
@@ -264,6 +296,7 @@
     },
     {
         "BriefDescription": "Micro-ops retired",
+        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ALL",
         "PublicDescription": "This event counts the number of micro-ops re=
tired. The processor decodes complex macro instructions into a sequence of =
simpler micro-ops. Most instructions are composed of one or two micro-ops. =
Some instructions are decoded into longer sequences such as repeat instruct=
ions, floating point transcendental instructions, and assists. In some case=
s micro-op sequences are fused or whole instructions are fused into one mic=
ro-op. See other UOPS_RETIRED events for differentiating retired fused and =
non-fused micro-ops.",
@@ -272,6 +305,7 @@
     },
     {
         "BriefDescription": "MSROM micro-ops retired",
+        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.MS",
         "PublicDescription": "This event counts the number of micro-ops re=
tired that were supplied from MSROM.",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
index 1be3fa5c4ad3..b50cee3a5e4c 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Loads missed DTLB",
+        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
         "PEBS": "1",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "Total cycles for all the page walks. (I-side =
and D-side)",
+        "Counter": "0,1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.CYCLES",
         "PublicDescription": "This event counts every cycle when a data (D=
) page walk or instruction (I) page walk is in progress.  Since a pagewalk =
implies a TLB miss, the approximate cost of a TLB miss can be determined fr=
om this event.",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "Duration of D-side page-walks in core cycles"=
,
+        "Counter": "0,1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.D_SIDE_CYCLES",
         "PublicDescription": "This event counts every cycle when a D-side =
(walks due to a load) page walk is in progress. Page walk duration divided =
by number of page walks is the average duration of page-walks.",
@@ -26,6 +29,7 @@
     },
     {
         "BriefDescription": "D-side page-walks",
+        "Counter": "0,1",
         "EdgeDetect": "1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.D_SIDE_WALKS",
@@ -35,6 +39,7 @@
     },
     {
         "BriefDescription": "Duration of I-side page-walks in core cycles"=
,
+        "Counter": "0,1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.I_SIDE_CYCLES",
         "PublicDescription": "This event counts every cycle when a I-side =
(walks due to an instruction fetch) page walk is in progress. Page walk dur=
ation divided by number of page walks is the average duration of page-walks=
.",
@@ -43,6 +48,7 @@
     },
     {
         "BriefDescription": "I-side page-walks",
+        "Counter": "0,1",
         "EdgeDetect": "1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.I_SIDE_WALKS",
@@ -52,6 +58,7 @@
     },
     {
         "BriefDescription": "Total page walks that are completed (I-side a=
nd D-side)",
+        "Counter": "0,1",
         "EdgeDetect": "1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.WALKS",
--=20
2.45.2.627.g7a2c4fd464-goog

