Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091B414DE0
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269460; cv=none; b=Vmx8fKOMjnIHJFWYBE5La1vlgBsyrzCXeqJBABH0zvwccWawj9bHvwxB6YUkrIw1EvboIq9MXRCXfVE4/9oqgQ/G/ubin+7LJhEML2zy36Sz/ccbjuh7EARcngzW/Xvfifa3bec9hrbBwYLYn7AORfz9FLlrRivFiHg6YU11z5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269460; c=relaxed/simple;
	bh=PH/MK75mh9EoGDiRTj6r7NBtQYqEEt1b45imvPHB0TQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gUlOxtOvlqW5VrmCXFC3zj0D9h7Q0WeLz+kX4lQSKKPRFLv8vAuiquT1cSh95hkJZlErtgTBMXP/s5DwbVs6uw4A1DV1DTvhAnonncN+Hn1TFbAaykkJYN67lFgHeTKzvVk22/uSbgQ2u9Yoe4PVeMdb6E9XXD5XZ4vcjzcjI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxMCK8NP; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxMCK8NP"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-313d1015161so881584eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269456; x=1790874256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GfWTVgSIJlb1FgS8OnOV/UO7fQGgzevTJ3j+SCzXphI=;
        b=dxMCK8NPmrEacVdN5gUZo2VhPUuhYyBpaSG1F18CNoXmssIzawapzI+nPSCLjm8ArA
         oFtglSdvkm+kil26rydP4nxhyOsxw1FJ4Ugc4PVmXL8Mll1SCjiyOzjjOmbF3X69lFQF
         cQbCOsbtciSfDXeD+8WCjOimUb3rWUJnB30VWxwDtv8VK0gzlfoIxPu0imZ5gb0I9AnK
         KeWMAJfCJ2udgsfa1KKnFZWj7SJuBn0ymD0aVvdJGz3/Jz1bDezWY6Tqf5ezjBgEp5r4
         qJINuIJozPTDo/FiLBGziJFp0YEkWmxHjUxe5LeuZsAs7KDY2iI+H8cBj5k1hEWyW3Hw
         H41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269456; x=1790874256;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GfWTVgSIJlb1FgS8OnOV/UO7fQGgzevTJ3j+SCzXphI=;
        b=n6ibi/VB4Iqcyb+mkV62WvI9ZjbauNHj1wPXGt8SWm/FqUZ0elxp/lFEtiJW7aEP18
         UEb62Xk4cda3xJCUNKlnGWQGBBPPXVu1gqmGisBCRcPWBPa0SDvOSjEu/R8Lw8Nk0jkX
         uijAArdljHQeaFUw020gZSE0PFhyXBpMNCapyXec2U0FeNkGQZYUj9Jj3mxQrfau8Q7w
         fHA/pgiVXW2RCuFbHCbkEsaWftyqzwcBX+h1UU/xw4Xxj2nWggS5DxkUDQWR2UB43VgL
         UAbziQmUyyYqvYMZV7RJ0vH1fru7arqwRCm0m0vnIh7nkC1QN4C3VJmT9apjzYaYY5LF
         681g==
X-Forwarded-Encrypted: i=1; AKwUvBzxcE83NxpNTDMvk0DR0Jly3qgF45NS/RxfX3z6ShS+iCCjZseMAJvl/CG8B+iSA6mJ7oDBKjLHcrNpd46pZESw@vger.kernel.org
X-Gm-Message-State: AFuF++mQfbHCzBWS52Kdkt6O2qLnHi78Nlwe/ZriTLhXGrtLd/oxzHmX
	Jx6SFpgfafrlk0vJIe6nHbIKBSXR6FI7JIUSuVx7Q7npLbmWxp3v0XH53F/i0kWWDJe56zaQubg
	VAQ59/P0rOA==
X-Received: from dlx15.prod.google.com ([2002:a05:7022:8f:b0:144:e53d:6fa6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:818e:b0:327:affc:b506
 with SMTP id 5a478bee46e88-34004e839e1mr3541996eec.15.1790269456065; Thu, 24
 Sep 2026 10:04:16 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:27 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-8-irogers@google.com>
Subject: [PATCH v2 07/26] perf vendor events intel: Update graniterapids
 events from 1.20 to 1.21
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

  https://github.com/intel/perfmon/commit/8732d043b432e9d04086a07feb23d9df7=
0a10f17

Fix wrong encoding of UMaskExt.

Fixes: 917f63ad7580 ("perf vendor events: Update graniterapids events and a=
dd counter information")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/graniterapids/other.json  |  9 +++++++++
 .../arch/x86/graniterapids/pipeline.json          |  6 +++---
 .../arch/x86/graniterapids/uncore-cache.json      | 15 +++++++++++++++
 .../x86/graniterapids/uncore-interconnect.json    |  2 ++
 .../arch/x86/graniterapids/uncore-io.json         | 12 ++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv        |  2 +-
 6 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/other.json b/tool=
s/perf/pmu-events/arch/x86/graniterapids/other.json
index c0747750b1a8..9173b9e3df9a 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/other.json
@@ -41,6 +41,15 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
index afc77bdeb600..e7be30ceb46d 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
@@ -559,7 +559,7 @@
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
         "UMask": "0x8"
     },
@@ -780,11 +780,11 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json=
 b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
index 721fc42797b1..899f4534db74 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
@@ -664,6 +664,16 @@
         "UMask": "0x10",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_PIPE_REJECT2.ANYQ_TOPA_MATCH",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_CHA_PIPE_REJECT2.ANYQ_TOPA_MATCH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20007f",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "UNC_CHA_REMOTE_SF.ALLOC_EXCLUSIVE",
         "Counter": "0,1,2,3",
@@ -701,6 +711,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.DIRBACKED_ONLY",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x4000",
         "Unit": "CHA"
     },
     {
@@ -730,6 +741,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.INCLUSIVE_ONLY",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -748,6 +760,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.UPDATE_EXCLUSIVE",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -767,6 +780,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.VICTIM_EXCLUSIVE",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -776,6 +790,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.VICTIM_SHARED",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconne=
ct.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.=
json
index 9f0c4c7198b0..4dbf9b8481cd 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
@@ -513,6 +513,7 @@
         "EventName": "UNC_B2CMI_IMC_WRITES.NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x300",
         "Unit": "B2CMI"
     },
     {
@@ -522,6 +523,7 @@
         "EventName": "UNC_B2CMI_IMC_WRITES.NI_MISS",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x500",
         "Unit": "B2CMI"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json b/=
tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
index 2ea2637df3fb..0e56bbed4d65 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
@@ -652,6 +652,18 @@
         "UMask": "0x1",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
         "Counter": "0,1",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 3753ff64835e..3e9a86ca18ac 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-CF,v1.25,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.13,grandridge,core
-GenuineIntel-6-A[DE],v1.20,graniterapids,core
+GenuineIntel-6-A[DE],v1.21,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.24,icelake,core
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

