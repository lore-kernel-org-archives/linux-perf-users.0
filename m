Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B251BC2A
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686555; cv=none; b=qHS29MZiI9nhUu+0Cs1bMyefrtlAK372y1n71HKYOgCYPNXmW8vxH2owBssy5tnwVmCVb1ozBufppPnFNZc0rwPqm3wQ0g3ON3Hfp3N5HsCYgNLpWdBcYtZSp+AIyVpw8a/Ygn2zUAUTksDnvO66INej2DxAYRVgHXlpXzTu6bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686555; c=relaxed/simple;
	bh=Dz18LZrUYGkpijAB590N0dgyU9iK6Cr+luU6vaCe6ic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Z8zXmkQ8cY/ft9qq8qwyPb0Ac1G+w249QPcK9DdHN4lX5ZYOadsbmn7zoFZ6KPjRMC6X1KG2Y2NS74Cq05Qxqaoz94wlXmS8LBcPaDzXilvO3HFkW1DZM2+Age6JhmWyontqeGHDSXtqaKDR8yQGRlZ1C139nHPW9/mYhQVd6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=prcqzHKK; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prcqzHKK"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742c03c0272so459869b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749686553; x=1750291353; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2C+17o8Ln8hoOEaVq9fP1NovPjwt4rLVbaU8TXQZizQ=;
        b=prcqzHKKaXZ8rFk+CdZIUFWE6j854/IOdp4hu9+8N9IMvGNXQNGsEHqSFvbQ62BrXw
         cpK+lnJpHKxFmHYA+PIKVPYdGbXISBojqNo7OUOywZzG/GHNWTD+Gax7OI82VdbgAJBC
         x5lKSTx+kYMWyZUOeWoUz0GDzSzoXAELVqG9s4NWDenqmAyROaayR29Uapdq+QBmoLAd
         Y1bFK5eeDPKpWkFltMFr2MdkVarU+xo6Sp65XlHIJiQWeMKIai/V6mZpmtWg3rw4xqdX
         vrM3D2qlJtgGAoSGsh7czOE421a5lLtXzxlTZesUAqaRWtAKGuFGWKfFrJwsjRy0+Izk
         5qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749686553; x=1750291353;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2C+17o8Ln8hoOEaVq9fP1NovPjwt4rLVbaU8TXQZizQ=;
        b=wJDS6a9ZH5mm6zAOm7PwyY503CsblxEXAwuPGSG5vU9Gk3LsEq0nG14yO7zecVQFAp
         VLj0bUR033DLhBcY26u1DWCZkcqQ0Lw347cnOyzM5zke9LoSRwazoxsFtZDQAm+QBtGD
         7hFQAlcP4lLgZ0zfi6knKv9Ghol1Kc29xkqNfNIpUUdsqWi7pNfp/GiUpFomvhjyJTke
         icL0MXUxi5AWI4Y9E/9/HU2OKWjbHHojs2cJJGr60FZpMAYLWfEWlefIl/TKI8UE31qn
         iazMe+pUfId7/Omv7oWjYDwclrkaTiENpIiPrHkNPHeuJG3bBVukPLsuPEI7T99+ek/j
         xdUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbd6ZqdRhwUHk7HivcMWlZm+gTCZB3vwo8gWl3N/hP3vmL9jSxg9vs9Jc6ovXknbO1NzJl5gAeA7K6vpCL7+e6@vger.kernel.org
X-Gm-Message-State: AOJu0YyfNWzN0/jbajvqGHp4tyKf6L+53iXynTJ4j3brnhCMg4QjPnAw
	JKWHsH7kXMObuARNgR4boyeQPLPzQFrf5TLLo6RtA1BjahYCG7sSTO1sa7O6O8c9CKOPVWp8dtP
	pPe7PmRmtGw==
X-Google-Smtp-Source: AGHT+IFPlm6+vJonc7NLaYhY5EwLsTLIAFD6k8RBRN9umBviUZ3RYOXkjDgyLDWrHs0MDP1+cD4gcgWM+NDx
X-Received: from pgjp8.prod.google.com ([2002:a63:e648:0:b0:b2c:3a2e:ac7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a10c:b0:21f:4631:811c
 with SMTP id adf61e73a8af0-21f86725da6mr7323532637.19.1749686552684; Wed, 11
 Jun 2025 17:02:32 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:02:11 -0700
In-Reply-To: <20250612000224.780337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612000224.780337-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612000224.780337-3-irogers@google.com>
Subject: [PATCH v1 02/15] perf vendor events: Update AlderlakeN events
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

Update events from v1.29 to v1.31.

Bring in the event updates v1.31:
https://github.com/intel/perfmon/commit/5a1269c8af70e32a548e74e1fda736189c3=
98ddc
https://github.com/intel/perfmon/commit/76c6d2c348c067e9ae1b616b35ee982da6d=
873b4

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/alderlaken/cache.json | 52 +++++++------------
 .../arch/x86/alderlaken/floating-point.json   |  1 -
 .../pmu-events/arch/x86/alderlaken/other.json |  1 -
 .../arch/x86/alderlaken/pipeline.json         | 42 ++-------------
 .../arch/x86/alderlaken/virtual-memory.json   |  3 --
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 6 files changed, 25 insertions(+), 76 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json b/tools/p=
erf/pmu-events/arch/x86/alderlaken/cache.json
index bf691aee1ef4..669f4979b651 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
@@ -118,7 +118,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
-        "PublicDescription": "Counts the number of load uops retired that =
hit in DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
@@ -128,7 +127,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HITM",
-        "PublicDescription": "Counts the number of load uops retired that =
hit in the L3 cache, in which a snoop was required and modified data was fo=
rwarded from another core or module. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
@@ -138,7 +136,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
-        "PublicDescription": "Counts the number of load uops retired that =
hit in the L1 data cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
@@ -148,7 +145,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
-        "PublicDescription": "Counts the number of load uops retired that =
miss in the L1 data cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
@@ -158,7 +154,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
-        "PublicDescription": "Counts the number of load uops retired that =
hit in the L2 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
@@ -168,7 +163,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
-        "PublicDescription": "Counts the number of load uops retired that =
miss in the L2 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
@@ -178,7 +172,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
-        "PublicDescription": "Counts the number of load uops retired that =
hit in the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
@@ -188,7 +181,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_UOPS_RETIRED_MISC.HIT_E_F",
-        "PublicDescription": "Counts the number of load uops retired that =
hit in the L3 cache, in which a snoop was required, and non-modified data w=
as forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x40"
     },
@@ -198,7 +190,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_UOPS_RETIRED_MISC.L3_MISS",
-        "PublicDescription": "Counts the number of load uops retired that =
miss in the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     },
@@ -240,7 +231,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
-        "PublicDescription": "Counts the total number of load uops retired=
. Available PDIST counters: 0",
+        "PublicDescription": "Counts the total number of load uops retired=
.",
         "SampleAfterValue": "200003",
         "UMask": "0x81"
     },
@@ -250,103 +241,103 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
-        "PublicDescription": "Counts the total number of store uops retire=
d. Available PDIST counters: 0",
+        "PublicDescription": "Counts the total number of store uops retire=
d.",
         "SampleAfterValue": "200003",
         "UMask": "0x82"
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 128 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled."=
,
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
-        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 128 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 128 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 16 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
-        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 16 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 16 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 256 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled."=
,
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
-        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 256 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 256 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 32 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
-        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 32 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 32 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 4 cycles as define=
d in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
-        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 4 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. I=
f a PEBS record is generated, will populate the PEBS Latency and PEBS Data =
Source fields accordingly. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 4 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. I=
f a PEBS record is generated, will populate the PEBS Latency and PEBS Data =
Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 512 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled."=
,
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
-        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 512 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 512 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 64 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
-        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 64 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 64 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 8 cycles as define=
d in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
-        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 8 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. I=
f a PEBS record is generated, will populate the PEBS Latency and PEBS Data =
Source fields accordingly. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 8 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. I=
f a PEBS record is generated, will populate the PEBS Latency and PEBS Data =
Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -356,7 +347,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
-        "PublicDescription": "Counts the number of load uops retired that =
performed one or more locks. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x21"
     },
@@ -366,7 +356,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
-        "PublicDescription": "Counts the number of retired split load uops=
. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x41"
     },
@@ -376,7 +365,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS",
-        "PublicDescription": "Counts the total number of load and store uo=
ps retired that missed in the second level TLB. Available PDIST counters: 0=
",
         "SampleAfterValue": "200003",
         "UMask": "0x13"
     },
@@ -386,7 +374,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
-        "PublicDescription": "Counts the number of load ops retired that m=
iss in the second Level TLB. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x11"
     },
@@ -396,7 +383,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
-        "PublicDescription": "Counts the number of store ops retired that =
miss in the second level TLB. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x12"
     },
@@ -406,7 +392,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
-        "PublicDescription": "Counts the number of stores uops retired. Co=
unts with or without PEBS enabled. If PEBS is enabled and a PEBS record is =
generated, will populate PEBS Latency and PEBS Data Source fields according=
ly. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of stores uops retired. Co=
unts with or without PEBS enabled. If PEBS is enabled and a PEBS record is =
generated, will populate PEBS Latency and PEBS Data Source fields according=
ly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json =
b/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
index f44da31ff1f1..ed963fcb6485 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
@@ -29,7 +29,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.FPDIV",
-        "PublicDescription": "Counts the number of floating point divide u=
ops retired (x87 and SSE, including x87 sqrt). Available PDIST counters: 0"=
,
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     }
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/other.json b/tools/p=
erf/pmu-events/arch/x86/alderlaken/other.json
index 8c2b5a284f2a..144d7b06f240 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/other.json
@@ -5,7 +5,6 @@
         "Deprecated": "1",
         "EventCode": "0xe4",
         "EventName": "LBR_INSERTS.ANY",
-        "PublicDescription": "This event is deprecated. [This event is ali=
as to MISC_RETIRED.LBR_INSERTS] Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/alderlaken/pipeline.json
index 9616bf0e9f1f..1dd61baec1a9 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
@@ -54,7 +54,7 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for. Available PDIST counters: 0",
+        "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
         "SampleAfterValue": "200003"
     },
     {
@@ -63,7 +63,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.CALL",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_INST_RETIRED.NEAR_CALL Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xf9"
     },
@@ -72,7 +71,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
-        "PublicDescription": "Counts the number of retired JCC (Jump on Co=
nditional Code) branch instructions retired, includes both taken and not ta=
ken branches. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
@@ -81,7 +79,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
-        "PublicDescription": "Counts the number of taken JCC (Jump on Cond=
itional Code) branch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
@@ -90,7 +87,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "PublicDescription": "Counts the number of far branch instructions=
 retired, includes far jump, far call and return, and interrupt call and re=
turn. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xbf"
     },
@@ -99,7 +95,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
-        "PublicDescription": "Counts the number of near indirect JMP and n=
ear indirect CALL branch instructions retired. Available PDIST counters: 0"=
,
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
@@ -108,7 +103,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
-        "PublicDescription": "Counts the number of near indirect CALL bran=
ch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
@@ -118,7 +112,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_INST_RETIRED.INDIRECT_CALL Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
@@ -128,7 +121,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.JCC",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_INST_RETIRED.COND Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
@@ -137,7 +129,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PublicDescription": "Counts the number of near CALL branch instru=
ctions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xf9"
     },
@@ -146,7 +137,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PublicDescription": "Counts the number of near RET branch instruc=
tions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
@@ -155,7 +145,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
-        "PublicDescription": "Counts the number of near taken branch instr=
uctions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xc0"
     },
@@ -165,7 +154,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_INST_RETIRED.INDIRECT Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
@@ -174,7 +162,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
-        "PublicDescription": "Counts the number of near relative CALL bran=
ch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfd"
     },
@@ -184,7 +171,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.RETURN",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_INST_RETIRED.NEAR_RETURN Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
@@ -194,7 +180,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_INST_RETIRED.COND_TAKEN Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
@@ -203,7 +188,7 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path. Available PDIST count=
ers: 0",
+        "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path.",
         "SampleAfterValue": "200003"
     },
     {
@@ -211,7 +196,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
-        "PublicDescription": "Counts the number of mispredicted JCC (Jump =
on Conditional Code) branch instructions retired. Available PDIST counters:=
 0",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
@@ -220,7 +204,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
-        "PublicDescription": "Counts the number of mispredicted taken JCC =
(Jump on Conditional Code) branch instructions retired. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
@@ -229,7 +212,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
-        "PublicDescription": "Counts the number of mispredicted near indir=
ect JMP and near indirect CALL branch instructions retired. Available PDIST=
 counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
@@ -238,7 +220,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
-        "PublicDescription": "Counts the number of mispredicted near indir=
ect CALL branch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
@@ -248,7 +229,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_MISP_RETIRED.INDIRECT_CALL Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
@@ -258,7 +238,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.JCC",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_MISP_RETIRED.COND Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
@@ -267,7 +246,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
-        "PublicDescription": "Counts the number of mispredicted near taken=
 branch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
@@ -277,7 +255,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_MISP_RETIRED.INDIRECT Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
@@ -286,7 +263,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RETURN",
-        "PublicDescription": "Counts the number of mispredicted near RET b=
ranch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
@@ -296,7 +272,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_MISP_RETIRED.COND_TAKEN Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
@@ -371,7 +346,7 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
-        "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses a programmable general purpose performance counter. Available=
 PDIST counters: 0",
+        "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses a programmable general purpose performance counter.",
         "SampleAfterValue": "2000003"
     },
     {
@@ -380,7 +355,6 @@
         "Deprecated": "1",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.4K_ALIAS",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 LD_BLOCKS.ADDRESS_ALIAS Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -389,7 +363,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
-        "PublicDescription": "Counts the number of retired loads that are =
blocked because it initially appears to be store forward blocked, but subse=
quently is shown not to be blocked based on 4K alias check. Available PDIST=
 counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -398,7 +371,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DATA_UNKNOWN",
-        "PublicDescription": "Counts the number of retired loads that are =
blocked because its address exactly matches an older store whose data is no=
t ready. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -448,7 +420,7 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "Counts the number of LBR entries recorded. R=
equires LBRs to be enabled in IA32_LBR_CTL. This event is PDIR on GP0 and N=
PEBS on all other GPs [This event is alias to LBR_INSERTS.ANY] Available PD=
IST counters: 0",
+        "PublicDescription": "Counts the number of LBR entries recorded. R=
equires LBRs to be enabled in IA32_LBR_CTL. This event is PDIR on GP0 and N=
PEBS on all other GPs [This event is alias to LBR_INSERTS.ANY]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -651,7 +623,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "TOPDOWN_RETIRING.ALL",
-        "PublicDescription": "Counts the total number of consumed retireme=
nt slots. Available PDIST counters: 0",
         "SampleAfterValue": "1000003"
     },
     {
@@ -667,7 +638,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.ALL",
-        "PublicDescription": "Counts the total number of uops retired. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "2000003"
     },
     {
@@ -675,7 +645,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.IDIV",
-        "PublicDescription": "Counts the number of integer divide uops ret=
ired. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -684,7 +653,7 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MS",
-        "PublicDescription": "Counts the number of uops that are from comp=
lex flows issued by the Microcode Sequencer (MS). This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows. Avai=
lable PDIST counters: 0",
+        "PublicDescription": "Counts the number of uops that are from comp=
lex flows issued by the Microcode Sequencer (MS). This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -693,7 +662,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.X87",
-        "PublicDescription": "Counts the number of x87 uops retired, inclu=
des those in MS flows. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     }
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
index c348046696bf..d9c737a17df0 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
@@ -57,7 +57,6 @@
         "Deprecated": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 MEM_UOPS_RETIRED.STLB_MISS Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x13"
     },
@@ -68,7 +67,6 @@
         "Deprecated": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 MEM_UOPS_RETIRED.STLB_MISS_LOADS Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x11"
     },
@@ -79,7 +77,6 @@
         "Deprecated": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_STORES",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 MEM_UOPS_RETIRED.STLB_MISS_STORES Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x12"
     }
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 35c5a4088356..8a2ee64cad7e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.31,alderlake,core
-GenuineIntel-6-BE,v1.29,alderlaken,core
+GenuineIntel-6-BE,v1.31,alderlaken,core
 GenuineIntel-6-C[56],v1.08,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
--=20
2.50.0.rc1.591.g9c95f17f64-goog

