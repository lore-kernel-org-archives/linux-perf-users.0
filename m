Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E764B1366
	for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716600643; cv=none; b=I1XhMGVmBxtUBKkFxxAaQ1f1zGDOP5DeTHhep+61968p8do4xFX41mkmg4gXIIBYNo5ZiQ4nLBw0qP1O9iVTu+qpvEU2LxCt88EAgMGrshHq30v2BjNlWKSkkrK+jMUPxeX/K+2um0pv6rTFxj37y8ki5jLrKPP0lMW/zgyzy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716600643; c=relaxed/simple;
	bh=zFzITPJhtRNm/GCLm0K2/hovkuLShO8P2L80sxOvFLU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rxDHwWY/88tDz2ou4A4KeFfvm6g14MlL8VD44Er3C6c2TtM8KPhzwhPNVPdpjklShMDVNhtoVxgrIWyBLJse6CZ+LQhccj8ek+r4QdD3X956+yX4lUn8aAEPgSOcG2khQq05hhqxcZyly+T+dX20WyepD4mUVNyGNHdDJp0ZPQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yHdaesDX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yHdaesDX"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a088faef7so10512137b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 18:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716600639; x=1717205439; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgYgRR7a5EfLTnx89EGds3S1GOXd+u68OHA+xjtS1pQ=;
        b=yHdaesDX2QiJaDDems9iN9jPuqcbRXW/S2I+FJ/PfLwy6GGLjBm9iWiJglhWvGH+xR
         /eYPP/u+F0PCwxDLvJvBDX60nsDSr0N/QtO1ghRCDrH3NR8O6/WgamaKQgPRP5wZZKNE
         HftJpcN80uTXfy5xi9iz0St1G0jhUD9jxl/8yVCEHifjkOXK7XHf0YhwTY0ecCpiq+o9
         WpYS5SYKIUBU1qEJsrAu5UoMHpkKHsNCi/EVvZCEsZt7FVrs9WVRZ/lqiW0m0HECmXP4
         LdKBTcgwuJx/KDwsaRWtHyMUl/4fLINCK28GbJ3sc1NDh76CEHeFka1DIdcTDc1x//rY
         BDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716600639; x=1717205439;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YgYgRR7a5EfLTnx89EGds3S1GOXd+u68OHA+xjtS1pQ=;
        b=XEQqbGEcutjgBTrqIqv+frIW7VY6SidVFopCYtqZOjr4t+Kx8jdWYHRP2DxPJztkXl
         2prAHIBobF7FHF2Z80kBbA/fE51BN50AL+lSyAwhwmUl/YXRjFLrCxTHrKH2p39GDzgZ
         wt0WxAz1h9Zf4u/dX0ZXBlURsXDw0cmKVabosLOiblHNMOw8OqlVo14j5HO+kqDLw4Mj
         gGjY+Vg0iPtuqdtQOgc6sC8UEXaeOlea97KdLneBShDEfIk92x4S7rwLcMXC8XZr/VwH
         Armqr2/wMS0pRNmuuzyhVhp82J3aAHxGJc6Zrs/AvtCqopbkrk0hR7wxp6dXkUdFa1eB
         UzvA==
X-Forwarded-Encrypted: i=1; AJvYcCXvMFG/WsnYGXCdTwkV2xn4DDmFaxAo1RKG4U8yvbkPbkA4nDVPkAIGoE/6NeXOy4rsw3xf8FN5jRq2djxSqow11yZAVczm2czQZHx4MBUnYw==
X-Gm-Message-State: AOJu0YxXNMGAtRBQHbgEMYVtjMaeFkfhM5jQJw3ap646W/QxCoocrnk/
	LmnrVcCQ8LOOeRAE6P0UKfwiRdyJA8aiae9eXvPJM9v3XomgZPEomWBxR2+qsKVhUBI4gc8tDL8
	DUVH2DQ==
X-Google-Smtp-Source: AGHT+IFw4r0/n8ZABQzmrsfnEk5cHOPV4maduLXD3+ZeJ9ORXvHVTxA2g9v5en+ruTpz5HaEh7uJH6euIdDw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b0b5:95af:a29:375e])
 (user=irogers job=sendgmr) by 2002:a05:6902:702:b0:df4:ee8a:bfcf with SMTP id
 3f1490d57ef6-df770ddea81mr1121818276.3.1716600638963; Fri, 24 May 2024
 18:30:38 -0700 (PDT)
Date: Fri, 24 May 2024 18:30:21 -0700
In-Reply-To: <20240525013021.436430-1-irogers@google.com>
Message-Id: <20240525013021.436430-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240525013021.436430-1-irogers@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c
From: Ian Rogers <irogers@google.com>
To: Weilin Wang <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	John Garry <john.g.garry@oracle.com>, Sandipan Das <sandipan.das@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

empty-pmu-events.c exists so that builds may occur without python
being installed on a system. Manually updating empty-pmu-events.c to
be in sync with jevents.py is a pain, let's use jevents.py to generate
empty-pmu-events.c.

1) change jevents.py so that an arch and model of none cause
   generation of a pmu-events.c without any json. Add a SPDX and
   autogenerated warning to the start of the file.

2) change Build so that if a generated pmu-events.c for arch none and
   model none doesn't match empty-pmu-events.c the build fails with a
   cat of the differences. Update Makefile.perf to clean up the files
   used for this.

3) update empty-pmu-events.c to match the output of jevents.py with
   arch and mode of none.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf                 |   2 +
 tools/perf/pmu-events/Build              |  12 +-
 tools/perf/pmu-events/empty-pmu-events.c | 894 ++++++++++++++---------
 tools/perf/pmu-events/jevents.py         |   6 +-
 4 files changed, 562 insertions(+), 352 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5c35c0d89306..4369c57a1d12 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1210,6 +1210,8 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-=
clean $(LIBSYMBOL)-clean $(
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
+		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
+		$(OUTPUT)pmu-events/empty-pmu-events.log \
 		$(OUTPUT)pmu-events/metric_test.log \
 		$(OUTPUT)$(fadvise_advice_array) \
 		$(OUTPUT)$(fsconfig_arrays) \
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 1d18bb89402e..c3fa43c49706 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -11,6 +11,8 @@ METRIC_TEST_PY	=3D  pmu-events/metric_test.py
 EMPTY_PMU_EVENTS_C =3D pmu-events/empty-pmu-events.c
 PMU_EVENTS_C	=3D  $(OUTPUT)pmu-events/pmu-events.c
 METRIC_TEST_LOG	=3D  $(OUTPUT)pmu-events/metric_test.log
+TEST_EMPTY_PMU_EVENTS_C =3D $(OUTPUT)pmu-events/test-empty-pmu-events.c
+EMPTY_PMU_EVENTS_TEST_LOG =3D $(OUTPUT)pmu-events/empty-pmu-events.log
=20
 ifeq ($(JEVENTS_ARCH),)
 JEVENTS_ARCH=3D$(SRCARCH)
@@ -31,7 +33,15 @@ $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
=20
-$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_=
TEST_LOG)
+$(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY=
) $(METRIC_TEST_LOG)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none pmu-events/arch=
 $@
+
+$(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENT=
S_C)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)diff -u $? 2> $@ || (cat $@ && false)
+
+$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_=
TEST_LOG) $(EMPTY_PMU_EVENTS_TEST_LOG)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS=
_MODEL) pmu-events/arch $@
 endif
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index 13727421d424..c592079982fb 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -1,196 +1,193 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * An empty pmu-events.c file used when there is no architecture json file=
s in
- * arch or when the jevents.py script cannot be run.
- *
- * The test cpu/soc is provided for testing.
- */
-#include "pmu-events/pmu-events.h"
+
+/* SPDX-License-Identifier: GPL-2.0 */
+/* THIS FILE WAS AUTOGENERATED BY jevents.py arch=3Dnone model=3Dnone ! */
+
+#include <pmu-events/pmu-events.h>
 #include "util/header.h"
 #include "util/pmu.h"
 #include <string.h>
 #include <stddef.h>
=20
-static const struct pmu_event pmu_events__test_soc_cpu[] =3D {
-	{
-		.name =3D "l3_cache_rd",
-		.event =3D "event=3D0x40",
-		.desc =3D "L3 cache access, read",
-		.topic =3D "cache",
-		.long_desc =3D "Attributable Level 3 cache access, read",
-	},
-	{
-		.name =3D "segment_reg_loads.any",
-		.event =3D "event=3D0x6,period=3D200000,umask=3D0x80",
-		.desc =3D "Number of segment register loads",
-		.topic =3D "other",
-	},
-	{
-		.name =3D "dispatch_blocked.any",
-		.event =3D "event=3D0x9,period=3D200000,umask=3D0x20",
-		.desc =3D "Memory cluster signals to block micro-op dispatch for any rea=
son",
-		.topic =3D "other",
-	},
-	{
-		.name =3D "eist_trans",
-		.event =3D "event=3D0x3a,period=3D200000,umask=3D0x0",
-		.desc =3D "Number of Enhanced Intel SpeedStep(R) Technology (EIST) trans=
itions",
-		.topic =3D "other",
-	},
-	{
-		.name =3D "uncore_hisi_ddrc.flux_wcmd",
-		.event =3D "event=3D0x2",
-		.desc =3D "DDRC write commands. Unit: hisi_sccl,ddrc ",
-		.topic =3D "uncore",
-		.long_desc =3D "DDRC write commands",
-		.pmu =3D "hisi_sccl,ddrc",
-	},
-	{
-		.name =3D "unc_cbo_xsnp_response.miss_eviction",
-		.event =3D "event=3D0x22,umask=3D0x81",
-		.desc =3D "A cross-core snoop resulted from L3 Eviction which misses in =
some processor core. Unit: uncore_cbox ",
-		.topic =3D "uncore",
-		.long_desc =3D "A cross-core snoop resulted from L3 Eviction which misse=
s in some processor core",
-		.pmu =3D "uncore_cbox",
-	},
-	{
-		.name =3D "event-hyphen",
-		.event =3D "event=3D0xe0,umask=3D0x00",
-		.desc =3D "UNC_CBO_HYPHEN. Unit: uncore_cbox ",
-		.topic =3D "uncore",
-		.long_desc =3D "UNC_CBO_HYPHEN",
-		.pmu =3D "uncore_cbox",
-	},
-	{
-		.name =3D "event-two-hyph",
-		.event =3D "event=3D0xc0,umask=3D0x00",
-		.desc =3D "UNC_CBO_TWO_HYPH. Unit: uncore_cbox ",
-		.topic =3D "uncore",
-		.long_desc =3D "UNC_CBO_TWO_HYPH",
-		.pmu =3D "uncore_cbox",
-	},
-	{
-		.name =3D "uncore_hisi_l3c.rd_hit_cpipe",
-		.event =3D "event=3D0x7",
-		.desc =3D "Total read hits. Unit: hisi_sccl,l3c ",
-		.topic =3D "uncore",
-		.long_desc =3D "Total read hits",
-		.pmu =3D "hisi_sccl,l3c",
-	},
-	{
-		.name =3D "uncore_imc_free_running.cache_miss",
-		.event =3D "event=3D0x12",
-		.desc =3D "Total cache misses. Unit: uncore_imc_free_running ",
-		.topic =3D "uncore",
-		.long_desc =3D "Total cache misses",
-		.pmu =3D "uncore_imc_free_running",
-	},
-	{
-		.name =3D "uncore_imc.cache_hits",
-		.event =3D "event=3D0x34",
-		.desc =3D "Total cache hits. Unit: uncore_imc ",
-		.topic =3D "uncore",
-		.long_desc =3D "Total cache hits",
-		.pmu =3D "uncore_imc",
-	},
-	{
-		.name =3D "bp_l1_btb_correct",
-		.event =3D "event=3D0x8a",
-		.desc =3D "L1 BTB Correction",
-		.topic =3D "branch",
-	},
-	{
-		.name =3D "bp_l2_btb_correct",
-		.event =3D "event=3D0x8b",
-		.desc =3D "L2 BTB Correction",
-		.topic =3D "branch",
-	},
-	{
-		.name =3D 0,
-		.event =3D 0,
-		.desc =3D 0,
-	},
+struct compact_pmu_event {
+        int offset;
 };
=20
-static const struct pmu_metric pmu_metrics__test_soc_cpu[] =3D {
-	{
-		.metric_expr	=3D "1 / IPC",
-		.metric_name	=3D "CPI",
-	},
-	{
-		.metric_expr	=3D "inst_retired.any / cpu_clk_unhalted.thread",
-		.metric_name	=3D "IPC",
-		.metric_group	=3D "group1",
-	},
-	{
-		.metric_expr	=3D "idq_uops_not_delivered.core / (4 * (( ( cpu_clk_unhalt=
ed.thread / 2 ) * "
-		"( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk ) =
)))",
-		.metric_name	=3D "Frontend_Bound_SMT",
-	},
-	{
-		.metric_expr	=3D "l1d\\-loads\\-misses / inst_retired.any",
-		.metric_name	=3D "dcache_miss_cpi",
-	},
-	{
-		.metric_expr	=3D "l1i\\-loads\\-misses / inst_retired.any",
-		.metric_name	=3D "icache_miss_cycles",
-	},
-	{
-		.metric_expr	=3D "(dcache_miss_cpi + icache_miss_cycles)",
-		.metric_name	=3D "cache_miss_cycles",
-		.metric_group	=3D "group1",
-	},
-	{
-		.metric_expr	=3D "l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqs=
ts.rfo_hit",
-		.metric_name	=3D "DCache_L2_All_Hits",
-	},
-	{
-		.metric_expr	=3D "max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data=
_rd_hit, 0) + "
-		"l2_rqsts.pf_miss + l2_rqsts.rfo_miss",
-		.metric_name	=3D "DCache_L2_All_Miss",
-	},
-	{
-		.metric_expr	=3D "DCache_L2_All_Hits + DCache_L2_All_Miss",
-		.metric_name	=3D "DCache_L2_All",
-	},
-	{
-		.metric_expr	=3D "d_ratio(DCache_L2_All_Hits, DCache_L2_All)",
-		.metric_name	=3D "DCache_L2_Hits",
-	},
-	{
-		.metric_expr	=3D "d_ratio(DCache_L2_All_Miss, DCache_L2_All)",
-		.metric_name	=3D "DCache_L2_Misses",
-	},
-	{
-		.metric_expr	=3D "ipc + M2",
-		.metric_name	=3D "M1",
-	},
-	{
-		.metric_expr	=3D "ipc + M1",
-		.metric_name	=3D "M2",
-	},
-	{
-		.metric_expr	=3D "1/M3",
-		.metric_name	=3D "M3",
-	},
-	{
-		.metric_expr	=3D "64 * l1d.replacement / 1000000000 / duration_time",
-		.metric_name	=3D "L1D_Cache_Fill_BW",
-	},
-	{
-		.metric_expr =3D 0,
-		.metric_name =3D 0,
-	},
+struct pmu_table_entry {
+        const struct compact_pmu_event *entries;
+        uint32_t num_entries;
+        struct compact_pmu_event pmu_name;
+};
+
+static const char *const big_c_string =3D
+/* offset=3D0 */ "default_core\000"
+/* offset=3D13 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\000eve=
nt=3D0x8a\000\00000\000\000"
+/* offset=3D72 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\000eve=
nt=3D0x8b\000\00000\000\000"
+/* offset=3D131 */ "l3_cache_rd\000cache\000L3 cache access, read\000event=
=3D0x40\000\00000\000Attributable Level 3 cache access, read\000"
+/* offset=3D226 */ "segment_reg_loads.any\000other\000Number of segment re=
gister loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000"
+/* offset=3D325 */ "dispatch_blocked.any\000other\000Memory cluster signal=
s to block micro-op dispatch for any reason\000event=3D9,period=3D200000,um=
ask=3D0x20\000\00000\000\000"
+/* offset=3D455 */ "eist_trans\000other\000Number of Enhanced Intel SpeedS=
tep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00=
000\000\000"
+/* offset=3D570 */ "hisi_sccl,ddrc\000"
+/* offset=3D585 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write com=
mands\000event=3D2\000\00000\000DDRC write commands\000"
+/* offset=3D671 */ "uncore_cbox\000"
+/* offset=3D683 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cro=
ss-core snoop resulted from L3 Eviction which misses in some processor core=
\000event=3D0x22,umask=3D0x81\000\00000\000A cross-core snoop resulted from=
 L3 Eviction which misses in some processor core\000"
+/* offset=3D914 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0x=
e0\000\00000\000UNC_CBO_HYPHEN\000"
+/* offset=3D979 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=
=3D0xc0\000\00000\000UNC_CBO_TWO_HYPH\000"
+/* offset=3D1050 */ "hisi_sccl,l3c\000"
+/* offset=3D1064 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read =
hits\000event=3D7\000\00000\000Total read hits\000"
+/* offset=3D1144 */ "uncore_imc_free_running\000"
+/* offset=3D1168 */ "uncore_imc_free_running.cache_miss\000uncore\000Total=
 cache misses\000event=3D0x12\000\00000\000Total cache misses\000"
+/* offset=3D1263 */ "uncore_imc\000"
+/* offset=3D1274 */ "uncore_imc.cache_hits\000uncore\000Total cache hits\0=
00event=3D0x34\000\00000\000Total cache hits\000"
+/* offset=3D1352 */ "uncore_sys_ddr_pmu\000"
+/* offset=3D1371 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycle=
s event\000event=3D0x2b\000v8\00000\000\000"
+/* offset=3D1444 */ "uncore_sys_ccn_pmu\000"
+/* offset=3D1463 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles =
event\000config=3D0x2c\0000x01\00000\000\000"
+/* offset=3D1537 */ "uncore_sys_cmn_pmu\000"
+/* offset=3D1556 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total =
cache misses in first lookup result (high priority)\000eventid=3D1,type=3D5=
\000(434|436|43c|43a).*\00000\000\000"
+/* offset=3D1696 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000"
+/* offset=3D1718 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.=
thread\000\000\000\000\000\000\000\00000"
+/* offset=3D1781 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core=
 / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_act=
ive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
+/* offset=3D1947 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_re=
tired.any\000\000\000\000\000\000\000\00000"
+/* offset=3D2011 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst=
_retired.any\000\000\000\000\000\000\000\00000"
+/* offset=3D2078 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + icac=
he_miss_cycles\000\000\000\000\000\000\000\00000"
+/* offset=3D2149 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit=
 + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
+/* offset=3D2243 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_dat=
a_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_mi=
ss\000\000\000\000\000\000\000\00000"
+/* offset=3D2377 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_A=
ll_Miss\000\000\000\000\000\000\000\00000"
+/* offset=3D2441 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCa=
che_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=3D2509 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, D=
Cache_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=3D2579 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00000"
+/* offset=3D2601 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00000"
+/* offset=3D2623 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
+/* offset=3D2643 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 /=
 duration_time\000\000\000\000\000\000\000\00000"
+;
+
+static const struct compact_pmu_event pmu_events__test_soc_cpu_default_cor=
e[] =3D {
+{ 13 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8=
a\000\00000\000\000 */
+{ 72 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8=
b\000\00000\000\000 */
+{ 325 }, /* dispatch_blocked.any\000other\000Memory cluster signals to blo=
ck micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=3D0x=
20\000\00000\000\000 */
+{ 455 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) T=
echnology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\000\=
000 */
+{ 131 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\=
000\00000\000Attributable Level 3 cache access, read\000 */
+{ 226 }, /* segment_reg_loads.any\000other\000Number of segment register l=
oads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000 */
+};
+static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {
+{ 585 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\00=
0event=3D2\000\00000\000DDRC write commands\000 */
+};
+static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {
+{ 1064 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000=
event=3D7\000\00000\000Total read hits\000 */
+};
+static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {
+{ 914 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\0=
0000\000UNC_CBO_HYPHEN\000 */
+{ 979 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\0=
00\00000\000UNC_CBO_TWO_HYPH\000 */
+{ 683 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core =
snoop resulted from L3 Eviction which misses in some processor core\000even=
t=3D0x22,umask=3D0x81\000\00000\000A cross-core snoop resulted from L3 Evic=
tion which misses in some processor core\000 */
+};
+static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {
+{ 1274 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=
=3D0x34\000\00000\000Total cache hits\000 */
+};
+static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {
+{ 1168 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache m=
isses\000event=3D0x12\000\00000\000Total cache misses\000 */
+
+};
+
+const struct pmu_table_entry pmu_events__test_soc_cpu[] =3D {
+{
+     .entries =3D pmu_events__test_soc_cpu_default_core,
+     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_default_core),
+     .pmu_name =3D { 0 /* default_core\000 */ },
+},
+{
+     .entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
+     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
+     .pmu_name =3D { 570 /* hisi_sccl,ddrc\000 */ },
+},
+{
+     .entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
+     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
+     .pmu_name =3D { 1050 /* hisi_sccl,l3c\000 */ },
+},
+{
+     .entries =3D pmu_events__test_soc_cpu_uncore_cbox,
+     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
+     .pmu_name =3D { 671 /* uncore_cbox\000 */ },
+},
+{
+     .entries =3D pmu_events__test_soc_cpu_uncore_imc,
+     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
+     .pmu_name =3D { 1263 /* uncore_imc\000 */ },
+},
+{
+     .entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
+     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_=
running),
+     .pmu_name =3D { 1144 /* uncore_imc_free_running\000 */ },
+},
 };
=20
+static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
+{ 1696 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
+{ 2377 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\=
000\000\000\000\000\000\000\00000 */
+{ 2149 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rq=
sts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
+{ 2243 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l=
2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\0=
00\000\000\000\000\000\00000 */
+{ 2441 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_A=
ll)\000\000\000\000\000\000\000\00000 */
+{ 2509 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2=
_All)\000\000\000\000\000\000\000\00000 */
+{ 1781 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * =
(cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cp=
u_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
+{ 1718 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\0=
00\000\000\000\000\000\000\00000 */
+{ 2643 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duratio=
n_time\000\000\000\000\000\000\000\00000 */
+{ 2579 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
+{ 2601 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
+{ 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
+{ 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_=
cycles\000\000\000\000\000\000\000\00000 */
+{ 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.an=
y\000\000\000\000\000\000\000\00000 */
+{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired=
.any\000\000\000\000\000\000\000\00000 */
+
+};
+
+const struct pmu_table_entry pmu_metrics__test_soc_cpu[] =3D {
+{
+     .entries =3D pmu_metrics__test_soc_cpu_default_core,
+     .num_entries =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu_default_core),
+     .pmu_name =3D { 0 /* default_core\000 */ },
+},
+};
+
+static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {
+{ 1463 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\00=
0config=3D0x2c\0000x01\00000\000\000 */
+};
+static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {
+{ 1556 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache mi=
sses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(434=
|436|43c|43a).*\00000\000\000 */
+};
+static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {
+{ 1371 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\=
000event=3D0x2b\000v8\00000\000\000 */
+
+};
+
+const struct pmu_table_entry pmu_events__test_soc_sys[] =3D {
+{
+     .entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
+     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_p=
mu),
+     .pmu_name =3D { 1444 /* uncore_sys_ccn_pmu\000 */ },
+},
+{
+     .entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
+     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_p=
mu),
+     .pmu_name =3D { 1537 /* uncore_sys_cmn_pmu\000 */ },
+},
+{
+     .entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
+     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_p=
mu),
+     .pmu_name =3D { 1352 /* uncore_sys_ddr_pmu\000 */ },
+},
+};
+
+
 /* Struct used to make the PMU event table implementation opaque to caller=
s. */
 struct pmu_events_table {
-	const struct pmu_event *entries;
+        const struct pmu_table_entry *pmus;
+        uint32_t num_pmus;
 };
=20
 /* Struct used to make the PMU metric table implementation opaque to calle=
rs. */
 struct pmu_metrics_table {
-	const struct pmu_metric *entries;
+        const struct pmu_table_entry *pmus;
+        uint32_t num_pmus;
 };
=20
 /*
@@ -202,92 +199,191 @@ struct pmu_metrics_table {
  * The  cpuid can contain any character other than the comma.
  */
 struct pmu_events_map {
-	const char *arch;
-	const char *cpuid;
-	const struct pmu_events_table event_table;
-	const struct pmu_metrics_table metric_table;
+        const char *arch;
+        const char *cpuid;
+        struct pmu_events_table event_table;
+        struct pmu_metrics_table metric_table;
 };
=20
 /*
  * Global table mapping each known CPU for the architecture to its
  * table of PMU events.
  */
-static const struct pmu_events_map pmu_events_map[] =3D {
-	{
-		.arch =3D "testarch",
-		.cpuid =3D "testcpu",
-		.event_table =3D { pmu_events__test_soc_cpu },
-		.metric_table =3D { pmu_metrics__test_soc_cpu },
-	},
-	{
-		.arch =3D 0,
-		.cpuid =3D 0,
-		.event_table =3D { 0 },
-		.metric_table =3D { 0 },
-	},
-};
-
-static const struct pmu_event pmu_events__test_soc_sys[] =3D {
-	{
-		.name =3D "sys_ddr_pmu.write_cycles",
-		.event =3D "event=3D0x2b",
-		.desc =3D "ddr write-cycles event. Unit: uncore_sys_ddr_pmu ",
-		.compat =3D "v8",
-		.topic =3D "uncore",
-		.pmu =3D "uncore_sys_ddr_pmu",
-	},
-	{
-		.name =3D "sys_ccn_pmu.read_cycles",
-		.event =3D "config=3D0x2c",
-		.desc =3D "ccn read-cycles event. Unit: uncore_sys_ccn_pmu ",
-		.compat =3D "0x01",
-		.topic =3D "uncore",
-		.pmu =3D "uncore_sys_ccn_pmu",
-	},
-	{
-		.name =3D "sys_cmn_pmu.hnf_cache_miss",
-		.event =3D "eventid=3D0x1,type=3D0x5",
-		.desc =3D "Counts total cache misses in first lookup result (high priori=
ty). Unit: uncore_sys_cmn_pmu ",
-		.compat =3D "(434|436|43c|43a).*",
-		.topic =3D "uncore",
-		.pmu =3D "uncore_sys_cmn_pmu",
-	},
-	{
-		.name =3D 0,
-		.event =3D 0,
-		.desc =3D 0,
-	},
+const struct pmu_events_map pmu_events_map[] =3D {
+{
+	.arch =3D "testarch",
+	.cpuid =3D "testcpu",
+	.event_table =3D {
+		.pmus =3D pmu_events__test_soc_cpu,
+		.num_pmus =3D ARRAY_SIZE(pmu_events__test_soc_cpu),
+	},
+	.metric_table =3D {
+		.pmus =3D pmu_metrics__test_soc_cpu,
+		.num_pmus =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu),
+	}
+},
+{
+	.arch =3D 0,
+	.cpuid =3D 0,
+	.event_table =3D { 0, 0 },
+	.metric_table =3D { 0, 0 },
+}
 };
=20
 struct pmu_sys_events {
 	const char *name;
-	const struct pmu_events_table table;
+	struct pmu_events_table event_table;
+	struct pmu_metrics_table metric_table;
 };
=20
 static const struct pmu_sys_events pmu_sys_event_tables[] =3D {
 	{
-		.table =3D { pmu_events__test_soc_sys },
+		.event_table =3D {
+			.pmus =3D pmu_events__test_soc_sys,
+			.num_pmus =3D ARRAY_SIZE(pmu_events__test_soc_sys)
+		},
 		.name =3D "pmu_events__test_soc_sys",
 	},
 	{
-		.table =3D { 0 }
+		.event_table =3D { 0, 0 },
+		.metric_table =3D { 0, 0 },
 	},
 };
=20
-int pmu_events_table__for_each_event(const struct pmu_events_table *table,=
 struct perf_pmu *pmu,
-				     pmu_event_iter_fn fn, void *data)
+static void decompress_event(int offset, struct pmu_event *pe)
+{
+	const char *p =3D &big_c_string[offset];
+
+	pe->name =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pe->topic =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pe->desc =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pe->event =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pe->compat =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pe->deprecated =3D *p - '0';
+	p++;
+	pe->perpkg =3D *p - '0';
+	p++;
+	pe->unit =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pe->long_desc =3D (*p =3D=3D '\0' ? NULL : p);
+}
+
+static void decompress_metric(int offset, struct pmu_metric *pm)
 {
-	for (const struct pmu_event *pe =3D &table->entries[0]; pe->name; pe++) {
-		int ret;
+	const char *p =3D &big_c_string[offset];
+
+	pm->metric_name =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pm->metric_group =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pm->metric_expr =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pm->metric_threshold =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pm->desc =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pm->long_desc =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pm->unit =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pm->compat =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pm->metricgroup_no_group =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pm->default_metricgroup_name =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pm->aggr_mode =3D *p - '0';
+	p++;
+	pm->event_grouping =3D *p - '0';
+}
=20
-                if (pmu && !pmu__name_match(pmu, pe->pmu))
+static int pmu_events_table__for_each_event_pmu(const struct pmu_events_ta=
ble *table,
+                                                const struct pmu_table_ent=
ry *pmu,
+                                                pmu_event_iter_fn fn,
+                                                void *data)
+{
+        int ret;
+        struct pmu_event pe =3D {
+                .pmu =3D &big_c_string[pmu->pmu_name.offset],
+        };
+
+        for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
+                decompress_event(pmu->entries[i].offset, &pe);
+                if (!pe.name)
                         continue;
+                ret =3D fn(&pe, table, data);
+                if (ret)
+                        return ret;
+        }
+        return 0;
+ }
+
+static int pmu_events_table__find_event_pmu(const struct pmu_events_table =
*table,
+                                            const struct pmu_table_entry *=
pmu,
+                                            const char *name,
+                                            pmu_event_iter_fn fn,
+                                            void *data)
+{
+        struct pmu_event pe =3D {
+                .pmu =3D &big_c_string[pmu->pmu_name.offset],
+        };
+        int low =3D 0, high =3D pmu->num_entries - 1;
=20
-		ret =3D fn(pe, table, data);
-		if (ret)
-			return ret;
-	}
-	return 0;
+        while (low <=3D high) {
+                int cmp, mid =3D (low + high) / 2;
+
+                decompress_event(pmu->entries[mid].offset, &pe);
+
+                if (!pe.name && !name)
+                        goto do_call;
+
+                if (!pe.name && name) {
+                        low =3D mid + 1;
+                        continue;
+                }
+                if (pe.name && !name) {
+                        high =3D mid - 1;
+                        continue;
+                }
+
+                cmp =3D strcasecmp(pe.name, name);
+                if (cmp < 0) {
+                        low =3D mid + 1;
+                        continue;
+                }
+                if (cmp > 0) {
+                        high =3D mid - 1;
+                        continue;
+                }
+  do_call:
+                return fn ? fn(&pe, table, data) : 0;
+        }
+        return PMU_EVENTS__NOT_FOUND;
+}
+
+int pmu_events_table__for_each_event(const struct pmu_events_table *table,
+                                    struct perf_pmu *pmu,
+                                    pmu_event_iter_fn fn,
+                                    void *data)
+{
+        for (size_t i =3D 0; i < table->num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
+                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
+                int ret;
+
+                if (pmu && !pmu__name_match(pmu, pmu_name))
+                        continue;
+
+                ret =3D pmu_events_table__for_each_event_pmu(table, table_=
pmu, fn, data);
+                if (pmu || ret)
+                        return ret;
+        }
+        return 0;
 }
=20
 int pmu_events_table__find_event(const struct pmu_events_table *table,
@@ -296,14 +392,19 @@ int pmu_events_table__find_event(const struct pmu_eve=
nts_table *table,
                                  pmu_event_iter_fn fn,
                                  void *data)
 {
-	for (const struct pmu_event *pe =3D &table->entries[0]; pe->name; pe++) {
-                if (pmu && !pmu__name_match(pmu, pe->pmu))
+        for (size_t i =3D 0; i < table->num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
+                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
+                int ret;
+
+                if (!pmu__name_match(pmu, pmu_name))
                         continue;
=20
-		if (!strcasecmp(pe->name, name))
-			return fn(pe, table, data);
-	}
-        return -1000;
+                ret =3D pmu_events_table__find_event_pmu(table, table_pmu,=
 name, fn, data);
+                if (ret !=3D PMU_EVENTS__NOT_FOUND)
+                        return ret;
+        }
+        return PMU_EVENTS__NOT_FOUND;
 }
=20
 size_t pmu_events_table__num_events(const struct pmu_events_table *table,
@@ -311,160 +412,253 @@ size_t pmu_events_table__num_events(const struct pm=
u_events_table *table,
 {
         size_t count =3D 0;
=20
-	for (const struct pmu_event *pe =3D &table->entries[0]; pe->name; pe++) {
-                if (pmu && !pmu__name_match(pmu, pe->pmu))
-                        continue;
+        for (size_t i =3D 0; i < table->num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
+                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
=20
-		count++;
-	}
+                if (pmu__name_match(pmu, pmu_name))
+                        count +=3D table_pmu->num_entries;
+        }
         return count;
 }
=20
-int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *tab=
le, pmu_metric_iter_fn fn,
-				      void *data)
+static int pmu_metrics_table__for_each_metric_pmu(const struct pmu_metrics=
_table *table,
+                                                const struct pmu_table_ent=
ry *pmu,
+                                                pmu_metric_iter_fn fn,
+                                                void *data)
+{
+        int ret;
+        struct pmu_metric pm =3D {
+                .pmu =3D &big_c_string[pmu->pmu_name.offset],
+        };
+
+        for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
+                decompress_metric(pmu->entries[i].offset, &pm);
+                if (!pm.metric_expr)
+                        continue;
+                ret =3D fn(&pm, table, data);
+                if (ret)
+                        return ret;
+        }
+        return 0;
+}
+
+int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *tab=
le,
+                                     pmu_metric_iter_fn fn,
+                                     void *data)
 {
-	for (const struct pmu_metric *pm =3D &table->entries[0]; pm->metric_expr;=
 pm++) {
-		int ret =3D fn(pm, table, data);
+        for (size_t i =3D 0; i < table->num_pmus; i++) {
+                int ret =3D pmu_metrics_table__for_each_metric_pmu(table, =
&table->pmus[i],
+                                                                 fn, data)=
;
+
+                if (ret)
+                        return ret;
+        }
+        return 0;
+}
=20
-		if (ret)
-			return ret;
-	}
-	return 0;
+static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
+{
+        static struct {
+                const struct pmu_events_map *map;
+                struct perf_pmu *pmu;
+        } last_result;
+        static struct {
+                const struct pmu_events_map *map;
+                char *cpuid;
+        } last_map_search;
+        static bool has_last_result, has_last_map_search;
+        const struct pmu_events_map *map =3D NULL;
+        char *cpuid =3D NULL;
+        size_t i;
+
+        if (has_last_result && last_result.pmu =3D=3D pmu)
+                return last_result.map;
+
+        cpuid =3D perf_pmu__getcpuid(pmu);
+
+        /*
+         * On some platforms which uses cpus map, cpuid can be NULL for
+         * PMUs other than CORE PMUs.
+         */
+        if (!cpuid)
+                goto out_update_last_result;
+
+        if (has_last_map_search && !strcmp(last_map_search.cpuid, cpuid)) =
{
+                map =3D last_map_search.map;
+                free(cpuid);
+        } else {
+                i =3D 0;
+                for (;;) {
+                        map =3D &pmu_events_map[i++];
+
+                        if (!map->arch) {
+                                map =3D NULL;
+                                break;
+                        }
+
+                        if (!strcmp_cpuid_str(map->cpuid, cpuid))
+                                break;
+               }
+               free(last_map_search.cpuid);
+               last_map_search.cpuid =3D cpuid;
+               last_map_search.map =3D map;
+               has_last_map_search =3D true;
+        }
+out_update_last_result:
+        last_result.pmu =3D pmu;
+        last_result.map =3D map;
+        has_last_result =3D true;
+        return map;
 }
=20
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu=
 *pmu)
 {
-	const struct pmu_events_table *table =3D NULL;
-	char *cpuid =3D perf_pmu__getcpuid(pmu);
-	int i;
+        const struct pmu_events_map *map =3D map_for_pmu(pmu);
=20
-	/* on some platforms which uses cpus map, cpuid can be NULL for
-	 * PMUs other than CORE PMUs.
-	 */
-	if (!cpuid)
-		return NULL;
+        if (!map)
+                return NULL;
=20
-	i =3D 0;
-	for (;;) {
-		const struct pmu_events_map *map =3D &pmu_events_map[i++];
+        if (!pmu)
+                return &map->event_table;
=20
-		if (!map->cpuid)
-			break;
+        for (size_t i =3D 0; i < map->event_table.num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu =3D &map->event_ta=
ble.pmus[i];
+                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
=20
-		if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
-			table =3D &map->event_table;
-			break;
-		}
-	}
-	free(cpuid);
-	return table;
+                if (pmu__name_match(pmu, pmu_name))
+                         return &map->event_table;
+        }
+        return NULL;
 }
=20
 const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_p=
mu *pmu)
 {
-	const struct pmu_metrics_table *table =3D NULL;
-	char *cpuid =3D perf_pmu__getcpuid(pmu);
-	int i;
+        const struct pmu_events_map *map =3D map_for_pmu(pmu);
=20
-	/* on some platforms which uses cpus map, cpuid can be NULL for
-	 * PMUs other than CORE PMUs.
-	 */
-	if (!cpuid)
-		return NULL;
+        if (!map)
+                return NULL;
=20
-	i =3D 0;
-	for (;;) {
-		const struct pmu_events_map *map =3D &pmu_events_map[i++];
+        if (!pmu)
+                return &map->metric_table;
=20
-		if (!map->cpuid)
-			break;
+        for (size_t i =3D 0; i < map->metric_table.num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu =3D &map->metric_t=
able.pmus[i];
+                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
=20
-		if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
-			table =3D &map->metric_table;
-			break;
-		}
-	}
-	free(cpuid);
-	return table;
+                if (pmu__name_match(pmu, pmu_name))
+                           return &map->metric_table;
+        }
+        return NULL;
 }
=20
 const struct pmu_events_table *find_core_events_table(const char *arch, co=
nst char *cpuid)
 {
-	for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
-	     tables->arch;
-	     tables++) {
-		if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpui=
d))
-			return &tables->event_table;
-	}
-	return NULL;
+        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
+             tables->arch;
+             tables++) {
+                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(table=
s->cpuid, cpuid))
+                        return &tables->event_table;
+        }
+        return NULL;
 }
=20
 const struct pmu_metrics_table *find_core_metrics_table(const char *arch, =
const char *cpuid)
 {
-	for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
-	     tables->arch;
-	     tables++) {
-		if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpui=
d))
-			return &tables->metric_table;
-	}
-	return NULL;
+        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
+             tables->arch;
+             tables++) {
+                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(table=
s->cpuid, cpuid))
+                        return &tables->metric_table;
+        }
+        return NULL;
 }
=20
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
 {
-	for (const struct pmu_events_map *tables =3D &pmu_events_map[0]; tables->=
arch; tables++) {
-		int ret =3D pmu_events_table__for_each_event(&tables->event_table,
-							   /*pmu=3D*/ NULL, fn, data);
-
-		if (ret)
-			return ret;
-	}
-	return 0;
+        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
+             tables->arch;
+             tables++) {
+                int ret =3D pmu_events_table__for_each_event(&tables->even=
t_table,
+                                                           /*pmu=3D*/ NULL=
, fn, data);
+
+                if (ret)
+                        return ret;
+        }
+        return 0;
 }
=20
 int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data)
 {
-	for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
-	     tables->arch;
-	     tables++) {
-		int ret =3D pmu_metrics_table__for_each_metric(&tables->metric_table, fn=
, data);
-
-		if (ret)
-			return ret;
-	}
-	return 0;
+        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
+             tables->arch;
+             tables++) {
+                int ret =3D pmu_metrics_table__for_each_metric(&tables->me=
tric_table, fn, data);
+
+                if (ret)
+                        return ret;
+        }
+        return 0;
 }
=20
 const struct pmu_events_table *find_sys_events_table(const char *name)
 {
-	for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables[0];
-	     tables->name;
-	     tables++) {
-		if (!strcmp(tables->name, name))
-			return &tables->table;
-	}
-	return NULL;
+        for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables=
[0];
+             tables->name;
+             tables++) {
+                if (!strcmp(tables->name, name))
+                        return &tables->event_table;
+        }
+        return NULL;
 }
=20
 int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
 {
-	for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables[0];
-	     tables->name;
-	     tables++) {
-		int ret =3D pmu_events_table__for_each_event(&tables->table, /*pmu=3D*/ =
NULL, fn, data);
-
-		if (ret)
-			return ret;
-	}
-	return 0;
+        for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables=
[0];
+             tables->name;
+             tables++) {
+                int ret =3D pmu_events_table__for_each_event(&tables->even=
t_table,
+                                                           /*pmu=3D*/ NULL=
, fn, data);
+
+                if (ret)
+                        return ret;
+        }
+        return 0;
 }
=20
-int pmu_for_each_sys_metric(pmu_metric_iter_fn fn __maybe_unused, void *da=
ta __maybe_unused)
+int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data)
 {
-	return 0;
+        for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables=
[0];
+             tables->name;
+             tables++) {
+                int ret =3D pmu_metrics_table__for_each_metric(&tables->me=
tric_table, fn, data);
+
+                if (ret)
+                        return ret;
+        }
+        return 0;
 }
=20
-const char *describe_metricgroup(const char *group __maybe_unused)
+static const int metricgroups[][2] =3D {
+
+};
+
+const char *describe_metricgroup(const char *group)
 {
-	return NULL;
+        int low =3D 0, high =3D (int)ARRAY_SIZE(metricgroups) - 1;
+
+        while (low <=3D high) {
+                int mid =3D (low + high) / 2;
+                const char *mgroup =3D &big_c_string[metricgroups[mid][0]]=
;
+                int cmp =3D strcmp(mgroup, group);
+
+                if (cmp =3D=3D 0) {
+                        return &big_c_string[metricgroups[mid][1]];
+                } else if (cmp < 0) {
+                        low =3D mid + 1;
+                } else {
+                        high =3D mid - 1;
+                }
+        }
+        return NULL;
 }
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index 7cc16ff96dc8..32878b02fbcd 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1255,6 +1255,10 @@ such as "arm/cortex-a34".''',
       'output_file', type=3Dargparse.FileType('w', encoding=3D'utf-8'), na=
rgs=3D'?', default=3Dsys.stdout)
   _args =3D ap.parse_args()
=20
+  _args.output_file.write(f"""
+/* SPDX-License-Identifier: GPL-2.0 */
+/* THIS FILE WAS AUTOGENERATED BY jevents.py arch=3D{_args.arch} model=3D{=
_args.model} ! */
+""")
   _args.output_file.write("""
 #include <pmu-events/pmu-events.h>
 #include "util/header.h"
@@ -1280,7 +1284,7 @@ struct pmu_table_entry {
     if item.name =3D=3D _args.arch or _args.arch =3D=3D 'all' or item.name=
 =3D=3D 'test':
       archs.append(item.name)
=20
-  if len(archs) < 2:
+  if len(archs) < 2 and _args.arch !=3D 'none':
     raise IOError(f'Missing architecture directory \'{_args.arch}\'')
=20
   archs.sort()
--=20
2.45.1.288.g0e0cd299f1-goog

