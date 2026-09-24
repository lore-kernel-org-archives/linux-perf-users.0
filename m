Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC63D9699
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228296; cv=none; b=jXlL2W22/9cnW9e+nq1r/5vBiNvBzfDxH5lfa3034PHqVsbqjncWzerD3pHUSGcRdVhTwuDD/MtMQ44rymgkOkmPqcIq/w3ileErcBPCDr2NJQs14oNhMwj7D6WnZiYuTEAzTV5PKyc8/lzKHLs4Ox0rp7qY79OmvwxrdG6ccZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228296; c=relaxed/simple;
	bh=ysS1DuDc8OwzwRxZc7EilUBERSPZuW2J2gP5Q7quK7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=t2/lGAqvvBZ2I0DKcye+KbUioUNDhl6cRtcOwHgEDIfNz03klCNV1U7rTtcLgLYRB1Tr20VN1soLgd28USB1J9qSqDFZkzi8pWrYK6qlynaiSAZlZjIEtXk1rdKFe/RIzl6468sN7HBC7qOQU8HifR683FIjxsBQzHtqhj0o5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9bvdmUp; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9bvdmUp"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-331b2ec616fso1174440eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790228291; x=1790833091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=12UnCudGrTLuqThUqVd7v0GM72DihyzBsYqjjNQ+GGc=;
        b=n9bvdmUpsuRoZ7O2ahpQV1YLXgXCuYwj+XI3LV2NZBOMY7XLW7HNeYJ6dCT32qMBMS
         /3lsqCxBJR141+rnDk6tbWf9vgAGjgcPGkS5q6n8kthtjE9fcwcYurIOwoXVcccZMMz0
         rPAKK2t+Thxr3bkZiX6Yudusp68xTmSYwn1zOyCU9Cm3DKy/V1G5Nl9ITSREhKofP29u
         Hvw0RlrR10pYGs2fpKCAPqvw+c0eCfGBV94YEvs5eFD3dT/rMCC5uieOxhTGrYIOwu/4
         9msMp4yWxw6/tlQulNAYEc7/M4a86Xkhq0bRHuzXT92VUihOq38/Plu4m4/SV8+AskSW
         6CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228291; x=1790833091;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=12UnCudGrTLuqThUqVd7v0GM72DihyzBsYqjjNQ+GGc=;
        b=G05KhnLmmshMK5ovWE+Z+nltFW05rqtifLyTsxCEhT7SfVOwRzmWrSJQSTbahT2rwC
         rm/AenwomVRUmwdqYZQDBLlK1RrRuw11ybtaOZeXD6rWRBfkWwYrJcCQwgBmlBzedcK5
         PA5mYBvsA+DNMYiW7A2G9jhyCR9XAgLPfIcxM51Ef5uEQVnaCbSt1N23m4OeRoR7MnBg
         sCxhR6sfwy8/rwbKlODjdL6O/M+JjQrHwTdplJMgDXQ2DJZChlkY7Luba48z/grL49od
         te2oLMy2f959PLDweqGLz2PpAe+m1PQk2gZ3YEleQprBPMFb0Ke71D4FGtOabENL0Euj
         XFlg==
X-Forwarded-Encrypted: i=1; AKwUvBzwqvqnbBchD4CnGQc/HYNXl4x2J/WM6DX4asMH2HU05rn3ezfZWrOnde1OjqhazV0F1fXlF+MeEOnpxoa1cXSc@vger.kernel.org
X-Gm-Message-State: AFuF++l9WVwr+Lg2Sm14MqPdJ2q0zUN6up+NSe+LIbKbr4hENER4cRt+
	ioK9lSaOI8+2KNoYf0oP4FSuiyN95b9oacynnpON/bJpVmpYou9ufWapHXlYav25ypWJwRHweub
	lksfZfFZpMw==
X-Received: from dyuq26-n2.prod.google.com ([2002:a05:693c:66da:20b0:340:6b72:487a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f588:b0:33b:ae91:1e62
 with SMTP id 5a478bee46e88-3400459996bmr996855eec.41.1790228291039; Wed, 23
 Sep 2026 22:38:11 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:36:31 -0700
In-Reply-To: <20260924053645.3555041-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924053645.3555041-8-irogers@google.com>
Subject: [PATCH v1 07/21] perf vendor events intel: Update graniterapids
 events from 1.20 to 1.21
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

  https://github.com/intel/perfmon/commit/8732d043b432e9d04086a07feb23d9df7=
0a10f17

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/graniterapids/other.json     |  9 +++++++++
 .../pmu-events/arch/x86/graniterapids/pipeline.json  |  6 +++---
 .../arch/x86/graniterapids/uncore-cache.json         | 10 ++++++++++
 .../pmu-events/arch/x86/graniterapids/uncore-io.json | 12 ++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv           |  2 +-
 5 files changed, 35 insertions(+), 4 deletions(-)

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
index 721fc42797b1..e69a72fdfc95 100644
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
2.56.0.rc1.310.g51773c2048-goog

