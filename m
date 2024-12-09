Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB519E830
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733783309; cv=none; b=X+Figwk0kh3PeWVXmsLMYDQ7RGueWfinM7ch3wUxYekZzclaXqW7lPG9nbUmd9tVLviZFxTnOR7mcdCwr7Qi2M6r/YKjF5PtnC+ulpIZa3oDV/o9R+pY1PqME8X1s7Ibbw3ZLLgx/WWqt6nEtGZBDFCwbVMuEHsU/cjvh8bSB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733783309; c=relaxed/simple;
	bh=QMD/NQd3y/kFOV/Q4ktNFvHsKetL2uEzjTfTDVW9G1M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=u1sWtolG8UosoqIlsjpRsNaJk6innCMey0KSG/w9/vp4a/TxSxAJYU+dQvbqNvGepDSbbXjglTZUniw0NW3iNTW2Mh0uBFGO/Ol+mmDdnsj7jO/YPvX60u2xntLywMM32lX3y2z9lvQTnpYBjO8cAk+NwcInQyGmCS8nYtQ1/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SFt8VZMP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SFt8VZMP"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef4e426a3fso8620747b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2024 14:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733783300; x=1734388100; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6mBkNzFLG1O9p0KXOTai1cQrkH8lnceohAy4x5XCtI=;
        b=SFt8VZMPZpyiK3FZPMt7kY2+ZDlghz5K5bkhgRP2uoIoT+yzOjQgLPkFchNPtnRKpY
         yWAb7bAIZa9HD4fOgQDhKD1wyId+zrdO485TIPzV4TBrQJW44MJ19jZ1OOTid467aJbc
         FwJizfH+ESJ/YrHqNUJfxPwE74BFfI0Y3PLbMbSN63RXIQkLKQWqwCceaVhLkWBOaZ3i
         i5ygJX75rVZkEDm9/UwuU8FGdldlHFQtLwzU4n5DdWXO2I6UfNKRFtR7rZxh1QA71jr2
         6yjTJaEcwgGdUsBilXUJR/8gQt880Kt80d5Vx/80g5vx2Jdi/Q1cmRWQKFkjRbY0wWXN
         Qg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733783300; x=1734388100;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V6mBkNzFLG1O9p0KXOTai1cQrkH8lnceohAy4x5XCtI=;
        b=PK0BEjDevOtXHdG08svZuzTytg2efS9G/CeLGSuo7P4OrBU7us2omGeTpQN01tL+qd
         ppqMp2Z1FYUenFoKn5PCv5lBpTf6OTk3IizzVIz/uQ8qjZx0yC23wiGSXLc2Hc0kUAIq
         At4MgcArHMPGxuqfQLBD+Zsw/VO+C0aolydz4l5t8zHvyNXExDOO2nKSkgYgC61fKayy
         003/Zek7w8ZRVUot6xjL2KxgpPFcZ3/REGsLNQQ988NFj141ihQVaII8gyhAwMX7s0bs
         a0TaL3agU33/e26DLogmbM4t1dGfsJc9mT1AQzqaUF+RHSCzKhjxeKKh+YtODn2OJ2jG
         YbEg==
X-Forwarded-Encrypted: i=1; AJvYcCXxLo/DSyd3dfkeumVg4bjGFqtmf1+0p2OunUx6pZTWQsmKLL702I/6aYgVoSHnudXb5HC4jjqJO7TVi7X8KGsD@vger.kernel.org
X-Gm-Message-State: AOJu0YwFcLGrZwB+UQvGgHFVdGKccBG1Rf/jF5oPlyAxGe9mU+6olkDW
	yNaQg/4emAf3hF9X1yNMkPFCGV9hh7xU1Agez1qtBRo5o1pREr6YFetCAs5qXuPCX84zej4ejje
	6HdfdNw==
X-Google-Smtp-Source: AGHT+IEqUuLU7+ggSEwPAgTeezC5Tl4PHPr1PuY2u36QyZo4W0X/UjwMgPdcypH7cMJnTwwmMuDJ+BKnwJkR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c8f1:280e:e8ad:32])
 (user=irogers job=sendgmr) by 2002:a05:690c:2506:b0:6f0:22ad:43f8 with SMTP
 id 00721157ae682-6f022ad7574mr114267b3.7.1733783299719; Mon, 09 Dec 2024
 14:28:19 -0800 (PST)
Date: Mon,  9 Dec 2024 14:27:42 -0800
In-Reply-To: <20241209222800.296000-1-irogers@google.com>
Message-Id: <20241209222800.296000-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209222800.296000-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.545.g3c1d2e2a6a-goog
Subject: [PATCH v1 05/22] perf vendor events: Update BroadwellDE events/metrics
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

Update events from v11 to v12.
Update TMA metrics from 4.8 to 5.01.

Bring in the event updates v12:
https://github.com/intel/perfmon/commit/e0b83388d545e527933031ddb2a1d22d650=
40de1

The TMA 5.01 update is from (with subsequent fixes):
https://github.com/intel/perfmon/commit/1d72913b2d938781fb28f3cc3507aaec5c2=
2d782

Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwellde/bdwde-metrics.json   | 256 ++++++++++--------
 .../arch/x86/broadwellde/cache.json           |  10 +-
 .../arch/x86/broadwellde/frontend.json        |   4 +-
 .../arch/x86/broadwellde/memory.json          |   6 +-
 .../arch/x86/broadwellde/metricgroups.json    |   5 +
 .../arch/x86/broadwellde/pipeline.json        |  10 +-
 .../arch/x86/broadwellde/uncore-cache.json    |  28 +-
 .../x86/broadwellde/uncore-interconnect.json  |  16 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 9 files changed, 184 insertions(+), 153 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json =
b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index 2e1380248684..b03a5f2bcd82 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -74,7 +74,7 @@
         "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_4k_aliasing",
-        "MetricThreshold": "tma_4k_aliasing > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_4k_aliasing > 0.2) & ((tma_l1_bound > 0.1=
) & ((tma_memory_bound > 0.2) & ((tma_backend_bound > 0.2))))",
         "PublicDescription": "This metric estimates how often memory load =
accesses were aliased by preceding stores (in program order) with a 4K addr=
ess offset. False match is possible; which incur a few cycles load re-issue=
. However; the short re-issue duration is often hidden by the out-of-order =
core and HW optimizations; hence a user may safely ignore a high value of t=
his metric unless it manages to propagate up into parent nodes of the hiera=
rchy (e.g. to L1_Bound).",
         "ScaleUnit": "100%"
     },
@@ -84,7 +84,7 @@
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_thread_slots",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
-        "MetricThreshold": "tma_alu_op_utilization > 0.4",
+        "MetricThreshold": "(tma_alu_op_utilization > 0.4)",
         "ScaleUnit": "100%"
     },
     {
@@ -92,7 +92,7 @@
         "MetricExpr": "66 * OTHER_ASSISTS.ANY_WB_ASSIST / tma_info_thread_=
slots",
         "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequence=
r_group",
         "MetricName": "tma_assists",
-        "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
+        "MetricThreshold": "(tma_assists > 0.1) & ((tma_microcode_sequence=
r > 0.05) & ((tma_heavy_operations > 0.1)))",
         "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
         "ScaleUnit": "100%"
     },
@@ -102,7 +102,7 @@
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
         "MetricGroup": "BvOB;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
-        "MetricThreshold": "tma_backend_bound > 0.2",
+        "MetricThreshold": "(tma_backend_bound > 0.2)",
         "MetricgroupNoGroup": "TopdownL1",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
         "ScaleUnit": "100%"
@@ -112,7 +112,7 @@
         "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_thread_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
-        "MetricThreshold": "tma_bad_speculation > 0.15",
+        "MetricThreshold": "(tma_bad_speculation > 0.15)",
         "MetricgroupNoGroup": "TopdownL1",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
         "ScaleUnit": "100%"
@@ -123,7 +123,7 @@
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * tma_bad_speculation",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
-        "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
+        "MetricThreshold": "(tma_branch_mispredicts > 0.1) & ((tma_bad_spe=
culation > 0.15))",
         "MetricgroupNoGroup": "TopdownL2",
         "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: =
tma_info_bad_spec_branch_misprediction_cost, tma_mispredicts_resteers",
         "ScaleUnit": "100%"
@@ -133,7 +133,7 @@
         "MetricExpr": "12 * (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS=
.COUNT + BACLEARS.ANY) / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
         "MetricName": "tma_branch_resteers",
-        "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
+        "MetricThreshold": "(tma_branch_resteers > 0.05) & ((tma_fetch_lat=
ency > 0.1) & ((tma_frontend_bound > 0.15)))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
         "ScaleUnit": "100%"
     },
@@ -143,7 +143,7 @@
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequencer > 0.=
05 & tma_heavy_operations > 0.1)",
+        "MetricThreshold": "(tma_cisc > 0.1) & ((tma_microcode_sequencer >=
 0.05) & ((tma_heavy_operations > 0.1)))",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources.",
         "ScaleUnit": "100%"
     },
@@ -152,7 +152,7 @@
         "MetricExpr": "MACHINE_CLEARS.COUNT * tma_branch_resteers / (BR_MI=
SP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY)",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
-        "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "MetricThreshold": "(tma_clears_resteers > 0.05) & ((tma_branch_re=
steers > 0.05) & ((tma_fetch_latency > 0.1) & ((tma_frontend_bound > 0.15))=
))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears. Sam=
ple with: INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound, tma=
_machine_clears, tma_microcode_sequencer, tma_ms_switches",
         "ScaleUnit": "100%"
     },
@@ -160,9 +160,9 @@
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(60 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM * (1 =
+ MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_=
UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS=
_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LO=
AD_UOPS_RETIRED.L3_MISS))) + 43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS *=
 (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_=
UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + ME=
M_LOAD_UOPS_RETIRED.L3_MISS)))) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_l3_bound_group",
+        "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
-        "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_contested_accesses > 0.05) & ((tma_l3_bou=
nd > 0.05) & ((tma_memory_bound > 0.2) & ((tma_backend_bound > 0.2))))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related m=
etrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma_remote=
_cache",
         "ScaleUnit": "100%"
     },
@@ -172,7 +172,7 @@
         "MetricExpr": "tma_backend_bound - tma_memory_bound",
         "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_b=
ackend_bound_group",
         "MetricName": "tma_core_bound",
-        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2=
",
+        "MetricThreshold": "(tma_core_bound > 0.1) & ((tma_backend_bound >=
 0.2))",
         "MetricgroupNoGroup": "TopdownL2",
         "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
         "ScaleUnit": "100%"
@@ -183,7 +183,7 @@
         "MetricExpr": "43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT * (1 + =
MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UO=
PS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L=
3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD=
_UOPS_RETIRED.L3_MISS))) / tma_info_thread_clks",
         "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issu=
eSyncxn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
-        "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_data_sharing > 0.05) & ((tma_l3_bound > 0=
.05) & ((tma_memory_bound > 0.2) & ((tma_backend_bound > 0.2))))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_contested_accesses, tma=
_false_sharing, tma_machine_clears, tma_remote_cache",
         "ScaleUnit": "100%"
     },
@@ -192,8 +192,8 @@
         "MetricExpr": "ARITH.FPU_DIV_ACTIVE / tma_info_core_core_clks",
         "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
-        "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
-        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
+        "MetricThreshold": "(tma_divider > 0.2) & ((tma_core_bound > 0.1) =
& ((tma_backend_bound > 0.2)))",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIV_ACTIVE",
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
-        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS_PS",
+        "MetricThreshold": "(tma_dram_bound > 0.1) & ((tma_memory_bound > =
0.2) & ((tma_backend_bound > 0.2)))",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
         "ScaleUnit": "100%"
     },
     {
@@ -211,7 +211,7 @@
         "MetricExpr": "(IDQ.ALL_DSB_CYCLES_ANY_UOPS - IDQ.ALL_DSB_CYCLES_4=
_UOPS) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
-        "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
+        "MetricThreshold": "(tma_dsb > 0.15) & ((tma_fetch_bandwidth > 0.2=
))",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
         "ScaleUnit": "100%"
     },
@@ -220,7 +220,7 @@
         "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_thread_=
clks",
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
-        "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
+        "MetricThreshold": "(tma_dsb_switches > 0.05) & ((tma_fetch_latenc=
y > 0.1) & ((tma_frontend_bound > 0.15)))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_frontend_dsb_cove=
rage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
@@ -229,7 +229,7 @@
         "MetricExpr": "(8 * DTLB_LOAD_MISSES.STLB_HIT + cpu@DTLB_LOAD_MISS=
ES.WALK_DURATION\\,cmask\\=3D1@ + 7 * DTLB_LOAD_MISSES.WALK_COMPLETED) / tm=
a_info_thread_clks",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_l1_bound_group",
         "MetricName": "tma_dtlb_load",
-        "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_dtlb_load > 0.1) & ((tma_l1_bound > 0.1) =
& ((tma_memory_bound > 0.2) & ((tma_backend_bound > 0.2))))",
         "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store",
         "ScaleUnit": "100%"
     },
@@ -238,7 +238,7 @@
         "MetricExpr": "(8 * DTLB_STORE_MISSES.STLB_HIT + cpu@DTLB_STORE_MI=
SSES.WALK_DURATION\\,cmask\\=3D1@ + 7 * DTLB_STORE_MISSES.WALK_COMPLETED) /=
 tma_info_thread_clks",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_store_bound_group",
         "MetricName": "tma_dtlb_store",
-        "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_dtlb_store > 0.05) & ((tma_store_bound > =
0.2) & ((tma_memory_bound > 0.2) & ((tma_backend_bound > 0.2))))",
         "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load",
         "ScaleUnit": "100%"
     },
@@ -246,9 +246,9 @@
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu@L1D_PE=
ND_MISS.FB_FULL\\,cmask\\=3D1@ / tma_info_thread_clks",
-        "MetricGroup": "BvMS;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
+        "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
-        "MetricThreshold": "tma_fb_full > 0.3",
+        "MetricThreshold": "(tma_fb_full > 0.3)",
         "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_system_dram_bw_use, tma_mem_ba=
ndwidth, tma_sq_full, tma_store_latency, tma_streaming_stores",
         "ScaleUnit": "100%"
     },
@@ -257,9 +257,9 @@
         "MetricExpr": "tma_frontend_bound - tma_fetch_latency",
         "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_=
frontend_bound_group;tma_issueFB",
         "MetricName": "tma_fetch_bandwidth",
-        "MetricThreshold": "tma_fetch_bandwidth > 0.2",
+        "MetricThreshold": "(tma_fetch_bandwidth > 0.2)",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1;FRONTEND_RETIRED.LATEN=
CY_GE_1;FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switches, t=
ma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
@@ -267,7 +267,7 @@
         "MetricExpr": "4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE=
 / tma_info_thread_slots",
         "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
         "MetricName": "tma_fetch_latency",
-        "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
+        "MetricThreshold": "(tma_fetch_latency > 0.1) & ((tma_frontend_bou=
nd > 0.15))",
         "MetricgroupNoGroup": "TopdownL2",
         "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
         "ScaleUnit": "100%"
@@ -277,7 +277,7 @@
         "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
-        "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > 0.=
6",
+        "MetricThreshold": "(tma_fp_arith > 0.2) & ((tma_light_operations =
> 0.6))",
         "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
         "ScaleUnit": "100%"
     },
@@ -286,7 +286,7 @@
         "MetricExpr": "FP_ARITH_INST_RETIRED.SCALAR / UOPS_RETIRED.RETIRE_=
SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
-        "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "MetricThreshold": "(tma_fp_scalar > 0.1) & ((tma_fp_arith > 0.2) =
& ((tma_light_operations > 0.6)))",
         "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5, t=
ma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
@@ -295,7 +295,7 @@
         "MetricExpr": "FP_ARITH_INST_RETIRED.VECTOR / UOPS_RETIRED.RETIRE_=
SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
-        "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "MetricThreshold": "(tma_fp_vector > 0.1) & ((tma_fp_arith > 0.2) =
& ((tma_light_operations > 0.6)))",
         "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
@@ -304,8 +304,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
-        "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "(tma_fp_vector_128b > 0.1) & ((tma_fp_vector >=
 0.1) & ((tma_fp_arith > 0.2) & ((tma_light_operations > 0.6))))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_=
1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -313,8 +313,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
-        "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "(tma_fp_vector_256b > 0.1) & ((tma_fp_vector >=
 0.1) & ((tma_fp_arith > 0.2) & ((tma_light_operations > 0.6))))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_fp_vector_512b, tma_port_0, tma_port_=
1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -322,7 +322,7 @@
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_thread_slots=
",
         "MetricGroup": "BvFB;BvIO;PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
-        "MetricThreshold": "tma_frontend_bound > 0.15",
+        "MetricThreshold": "(tma_frontend_bound > 0.15)",
         "MetricgroupNoGroup": "TopdownL1",
         "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4_PS",
         "ScaleUnit": "100%"
@@ -332,9 +332,9 @@
         "MetricExpr": "tma_microcode_sequencer",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
-        "MetricThreshold": "tma_heavy_operations > 0.1",
+        "MetricThreshold": "(tma_heavy_operations > 0.1)",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences. ([ICL+] Note this may overcou=
nt due to approximation using indirect events; [ADL+] .)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences.([ICL+] Note this may overcoun=
t due to approximation using indirect events; [ADL+]). Sample with: UOPS_RE=
TIRED.HEAVY",
         "ScaleUnit": "100%"
     },
     {
@@ -342,23 +342,23 @@
         "MetricExpr": "ICACHE.IFDATA_STALL / tma_info_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
+        "MetricThreshold": "(tma_icache_misses > 0.05) & ((tma_fetch_laten=
cy > 0.1) & ((tma_frontend_bound > 0.15)))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
         "MetricExpr": "tma_info_inst_mix_instructions / (UOPS_RETIRED.RETI=
RE_SLOTS / UOPS_ISSUED.ANY * BR_MISP_EXEC.INDIRECT)",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
-        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
+        "MetricThreshold": "(tma_info_bad_spec_ipmisp_indirect < 1000)"
     },
     {
         "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;BadSpec;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmispredict",
-        "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200"
+        "MetricThreshold": "(tma_info_bad_spec_ipmispredict < 200)"
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
@@ -396,7 +396,7 @@
         "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_=
UOPS + IDQ.MS_UOPS)",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_frontend_dsb_coverage",
-        "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 4 > 0.35",
+        "MetricThreshold": "(tma_info_frontend_dsb_coverage < 0.7) & ((tma=
_info_thread_ipc / 4) > 0.35)",
         "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_inst_mix_iptb, tma_lcp"
     },
     {
@@ -405,6 +405,12 @@
         "MetricGroup": "Fed",
         "MetricName": "tma_info_frontend_ipunknown_branch"
     },
+    {
+        "BriefDescription": "Taken Branches retired Per Cycle",
+        "MetricExpr": "BR_INST_RETIRED.NEAR_TAKEN / tma_info_thread_clks",
+        "MetricGroup": "Branches;FetchBW",
+        "MetricName": "tma_info_frontend_tbpc"
+    },
     {
         "BriefDescription": "Branch instructions per taken branch.",
         "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
@@ -423,7 +429,7 @@
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR + =
FP_ARITH_INST_RETIRED.VECTOR)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
-        "MetricThreshold": "tma_info_inst_mix_iparith < 10",
+        "MetricThreshold": "(tma_info_inst_mix_iparith < 10)",
         "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW."
     },
     {
@@ -431,7 +437,7 @@
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx128",
-        "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
+        "MetricThreshold": "(tma_info_inst_mix_iparith_avx128 < 10)",
         "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting."
     },
     {
@@ -439,7 +445,7 @@
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx256",
-        "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
+        "MetricThreshold": "(tma_info_inst_mix_iparith_avx256 < 10)",
         "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting."
     },
     {
@@ -447,7 +453,7 @@
         "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_DOU=
BLE",
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
-        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
+        "MetricThreshold": "(tma_info_inst_mix_iparith_scalar_dp < 10)",
         "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
     },
     {
@@ -455,7 +461,7 @@
         "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_SIN=
GLE",
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
-        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
+        "MetricThreshold": "(tma_info_inst_mix_iparith_scalar_sp < 10)",
         "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
     },
     {
@@ -463,42 +469,42 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Branches;Fed;InsType",
         "MetricName": "tma_info_inst_mix_ipbranch",
-        "MetricThreshold": "tma_info_inst_mix_ipbranch < 8"
+        "MetricThreshold": "(tma_info_inst_mix_ipbranch < 8)"
     },
     {
         "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
         "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "tma_info_inst_mix_ipcall",
-        "MetricThreshold": "tma_info_inst_mix_ipcall < 200"
+        "MetricThreshold": "(tma_info_inst_mix_ipcall < 200)"
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR + =
2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_=
FLOPS + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_ipflop",
-        "MetricThreshold": "tma_info_inst_mix_ipflop < 10"
+        "MetricThreshold": "(tma_info_inst_mix_ipflop < 10)"
     },
     {
         "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
         "MetricGroup": "InsType",
         "MetricName": "tma_info_inst_mix_ipload",
-        "MetricThreshold": "tma_info_inst_mix_ipload < 3"
+        "MetricThreshold": "(tma_info_inst_mix_ipload < 3)"
     },
     {
         "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
         "MetricGroup": "InsType",
         "MetricName": "tma_info_inst_mix_ipstore",
-        "MetricThreshold": "tma_info_inst_mix_ipstore < 8"
+        "MetricThreshold": "(tma_info_inst_mix_ipstore < 8)"
     },
     {
         "BriefDescription": "Instructions per taken branch",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
         "MetricName": "tma_info_inst_mix_iptb",
-        "MetricThreshold": "tma_info_inst_mix_iptb < 9",
+        "MetricThreshold": "(tma_info_inst_mix_iptb < 4 * 2 + 1)",
         "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, =
tma_lcp"
     },
     {
@@ -521,7 +527,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / tma_info_system_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l1d_cache_fill_bw"
     },
@@ -533,7 +539,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / tma_info_system_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l2_cache_fill_bw"
     },
@@ -575,7 +581,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / tma_info_system=
_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l3_cache_fill_bw"
     },
@@ -594,7 +600,7 @@
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricGroup": "LockCont;Memory_Lat;Offcore",
         "MetricName": "tma_info_memory_latency_load_l2_miss_latency"
     },
     {
@@ -623,10 +629,10 @@
         "MetricExpr": "(cpu@ITLB_MISSES.WALK_DURATION\\,cmask\\=3D1@ + cpu=
@DTLB_LOAD_MISSES.WALK_DURATION\\,cmask\\=3D1@ + cpu@DTLB_STORE_MISSES.WALK=
_DURATION\\,cmask\\=3D1@ + 7 * (DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOA=
D_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED)) / tma_info_core_core=
_clks",
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "tma_info_memory_tlb_page_walks_utilization",
-        "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5"
+        "MetricThreshold": "(tma_info_memory_tlb_page_walks_utilization > =
0.5)"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per core",
+        "BriefDescription": "",
         "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
@@ -639,7 +645,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -657,14 +663,14 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / tma_info_system_time",
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
         "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth,=
 tma_sq_full"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / 1e9 / duration_time",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / 1e9 / tma_info_system_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_system_gflops",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width"
@@ -674,7 +680,7 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
         "MetricGroup": "Branches;OS",
         "MetricName": "tma_info_system_ipfarbranch",
-        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6"
+        "MetricThreshold": "(tma_info_system_ipfarbranch < 1000000)"
     },
     {
         "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
@@ -687,7 +693,20 @@
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
         "MetricGroup": "OS",
         "MetricName": "tma_info_system_kernel_utilization",
-        "MetricThreshold": "tma_info_system_kernel_utilization > 0.05"
+        "MetricThreshold": "(tma_info_system_kernel_utilization > 0.05)"
+    },
+    {
+        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P / CPU_CLK_UNHALTED.THREAD=
",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_mux",
+        "MetricThreshold": "((tma_info_system_mux > 1.1)|(tma_info_system_=
mux < 0.9))"
+    },
+    {
+        "BriefDescription": "Total package Power in Watts",
+        "MetricExpr": "power@energy\\-pkg@ * 61 / (tma_info_system_time * =
1e6)",
+        "MetricGroup": "Power;SoC",
+        "MetricName": "tma_info_system_power"
     },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
@@ -701,6 +720,13 @@
         "MetricGroup": "SoC",
         "MetricName": "tma_info_system_socket_clks"
     },
+    {
+        "BriefDescription": "Run duration time in seconds",
+        "MetricExpr": "duration_time",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_time",
+        "MetricThreshold": "(tma_info_system_time < 1)"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
         "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
@@ -743,31 +769,31 @@
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "MetricGroup": "Pipeline;Ret;Retire",
         "MetricName": "tma_info_thread_uoppi",
-        "MetricThreshold": "tma_info_thread_uoppi > 1.05"
+        "MetricThreshold": "(tma_info_thread_uoppi > 1.05)"
     },
     {
         "BriefDescription": "Uops per taken branch",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / BR_INST_RETIRED.NEAR_TA=
KEN",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "tma_info_thread_uptb",
-        "MetricThreshold": "tma_info_thread_uptb < 6"
+        "MetricThreshold": "(tma_info_thread_uptb < 4 * 1.5)"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
         "MetricExpr": "(14 * ITLB_MISSES.STLB_HIT + cpu@ITLB_MISSES.WALK_D=
URATION\\,cmask\\=3D1@ + 7 * ITLB_MISSES.WALK_COMPLETED) / tma_info_thread_=
clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
+        "MetricThreshold": "(tma_itlb_misses > 0.05) & ((tma_fetch_latency=
 > 0.1) & ((tma_frontend_bound > 0.15)))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 Data (L1D) cache",
         "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
-        "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 data cache.  The L1 data cache typical=
ly has the shortest latency.  However; in certain cases like loads blocked =
on older stores; a load might suffer due to high latency even though it is =
being satisfied by the L1. Another example is loads who miss in the TLB. Th=
ese cases are characterized by execution unit stalls; while some non-comple=
ted demand load lives in the machine without having that demand load missin=
g the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT_PS;MEM_LOAD_RETIRED.FB=
_HIT_PS. Related metrics: tma_clears_resteers, tma_machine_clears, tma_micr=
ocode_sequencer, tma_ms_switches, tma_ports_utilized_1",
+        "MetricThreshold": "(tma_l1_bound > 0.1) & ((tma_memory_bound > 0.=
2) & ((tma_backend_bound > 0.2)))",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1D. Another example is loads who miss in the TLB.=
 These cases are characterized by execution unit stalls; while some non-com=
pleted demand load lives in the machine without having that demand load mis=
sing the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT. Related metrics: t=
ma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tma_ms_swi=
tches, tma_ports_utilized_1",
         "ScaleUnit": "100%"
     },
     {
@@ -775,8 +801,8 @@
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.ST=
ALLS_L2_MISS) / tma_info_thread_clks",
         "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
-        "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT_PS",
+        "MetricThreshold": "(tma_l2_bound > 0.05) & ((tma_memory_bound > 0=
.2) & ((tma_backend_bound > 0.2)))",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT",
         "ScaleUnit": "100%"
     },
     {
@@ -785,7 +811,7 @@
         "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETIR=
ED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS) * CYCLE_ACTIVITY.STALLS_L2_M=
ISS / tma_info_thread_clks",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
-        "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
+        "MetricThreshold": "(tma_l3_bound > 0.05) & ((tma_memory_bound > 0=
.2) & ((tma_backend_bound > 0.2)))",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
         "ScaleUnit": "100%"
     },
@@ -795,7 +821,7 @@
         "MetricExpr": "29 * (MEM_LOAD_UOPS_RETIRED.L3_HIT * (1 + MEM_LOAD_=
UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIRE=
D.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_HIT_RET=
IRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOPS_RET=
IRED.L3_MISS))) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
-        "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_l3_hit_latency > 0.1) & ((tma_l3_bound > =
0.05) & ((tma_memory_bound > 0.2) & ((tma_backend_bound > 0.2))))",
         "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_mem_latency",
         "ScaleUnit": "100%"
     },
@@ -804,7 +830,7 @@
         "MetricExpr": "ILD_STALL.LCP / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
-        "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
+        "MetricThreshold": "(tma_lcp > 0.05) & ((tma_fetch_latency > 0.1) =
& ((tma_frontend_bound > 0.15)))",
         "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
         "ScaleUnit": "100%"
     },
@@ -813,7 +839,7 @@
         "MetricExpr": "tma_retiring - tma_heavy_operations",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_light_operations",
-        "MetricThreshold": "tma_light_operations > 0.6",
+        "MetricThreshold": "(tma_light_operations > 0.6)",
         "MetricgroupNoGroup": "TopdownL2",
         "PublicDescription": "This metric represents fraction of slots whe=
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
@@ -824,7 +850,7 @@
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 + UOPS_DISPATCHED_PORT.PORT_7 - UOPS_DISPATCHED_PORT.PORT_4) / (2 *=
 tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
-        "MetricThreshold": "tma_load_op_utilization > 0.6",
+        "MetricThreshold": "(tma_load_op_utilization > 0.6)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port for Load operations. Sample with: =
UOPS_DISPATCHED.PORT_2_3_10",
         "ScaleUnit": "100%"
     },
@@ -832,9 +858,9 @@
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.ALL_=
STORES * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCLES_W=
ITH_DEMAND_RFO) / tma_info_thread_clks",
-        "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
+        "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
-        "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_lock_latency > 0.2) & ((tma_l1_bound > 0.=
1) & ((tma_memory_bound > 0.2) & ((tma_backend_bound > 0.2))))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS. Related metrics: tma_store_latency",
         "ScaleUnit": "100%"
     },
@@ -844,7 +870,7 @@
         "MetricExpr": "tma_bad_speculation - tma_branch_mispredicts",
         "MetricGroup": "BadSpec;BvMS;MachineClears;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
         "MetricName": "tma_machine_clears",
-        "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation=
 > 0.15",
+        "MetricThreshold": "(tma_machine_clears > 0.1) & ((tma_bad_specula=
tion > 0.15))",
         "MetricgroupNoGroup": "TopdownL2",
         "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sh=
aring, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_c=
ache",
         "ScaleUnit": "100%"
@@ -852,9 +878,9 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
-        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_mem_bandwidth > 0.2) & ((tma_dram_bound >=
 0.1) & ((tma_memory_bound > 0.2) & ((tma_backend_bound > 0.2))))",
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
@@ -863,7 +889,7 @@
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
         "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
-        "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_mem_latency > 0.1) & ((tma_dram_bound > 0=
.1) & ((tma_memory_bound > 0.2) & ((tma_backend_bound > 0.2))))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_l3_hit_latency",
         "ScaleUnit": "100%"
     },
@@ -873,7 +899,7 @@
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_MEM_ANY + RESOURCE_STALLS.SB=
) / (CYCLE_ACTIVITY.STALLS_TOTAL + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (UO=
PS_EXECUTED.CYCLES_GE_3_UOPS_EXEC if tma_info_thread_ipc > 1.8 else UOPS_EX=
ECUTED.CYCLES_GE_2_UOPS_EXEC) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latenc=
y > 0.1 else 0) + RESOURCE_STALLS.SB) * tma_backend_bound",
         "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_b=
ound_group",
         "MetricName": "tma_memory_bound",
-        "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
+        "MetricThreshold": "(tma_memory_bound > 0.2) & ((tma_backend_bound=
 > 0.2))",
         "MetricgroupNoGroup": "TopdownL2",
         "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
         "ScaleUnit": "100%"
@@ -883,7 +909,7 @@
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY * IDQ.M=
S_UOPS / tma_info_thread_slots",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
         "MetricName": "tma_microcode_sequencer",
-        "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_ope=
rations > 0.1",
+        "MetricThreshold": "(tma_microcode_sequencer > 0.05) & ((tma_heavy=
_operations > 0.1))",
         "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: UOPS_RETIRED.MS. Related metrics: tma_clears_reste=
ers, tma_l1_bound, tma_machine_clears, tma_ms_switches",
         "ScaleUnit": "100%"
     },
@@ -892,7 +918,7 @@
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES * tma_branch_resteers =
/ (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY)",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_group;=
tma_branch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
-        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "MetricThreshold": "(tma_mispredicts_resteers > 0.05) & ((tma_bran=
ch_resteers > 0.05) & ((tma_fetch_latency > 0.1) & ((tma_frontend_bound > 0=
.15))))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_branch_mispredicts, tma_info_bad_spec_branch_misprediction_cost=
",
         "ScaleUnit": "100%"
     },
@@ -901,7 +927,7 @@
         "MetricExpr": "(IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MITE_CYCLES=
_4_UOPS) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
         "MetricName": "tma_mite",
-        "MetricThreshold": "tma_mite > 0.1 & tma_fetch_bandwidth > 0.2",
+        "MetricThreshold": "(tma_mite > 0.1) & ((tma_fetch_bandwidth > 0.2=
))",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS",
         "ScaleUnit": "100%"
     },
@@ -910,7 +936,7 @@
         "MetricExpr": "2 * IDQ.MS_SWITCHES / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
-        "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
+        "MetricThreshold": "(tma_ms_switches > 0.05) & ((tma_fetch_latency=
 > 0.1) & ((tma_frontend_bound > 0.15)))",
         "PublicDescription": "This metric estimates the fraction of cycles=
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
@@ -919,8 +945,8 @@
         "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_0 / tma_info_core_core_cl=
ks",
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
-        "MetricThreshold": "tma_port_0 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512=
b, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "(tma_port_0 > 0.6)",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_128b,=
 tma_fp_vector_256b, tma_fp_vector_512b, tma_port_1, tma_port_5, tma_port_6=
, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -928,8 +954,8 @@
         "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_1 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
-        "MetricThreshold": "tma_port_1 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_5, tma_por=
t_6, tma_ports_utilized_2",
+        "MetricThreshold": "(tma_port_1 > 0.6)",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Related metrics: tma_fp_s=
calar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector=
_512b, tma_port_0, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -937,7 +963,7 @@
         "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_2 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_load_op_utilization_gro=
up",
         "MetricName": "tma_port_2",
-        "MetricThreshold": "tma_port_2 > 0.6",
+        "MetricThreshold": "(tma_port_2 > 0.6)",
         "ScaleUnit": "100%"
     },
     {
@@ -945,7 +971,7 @@
         "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_3 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_load_op_utilization_gro=
up",
         "MetricName": "tma_port_3",
-        "MetricThreshold": "tma_port_3 > 0.6",
+        "MetricThreshold": "(tma_port_3 > 0.6)",
         "ScaleUnit": "100%"
     },
     {
@@ -953,7 +979,7 @@
         "MetricExpr": "tma_store_op_utilization",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_issueSpSt;tma_store_op_=
utilization_group",
         "MetricName": "tma_port_4",
-        "MetricThreshold": "tma_port_4 > 0.6",
+        "MetricThreshold": "(tma_port_4 > 0.6)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 4 (Store-data). Related metrics: t=
ma_split_stores",
         "ScaleUnit": "100%"
     },
@@ -962,7 +988,7 @@
         "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_5 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_5",
-        "MetricThreshold": "tma_port_5 > 0.6",
+        "MetricThreshold": "(tma_port_5 > 0.6)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+]=
 ALU). Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_128b, t=
ma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_6, =
tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
@@ -971,8 +997,8 @@
         "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_6 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
-        "MetricThreshold": "tma_port_6 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_6. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b=
, tma_port_0, tma_port_1, tma_port_5, tma_ports_utilized_2",
+        "MetricThreshold": "(tma_port_6 > 0.6)",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_128b, =
tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5,=
 tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -980,7 +1006,7 @@
         "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_7 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_store_op_utilization_gr=
oup",
         "MetricName": "tma_port_7",
-        "MetricThreshold": "tma_port_7 > 0.6",
+        "MetricThreshold": "(tma_port_7 > 0.6)",
         "ScaleUnit": "100%"
     },
     {
@@ -989,7 +1015,7 @@
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_TOTAL + UOPS_EXECUTED.CYCLES=
_GE_1_UOP_EXEC - (UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC if tma_info_thread_ip=
c > 1.8 else UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) - (RS_EVENTS.EMPTY_CYCLES=
 if tma_fetch_latency > 0.1 else 0) + RESOURCE_STALLS.SB - RESOURCE_STALLS.=
SB - CYCLE_ACTIVITY.STALLS_MEM_ANY) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
-        "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
+        "MetricThreshold": "(tma_ports_utilization > 0.15) & ((tma_core_bo=
und > 0.1) & ((tma_backend_bound > 0.2)))",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
         "ScaleUnit": "100%"
     },
@@ -998,7 +1024,7 @@
         "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (CYCLE_ACTIVITY.STALLS_TOTAL - (RS_EVENTS.EMPTY_CYCLES if tma=
_fetch_latency > 0.1 else 0)) / tma_info_core_core_clks)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
-        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_ports_utilized_0 > 0.2) & ((tma_ports_uti=
lization > 0.15) & ((tma_core_bound > 0.1) & ((tma_backend_bound > 0.2))))"=
,
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
         "ScaleUnit": "100%"
     },
@@ -1007,7 +1033,7 @@
         "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / tma_info_core_core_clks=
)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
-        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_ports_utilized_1 > 0.2) & ((tma_ports_uti=
lization > 0.15) & ((tma_core_bound > 0.1) & ((tma_backend_bound > 0.2))))"=
,
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL. Related m=
etrics: tma_l1_bound",
         "ScaleUnit": "100%"
     },
@@ -1016,7 +1042,7 @@
         "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
2_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_clk=
s)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
-        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_ports_utilized_2 > 0.15) & ((tma_ports_ut=
ilization > 0.15) & ((tma_core_bound > 0.1) & ((tma_backend_bound > 0.2))))=
",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_=
port_0, tma_port_1, tma_port_5, tma_port_6",
         "ScaleUnit": "100%"
     },
@@ -1025,7 +1051,7 @@
         "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_clks",
         "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
-        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_ports_utilized_3m > 0.4) & ((tma_ports_ut=
ilization > 0.15) & ((tma_core_bound > 0.1) & ((tma_backend_bound > 0.2))))=
",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
         "ScaleUnit": "100%"
     },
@@ -1034,7 +1060,7 @@
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_thread_slots",
         "MetricGroup": "BvUW;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
-        "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
+        "MetricThreshold": "((tma_retiring > 0.7)|(tma_heavy_operations > =
0.1))",
         "MetricgroupNoGroup": "TopdownL1",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.SLOTS",
         "ScaleUnit": "100%"
@@ -1045,7 +1071,7 @@
         "MetricExpr": "tma_info_memory_load_miss_real_latency * LD_BLOCKS.=
NO_SR / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
-        "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_split_loads > 0.3)",
         "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS_PS",
         "ScaleUnit": "100%"
     },
@@ -1054,16 +1080,16 @@
         "MetricExpr": "2 * MEM_UOPS_RETIRED.SPLIT_STORES / tma_info_core_c=
ore_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
-        "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_split_stores > 0.2) & ((tma_store_bound >=
 0.2) & ((tma_memory_bound > 0.2) & ((tma_backend_bound > 0.2))))",
         "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES_PS. Related metrics: tma_port_=
4",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
         "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / tma_info_core_core_clks",
-        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
-        "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_sq_full > 0.3) & ((tma_l3_bound > 0.05) &=
 ((tma_memory_bound > 0.2) & ((tma_backend_bound > 0.2))))",
         "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_system_dram_bw_use, tma_mem_bandwidth",
         "ScaleUnit": "100%"
     },
@@ -1072,7 +1098,7 @@
         "MetricExpr": "RESOURCE_STALLS.SB / tma_info_thread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_store_bound",
-        "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
+        "MetricThreshold": "(tma_store_bound > 0.2) & ((tma_memory_bound >=
 0.2) & ((tma_backend_bound > 0.2)))",
         "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES_PS",
         "ScaleUnit": "100%"
     },
@@ -1081,7 +1107,7 @@
         "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
-        "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_store_fwd_blk > 0.1) & ((tma_l1_bound > 0=
.1) & ((tma_memory_bound > 0.2) & ((tma_backend_bound > 0.2))))",
         "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
         "ScaleUnit": "100%"
     },
@@ -1089,9 +1115,9 @@
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_UOPS_RETIRED.LOCK_=
LOADS / MEM_UOPS_RETIRED.ALL_STORES) + (1 - MEM_UOPS_RETIRED.LOCK_LOADS / M=
EM_UOPS_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
-        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
issueRFO;tma_issueSL;tma_store_bound_group",
+        "MetricGroup": "BvML;LockCont;MemoryLat;Offcore;TopdownL4;tma_L4_g=
roup;tma_issueRFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
-        "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "(tma_store_latency > 0.1) & ((tma_store_bound =
> 0.2) & ((tma_memory_bound > 0.2) & ((tma_backend_bound > 0.2))))",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
         "ScaleUnit": "100%"
     },
@@ -1100,7 +1126,7 @@
         "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_store_op_utilization",
-        "MetricThreshold": "tma_store_op_utilization > 0.6",
+        "MetricThreshold": "(tma_store_op_utilization > 0.6)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port for Store operations. Sample with:=
 UOPS_DISPATCHED.PORT_7_8",
         "ScaleUnit": "100%"
     },
@@ -1109,7 +1135,7 @@
         "MetricExpr": "tma_branch_resteers - tma_mispredicts_resteers - tm=
a_clears_resteers",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;TopdownL4;tma_L4_group;=
tma_branch_resteers_group",
         "MetricName": "tma_unknown_branches",
-        "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "MetricThreshold": "(tma_unknown_branches > 0.05) & ((tma_branch_r=
esteers > 0.05) & ((tma_fetch_latency > 0.1) & ((tma_frontend_bound > 0.15)=
)))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit) hence called Unknown Bran=
ches. Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "ScaleUnit": "100%"
     },
@@ -1118,7 +1144,7 @@
         "MetricExpr": "INST_RETIRED.X87 * tma_info_thread_uoppi / UOPS_RET=
IRED.RETIRE_SLOTS",
         "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
         "MetricName": "tma_x87_use",
-        "MetricThreshold": "tma_x87_use > 0.1 & (tma_fp_arith > 0.2 & tma_=
light_operations > 0.6)",
+        "MetricThreshold": "(tma_x87_use > 0.1) & ((tma_fp_arith > 0.2) & =
((tma_light_operations > 0.6)))",
         "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
         "ScaleUnit": "100%"
     }
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json b/tools/=
perf/pmu-events/arch/x86/broadwellde/cache.json
index 315d7f041731..49d8de8f1b51 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
@@ -22,7 +22,7 @@
         "Counter": "2",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
-        "PublicDescription": "This event counts duration of L1D miss outst=
anding, that is each cycle number of Fill Buffers (FB) outstanding required=
 by Demand Reads. FB either is held by demand loads, or it is held by non-d=
emand loads and gets hit at least once by demand. The valid outstanding int=
erval is defined until the FB deallocation by one of the following ways: fr=
om FB allocation, if FB is allocated by demand; from the demand Hit FB, if =
it is allocated by hardware or software prefetch.\nNote: In the L1D, a Dema=
nd Read contains cacheable or noncacheable demand loads, including ones cau=
sing cache-line splits and reads due to page walks resulted from any reques=
t type.",
+        "PublicDescription": "This event counts duration of L1D miss outst=
anding, that is each cycle number of Fill Buffers (FB) outstanding required=
 by Demand Reads. FB either is held by demand loads, or it is held by non-d=
emand loads and gets hit at least once by demand. The valid outstanding int=
erval is defined until the FB deallocation by one of the following ways: fr=
om FB allocation, if FB is allocated by demand; from the demand Hit FB, if =
it is allocated by hardware or software prefetch. Note: In the L1D, a Deman=
d Read contains cacheable or noncacheable demand loads, including ones caus=
ing cache-line splits and reads due to page walks resulted from any request=
 type.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -434,7 +434,7 @@
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HIT_LFB",
         "PEBS": "1",
-        "PublicDescription": "This event counts retired load uops which da=
ta sources were load uops missed L1 but hit a fill buffer due to a precedin=
g miss to the same cache line with the data not ready.\nNote: Only two data=
-sources of L1/FB are applicable for AVX-256bit  even though the correspond=
ing AVX load could be serviced by a deeper level in the memory hierarchy. D=
ata source is reported for the Low-half load.",
+        "PublicDescription": "This event counts retired load uops which da=
ta sources were load uops missed L1 but hit a fill buffer due to a precedin=
g miss to the same cache line with the data not ready. Note: Only two data-=
sources of L1/FB are applicable for AVX-256bit  even though the correspondi=
ng AVX load could be serviced by a deeper level in the memory hierarchy. Da=
ta source is reported for the Low-half load.",
         "SampleAfterValue": "100003",
         "UMask": "0x40"
     },
@@ -445,7 +445,7 @@
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
         "PEBS": "1",
-        "PublicDescription": "This event counts retired load uops which da=
ta sources were hits in the nearest-level (L1) cache.\nNote: Only two data-=
sources of L1/FB are applicable for AVX-256bit  even though the correspondi=
ng AVX load could be serviced by a deeper level in the memory hierarchy. Da=
ta source is reported for the Low-half load. This event also counts SW pref=
etches independent of the actual data source.",
+        "PublicDescription": "This event counts retired load uops which da=
ta sources were hits in the nearest-level (L1) cache. Note: Only two data-s=
ources of L1/FB are applicable for AVX-256bit  even though the correspondin=
g AVX load could be serviced by a deeper level in the memory hierarchy. Dat=
a source is reported for the Low-half load. This event also counts SW prefe=
tches independent of the actual data source.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -634,7 +634,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xb2",
         "EventName": "OFFCORE_REQUESTS_BUFFER.SQ_FULL",
-        "PublicDescription": "This event counts the number of cases when t=
he offcore requests buffer cannot take more entries for the core. This can =
happen when the superqueue does not contain eligible entries, or when L1D w=
riteback pending FIFO requests is full.\nNote: Writeback pending FIFO has s=
ix entries.",
+        "PublicDescription": "This event counts the number of cases when t=
he offcore requests buffer cannot take more entries for the core. This can =
happen when the superqueue does not contain eligible entries, or when L1D w=
riteback pending FIFO requests is full. Note: Writeback pending FIFO has si=
x entries.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -697,7 +697,7 @@
         "Errata": "BDM76",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
-        "PublicDescription": "This event counts the number of offcore outs=
tanding Demand Data Read transactions in the super queue (SQ) every cycle. =
A transaction is considered to be in the Offcore outstanding state between =
L2 miss and transaction completion sent to requestor. See the corresponding=
 Umask under OFFCORE_REQUESTS.\nNote: A prefetch promoted to Demand is coun=
ted from the promotion point.",
+        "PublicDescription": "This event counts the number of offcore outs=
tanding Demand Data Read transactions in the super queue (SQ) every cycle. =
A transaction is considered to be in the Offcore outstanding state between =
L2 miss and transaction completion sent to requestor. See the corresponding=
 Umask under OFFCORE_REQUESTS. Note: A prefetch promoted to Demand is count=
ed from the promotion point.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json b/too=
ls/perf/pmu-events/arch/x86/broadwellde/frontend.json
index db3488abf9fc..018020a51436 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
@@ -12,7 +12,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xAB",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
-        "PublicDescription": "This event counts Decode Stream Buffer (DSB)=
-to-MITE switch true penalty cycles. These cycles do not include uops route=
d through because of the switch itself, for example, when Instruction Decod=
e Queue (IDQ) pre-allocation is unavailable, or Instruction Decode Queue (I=
DQ) is full. SBD-to-MITE switch true penalty cycles happen after the merge =
mux (MM) receives Decode Stream Buffer (DSB) Sync-indication until receivin=
g the first MITE uop. \nMM is placed before Instruction Decode Queue (IDQ) =
to merge uops being fed from the MITE and Decode Stream Buffer (DSB) paths.=
 Decode Stream Buffer (DSB) inserts the Sync-indication whenever a Decode S=
tream Buffer (DSB)-to-MITE switch occurs.\nPenalty: A Decode Stream Buffer =
(DSB) hit followed by a Decode Stream Buffer (DSB) miss can cost up to six =
cycles in which no uops are delivered to the IDQ. Most often, such switches=
 from the Decode Stream Buffer (DSB) to the legacy pipeline cost 02 cycles.=
",
+        "PublicDescription": "This event counts Decode Stream Buffer (DSB)=
-to-MITE switch true penalty cycles. These cycles do not include uops route=
d through because of the switch itself, for example, when Instruction Decod=
e Queue (IDQ) pre-allocation is unavailable, or Instruction Decode Queue (I=
DQ) is full. SBD-to-MITE switch true penalty cycles happen after the merge =
mux (MM) receives Decode Stream Buffer (DSB) Sync-indication until receivin=
g the first MITE uop.  MM is placed before Instruction Decode Queue (IDQ) t=
o merge uops being fed from the MITE and Decode Stream Buffer (DSB) paths. =
Decode Stream Buffer (DSB) inserts the Sync-indication whenever a Decode St=
ream Buffer (DSB)-to-MITE switch occurs. Penalty: A Decode Stream Buffer (D=
SB) hit followed by a Decode Stream Buffer (DSB) miss can cost up to six cy=
cles in which no uops are delivered to the IDQ. Most often, such switches f=
rom the Decode Stream Buffer (DSB) to the legacy pipeline cost 02 cycles.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -212,7 +212,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
-        "PublicDescription": "This event counts the number of uops not del=
ivered to Resource Allocation Table (RAT) per thread adding 4  x when Resou=
rce Allocation Table (RAT) is not stalled and Instruction Decode Queue (IDQ=
) delivers x uops to Resource Allocation Table (RAT) (where x belongs to {0=
,1,2,3}). Counting does not cover cases when:\n a. IDQ-Resource Allocation =
Table (RAT) pipe serves the other thread;\n b. Resource Allocation Table (R=
AT) is stalled for the thread (including uop drops and clear BE conditions)=
; \n c. Instruction Decode Queue (IDQ) delivers four uops.",
+        "PublicDescription": "This event counts the number of uops not del=
ivered to Resource Allocation Table (RAT) per thread adding 4  x when Resou=
rce Allocation Table (RAT) is not stalled and Instruction Decode Queue (IDQ=
) delivers x uops to Resource Allocation Table (RAT) (where x belongs to {0=
,1,2,3}). Counting does not cover cases when:  a. IDQ-Resource Allocation T=
able (RAT) pipe serves the other thread;  b. Resource Allocation Table (RAT=
) is stalled for the thread (including uop drops and clear BE conditions); =
  c. Instruction Decode Queue (IDQ) delivers four uops.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/memory.json b/tools=
/perf/pmu-events/arch/x86/broadwellde/memory.json
index 31a74eed2f7d..9fca9a4eeb48 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/memory.json
@@ -68,7 +68,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.START",
-        "PublicDescription": "Number of times we entered an HLE region\n d=
oes not count nested transactions.",
+        "PublicDescription": "Number of times we entered an HLE region  do=
es not count nested transactions.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -77,7 +77,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "This event counts the number of memory order=
ing Machine Clears detected. Memory Ordering Machine Clears can result from=
 one of the following:\n1. memory disambiguation,\n2. external snoop, or\n3=
. cross SMT-HW-thread snoop (stores) hitting load buffer.",
+        "PublicDescription": "This event counts the number of memory order=
ing Machine Clears detected. Memory Ordering Machine Clears can result from=
 one of the following: 1. memory disambiguation, 2. external snoop, or 3. c=
ross SMT-HW-thread snoop (stores) hitting load buffer.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -280,7 +280,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.START",
-        "PublicDescription": "Number of times we entered an RTM region\n d=
oes not count nested transactions.",
+        "PublicDescription": "Number of times we entered an RTM region  do=
es not count nested transactions.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/metricgroups.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/metricgroups.json
index 4193c90c3459..0863375bdead 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/metricgroups.json
@@ -9,6 +9,7 @@
     "BvCB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvFB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvIO": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvML": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvMP": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvMS": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
@@ -34,6 +35,7 @@
     "InsType": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "L2Evicts": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "LSD": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "LockCont": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "MachineClears": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
     "Machine_Clears": "Grouping from Top-down Microarchitecture Analysis M=
etrics spreadsheet",
     "Mem": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
@@ -51,6 +53,7 @@
     "Pipeline": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "PortsUtil": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
     "Power": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
+    "Prefetches": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
     "Ret": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
     "Retire": "Grouping from Top-down Microarchitecture Analysis Metrics s=
preadsheet",
     "SMT": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
@@ -78,6 +81,7 @@
     "tma_bad_speculation_group": "Metrics contributing to tma_bad_speculat=
ion category",
     "tma_branch_resteers_group": "Metrics contributing to tma_branch_reste=
ers category",
     "tma_core_bound_group": "Metrics contributing to tma_core_bound catego=
ry",
+    "tma_divider_group": "Metrics contributing to tma_divider category",
     "tma_dram_bound_group": "Metrics contributing to tma_dram_bound catego=
ry",
     "tma_dtlb_load_group": "Metrics contributing to tma_dtlb_load category=
",
     "tma_dtlb_store_group": "Metrics contributing to tma_dtlb_store catego=
ry",
@@ -103,6 +107,7 @@
     "tma_issueSpSt": "Metrics related by the issue $issueSpSt",
     "tma_issueSyncxn": "Metrics related by the issue $issueSyncxn",
     "tma_issueTLB": "Metrics related by the issue $issueTLB",
+    "tma_itlb_misses_group": "Metrics contributing to tma_itlb_misses cate=
gory",
     "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category",
     "tma_l3_bound_group": "Metrics contributing to tma_l3_bound category",
     "tma_light_operations_group": "Metrics contributing to tma_light_opera=
tions category",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/broadwellde/pipeline.json
index c03f77539362..962cd07eb307 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
@@ -379,7 +379,7 @@
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
         "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-        "PublicDescription": "This event counts the number of reference cy=
cles when the core is not in a halt state. The core enters the halt state w=
hen it is running the HLT instruction or the MWAIT instruction. This event =
is not affected by core frequency changes (for example, P states, TM2 trans=
itions) but has the same incrementing frequency as the time stamp counter. =
This event can approximate elapsed time while the core was not in a halt st=
ate. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK eve=
nt. It is counted on a dedicated fixed counter, leaving the four (eight whe=
n Hyperthreading is disabled) programmable counters available for other eve=
nts. \nNote: On all current platforms this event stops counting during 'thr=
ottling (TM)' states duty off periods the processor is 'halted'.  This even=
t is clocked by base clock (100 Mhz) on Sandy Bridge. The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case.",
+        "PublicDescription": "This event counts the number of reference cy=
cles when the core is not in a halt state. The core enters the halt state w=
hen it is running the HLT instruction or the MWAIT instruction. This event =
is not affected by core frequency changes (for example, P states, TM2 trans=
itions) but has the same incrementing frequency as the time stamp counter. =
This event can approximate elapsed time while the core was not in a halt st=
ate. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK eve=
nt. It is counted on a dedicated fixed counter, leaving the four (eight whe=
n Hyperthreading is disabled) programmable counters available for other eve=
nts.  Note: On all current platforms this event stops counting during 'thro=
ttling (TM)' states duty off periods the processor is 'halted'.  This event=
 is clocked by base clock (100 Mhz) on Sandy Bridge. The counter update is =
done at a lower clock rate then the core clock the overflow status bit for =
this counter may appear 'sticky'.  After the counter has overflowed and sof=
tware clears the overflow status bit and resets the counter to less than MA=
X. The reset value to the counter is not clocked immediately so the overflo=
w status bit will flip 'high (1)' and generate another PMI (if enabled) aft=
er which the reset value gets clocked into the counter. Therefore, software=
 will get the interrupt, read the overflow status bit '1 for bit 34 while t=
he counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
     },
@@ -579,7 +579,7 @@
         "BriefDescription": "Instructions retired from execution.",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PublicDescription": "This event counts the number of instructions=
 retired from execution. For instructions that consist of multiple micro-op=
s, this event counts the retirement of the last micro-op of the instruction=
. Counting continues during hardware interrupts, traps, and inside interrup=
t handlers. \nNotes: INST_RETIRED.ANY is counted by a designated fixed coun=
ter, leaving the four (eight when Hyperthreading is disabled) programmable =
counters available for other events. INST_RETIRED.ANY_P is counted by a pro=
grammable counter and it is an architectural performance event. \nCounting:=
 Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as ret=
ired instructions.",
+        "PublicDescription": "This event counts the number of instructions=
 retired from execution. For instructions that consist of multiple micro-op=
s, this event counts the retirement of the last micro-op of the instruction=
. Counting continues during hardware interrupts, traps, and inside interrup=
t handlers.  Notes: INST_RETIRED.ANY is counted by a designated fixed count=
er, leaving the four (eight when Hyperthreading is disabled) programmable c=
ounters available for other events. INST_RETIRED.ANY_P is counted by a prog=
rammable counter and it is an architectural performance event.  Counting: F=
aulting executions of GETSEC/VM entry/VM Exit/MWait will not count as retir=
ed instructions.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -654,7 +654,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PublicDescription": "This event counts how many times the load op=
eration got the true Block-on-Store blocking code preventing store forwardi=
ng. This includes cases when:\n - preceding store conflicts with the load (=
incomplete overlap);\n - store forwarding is impossible due to u-arch limit=
ations;\n - preceding lock RMW operations are not forwarded;\n - store has =
the no-forward bit set (uncacheable/page-split/masked stores);\n - all-bloc=
king stores are used (mostly, fences and port I/O);\nand others.\nThe most =
common case is a load blocked due to its address range overlapping with a p=
receding smaller uncompleted store. Note: This event does not take into acc=
ount cases of out-of-SW-control (for example, SbTailHit), unknown physical =
STA, and cases of blocking loads on store due to being non-WB memory type o=
r a lock. These cases are covered by other events.\nSee the table of not su=
pported store forwards in the Optimization Guide.",
+        "PublicDescription": "This event counts how many times the load op=
eration got the true Block-on-Store blocking code preventing store forwardi=
ng. This includes cases when:  - preceding store conflicts with the load (i=
ncomplete overlap);  - store forwarding is impossible due to u-arch limitat=
ions;  - preceding lock RMW operations are not forwarded;  - store has the =
no-forward bit set (uncacheable/page-split/masked stores);  - all-blocking =
stores are used (mostly, fences and port I/O); and others. The most common =
case is a load blocked due to its address range overlapping with a precedin=
g smaller uncompleted store. Note: This event does not take into account ca=
ses of out-of-SW-control (for example, SbTailHit), unknown physical STA, an=
d cases of blocking loads on store due to being non-WB memory type or a loc=
k. These cases are covered by other events. See the table of not supported =
store forwards in the Optimization Guide.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -822,7 +822,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5E",
         "EventName": "RS_EVENTS.EMPTY_CYCLES",
-        "PublicDescription": "This event counts cycles during which the re=
servation station (RS) is empty for the thread.\nNote: In ST-mode, not acti=
ve thread should drive 0. This is usually caused by severely costly branch =
mispredictions, or allocator/FE issues.",
+        "PublicDescription": "This event counts cycles during which the re=
servation station (RS) is empty for the thread. Note: In ST-mode, not activ=
e thread should drive 0. This is usually caused by severely costly branch m=
ispredictions, or allocator/FE issues.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1177,7 +1177,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.FLAGS_MERGE",
-        "PublicDescription": "Number of flags-merge uops being allocated. =
Such uops considered perf sensitive\n added by GSR u-arch.",
+        "PublicDescription": "Number of flags-merge uops being allocated. =
Such uops considered perf sensitive  added by GSR u-arch.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
index f5b5ae1150c3..bfc499fdfdeb 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
@@ -608,7 +608,7 @@
         "EventCode": "0x12",
         "EventName": "UNC_C_RxR_EXT_STARVED.IPQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; IPQ is externally startved and therefore we are blocking the IRQ.",
+        "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; IPQ is externally starved and therefore we are blocking the IRQ.",
         "UMask": "0x2",
         "Unit": "CBOX"
     },
@@ -1654,7 +1654,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_H_BYPASS_IMC.NOT_TAKEN",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when the HA was a=
ble to bypass was attempted.  This is a latency optimization for situations=
 when there is light loadings on the memory subsystem.  This can be filted =
by when the bypass was taken and when it was not.; Filter for transactions =
that could not take the bypass.",
+        "PublicDescription": "Counts the number of times when the HA was a=
ble to bypass was attempted.  This is a latency optimization for situations=
 when there is light loadings on the memory subsystem.  This can be filtere=
d by when the bypass was taken and when it was not.; Filter for transaction=
s that could not take the bypass.",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -1664,7 +1664,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_H_BYPASS_IMC.TAKEN",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when the HA was a=
ble to bypass was attempted.  This is a latency optimization for situations=
 when there is light loadings on the memory subsystem.  This can be filted =
by when the bypass was taken and when it was not.; Filter for transactions =
that succeeded in taking the bypass.",
+        "PublicDescription": "Counts the number of times when the HA was a=
ble to bypass was attempted.  This is a latency optimization for situations=
 when there is light loadings on the memory subsystem.  This can be filtere=
d by when the bypass was taken and when it was not.; Filter for transaction=
s that succeeded in taking the bypass.",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -2679,7 +2679,7 @@
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN0",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high banwidth workloads should be able to make use of all of the regular b=
uffers, but it will be difficult (and uncommon) to make use of both the reg=
ular and special buffers at the same time.  One can filter based on the mem=
ory controller channel.  One or more channels can be tracked at a given tim=
e.; Filter for memory controller channel 0 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high bandwidth workloads should be able to make use of all of the regular =
buffers, but it will be difficult (and uncommon) to make use of both the re=
gular and special buffers at the same time.  One can filter based on the me=
mory controller channel.  One or more channels can be tracked at a given ti=
me.; Filter for memory controller channel 0 only.",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -2689,7 +2689,7 @@
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high banwidth workloads should be able to make use of all of the regular b=
uffers, but it will be difficult (and uncommon) to make use of both the reg=
ular and special buffers at the same time.  One can filter based on the mem=
ory controller channel.  One or more channels can be tracked at a given tim=
e.; Filter for memory controller channel 1 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high bandwidth workloads should be able to make use of all of the regular =
buffers, but it will be difficult (and uncommon) to make use of both the re=
gular and special buffers at the same time.  One can filter based on the me=
mory controller channel.  One or more channels can be tracked at a given ti=
me.; Filter for memory controller channel 1 only.",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -2699,7 +2699,7 @@
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN2",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high banwidth workloads should be able to make use of all of the regular b=
uffers, but it will be difficult (and uncommon) to make use of both the reg=
ular and special buffers at the same time.  One can filter based on the mem=
ory controller channel.  One or more channels can be tracked at a given tim=
e.; Filter for memory controller channel 2 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high bandwidth workloads should be able to make use of all of the regular =
buffers, but it will be difficult (and uncommon) to make use of both the re=
gular and special buffers at the same time.  One can filter based on the me=
mory controller channel.  One or more channels can be tracked at a given ti=
me.; Filter for memory controller channel 2 only.",
         "UMask": "0x4",
         "Unit": "HA"
     },
@@ -2709,7 +2709,7 @@
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN3",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high banwidth workloads should be able to make use of all of the regular b=
uffers, but it will be difficult (and uncommon) to make use of both the reg=
ular and special buffers at the same time.  One can filter based on the mem=
ory controller channel.  One or more channels can be tracked at a given tim=
e.; Filter for memory controller channel 3 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high bandwidth workloads should be able to make use of all of the regular =
buffers, but it will be difficult (and uncommon) to make use of both the re=
gular and special buffers at the same time.  One can filter based on the me=
mory controller channel.  One or more channels can be tracked at a given ti=
me.; Filter for memory controller channel 3 only.",
         "UMask": "0x8",
         "Unit": "HA"
     },
@@ -3239,7 +3239,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_H_TRACKER_CYCLES_NE.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is not empty.  This can be used with edge detect to identify=
 the number of situations when the pool became empty.  This should not be c=
onfused with RTID credit usage -- which must be tracked inside each cbo ind=
ividually -- but represents the actual tracker buffer structure.  In other =
words, this buffer could be completely empty, but there may still be credit=
s in use by the CBos.  This stat can be used in conjunction with the occupa=
ncy accumulation stat in order to calculate average queue occpancy.  HA tra=
ckers are allocated as soon as a request enters the HA if an HT (Home Track=
er) entry is available and is released after the snoop response and data re=
turn (or post in the case of a write) and the response is returned on the r=
ing.; Requests coming from both local and remote sockets.",
+        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is not empty.  This can be used with edge detect to identify=
 the number of situations when the pool became empty.  This should not be c=
onfused with RTID credit usage -- which must be tracked inside each cbo ind=
ividually -- but represents the actual tracker buffer structure.  In other =
words, this buffer could be completely empty, but there may still be credit=
s in use by the CBos.  This stat can be used in conjunction with the occupa=
ncy accumulation stat in order to calculate average queue occupancy.  HA tr=
ackers are allocated as soon as a request enters the HA if an HT (Home Trac=
ker) entry is available and is released after the snoop response and data r=
eturn (or post in the case of a write) and the response is returned on the =
ring.; Requests coming from both local and remote sockets.",
         "UMask": "0x3",
         "Unit": "HA"
     },
@@ -3249,7 +3249,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_H_TRACKER_CYCLES_NE.LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is not empty.  This can be used with edge detect to identify=
 the number of situations when the pool became empty.  This should not be c=
onfused with RTID credit usage -- which must be tracked inside each cbo ind=
ividually -- but represents the actual tracker buffer structure.  In other =
words, this buffer could be completely empty, but there may still be credit=
s in use by the CBos.  This stat can be used in conjunction with the occupa=
ncy accumulation stat in order to calculate average queue occpancy.  HA tra=
ckers are allocated as soon as a request enters the HA if an HT (Home Track=
er) entry is available and is released after the snoop response and data re=
turn (or post in the case of a write) and the response is returned on the r=
ing.; This filter includes only requests coming from the local socket.",
+        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is not empty.  This can be used with edge detect to identify=
 the number of situations when the pool became empty.  This should not be c=
onfused with RTID credit usage -- which must be tracked inside each cbo ind=
ividually -- but represents the actual tracker buffer structure.  In other =
words, this buffer could be completely empty, but there may still be credit=
s in use by the CBos.  This stat can be used in conjunction with the occupa=
ncy accumulation stat in order to calculate average queue occupancy.  HA tr=
ackers are allocated as soon as a request enters the HA if an HT (Home Trac=
ker) entry is available and is released after the snoop response and data r=
eturn (or post in the case of a write) and the response is returned on the =
ring.; This filter includes only requests coming from the local socket.",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -3259,7 +3259,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_H_TRACKER_CYCLES_NE.REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is not empty.  This can be used with edge detect to identify=
 the number of situations when the pool became empty.  This should not be c=
onfused with RTID credit usage -- which must be tracked inside each cbo ind=
ividually -- but represents the actual tracker buffer structure.  In other =
words, this buffer could be completely empty, but there may still be credit=
s in use by the CBos.  This stat can be used in conjunction with the occupa=
ncy accumulation stat in order to calculate average queue occpancy.  HA tra=
ckers are allocated as soon as a request enters the HA if an HT (Home Track=
er) entry is available and is released after the snoop response and data re=
turn (or post in the case of a write) and the response is returned on the r=
ing.; This filter includes only requests coming from remote sockets.",
+        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is not empty.  This can be used with edge detect to identify=
 the number of situations when the pool became empty.  This should not be c=
onfused with RTID credit usage -- which must be tracked inside each cbo ind=
ividually -- but represents the actual tracker buffer structure.  In other =
words, this buffer could be completely empty, but there may still be credit=
s in use by the CBos.  This stat can be used in conjunction with the occupa=
ncy accumulation stat in order to calculate average queue occupancy.  HA tr=
ackers are allocated as soon as a request enters the HA if an HT (Home Trac=
ker) entry is available and is released after the snoop response and data r=
eturn (or post in the case of a write) and the response is returned on the =
ring.; This filter includes only requests coming from remote sockets.",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -3679,7 +3679,7 @@
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN0",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high banwidth workloads should be able to make use of all of the regu=
lar buffers, but it will be difficult (and uncommon) to make use of both th=
e regular and special buffers at the same time.  One can filter based on th=
e memory controller channel.  One or more channels can be tracked at a give=
n time.; Filter for memory controller channel 0 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high bandwidth workloads should be able to make use of all of the reg=
ular buffers, but it will be difficult (and uncommon) to make use of both t=
he regular and special buffers at the same time.  One can filter based on t=
he memory controller channel.  One or more channels can be tracked at a giv=
en time.; Filter for memory controller channel 0 only.",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -3689,7 +3689,7 @@
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high banwidth workloads should be able to make use of all of the regu=
lar buffers, but it will be difficult (and uncommon) to make use of both th=
e regular and special buffers at the same time.  One can filter based on th=
e memory controller channel.  One or more channels can be tracked at a give=
n time.; Filter for memory controller channel 1 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high bandwidth workloads should be able to make use of all of the reg=
ular buffers, but it will be difficult (and uncommon) to make use of both t=
he regular and special buffers at the same time.  One can filter based on t=
he memory controller channel.  One or more channels can be tracked at a giv=
en time.; Filter for memory controller channel 1 only.",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -3699,7 +3699,7 @@
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN2",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high banwidth workloads should be able to make use of all of the regu=
lar buffers, but it will be difficult (and uncommon) to make use of both th=
e regular and special buffers at the same time.  One can filter based on th=
e memory controller channel.  One or more channels can be tracked at a give=
n time.; Filter for memory controller channel 2 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high bandwidth workloads should be able to make use of all of the reg=
ular buffers, but it will be difficult (and uncommon) to make use of both t=
he regular and special buffers at the same time.  One can filter based on t=
he memory controller channel.  One or more channels can be tracked at a giv=
en time.; Filter for memory controller channel 2 only.",
         "UMask": "0x4",
         "Unit": "HA"
     },
@@ -3709,7 +3709,7 @@
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN3",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high banwidth workloads should be able to make use of all of the regu=
lar buffers, but it will be difficult (and uncommon) to make use of both th=
e regular and special buffers at the same time.  One can filter based on th=
e memory controller channel.  One or more channels can be tracked at a give=
n time.; Filter for memory controller channel 3 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high bandwidth workloads should be able to make use of all of the reg=
ular buffers, but it will be difficult (and uncommon) to make use of both t=
he regular and special buffers at the same time.  One can filter based on t=
he memory controller channel.  One or more channels can be tracked at a giv=
en time.; Filter for memory controller channel 3 only.",
         "UMask": "0x8",
         "Unit": "HA"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect=
.json b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
index 58031f397168..5ccc49cb66a6 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
@@ -33,7 +33,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x80",
         "Unit": "IRP"
     },
@@ -43,7 +43,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.CRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x2",
         "Unit": "IRP"
     },
@@ -53,7 +53,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.DRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x4",
         "Unit": "IRP"
     },
@@ -63,7 +63,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.PCIDCAHINT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x20",
         "Unit": "IRP"
     },
@@ -73,7 +73,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.PCIRDCUR",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x1",
         "Unit": "IRP"
     },
@@ -83,7 +83,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.PCITOM",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x10",
         "Unit": "IRP"
     },
@@ -93,7 +93,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.RFO",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x8",
         "Unit": "IRP"
     },
@@ -103,7 +103,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x40",
         "Unit": "IRP"
     },
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 01f6a4a82ed2..a442ace16a67 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -4,7 +4,7 @@ GenuineIntel-6-BE,v1.28,alderlaken,core
 GenuineIntel-6-C[56],v1.05,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
-GenuineIntel-6-56,v11,broadwellde,core
+GenuineIntel-6-56,v12,broadwellde,core
 GenuineIntel-6-4F,v22,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.22,cascadelakex,core
 GenuineIntel-6-9[6C],v1.05,elkhartlake,core
--=20
2.47.1.545.g3c1d2e2a6a-goog

