Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0EA3FF1C0
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228297; cv=none; b=A2acnNdByG+j07OPmHV623VUY4A2L7K60yAF7vwE2LVmvum0JLYF/xFUulfMXrL7zcVCVLdjlEcP0gna5/y7oUAxlCRGF7PcpI58K1BY6VXZNU29eCt4ylEx0MtvxYTxNX8FTeqWZpXC5oxPPcCpej0ETVGJSjhEvYCeedSVZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228297; c=relaxed/simple;
	bh=mgHqw0aMH+6HR0CqOm7nIPLPhQH4ceBfWunzC+lJCvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jotdVbJ2WOlY8aw7tJ/NfdDHUq6RT8y4uJgSsP/b9d1etXAzBeqmOjlvMun6eOfimwAvACELcOE4ufMk2+ybIE53ylurm6Z4faKl4BlD7cZshxrahW8FSNeZD/yV3El24uaLaWiD/UPeTVeY498SC1VQBw6N0/bvCjpxkmu9yho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5GLsKjY; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5GLsKjY"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1416f32fe11so2296775c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790228289; x=1790833089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6NWUI6GW15IkHXpICDpWmf5urD4XS2/MCUoQqseXnA=;
        b=T5GLsKjYmc5Ja32KDLpHStpCUgElCfQYN0Tgh+uiKAftgnkF7lsdwrWCdg2STyocLg
         ntS7S3me2GHZoZBU0L2vUCILKS1gv/IgyoI58Iys6zzVnu/RxWxKMM1wFHgiiw95Gxq3
         WNwPPMTZ85nGkN9Ik5JEfsfWPhzpfztmwXnGfJHtPSf2Fs60JELpdqzm5lqYwGOJ2l/T
         zD0GXPyQIMuPwl4/LgTukUGZ8mUaSer1PC080M/3JZhB6iSVTs2a8R+leIKvi+tIU4Rh
         KDcI4WNHJl+i8DUWhCGrjBSWvl8kIit4FHzy9HOr3cj/+fW1nF682Wp8rtfOHyERFcbx
         KSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228289; x=1790833089;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e6NWUI6GW15IkHXpICDpWmf5urD4XS2/MCUoQqseXnA=;
        b=Ez0Gb5YXb+jJUI+UPMfmbgchgxZIFFEGdBdSpJBbFaSGF1jyfjENRE+SVfqINmlLui
         Vf8MJ7eMb2jbSERSP0Naa6fLs3fugdmTObXNTlTdalTGFE7bUSVC5a9g0670FqMxckq+
         jOWjBMknC37vVHQaS0wXJBmKWEfZn2Nu+cT3TqT/cgkVf6MfAlztQmAMI1wqI3/5f31u
         ynBcllO2wvUzafmIZU8m0LTtLZbjmc6n+CtCGGTlppxtk3rDuVXPY0sITEiyXLk0hHiP
         zYCVUOIq3sY9hD4YxN5TXONqDK6SwNeQrbIqVcTHseS3fvaWqT2Cq3dH+fy0TyO++IvD
         jLpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlPpOQSKjKaA+v0kE9jJ/8rmE/1OQ9I+anHGiIyGIlQF99SWcmYyCmwbgnc0E8VbT9Zjma/k5w2o/vBY1KRj5M@vger.kernel.org
X-Gm-Message-State: AFuF++kn492RR0C6o/qmqesb2iEsJTNwcYV8K885FnbR+sVtuje6F6UC
	TcU1TxiDm16NSvz1doDiHXeNy1uSxzO6V9uvlmOSbF7PfoIWb6fl5ur9qr2aUUomFNdkfH7+dNu
	ED8Nx86gGFA==
X-Received: from dlbek22.prod.google.com ([2002:a05:7022:c96:b0:144:bebe:a64])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4186:10b0:143:5c63:23bb
 with SMTP id a92af1059eb24-14503fd2aabmr1093019c88.11.1790228288745; Wed, 23
 Sep 2026 22:38:08 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:36:30 -0700
In-Reply-To: <20260924053645.3555041-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924053645.3555041-7-irogers@google.com>
Subject: [PATCH v1 06/21] perf vendor events intel: Update emeraldrapids
 events from 1.24 to 1.25
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:

  https://github.com/intel/perfmon/commit/0929815a4859319c27d2aa9099d394408=
29c5d7a

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/emeraldrapids/cache.json         |  2 +-
 .../arch/x86/emeraldrapids/memory.json        | 35 ++++++++++++
 .../arch/x86/emeraldrapids/other.json         |  9 ++++
 .../arch/x86/emeraldrapids/pipeline.json      | 10 ++--
 .../arch/x86/emeraldrapids/uncore-io.json     | 53 ++++++++++++++++++-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 6 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json b/tool=
s/perf/pmu-events/arch/x86/emeraldrapids/cache.json
index a44e1f027c1d..fc1be5b2bff2 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
@@ -1201,7 +1201,7 @@
         "EventCode": "0x2c",
         "EventName": "SQ_MISC.BUS_LOCK",
         "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
-        "SampleAfterValue": "100003",
+        "SampleAfterValue": "503",
         "UMask": "0x10"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json b/too=
ls/perf/pmu-events/arch/x86/emeraldrapids/memory.json
index 5e6c1f05c981..93effd1d69a2 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json
@@ -55,6 +55,17 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x9"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than any number of cycles."=
,
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY",
+        "MSRIndex": "0x3F6",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than any number of cycles.=
 Reported latency may be longer than just the memory latency.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 1024 cycles.",
         "Counter": "1,2,3,4,5,6,7",
@@ -91,6 +102,30 @@
         "SampleAfterValue": "20011",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 2 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2 cycles. Reported la=
tency may be longer than just the memory latency.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
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
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
         "Counter": "1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/other.json b/tool=
s/perf/pmu-events/arch/x86/emeraldrapids/other.json
index 21f49f609ed4..4ded9b0499c3 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/other.json
@@ -32,6 +32,15 @@
         "SampleAfterValue": "203",
         "UMask": "0x1"
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
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
index 1fa7957956df..035c01540cf7 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
@@ -200,11 +200,11 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
+        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
-        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired. Available PDIST counters: 0",
+        "PublicDescription": "This event counts the number of mispredicted=
 ret instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
     },
@@ -502,7 +502,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary from run to run and not match the architect=
ural number of iterations (specified by RCX).",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -723,11 +723,11 @@
         "UMask": "0x20"
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
         "UMask": "0x20"
     },
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json b/=
tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json
index ddb0f65307f4..d7a6ae230e61 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json
@@ -573,6 +573,19 @@
         "UMask": "0x1",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to this IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "PublicDescription": "Number of DWs (4 bytes) requested by the mai=
n die.  Includes all requests initiated by the main die, including reads an=
d writes. : x16 card plugged in to stack, Or x8 card plugged in to Lane 0/1=
, Or x4 card is plugged in to slot 0",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part0",
         "Counter": "2,3",
@@ -677,6 +690,19 @@
         "UMask": "0x8",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made to=
 this IIO by a different IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "PublicDescription": "Number of DWs (4 bytes) requested by the mai=
n die.  Includes all requests initiated by the main die, including reads an=
d writes. : x16 card plugged in to stack, Or x8 card plugged in to Lane 0/1=
, Or x4 card is plugged in to slot 0",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part0 by a different IIO unit",
         "Counter": "2,3",
@@ -1104,6 +1130,32 @@
         "UMask": "0x1",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 IIO any part to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "PublicDescription": "Number of DWs (4 bytes) the card requests of=
 the main die.    Includes all requests initiated by the Card, including re=
ads and writes. : x16 card plugged in to stack, Or x8 card plugged in to La=
ne 0/1, Or x4 card is plugged in to slot 0",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 any IIO part to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "PublicDescription": "Number of DWs (4 bytes) the card requests of=
 the main die.    Includes all requests initiated by the Card, including re=
ads and writes. : x16 card plugged in to stack, Or x8 card plugged in to La=
ne 0/1, Or x4 card is plugged in to slot 0",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
         "Counter": "0,1",
@@ -1827,7 +1879,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX_POSTED",
-        "Experimental": "1",
         "FCMask": "0x01",
         "PerPkg": "1",
         "PortMask": "0x00FF",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 27eaf934b925..3753ff64835e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -9,7 +9,7 @@ GenuineIntel-6-4F,v23,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.25,cascadelakex,core
 GenuineIntel-6-DD,v1.04,clearwaterforest,core
 GenuineIntel-6-9[6C],v1.05,elkhartlake,core
-GenuineIntel-6-CF,v1.24,emeraldrapids,core
+GenuineIntel-6-CF,v1.25,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.13,grandridge,core
--=20
2.56.0.rc1.310.g51773c2048-goog

