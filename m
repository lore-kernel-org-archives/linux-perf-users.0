Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781619F41C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733783320; cv=none; b=bt2SK/LaA8PCDoXH8AVD6obuAu51i0Ng120FXCssrmN1prPpPrGIX7i7k+OOqEjwIvVLivmWw7yttsjxElajPVhjGTYrpmT3Jpa8dUHoi7jA5pDTS8xhjwMX0oviAJPo93q7uxDYkfHcBl9zexK8gUaVsdFZLHVWWUYhbZPUHl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733783320; c=relaxed/simple;
	bh=hO/nZ+3eTsTlQrSdYfYxHxGTA4WB76R+WX0NGsAIisA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oxUkC2m4pj7sG1/VfRiuiDMwKmDVdhAyq/bqf1/UUVpbd9UvRmg0jpvMoIUEUAu0x2fEi8sqLjd8e/gKqMzByMtVusixbDk2pzZWaasy0oJ/xCg4POT/dl3W4aeQVEY1qy2K9kgafwsiibNMvjN8aeyO1/i54r34rzs4pkifSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0hl1mQPN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0hl1mQPN"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f0029af168so22818317b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2024 14:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733783310; x=1734388110; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7r63EyygyG+quKYZklwXpj3EqjAm/6RL4CFWh9W+pCI=;
        b=0hl1mQPNg6570eUuuiqZgEHcvd6ESEbrm23/DhDhLPDrdD9hIvF7SeqGuDqN1qWB6U
         tVWUfQ2fXqVCXRkohR6FFGSzCKU+vnpzYImaCEWisuIoXWr8FidP9DY0HM6fB3iow4qX
         D/92FdFBOkX5z67StJgvyVYsO1DVVYP2i7P8S6zWu6ZaVw4RIiJoo/douMOU6c65SaaW
         ma1Bu2KrieTQZG4BJhE1ZQ5wssllTR5LaOXafWrqUkRyRY7apH7pXM1ejvUMSUj5bh0G
         zWxX1PWsFGsLl/Q2LaE8mIeHEm4syPxrsOTyjnRHLambeijONWwoNhrYSD90L45HrHOl
         6mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733783310; x=1734388110;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7r63EyygyG+quKYZklwXpj3EqjAm/6RL4CFWh9W+pCI=;
        b=hVslykLrcUWE0/t13ol0y74ym7IIwh+KRSwdj3ufhlrGSCO4vjgvTBFyLh/qAqfQ7/
         uzc9o3sdSxTv0Wb/NthdQoseW8bN6y1kLOSxVZv6KnhzFjIRqoXKFwE1qiE5YvdhKq6q
         a92sfuh4CDmEdQv2X+cRTeoEBVHkHjcAvJwFFOlkZSbdWOhC36omQtuHzGxQ2TY4McxC
         uwee4Xo4DtWwve+1DD7SSJTHWMFZYIl9gpVb1miM6YiDNx4FXf6Gw06s1mOG/REqDqaW
         tpXR5roXdwEAcjR6alO6kMMnyJ+aO3vP7Qrj5WwtUMByA/lbMOUe3oE9wj3dPxO6zNYO
         sRdg==
X-Forwarded-Encrypted: i=1; AJvYcCXOiz/rqn4D6sLHFo3TbaiQxO2X0mLgwXCkQVbiaOjmAEDkaWUMwR43mcioVpoIr58D3OGoz4dOJy/tKrS9+ICN@vger.kernel.org
X-Gm-Message-State: AOJu0YxBw0Dhsb7rDhK6aZKG6d4xY0gF5XUGt6rJJdgtiuUMJoQComYG
	dHGaci8Eg+qeSxpULFEOFj56Ziow8silVBKFT1a9aCdntc8IGo5XsBfXICtNq7NZ8/hlpbSF5bj
	poPpUag==
X-Google-Smtp-Source: AGHT+IG98a4d4SqWQy0MsDOQpoAl2vorCcM3GnIiH/Ribq6IZiEiComRn7DasWh98oMKEgxlwomoBN42OIT8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c8f1:280e:e8ad:32])
 (user=irogers job=sendgmr) by 2002:a05:690c:2891:b0:6ef:e0ce:df9f with SMTP
 id 00721157ae682-6efe3c68ec1mr240647b3.4.1733783309794; Mon, 09 Dec 2024
 14:28:29 -0800 (PST)
Date: Mon,  9 Dec 2024 14:27:46 -0800
In-Reply-To: <20241209222800.296000-1-irogers@google.com>
Message-Id: <20241209222800.296000-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209222800.296000-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.545.g3c1d2e2a6a-goog
Subject: [PATCH v1 09/22] perf vendor events: Update GrandRidge events/metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.03 to v1.05.
Update TMA metrics from 4.8 to 5.01.

Bring in the event updates v1.05:
https://github.com/intel/perfmon/commit/3b2e3528fbfb5576f443607ac9d772de88a=
ed72c
https://github.com/intel/perfmon/commit/9bc1815536ff1f6fe73693a19a410b6a711=
740c2

The TMA 5.01 update is from (with subsequent fixes):
https://github.com/intel/perfmon/commit/1d72913b2d938781fb28f3cc3507aaec5c2=
2d782

Update uncore IIO events umask with the change:
https://github.com/intel/perfmon/commit/d78e8a166537c9ceab4f2e901dc96c53667=
a2174
which should address an issue originally raised by Michael Petlan:
Reported-by: Michael Petlan <mpetlan@redhat.com>
Closes: https://lore.kernel.org/all/alpine.LRH.2.20.2401300733310.11354@Die=
go/

Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/grandridge/grr-metrics.json      | 284 ++++++------------
 .../arch/x86/grandridge/pipeline.json         |   3 +-
 .../arch/x86/grandridge/uncore-cache.json     |   4 +-
 .../x86/grandridge/uncore-interconnect.json   |  60 ++++
 .../arch/x86/grandridge/uncore-io.json        | 214 ++++++-------
 .../arch/x86/grandridge/uncore-memory.json    |   2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 7 files changed, 260 insertions(+), 309 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json b/t=
ools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
index 07e542297e93..2f9959c61718 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
@@ -1,4 +1,11 @@
 [
+    {
+        "BriefDescription": "C10 residency percent per package",
+        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C10_Pkg_Residency",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "C1 residency percent per core",
         "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
@@ -7,17 +14,24 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "BriefDescription": "C2 residency percent per package",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C6_Core_Residency",
+        "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C6 residency percent per module",
-        "MetricExpr": "cstate_module@c6\\-residency@ / TSC",
+        "BriefDescription": "C3 residency percent per package",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C6_Module_Residency",
+        "MetricName": "C3_Pkg_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "C6 residency percent per core",
+        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
@@ -28,7 +42,21 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
+        "BriefDescription": "C7 residency percent per core",
+        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Core_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "C8 residency percent per package",
+        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C8_Pkg_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
         "MetricName": "cpi",
         "ScaleUnit": "1per_instr"
@@ -49,31 +77,31 @@
         "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte page sizes) caused by demand data loads to the total number of c=
ompleted instructions",
         "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRE=
D.ANY",
         "MetricName": "dtlb_2nd_level_2mb_large_page_load_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte page sizes) caused by demand data loads to the total number of =
completed instructions. This implies it missed in the Data Translation Look=
aside Buffer (DTLB) and further levels of TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte page sizes) caused by demand data loads to the total number of =
completed instructions. This implies it missed in the Data Translation Look=
aside Buffer (DTLB) and further levels of TLB",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions",
         "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
         "MetricName": "dtlb_2nd_level_load_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions",
         "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
         "MetricName": "dtlb_2nd_level_store_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB",
         "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU.",
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU",
         "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e6 / durati=
on_time",
         "MetricName": "io_bandwidth_read",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU",
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM + UNC_CHA_TOR_INSERTS.=
IO_ITOMCACHENEAR) * 64 / 1e6 / duration_time",
         "MetricName": "io_bandwidth_write",
         "ScaleUnit": "1MB/s"
@@ -82,14 +110,14 @@
         "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
         "MetricName": "itlb_2nd_level_large_page_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total =
number of completed instructions. This implies it missed in the Instruction=
 Translation Lookaside Buffer (ITLB) and further levels of TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total =
number of completed instructions. This implies it missed in the Instruction=
 Translation Lookaside Buffer (ITLB) and further levels of TLB",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
         "MetricName": "itlb_2nd_level_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB",
         "ScaleUnit": "1per_instr"
     },
     {
@@ -188,17 +216,15 @@
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to certain allocation restrictions",
         "MetricExpr": "tma_core_bound",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_core_bound_group"=
,
         "MetricName": "tma_allocation_restriction",
-        "MetricThreshold": "tma_allocation_restriction > 0.1 & (tma_core_b=
ound > 0.1 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend due to backend stalls",
         "MetricExpr": "TOPDOWN_BE_BOUND.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
-        "MetricThreshold": "tma_backend_bound > 0.1",
         "MetricgroupNoGroup": "TopdownL1",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend due to backend stalls. Note that uops must=
 be available for consumption in order for this event to count. If a uop is=
 not available (IQ is empty), this event will not count",
         "ScaleUnit": "100%"
@@ -206,104 +232,92 @@
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.ALL_P / (6 * CPU_CLK_UNHALT=
ED.CORE)",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
-        "MetricThreshold": "tma_bad_speculation > 0.15",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BACLEARS, which occurs when the Branch T=
arget Buffer (BTB) prediction or lack thereof, was corrected by a later bra=
nch predictor in the frontend",
         "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / (6 * CPU_CLK_UNHAL=
TED.CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
         "MetricName": "tma_branch_detect",
-        "MetricThreshold": "tma_branch_detect > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
-        "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s.",
+        "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to branch mispredicts",
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / (6 * CPU_CLK_U=
NHALTED.CORE)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
+        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_bad_speculation_g=
roup",
         "MetricName": "tma_branch_mispredicts",
-        "MetricThreshold": "tma_branch_mispredicts > 0.05 & tma_bad_specul=
ation > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BTCLEARS, which occurs when the Branch T=
arget Buffer (BTB) predicts a taken branch.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BTCLEARS, which occurs when the Branch T=
arget Buffer (BTB) predicts a taken branch",
         "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / (6 * CPU_CLK_UNHA=
LTED.CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
         "MetricName": "tma_branch_resteer",
-        "MetricThreshold": "tma_branch_resteer > 0.05 & (tma_ifetch_latenc=
y > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to the microcode sequencer (MS).",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to the microcode sequencer (MS)",
         "MetricExpr": "TOPDOWN_FE_BOUND.CISC / (6 * CPU_CLK_UNHALTED.CORE)=
",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.05 & (tma_ifetch_bandwidth > 0.1 =
& tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are bounded by core restrictions and not attributed to an o=
utstanding load or stores, or resource limitation",
         "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / (6 * CPU_CLK_=
UNHALTED.CORE)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_backend_bound_gro=
up",
         "MetricName": "tma_core_bound",
-        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.1=
",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to decode stalls.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to decode stalls",
         "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / (6 * CPU_CLK_UNHALTED.COR=
E)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
         "MetricName": "tma_decode",
-        "MetricThreshold": "tma_decode > 0.05 & (tma_ifetch_bandwidth > 0.=
1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that does not require the =
use of microcode, classified as a fast nuke, due to memory ordering, memory=
 disambiguation and memory renaming",
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / (6 * CPU_CLK_UNH=
ALTED.CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_machine_clears_gr=
oup",
         "MetricName": "tma_fast_nuke",
-        "MetricThreshold": "tma_fast_nuke > 0.05 & (tma_machine_clears > 0=
.05 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to frontend stalls.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to frontend stalls",
         "MetricExpr": "TOPDOWN_FE_BOUND.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
-        "MetricThreshold": "tma_frontend_bound > 0.2",
         "MetricgroupNoGroup": "TopdownL1",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to instruction cache misses.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to instruction cache misses",
         "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / (6 * CPU_CLK_UNHALTED.COR=
E)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend bandwidth restrictions due to d=
ecode, predecode, cisc, and other limitations.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend bandwidth restrictions due to d=
ecode, predecode, cisc, and other limitations",
         "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / (6 * CPU_CLK_=
UNHALTED.CORE)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
+        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_frontend_bound_gr=
oup",
         "MetricName": "tma_ifetch_bandwidth",
-        "MetricThreshold": "tma_ifetch_bandwidth > 0.1 & tma_frontend_boun=
d > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend latency restrictions due to ica=
che misses, itlb misses, branch detection, and resteer limitations.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend latency restrictions due to ica=
che misses, itlb misses, branch detection, and resteer limitations",
         "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / (6 * CPU_CLK_UN=
HALTED.CORE)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
+        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_frontend_bound_gr=
oup",
         "MetricName": "tma_ifetch_latency",
-        "MetricThreshold": "tma_ifetch_latency > 0.15 & tma_frontend_bound=
 > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -331,32 +345,6 @@
         "MetricGroup": "Flops",
         "MetricName": "tma_info_arith_inst_mix_ipfparith_scalar_sp"
     },
-    {
-        "BriefDescription": "Percentage of time that retirement is stalled=
 due to a first level data TLB miss",
-        "MetricExpr": "tma_info_bottleneck_dtlb_miss_bound_cycles",
-        "MetricName": "tma_info_bottleneck_%_dtlb_miss_bound_cycles"
-    },
-    {
-        "BriefDescription": "Percentage of time that allocation and retire=
ment is stalled by the Frontend Cluster due to an Ifetch Miss, either Icach=
e or ITLB Miss",
-        "MetricExpr": "tma_info_bottleneck_ifetch_miss_bound_cycles",
-        "MetricGroup": "Ifetch",
-        "MetricName": "tma_info_bottleneck_%_ifetch_miss_bound_cycles",
-        "PublicDescription": "Percentage of time that allocation and retir=
ement is stalled by the Frontend Cluster due to an Ifetch Miss, either Icac=
he or ITLB Miss. See Info.Ifetch_Bound"
-    },
-    {
-        "BriefDescription": "Percentage of time that retirement is stalled=
 due to an L1 miss",
-        "MetricExpr": "tma_info_bottleneck_load_miss_bound_cycles",
-        "MetricGroup": "Load_Store_Miss",
-        "MetricName": "tma_info_bottleneck_%_load_miss_bound_cycles",
-        "PublicDescription": "Percentage of time that retirement is stalle=
d due to an L1 miss. See Info.Load_Miss_Bound"
-    },
-    {
-        "BriefDescription": "Percentage of time that retirement is stalled=
 by the Memory Cluster due to a pipeline stall",
-        "MetricExpr": "tma_info_bottleneck_mem_exec_bound_cycles",
-        "MetricGroup": "Mem_Exec",
-        "MetricName": "tma_info_bottleneck_%_mem_exec_bound_cycles",
-        "PublicDescription": "Percentage of time that retirement is stalle=
d by the Memory Cluster due to a pipeline stall. See Info.Mem_Exec_Bound"
-    },
     {
         "BriefDescription": "Percentage of time that retirement is stalled=
 due to a first level data TLB miss",
         "MetricExpr": "100 * (LD_HEAD.DTLB_MISS_AT_RET + LD_HEAD.PGWALK_AT=
_RET) / CPU_CLK_UNHALTED.CORE",
@@ -438,21 +426,6 @@
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
         "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_to_u=
nknown_branch_ratio"
     },
-    {
-        "BriefDescription": "Percentage of time that allocation is stalled=
 due to load buffer full",
-        "MetricExpr": "tma_info_buffer_stalls_load_buffer_stall_cycles",
-        "MetricName": "tma_info_buffer_stalls_%_load_buffer_stall_cycles"
-    },
-    {
-        "BriefDescription": "Percentage of time that allocation is stalled=
 due to memory reservation stations full",
-        "MetricExpr": "tma_info_buffer_stalls_mem_rsv_stall_cycles",
-        "MetricName": "tma_info_buffer_stalls_%_mem_rsv_stall_cycles"
-    },
-    {
-        "BriefDescription": "Percentage of time that allocation is stalled=
 due to store buffer full",
-        "MetricExpr": "tma_info_buffer_stalls_store_buffer_stall_cycles",
-        "MetricName": "tma_info_buffer_stalls_%_store_buffer_stall_cycles"
-    },
     {
         "BriefDescription": "Percentage of time that allocation is stalled=
 due to load buffer full",
         "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.LD_BUF / CPU_CLK_UNHALTED=
.CORE",
@@ -474,7 +447,8 @@
     {
         "BriefDescription": "Cycles Per Instruction",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE / INST_RETIRED.ANY",
-        "MetricName": "tma_info_core_cpi"
+        "MetricName": "tma_info_core_cpi",
+        "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
@@ -492,21 +466,6 @@
         "MetricExpr": "TOPDOWN_RETIRING.ALL_P / INST_RETIRED.ANY",
         "MetricName": "tma_info_core_upi"
     },
-    {
-        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L2",
-        "MetricExpr": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l2h=
it",
-        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2hit"
-    },
-    {
-        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L3",
-        "MetricExpr": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l3h=
it",
-        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3hit"
-    },
-    {
-        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss subsequently misses in the L3",
-        "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.LLC_MISS / MEM_BOUND_=
STALLS_IFETCH.ALL",
-        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3miss"
-    },
     {
         "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L2",
         "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.L2_HIT / MEM_BOUND_ST=
ALLS_IFETCH.ALL",
@@ -519,24 +478,6 @@
         "MetricName": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l3h=
it",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L2",
-        "MetricExpr": "tma_info_load_miss_bound_loadmissbound_with_l2hit",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2hit=
"
-    },
-    {
-        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L3",
-        "MetricExpr": "tma_info_load_miss_bound_loadmissbound_with_l3hit",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3hit=
"
-    },
-    {
-        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that subsequently misses the L3",
-        "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.LLC_MISS / MEM_BOUND_ST=
ALLS_LOAD.ALL",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3mis=
s"
-    },
     {
         "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L2",
         "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.L2_HIT / MEM_BOUND_STAL=
LS_LOAD.ALL",
@@ -584,16 +525,6 @@
         "MetricExpr": "1e3 * MACHINE_CLEARS.SMC / INST_RETIRED.ANY",
         "MetricName": "tma_info_machine_clear_bound_machine_clears_smc_pki=
"
     },
-    {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h an address aliasing block",
-        "MetricExpr": "tma_info_mem_exec_blocks_loads_with_adressaliasing"=
,
-        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_adressaliasin=
g"
-    },
-    {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
-        "MetricExpr": "tma_info_mem_exec_blocks_loads_with_storefwdblk",
-        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_storefwdblk"
-    },
     {
         "BriefDescription": "Percentage of total non-speculative loads wit=
h an address aliasing block",
         "MetricExpr": "100 * LD_BLOCKS.ADDRESS_ALIAS / MEM_UOPS_RETIRED.AL=
L_LOADS",
@@ -606,31 +537,6 @@
         "MetricName": "tma_info_mem_exec_blocks_loads_with_storefwdblk",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 first level data cache miss",
-        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_l1miss",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_l1miss"
-    },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to o=
ther block cases, such as pipeline conflicts, fences, etc",
-        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_otherpipeline=
blks",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_otherpipeli=
neblks"
-    },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 pagewalk",
-        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_pagewalk",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_pagewalk"
-    },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 second level TLB miss",
-        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_stlbhit",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_stlbhit"
-    },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 store forward address match",
-        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_storefwding",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_storefwding=
"
-    },
     {
         "BriefDescription": "Percentage of Memory Execution Bound due to a=
 first level data cache miss",
         "MetricExpr": "100 * LD_HEAD.L1_MISS_AT_RET / LD_HEAD.ANY_AT_RET",
@@ -686,11 +592,6 @@
         "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / TOPDOWN_RETIRING=
.ALL_P",
         "MetricName": "tma_info_mem_mix_memload_ratio"
     },
-    {
-        "BriefDescription": "Percentage of time that the core is stalled d=
ue to a TPAUSE or UMWAIT instruction",
-        "MetricExpr": "tma_info_serialization_tpause_cycles",
-        "MetricName": "tma_info_serialization _%_tpause_cycles"
-    },
     {
         "BriefDescription": "Percentage of time that the core is stalled d=
ue to a TPAUSE or UMWAIT instruction",
         "MetricExpr": "100 * SERIALIZATION.C01_MS_SCB / (6 * CPU_CLK_UNHAL=
TED.CORE)",
@@ -711,14 +612,17 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "cpu@CPU_CLK_UNHALTED.CORE_P@k / CPU_CLK_UNHALTED.CO=
RE",
-        "MetricGroup": "Summary",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P:k / CPU_CLK_UNHALTED.CORE",
         "MetricName": "tma_info_system_kernel_utilization"
     },
+    {
+        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P / CPU_CLK_UNHALTED.CORE",
+        "MetricName": "tma_info_system_mux"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricGroup": "Power",
         "MetricName": "tma_info_system_turbo_utilization"
     },
     {
@@ -742,102 +646,90 @@
         "MetricName": "tma_info_uop_mix_x87_uop_ratio"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB=
) misses.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB=
) misses",
         "MetricExpr": "TOPDOWN_FE_BOUND.ITLB_MISS / (6 * CPU_CLK_UNHALTED.=
CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_ifetch_latency >=
 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation",
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / (6 * CPU_C=
LK_UNHALTED.CORE)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
+        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_bad_speculation_g=
roup",
         "MetricName": "tma_machine_clears",
-        "MetricThreshold": "tma_machine_clears > 0.05 & tma_bad_speculatio=
n > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to memory reservation stalls in which a sched=
uler is not able to accept uops",
         "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / (6 * CPU_CLK_UNHAL=
TED.CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
         "MetricName": "tma_mem_scheduler",
-        "MetricThreshold": "tma_mem_scheduler > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to IEC or FPC RAT stalls, which can be due to=
 FIQ or IEC reservation stalls in which the integer, floating point or SIMD=
 scheduler is not able to accept uops",
         "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / (6 * CPU_CLK_U=
NHALTED.CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
         "MetricName": "tma_non_mem_scheduler",
-        "MetricThreshold": "tma_non_mem_scheduler > 0.1 & (tma_resource_bo=
und > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that requires the use of m=
icrocode (slow nuke)",
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / (6 * CPU_CLK_UNHALTE=
D.CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_machine_clears_gr=
oup",
         "MetricName": "tma_nuke",
-        "MetricThreshold": "tma_nuke > 0.05 & (tma_machine_clears > 0.05 &=
 tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to other common frontend stalls not categor=
ized.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to other common frontend stalls not categor=
ized",
         "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
         "MetricName": "tma_other_fb",
-        "MetricThreshold": "tma_other_fb > 0.05 & (tma_ifetch_bandwidth > =
0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to wrong predecodes.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to wrong predecodes",
         "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / (6 * CPU_CLK_UNHALTED.=
CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
         "MetricName": "tma_predecode",
-        "MetricThreshold": "tma_predecode > 0.05 & (tma_ifetch_bandwidth >=
 0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the physical register file unable to accep=
t an entry (marble stalls)",
         "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / (6 * CPU_CLK_UNHALTED.C=
ORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
         "MetricName": "tma_register",
-        "MetricThreshold": "tma_register > 0.1 & (tma_resource_bound > 0.2=
 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the reorder buffer being full (ROB stalls)=
",
         "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / (6 * CPU_CLK_UNHA=
LTED.CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
         "MetricName": "tma_reorder_buffer",
-        "MetricThreshold": "tma_reorder_buffer > 0.1 & (tma_resource_bound=
 > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a resource limitation",
         "MetricExpr": "tma_backend_bound - tma_core_bound",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_backend_bound_gro=
up",
         "MetricName": "tma_resource_bound",
-        "MetricThreshold": "tma_resource_bound > 0.2 & tma_backend_bound >=
 0.1",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that result =
in retirement slots",
         "MetricExpr": "TOPDOWN_RETIRING.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
-        "MetricThreshold": "tma_retiring > 0.75",
         "MetricgroupNoGroup": "TopdownL1",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to scoreboards from the instruction queue (IQ=
), jump execution unit (JEU), or microcode sequencer (MS)",
         "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / (6 * CPU_CLK_UNHAL=
TED.CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
         "MetricName": "tma_serialization",
-        "MetricThreshold": "tma_serialization > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/grandridge/pipeline.json
index b67c0c89054d..40fa4f5ae261 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
@@ -1,6 +1,6 @@
 [
     {
-        "BriefDescription": "Counts the number of cycles when any of the d=
ividers are active.",
+        "BriefDescription": "Counts the number of cycles when any of the f=
loating point or integer dividers are active.",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xcd",
@@ -185,7 +185,6 @@
         "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
index 1eaf796601b1..6a80cf6cbd36 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
@@ -573,7 +573,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Code read from local IA that miss the cache",
+        "BriefDescription": "Code read from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD",
@@ -593,7 +593,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data read opt from local IA that miss the cac=
he",
+        "BriefDescription": "Data read opt from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.json
index 6aaca4039107..2c18767511f3 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.json
@@ -183,6 +183,26 @@
         "PerPkg": "1",
         "Unit": "IRP"
     },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.FAST_REJ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.FAST_REQ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Misc Events - Set 1 : Lost Forward : Snoop pu=
lled away ownership before a write was committed",
         "Counter": "0,1,2,3",
@@ -193,6 +213,46 @@
         "UMask": "0x10",
         "Unit": "IRP"
     },
+    {
+        "BriefDescription": "Snoop Hit E/S responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_ES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x74",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Hit I responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x72",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Hit M responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_M",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop miss responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x71",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Inbound write (fast path) requests to coheren=
t memory, received by the IRP resulting in write ownership requests issued =
by IRP to the mesh.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json b/too=
ls/perf/pmu-events/arch/x86/grandridge/uncore-io.json
index 33fc7b835abf..c5b05c71c56d 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json
@@ -17,7 +17,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -29,7 +29,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -41,7 +41,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -53,7 +53,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -65,7 +65,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -77,7 +77,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -89,7 +89,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -101,7 +101,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -113,7 +113,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -125,7 +125,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff0ff",
+        "UMask": "0xff",
         "Unit": "IIO"
     },
     {
@@ -137,7 +137,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -149,7 +149,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -161,7 +161,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -173,7 +173,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -185,7 +185,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010010",
+        "UMask": "0x10",
         "Unit": "IIO"
     },
     {
@@ -197,7 +197,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020020",
+        "UMask": "0x20",
         "Unit": "IIO"
     },
     {
@@ -209,7 +209,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040040",
+        "UMask": "0x40",
         "Unit": "IIO"
     },
     {
@@ -221,7 +221,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080080",
+        "UMask": "0x80",
         "Unit": "IIO"
     },
     {
@@ -232,7 +232,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -244,7 +244,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -256,7 +256,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -268,7 +268,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -280,7 +280,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -292,7 +292,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -304,7 +304,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -316,7 +316,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -328,7 +328,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -339,7 +339,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -350,7 +350,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -361,7 +361,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -372,7 +372,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -383,7 +383,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -394,7 +394,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -405,7 +405,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -416,7 +416,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -427,7 +427,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -438,7 +438,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -449,7 +449,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x02",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -460,7 +460,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x04",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -471,7 +471,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x08",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -482,7 +482,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x10",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -493,7 +493,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x20",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -504,7 +504,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x40",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -515,7 +515,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x80",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -526,7 +526,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -537,7 +537,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x02",
-        "UMask": "0x7002001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -548,7 +548,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x04",
-        "UMask": "0x7004001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -559,7 +559,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x08",
-        "UMask": "0x7008001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -570,7 +570,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x10",
-        "UMask": "0x7010001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -581,7 +581,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x20",
-        "UMask": "0x7020001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -592,7 +592,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x40",
-        "UMask": "0x7040001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -603,7 +603,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x80",
-        "UMask": "0x7080001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -615,7 +615,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -627,7 +627,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -639,7 +639,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -651,7 +651,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -663,7 +663,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -675,7 +675,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -687,7 +687,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -699,7 +699,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -832,7 +832,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff080",
+        "UMask": "0x80",
         "Unit": "IIO"
     },
     {
@@ -844,7 +844,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff040",
+        "UMask": "0x40",
         "Unit": "IIO"
     },
     {
@@ -856,7 +856,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff020",
+        "UMask": "0x20",
         "Unit": "IIO"
     },
     {
@@ -868,7 +868,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -880,7 +880,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -892,7 +892,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -904,7 +904,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -925,7 +925,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -936,7 +936,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -947,7 +947,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -958,7 +958,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -969,7 +969,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -980,7 +980,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -991,7 +991,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1002,7 +1002,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1013,7 +1013,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1024,7 +1024,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1035,7 +1035,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1046,7 +1046,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1057,7 +1057,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1068,7 +1068,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1079,7 +1079,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1090,7 +1090,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1101,7 +1101,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1112,7 +1112,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1123,7 +1123,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1134,7 +1134,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1145,7 +1145,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1156,7 +1156,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1167,7 +1167,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1178,7 +1178,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1189,7 +1189,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1200,7 +1200,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1211,7 +1211,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1222,7 +1222,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1233,7 +1233,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1244,7 +1244,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1255,7 +1255,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1266,7 +1266,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1278,7 +1278,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1290,7 +1290,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1302,7 +1302,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1314,7 +1314,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1326,7 +1326,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1338,7 +1338,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1350,7 +1350,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1362,7 +1362,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080002",
+        "UMask": "0x2",
         "Unit": "IIO"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
index 7e6e6764f181..e75b3050ccd5 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
@@ -169,7 +169,7 @@
         "Unit": "IMC"
     },
     {
-        "BriefDescription": "Number of DRAM DCLK clock cycles while the ev=
ent is enabled",
+        "BriefDescription": "Number of DRAM DCLK clock cycles while the ev=
ent is enabled.  DCLK is 1/4 of DRAM data rate.",
         "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_M_CLOCKTICKS",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 04a99e4767ef..1a28f9d70e74 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -11,7 +11,7 @@ GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.11,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
-GenuineIntel-6-B6,v1.03,grandridge,core
+GenuineIntel-6-B6,v1.05,grandridge,core
 GenuineIntel-6-A[DE],v1.02,graniterapids,core
 GenuineIntel-6-(3C|45|46),v35,haswell,core
 GenuineIntel-6-3F,v28,haswellx,core
--=20
2.47.1.545.g3c1d2e2a6a-goog

