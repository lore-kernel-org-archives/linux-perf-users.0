Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037225;
	b=DfnxdruoXNvSCtMQBNjSac1ktvMnK+g86xUNdOLi72y+n263DAUamc8qc1ZEOUjs5/B3
	 XV+zyNFlJ5umlTcG1ff6clnSUIYgRgj8+VJN41GVMkPsBVpq3P8wWHl2BX8QMY5HTbBUl
	 SneW8e3j59mmFhUn/WOwJ9l+767XXSY+FzBOuyo9xnxhm7MiW5xw19G9wK3VD2YUBaOsl
	 8g3QRt8dzh5P0lds0pxNSqbryDSMxkjINjGzFKHBmbpGcK/BQ/ybMNcgVfbWC4t0w4ZXC
	 BK9pJqPILQqYVQV+syMY2fUNMQc937qKPFccOrmpPYMIBV48qNJqWhP35MF2UGI4CAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=61Eogm8SsuQnAiuvSTV3Hr2BLICmZ0Pr+i9ekPJUYLo=;
	b=zM7LxfjV6sua1ADns3nrSwZnz6QVwTTzvQivRAh4X6COWDS+IOUBFafn6HYj61r6iUmt
	 Iu+g8AKO7AlFFaU5TblUGWJazcmQ3zxXreGz5pctcWhKHvtQzpqUS+unga+WNN3AAJ/f0
	 6U6LuZo1ZKpDD605aMb02VUQcfP6sm18Hn5I5YJS6ue1Q3iGWzk44JMvy/eSWh6NEj/qG
	 GynUXDr2PRhr/gxrQR3JDXNu7DRohORXLZqE4cQIgoFmY5yfoYjtdQsM76qQ8my1zBn4V
	 7vc3xiKLg8QSfh6KWRTX4KAT9+7ar0tWWs96yBqiZdOtpEdUSYBS7DPzpd7fCNk27bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dzS51VaR;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4028860A261A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 21:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4028860A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dzS51VaR
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c467e19391so2203749b6e.3
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 13:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795037223; x=1795642023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=61Eogm8SsuQnAiuvSTV3Hr2BLICmZ0Pr+i9ekPJUYLo=;
        b=dzS51VaR5zxJTc2TJUL6fvyov/SqJZ/QCNxWOYw85WlAtEDced0IjPrvm/8bUXzy4d
         WLBJB84B+NNTEqWO3hQ3L98ahKmJKbg4KxTBMchr+S793SWPsfvqf2kU5rbL+Uct6sea
         m2aZeNhra9NtzhYV6pZ606pJm1+rqTOfKhoz3AqB6xfAxPnEICPDN4GMshBTItwlKsnf
         VQ2wwCNxI91nXjwDB9IgxrtyW9sMgeu0JEw66+/tlKLPwemQ9fPJuRVxvvrnOu9ZnJoy
         XSRjhCk3obMJHHp7SY3FLWab7tqqTXJrl2zqf2GERBOWFhWqMr57v54IxIXR2+WkqGzc
         gzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037223; x=1795642023;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=61Eogm8SsuQnAiuvSTV3Hr2BLICmZ0Pr+i9ekPJUYLo=;
        b=cmVTTb3O2bTB4cZ0JfHeb1UERny+a7EOm2tBnECsMrBROTuG+wCbWdgIxUZ9kZtczc
         7zZZ5U3yZC7VEl9+JYq3wuBiEo32ocMznAMeS9WIsjQHqHyrX5RIPj1Au6e3BkzH+j0f
         U0XtZHF4R7phVwv+aNnUyoL2ObO4xYtoMkQc+pH5ah8Xh0Lb9Qscx35XSAdc7l2aVZny
         LlguldeDhKgBEdcyoVLTSuyruqa0RXppkyZi4Kl29Ns/CjhSIckHHXHbXaHJ951FL+Hj
         DJkX540AV/N10/kLcE6TFCZ2cv1Y7/WaFx4vO/GXz5O3yZ49O/1ECkhlUHOaXXwA9XnX
         54gA==
X-Forwarded-Encrypted: i=1; AL+hErG5YfUxaURZ6R+M1vHXOGd2kKa11dcw7BURW7zbvCC+WYCXatxBLS6anyaYeW2ciLVERyYv9ykdC0JNAYFh1Iea@vger.kernel.org
X-Gm-Message-State: APuU4Z9AbNuJQ1vv/1JDXWjdsDaZDlCslqlqxqquTcw36nCQN3nbRvb1
	n+mqWO5+iMQkxDp7lhlM9uBSSQrrVl5M44Ncl4m9CRlVfEl0yHkbgF7xXdTdU5CljoIdYXktr80
	RNIJ24Q==
X-Received: from jahl1-n2.prod.google.com ([2002:a05:6638:8c01:20b0:620:20e6:fa29])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:14c1:b0:4f6:5279:5c75
 with SMTP id 5614622812f47-5773d72d7c3mr4140413b6e.28.1795037222751; Wed, 18
 Nov 2026 13:27:02 -0800 (PST)
Date: Wed, 18 Nov 2026 13:26:55 -0800
In-Reply-To: <20261118212655.2262601-1-ctshao@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118212655.2262601-1-ctshao@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118212655.2262601-4-ctshao@google.com>
Subject: [PATCH v1 3/3] perf vendor events intel: Update novalake events from
 1.04 to 1.05
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:
https://github.com/intel/perfmon/commit/409ce6f3950c46f6cd3deac31b93d66a6ae=
82d6e

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-4-carbon
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/novalake/cache.json   | 13 ++-
 .../pmu-events/arch/x86/novalake/counter.json |  5 ++
 .../arch/x86/novalake/floating-point.json     |  4 +-
 .../pmu-events/arch/x86/novalake/memory.json  | 39 ++++++++-
 .../pmu-events/arch/x86/novalake/other.json   | 84 +++++++++++++++++++
 .../arch/x86/novalake/pipeline.json           | 75 +++++++++++++++++
 .../arch/x86/novalake/uncore-cache.json       | 11 +++
 8 files changed, 227 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/uncore-cache.js=
on

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 5e6bff382c23..7b88b9fad945 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -27,7 +27,7 @@ GenuineIntel-6-BD,v1.27,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.23,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
-GenuineIntel-18-[13],v1.04,novalake,core
+GenuineIntel-18-[13],v1.05,novalake,core
 GenuineIntel-6-(CC|D5|E5),v1.08,pantherlake,core
 GenuineIntel-6-A7,v1.06,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
diff --git a/tools/perf/pmu-events/arch/x86/novalake/cache.json b/tools/per=
f/pmu-events/arch/x86/novalake/cache.json
index e8d416ffd421..808858f1871e 100644
--- a/tools/perf/pmu-events/arch/x86/novalake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/novalake/cache.json
@@ -249,7 +249,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "L2_REQUEST.RFO_HIT_XSNP_HIT_FWD",
+        "BriefDescription": "L2_REQUEST.RFO_HIT_XSNP_HIT_FWD [This event i=
s alias to L2_RQSTS.RFO_HIT_XSNP_HIT_FWD]",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.RFO_HIT_XSNP_HIT_FWD",
@@ -377,6 +377,15 @@
         "UMask": "0x42",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "L2_RQSTS.RFO_HIT_XSNP_HIT_FWD [This event is =
alias to L2_REQUEST.RFO_HIT_XSNP_HIT_FWD]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_HIT_XSNP_HIT_FWD",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2002",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "RFO requests that miss L2 cache [This event i=
s alias to L2_REQUEST.RFO_MISS]",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1174,7 +1183,7 @@
         "EventCode": "0x2c",
         "EventName": "SQ_MISC.BUS_LOCK",
         "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
-        "SampleAfterValue": "100003",
+        "SampleAfterValue": "503",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
diff --git a/tools/perf/pmu-events/arch/x86/novalake/counter.json b/tools/p=
erf/pmu-events/arch/x86/novalake/counter.json
index 6cdc63552c67..0ab92c0013b6 100644
--- a/tools/perf/pmu-events/arch/x86/novalake/counter.json
+++ b/tools/perf/pmu-events/arch/x86/novalake/counter.json
@@ -13,5 +13,10 @@
         "Unit": "iMC",
         "CountersNumFixed": "0",
         "CountersNumGeneric": "5"
+    },
+    {
+        "Unit": "CBOX",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 2
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/novalake/floating-point.json b/=
tools/perf/pmu-events/arch/x86/novalake/floating-point.json
index 455f752a746d..f60bf04b87af 100644
--- a/tools/perf/pmu-events/arch/x86/novalake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/novalake/floating-point.json
@@ -359,7 +359,7 @@
         "EventName": "FP_ARITH_OPS_RETIRED.SCALAR",
         "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events.",
         "SampleAfterValue": "1000003",
-        "UMask": "0x3",
+        "UMask": "0x303",
         "Unit": "cpu_core"
     },
     {
@@ -389,7 +389,7 @@
         "EventName": "FP_ARITH_OPS_RETIRED.VECTOR",
         "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events.",
         "SampleAfterValue": "1000003",
-        "UMask": "0x3c",
+        "UMask": "0x1cfc",
         "Unit": "cpu_core"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/novalake/memory.json b/tools/pe=
rf/pmu-events/arch/x86/novalake/memory.json
index 618bcb7cb3e1..8e7488a88e77 100644
--- a/tools/perf/pmu-events/arch/x86/novalake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/novalake/memory.json
@@ -132,7 +132,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
+        "PublicDescription": "Counts the number of Machine Clears detected=
 due to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -155,6 +155,18 @@
         "UMask": "0x48",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than any number of cycles."=
,
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT",
+        "MSRIndex": "0x3F6",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than any number of cycles.=
  Reported latency may be longer than just the memory latency. Available PD=
IST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 1024 cycles.",
         "Counter": "2,3,4,5,6,7",
@@ -194,6 +206,19 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 2 cycles.",
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2 cycles.  Reported l=
atency may be longer than just the memory latency. Available PDIST counters=
: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 2048 cycles.",
         "Counter": "2,3,4,5,6,7",
@@ -308,6 +333,18 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "OMR.DEMAND_RFO.L3_MISS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFF03F000000002",
+        "PublicDescription": "OMR.DEMAND_RFO.L3_MISS Available PDIST count=
ers: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "OMR.READS_TO_CORE.L3_MISS",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/novalake/other.json b/tools/per=
f/pmu-events/arch/x86/novalake/other.json
index 19932b311486..1c0d4e729e1f 100644
--- a/tools/perf/pmu-events/arch/x86/novalake/other.json
+++ b/tools/perf/pmu-events/arch/x86/novalake/other.json
@@ -175,6 +175,54 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HIT",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HIT",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xED000400000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HIT Available=
 PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HIT.SNP_HIT_NO=
_FWD",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HIT.SNP_HIT_NO_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x4D000400000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HIT.SNP_HIT_N=
O_FWD Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HITESF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HITESF",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE5000400000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HITESF Availa=
ble PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HITM",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HITM",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE9000400000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HITM Availabl=
e PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_0",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -199,6 +247,42 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "OMR.DEMAND_RFO.ANY_RESPONSE",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x4000000000000002",
+        "PublicDescription": "OMR.DEMAND_RFO.ANY_RESPONSE Available PDIST =
counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_RFO.L3_SAME_CBB.HITM",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_RFO.L3_SAME_CBB.HITM",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE9000400000002",
+        "PublicDescription": "OMR.DEMAND_RFO.L3_SAME_CBB.HITM Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.MODIFIED_WRITE.ANY_RESPONSE",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.MODIFIED_WRITE.ANY_RESPONSE",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x4000000000000808",
+        "PublicDescription": "OMR.MODIFIED_WRITE.ANY_RESPONSE Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "OMR.READS_TO_CORE.ANY_MEMORY",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/novalake/pipeline.json b/tools/=
perf/pmu-events/arch/x86/novalake/pipeline.json
index 8b2e1ed2331d..382d08f79416 100644
--- a/tools/perf/pmu-events/arch/x86/novalake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/novalake/pipeline.json
@@ -2219,6 +2219,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles where at least 10 uops was executed pe=
r-thread",
+        "Counter": "3",
+        "CounterMask": "10",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_10",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread",
         "Counter": "3",
@@ -2252,6 +2262,26 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles where at least 6 uops was executed per=
-thread",
+        "Counter": "3",
+        "CounterMask": "6",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_6",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where at least 8 uops was executed per=
-thread",
+        "Counter": "3",
+        "CounterMask": "8",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_8",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
         "Counter": "3",
@@ -2464,5 +2494,50 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts number of vector uops dispatched on VE=
C1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb4",
+        "EventName": "VEC_DISPATCHED.V1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts number of vector uops dispatched on VE=
C2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb4",
+        "EventName": "VEC_DISPATCHED.V2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts number of vector uops dispatched on VE=
C3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb4",
+        "EventName": "VEC_DISPATCHED.V3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts number of vector uops dispatched on VE=
C4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb4",
+        "EventName": "VEC_DISPATCHED.V4",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts number of vector uops dispatched on VE=
C5",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb4",
+        "EventName": "VEC_DISPATCHED.V5",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/novalake/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/novalake/uncore-cache.json
new file mode 100644
index 000000000000..a71772c6bb82
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/novalake/uncore-cache.json
@@ -0,0 +1,11 @@
+[
+    {
+        "BriefDescription": "Counts UCLK ungated cycles.",
+        "Counter": "0,1",
+        "EventCode": "0x2d",
+        "EventName": "UNC_CBO_SBO_UCLK_CYCLES.UNGATED",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBOX"
+    }
+]
--=20
2.56.1.708.g77570a6a1d-goog

