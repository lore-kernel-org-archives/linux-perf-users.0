Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1030FC06
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821269; cv=none; b=FR6GbOzGptYb5MNLEDs4QKh70ld43z9r02D+FnPfHSx1kU7I76wXhg7NJ/ByW9+tGJCVAPkuqHMFut7ouSst31vsEKIUTQ1Y6wox875p49LwwE+oYZWqBMQvvkYS7et1l7a0Qem9zHpQoSTjZczIKxw2LBZW6VIFsIX4DGQsW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821269; c=relaxed/simple;
	bh=L5mClrOxM1Vi7xus9bb5BTll0P5eDBA1XM0N57HN+OA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WRUbS0J5iVk4qCAAZK1zkgcy/Smtr5qUXiDQoEyV16Q5cMKHBMmT1gNSkCJWpbxLGTr97porVj1tJi2pfTm6nNFeYYXg0A54zykND0Y9EPGRDpCFpRywH/uq3NBeUSZqt0g7fd7pK66zUzx9DSkHib2Z1f0CRWjktHZvNPFQvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PwR8eARm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwR8eARm"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-268141f759aso12366365ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821267; x=1759426067; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZYU2qERiWlNmtHWP5xSPxWRl4VlPcT4exceZasu0ZA=;
        b=PwR8eARmny3vfbULBjORgySxhyZzxNJ3CDbIex7w71SRwttiD95lk1ArfLaHHaXAS3
         r6/GRAGy/pa2/wXP9Yhg2InjErvv9IM40qePr5Uhl4O+6Ye+0qhd12t3JaiDvx8QW8mK
         l2T0XJPpfYJDGevW3PQ1oUhX+RmMahSqqhDDNTXIk5nst0FVLkvpicdkldd7VsbolS43
         y8PjDZ1Vh4bO9LtWY5ZoIWuCGnkJBbLZTbYQAULV4lrjZ98uj6F65sEKXlJlOcmwq/P4
         F4vHZfnQhic48OmOvV2p/eYnIFYZMd29NNmk3dMrq7LhCH22jwgWPZw1/FmF+B1u0Imm
         4MbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821267; x=1759426067;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iZYU2qERiWlNmtHWP5xSPxWRl4VlPcT4exceZasu0ZA=;
        b=h6qJWixO7P/KOKW9yA2drMSYG/0icCHioVCr6ZCyFV+xWAUq9Qn6Eio3z1rgXDnrLK
         Yl61y5E1JdRxMnpEMGouCHK9DTnpgrycIFENFrz3dloFBVm/zS5is4PkXHIN/Qw8DsQR
         +Q5zcW5lbX0gceTfXVAcdmxBFMMcfq6GAREZeTSJ3P1dGeVInbhouR0quIfQWtzqfcr/
         Zuw1xqgfETTATbbhuiwQWTlsGQMH/iiVEP8vEHImv1ckL6S97pOpln6fXHbhZw3zVTKS
         RifHKczMT6bV5Pk4u9PuoyecHrOCiuEUV6ZPnfeRRrl32/DSeM8EWAARWQ3qiLeJRljv
         kHnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSnWChWZeKIzomLxLWAjrFYUryqR7rWVlmgfpsLi0FFXk45MyDvOIb+0dsC7PBlGQRADwIYzXTHuSsqi+LhJC1@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDGMNTqmS5c/d+E7UHx2WwY7fhwu2X0oyByZPnKmRTQG9wdIv
	rmZ9g7oiZVn4+akmVLk79xzzXsg+tcYK2olKROs/bdLddH3t2IpzwYbQjKql2NghG4AJcjj3bDk
	Z7MGroixbhQ==
X-Google-Smtp-Source: AGHT+IENpfvrZUimMwyOhITQIW6b26XFKtSxuwnxjMTO0VHSW69GaLOsSFlP1NTHt4Y6kbwT61KPf+EAskAJ
X-Received: from plhq9.prod.google.com ([2002:a17:903:11c9:b0:26a:e046:7605])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a2d:b0:24b:11c8:2d05
 with SMTP id d9443c01a7336-27ed4a4bbaamr45048465ad.45.1758821267275; Thu, 25
 Sep 2025 10:27:47 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:27:29 -0700
In-Reply-To: <20250925172736.960368-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172736.960368-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172736.960368-4-irogers@google.com>
Subject: [PATCH v2 03/10] perf vendor events intel: Update emeraldrapids
 events to v1.20
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update emeraldrapids events to v1.20 released in:
https://github.com/intel/perfmon/commit/868b433955f3e94126420ee9374b9e0a6ce=
2d83e
https://github.com/intel/perfmon/commit/43681e2817a960d06c5b8870cc6d3e5b7b6=
feeb9

Also adds cpu_cstate_c0 and cpu_cstate_c6 metrics.

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/emeraldrapids/cache.json         | 63 +++++++++++++++++++
 .../arch/x86/emeraldrapids/emr-metrics.json   | 12 ++++
 .../arch/x86/emeraldrapids/uncore-cache.json  | 11 ++++
 .../arch/x86/emeraldrapids/uncore-memory.json | 22 +++++++
 .../arch/x86/emeraldrapids/uncore-power.json  |  2 -
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 6 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json b/tool=
s/perf/pmu-events/arch/x86/emeraldrapids/cache.json
index e96f938587bb..26568e4b77f7 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
@@ -1,4 +1,67 @@
 [
+    {
+        "BriefDescription": "Hit snoop reply with data, line invalidated."=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.I_FWD_FE",
+        "PublicDescription": "Counts responses to snoops indicating the li=
ne will now be (I)nvalidated: removed from this core's cache, after the dat=
a is forwarded back to the requestor and indicating the data was found unmo=
dified in the (FE) Forward or Exclusive State in this cores caches cache.  =
A single snoop response from the core counts on all hyperthreads of the cor=
e.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "HitM snoop reply with data, line invalidated.=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.I_FWD_M",
+        "PublicDescription": "Counts responses to snoops indicating the li=
ne will now be (I)nvalidated: removed from this core's caches, after the da=
ta is forwarded back to the requestor, and indicating the data was found mo=
dified(M) in this cores caches cache (aka HitM response).  A single snoop r=
esponse from the core counts on all hyperthreads of the core.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Hit snoop reply without sending the data, lin=
e invalidated.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.I_HIT_FSE",
+        "PublicDescription": "Counts responses to snoops indicating the li=
ne will now be (I)nvalidated in this core's caches without forwarded back t=
o the requestor. The line was in Forward, Shared or Exclusive (FSE) state i=
n this cores caches.  A single snoop response from the core counts on all h=
yperthreads of the core.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Line not found snoop reply",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.MISS",
+        "PublicDescription": "Counts responses to snoops indicating that t=
he data was not found (IHitI) in this core's caches. A single snoop respons=
e from the core counts on all hyperthreads of the Core.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Hit snoop reply with data, line kept in Share=
d state.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.S_FWD_FE",
+        "PublicDescription": "Counts responses to snoops indicating the li=
ne may be kept on this core in the (S)hared state, after the data is forwar=
ded back to the requestor, initially the data was found in the cache in the=
 (FS) Forward or Shared state.  A single snoop response from the core count=
s on all hyperthreads of the core.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "HitM snoop reply with data, line kept in Shar=
ed state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.S_FWD_M",
+        "PublicDescription": "Counts responses to snoops indicating the li=
ne may be kept on this core in the (S)hared state, after the data is forwar=
ded back to the requestor, initially the data was found in the cache in the=
 (M)odified state.  A single snoop response from the core counts on all hyp=
erthreads of the core.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Hit snoop reply without sending the data, lin=
e kept in Shared state.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.S_HIT_FSE",
+        "PublicDescription": "Counts responses to snoops indicating the li=
ne was kept on this core in the (S)hared state, and that the data was found=
 unmodified but not forwarded back to the requestor, initially the data was=
 found in the cache in the (FSE) Forward, Shared state or Exclusive state. =
 A single snoop response from the core counts on all hyperthreads of the co=
re.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "L1D.HWPF_MISS",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json =
b/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
index af0a7dd81e93..433ae5f50704 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
@@ -39,6 +39,18 @@
         "MetricName": "cpi",
         "ScaleUnit": "1per_instr"
     },
+    {
+        "BriefDescription": "The average number of cores that are in cstat=
e C0 as observed by the power control unit (PCU)",
+        "MetricExpr": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C0 / UNC_P_CLOCKT=
ICKS * #num_packages",
+        "MetricGroup": "cpu_cstate",
+        "MetricName": "cpu_cstate_c0"
+    },
+    {
+        "BriefDescription": "The average number of cores are in cstate C6 =
as observed by the power control unit (PCU)",
+        "MetricExpr": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C6 / UNC_P_CLOCKT=
ICKS * #num_packages",
+        "MetricGroup": "cpu_cstate",
+        "MetricName": "cpu_cstate_c6"
+    },
     {
         "BriefDescription": "CPU operating frequency (in GHz)",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC =
* #SYSTEM_TSC_FREQ / 1e9",
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json=
 b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
index f453202d80c2..92cf47967f0b 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
@@ -311,6 +311,17 @@
         "UMask": "0x2",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Remote",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xaf",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_NONLOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Distress signal asserted : DPT Remote : Coun=
ts the number of cycles either the local or incoming distress signals are a=
sserted. : Dynamic Prefetch Throttle received by this tile",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "Egress Blocking due to Ordering requirements =
: Down",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.jso=
n b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.json
index 90f61c9511fc..30044177ccf8 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.json
@@ -3129,6 +3129,28 @@
         "PublicDescription": "Clock-Enabled Self-Refresh : Counts the numb=
er of cycles when the iMC is in self-refresh and the iMC still has a clock.=
  This happens in some package C-states.  For example, the PCU may ask the =
iMC to enter self-refresh even though some of the cores are still processin=
g.  One use of this is for Monroe technology.  Self-refresh is required dur=
ing package C3 and C6, but there is no clock in the iMC at this time, so it=
 is not possible to count these cases.",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Throttle Cycles for Rank 0 : Counts the numb=
er of cycles while the iMC is being throttled by either thermal constraints=
 or by the PCU throttling.  It is not possible to distinguish between the t=
wo.  This can be filtered by rank.  If multiple ranks are selected and are =
being throttled at the same time, the counter will only increment by 1. : T=
hermal throttling is performed per DIMM.  We support 3 DIMMs per channel.  =
This ID allows us to filter by ID.",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Throttle Cycles for Rank 0 : Counts the numb=
er of cycles while the iMC is being throttled by either thermal constraints=
 or by the PCU throttling.  It is not possible to distinguish between the t=
wo.  This can be filtered by rank.  If multiple ranks are selected and are =
being throttled at the same time, the counter will only increment by 1.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Precharge due to read, write, underfill, or P=
GT.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-power.json=
 b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-power.json
index 9482ddaea4d1..71c35b165a3e 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-power.json
@@ -178,7 +178,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C0",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of cores in C0 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
         "Unit": "PCU"
@@ -198,7 +197,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C6",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of cores in C6 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
         "Unit": "PCU"
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 8daaa8f40b66..dec7bdd770cf 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -9,7 +9,7 @@ GenuineIntel-6-4F,v23,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.25,cascadelakex,core
 GenuineIntel-6-DD,v1.00,clearwaterforest,core
 GenuineIntel-6-9[6C],v1.05,elkhartlake,core
-GenuineIntel-6-CF,v1.16,emeraldrapids,core
+GenuineIntel-6-CF,v1.20,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.09,grandridge,core
--=20
2.51.0.536.g15c5d4f767-goog

