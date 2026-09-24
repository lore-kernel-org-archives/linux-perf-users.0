Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E04411672
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269447; cv=none; b=Qwp3gzYHlCcCPIf6VwEdwwTG8vHTJbxvl4vtW3xI4Rs2bnPwzgkXTykGpHIbfGe1Yej5fdBjdBYHx7Mxgfx+cSPr9Fzv7ULGI0zlTyjDuHp7yxyOjY9DwlCQHO4GM27TF5FhRIBkat4+D4W9FuqOsrlDg0gcfN0n/xq5ZKjljKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269447; c=relaxed/simple;
	bh=5NmY56k3QCWHRS+9mMcOx8xHTzgVxcRhdTbbUHYDB08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c9Q4bPKViqeVI0AoRkuMlP/uZ4v75lKMF3YN4EwzoBL/n0rXD7UwDicosfmXhqo7a88RK7ucQQdVZ6yitlXwusTHmGwacGvnoAObECTY7hMIj7HKDXTerXUAFrxx+FtdoTOI9mZVMzr16P/vti0Eg8wVJf/TsM3HEs4NcUhmB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCkW3Has; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCkW3Has"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-331b2ec616fso3308303eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269444; x=1790874244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Eey3rbwq9lfFSIjQSnHq3wKThZ7U6KjaV4Lu200cqM=;
        b=YCkW3HasN2vDyGkozPp6EdKiReiL142bXFlgActUXws8k0RoEAHQtHo4JxC8blW3+e
         Nq7qKDLoT4uXQ6tjWaaDQSb7is4BKadnABKa2uaW25+QNxavCS0hZY+kZVpIANhiedBh
         AFGOXkCeSC2vY2QeOwv/+ZIIAmd7bfRPdaP95N/Dd8s+DV4b4Hhx2h9VJadOVT17nrQL
         IUkKoTJIObo7gdPQHbNgsKFZE237GSl0ApJvGa5gymE8CKAapOB+Y2J912zKQUmgBQvn
         ReTCuFW2sEsGMdB7ZUIKFNYLJFgP9lPm+uHWDgnvYE1GWMwn6gEMhbdjiNb4A/zm2iXE
         6GNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269444; x=1790874244;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Eey3rbwq9lfFSIjQSnHq3wKThZ7U6KjaV4Lu200cqM=;
        b=1+BRRPqpG2JhygGZhO3vTcN6sYKJuIK3lWK2Q0Sd8OUWMyysn+FeACiphoJLtRhRoL
         jdN03ILZ7DaHpWtSW2F/UXSMMNcLJh5wNpvVbbyuiCVCHcZosCjhz3hiXT7Oh7oi9ges
         d/+ltxxzaEqq/713G4uoSzGuavIv2DrbALimc/DAl1VEFKbnQNeTpRNZ9xWnrboYreMN
         WCV38vvvT8UhpK49G6M3nO7eYkmWnWOgAGtQOQrnZGs/8iPjYDjEz5lpg+TAomMOPXdk
         F4+ACdUAP0vvXHVzp8XGomSv0piBO6PgRVZVEJLNlJGBd6E4eCEoVzOKmMLw8nCLWTDS
         e2Ug==
X-Forwarded-Encrypted: i=1; AKwUvBwyvbisiIg/rXD15GtzN6bZ75VLj0S5yAC78idOSNHCkGrcmECrR9CRSScuGILcqY/hyXgxfJmqnGCQTuesSxxq@vger.kernel.org
X-Gm-Message-State: AFuF++nYicpYHuKUVP6HSUBfoAWzmWJn8WQ4vC8WgtlxFiq9DX9hKdC4
	SLZzlgjQ5myP9hRRJqyUhdEjObccN0bWCoTvdnp9IhUglwtM+AG50TDPxjGjPzlmOhDsugabbtp
	IYF3P1oGidQ==
X-Received: from dyckg24.prod.google.com ([2002:a05:7301:d198:b0:33b:beb3:6c8c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:829b:10b0:33b:e21e:4a3a
 with SMTP id 5a478bee46e88-3400439b178mr3198555eec.40.1790269443943; Thu, 24
 Sep 2026 10:04:03 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:23 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-4-irogers@google.com>
Subject: [PATCH v2 03/26] perf vendor events intel: Update arrowlake events
 from 1.20 to 1.21
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

  https://github.com/intel/perfmon/commit/335239ef9a63a3a6e198233678f898761=
cba38aa

Fix umask encoding when UMaskExt is used.

Fixes: ba56a910635a ("perf vendor events: Add Arrowlake events/metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/arrowlake/cache.json  |  1 +
 .../pmu-events/arch/x86/arrowlake/other.json  | 19 +++++++++++++++++++
 .../arch/x86/arrowlake/pipeline.json          | 10 ++++++----
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/arrowlake/cache.json
index 142f62c59531..7fc4d136706d 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
@@ -1107,6 +1107,7 @@
         "EventName": "MEM_LOAD_RETIRED.L1_HIT_L1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the Level 1 of the L1 data cache. Available PDIST co=
unters: 0,1",
         "SampleAfterValue": "1000003",
+        "UMask": "0x100",
         "Unit": "cpu_core"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/arrowlake/other.json
index c8feed3a99a6..96086e257a6a 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/other.json
@@ -101,6 +101,25 @@
         "UMask": "0x10",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL. [This event is alias to MISC_RET=
IRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe4",
+        "EventName": "LBR_INSERTS.ANY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "LBR record is inserted [This event is alias t=
o MISC_RETIRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xe4",
+        "EventName": "LBR_INSERTS.ANY",
+        "PublicDescription": "LBR record is inserted [This event is alias =
to MISC_RETIRED.LBR_INSERTS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This event is deprecated. [This event is alia=
s to MISC_RETIRED.LBR_INSERTS]",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/arrowlake/pipeline.json
index 1f1b5a88216a..4533ca6e1461 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
@@ -209,6 +209,7 @@
         "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
         "PublicDescription": "Counts taken forward conditional branch inst=
ructions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
+        "UMask": "0x100",
         "Unit": "cpu_core"
     },
     {
@@ -627,6 +628,7 @@
         "EventName": "BR_MISP_RETIRED.COND_TAKEN_FWD",
         "PublicDescription": "Counts taken forward conditional mispredicte=
d branch instructions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
+        "UMask": "0x100",
         "Unit": "cpu_core"
     },
     {
@@ -1238,7 +1240,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary run to run and not match the architectural =
number of iterations (specified by RCX) Available PDIST counters: 0,1",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary from run to run and not match the architect=
ural number of iterations (specified by RCX). Available PDIST counters: 0,1=
",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1931,7 +1933,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL.",
+        "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL.  [This event is alias to LBR_INS=
ERTS.ANY]",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
@@ -1940,11 +1942,11 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "LBR record is inserted",
+        "BriefDescription": "LBR record is inserted [This event is alias t=
o LBR_INSERTS.ANY]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "LBR record is inserted Available PDIST count=
ers: 0,1",
+        "PublicDescription": "LBR record is inserted [This event is alias =
to LBR_INSERTS.ANY] Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 748d1ee1605c..27eaf934b925 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,7 +1,7 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.41,alderlake,core
 GenuineIntel-6-BE,v1.41,alderlaken,core
-GenuineIntel-6-C[56],v1.20,arrowlake,core
+GenuineIntel-6-C[56],v1.21,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
 GenuineIntel-6-56,v12,broadwellde,core
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

