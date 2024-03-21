Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C864D3984D
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Mar 2024 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000829; cv=none; b=rItE8L2SjUX+WTBZJ2Cf1jyU7blP5EbYxwZHZ68+spgEctTFMoRlxKlO/LAv1q4joa5UAikws2KwMxHpxWUD+FjmOzqXrlHEgy0621F87vUVbnI8HplqJd5QZIx4ZxnkKQVAInV4xac4ISDiZwejL/jQsxRxSB7fkhIillIZBm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000829; c=relaxed/simple;
	bh=VLVml4Kn32DHcUw6yH3DhBensbZOr8TEd5AqmCvRMew=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZYF51ZhnmsIycW/MVtiI2fbmc/pKHAcervEPMgtPcksS8J/+SY904xyg+vSTaCskKhNg3Ku4KCkvEqvWOgAvQR+yLJX11egnxGmC7+Qc67aRE7Rvqo2y+gJQ46TsTwkkilbnQmDPwKiYfrmq6wtWCbQlUQ8FeQwgUg+iuo0VNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ReFFgWuA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ReFFgWuA"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0b18e52dso8563397b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 23:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711000826; x=1711605626; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o96QFSJF+sjvhNIgQJyH9qTpFePN3J+QpgdIZNuruzU=;
        b=ReFFgWuAHNVAvUkecaXcuYXdTFB3YO38wrQ+7JXB59+uAtdxkYcrM6UWeufDbtYxgY
         kMFkwP2ICrO4Ym0JcS+6R6lTSJ6Q83EUQlbiByQ2rFjImP1nE140aAdeuSoOaJt+GsTE
         u4+B0E2vvW15Z9nqMyxdqt0zrhSqSvZvps16eVMW7l+napt0ayKh24BEHWEwcPwPDL2u
         gurdNMvhz7UgAqsEFecJ51dxfl3aIIFz7H9PROioWTq3EYGwmVLU+WgXG7VSfIXUHaM1
         tacge7vLPadkuOv+dAGI4tLy533vfzTJhAL1GrFnmRI6ukcBWobQWYhz8JFlyYkgBvbX
         gxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000826; x=1711605626;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o96QFSJF+sjvhNIgQJyH9qTpFePN3J+QpgdIZNuruzU=;
        b=GtmuyW5oE5ISAztHClNDlVllEJSJrG1wWcDea9XZxQEjklYOd1c35Cbofv2t2887QE
         JMQhyeG7kaofNGsZcnsObq4zNjtLNQCfevO3dpM/q2i1dIyF9ZJWQa/znWdknj5QZcEP
         RSv4bkfTvJLmxYPPedsGnG66sj2K58elkCLjcALgmTO+YT8cJbGDGYYikon9EMxkwsxY
         Ggamc+2aaUuuD9Fsq1ovgr19/lkQNacTZldgfae2YIPmw17KcfNLC6mBJ8fivlQrtISs
         r9eCOjkHvGVWpeCrgSDDdnfhkAQiJHd8Y5Os7XUAmCjlNEaUxkKTaYlE6T78rG8jxsEB
         uXTg==
X-Forwarded-Encrypted: i=1; AJvYcCVRct3d41+OC7JKn8EpRESvgDpYH1OGHQtWtXG0zpbUdaZFdSa2+BQajNFZuMy8QZvQ9QisCVOIKHqSbv9buniM5n/x1E42wzhSdBTk15eMAQ==
X-Gm-Message-State: AOJu0YxxtYqJmjUGaPM1q53qqkTpOT6zYvtngnrH0KgG7g3f8lntX/qP
	OYJVlv1HI2lU+/zPoC9VRxkoknBzJHx5Ab/EZsQa82cYzAd9lP+A7dEFFX0CBsAPLlzTEEO8bmv
	+bDDA1A==
X-Google-Smtp-Source: AGHT+IGNClv/ADWET4Bc5IOkWHqBsgLPtqL7LhaPii+QaSxeFfmIhDYtV+w29lr2NsY0nfmu9b+Nv19lpg2q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a0d:e6c7:0:b0:610:fb7b:da18 with SMTP id
 p190-20020a0de6c7000000b00610fb7bda18mr492148ywe.4.1711000825839; Wed, 20 Mar
 2024 23:00:25 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:00:05 -0700
In-Reply-To: <20240321060016.1464787-1-irogers@google.com>
Message-Id: <20240321060016.1464787-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321060016.1464787-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v1 01/12] perf vendor events intel: Update cascadelakex to 1.21
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

Update events from 1.20 to 1.21 as released in:
https://github.com/intel/perfmon/commit/fcfdba3be8f3be81ad6b509fdebf953ead9=
2dc2c

Largely fixes spelling and descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/cascadelakex/frontend.json | 10 +++++-----
 .../pmu-events/arch/x86/cascadelakex/memory.json   |  2 +-
 .../pmu-events/arch/x86/cascadelakex/other.json    |  2 +-
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |  2 +-
 .../arch/x86/cascadelakex/uncore-interconnect.json | 14 +++++++-------
 .../arch/x86/cascadelakex/virtual-memory.json      |  2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |  2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json b/to=
ols/perf/pmu-events/arch/x86/cascadelakex/frontend.json
index 095904c77001..d6f543471b24 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
@@ -19,7 +19,7 @@
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switches",
         "EventCode": "0xAB",
         "EventName": "DSB2MITE_SWITCHES.COUNT",
-        "PublicDescription": "This event counts the number of the Decode S=
tream Buffer (DSB)-to-MITE switches including all misses because of missing=
 Decode Stream Buffer (DSB) cache and u-arch forced misses.\nNote: Invoking=
 MITE requires two or three cycles delay.",
+        "PublicDescription": "This event counts the number of the Decode S=
tream Buffer (DSB)-to-MITE switches including all misses because of missing=
 Decode Stream Buffer (DSB) cache and u-arch forced misses. Note: Invoking =
MITE requires two or three cycles delay.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -267,11 +267,11 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops [This event is alias to IDQ.DSB_CYCLES_OK]",
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 or more Uops [This event is alias to IDQ.DSB_CYCLES_OK]",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_4_UOPS",
-        "PublicDescription": "Counts the number of cycles 4 uops were deli=
vered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB)=
 path. Count includes uops that may 'bypass' the IDQ. [This event is alias =
to IDQ.DSB_CYCLES_OK]",
+        "PublicDescription": "Counts the number of cycles 4 or more uops w=
ere delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buff=
er (DSB) path. Count includes uops that may 'bypass' the IDQ. [This event i=
s alias to IDQ.DSB_CYCLES_OK]",
         "SampleAfterValue": "2000003",
         "UMask": "0x18"
     },
@@ -321,11 +321,11 @@
         "UMask": "0x18"
     },
     {
-        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops [This event is alias to IDQ.ALL_DSB_CYCLES_4_UOPS]",
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 or more Uops [This event is alias to IDQ.ALL_DSB_CYCLES_4_UOPS]",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles 4 uops were deli=
vered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB)=
 path. Count includes uops that may 'bypass' the IDQ. [This event is alias =
to IDQ.ALL_DSB_CYCLES_4_UOPS]",
+        "PublicDescription": "Counts the number of cycles 4 or more uops w=
ere delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buff=
er (DSB) path. Count includes uops that may 'bypass' the IDQ. [This event i=
s alias to IDQ.ALL_DSB_CYCLES_4_UOPS]",
         "SampleAfterValue": "2000003",
         "UMask": "0x18"
     },
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json b/tool=
s/perf/pmu-events/arch/x86/cascadelakex/memory.json
index a00ad0aaf1ba..c69b2c33334b 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
@@ -6866,7 +6866,7 @@
         "BriefDescription": "Number of times an RTM execution aborted due =
to any reasons (multiple categories may count as one).",
         "EventCode": "0xC9",
         "EventName": "RTM_RETIRED.ABORTED",
-        "PEBS": "1",
+        "PEBS": "2",
         "PublicDescription": "Number of times RTM abort was triggered.",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/other.json b/tools=
/perf/pmu-events/arch/x86/cascadelakex/other.json
index 3ab5e91a4c1c..95d42ac36717 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/other.json
@@ -19,7 +19,7 @@
         "BriefDescription": "Core cycles where the core was running in a m=
anner where Turbo may be clipped to the AVX512 turbo schedule.",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LVL2_TURBO_LICENSE",
-        "PublicDescription": "Core cycles where the core was running with =
power-delivery for license level 2 (introduced in Skylake Server michroarch=
tecture).  This includes high current AVX 512-bit instructions.",
+        "PublicDescription": "Core cycles where the core was running with =
power-delivery for license level 2 (introduced in Skylake Server microarchi=
tecture).  This includes high current AVX 512-bit instructions.",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
index 66d686cc933e..c50ddf5b40dd 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
@@ -396,7 +396,7 @@
         "Errata": "SKL091, SKL044",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.NOP",
-        "PEBS": "1",
+        "PEBS": "2",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-interconnec=
t.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-interconnect.js=
on
index 1a342dff1503..3fe9ce483bbe 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-interconnect.json
@@ -38,7 +38,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x80",
         "Unit": "IRP"
     },
@@ -47,7 +47,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.CRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x2",
         "Unit": "IRP"
     },
@@ -56,7 +56,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.DRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x4",
         "Unit": "IRP"
     },
@@ -65,7 +65,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.PCIDCAHINT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x20",
         "Unit": "IRP"
     },
@@ -74,7 +74,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.PCIRDCUR",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x1",
         "Unit": "IRP"
     },
@@ -101,7 +101,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x40",
         "Unit": "IRP"
     },
@@ -500,7 +500,7 @@
         "EventCode": "0x11",
         "EventName": "UNC_I_TRANSACTIONS.WRITES",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Trackes only write requests.=
  Each write request should have a prefetch, so there is no need to explici=
tly track these requests.  For writes that are tickled and have to retry, t=
he counter will be incremented for each retry.",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only write requests. =
 Each write request should have a prefetch, so there is no need to explicit=
ly track these requests.  For writes that are tickled and have to retry, th=
e counter will be incremented for each retry.",
         "UMask": "0x2",
         "Unit": "IRP"
     },
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.jso=
n b/tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json
index f59405877ae8..73feadaf7674 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json
@@ -205,7 +205,7 @@
         "BriefDescription": "Counts 1 per cycle for each PMH that is busy =
with a page walk for an instruction fetch request. EPT page walk duration a=
re excluded in Skylake.",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts 1 per cycle for each PMH (Page Miss H=
andler) that is busy with a page walk for an instruction fetch request. EPT=
 page walk duration are excluded in Skylake michroarchitecture.",
+        "PublicDescription": "Counts 1 per cycle for each PMH (Page Miss H=
andler) that is busy with a page walk for an instruction fetch request. EPT=
 page walk duration are excluded in Skylake microarchitecture.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 5297d25f4e03..281419d2edeb 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -5,7 +5,7 @@ GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v29,broadwell,core
 GenuineIntel-6-56,v11,broadwellde,core
 GenuineIntel-6-4F,v22,broadwellx,core
-GenuineIntel-6-55-[56789ABCDEF],v1.20,cascadelakex,core
+GenuineIntel-6-55-[56789ABCDEF],v1.21,cascadelakex,core
 GenuineIntel-6-9[6C],v1.04,elkhartlake,core
 GenuineIntel-6-CF,v1.03,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
--=20
2.44.0.396.g6e790dbe36-goog

