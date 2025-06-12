Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793C101DE
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686554; cv=none; b=KHEC7wi/qnpXvIekVDtym9EJyzWGHtwvOb6GW3hxG5cflwuzVqB9XVU2z/uygJS6fLNRxmolIiApV6HrnrSRlWBHOC4zJHdfWp9QgNWa1oOLK6Z+7R9VVqxOTfNV1ZzcvXXBvNTMvj9McgqQtsNQJ7dzffPp25CBCYIwyGY1aV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686554; c=relaxed/simple;
	bh=73/VClvfm+vnu8mK8PL5YscNhRxhLzL5oFZj9kU/jW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oYab4SnjDGyVSEFx3PdaCOCU4vx7nWlNSGv6rBUMvghOvM4wU6k5IsS7oIhZGUjpHyUzYXXNGLku1mfK6cZMn8Tq7lulqEznd71BE9uW2k0faC7h5RVbFmhT9LtG7i8iPu54TylH6ByRoPYd5zv3YuegjoX11PmpMZqmlnd4T8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJaWzOgY; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJaWzOgY"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-73a17986d6bso118419a34.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 17:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749686551; x=1750291351; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0F7siqHw6wGoddpwArkho8QHHimv4PXa5X1RDHbpiuc=;
        b=NJaWzOgYn6zXErnYDICllM6RC4is7BqTXImShY3ZdL6AE9ezPAmkQWRYRIqelgnoEi
         tV7OumbFYOn+QReW5CEaVQm2JhHEe+z2aq5AxVxG2/chV5T9+Fhmge3a9V0imVGwrVMz
         Cu5AXvXe8y4/jWws4aUxUYmizB4dRSqMAZ4Y1M7KcBYkZhiMiQj2M9tTu50JhIuBp9D9
         zLBytrZmfMjSHQhfUYp4eJ9eD6+ciYKU6SM89cW7i52+Nj1NVDx/wBKnQZAAxmtIOcbM
         zyo1C/sF6UAJQl/8s7ogDRrsN1tkdirhdFqin7lKew/oe89EC0vRfr06+z3tAIQ2Wkf8
         om6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749686551; x=1750291351;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0F7siqHw6wGoddpwArkho8QHHimv4PXa5X1RDHbpiuc=;
        b=KDVtii5CoQXrtu6mbt4Ksa4uztS0fmSiBNRuXeAdkinjyrxm1tChRCqfouww+HL2fU
         +8Pve60KJQI8s9X33yOBQgtbdwX8k/hOf3oJMKKHKkicP8AD/tGf2oraXYc0wWbCtUkt
         CEaeobuRkLj2qIdSMqCPKHLFcq7oa1lXbUnNVDFie5kgruDrSxnHQjmB0B2IwFLMUnFE
         wFn1EoRfS3Ma3nvyN1yx9nEWl5+70JQRMXqz3BaOFumX8G9N7PPIO2tyTMsp9JHurmrm
         O8QojtN3aISEIpTKmxFTD64HHEMq65PhNARdmlKuNijdKB7pcxXVbA2tIlFacSC+5/3x
         Rc8w==
X-Forwarded-Encrypted: i=1; AJvYcCWYKKNUel2U5iEM+Ytih9R5z3j2jv7IDdpjQMiYCFTgsF4uzHaNo3rrSf7+RjvVnzAEliXmCdENFBa3leFq2ecE@vger.kernel.org
X-Gm-Message-State: AOJu0YxpRZJ5QswlJ30lzv27k/noCY+2SkvGBnEzgMo48aiTSeczQYz5
	R4G6GlZTLBQnRsDHUWepvrwtSX/w/vltIEw+Rkff8WICUs6iwO0TdfiF+07nr/NOw06y6qn+MHU
	zxC24opEZuA==
X-Google-Smtp-Source: AGHT+IFLAWr7KjJ1kPrDAwN+Sdk0+ro6J0dKUWn58sp2zc9Qqnha2PKYtxEwg0CG6WkoQSylUR39ZFlvsgsM
X-Received: from oacny15.prod.google.com ([2002:a05:6871:750f:b0:2ba:487b:683e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:351:b0:2b8:e6f2:ba7e
 with SMTP id 586e51a60fabf-2eab72d8497mr457455fac.12.1749686550719; Wed, 11
 Jun 2025 17:02:30 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:02:10 -0700
In-Reply-To: <20250612000224.780337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612000224.780337-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612000224.780337-2-irogers@google.com>
Subject: [PATCH v1 01/15] perf vendor events: Update Alderlake events
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
 .../pmu-events/arch/x86/alderlake/cache.json  | 56 +++++++------------
 .../arch/x86/alderlake/floating-point.json    |  1 -
 .../pmu-events/arch/x86/alderlake/other.json  |  1 -
 .../arch/x86/alderlake/pipeline.json          | 44 ++-------------
 .../arch/x86/alderlake/virtual-memory.json    |  3 -
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 6 files changed, 28 insertions(+), 79 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/cache.json
index c2802fbb853b..5461576dafc7 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -728,7 +728,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
-        "PublicDescription": "Counts the number of load uops retired that =
hit in DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x80",
         "Unit": "cpu_atom"
@@ -739,7 +738,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HITM",
-        "PublicDescription": "Counts the number of load uops retired that =
hit in the L3 cache, in which a snoop was required and modified data was fo=
rwarded from another core or module. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x20",
         "Unit": "cpu_atom"
@@ -750,7 +748,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
-        "PublicDescription": "Counts the number of load uops retired that =
hit in the L1 data cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -761,7 +758,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
-        "PublicDescription": "Counts the number of load uops retired that =
miss in the L1 data cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x8",
         "Unit": "cpu_atom"
@@ -772,7 +768,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
-        "PublicDescription": "Counts the number of load uops retired that =
hit in the L2 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x2",
         "Unit": "cpu_atom"
@@ -783,7 +778,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
-        "PublicDescription": "Counts the number of load uops retired that =
miss in the L2 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x10",
         "Unit": "cpu_atom"
@@ -794,7 +788,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
-        "PublicDescription": "Counts the number of load uops retired that =
hit in the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x4",
         "Unit": "cpu_atom"
@@ -805,7 +798,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_UOPS_RETIRED_MISC.HIT_E_F",
-        "PublicDescription": "Counts the number of load uops retired that =
hit in the L3 cache, in which a snoop was required, and non-modified data w=
as forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x40",
         "Unit": "cpu_atom"
@@ -816,7 +808,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_UOPS_RETIRED_MISC.L3_MISS",
-        "PublicDescription": "Counts the number of load uops retired that =
miss in the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20",
         "Unit": "cpu_atom"
@@ -873,7 +864,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
-        "PublicDescription": "Counts the total number of load uops retired=
. Available PDIST counters: 0",
+        "PublicDescription": "Counts the total number of load uops retired=
.",
         "SampleAfterValue": "200003",
         "UMask": "0x81",
         "Unit": "cpu_atom"
@@ -884,111 +875,111 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
-        "PublicDescription": "Counts the total number of store uops retire=
d. Available PDIST counters: 0",
+        "PublicDescription": "Counts the total number of store uops retire=
d.",
         "SampleAfterValue": "200003",
         "UMask": "0x82",
         "Unit": "cpu_atom"
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
@@ -999,7 +990,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
-        "PublicDescription": "Counts the number of load uops retired that =
performed one or more locks. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x21",
         "Unit": "cpu_atom"
@@ -1010,7 +1000,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
-        "PublicDescription": "Counts the number of retired split load uops=
. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x41",
         "Unit": "cpu_atom"
@@ -1021,7 +1010,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS",
-        "PublicDescription": "Counts the total number of load and store uo=
ps retired that missed in the second level TLB. Available PDIST counters: 0=
",
         "SampleAfterValue": "200003",
         "UMask": "0x13",
         "Unit": "cpu_atom"
@@ -1032,7 +1020,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
-        "PublicDescription": "Counts the number of load ops retired that m=
iss in the second Level TLB. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x11",
         "Unit": "cpu_atom"
@@ -1043,7 +1030,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
-        "PublicDescription": "Counts the number of store ops retired that =
miss in the second level TLB. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x12",
         "Unit": "cpu_atom"
@@ -1054,7 +1040,7 @@
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
         "UMask": "0x6",
         "Unit": "cpu_atom"
@@ -1478,12 +1464,12 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "For every cycle where the core is waiting on =
at least 1 outstanding Demand RFO request, increments by 1.",
+        "BriefDescription": "Cycles with offcore outstanding demand rfo re=
ads transactions in SuperQueue (SQ), queue to uncore.",
         "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
-        "PublicDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEM=
AND_RFO Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of offcore outstanding dem=
and rfo Reads transactions in the super queue every cycle. The 'Offcore out=
standing' state of the transaction lasts from the L2 miss until the sending=
 transaction completion to requestor (SQ deallocation). See the correspondi=
ng Umask under OFFCORE_REQUESTS. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json b=
/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
index ce570b96360a..d01f1b163ed8 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
@@ -213,7 +213,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.FPDIV",
-        "PublicDescription": "Counts the number of floating point divide u=
ops retired (x87 and SSE, including x87 sqrt). Available PDIST counters: 0"=
,
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_atom"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/other.json
index e4e75b088ccc..5f64138edfe4 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
@@ -55,7 +55,6 @@
         "Deprecated": "1",
         "EventCode": "0xe4",
         "EventName": "LBR_INSERTS.ANY",
-        "PublicDescription": "This event is deprecated. [This event is ali=
as to MISC_RETIRED.LBR_INSERTS] Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index 7e0e33792c45..48ef2a8cc49a 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -128,7 +128,7 @@
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
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
@@ -147,7 +147,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.CALL",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_INST_RETIRED.NEAR_CALL Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xf9",
         "Unit": "cpu_atom"
@@ -157,7 +156,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
-        "PublicDescription": "Counts the number of retired JCC (Jump on Co=
nditional Code) branch instructions retired, includes both taken and not ta=
ken branches. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x7e",
         "Unit": "cpu_atom"
@@ -187,7 +185,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
-        "PublicDescription": "Counts the number of taken JCC (Jump on Cond=
itional Code) branch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfe",
         "Unit": "cpu_atom"
@@ -207,7 +204,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "PublicDescription": "Counts the number of far branch instructions=
 retired, includes far jump, far call and return, and interrupt call and re=
turn. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xbf",
         "Unit": "cpu_atom"
@@ -227,7 +223,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
-        "PublicDescription": "Counts the number of near indirect JMP and n=
ear indirect CALL branch instructions retired. Available PDIST counters: 0"=
,
         "SampleAfterValue": "200003",
         "UMask": "0xeb",
         "Unit": "cpu_atom"
@@ -247,7 +242,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
-        "PublicDescription": "Counts the number of near indirect CALL bran=
ch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfb",
         "Unit": "cpu_atom"
@@ -258,7 +252,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_INST_RETIRED.INDIRECT_CALL Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfb",
         "Unit": "cpu_atom"
@@ -269,7 +262,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.JCC",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_INST_RETIRED.COND Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x7e",
         "Unit": "cpu_atom"
@@ -279,7 +271,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PublicDescription": "Counts the number of near CALL branch instru=
ctions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xf9",
         "Unit": "cpu_atom"
@@ -299,7 +290,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PublicDescription": "Counts the number of near RET branch instruc=
tions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xf7",
         "Unit": "cpu_atom"
@@ -319,7 +309,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
-        "PublicDescription": "Counts the number of near taken branch instr=
uctions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xc0",
         "Unit": "cpu_atom"
@@ -340,7 +329,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_INST_RETIRED.INDIRECT Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xeb",
         "Unit": "cpu_atom"
@@ -350,7 +338,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
-        "PublicDescription": "Counts the number of near relative CALL bran=
ch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfd",
         "Unit": "cpu_atom"
@@ -361,7 +348,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.RETURN",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_INST_RETIRED.NEAR_RETURN Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xf7",
         "Unit": "cpu_atom"
@@ -372,7 +358,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_INST_RETIRED.COND_TAKEN Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfe",
         "Unit": "cpu_atom"
@@ -382,7 +367,7 @@
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
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
@@ -400,7 +385,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
-        "PublicDescription": "Counts the number of mispredicted JCC (Jump =
on Conditional Code) branch instructions retired. Available PDIST counters:=
 0",
         "SampleAfterValue": "200003",
         "UMask": "0x7e",
         "Unit": "cpu_atom"
@@ -430,7 +414,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
-        "PublicDescription": "Counts the number of mispredicted taken JCC =
(Jump on Conditional Code) branch instructions retired. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfe",
         "Unit": "cpu_atom"
@@ -450,7 +433,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
-        "PublicDescription": "Counts the number of mispredicted near indir=
ect JMP and near indirect CALL branch instructions retired. Available PDIST=
 counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xeb",
         "Unit": "cpu_atom"
@@ -470,7 +452,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
-        "PublicDescription": "Counts the number of mispredicted near indir=
ect CALL branch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfb",
         "Unit": "cpu_atom"
@@ -491,7 +472,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_MISP_RETIRED.INDIRECT_CALL Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfb",
         "Unit": "cpu_atom"
@@ -502,7 +482,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.JCC",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_MISP_RETIRED.COND Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x7e",
         "Unit": "cpu_atom"
@@ -512,7 +491,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
-        "PublicDescription": "Counts the number of mispredicted near taken=
 branch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x80",
         "Unit": "cpu_atom"
@@ -533,7 +511,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_MISP_RETIRED.INDIRECT Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xeb",
         "Unit": "cpu_atom"
@@ -553,7 +530,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RETURN",
-        "PublicDescription": "Counts the number of mispredicted near RET b=
ranch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xf7",
         "Unit": "cpu_atom"
@@ -564,7 +540,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 BR_MISP_RETIRED.COND_TAKEN Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfe",
         "Unit": "cpu_atom"
@@ -934,7 +909,7 @@
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
         "SampleAfterValue": "2000003",
         "Unit": "cpu_atom"
     },
@@ -1126,7 +1101,6 @@
         "Deprecated": "1",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.4K_ALIAS",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 LD_BLOCKS.ADDRESS_ALIAS Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_atom"
@@ -1136,7 +1110,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
-        "PublicDescription": "Counts the number of retired loads that are =
blocked because it initially appears to be store forward blocked, but subse=
quently is shown not to be blocked based on 4K alias check. Available PDIST=
 counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_atom"
@@ -1156,7 +1129,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DATA_UNKNOWN",
-        "PublicDescription": "Counts the number of retired loads that are =
blocked because its address exactly matches an older store whose data is no=
t ready. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1186,7 +1158,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
-        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions. Available PDIST counters: 0",
+        "PublicDescription": "Counts all software-prefetch load dispatches=
 that hit the fill buffer (FB) allocated for the software prefetch. It can =
also be incremented by some lock instructions. So it should only be used wi=
th profiling so that the locks can be excluded by ASM (Assembly File) inspe=
ction of the nearby instructions. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1306,7 +1278,7 @@
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
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1681,7 +1653,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "TOPDOWN_RETIRING.ALL",
-        "PublicDescription": "Counts the total number of consumed retireme=
nt slots. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "Unit": "cpu_atom"
     },
@@ -1933,7 +1904,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.ALL",
-        "PublicDescription": "Counts the total number of uops retired. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_atom"
     },
@@ -1963,7 +1933,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.IDIV",
-        "PublicDescription": "Counts the number of integer divide uops ret=
ired. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_atom"
@@ -1973,7 +1942,7 @@
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
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -2030,7 +1999,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.X87",
-        "PublicDescription": "Counts the number of x87 uops retired, inclu=
des those in MS flows. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_atom"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
index 3d15275eca61..ffbbd08acc68 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
@@ -266,7 +266,6 @@
         "Deprecated": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 MEM_UOPS_RETIRED.STLB_MISS Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x13",
         "Unit": "cpu_atom"
@@ -278,7 +277,6 @@
         "Deprecated": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 MEM_UOPS_RETIRED.STLB_MISS_LOADS Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x11",
         "Unit": "cpu_atom"
@@ -290,7 +288,6 @@
         "Deprecated": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_STORES",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 MEM_UOPS_RETIRED.STLB_MISS_STORES Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x12",
         "Unit": "cpu_atom"
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index bde2f32423a1..35c5a4088356 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,5 +1,5 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.29,alderlake,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.31,alderlake,core
 GenuineIntel-6-BE,v1.29,alderlaken,core
 GenuineIntel-6-C[56],v1.08,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
--=20
2.50.0.rc1.591.g9c95f17f64-goog

