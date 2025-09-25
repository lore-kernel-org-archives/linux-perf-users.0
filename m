Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F3311941
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821275; cv=none; b=tmUn3aNjW4S4c4TON7s4yJSQSp1cyqMGeHWLSSZE2YRYbUrT3/RlPG05YNTigNQ1cSiBDXeOvV23yamb3M1FSwfGsecRYU+TijsCY9HY7YIko6bdMsYuJALWK9speYMbThq62mYabsFTgROcQE/fTOjSw5OBn9qQ1uWGr+Xa6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821275; c=relaxed/simple;
	bh=mEgFNOStWmEmyXhnJ8RKIm4BeEquT63KcquoDwTCPiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fjt14WRFOAcueCyCvrGqqkPC0wdScgwKNgB8xe7JU5UzTVLmFeVptGi2UP2rf+RRc96E3qtzc3GiQU92/qssa29hp4/rkl+lmZBIQ7wLOF/EhX0gJBC4c47PYVQVxqZyKACb/7oyDvMUEALuPv/dm6k7moeCZv/x7M1Re7ye8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRTBlxqc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRTBlxqc"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-78105c10afdso864701b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821271; x=1759426071; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iNpj5ZEX41ukRwMbAhbju3xW1pEqusQTijwhwtvDXoA=;
        b=NRTBlxqcuRC+p66tT9tkjyqBdQCrEKVUU0GrIEjKmWhD8MhRkfOvndQbo1lO2pf+Lg
         2Qq1aP/hCje7giJ0HWaZPowjoSCOlCwCNnTtElMfKEf3M3UQRhYTtYbmy0tacIHgUH0S
         IKlAb9QpJ9VEciXANC//ESU2IhafDN/RgkG3ygQv5RVKw04lMNCFN0YZz7/BiVfXgIhu
         wNczgAHuHLUxq43Ej2PzlIW7SMyeYStJSctn7j8szOmWIWS68IW3NQAKPlx52Eg5MlBc
         cdXukBSATvcpi8K2HAGSAz4x9ZOpBIb1NXD+R/GTV49s45KwNIzKIr7ArZ8e08gLPhIp
         PSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821271; x=1759426071;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNpj5ZEX41ukRwMbAhbju3xW1pEqusQTijwhwtvDXoA=;
        b=TDYFJSfChwo6PVf0IvCRjtlGn/ViZNmz1XMuPjWh/ydflmShRFEb1BHhDeW+SCnDKG
         JyVPBhQ+Gv3APXFppxkID2dQQR3pQ1O7BZrCpmrd6hjldENoGm3/F9XCpBDFXPrdhVps
         TKvpclTQh8X59FIyeE9fCyHlOULINRgfN7DnxTk4+KnlkzTPrWBC3dZGCOwHYjjrnsxW
         XPUUZfCwKC0N8xsG0317SJqpAr+CspdmsrbZ3CIRP79r5GH1n5cR3kO5GkwLWxyqjOK7
         x9z5fM4xg5SpOOD4riOzi109P/3P5gDY/aUMjQAKk2bCDfm7lOwmh1Ra+1XV8HYWSvTC
         5Svw==
X-Forwarded-Encrypted: i=1; AJvYcCU7WQXk58fR/uyrakOUz89h/xbCquKKRSPUT54ytQTow3C7Ure1SfFFrzR8A3lrhkiFsStwPYJ8EuZxbI0v1mez@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmbZUFjl3MmFC/LD7ehI14Dvh5ZeQjj6tUVCiq1v4REE+Tz9D
	Rr4llaRd0mXePs1abIh6Ytt3EsxyAx3kJCSIIPMHqf2iJOuscK2yPbZ3h14lqqdeiWrhk17I2i2
	LrJs3FXlzug==
X-Google-Smtp-Source: AGHT+IH5MSJwTh1B7mFyWb5WTRnOqKj7f6NddG4t/3ZHzJDKgIly1q0aSICrXnNtFRQEG35IWEozy7n8hsJX
X-Received: from pgct2.prod.google.com ([2002:a05:6a02:5282:b0:b54:f487:1d7d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f98:b0:250:595e:a69a
 with SMTP id adf61e73a8af0-2e7d0db08aemr4810087637.41.1758821271375; Thu, 25
 Sep 2025 10:27:51 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:27:31 -0700
In-Reply-To: <20250925172736.960368-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172736.960368-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172736.960368-6-irogers@google.com>
Subject: [PATCH v2 05/10] perf vendor events intel: Update graniterapids
 events to v1.15
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

Update graniterapids events to v1.15 released in:
https://github.com/intel/perfmon/commit/8af960a34864d291ad5a5a9f8fdf5a40486b78a1
https://github.com/intel/perfmon/commit/943667ba5b3f3203e47aede6bc7d017a26b89a26

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../graniterapids/uncore-interconnect.json    |  10 +-
 .../arch/x86/graniterapids/uncore-memory.json | 112 ++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 3 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
index 6667fbc50452..5eb1145f204f 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
@@ -833,11 +833,19 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1F",
         "EventName": "UNC_I_MISC1.LOST_FWD",
-        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x10",
         "Unit": "IRP"
     },
+    {
+        "BriefDescription": "Misc Events - Set 1 : Received Invalid : Secondary received a transfer that did not have sufficient MESI state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_INVLD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Snoop Hit E/S responses",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
index 9d385be59e3d..f559e27e2815 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
@@ -56,6 +56,33 @@
         "UMask": "0xcf",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 regular reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_NON_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc3",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 auto-precharge reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_PRE_REG",
+        "PerPkg": "1",
+        "UMask": "0xc2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 auto-precharge underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_PRE_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc8",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "CAS count for SubChannel 0 regular reads",
         "Counter": "0,1,2,3",
@@ -74,6 +101,15 @@
         "UMask": "0xc4",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_UNDERFILL_ALL",
+        "PerPkg": "1",
+        "UMask": "0xcc",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "CAS count for SubChannel 0, all writes",
         "Counter": "0,1,2,3",
@@ -121,6 +157,33 @@
         "UMask": "0xcf",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 regular reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_NON_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc3",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 auto-precharge reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_PRE_REG",
+        "PerPkg": "1",
+        "UMask": "0xc2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 auto-precharge underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_PRE_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc8",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "CAS count for SubChannel 1 regular reads",
         "Counter": "0,1,2,3",
@@ -139,6 +202,15 @@
         "UMask": "0xc4",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_UNDERFILL_ALL",
+        "PerPkg": "1",
+        "UMask": "0xcc",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "CAS count for SubChannel 1, all writes",
         "Counter": "0,1,2,3",
@@ -188,6 +260,46 @@
         "PublicDescription": "DRAM Clockticks",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "PMMNT is sending REF* commands while being in specified Refresh rate",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_M_MNTCMD_REFRATE.REFAB1X",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "PMMNT is sending REF* commands while being in specified Refresh rate",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_M_MNTCMD_REFRATE.REFAB2X",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "PMMNT is sending REF* commands while being in specified Refresh rate",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_M_MNTCMD_REFRATE.REFSB1X",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "PMMNT is sending REF* commands while being in specified Refresh rate",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_M_MNTCMD_REFRATE.REFSB2X",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "# of cycles MR4 temp readings forced 2x refresh",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 888d38e49766..6c0a6c3d2451 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-CF,v1.20,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.10,grandridge,core
-GenuineIntel-6-A[DE],v1.12,graniterapids,core
+GenuineIntel-6-A[DE],v1.15,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.24,icelake,core
-- 
2.51.0.536.g15c5d4f767-goog

