Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830924A4984
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269479; cv=none; b=nO0PKtg4VfWdplPN1DcN4ufQxQd33zpx/5f1DYA0P5/0Xz9LlghRrCbmc0vENuAqVLTKK1M20D4M0P1QWMQb8NIuVUbmbiFEQulj7BzI/4DrN3LoSHsUnnAXpceaJLwsW2YabyZq5vjs6gyR7OsItnLuCU/rq95OEFsq1UtWrBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269479; c=relaxed/simple;
	bh=pkYU/sT1PkrIwCEu7P49hurzS/ZBFC1ORzL8jfD0p34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IX3tSXBgvTfT1xFaVTxRxVmTPpeSbgKaQFXzEU39/bkHd9HZq+846KH5PAl/g8J1wLtwbs1otu90aURm4u5xBlKWsDz7UOYzXo/yFCxLxk1bMxsUXER3SoS6HZty0y3842NhJ8Tg02ZW9aGYYCGKu/+DRIwCKYYIvN4DB2DoKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YsO9oBFY; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsO9oBFY"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so104417c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269475; x=1790874275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iOSbZLAcaqbgj9jb704xsDCixgZKYJFKswEYhcsjL4M=;
        b=YsO9oBFYqqGwmiMeAbRkaKkGcMNv3gtEeTP8Q7oaKQmOuMByY3fv/HHSFGAoIHhz3c
         paWuRd7RkHqo14zXTKgD3ajTv8HMu5ry/QR356TY7cOFu5cW412002WiZvTlFoedp4nC
         fQ+aGdm6EiXKYBY8BDG7UqtbjYH8LiSP1I3dSUZDxVWt0LxVgbzyqE37BBp0xV8TOoNE
         sonNmE0chxtP8VfSw9SnX7pQrIecgtJjgChM08SuECY2jKfHhQOJDZqQFSW5BVbbbrE3
         WtVXa4KUQp1EOlW4ZjjrzqWna86h2+lgM9tnbblNqpdmlLcSBXwjzPWu93HudnczcDgX
         sx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269475; x=1790874275;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iOSbZLAcaqbgj9jb704xsDCixgZKYJFKswEYhcsjL4M=;
        b=nOrRzblxtFutwuCUxhYinjYZvzwR7pY1dMqnEEylRt9+ymU/XumUPwJ3wZEO2goHoB
         t07/Hw0znqBUxSWgglVoVXTidLIlAc3CrRGxY2fgauN/8QVAPjMkGMkXIpgFAf9UeCsQ
         8u2m7ux8l8mbb+G7AJ2EI9fQIjZOPuCmV8M/bdYkovwS5Hzn+KXMP+O3pYx/PsVXhaw8
         8hPHBdpyWC+WJmd5lPpeX5XeBXIw+P9H5IQVLABp7fLSeEiqSmDz3jQE0mR1gckpNYS/
         N9HbwyMQ9T7HegyWZU59pd8bTzSAQ8iHpget02nAG6NWJLkc5Gc7dGpy3cAsXGuVBI21
         89TQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUfOVN7wmcVguYcCHZin6M0J8MzSBJUIO6kZQUmHSD9z6p+NOqpP+WdGzIn/QdSQ7A7cAk+P8NNJPtkRjED2JV@vger.kernel.org
X-Gm-Message-State: AFuF++kg9029SOxlgfw4qTOrFDAn311orN6b84na3r6If1D6HBEWLLdx
	VuP15+O0rew4ckN9lFo8JMNEgjUZkp6VAZphbye0e63CdqhEvlycjsaa2Ma2BaQeJZT459x02GY
	Q8IVwxkkkxA==
X-Received: from dlbsi13.prod.google.com ([2002:a05:7022:b88d:b0:144:dd42:beec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4659:b0:143:3242:6308
 with SMTP id a92af1059eb24-14503f850c0mr2420076c88.6.1790269474991; Thu, 24
 Sep 2026 10:04:34 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:36 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-17-irogers@google.com>
Subject: [PATCH v2 16/26] perf vendor events intel: Update pantherlake events
 from 1.07 to 1.08
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

  https://github.com/intel/perfmon/commit/f3bbfcf86d67948fc330d4b2cddb29408=
7663da4

Fix umask encodings that weren't incorporating UMaskExt.

Fixes: dd171167f220 ("perf vendor events intel: Update pantherlake events t=
o v1.00")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv             |  2 +-
 tools/perf/pmu-events/arch/x86/pantherlake/cache.json  |  3 +++
 tools/perf/pmu-events/arch/x86/pantherlake/other.json  | 10 ++++++++++
 .../perf/pmu-events/arch/x86/pantherlake/pipeline.json | 10 +++++++---
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index f7c8c2aa476a..b8730fb35c31 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -27,7 +27,7 @@ GenuineIntel-6-(AA|AC|B5),v1.23,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-18-[13],v1.04,novalake,core
-GenuineIntel-6-(CC|D5|E5),v1.07,pantherlake,core
+GenuineIntel-6-(CC|D5|E5),v1.08,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.39,sapphirerapids,core
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/cache.json b/tools/=
perf/pmu-events/arch/x86/pantherlake/cache.json
index 165e955b870c..48bcd2f8ea15 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/cache.json
@@ -779,6 +779,7 @@
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.MEMSIDE_CACHE",
         "PublicDescription": "Retired load instructions which data source =
is memory side cache. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
+        "UMask": "0x100",
         "Unit": "cpu_core"
     },
     {
@@ -832,6 +833,7 @@
         "EventName": "MEM_LOAD_RETIRED.L1_HIT_L1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the Level 1 of the L1 data cache. Available PDIST co=
unters: 0,1",
         "SampleAfterValue": "1000003",
+        "UMask": "0x100",
         "Unit": "cpu_core"
     },
     {
@@ -1070,6 +1072,7 @@
         "EventCode": "0x44",
         "EventName": "MEM_STORE_RETIRED.MEMSIDE_CACHE",
         "SampleAfterValue": "100021",
+        "UMask": "0x400",
         "Unit": "cpu_core"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/other.json b/tools/=
perf/pmu-events/arch/x86/pantherlake/other.json
index 91dd2d25ebaf..840486ef592e 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/other.json
@@ -28,6 +28,16 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
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
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/pantherlake/pipeline.json
index 74209da5bc27..5685114edddb 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
@@ -225,6 +225,7 @@
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PublicDescription": "Counts far branch instructions retired. Avai=
lable PDIST counters: 0,1",
         "SampleAfterValue": "100007",
+        "UMask": "0x100",
         "Unit": "cpu_core"
     },
     {
@@ -553,6 +554,7 @@
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_COST",
         "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.ALL_BRANCHES_TPEBS] Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
+        "UMask": "0x8000",
         "Unit": "cpu_core"
     },
     {
@@ -562,6 +564,7 @@
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_TPEBS",
         "PublicDescription": "All mispredicted branch instructions retired=
. This precise event may be used to get the misprediction cost via the Reti=
re_Latency field of PEBS. It fires on the instruction that immediately foll=
ows the mispredicted branch. [This event is alias to BR_MISP_RETIRED.ALL_BR=
ANCHES_COST] Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
+        "UMask": "0x8000",
         "Unit": "cpu_core"
     },
     {
@@ -1334,7 +1337,7 @@
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
@@ -1860,11 +1863,11 @@
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
@@ -2631,6 +2634,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.X87",
         "SampleAfterValue": "1000003",
+        "UMask": "0x100",
         "Unit": "cpu_atom"
     }
 ]
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

