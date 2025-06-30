Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD912BDC01
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301086; cv=none; b=Qidc6DKziWDogPra/rFL+fnp4zj1BqK6qGXRpg7c9eRW8F4FWq7CH0vcwz07fpG4rqzqvEedkUQqSuEsDg+x6smdM1a7hLS8OFYy+E68HSoLU8jNbbtioARfjxoSwk8Kt95/NBipXX3VEEP9m1gSCxuWit1l4CFCimF9wyqnGf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301086; c=relaxed/simple;
	bh=+g9stw2MQAntOJZ+kh1FXeyCowowHJKXq/UCsDHjxnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pq2qGw0DuHaepHenNQrnBaLbCXUBNBmE3SuYUgZjFbF2NZPQbT5U1F7LKoKW75lSL5cvbIKhILS0SaESrgSZkkgh3s91AutLmAa1bahIK86sHcYGHUZJ7cAJ94hkAQuJR2V6yqTY9abNNvImjVvIxFiaD105TucmIIu7oEBHXis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eHTxiPsi; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHTxiPsi"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-6114de00ef5so250930eaf.3
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751301084; x=1751905884; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89HvY4zB6UR7umA8p+Rh7NZXEX65+JPdYsN7WZgrzSo=;
        b=eHTxiPsiu0QFmYoajKRI09pVmcGsNxnJ415aUAXEfrBlQyhYiVt+x0RP+4w6ymbT26
         PgKcTCGrPXzqEa3NmcaeNh+nK7eoHz/PHmQ5k4NH/B+tHZydOu5rCLJ7Fs3a/tOjohvf
         6iTiygcHkgD0dDqZMx1gdslu//dMREzFa8zzFAXYorfJvdspwz2kiT9B0XcMdd7nzdy4
         DRSP1GAyQjKjCs1d+hiaqZ6NHBT5P8tERzYIBwbiJMJJi91ltA3Z3CMn7+UWrpnztjIl
         QzDeMz4293Ad/ZLmjoBD8mZAy1yXBhT3/pXztAI8Lryx3CW3lm8U+ZWt/bqRG4XsXUyR
         R1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301084; x=1751905884;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=89HvY4zB6UR7umA8p+Rh7NZXEX65+JPdYsN7WZgrzSo=;
        b=kxrEKWlyv9nZJ0Mg/WTcUFdeL32gtrCqFfQPriB1lAwnph61qD4Xrg37O+DG+kR1Pz
         eX9Yg300razi8OSDbMgQ5CoCov1s8pIvZgFTpQt5PZjSg/TVbvQhmTMTz8Icxssby83R
         /G2la8iAcZtHxKKrrE79I6ihNuB8A8cAntIPuyRmPY5jtOPMubwz36eT/CSAVEFTICog
         tvNeEmg5gqqVZZYJSG5e96frqgHysOVzZtGMn1vTHQcEvFZAHGCH6oR52pf0lhZrbvaQ
         B8Eei5Lhcd5oWME1lJcwjLX6N3UvELSsgaCpZNN3T7evsu/Io4XsHDb+ergBG6tbmf65
         MYkw==
X-Forwarded-Encrypted: i=1; AJvYcCWffb4FafdH5VopKAKst6gHPWs/gXJUlKjhVkpV1b2ciJuK/X8/2Z6LJbMe7WzR7ih3ZkxiSZA9xYLCP/m1/jMj@vger.kernel.org
X-Gm-Message-State: AOJu0YyYFIgWilWSnCg/LQ/aZkGlZzIi4EmXqlvRtQBMoYoeKHO5DQ7B
	G8skgRLbFI7kbE4hX1RDL4SHVeeureBL/jtt6bdE6zf8PjZI0qlKLw4bS8ip5UwkPJWqyDp2zPm
	7lMcHNWXf0g==
X-Google-Smtp-Source: AGHT+IHbTmD+XGkF0K8uF87y5mq4GAcaJW22jwMMS5lrgEOygIyFtH9sIX3Gst+OYWK1jKZDblQVydg3YX3k
X-Received: from oabqj21.prod.google.com ([2002:a05:6870:2f15:b0:2c1:c983:48c1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:3929:b0:2c2:2f08:5e5b
 with SMTP id 586e51a60fabf-2efed4d9536mr10162278fac.13.1751301083759; Mon, 30
 Jun 2025 09:31:23 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:30:55 -0700
In-Reply-To: <20250630163101.1920170-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630163101.1920170-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630163101.1920170-11-irogers@google.com>
Subject: [PATCH v2 10/15] perf vendor events: Update MeteorLake events
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.13 to v1.14.

Bring in the event updates v1.14:
https://github.com/intel/perfmon/commit/6c53969b8d1a83afe6ae90149c8dd4ee416=
027ef

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |  2 +-
 .../arch/x86/meteorlake/frontend.json         | 72 +++++++++++++++++++
 .../arch/x86/meteorlake/pipeline.json         |  2 +-
 4 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 5f27b3700c3c..1185ea93b44a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -23,7 +23,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.14,lunarlake,core
-GenuineIntel-6-(AA|AC|B5),v1.13,meteorlake,core
+GenuineIntel-6-(AA|AC|B5),v1.14,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/cache.json
index c980bbee6146..82b115183924 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -231,7 +231,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of L2 Cache Accesses that m=
iss the L2 and get BBL reject  short and long rejects (includes those count=
ed in L2_reject_XQ.any), per core event",
+        "BriefDescription": "Counts the number of L2 Cache Accesses that m=
iss the L2 and get BBL reject  short and long rejects, per core event",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.REJECTS",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/frontend.json
index 509ce68c2ea6..82727022efb6 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
@@ -49,6 +49,14 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged with having preceded with frontend bound behavior",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ALL",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Retired ANT branches",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -73,6 +81,43 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles/empty issue slots due=
 to a baclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_DETECT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles /empty issue slots du=
e to a btclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_RESTEER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged following an ms flow due to the bubble/wasted issue slot from=
 exiting long ms flow",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.CISC",
+        "PublicDescription": "Counts the number of  instructions retired t=
hat were tagged following an ms flow due to the bubble/wasted issue slot fr=
om exiting long ms flow",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged every cycle the decoder is unable to send 3 uops per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Retired Instructions who experienced a critic=
al DSB miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -85,6 +130,15 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ica=
che miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ICACHE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -286,6 +340,24 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instruction retired tagg=
ed after a wasted issue slot if none of the previous events occurred",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.OTHER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles/empty issue slots due=
 to a predecode wrong.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.PREDECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index a833d6f53d0e..22b25708e799 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -1076,7 +1076,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
-        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions. Available PDIST counters: 0",
+        "PublicDescription": "Counts all software-prefetch load dispatches=
 that hit the fill buffer (FB) allocated for the software prefetch. It can =
also be incremented by some lock instructions. So it should only be used wi=
th profiling so that the locks can be excluded by ASM (Assembly File) inspe=
ction of the nearby instructions. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
--=20
2.50.0.727.gbf7dc18ff4-goog

