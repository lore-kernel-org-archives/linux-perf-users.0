Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D41DEFEC
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184242; cv=none; b=PLUYVgOcxq5FnPjR11QBryQ04tcb5Tl6chdOwelhkjWFNscmfashYFVdxZ7rQ7zUMx4BDjAHIPhRqgQ4+Sd6GhRDBRDVYE7Q8TvLwY7fPXaw0Nhrg+T678Fa3vwnWt8AqENDr6kcBdlZFNQjyc039ZlglLnDVVaH8nV6Ge5U8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184242; c=relaxed/simple;
	bh=dSSEt37vVayxhTDFxGUmPPx5woSstANHnfsjL5Qm+Gc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=m7LHyYhB+St+3XgdhojdwF/awKcYRawuioW6BSFfC9V0ZKJUcCXo0hlKhwYoHWG7LxEg18klqrCMFVOHm4je2AHyz+z7hzrFDlsWdg+/BRK4+GjM7YnkrER0o+MactKqvDm9SZ2QqhN5yym1eWSvz3OBfrQlSJvIsDLlbNpW1WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTAo3RDr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTAo3RDr"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2240c997059so53639765ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743184234; x=1743789034; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSXnTbk4voMY/wNNkFTb+y053l8KHfYnN3nPa6KFR0k=;
        b=RTAo3RDrUI9GqNdFT/0S83uqNeZzNQt1eaqtvTYph4GHhLjq5JRxnRNxkwszmwf8A7
         Z20HU175o37ncYQ5J6iRLKhi3W2ZuGilD7akm5zdt3rqGXfKN0Ny2c1j+fdqThAY1Ttj
         7b5tScd8l/pN8Qg7KMWWcbC916Q518xHt2K/OYDil2Us0N8/qvARLnE36E8TJIXuuZts
         Nm3Q9i5vjV+q9laqK2CvTB+kV/VbhsqTdYM5WbfBRqDlh1Yf6ggEg9gJCAGrqUgsh8eb
         Xvb5azkzKSw+/kmx2/Zp60BVqInMoCdOueWx496f3dTYKM1imM5oFbDGyxW+fqMFAPrm
         /bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743184234; x=1743789034;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gSXnTbk4voMY/wNNkFTb+y053l8KHfYnN3nPa6KFR0k=;
        b=AgoWYonn/SAtALzqtpzdmHvcqI2+MhfeWVm6W6XPPsNZK0MsPhdpE7hYN2T0Su6tY6
         7qhVL3sr+d2KFaq5P6d2CN8rpAJNiv36XMXjtBxse+lAg2f7FOwYtaJ0jze7ImpA2hDa
         cjRfa427Va6RzLV3DgWvVfrnuJk2/B5h/nhwabfGLq9lTTJxTrKc4JwYvZ6/nr/gJC2Z
         EBzEXHo1oFWmF4OzuYd/1XRctAxfbBDYFQswTSqtn4abf25VeOualHY/dD6+OdE9sCBg
         ut+sHWC9Wj1CxgCYAPwOIjrqUkPLnNtAeIJvdH/vFjqOt51pGBtTncKn0AwjTWRJei0l
         0rtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0CFACe/wmMcYonQBajIZtzYM4qEDjhNuGmnYxy9ESV+mS6u8Yn72oW9Mc38GBYBPxPthTBa09KZQteXy1D2Yw@vger.kernel.org
X-Gm-Message-State: AOJu0YyUidPapkP0LS0HRineX+IEbgfRL+NZslNaNgzBb5Tet8Qo+4wk
	ErSCvtDIoIGD+ruinR++bnNJK2mR3ieJv240R8dHsjWT5y7ItYtHaKRAqvpegCaGMZVsB9A6eEN
	MGXao3g==
X-Google-Smtp-Source: AGHT+IGAL+tUdl6ZXRYdHyP3GO58zq239jvytvXoPdzHLjlsxghDhE80na3KTYLDyh5W1vaM/Tok2OJmfLIv
X-Received: from plblw8.prod.google.com ([2002:a17:903:2ac8:b0:220:ddee:5ee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:120c:b0:220:cd9a:a167
 with SMTP id d9443c01a7336-2292f942c16mr1262675ad.4.1743184233712; Fri, 28
 Mar 2025 10:50:33 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:49:36 -0700
In-Reply-To: <20250328175006.43110-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328175006.43110-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328175006.43110-6-irogers@google.com>
Subject: [PATCH v5 05/35] perf vendor events: Update broadwell metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Switch to metrics generated from the TMA spreadsheet. Minor threshold
simplification.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwell/bdw-metrics.json       | 256 +++++++++---------
 1 file changed, 127 insertions(+), 129 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/to=
ols/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
index 40970fa5566c..89750117a7f6 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
@@ -74,12 +74,12 @@
         "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_4k_aliasing",
-        "MetricThreshold": "tma_4k_aliasing > 0.2 & tma_l1_bound > 0.1 & t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates how often memory load =
accesses were aliased by preceding stores (in program order) with a 4K addr=
ess offset. False match is possible; which incur a few cycles load re-issue=
. However; the short re-issue duration is often hidden by the out-of-order =
core and HW optimizations; hence a user may safely ignore a high value of t=
his metric unless it manages to propagate up into parent nodes of the hiera=
rchy (e.g. to L1_Bound)",
+        "MetricThreshold": "tma_4k_aliasing > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates how often memory load =
accesses were aliased by preceding stores (in program order) with a 4K addr=
ess offset. False match is possible; which incur a few cycles load re-issue=
. However; the short re-issue duration is often hidden by the out-of-order =
core and HW optimizations; hence a user may safely ignore a high value of t=
his metric unless it manages to propagate up into parent nodes of the hiera=
rchy (e.g. to L1_Bound).",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_thread_slots",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
@@ -92,8 +92,8 @@
         "MetricExpr": "66 * OTHER_ASSISTS.ANY_WB_ASSIST / tma_info_thread_=
slots",
         "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequence=
r_group",
         "MetricName": "tma_assists",
-        "MetricThreshold": "tma_assists > 0.1 & tma_microcode_sequencer > =
0.05 & tma_heavy_operations > 0.1",
-        "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: OTHER_ASSISTS.AN=
Y_WB_ASSIST",
+        "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
+        "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: OTHER_ASSISTS.AN=
Y",
         "ScaleUnit": "100%"
     },
     {
@@ -104,7 +104,7 @@
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound",
+        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
         "ScaleUnit": "100%"
     },
     {
@@ -114,7 +114,7 @@
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
         "ScaleUnit": "100%"
     },
     {
@@ -125,7 +125,7 @@
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_mispredicts_resteers",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_bad_spec_branch_misprediction_cost, tma_mispredicts_resteers",
         "ScaleUnit": "100%"
     },
     {
@@ -133,8 +133,8 @@
         "MetricExpr": "12 * (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS=
.COUNT + BACLEARS.ANY) / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
         "MetricName": "tma_branch_resteers",
-        "MetricThreshold": "tma_branch_resteers > 0.05 & tma_fetch_latency=
 > 0.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES. Related metrics: tma_l3_hit_latency, tma_store_latency",
+        "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
         "ScaleUnit": "100%"
     },
     {
@@ -143,8 +143,8 @@
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.1 & tma_microcode_sequencer > 0.0=
5 & tma_heavy_operations > 0.1",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources",
+        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequencer > 0.=
05 & tma_heavy_operations > 0.1)",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources.",
         "ScaleUnit": "100%"
     },
     {
@@ -152,7 +152,7 @@
         "MetricExpr": "MACHINE_CLEARS.COUNT * tma_branch_resteers / (BR_MI=
SP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY)",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
-        "MetricThreshold": "tma_clears_resteers > 0.05 & tma_branch_restee=
rs > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears. Rel=
ated metrics: tma_l1_bound, tma_machine_clears, tma_microcode_sequencer, tm=
a_ms_switches",
         "ScaleUnit": "100%"
     },
@@ -162,8 +162,8 @@
         "MetricExpr": "(60 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM * (1 =
+ MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_=
UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS=
_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LO=
AD_UOPS_RETIRED.L3_MISS))) + 43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS *=
 (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_=
UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + ME=
M_LOAD_UOPS_RETIRED.L3_MISS)))) / tma_info_thread_clks",
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
-        "MetricThreshold": "tma_contested_accesses > 0.05 & tma_l3_bound >=
 0.05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM, MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MIS=
S. Related metrics: tma_data_sharing, tma_false_sharing, tma_machine_clears=
",
+        "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS. Re=
lated metrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma=
_remote_cache",
         "ScaleUnit": "100%"
     },
     {
@@ -174,7 +174,7 @@
         "MetricName": "tma_core_bound",
         "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2=
",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
         "ScaleUnit": "100%"
     },
     {
@@ -183,8 +183,8 @@
         "MetricExpr": "43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT * (1 + =
MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UO=
PS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L=
3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD=
_UOPS_RETIRED.L3_MISS))) / tma_info_thread_clks",
         "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issu=
eSyncxn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
-        "MetricThreshold": "tma_data_sharing > 0.05 & tma_l3_bound > 0.05 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_UOPS_L3_HIT_RETIRED.XSNP_HIT. Related metrics: tma_contested_accesses, t=
ma_false_sharing, tma_machine_clears",
+        "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_HIT_PS. Related metrics: tma_contested_accesses, tma=
_false_sharing, tma_machine_clears, tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
@@ -192,8 +192,8 @@
         "MetricExpr": "ARITH.FPU_DIV_ACTIVE / tma_info_core_core_clks",
         "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
-        "MetricThreshold": "tma_divider > 0.2 & tma_core_bound > 0.1 & tma=
_backend_bound > 0.2",
-        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.FPU_DIV_ACTIVE",
+        "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
         "ScaleUnit": "100%"
     },
     {
@@ -202,8 +202,8 @@
         "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_=
RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STALL=
S_L2_MISS / tma_info_thread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
-        "MetricThreshold": "tma_dram_bound > 0.1 & tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_RE=
TIRED.L3_MISS",
+        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_RE=
TIRED.L3_MISS_PS",
         "ScaleUnit": "100%"
     },
     {
@@ -212,7 +212,7 @@
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
         "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
         "ScaleUnit": "100%"
     },
     {
@@ -220,26 +220,26 @@
         "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_thread_=
clks",
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
-        "MetricThreshold": "tma_dsb_switches > 0.05 & tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Related metrics: tma_fetch_bandw=
idth, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "(8 * DTLB_LOAD_MISSES.STLB_HIT + cpu@DTLB_LOAD_MISS=
ES.WALK_DURATION\\,cmask\\=3D0x1@ + 7 * DTLB_LOAD_MISSES.WALK_COMPLETED) / =
tma_info_thread_clks",
+        "MetricExpr": "(8 * DTLB_LOAD_MISSES.STLB_HIT + cpu@DTLB_LOAD_MISS=
ES.WALK_DURATION\\,cmask\\=3D1@ + 7 * DTLB_LOAD_MISSES.WALK_COMPLETED) / tm=
a_info_thread_clks",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_l1_bound_group",
         "MetricName": "tma_dtlb_load",
-        "MetricThreshold": "tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma=
_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_UOPS_RETIRED.STLB_MISS_LOADS. Related metrics: tma_=
dtlb_store",
+        "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_UOPS_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(8 * DTLB_STORE_MISSES.STLB_HIT + cpu@DTLB_STORE_MI=
SSES.WALK_DURATION\\,cmask\\=3D0x1@ + 7 * DTLB_STORE_MISSES.WALK_COMPLETED)=
 / tma_info_thread_clks",
+        "MetricExpr": "(8 * DTLB_STORE_MISSES.STLB_HIT + cpu@DTLB_STORE_MI=
SSES.WALK_DURATION\\,cmask\\=3D1@ + 7 * DTLB_STORE_MISSES.WALK_COMPLETED) /=
 tma_info_thread_clks",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_store_bound_group",
         "MetricName": "tma_dtlb_store",
-        "MetricThreshold": "tma_dtlb_store > 0.05 & tma_store_bound > 0.2 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_UOPS_RETIRED.STLB_MISS_STORES. Related metrics: tma_dtlb_load",
+        "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_UOPS_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load",
         "ScaleUnit": "100%"
     },
     {
@@ -247,18 +247,18 @@
         "MetricExpr": "60 * OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM =
/ tma_info_thread_clks",
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
-        "MetricThreshold": "tma_false_sharing > 0.05 & tma_store_bound > 0=
.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: MEM_LOAD_UOPS_L3=
_HIT_RETIRED.XSNP_HITM, OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM. Rela=
ted metrics: tma_contested_accesses, tma_data_sharing, tma_machine_clears",
+        "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: MEM_LOAD_L3_HIT_=
RETIRED.XSNP_HITM_PS;OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM. Related=
 metrics: tma_contested_accesses, tma_data_sharing, tma_machine_clears, tma=
_remote_cache",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu@L1D_PE=
ND_MISS.FB_FULL\\,cmask\\=3D0x1@ / tma_info_thread_clks",
+        "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu@L1D_PE=
ND_MISS.FB_FULL\\,cmask\\=3D1@ / tma_info_thread_clks",
         "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_system_dram_bw_use, tma_mem_ba=
ndwidth, tma_sq_full, tma_store_latency",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_system_dram_bw_use, tma_mem_ba=
ndwidth, tma_sq_full, tma_store_latency, tma_streaming_stores",
         "ScaleUnit": "100%"
     },
     {
@@ -287,7 +287,7 @@
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
         "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > 0.=
6",
-        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
         "ScaleUnit": "100%"
     },
     {
@@ -295,8 +295,8 @@
         "MetricExpr": "FP_ARITH_INST_RETIRED.SCALAR / UOPS_RETIRED.RETIRE_=
SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
-        "MetricThreshold": "tma_fp_scalar > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports=
_utilized_2",
+        "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5, t=
ma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -304,8 +304,8 @@
         "MetricExpr": "FP_ARITH_INST_RETIRED.VECTOR / UOPS_RETIRED.RETIRE_=
SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
-        "MetricThreshold": "tma_fp_vector > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_port_0, tma_port_=
1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -313,8 +313,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
-        "MetricThreshold": "tma_fp_vector_128b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_port_0, tma_port_1, tma_port_5, tma_p=
ort_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_=
1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -322,8 +322,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
-        "MetricThreshold": "tma_fp_vector_256b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_port_0, tma_port_1, tma_port_5, tma_p=
ort_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_fp_vector_512b, tma_port_0, tma_port_=
1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -333,33 +333,33 @@
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound",
+        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound.",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations , instructions that require =
two or more uops or micro-coded sequences",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
         "MetricExpr": "tma_microcode_sequencer",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations , instructions that require=
 two or more uops or micro-coded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.([ICL+] Note this may overcount=
 due to approximation using indirect events; [ADL+])",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences.([ICL+] Note this may overcoun=
t due to approximation using indirect events; [ADL+])",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
         "MetricExpr": "ICACHE.IFDATA_STALL / tma_info_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
         "MetricExpr": "tma_info_inst_mix_instructions / (UOPS_RETIRED.RETI=
RE_SLOTS / UOPS_ISSUED.ANY * BR_MISP_EXEC.INDIRECT)",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
-        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1000"
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
     },
     {
         "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
@@ -370,7 +370,7 @@
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else tm=
a_info_thread_clks)",
+        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / 2 * (1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK) if #core_wide < 1 else (CP=
U_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else tma_info_thread_clks))",
         "MetricGroup": "SMT",
         "MetricName": "tma_info_core_core_clks"
     },
@@ -391,11 +391,11 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + FP_ARITH_INST_RETIR=
ED.VECTOR) / (2 * tma_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)"
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D0x1@",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_core_ilp"
     },
@@ -420,7 +420,7 @@
         "MetricName": "tma_info_frontend_tbpc"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch",
+        "BriefDescription": "Branch instructions per taken branch.",
         "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
         "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "tma_info_inst_mix_bptkbranch"
@@ -438,7 +438,7 @@
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
         "MetricThreshold": "tma_info_inst_mix_iparith < 10",
-        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW"
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
@@ -446,7 +446,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx128",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
@@ -454,7 +454,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx256",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
@@ -462,7 +462,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
@@ -470,7 +470,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
@@ -512,7 +512,7 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
         "MetricName": "tma_info_inst_mix_iptb",
-        "MetricThreshold": "tma_info_inst_mix_iptb < 4 * 2 + 1",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 9",
         "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, =
tma_lcp"
     },
     {
@@ -634,20 +634,20 @@
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "(cpu@ITLB_MISSES.WALK_DURATION\\,cmask\\=3D0x1@ + c=
pu@DTLB_LOAD_MISSES.WALK_DURATION\\,cmask\\=3D0x1@ + cpu@DTLB_STORE_MISSES.=
WALK_DURATION\\,cmask\\=3D0x1@ + 7 * (DTLB_STORE_MISSES.WALK_COMPLETED + DT=
LB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED)) / tma_info_cor=
e_core_clks",
+        "MetricExpr": "(cpu@ITLB_MISSES.WALK_DURATION\\,cmask\\=3D1@ + cpu=
@DTLB_LOAD_MISSES.WALK_DURATION\\,cmask\\=3D1@ + cpu@DTLB_STORE_MISSES.WALK=
_DURATION\\,cmask\\=3D1@ + 7 * (DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOA=
D_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED)) / tma_info_core_core=
_clks",
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "tma_info_memory_tlb_page_walks_utilization",
         "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D0x1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
+        "BriefDescription": "",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D0x1@",
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire"
     },
@@ -688,14 +688,13 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
         "MetricGroup": "Branches;OS",
         "MetricName": "tma_info_system_ipfarbranch",
-        "MetricThreshold": "tma_info_system_ipfarbranch < 1000000"
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6"
     },
     {
         "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
         "MetricGroup": "OS",
-        "MetricName": "tma_info_system_kernel_cpi",
-        "ScaleUnit": "1per_instr"
+        "MetricName": "tma_info_system_kernel_cpi"
     },
     {
         "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
@@ -743,7 +742,7 @@
         "MetricName": "tma_info_system_turbo_utilization"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active",
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Pipeline",
         "MetricName": "tma_info_thread_clks"
@@ -752,15 +751,14 @@
         "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
         "MetricExpr": "1 / tma_info_thread_ipc",
         "MetricGroup": "Mem;Pipeline",
-        "MetricName": "tma_info_thread_cpi",
-        "ScaleUnit": "1per_instr"
+        "MetricName": "tma_info_thread_cpi"
     },
     {
         "BriefDescription": "The ratio of Executed- by Issued-Uops",
         "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
         "MetricGroup": "Cor;Pipeline",
         "MetricName": "tma_info_thread_execute_per_issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage"
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
     },
     {
         "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
@@ -786,14 +784,14 @@
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / BR_INST_RETIRED.NEAR_TA=
KEN",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "tma_info_thread_uptb",
-        "MetricThreshold": "tma_info_thread_uptb < 4 * 1.5"
+        "MetricThreshold": "tma_info_thread_uptb < 6"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
-        "MetricExpr": "(14 * ITLB_MISSES.STLB_HIT + cpu@ITLB_MISSES.WALK_D=
URATION\\,cmask\\=3D0x1@ + 7 * ITLB_MISSES.WALK_COMPLETED) / tma_info_threa=
d_clks",
+        "MetricExpr": "(14 * ITLB_MISSES.STLB_HIT + cpu@ITLB_MISSES.WALK_D=
URATION\\,cmask\\=3D1@ + 7 * ITLB_MISSES.WALK_COMPLETED) / tma_info_thread_=
clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: ITLB_M=
ISSES.WALK_COMPLETED",
         "ScaleUnit": "100%"
     },
@@ -802,8 +800,8 @@
         "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
-        "MetricThreshold": "tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & =
tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1D. Another example is loads who miss in the TLB.=
 These cases are characterized by execution unit stalls; while some non-com=
pleted demand load lives in the machine without having that demand load mis=
sing the L1 cache. Sample with: MEM_LOAD_UOPS_RETIRED.L1_HIT. Related metri=
cs: tma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tma_m=
s_switches, tma_ports_utilized_1",
+        "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1D. Another example is loads who miss in the TLB.=
 These cases are characterized by execution unit stalls; while some non-com=
pleted demand load lives in the machine without having that demand load mis=
sing the L1 cache. Sample with: MEM_LOAD_UOPS_RETIRED.L1_HIT_PS. Related me=
trics: tma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tm=
a_ms_switches, tma_ports_utilized_1",
         "ScaleUnit": "100%"
     },
     {
@@ -811,8 +809,8 @@
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.ST=
ALLS_L2_MISS) / tma_info_thread_clks",
         "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
-        "MetricThreshold": "tma_l2_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_UOPS_RETIRED.L2_HIT",
+        "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_UOPS_RETIRED.L2_HIT_PS",
         "ScaleUnit": "100%"
     },
     {
@@ -821,8 +819,8 @@
         "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETIR=
ED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS) * CYCLE_ACTIVITY.STALLS_L2_M=
ISS / tma_info_thread_clks",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
-        "MetricThreshold": "tma_l3_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT",
+        "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
         "ScaleUnit": "100%"
     },
     {
@@ -831,8 +829,8 @@
         "MetricExpr": "29 * (MEM_LOAD_UOPS_RETIRED.L3_HIT * (1 + MEM_LOAD_=
UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIRE=
D.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_HIT_RET=
IRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOPS_RET=
IRED.L3_MISS))) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
-        "MetricThreshold": "tma_l3_hit_latency > 0.1 & tma_l3_bound > 0.05=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT. Related metrics: =
tma_branch_resteers, tma_mem_latency, tma_store_latency",
+        "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS. Related metric=
s: tma_mem_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -840,18 +838,18 @@
         "MetricExpr": "ILD_STALL.LCP / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
-        "MetricThreshold": "tma_lcp > 0.05 & tma_fetch_latency > 0.1 & tma=
_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. Related metr=
ics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage,=
 tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations , instructions that require =
no more than one uop (micro-operation)",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
         "MetricExpr": "tma_retiring - tma_heavy_operations",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_light_operations",
         "MetricThreshold": "tma_light_operations > 0.6",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations , instructions that require=
 no more than one uop (micro-operation). This correlates with total number =
of instructions used by the program. A uops-per-instruction (see UopPI metr=
ic) ratio of 1 or less should be expected for decently optimized code runni=
ng on Intel Core/Xeon products. While this often indicates efficient X86 in=
structions were executed; high value does not necessarily mean better perfo=
rmance cannot be achieved. ([ICL+] Note this may undercount due to approxim=
ation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIST=
",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UopPI met=
ric) ratio of 1 or less should be expected for decently optimized code runn=
ing on Intel Core/Xeon products. While this often indicates efficient X86 i=
nstructions were executed; high value does not necessarily mean better perf=
ormance cannot be achieved. ([ICL+] Note this may undercount due to approxi=
mation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIS=
T",
         "ScaleUnit": "100%"
     },
     {
@@ -870,8 +868,8 @@
         "MetricExpr": "MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.ALL_=
STORES * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCLES_W=
ITH_DEMAND_RFO) / tma_info_thread_clks",
         "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
-        "MetricThreshold": "tma_lock_latency > 0.2 & tma_l1_bound > 0.1 & =
tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_UOPS_RETIRED.LOCK_LOA=
DS. Related metrics: tma_store_latency",
+        "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_UOPS_RETIRED.LOCK_LOA=
DS_PS. Related metrics: tma_store_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -882,15 +880,15 @@
         "MetricName": "tma_machine_clears",
         "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation=
 > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sh=
aring, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sh=
aring, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_c=
ache",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D0x4@) / tma_info_thread_clks",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
         "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
-        "MetricThreshold": "tma_mem_bandwidth > 0.2 & tma_dram_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_fb_full, tma_info_system_dram_bw_u=
se, tma_sq_full",
         "ScaleUnit": "100%"
     },
@@ -899,7 +897,7 @@
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
         "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
-        "MetricThreshold": "tma_mem_latency > 0.1 & tma_dram_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_l3_hit_latency",
         "ScaleUnit": "100%"
     },
@@ -911,7 +909,7 @@
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
",
+        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
         "ScaleUnit": "100%"
     },
     {
@@ -928,8 +926,8 @@
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES * tma_branch_resteers =
/ (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY)",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_group;=
tma_branch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
-        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & tma_branch_r=
esteers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Related metrics: tma_branch_mispredicts",
+        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Related metrics: tma_branch_mispredicts, tma_info_bad=
_spec_branch_misprediction_cost",
         "ScaleUnit": "100%"
     },
     {
@@ -938,7 +936,7 @@
         "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
         "MetricName": "tma_mite",
         "MetricThreshold": "tma_mite > 0.1 & tma_fetch_bandwidth > 0.2",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck.",
         "ScaleUnit": "100%"
     },
     {
@@ -946,8 +944,8 @@
         "MetricExpr": "2 * IDQ.MS_SWITCHES / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
-        "MetricThreshold": "tma_ms_switches > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_clears_r=
esteers, tma_l1_bound, tma_machine_clears, tma_microcode_sequencer",
+        "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_clears_r=
esteers, tma_l1_bound, tma_machine_clears, tma_microcode_sequencer, tma_mix=
ing_vectors, tma_serializing_operation",
         "ScaleUnit": "100%"
     },
     {
@@ -956,7 +954,7 @@
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
         "MetricThreshold": "tma_port_0 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED_PORT.PORT_0. Related metrics: tma_fp_=
scalar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_port_1, =
tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512=
b, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -965,7 +963,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
         "MetricThreshold": "tma_port_1 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED_PORT.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vect=
or_128b, tma_fp_vector_256b, tma_port_0, tma_port_5, tma_port_6, tma_ports_=
utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_5, tma_por=
t_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1001,7 +999,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_5",
         "MetricThreshold": "tma_port_5 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+]=
 ALU). Sample with: UOPS_DISPATCHED_PORT.PORT_5. Related metrics: tma_fp_sc=
alar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_port_0, tm=
a_port_1, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+]=
 ALU). Sample with: UOPS_DISPATCHED.PORT_5. Related metrics: tma_fp_scalar,=
 tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1010,7 +1008,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED_PORT.PORT_1. Related metrics: tma_fp_s=
calar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_port_0, t=
ma_port_1, tma_port_5, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_1. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b=
, tma_port_0, tma_port_1, tma_port_5, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1028,43 +1026,43 @@
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_TOTAL + UOPS_EXECUTED.CYCLES=
_GE_1_UOP_EXEC - (UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC if tma_info_thread_ip=
c > 1.8 else UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) - (RS_EVENTS.EMPTY_CYCLES=
 if tma_fetch_latency > 0.1 else 0) + RESOURCE_STALLS.SB - RESOURCE_STALLS.=
SB - CYCLE_ACTIVITY.STALLS_MEM_ANY) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
-        "MetricThreshold": "tma_ports_utilization > 0.15 & tma_core_bound =
> 0.1 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations",
+        "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\=3D0x1\\,cmask\\=3D0=
x1@ / 2 if #SMT_on else CYCLE_ACTIVITY.STALLS_TOTAL - (RS_EVENTS.EMPTY_CYCL=
ES if tma_fetch_latency > 0.1 else 0)) / tma_info_core_core_clks",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (CYCLE_ACTIVITY.STALLS_TOTAL - (RS_EVENTS.EMPTY_CYCLES if tma=
_fetch_latency > 0.1 else 0)) / tma_info_core_core_clks)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
-        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric",
+        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@ - cpu@UOP=
S_EXECUTED.CORE\\,cmask\\=3D0x2@) / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_=
GE_1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / tma_info_core_core_c=
lks",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / tma_info_core_core_clks=
)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
-        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful. Related metrics: tma_l1_bound",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x2@ - cpu@UOP=
S_EXECUTED.CORE\\,cmask\\=3D0x3@) / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_=
GE_2_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_=
clks",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
2_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_clk=
s)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
-        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. R=
elated metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_128b, tma_fp_ve=
ctor_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6",
+        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. R=
elated metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_128b, tma_fp_ve=
ctor_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5, tma_port=
_6",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@ / 2 if #SM=
T_on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_clks",
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_clks",
         "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
-        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
     },
     {
@@ -1084,7 +1082,7 @@
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
         "MetricThreshold": "tma_split_loads > 0.3",
-        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_UOPS_RETIRED.SPLIT_LOADS",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_UOPS_RETIRED.SPLIT_LOADS_PS",
         "ScaleUnit": "100%"
     },
     {
@@ -1092,8 +1090,8 @@
         "MetricExpr": "2 * MEM_UOPS_RETIRED.SPLIT_STORES / tma_info_core_c=
ore_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
-        "MetricThreshold": "tma_split_stores > 0.2 & tma_store_bound > 0.2=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_UOPS_RETIRED.SPLIT_STORES. Related metrics: tma_port_4",
+        "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_UOPS_RETIRED.SPLIT_STORES_PS. Related metrics: tma_port_=
4",
         "ScaleUnit": "100%"
     },
     {
@@ -1101,7 +1099,7 @@
         "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / tma_info_core_core_clks",
         "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
-        "MetricThreshold": "tma_sq_full > 0.3 & tma_l3_bound > 0.05 & tma_=
memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_system_dram_bw_use, tma_mem_bandwidth",
         "ScaleUnit": "100%"
     },
@@ -1110,8 +1108,8 @@
         "MetricExpr": "RESOURCE_STALLS.SB / tma_info_thread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_store_bound",
-        "MetricThreshold": "tma_store_bound > 0.2 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_UOPS_RETIRED.ALL_STORES",
+        "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_UOPS_RETIRED.ALL_STORES_PS",
         "ScaleUnit": "100%"
     },
     {
@@ -1119,8 +1117,8 @@
         "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
-        "MetricThreshold": "tma_store_fwd_blk > 0.1 & tma_l1_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading",
+        "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
         "ScaleUnit": "100%"
     },
     {
@@ -1129,8 +1127,8 @@
         "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_UOPS_RETIRED.LOCK_=
LOADS / MEM_UOPS_RETIRED.ALL_STORES) + (1 - MEM_UOPS_RETIRED.LOCK_LOADS / M=
EM_UOPS_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
         "MetricGroup": "BvML;LockCont;MemoryLat;Offcore;TopdownL4;tma_L4_g=
roup;tma_issueRFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
-        "MetricThreshold": "tma_store_latency > 0.1 & tma_store_bound > 0.=
2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_branch_resteers, tma_fb_full, tma_l=
3_hit_latency, tma_lock_latency",
+        "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -1146,7 +1144,7 @@
         "MetricExpr": "tma_branch_resteers - tma_mispredicts_resteers - tm=
a_clears_resteers",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;TopdownL4;tma_L4_group;=
tma_branch_resteers_group",
         "MetricName": "tma_unknown_branches",
-        "MetricThreshold": "tma_unknown_branches > 0.05 & tma_branch_reste=
ers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit) hence called Unknown Bran=
ches. Sample with: BACLEARS.ANY",
         "ScaleUnit": "100%"
     },
@@ -1155,8 +1153,8 @@
         "MetricExpr": "INST_RETIRED.X87 * tma_info_thread_uoppi / UOPS_RET=
IRED.RETIRE_SLOTS",
         "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
         "MetricName": "tma_x87_use",
-        "MetricThreshold": "tma_x87_use > 0.1 & tma_fp_arith > 0.2 & tma_l=
ight_operations > 0.6",
-        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint",
+        "MetricThreshold": "tma_x87_use > 0.1 & (tma_fp_arith > 0.2 & tma_=
light_operations > 0.6)",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
         "ScaleUnit": "100%"
     }
 ]
--=20
2.49.0.472.ge94155a9ec-goog

