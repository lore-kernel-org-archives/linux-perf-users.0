Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97C3A8CB
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Mar 2024 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000844; cv=none; b=hSyinNZSgKUHX2j7xdjCJBOQ4Jd8DSzEI/Ocs31ND2Xr1XzwlfZT8on6mY0eg+ERDUdFZx1Ciz6bYsbfPEIOPmilNiuY0Eog6OD2VjkvdXsWoC412DDUsFtlwkU3VHNDvsXkOqqsY8xUmA5mO24PKrTsXdtzU30KAS/U1b/nvL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000844; c=relaxed/simple;
	bh=4aiYnfklGUdNA5v0rvMjTuhlmz0jerht5D8xp54iK74=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Q5ULyfCPIX31SxuJgVbii79AFopBwhC54c1qq+btLzNQJtOhBMuh3XT9ZA3hBP9XdCehHUFDCD84qU96ptMo0yYgLTTYA0GaT6fP00y5j/aYjU3e0fxFKjfN50XGFCpeyrmapwVGfF5yRefX4+2oJ5zQFAk/sE8sjU3DFW8xnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpULHlga; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpULHlga"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a4ee41269so11460147b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 23:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711000842; x=1711605642; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vojHkqbNtpD3GTjYNny3Rj7xmglPy9DzyUNuef2MBMo=;
        b=JpULHlgaoyKyWz2UZxjjiBLm73G70HNsoVzil42aVAfgGT2roYGY4zk1RpNQ6Ajv/t
         tqNysysqTmomUPVrcS5lMdunpXu9u8Mi43GQwKGapwr2U1r1glS13T/ohr5CaoOm4e9u
         ktSHiqNRr9u0kB9WIV3KyFMLJm0OssZTTL/bnG4vNkmO5m3ECdSoBB/xlcQcb4YvLj/Q
         IyySgzXvlH26UqLEHzmTO5sJWpCHN3911K4e69NZfrtHOBJa/19VYH74ofZ4XE/ZeHih
         atZ2TYuYp8arfVx5TBqXoYIzt5QbwJWIne4hunwJlqP8MzYyKtX1Xn8TxgQjiX4usU17
         MVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000842; x=1711605642;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vojHkqbNtpD3GTjYNny3Rj7xmglPy9DzyUNuef2MBMo=;
        b=O/syLPB9gaBBBUTDRe/5ge/eIV/qUWdasE4e0L1LCUfRlrGclo7nvExjZmKigS2TJL
         XtEX7oqGyVlsaNjuX+vfK/z4asfkN9kxy41NbcbFhj8rPUip5ligCkx6jhG5vH8Rpo5O
         YkoznvY8wYpygNGorGoEBrsw1LVNvZnE10L+qve587Pcq5gwW2241bWLMEqz2JyqGw3T
         eN6Il2lRKWzGIjcmOnGF9XhNbdsH7gLc7hZC7sDJFkVrSnAo2r44V8JtS2KsAHQKZDUW
         2fxn9hBgGJ5OBxkDq3xLXz1A4kjPZHGcbbe4jYSCZgXpEtUl6+c3c5AiCmPq/KhAMhZp
         nrGA==
X-Forwarded-Encrypted: i=1; AJvYcCVbpTpllv3c7mXRFgOWMOPdxo1h9bmoLJ/T+KAr5qm3k1ExScL9XZNxw2sWHKHvIdWKvelOaJsPHK8mdo13hkrPXf1kzkZpNHoTBzloIviSwA==
X-Gm-Message-State: AOJu0YzXoDU1ltVHrUi33NSHqk1Zwda0wmvmi0jwMJSVc0q++89Pzyti
	oo9pxi55zWfxKv+CO8UOpAiQ2zcMuGaeOW0f6PpeY84bmtx8I2nSSx6tWjERMRdcWPCs/6nlBJs
	sawc7cA==
X-Google-Smtp-Source: AGHT+IE4D5iCRIsPgcBFRPm4cKy2hSTJaELL1ZSlzKDbfWv5T9/W2JEov6kaL/JLLzMD6UVTwim6GRrl0GKU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a81:a184:0:b0:60b:b968:a28e with SMTP id
 y126-20020a81a184000000b0060bb968a28emr2118606ywg.7.1711000842294; Wed, 20
 Mar 2024 23:00:42 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:00:12 -0700
In-Reply-To: <20240321060016.1464787-1-irogers@google.com>
Message-Id: <20240321060016.1464787-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321060016.1464787-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v1 08/12] perf vendor events intel: Update sierraforest to 1.02
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from 1.01 to 1.02 as released in:
https://github.com/intel/perfmon/commit/451dd41ae627b56433ad4065bf3632789eb=
70834

Various description updates. Adds topdown events
TOPDOWN_BAD_SPECULATION.ALL_P, TOPDOWN_BE_BOUND.ALL_P,
TOPDOWN_FE_BOUND.ALL_P and TOPDOWN_RETIRING.ALL_P.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../arch/x86/sierraforest/pipeline.json       | 36 ++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index e5de35c96358..ac32377ab01a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -27,7 +27,7 @@ GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.02,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.20,sapphirerapids,core
-GenuineIntel-6-AF,v1.01,sierraforest,core
+GenuineIntel-6-AF,v1.02,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v58,skylake,core
 GenuineIntel-6-55-[01234],v1.32,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/sierraforest/pipeline.json
index ba9843110f07..90292dc03d33 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
@@ -249,10 +249,17 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
.ALL_P]",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
-        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window, including =
relevant microcode flows, and while uops are not yet available in the instr=
uction queue (IQ) or until an FE_BOUND event occurs besides OTHER and CISC.=
 Also includes the issue slots that were consumed by the backend but were t=
hrown away because they were younger than the mispredict or machine clear."=
,
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window, including =
relevant microcode flows, and while uops are not yet available in the instr=
uction queue (IQ) or until an FE_BOUND event occurs besides OTHER and CISC.=
 Also includes the issue slots that were consumed by the backend but were t=
hrown away because they were younger than the mispredict or machine clear. =
[This event is alias to TOPDOWN_BAD_SPECULATION.ALL_P]",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
.ALL]",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.ALL_P",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window, including =
relevant microcode flows, and while uops are not yet available in the instr=
uction queue (IQ) or until an FE_BOUND event occurs besides OTHER and CISC.=
 Also includes the issue slots that were consumed by the backend but were t=
hrown away because they were younger than the mispredict or machine clear. =
[This event is alias to TOPDOWN_BAD_SPECULATION.ALL]",
         "SampleAfterValue": "1000003"
     },
     {
@@ -284,7 +291,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls",
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls [This event is alias to TOPDOWN_BE_BOUND.ALL_P]=
",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALL",
         "SampleAfterValue": "1000003"
@@ -296,6 +303,12 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls [This event is alias to TOPDOWN_BE_BOUND.ALL]",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALL_P",
+        "SampleAfterValue": "1000003"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stall (sche=
duler not being able to accept another uop).  This could be caused by RSV f=
ull or load/store buffer block.",
         "EventCode": "0x74",
@@ -332,11 +345,17 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls",
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls [This event is alias to TOPDOWN_FE_BOUND.ALL_=
P]",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "SampleAfterValue": "1000003"
     },
+    {
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls [This event is alias to TOPDOWN_FE_BOUND.ALL]=
",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ALL_P",
+        "SampleAfterValue": "1000003"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BAClear",
         "EventCode": "0x71",
@@ -409,12 +428,19 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Counts the number of consumed retirement slot=
s.  Similar to UOPS_RETIRED.ALL",
+        "BriefDescription": "Counts the number of consumed retirement slot=
s.  Similar to UOPS_RETIRED.ALL [This event is alias to TOPDOWN_RETIRING.AL=
L_P]",
         "EventCode": "0x72",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "PEBS": "1",
         "SampleAfterValue": "1000003"
     },
+    {
+        "BriefDescription": "Counts the number of consumed retirement slot=
s.  Similar to UOPS_RETIRED.ALL [This event is alias to TOPDOWN_RETIRING.AL=
L]",
+        "EventCode": "0x72",
+        "EventName": "TOPDOWN_RETIRING.ALL_P",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003"
+    },
     {
         "BriefDescription": "Counts the number of uops issued by the front=
 end every cycle.",
         "EventCode": "0x0e",
--=20
2.44.0.396.g6e790dbe36-goog

