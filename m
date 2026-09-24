Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D0E414A2A
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269485; cv=none; b=DtNhjvb/hrKK5d+RgqZA0XpzcGuexIsct2uX1fm0MPdNNQtrdBUC9xeZ+gLbqK3AR5UuAbLCU5iJTjJ0+eI9xI5YmxJFZtUQL4ctBrARprVPhgkUb3Cg3S5DCFNW/FFUZ3eil7AOIAlzQuFaoFeOB4RBXD6hYdS8E0rihYt24sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269485; c=relaxed/simple;
	bh=tbjeFDjKAjW/FGFKhKcot54ONRK5bHiwZtCeTV67wLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OP0MCLlLe6BT/z88AAmcEksTfagUA4uGNUjVoeECYTngkjMTD+lW7CX3wJwCJhaHGAbG0eaprAInNvctYFRRTK1gE8i33W1xaGLAvx4Q2DO6AnYmIcxps2gboaTaUxH2Q4vWA8w4M6dPOgxaOBjy5+KYL2xs9X/xPoSvFZRP+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ju79aJFg; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ju79aJFg"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso3808489eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269474; x=1790874274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1CeIle0aVnA/6O76wft1ZD0F21u20392EVd9zwl1WZg=;
        b=Ju79aJFg1xQYiummJzQI6cwl7iHRSe3tyhkb+6xCT/GowBJYVxcaT9KZZl6cGV8TI6
         pwFJWBC2DiLjlRYnxg60NteqxQQinn96L1Wdp9LGfiVlT6gn+OkjlzFNrvRWugjQOUWz
         +XqPooIP/oaWiEVRqPu/BCY97SS9mSziK+8hCrMmkQZTn/nc17gblh+igXQ6eeZSj0tr
         3+emMoint73MXttjLslRn3HTUgrl6KeRwf6LIZYi7eBdGDWDFp+tzNyIU+9IiGHEI4Kf
         7OYa8tgLg/iu/3knRJ2VuIyzFByf32kgfd+ib7IcBxeYUeWwPZI4vk0e97OkPnsZm/kA
         Lr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269474; x=1790874274;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1CeIle0aVnA/6O76wft1ZD0F21u20392EVd9zwl1WZg=;
        b=aekpJHsrRPTyDVA9vPC8iSHFg9s1SB3aR9oOAhWWcerI0LvYZ6Ilz6Kiw5/deQDS13
         wkPpzLKFmsXg17ygFngLf0nq1RKdlvT9Zd2gR8THKV/Be6vMjz75Abg/hEgyYjjvExaa
         kOWCOAQCG7PngjXLuQ73fRfQmdBoha7PxvkwGGRAantjyv74dSZ8Gxa1fpphxUlK70Ur
         V+v9DPs3aeRPAHaJLc3y2woViI7Gkn/p/YWqdO/E2OkQPIzQeTBfJno321kfeqGCACom
         WWR/8AvStyK7sT7tA4wA1+H86zKxxZNEdKxgElLGy2JrWr1ZmefyCOl2aebpswgXoN07
         VCyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQKAoVLnH0ta8/OgtBKVkMFZzg2LZBGOBqg2TqpycUtShpC6mfUoSGS3/AWVmRNIFdy8ixtFVPCrPSjLdjrnls@vger.kernel.org
X-Gm-Message-State: AFuF++mezvurOV0V81hcBtIDU8A4AnyYCPJcNIbmHNzmzt5TL8K/0/eL
	Kt7mTwqY0Vh7bH7BAzzRhWg1dEP4KMoqKv7pzCWKG/uksUB7B75+tDuCkM+jk8v6CdGa87EPbi3
	DL4cZmnI+Rw==
X-Received: from dlbrj21.prod.google.com ([2002:a05:7022:f415:b0:143:c6c8:ff2c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:205c:10b0:138:4e43:6399
 with SMTP id a92af1059eb24-1450404d25emr2662073c88.11.1790269472748; Thu, 24
 Sep 2026 10:04:32 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:35 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-16-irogers@google.com>
Subject: [PATCH v2 15/26] perf vendor events intel: Update novalake events
 from 1.00 to 1.04
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, edward.baker@intel.com, perry.taylor@intel.com, 
	eranian@google.com
Cc: adrian.hunter@intel.com, afaerber@suse.de, ctshao@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mani@kernel.org, mingo@redhat.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:

  https://github.com/intel/perfmon/commit/50afd00f84fb8c7bfa26a993a968982c1=
573e6d1
  https://github.com/intel/perfmon/commit/b576c542b68d377fa00ef4674715ea87a=
37c309c

The format encoding for the off module response MSRs, introduced in
this patch, is updated in:
https://lore.kernel.org/linux-perf-users/20260923015517.2665398-1-dapeng1.m=
i@linux.intel.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../pmu-events/arch/x86/novalake/cache.json   | 500 ++++++++++++++++-
 .../arch/x86/novalake/floating-point.json     | 423 +++++++++++++++
 .../arch/x86/novalake/frontend.json           | 147 ++++-
 .../pmu-events/arch/x86/novalake/memory.json  |  24 +
 .../pmu-events/arch/x86/novalake/other.json   | 213 ++++++++
 .../arch/x86/novalake/pipeline.json           | 508 +++++++++++++++++-
 .../arch/x86/novalake/virtual-memory.json     | 173 ++++++
 8 files changed, 1967 insertions(+), 23 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 15772f0b1cb1..f7c8c2aa476a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -26,6 +26,7 @@ GenuineIntel-6-BD,v1.26,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.23,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
+GenuineIntel-18-[13],v1.04,novalake,core
 GenuineIntel-6-(CC|D5|E5),v1.07,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
@@ -39,7 +40,6 @@ GenuineIntel-6-8[CD],v1.19,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
 GenuineIntel-6-25,v4,westmereep-sp,core
 GenuineIntel-6-2F,v4,westmereex,core
-GenuineIntel-18-[13],v1.00,novalake,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
diff --git a/tools/perf/pmu-events/arch/x86/novalake/cache.json b/tools/per=
f/pmu-events/arch/x86/novalake/cache.json
index 106c50fa6eb4..e8d416ffd421 100644
--- a/tools/perf/pmu-events/arch/x86/novalake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/novalake/cache.json
@@ -139,6 +139,15 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of demand and prefetch tran=
sactions that the External Queue (XQ) rejects due to a full or near full co=
ndition.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x30",
+        "EventName": "L2_REJECT_XQ.ANY",
+        "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition which likely indicates back pressure from the IDI link.  The XQ ma=
y reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses=
) and WOB (L2 write-back victims).",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_RQSTS.REFERENCES, L2_RQSTS.ANY]",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -239,6 +248,15 @@
         "UMask": "0x42",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "L2_REQUEST.RFO_HIT_XSNP_HIT_FWD",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.RFO_HIT_XSNP_HIT_FWD",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2002",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "RFO requests that miss L2 cache [This event i=
s alias to L2_RQSTS.RFO_MISS]",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -379,6 +397,16 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles when L1D is locked",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x42",
+        "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
+        "PublicDescription": "This event counts the number of cycles when =
the L1D is locked.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -409,6 +437,90 @@
         "UMask": "0x4f",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4f",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to L1 cache miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3f",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to L1 cache miss that hit an L2 in different module, L=
3, or MMIO, on the same CBB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.CACHE_HIT_LOCAL_CBB",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to L1 cache miss that also miss an L2 in different mod=
ule, L3, or MMIO, on the same CBB",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.CACHE_MISS_LOCAL_CBB",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3c",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to L1 cache miss. that hit the L2 cache within the sam=
e module.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.L2_HIT_LOCAL_MODULE",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to a demand load that hit the L2 cache within the same module.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to L1 cache miss. that miss the L2 cache within the sa=
me module.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.L2_MISS_LOCAL_MODULE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3e",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to L1cache miss that hit in any cache, L2 or L3 or MMI=
O, that is not on the same CBB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_CACHE_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a load miss at ret that hit in memory regions 0, 1,=
 2, 3, 4, 5, 6, 7.  Memory regions may be mapped to the local or remote soc=
kets.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.MEM_HIT_ANY_SOCKET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x30",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to L1 cache miss that hit in memory regions 0, 1, 2, 4=
, 5.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.MEM_HIT_LOCAL_SOCKET",
+        "PublicDescription": "Counts the number of unhalted cycles when th=
e core is stalled due to L1 cache miss that hit in memory regions 0,1,2,4,5=
",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts all retired load instructions.",
         "Counter": "0,1,2,3",
@@ -443,7 +555,7 @@
     },
     {
         "BriefDescription": "All retired memory instructions.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ANY",
@@ -530,27 +642,82 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB",
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L2_OTHER_MODULE.SAME=
_CBB.HIT.SNP_FWD [This event is alias to MEM_LOAD_L2_MISS_RETIRED.OTHER_MOD=
ULE_L2_HIT_SAME_CBB_SNP_FWD]",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.L2_OTHER_MODULE.SAME_CBB.HI=
T.SNP_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x8D000800000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L2_OTHER_MODULE.SAM=
E_CBB.HIT.SNP_FWD [This event is alias to MEM_LOAD_L2_MISS_RETIRED.OTHER_MO=
DULE_L2_HIT_SAME_CBB_SNP_FWD] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L2_OTHER_MODULE.SAME=
_CBB.HITM.SNP_FWD [This event is alias to MEM_LOAD_L2_MISS_RETIRED.OTHER_MO=
DULE_L2.SAME_CBB.HITM.SNP_FWD]",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.L2_OTHER_MODULE.SAME_CBB.HI=
TM.SNP_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x89000800000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L2_OTHER_MODULE.SAM=
E_CBB.HITM.SNP_FWD [This event is alias to MEM_LOAD_L2_MISS_RETIRED.OTHER_M=
ODULE_L2.SAME_CBB.HITM.SNP_FWD] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HITESF.SNP_HIT_NO_FWD]",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "Deprecated": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.HITESF.SNP_HIT_=
NO_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x45000400000001",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HITESF.SNP_HIT_NO_FWD] Available=
 PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HITESF.SNP_MISS]",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "Deprecated": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.HITESF.SNP_MISS=
",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x25000400000001",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HITESF.SNP_MISS] Available PDIST=
 counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB [Thi=
s event is alias to MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HIT]",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD6",
         "EventName": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB",
         "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
         "MSRValue": "0xED000400000001",
-        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB Ava=
ilable PDIST counters: 0,1",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB [Th=
is event is alias to MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HIT] Available PD=
IST counters: 0,1",
         "SampleAfterValue": "100021",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB_SNP_=
HIT_NO_FWD",
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HIT.SNP_HIT_NO_FWD]",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
+        "Deprecated": "1",
         "EventCode": "0xD6",
         "EventName": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB_SNP_HIT_NO_=
FWD",
         "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
         "MSRValue": "0x4D000400000001",
-        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB_SNP=
_HIT_NO_FWD Available PDIST counters: 0,1",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HIT.SNP_HIT_NO_FWD] Available PD=
IST counters: 0,1",
         "SampleAfterValue": "100021",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -568,6 +735,71 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HIT [Thi=
s event is alias to MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB]",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HIT",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xED000400000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HIT [Th=
is event is alias to MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB] Available PD=
IST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HIT.SNP_=
HIT_NO_FWD [This event is alias to MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB=
_SNP_HIT_NO_FWD]",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HIT.SNP_HIT_NO_=
FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x4D000400000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HIT.SNP=
_HIT_NO_FWD [This event is alias to MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CB=
B_SNP_HIT_NO_FWD] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HITESF.S=
NP_HIT_NO_FWD [This event is alias to MEM_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.=
HITESF.SNP_HIT_NO_FWD]",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HITESF.SNP_HIT_=
NO_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x45000400000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HITESF.=
SNP_HIT_NO_FWD [This event is alias to MEM_LOAD_L2_MISS_RETIRED.L3.SAME_CBB=
.HITESF.SNP_HIT_NO_FWD] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HITESF.S=
NP_MISS [This event is alias to MEM_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.HITESF=
.SNP_MISS]",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HITESF.SNP_MISS=
",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x25000400000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_SAME_CBB.HITESF.=
SNP_MISS [This event is alias to MEM_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.HITES=
F.SNP_MISS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_0",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_0",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5010000000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_0 Availa=
ble PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_1",
         "Counter": "0,1,2,3",
@@ -581,6 +813,34 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to MEM_LOAD_L2_MISS_RETIRED.L2_OTHER_MODULE.SAME_CBB.HITM.SNP_FWD]",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "Deprecated": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.OTHER_MODULE_L2.SAME_CBB.HI=
TM.SNP_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x89000800000001",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to MEM_LOAD_L2_MISS_RETIRED.L2_OTHER_MODULE.SAME_CBB.HITM.SNP_FWD] Avail=
able PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to MEM_LOAD_L2_MISS_RETIRED.L2_OTHER_MODULE.SAME_CBB.HIT.SNP_FWD]",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "Deprecated": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.OTHER_MODULE_L2_HIT_SAME_CB=
B_SNP_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x8D000800000001",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to MEM_LOAD_L2_MISS_RETIRED.L2_OTHER_MODULE.SAME_CBB.HIT.SNP_FWD] Availa=
ble PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Retired instructions with at least 1 uncachea=
ble load or lock.",
         "Counter": "0,1,2,3",
@@ -666,6 +926,117 @@
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
         "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources. Available PDIST counters: 0,1",
         "SampleAfterValue": "100021",
+        "UMask": "0x8000",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instruction with at least 1 load uop =
whose Data Source was: Hit in L2 cache that required a snoop to other core =
in DCM - data was forwarded from other core.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_XSNP_HIT_FWD",
+        "PublicDescription": "Retired instruction with at least 1 load uop=
 whose Data Source was: Hit in L2 cache that required a snoop to other core=
 in DCM - data was forwarded from other core. Available PDIST counters: 0,1=
",
+        "SampleAfterValue": "50021",
+        "UMask": "0x200",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instruction with at least 1 load uop =
whose Data Source was: Hit in L2 cache that required a snoop to other core =
in DCM which missed the other core and no data was forwarded.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_XSNP_MISS",
+        "PublicDescription": "Retired instruction with at least 1 load uop=
 whose Data Source was: Hit in L2 cache that required a snoop to other core=
 in DCM which missed the other core and no data was forwarded. Available PD=
IST counters: 0,1",
+        "SampleAfterValue": "50021",
+        "UMask": "0x80",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t the L1 data cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
+        "PublicDescription": "Counts the number of load ops retired that h=
it the L1 data cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss in the L1 data cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
+        "PublicDescription": "Counts the number of load ops retired that m=
iss in the L1 data cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
+        "PublicDescription": "Counts the number of load ops retired that h=
it in the L2 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
+        "PublicDescription": "Counts the number of load ops retired that m=
iss in the L2 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t an L2 in different module, L3, or MMIO, on the same CBB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_RETIRED_2.CACHE_HIT_LOCAL_CBB",
+        "PublicDescription": "Counts the number of load ops retired that h=
it an L2 in different module, L3, or MMIO, on the same CBB Available PDIST =
counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in memory regions 0, 1, 2, 4, 5.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_RETIRED_2.MEM_HIT_LOCAL_SOCKET",
+        "PublicDescription": "Counts the number of load ops retired that h=
it in memory regions 0,1,2,4,5 Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "MEM_STORE_L2_MISS_RETIRED.L2_OTHER_MODULE.SAM=
E_CBB.HITM.SNP_FWD [This event is alias to MEM_STORE_L2_MISS_RETIRED.OTHER_=
MODULE_L2.SAME_CBB.HITM.SNP_FWD]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x4F",
+        "EventName": "MEM_STORE_L2_MISS_RETIRED.L2_OTHER_MODULE.SAME_CBB.H=
ITM.SNP_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x89000800000002",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "MEM_STORE_L2_MISS_RETIRED.OTHER_MODULE_L2.SAM=
E_CBB.HITM.SNP_FWD [This event is alias to MEM_STORE_L2_MISS_RETIRED.L2_OTH=
ER_MODULE.SAME_CBB.HITM.SNP_FWD]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x4F",
+        "EventName": "MEM_STORE_L2_MISS_RETIRED.OTHER_MODULE_L2.SAME_CBB.H=
ITM.SNP_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x89000800000002",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
@@ -677,6 +1048,116 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of memory uops retired. A s=
ingle uop that performs both a load AND a store will be counted as 1, not 2=
 (e.g. ADD [mem], CONST).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL",
+        "PublicDescription": "Counts the number of memory uops retired.  A=
 single uop that performs both a load AND a store will be counted as 1, not=
 2 (e.g. ADD [mem], CONST) Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x83",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
+        "PublicDescription": "Counts the number of load ops retired. Avail=
able PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of store ops retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
+        "PublicDescription": "Counts the number of store ops retired. Avai=
lable PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that p=
erformed one or more locks.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
+        "PublicDescription": "Counts the number of load uops retired that =
performed one or more locks Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x21",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that=
 were splits.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT",
+        "PublicDescription": "Counts the number of memory uops retired tha=
t were splits. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x43",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired split load uops.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
+        "PublicDescription": "Counts the number of retired split load uops=
. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x41",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired split store uops=
.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
+        "PublicDescription": "Counts the number of retired split store uop=
s. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x42",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that=
 missed in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS",
+        "PublicDescription": "Counts the number of memory uops retired tha=
t missed in the second level TLB. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x13",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that m=
iss in the second Level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
+        "PublicDescription": "Counts the number of load uops retired that =
miss in the second Level TLB. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x11",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of store uops retired that =
miss in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
+        "PublicDescription": "Counts the number of store uops retired that=
 miss in the second level TLB. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x12",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Retired memory uops for any access",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -745,5 +1226,14 @@
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to an icache miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ICACHE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/novalake/floating-point.json b/=
tools/perf/pmu-events/arch/x86/novalake/floating-point.json
index 471a90f3670c..455f752a746d 100644
--- a/tools/perf/pmu-events/arch/x86/novalake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/novalake/floating-point.json
@@ -181,6 +181,24 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "FP_ARITH_INST_RETIRED.SCALAR_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_HALF",
+        "SampleAfterValue": "100003",
+        "UMask": "0x100",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of all Scalar Half-Precision FP arithm=
etic instructions(1) retired - regular and complex.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_HALF_WCOMPLEX",
+        "SampleAfterValue": "100003",
+        "UMask": "0x300",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts number of SSE/AVX computational scalar=
 single precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar single precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB=
 instructions count twice as they perform 2 calculations per element.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -238,6 +256,24 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.16_FLOPS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.16_FLOPS",
+        "SampleAfterValue": "100003",
+        "UMask": "0x880",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.1_FLOPS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.1_FLOPS",
+        "SampleAfterValue": "100003",
+        "UMask": "0x103",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 4 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perf=
orm 2 calculations per element.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -258,6 +294,24 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.2_FLOPS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.2_FLOPS",
+        "SampleAfterValue": "100003",
+        "UMask": "0x204",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.32_FLOPS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.32_FLOPS",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1000",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single and 256-bit packed double precision FP instructions retired; some =
instructions will count twice as noted below.  Each count represents 2 or/a=
nd 4 computation operations, 1 for each element.  Applies to SSE* and AVX* =
packed single precision and packed double precision FP instructions: ADD SU=
B HADD HSUB SUBADD MUL DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DP=
P and FM(N)ADD/SUB count twice as they perform 2 calculations per element."=
,
         "Counter": "0,1,2,3,4,5,6,7",
@@ -365,6 +419,375 @@
         "UMask": "0x10c0",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of retired packed 256 bit f=
loating point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.256B_PACKED",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5fe0",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired packed 512 bit f=
loating point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.512B_PACKED",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x9fe0",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the total number of retired floating p=
oint arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1fff",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the total number of retired floating p=
oint FMA arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.FMA",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3fff",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired packed floating =
point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.PACKED",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1fe0",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired packed 128 bit o=
r 256 bit double precision floating point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.PACKED_DP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1000",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired packed 128 bit o=
r 256 bit half precision floating point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.PACKED_HP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired packed 128 bit o=
r 256 bit half precision floating point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.PACKED_HP_CMPLX3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x100",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired packed 128 bit o=
r 256 bit half precision floating point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.PACKED_HP_CMPLX4",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x200",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired packed 128 bit o=
r 256 bit half precision floating point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.PACKED_HP_DOT_PROD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired packed 128 bit o=
r 256 bit single precision floating point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.PACKED_SP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x800",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired scalar 64 bit do=
uble precision floating point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.SCALAR_DP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired scalar 16 bit ha=
lf precision floating point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.SCALAR_HP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired scalar 16 bit ha=
lf precision floating point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.SCALAR_HP_CMPLX3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired scalar 16 bit ha=
lf precision floating point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.SCALAR_HP_CMPLX4",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired scalar 32 bit si=
ngle precision floating point arithmetic operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_RETIRED.SCALAR_SP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of packed 256 bit double precision instructions. Requires SW to u=
se a multiplier of 2.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.256B_PACKED_DP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5000",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of packed 256 bit half precision instructions. Requires SW to use=
 a multiplier of 8.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.256B_PACKED_HP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4040",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of packed 256 bit single precision instructions. Requires SW to u=
se a multiplier of 4.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.256B_PACKED_SP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4800",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of packed 512 bit double precision instructions. Requires SW to u=
se a multiplier of 2.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.512B_PACKED_DP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x9000",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of packed 512 bit half precision instructions. Requires SW to use=
 a multiplier of 8.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.512B_PACKED_HP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8040",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of packed 512 bit single precision instructions. Requires SW to u=
se a multiplier of 4.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.512B_PACKED_SP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8800",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of packed 128 bit or 256 bit double precision instructions. Requi=
res SW to use a multiplier of 2.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.PACKED_DP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1000",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of packed 128 bit or 256 bit half precision instructions. Require=
s SW to use a multiplier of 8.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.PACKED_HP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of packed 128 bit or 256 bit half precision complex instructions.=
 Requires SW to use a multiplier of 24.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.PACKED_HP_CMPLX3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x100",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of packed 128 bit or 256 bit half precision complex instructions.=
 Requires SW to use a multiplier of 32.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.PACKED_HP_CMPLX4",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x200",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of packed 128 bit or 256 bit half precision instructions. Require=
s SW to use a multiplier of 16.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.PACKED_HP_DOT_PROD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of packed 128 bit or 256 bit single precision instructions. Requi=
res SW to use a multiplier of 4.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.PACKED_SP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x800",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of scalar 64 bit double precision instructions. Requires no SW mu=
ltiplier.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.SCALAR_DP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of scalar 16 bit half precision instructions. Requires no SW mult=
iplier.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.SCALAR_HP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of scalar 16 bit half precision complex instructions. Requires SW=
 to use a multiplier of 3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.SCALAR_HP_CMPLX3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of scalar 16 bit half precision complex instructions. Requires SW=
 to use a multiplier of 4 .",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.SCALAR_HP_CMPLX4",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations of scalar 32 bit single precision instructions. Requires no SW mu=
ltiplier.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.SCALAR_SP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations that require a SW multiplier of 16.  A summation of all SW multip=
lied events is required in order to calculate total FLOPS.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.SW_16X",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations that require a SW multiplier of 1.  A summation of all SW multipl=
ied events is required in order to calculate total FLOPS.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.SW_1X",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x19",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations that require a SW multiplier of 24.  A summation of all SW multip=
lied events is required in order to calculate total FLOPS.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.SW_24X",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x100",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations that require a SW multiplier of 2.  A summation of all SW multipl=
ied events is required in order to calculate total FLOPS.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.SW_2X",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1000",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations that require a SW multiplier of 32.  A summation of all SW multip=
lied events is required in order to calculate total FLOPS.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.SW_32X",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x600",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations that require a SW multiplier of 3.  A summation of all SW multipl=
ied events is required in order to calculate total FLOPS.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.SW_3X",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations that require a SW multiplier of 4.  A summation of all SW multipl=
ied events is required in order to calculate total FLOPS.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.SW_4X",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x804",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired floating point o=
perations that require a SW multiplier of 8.  A summation of all SW multipl=
ied events is required in order to calculate total FLOPS.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_FLOPS_RETIRED.SW_8X",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of uops executed on all flo=
ating point ports.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/novalake/frontend.json b/tools/=
perf/pmu-events/arch/x86/novalake/frontend.json
index 7d1e62bb8803..941191874f19 100644
--- a/tools/perf/pmu-events/arch/x86/novalake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/novalake/frontend.json
@@ -84,6 +84,15 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged with having preceded with frontend bound behavior.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ALL",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged with having preceded with frontend bound behavior Available =
PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Retired ANT branches",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -108,6 +117,46 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t are tagged after a branch instruction causes bubbles/empty issue slots du=
e to a BAClear.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_DETECT",
+        "PublicDescription": "Counts the number of instruction retired tha=
t are tagged after a branch instruction causes bubbles/empty issue slots du=
e to a baclear Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t are tagged after a branch instruction causes bubbles /empty issue slots d=
ue to a BTClear.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_RESTEER",
+        "PublicDescription": "Counts the number of instruction retired tha=
t are tagged after a branch instruction causes bubbles /empty issue slots d=
ue to a btclear Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged following an ms flow due to the bubble/wasted issue slot from=
 exiting long MS flow.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.CISC",
+        "PublicDescription": "Counts the number of  instructions retired t=
hat were tagged following an ms flow due to the bubble/wasted issue slot fr=
om exiting long ms flow Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged every cycle the decoder is unable to send 3 uops per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DECODE",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged every cycle the decoder is unable to send 3 uops per cycle. =
Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Retired Instructions who experienced a critic=
al DSB miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -320,6 +369,26 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired tag=
ged after a wasted issue slot if none of the previous events occurred.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.OTHER",
+        "PublicDescription": "Counts the number of instruction retired tag=
ged after a wasted issue slot if none of the previous events occurred Avail=
able PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles/empty issue slots due=
 to a predecode wrong.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.PREDECODE",
+        "PublicDescription": "Counts the number of instruction retired tha=
t are tagged after a branch instruction causes bubbles/empty issue slots du=
e to a predecode wrong. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -344,6 +413,66 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were preceded by empty issue slots at allocation due to an Instruction L1=
 cache miss, that also missed the local L2 cache and hit an L2 in different=
 module, L3, or MMIO, on the same CBB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.CACHE_HIT_LOCAL_CBB",
+        "PublicDescription": "Counts the number of instructions retired th=
at were preceded by empty issue slots at allocation due to an Instruction L=
1 cache miss, that also missed the local L2 cache and hit an L2 in differen=
t module, L3, or MMIO, on the same CBB Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were preceded by empty issue slots at allocation due to an Instruction L1=
 cache miss,  that also missed the local L2 cache,  and hit in any cache, L=
2 or L3 or MMIO, that is not on the same CBB, or hit in Memory on the local=
 or remote socket.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.CACHE_MISS_LOCAL_CBB",
+        "PublicDescription": "Counts the number of instructions retired th=
at were preceded by empty issue slots at allocation due to an Instruction L=
1 cache miss,  that also missed the local L2 cache,  and hit in any cache, =
L2 or L3 or MMIO, that is not on the same CBB, or hit in Memory on the loca=
l or remote socket. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3c",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss that hit in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ITLB_STLB_HIT",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to IT=
LB miss that hit in the second level TLB. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were preceded by empty issue slots at allocation due to an ITLB miss that=
 also missed the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ITLB_STLB_MISS",
+        "PublicDescription": "Counts the number of instructions retired th=
at were preceded by empty issue slots at allocation due to an ITLB miss tha=
t also missed the second level TLB. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were preceded by empty issue slots at allocation due to an Instruction L1=
 cache miss, that missed in the L2 cache within the same module.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.L2_MISS_LOCAL_MODULE",
+        "PublicDescription": "Counts the number of instructions retired th=
at were preceded by empty issue slots at allocation due to an Instruction L=
1 cache miss, that missed in the L2 cache within the same module. Available=
 PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3e",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were preceded by empty issue slots at allocation due to an Instruction L1=
 cache miss that hit in memory regions 0, 1, 2, 4, 5.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.MEM_HIT_LOCAL_SOCKET",
+        "PublicDescription": "Counts the number of instructions retired th=
at were preceded by empty issue slots at allocation due to an Instruction L=
1 cache miss that hit in memory regions 0,1,2,4,5 Available PDIST counters:=
 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -423,7 +552,7 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_ANY",
@@ -434,7 +563,7 @@
     },
     {
         "BriefDescription": "Cycles DSB is delivering optimal number of Uo=
ps",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "CounterMask": "8",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
@@ -445,7 +574,7 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
@@ -455,7 +584,7 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering any Uop",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_ANY",
@@ -466,7 +595,7 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering optimal number of U=
ops",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "CounterMask": "8",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_OK",
@@ -477,7 +606,7 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
@@ -487,7 +616,7 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to IDQ w=
hile MS is busy",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES_ANY",
@@ -498,7 +627,7 @@
     },
     {
         "BriefDescription": "Number of switches from DSB or MITE to the MS=
",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -510,7 +639,7 @@
     },
     {
         "BriefDescription": "Uops initiated by MITE or Decode Stream Buffe=
r (DSB) and delivered to Instruction Decode Queue (IDQ) while Microcode Seq=
uencer (MS) is busy",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
         "PublicDescription": "Counts the number of uops initiated by MITE =
or Decode Stream Buffer (DSB) and delivered to Instruction Decode Queue (ID=
Q) while the Microcode Sequencer (MS) is busy. Counting includes uops that =
may 'bypass' the IDQ.",
diff --git a/tools/perf/pmu-events/arch/x86/novalake/memory.json b/tools/pe=
rf/pmu-events/arch/x86/novalake/memory.json
index 459f0b7a026f..618bcb7cb3e1 100644
--- a/tools/perf/pmu-events/arch/x86/novalake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/novalake/memory.json
@@ -295,5 +295,29 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_MISS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFF03F000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_MISS Available PDIST c=
ounters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L3_MISS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L3_MISS",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFF03F000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L3_MISS Available PDIST co=
unters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/novalake/other.json b/tools/per=
f/pmu-events/arch/x86/novalake/other.json
index 1c6ae1c9d4ff..19932b311486 100644
--- a/tools/perf/pmu-events/arch/x86/novalake/other.json
+++ b/tools/perf/pmu-events/arch/x86/novalake/other.json
@@ -58,6 +58,183 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "LBR record is inserted [This event is alias t=
o MISC_RETIRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe4",
+        "EventName": "LBR_INSERTS.ANY",
+        "PublicDescription": "LBR record is inserted [This event is alias =
to MISC_RETIRED.LBR_INSERTS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Any memory transaction that reached the SQ.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x21",
+        "EventName": "OFFMODULE_REQUESTS.ALL_REQUESTS",
+        "PublicDescription": "Counts memory transactions reached the super=
 queue including requests initiated by the core, all L3 prefetches, page wa=
lks, etc..",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Demand and prefetch data reads",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x21",
+        "EventName": "OFFMODULE_REQUESTS.DATA_RD",
+        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests sent to uncore",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x21",
+        "EventName": "OFFMODULE_REQUESTS.DEMAND_DATA_RD",
+        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFMODULE_REQUESTS_OUTSTANDING to deter=
mine average latency in the uncore.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when offmodule outstanding cacheable C=
ore Data Read transactions are present in SuperQueue (SQ), queue to uncore.=
",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFMODULE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "PublicDescription": "Counts cycles when offmodule outstanding cac=
heable Core Data Read transactions are present in the super queue. A transa=
ction is considered to be in the Offmodule outstanding state between L2 mis=
s and transaction completion sent to requestor (SQ de-allocation). See corr=
esponding Umask under OFFMODULE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles with offmodule outstanding Code Reads =
transactions in the SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFMODULE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CO=
DE_RD",
+        "PublicDescription": "Counts the number of offmodule outstanding C=
ode Reads transactions in the super queue every cycle. The 'Offmodule outst=
anding' state of the transaction lasts from the L2 miss until the sending t=
ransaction completion to requestor (SQ deallocation). See the corresponding=
 Umask under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles with offmodule outstanding demand rfo =
reads transactions in SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFMODULE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RF=
O",
+        "PublicDescription": "Counts the number of offmodule outstanding d=
emand rfo Reads transactions in the super queue every cycle. The 'Offmodule=
 outstanding' state of the transaction lasts from the L2 miss until the sen=
ding transaction completion to requestor (SQ deallocation). See the corresp=
onding Umask under OFFMODULE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Offmodule outstanding cacheable Core Data Rea=
d transactions in SuperQueue (SQ), queue to uncore",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFMODULE_REQUESTS_OUTSTANDING.DATA_RD",
+        "PublicDescription": "Counts the number of offmodule outstanding c=
acheable Core Data Read transactions in the super queue every cycle. A tran=
saction is considered to be in the Offmodule outstanding state between L2 m=
iss and transaction completion sent to requestor (SQ de-allocation). See co=
rresponding Umask under OFFMODULE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "For every cycle, increments by the number of =
outstanding demand data read requests pending.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFMODULE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
+        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.ANY_MEMORY",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.ANY_MEMORY",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5030000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.ANY_MEMORY Available PDIS=
T counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x4000000000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.ANY_RESPONSE Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_0",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.MEM_REGION_0",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5010000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_0 Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.MEM_REGION_1",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5020000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_1 Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.ANY_MEMORY",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.ANY_MEMORY",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5030000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.ANY_MEMORY Available PDIST=
 counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.ANY_RESPONSE",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.ANY_RESPONSE",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x4000000000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.ANY_RESPONSE Available PDI=
ST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OMR.STREAMING_WR.ANY_RESPONSE",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x4000000000000800",
+        "PublicDescription": "OMR.STREAMING_WR.ANY_RESPONSE Available PDIS=
T counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "number of port pushouts of integer ports (rea=
dy uop was delayed due to port being used by another uop) including integer=
 STD.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -67,6 +244,15 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "number of port pushouts of memory exec ports =
(ready uop was delayed due to port being used by another uop)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xab",
+        "EventName": "PORT_PUSHOUT.MEM_ADDRESS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "number of port pushouts of vector ports (read=
y uop was delayed due to port being used by another uop)",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -76,6 +262,24 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Number of integer uops scheduled for executio=
n (no cancel) including integer STD uops - ports with ready uops",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xaa",
+        "EventName": "PORT_READY.INTEGER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of memory AGU uops scheduled for execu=
tion (no cancel) - ports with ready uops",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xaa",
+        "EventName": "PORT_READY.MEM_ADDRESS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Number of vector uops scheduled for execution=
 (no cancel) including vec/fp STD uops- ports with ready uops",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -94,6 +298,15 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Alloc Stall cycles when stall is due to integ=
er stack resource and is not MEMORY_BOUND stall",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa9",
+        "EventName": "STALL_CORE_BOUND.INTEGER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Alloc Stall cycles when stall is due to MEM R=
S resource and is not MEMORY_BOUND stall",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/novalake/pipeline.json b/tools/=
perf/pmu-events/arch/x86/novalake/pipeline.json
index 998dd4cbc66a..8b2e1ed2331d 100644
--- a/tools/perf/pmu-events/arch/x86/novalake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/novalake/pipeline.json
@@ -1,4 +1,14 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles when any of the f=
loating point or integer dividers are active.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.DIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -10,6 +20,16 @@
         "UMask": "0x9",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of cycles when any of the i=
nteger dividers are active.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles when integer divide unit is busy execu=
ting divide or square root operations.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -76,6 +96,16 @@
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of conditional branch instr=
uctions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Conditional branch instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -126,6 +156,16 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of taken backward condition=
al branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN_BWD",
+        "PublicDescription": "Counts the number of taken backward conditio=
nal branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Taken backward conditional branch instruction=
s retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -136,6 +176,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of taken forward conditiona=
l branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
+        "PublicDescription": "Counts the number of taken forward condition=
al branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Taken forward conditional branch instructions=
 retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -146,6 +196,16 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and interrupt call and ret=
urn.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
+        "PublicDescription": "Counts the number of far branch instructions=
 retired, includes far jump, far call and return, and interrupt call and re=
turn. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x100",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Far branch instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -153,8 +213,19 @@
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PublicDescription": "Counts far branch instructions retired. Avai=
lable PDIST counters: 0,1",
         "SampleAfterValue": "100007",
+        "UMask": "0x100",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "PublicDescription": "Counts the number of near CALL branch instru=
ctions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x30",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Direct and indirect near call instructions re=
tired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -165,6 +236,16 @@
         "UMask": "0x30",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near direct CALL branch =
instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_DIRECT_CALL",
+        "PublicDescription": "Counts the number of near direct CALL branch=
 instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "near direct call instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -175,6 +256,16 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near direct JMP branch i=
nstructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_DIRECT_JMP",
+        "PublicDescription": "Counts the number of near direct JMP branch =
instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "near direct jump instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -185,6 +276,16 @@
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT",
+        "PublicDescription": "Counts the number of near indirect JMP and n=
ear indirect CALL branch instructions retired. Available PDIST counters: 0,=
1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Indirect near branch instructions retired (ex=
cluding returns)",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -195,6 +296,16 @@
         "UMask": "0x50",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT_CALL",
+        "PublicDescription": "Counts the number of near indirect CALL bran=
ch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Indirect near call instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -205,6 +316,16 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP branch=
 instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT_JMP",
+        "PublicDescription": "Counts the number of near indirect JMP branc=
h instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Indirect near jump instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -215,6 +336,26 @@
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP, near =
indirect CALL, and RET branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT_OR_RETURN",
+        "PublicDescription": "Counts the number of near indirect JMP, near=
 indirect CALL, and RET branch instructions retired. Available PDIST counte=
rs: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x58",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of near JMP branch instruct=
ions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_JMP",
+        "PublicDescription": "Counts the number of near JMP branch instruc=
tions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc0",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Indirect and Direct Relative near jump instru=
ctions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -225,6 +366,16 @@
         "UMask": "0xc0",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near RET branch instruct=
ions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "PublicDescription": "Counts the number of near RET branch instruc=
tions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Return instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -235,6 +386,16 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near taken branch instru=
ctions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "PublicDescription": "Counts the number of near taken branch instr=
uctions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xfb",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Taken branch instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -245,6 +406,16 @@
         "UMask": "0xfb",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the total number of taken branch instr=
uctions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.TAKEN",
+        "PublicDescription": "Counts the total number of taken branch inst=
ructions retired Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1fb",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -270,8 +441,19 @@
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_TPEBS",
         "PublicDescription": "All mispredicted branch instructions retired=
. This precise event may be used to get the misprediction cost via the Reti=
re_Latency field of PEBS. It fires on the instruction that immediately foll=
ows the mispredicted branch. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
+        "UMask": "0x8000",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted conditional=
 branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND",
+        "PublicDescription": "Counts the number of mispredicted conditiona=
l branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -282,6 +464,16 @@
         "UMask": "0x7",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted not taken c=
onditional branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
+        "PublicDescription": "Counts the number of mispredicted not taken =
conditional branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Mispredicted non-taken conditional branch ins=
tructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -302,6 +494,16 @@
         "UMask": "0x8004",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted taken condi=
tional branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PublicDescription": "Counts the number of mispredicted taken cond=
itional branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -312,6 +514,46 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted taken backw=
ard conditional branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_BWD",
+        "PublicDescription": "Counts the number of mispredicted taken back=
ward conditional branch instructions retired. Available PDIST counters: 0,1=
",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken backward.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_BWD",
+        "PublicDescription": "Counts taken backward conditional mispredict=
ed branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken backward. This precise event may be used to get t=
he misprediction cost via the Retire_Latency field of PEBS. It fires on the=
 instruction that immediately follows the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_BWD_TPEBS",
+        "PublicDescription": "number of branch instructions retired that w=
ere mispredicted and taken backward. This precise event may be used to get =
the misprediction cost via the Retire_Latency field of PEBS. It fires on th=
e instruction that immediately follows the mispredicted branch. Available P=
DIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8001",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted taken forwa=
rd conditional branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_FWD",
+        "PublicDescription": "Counts the number of mispredicted taken forw=
ard conditional branch instructions retired. Available PDIST counters: 0,1"=
,
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken forward.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -352,6 +594,16 @@
         "UMask": "0x8007",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT",
+        "PublicDescription": "Counts the number of mispredicted near indir=
ect JMP and near indirect CALL branch instructions retired. Available PDIST=
 counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Miss-predicted near indirect branch instructi=
ons retired (excluding returns)",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -362,6 +614,16 @@
         "UMask": "0x50",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT_CALL",
+        "PublicDescription": "Counts the number of mispredicted near indir=
ect CALL branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Mispredicted indirect CALL retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -382,6 +644,16 @@
         "UMask": "0x8010",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT_JMP",
+        "PublicDescription": "Counts the number of mispredicted near indir=
ect JMP branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Miss-predicted near indirect jump instruction=
s retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -402,6 +674,16 @@
         "UMask": "0x8040",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP, near indirect CALL, and RET branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT_OR_RETURN",
+        "PublicDescription": "Counts the number of mispredicted near indir=
ect JMP, near indirect CALL, and RET branch instructions retired. Available=
 PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x58",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Miss-predicted near indirect branch instructi=
ons retired (excluding returns)",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -412,6 +694,16 @@
         "UMask": "0x8050",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_RETURN",
+        "PublicDescription": "Counts the number of mispredicted near RET b=
ranch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -432,6 +724,16 @@
         "UMask": "0x8008",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near taken =
branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "PublicDescription": "Counts the number of mispredicted near taken=
 branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5b",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -710,7 +1012,7 @@
     },
     {
         "BriefDescription": "EXE_RETIRED.ANY",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xdf",
         "EventName": "EXE_RETIRED.ANY",
         "SampleAfterValue": "2000003",
@@ -719,7 +1021,7 @@
     },
     {
         "BriefDescription": "Retired conditional instructions (e.g. CMOV) =
where condition was false",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xdf",
         "EventName": "EXE_RETIRED.CMOV_NTAKEN",
         "SampleAfterValue": "2000003",
@@ -728,7 +1030,7 @@
     },
     {
         "BriefDescription": "Retired conditional instructions (e.g. CMOV) =
where condition was true",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xdf",
         "EventName": "EXE_RETIRED.CMOV_TAKEN",
         "SampleAfterValue": "2000003",
@@ -1413,15 +1715,25 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "LBR record is inserted",
+        "BriefDescription": "LBR record is inserted [This event is alias t=
o LBR_INSERTS.ANY]",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "LBR record is inserted Available PDIST count=
ers: 0,1",
+        "PublicDescription": "LBR record is inserted [This event is alias =
to LBR_INSERTS.ANY] Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Count micro branches that gets mispredicted",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe4",
+        "EventName": "MISC_RETIRED.UBR_MISP",
+        "PublicDescription": "Count micro branches that gets mispredicted =
Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of CLFLUSH, CLWB, and CLDEM=
OTE instructions retired. [This event is alias to MICROCODE_RETIRED.CL_INST=
]",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1595,6 +1907,34 @@
         "SampleAfterValue": "1000003",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to Fast Nukes such as Memory Orde=
ring Machine clears and MRN nukes.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not consumed by the backend due to Fast Nukes such as  Memory Or=
dering Machine clears and MRN nukes",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to Branch Mispredict.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to a machine clear (nuke).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.NUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls. [This event is alias to TOPDOWN_BE_BOUND.ALL_P=
]",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1604,6 +1944,15 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to due to certain allocation rest=
rictions.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls. [This event is alias to TOPDOWN_BE_BOUND.ALL]"=
,
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1613,6 +1962,54 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stall (sche=
duler not being able to accept another uop).  This could be caused by RSV f=
ull or load/store buffer block.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IEC and FPC RAT stalls - which=
 can be due to the FIQ and IEC reservation station stall (integer, FP and S=
IMD scheduler not being able to accept another uop).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not consumed by the backend due to IEC and FPC RAT stalls - whic=
h can be due to the FIQ and IEC reservation station stall (integer, FP and =
SIMD scheduler not being able to accept another uop. )",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to mrbl stall.  A marble refers t=
o a physical register file entry, also known as the physical destination (P=
DST).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REGISTER",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not consumed by the backend due to mrbl stall.  A 'marble' refer=
s to a physical register file entry, also known as the physical destination=
 (PDST).",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to ROB full.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IQ/JEU scoreboards or MS SCB."=
,
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not consumed by the backend due to iq/jeu scoreboards or ms scb"=
,
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of retiremen=
t slots not consumed due to front end stalls.",
         "Counter": "Fixed counter 5",
@@ -1630,6 +2027,80 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BAClear.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BTClear.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to MS.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.CISC",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to ms",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to decode stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.DECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to latency related stalls inclu=
ding BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x72",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to ITLB miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ITLB_MISS",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to itlb miss",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend that do not categorize into any oth=
er common frontend stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.OTHER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to predecode wrong.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of consumed =
retirement slots.",
         "Counter": "Fixed counter 6",
@@ -1650,7 +2121,7 @@
     },
     {
         "BriefDescription": "This event counts the number of not dec-by-al=
l uops decoded (any non dec-by-all uops) e.g. when a 2 uop instruction is d=
ecoded this events counts 2.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x76",
         "EventName": "UOPS_DECODED.HEAVY_INST_UOPS",
         "SampleAfterValue": "1000003",
@@ -1659,7 +2130,7 @@
     },
     {
         "BriefDescription": "Uops executed on INT EU ALU ports.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.ALU",
         "PublicDescription": "Number of ALU integer uops dispatch to execu=
tion.",
@@ -1669,7 +2140,7 @@
     },
     {
         "BriefDescription": "Uops executed on any INT EU ports",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.INT_EU_ALL",
         "PublicDescription": "Number of integer uops dispatched to executi=
on.",
@@ -1941,6 +2412,17 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "UOPS_RETIRED.NANO_CODE",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.NANO_CODE",
+        "PublicDescription": "UOPS_RETIRED.NANO_CODE Available PDIST count=
ers: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that are utilized by operations that eventually get retired (commi=
tted) by the processor pipeline. Usually, this event positively correlates =
with higher performance  for example, as measured by the instructions-per-c=
ycle metric.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1971,6 +2453,16 @@
         "EventName": "UOPS_RETIRED.X87",
         "PublicDescription": "Counts the number of x87 uops retired, inclu=
des those in ms flows Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
+        "UMask": "0x100",
         "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts number of vector uops dispatched on VE=
C0",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb4",
+        "EventName": "VEC_DISPATCHED.V0",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/novalake/virtual-memory.json b/=
tools/perf/pmu-events/arch/x86/novalake/virtual-memory.json
index 356a74434288..14bca6823b82 100644
--- a/tools/perf/pmu-events/arch/x86/novalake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/novalake/virtual-memory.json
@@ -8,6 +8,15 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of page walks due to loads =
that miss the PDE (Page Directory Entry) cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.PDE_CACHE_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to a demand load that did not start a page walk. A=
ccounts for all page sizes. Will result in a DTLB write from STLB.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -27,6 +36,24 @@
         "UMask": "0x320",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to a demand load that did not start a page walk. A=
ccount for 4k page size only. Will result in a DTLB write from STLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT_4K",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to a demand load that did not start a page walk. A=
ccount for large page sizes only. Will result in a DTLB write from STLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT_LGPG",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a demand load.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -38,6 +65,16 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to any page size.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to any page si=
ze. Includes page walks that page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -48,6 +85,16 @@
         "UMask": "0xe",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 1G page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
+        "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 1GB pages. =
Includes page walks that page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 1G page.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -58,6 +105,16 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 2M or 4M page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 2M or 4M pa=
ges. Includes page walks that page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 2M/4M page.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -117,6 +174,15 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts walks that miss the PDE_CACHE.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.PDE_CACHE_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to stores that did not start a page walk. Accounts=
 for all page sizes. Will result in a DTLB write from STLB.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -137,6 +203,24 @@
         "UMask": "0x320",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to stores that did not start a page walk. Account =
for 4k page size only. Will result in a DTLB write from STLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT_4K",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to stores that did not start a page walk. Account =
for large page sizes only. Will result in a DTLB write from STLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT_LGPG",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a store.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -148,6 +232,16 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to any page size.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to any page size.  Includes page walks =
that page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Store misses in all TLB levels causes a page =
walk that completes. (All page sizes)",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -158,6 +252,16 @@
         "UMask": "0xe",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 1G page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
+        "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 1G pages.  Includes page walks that =
page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 1G page.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -168,6 +272,16 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 2M or 4M page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 2M or 4M pages.  Includes page walks=
 that page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 2M/4M page.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -218,6 +332,16 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of times there was an ITLB =
miss and a new translation was filled into the ITLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x81",
+        "EventName": "ITLB.FILLS",
+        "PublicDescription": "Counts the number of times the machine was u=
nable to find a translation in the Instruction Translation Lookaside Buffer=
 (ITLB) and a new translation was filled into the ITLB. The event is specul=
ative in nature, but will not count translations (page walks) that are begu=
n and not finished, or translations that are finished but not filled into t=
he ITLB.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of page walks initiated by =
a instruction fetch that missed the first and second level TLBs.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -227,6 +351,15 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of page walks due to an ins=
truction fetch that miss the PDE (Page Directory Entry) cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.PDE_CACHE_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to an instruction fetch that did not start a page =
walk. Account for all pages sizes. Will result in an ITLB write from STLB."=
,
         "Counter": "0,1,2,3,4,5,6,7",
@@ -257,6 +390,16 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to any page size. Includes=
 page walks that page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -267,6 +410,26 @@
         "UMask": "0xe",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to a 1G page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_1G",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 1G pages.  Includes pag=
e walks that page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to a 2M or 4M page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 2M or 4M pages.  Includ=
es page walks that page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (2M/4M)",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -297,6 +460,16 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks outstanding f=
or iside in PMH every cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for iside in PMH every cycle.  A PMH page walk is outstanding from page wal=
k start till PMH becomes idle again (ready to serve next walk). Includes EP=
T-walk intervals.  Walks could be counted by edge detecting on this event, =
but would count restarted suspended walks.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of page walks outstanding for an outst=
anding code request in the PMH each cycle.",
         "Counter": "0,1,2,3,4,5,6,7",
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

