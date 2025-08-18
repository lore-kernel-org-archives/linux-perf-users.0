Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C978F36
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543947; cv=none; b=ftlexXC9tITHq784oUgImUWHw+rX4CvA2BX1g43No1KpnlOO9ugxIAJuHO7+a8p1tu7Bi4SI6VbQbupX6HY6BbaNjvZigxTscZXkqZYkE6EOeOKm2Sb4b0Cr//9Qi3it2t9+ijOvpNYx4XUNG9h5PE6uH5ntEOr+xpIUko9wyHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543947; c=relaxed/simple;
	bh=vWKJBpaScNOWQfCoq/T/wkqQUgU2SHHR+ai5/eBBOxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KnBlt9HOjGuf9sKQbboBkISkD2wqLI0CkWb7BO2IjOi+9WlULIU84drbqzksWUPN+7p2LboU/A2NTGB/gVv2alnmlljZsKd5MlA/9QmKPs0d1WhXeRMCARU+vMsWHMgdTNY1oFkH079Z/G3IFYHbsXvyDk7Ou34nVFaH9yoCE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nj2dFUlm; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nj2dFUlm"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47174c65b0so9034396a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755543943; x=1756148743; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5w4JuxdJH1+BngTPD2SES+TYEhCQ4dCjZ3RtaRCrrY=;
        b=nj2dFUlmmjWKoV0niK7ot62xk6QwoqxxmpRd41n3sXGqFhk4esbfhNvqpQl+kHaHBJ
         0BDj81KOQhyufTHITpYyowkjDcKyVOP34AdOSWWLHDbOW+BLCyMso50l0gq2WtaUWtaw
         dDGb8Me5PsyNllPZHIEkeUWc2NOFMN0rg7R+Lmxq6w89sLbDNeZ9y52jlKHXlHBdYY7w
         2sel55lEzHa9FxQ3EMgsyygiY7Iiah89Xsk9e+RzE6SUX7ATRuraJ3ok27Hj0CnHSgRb
         bGQFtNMQSnjJoxngYUrOjrWrFhd1RLstV3qON8aq7S05xLJlme55gEaigkhqcsa5Rtsp
         0Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543943; x=1756148743;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h5w4JuxdJH1+BngTPD2SES+TYEhCQ4dCjZ3RtaRCrrY=;
        b=jGT344m83K5ulpdjY5mf+CYIHqjSoUyOj3m8vrCvp+96Bd10eXbxsM/aC5aCnio0Sv
         OUO+BjlT0/GTsYddDJ4wwdDGuDEqVQIKEjcN15H3rtKkWneMEn/qyTmYM1Q1ir1/GWxR
         cmPLArCN0bkybtvLWU82DghN41cgTLL7nz5lLmPUuAuKZJsETxAJ6uvFIG8gZNruUVUh
         lHEQd059Y1BWslyuo8lVI8gKWaYR5AFCI8OwjCodOFzHO5Q0mn3XLh4ewKJloKCkn8PC
         aQpZYs/5A3BRbagKWf1dOkcwgubLMIMm5Vj44YFDDc++QuVpMN/RhDxDho3emUskDXmV
         sZgg==
X-Forwarded-Encrypted: i=1; AJvYcCV+dL6E6lu5h6qKin6YTfzLYqxF1ANHUekBtuWx3qjxzk7nKyVfj7nBG9hNu/uwo1p8Ka9bGnAfJvcfb/XmNRZA@vger.kernel.org
X-Gm-Message-State: AOJu0YwgW2T3qyJruImmiUYartk9vuRUNvKtFm22oTh3SziYHVFVpA9u
	gbqVkARvLsRv3j3LH3oQ5+Z0VOTFvdQZU3ERnrUMSLDfcD5ANm/zvsaogFsr7PJbHOWGIXB+g2r
	KyYHdi2h0rQ==
X-Google-Smtp-Source: AGHT+IFW4wrrGD2D7qkTClbN2j0h9cYk9vkh2VnUtjH3byXgfJffydCOAxZDlAq7xBNP1jmIlLl/8pfatVhS
X-Received: from plho15.prod.google.com ([2002:a17:903:23cf:b0:240:468a:9a20])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1965:b0:243:926:b1f3
 with SMTP id d9443c01a7336-2446d7a9610mr208817295ad.24.1755543943322; Mon, 18
 Aug 2025 12:05:43 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:04:05 -0700
In-Reply-To: <20250818190416.145274-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818190416.145274-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818190416.145274-10-irogers@google.com>
Subject: [PATCH v2 09/20] perf vendor events: Update haswell metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update metrics from TMA 5.0 to 5.1.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 .../arch/x86/haswell/hsw-metrics.json         | 32 ++++++++---------
 .../arch/x86/haswellx/hsx-metrics.json        | 35 +++++++++----------
 2 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tool=
s/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
index b26ea70a3628..aebd82ced1cf 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
@@ -1,49 +1,49 @@
 [
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency",
         "ScaleUnit": "100%"
@@ -80,7 +80,6 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_thread_slots",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
@@ -98,7 +97,6 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
         "MetricGroup": "BvOB;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
@@ -139,7 +137,6 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
@@ -509,7 +506,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * msr@tsc@ / 1e9 =
/ tma_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -521,7 +518,7 @@
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized"
     },
@@ -696,7 +693,6 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 + UOPS_DISPATCHED_PORT.PORT_7 - UOPS_DISPATCHED_PORT.PORT_4) / (2 *=
 tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
@@ -746,7 +742,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALL=
S_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_=
ACTIVITY.CYCLES_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - (cpu=
@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else cpu@UO=
PS_EXECUTED.CORE\\,cmask\\=3D2@)) / 2 - (RS_EVENTS.EMPTY_CYCLES if tma_fetc=
h_latency > 0.1 else 0) + RESOURCE_STALLS.SB) if #SMT_on else min(CPU_CLK_U=
NHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\=
\,cmask\\=3D1@ - (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_=
ipc > 1.8 else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) - (RS_EVENTS.EMPTY_CY=
CLES if tma_fetch_latency > 0.1 else 0) + RESOURCE_STALLS.SB) * tma_backend=
_bound",
+        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS=
_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_A=
CTIVITY.CYCLES_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - (cpu@=
UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else cpu@UOP=
S_EXECUTED.CORE\\,cmask\\=3D2@)) / 2 - (RS_EVENTS.EMPTY_CYCLES if tma_fetch=
_latency > 0.1 else 0) + RESOURCE_STALLS.SB if #SMT_on else min(CPU_CLK_UNH=
ALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,=
cmask\\=3D1@ - (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_ip=
c > 1.8 else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) - (RS_EVENTS.EMPTY_CYCL=
ES if tma_fetch_latency > 0.1 else 0) + RESOURCE_STALLS.SB) * tma_backend_b=
ound",
         "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_b=
ound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
@@ -856,7 +852,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES=
_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - (cpu@UOPS_EXECUTED.=
CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else cpu@UOPS_EXECUTED.COR=
E\\,cmask\\=3D2@)) / 2 - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1=
 else 0) + RESOURCE_STALLS.SB if #SMT_on else min(CPU_CLK_UNHALTED.THREAD, =
CYCLE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ -=
 (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else c=
pu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) - (RS_EVENTS.EMPTY_CYCLES if tma_fetc=
h_latency > 0.1 else 0) + RESOURCE_STALLS.SB - RESOURCE_STALLS.SB - min(CPU=
_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS_LDM_PENDING)) / tma_info_thread=
_clks",
+        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLE=
S_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - (cpu@UOPS_EXECUTED=
.CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else cpu@UOPS_EXECUTED.CO=
RE\\,cmask\\=3D2@)) / 2 - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.=
1 else 0) + RESOURCE_STALLS.SB if #SMT_on else min(CPU_CLK_UNHALTED.THREAD,=
 CYCLE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ =
- (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else =
cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) - (RS_EVENTS.EMPTY_CYCLES if tma_fet=
ch_latency > 0.1 else 0) + RESOURCE_STALLS.SB) - RESOURCE_STALLS.SB - min(C=
PU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS_LDM_PENDING)) / tma_info_thre=
ad_clks",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
         "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
@@ -865,7 +861,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUT=
E) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) / tma_info=
_core_core_clks)",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUTE=
) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) / tma_info_=
core_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -874,7 +870,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (cpu@UOPS_EXECUTED.CORE\\=
,cmask\\=3D1@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) / tma_info_core_core=
_clks)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,=
cmask\\=3D1@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) / tma_info_core_core_=
clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
         "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -883,7 +879,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (cpu@UOPS_EXECUTED.CORE\\=
,cmask\\=3D2@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / tma_info_core_core=
_clks)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,=
cmask\\=3D2@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / tma_info_core_core_=
clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index 8245a98ad4b9..b8845f8a28b9 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -1,49 +1,49 @@
 [
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency",
         "ScaleUnit": "100%"
@@ -282,7 +282,6 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_thread_slots",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
@@ -300,7 +299,6 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
         "MetricGroup": "BvOB;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
@@ -341,7 +339,6 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
@@ -711,7 +708,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * msr@tsc@ / 1e9 =
/ tma_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -723,7 +720,7 @@
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized"
     },
@@ -756,6 +753,7 @@
     },
     {
         "BriefDescription": "Average number of parallel data read requests=
 to external memory",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x18=
2@ / UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x182\\,thresh\\=3D1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
@@ -918,7 +916,6 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 + UOPS_DISPATCHED_PORT.PORT_7 - UOPS_DISPATCHED_PORT.PORT_4) / (2 *=
 tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
@@ -928,6 +925,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "200 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM * (=
1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOA=
D_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UO=
PS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_=
LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE=
_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_R=
ETIRED.REMOTE_FWD))) / tma_info_thread_clks",
         "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
         "MetricName": "tma_local_mem",
@@ -977,7 +975,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALL=
S_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_=
ACTIVITY.CYCLES_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - (cpu=
@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else cpu@UO=
PS_EXECUTED.CORE\\,cmask\\=3D2@)) / 2 - (RS_EVENTS.EMPTY_CYCLES if tma_fetc=
h_latency > 0.1 else 0) + RESOURCE_STALLS.SB) if #SMT_on else min(CPU_CLK_U=
NHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\=
\,cmask\\=3D1@ - (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_=
ipc > 1.8 else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) - (RS_EVENTS.EMPTY_CY=
CLES if tma_fetch_latency > 0.1 else 0) + RESOURCE_STALLS.SB) * tma_backend=
_bound",
+        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS=
_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_A=
CTIVITY.CYCLES_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - (cpu@=
UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else cpu@UOP=
S_EXECUTED.CORE\\,cmask\\=3D2@)) / 2 - (RS_EVENTS.EMPTY_CYCLES if tma_fetch=
_latency > 0.1 else 0) + RESOURCE_STALLS.SB if #SMT_on else min(CPU_CLK_UNH=
ALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,=
cmask\\=3D1@ - (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_ip=
c > 1.8 else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) - (RS_EVENTS.EMPTY_CYCL=
ES if tma_fetch_latency > 0.1 else 0) + RESOURCE_STALLS.SB) * tma_backend_b=
ound",
         "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_b=
ound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
@@ -1087,7 +1085,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES=
_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - (cpu@UOPS_EXECUTED.=
CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else cpu@UOPS_EXECUTED.COR=
E\\,cmask\\=3D2@)) / 2 - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1=
 else 0) + RESOURCE_STALLS.SB if #SMT_on else min(CPU_CLK_UNHALTED.THREAD, =
CYCLE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ -=
 (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else c=
pu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) - (RS_EVENTS.EMPTY_CYCLES if tma_fetc=
h_latency > 0.1 else 0) + RESOURCE_STALLS.SB - RESOURCE_STALLS.SB - min(CPU=
_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS_LDM_PENDING)) / tma_info_thread=
_clks",
+        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLE=
S_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - (cpu@UOPS_EXECUTED=
.CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else cpu@UOPS_EXECUTED.CO=
RE\\,cmask\\=3D2@)) / 2 - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.=
1 else 0) + RESOURCE_STALLS.SB if #SMT_on else min(CPU_CLK_UNHALTED.THREAD,=
 CYCLE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ =
- (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else =
cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) - (RS_EVENTS.EMPTY_CYCLES if tma_fet=
ch_latency > 0.1 else 0) + RESOURCE_STALLS.SB) - RESOURCE_STALLS.SB - min(C=
PU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS_LDM_PENDING)) / tma_info_thre=
ad_clks",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
         "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
@@ -1096,7 +1094,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUT=
E) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) / tma_info=
_core_core_clks)",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUTE=
) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) / tma_info_=
core_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1105,7 +1103,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (cpu@UOPS_EXECUTED.CORE\\=
,cmask\\=3D1@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) / tma_info_core_core=
_clks)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,=
cmask\\=3D1@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) / tma_info_core_core_=
clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
         "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1114,7 +1112,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (cpu@UOPS_EXECUTED.CORE\\=
,cmask\\=3D2@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / tma_info_core_core=
_clks)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,=
cmask\\=3D2@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / tma_info_core_core_=
clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1141,6 +1139,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "310 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM * =
(1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LO=
AD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM=
_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOT=
E_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_=
RETIRED.REMOTE_FWD))) / tma_info_thread_clks",
         "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
         "MetricName": "tma_remote_mem",
--=20
2.51.0.rc1.167.g924127e9c0-goog

