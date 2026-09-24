Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65D3C1412
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269443; cv=none; b=Qb/k/KtHLtg9/xi5mu32mCf0AOcr64A/TT8qd0jIEVocMYZAdzmAFNRtYr19jJ6t+c8Cy9s9C0rOqCfkfHvRQstPFoqQ3DlZoN5yUvf0h24FHJmBuVlLGZpXe17QKUjJYsMiD6YBptGV72hnfB2kgf75QR9/EUssK0/yVtgViFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269443; c=relaxed/simple;
	bh=fASlFs88RC50PCMAvHNVJ+6yau7XJ1K/7bEmTYvI9ZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gbNIf2o3m5WzoVk3sHHl/J4U83M4MAWvOcNRJLYQX2sqIv2PcOidAbKi+BROtxNIgvUhLfsFzVUV6hdy2ZVNM9lltp1ryITf3Xy+/NE6Y2gtUbq9MlXaZgcYtBMQQSEDI6OyzyGUcl8km+uvh09tUwpjvRA0yZit0/YTWgKAMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UkokQ2Qv; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UkokQ2Qv"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-144f706e063so1028460c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269440; x=1790874240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kcfc/gG72nL4NrMskhYTxVcUTH3LHf0qieM/kAC6wno=;
        b=UkokQ2QvOE50OzDWHq/huAg0UkHQZShPBaEuKzg1WVrC+q0//n+iwEEqGL7Vt/YpB4
         l/XXr260YeVf+uhx83GMnmVhYQy8/7VBDocFBT16CGeTh0Dd/1QXFkrCHbtFjVpD1MAI
         a4oI1BjdZL5bWxvO2BPqo6jMI3AHrq4nzTVpMSNc4zwD+2GnzITfxsd29LivJnBDGbby
         5YTo9wW1ruG6OZJm20PcIBnNJ+hgMmFnurXJl2IShQtUFPKrhFFM/tGN+yFjS1mDiNpO
         wMEus3S2iNdadYaWVe/91vaMRMqD/5cyqaGWvMYdo9Tyfc9OGZnkbRMpEdub0KCk9iLA
         o7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269440; x=1790874240;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kcfc/gG72nL4NrMskhYTxVcUTH3LHf0qieM/kAC6wno=;
        b=ISktBqhGMhPmAPkxd0ypnQv/VDjnKkpIvNOCoPp9mDa3fcwUAf8F5tMX3B4IoH2CkN
         tTWEfzORSz5dWc/+aRyGfhIHzvRSPjLtupHMf3EPsdSS0Bx1MyOo9KkXB7zZEkt2Ss3i
         izFinuoHRzxh94oMzxyPTu0Zji4RsKa48NbPyqLI4/L4bECdsNeW7mqYRj/G2cdlebwX
         VD3APWLQxuhQPbkoQ7TMpLnFQxE7W148iYPSgAzyUTTaBGKH/+P0aMU58W462IsElHKl
         MD7dUHL1FY8t+lsFIGRPQtKvbHsnYQ6eFoPMBX5y4bNbtQricACbTYFRSxbN4jE55bIK
         SlJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIWJlqNZ2Y1nFIEd8mGlas8GBo2DcC8ZdvJTEJ1T4PkV/OFxBXDqhIS3ckHsSKD0+UfapDYnTie8KIMMK8mYe9@vger.kernel.org
X-Gm-Message-State: AFuF++mvSvYVndWxwIIWGf3wmwt8Kv5tuq7kbhkppaW4u6Y7w+htRV/y
	43amiyCypBOnQb6ZOzrnDFaNe44c5Twyz0W14HlitXSlBgYO+Dr7MtoNu27tgUGlz20N1k7gz2l
	A6vZOiAhnXg==
X-Received: from dlev1.prod.google.com ([2002:a05:701b:4641:b0:143:9538:71e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4211:20b0:143:3769:c680
 with SMTP id a92af1059eb24-145040c4349mr2457855c88.25.1790269440047; Thu, 24
 Sep 2026 10:04:00 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:21 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-2-irogers@google.com>
Subject: [PATCH v2 01/26] perf vendor events intel: Update alderlake events
 from 1.40 to 1.41
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

  https://github.com/intel/perfmon/commit/5d7b37d5671a49c72abf735dc81d147c7=
776119c

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/alderlake/cache.json |  4 ++--
 .../perf/pmu-events/arch/x86/alderlake/memory.json  | 13 +++++++++++++
 tools/perf/pmu-events/arch/x86/alderlake/other.json | 10 ++++++++++
 .../pmu-events/arch/x86/alderlake/pipeline.json     |  6 +++---
 tools/perf/pmu-events/arch/x86/mapfile.csv          |  2 +-
 5 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/cache.json
index 6c09da7b69e8..b804fe0a4156 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ANY",
-        "PublicDescription": "Counts the number of (demand and L1 prefetch=
ers) core requests rejected by the L2 queue (L2Q) due to a full or nearly f=
ull condition, which likely indicates back pressure from L2Q.  It also coun=
ts requests that would have gone directly to the External Queue (XQ), but a=
re rejected due to a full or nearly full condition, indicating back pressur=
e from the IDI link.  The L2Q may also reject transactions  from a core to =
ensure fairness between cores, or to delay a cores dirty eviction when the =
address conflicts incoming external snoops.  (Note that L2 prefetcher reque=
sts that are dropped are not counted by this event).  Counts on a per core =
basis.",
+        "PublicDescription": "Counts the number of core requests (demand a=
nd L1 prefetchers) rejected by the L2 queue (L2Q) due to a full or nearly f=
ull condition, which likely indicates back pressure from L2Q. It also count=
s requests that would have gone directly to the External Queue (XQ) but are=
 rejected due to a full or nearly full condition, indicating back pressure =
from the IDI link. The L2Q may also reject transactions from a core to ensu=
re fairness between cores, or to delay a cores dirty eviction when the addr=
ess conflicts with incoming external snoops. (Note that L2 prefetcher reque=
sts that are dropped are not counted by this event). Counts on a per core b=
asis.",
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
@@ -135,7 +135,7 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_XQ.ANY",
-        "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition which likely indicates back pressure from the IDI link.  The XQ ma=
y reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses=
) and WOB (L2 write-back victims).",
+        "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition, which likely indicates back pressure from the IDI link. The XQ ma=
y reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses=
) and WOB (L2 write-back victims).",
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/alderlake/memory.json
index f482c06ac728..70e3c9a1f740 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -228,6 +228,19 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
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
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency.",
+        "SampleAfterValue": "23",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
         "Counter": "1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/other.json
index af46cde26b54..c530f05e09d6 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
@@ -55,6 +55,16 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Increments whenever there is an update to the=
 LBR array. [This event is alias to MISC_RETIRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcc",
+        "EventName": "LBR_INSERTS.ANY",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT. [This event is alias to MISC_RET=
IRED.LBR_INSERTS]",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that have any type of response.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index eb840066a5a7..1b9482b02bc5 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -988,7 +988,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary run to run and not match the architectural =
number of iterations (specified by RCX)",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary from run to run and not match the architect=
ural number of iterations (specified by RCX).",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1327,11 +1327,11 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Increments whenever there is an update to the=
 LBR array.",
+        "BriefDescription": "Increments whenever there is an update to the=
 LBR array. [This event is alias to LBR_INSERTS.ANY]",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcc",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT. [This event is alias to LBR_INSE=
RTS.ANY]",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index e5d90825041b..866b5fba7124 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,5 +1,5 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.40,alderlake,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.41,alderlake,core
 GenuineIntel-6-BE,v1.40,alderlaken,core
 GenuineIntel-6-C[56],v1.20,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

