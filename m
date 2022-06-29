Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400C6CCA47C
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Jun 2022 18:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiF2S0H (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiF2S0D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Jun 2022 14:26:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D001E2C659
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 11:26:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31ba792c793so84776317b3.20
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UQ9QP34Vt5zeXtRojuDb+usQC7PCdfID8HAo/KI8Bok=;
        b=epiXTR1fMAAZps2XUbttfzNINx0ZzeoDYLyrGtXIdT7yG5WrJZtxSOdCycY9QyJ+GF
         XcjTaDdN+tG1G9YXkS12U0ZO9BpK8pbb/IC3vEusUMWid6NnbeDLxOxpYSycMsTtYPOu
         vU8effDujjosmeIgwrr5zgX7/lbBrmvPCTIv1yuWbcZZ/6pl2nasWeeJ3NZ1A0/o+Q0q
         nnvSs3IExmPoZ5L8nk1yJ/2zItFYI97T6nYbrL4KwHesgWXINQOvfq0+x10YaigiYl9G
         M/lmQtQRAzZav70aR1GyFHu3ZDyyStbGNdgA7sBTxoRJX1ww/ZXL3GRlcOkJ2R65611V
         upJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UQ9QP34Vt5zeXtRojuDb+usQC7PCdfID8HAo/KI8Bok=;
        b=2WbwYa+qtoIIzM2sKqFqbojYbkAT2E9QnPRDu7VXDj8P+zkUeNAPvyxySHG1P76FBt
         wZq+JOxPd0MM/utFtnVJsceOUPQvs8QG038G6yHIpSBhqvpMwlEfvbEeFSbFYxu3IKNh
         I4eJuwFuWV01Qcz8Jjuji+CkGz0mdeW73pwyT4CmB1hOxMHU3OAH1C9cKD84BMp+8okP
         QCu14BNp7NUwReScVI4RidjeqKYzb5xJRGHYlOYBWLVo6py6AusnW3nemaVLTeZARVHU
         0gLCT/MMbpDG65nAdfy0LNnkY7g3ocDXYGv6JxHXjdZZrjfd/KhKFITucja0CnRYTljQ
         T+QA==
X-Gm-Message-State: AJIora/nUn58oLtqZN96ChMkgTnnecRwwlHkjMelMvtCDEAj//qaovN4
        h1R3kHoHwYM4LwvxLOsNQqrllKJhA3lk
X-Google-Smtp-Source: AGRyM1v5jkr/0u7ZRHtUw8muhNB5Vlyj2lzBCdJvIPPne+3/c4+sg3l5mMQadodRtNhMWqfkoyFg/n7pJD9b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5a1:84fb:df7d:bd89])
 (user=irogers job=sendgmr) by 2002:a25:d916:0:b0:66c:8096:1f12 with SMTP id
 q22-20020a25d916000000b0066c80961f12mr4984449ybg.392.1656527162090; Wed, 29
 Jun 2022 11:26:02 -0700 (PDT)
Date:   Wed, 29 Jun 2022 11:25:04 -0700
In-Reply-To: <20220629182505.406269-1-irogers@google.com>
Message-Id: <20220629182505.406269-4-irogers@google.com>
Mime-Version: 1.0
References: <20220629182505.406269-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v7 3/4] perf jevents: Switch build to use jevents.py
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <rogers.email@gmail.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Ian Rogers <rogers.email@gmail.com>

Generate pmu-events.c using jevents.py rather than the binary built from
jevents.c. Add a new config variable NO_JEVENTS that is set when there
is no architecture json or an appropriate python interpreter isn't present.
When NO_JEVENTS is defined the file pmu-events/empty-pmu-events.c is copied
and used as the pmu-events.c file.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: John Garry <john.garry@huawei.com>
---
 tools/perf/Makefile.config               |  19 +++
 tools/perf/Makefile.perf                 |   1 +
 tools/perf/pmu-events/Build              |  13 +-
 tools/perf/pmu-events/empty-pmu-events.c | 158 +++++++++++++++++++++++
 4 files changed, 189 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/pmu-events/empty-pmu-events.c

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 16c1a87444b8..153c18909ff5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -889,6 +889,25 @@ else
   endif
 endif
 
+ifneq ($(NO_JEVENTS),1)
+  ifeq ($(wildcard pmu-events/arch/$(SRCARCH)/mapfile.csv),)
+    NO_JEVENTS := 1
+  endif
+endif
+ifneq ($(NO_JEVENTS),1)
+  NO_JEVENTS := 0
+  ifndef PYTHON
+    $(warning No python interpreter disabling jevent generation)
+    NO_JEVENTS := 1
+  else
+    # jevents.py uses f-strings present in Python 3.6 released in Dec. 2016.
+    JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3 and sys.version_info.minor >= 6) else "0")' 2> /dev/null)
+    ifneq ($(JEVENTS_PYTHON_GOOD), 1)
+      $(warning Python interpreter too old (older than 3.6) disabling jevent generation)
+      NO_JEVENTS := 1
+    endif
+  endif
+endif
 
 ifndef NO_LIBBFD
   ifeq ($(feature-libbfd), 1)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 1e29c8936f71..dc6b177ac1de 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -655,6 +655,7 @@ JEVENTS       := $(OUTPUT)pmu-events/jevents
 JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
 
 PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
+export NO_JEVENTS
 
 export JEVENTS
 
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a055dee6a46a..5ec5ce8c31ba 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -9,10 +9,19 @@ JSON		=  $(shell [ -d $(JDIR) ] &&				\
 JDIR_TEST	=  pmu-events/arch/test
 JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')
+JEVENTS_PY	=  pmu-events/jevents.py
 
 #
 # Locate/process JSON files in pmu-events/arch/
 # directory and create tables in pmu-events.c.
 #
-$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS)
-	$(Q)$(call echo-cmd,gen)$(JEVENTS) $(SRCARCH) pmu-events/arch $(OUTPUT)pmu-events/pmu-events.c $(V)
+
+ifeq ($(NO_JEVENTS),1)
+$(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)cp $< $@
+else
+$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(SRCARCH) pmu-events/arch $@
+endif
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
new file mode 100644
index 000000000000..77e655c6f116
--- /dev/null
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An empty pmu-events.c file used when there is no architecture json files in
+ * arch or when the jevents.py script cannot be run.
+ *
+ * The test cpu/soc is provided for testing.
+ */
+#include "pmu-events/pmu-events.h"
+
+static const struct pmu_event pme_test_soc_cpu[] = {
+	{
+		.name = "l3_cache_rd",
+		.event = "event=0x40",
+		.desc = "L3 cache access, read",
+		.topic = "cache",
+		.long_desc = "Attributable Level 3 cache access, read",
+	},
+	{
+		.name = "segment_reg_loads.any",
+		.event = "event=0x6,period=200000,umask=0x80",
+		.desc = "Number of segment register loads",
+		.topic = "other",
+	},
+	{
+		.name = "dispatch_blocked.any",
+		.event = "event=0x9,period=200000,umask=0x20",
+		.desc = "Memory cluster signals to block micro-op dispatch for any reason",
+		.topic = "other",
+	},
+	{
+		.name = "eist_trans",
+		.event = "event=0x3a,period=200000,umask=0x0",
+		.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
+		.topic = "other",
+	},
+	{
+		.name = "uncore_hisi_ddrc.flux_wcmd",
+		.event = "event=0x2",
+		.desc = "DDRC write commands. Unit: hisi_sccl,ddrc ",
+		.topic = "uncore",
+		.long_desc = "DDRC write commands",
+		.pmu = "hisi_sccl,ddrc",
+	},
+	{
+		.name = "unc_cbo_xsnp_response.miss_eviction",
+		.event = "event=0x22,umask=0x81",
+		.desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core. Unit: uncore_cbox ",
+		.topic = "uncore",
+		.long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
+		.pmu = "uncore_cbox",
+	},
+	{
+		.name = "event-hyphen",
+		.event = "event=0xe0,umask=0x00",
+		.desc = "UNC_CBO_HYPHEN. Unit: uncore_cbox ",
+		.topic = "uncore",
+		.long_desc = "UNC_CBO_HYPHEN",
+		.pmu = "uncore_cbox",
+	},
+	{
+		.name = "event-two-hyph",
+		.event = "event=0xc0,umask=0x00",
+		.desc = "UNC_CBO_TWO_HYPH. Unit: uncore_cbox ",
+		.topic = "uncore",
+		.long_desc = "UNC_CBO_TWO_HYPH",
+		.pmu = "uncore_cbox",
+	},
+	{
+		.name = "uncore_hisi_l3c.rd_hit_cpipe",
+		.event = "event=0x7",
+		.desc = "Total read hits. Unit: hisi_sccl,l3c ",
+		.topic = "uncore",
+		.long_desc = "Total read hits",
+		.pmu = "hisi_sccl,l3c",
+	},
+	{
+		.name = "uncore_imc_free_running.cache_miss",
+		.event = "event=0x12",
+		.desc = "Total cache misses. Unit: uncore_imc_free_running ",
+		.topic = "uncore",
+		.long_desc = "Total cache misses",
+		.pmu = "uncore_imc_free_running",
+	},
+	{
+		.name = "uncore_imc.cache_hits",
+		.event = "event=0x34",
+		.desc = "Total cache hits. Unit: uncore_imc ",
+		.topic = "uncore",
+		.long_desc = "Total cache hits",
+		.pmu = "uncore_imc",
+	},
+	{
+		.name = "bp_l1_btb_correct",
+		.event = "event=0x8a",
+		.desc = "L1 BTB Correction",
+		.topic = "branch",
+	},
+	{
+		.name = "bp_l2_btb_correct",
+		.event = "event=0x8b",
+		.desc = "L2 BTB Correction",
+		.topic = "branch",
+	},
+	{
+		.name = 0,
+		.event = 0,
+		.desc = 0,
+	},
+};
+
+const struct pmu_events_map pmu_events_map[] = {
+	{
+		.cpuid = "testcpu",
+		.version = "v1",
+		.type = "core",
+		.table = pme_test_soc_cpu,
+	},
+	{
+		.cpuid = 0,
+		.version = 0,
+		.type = 0,
+		.table = 0,
+	},
+};
+
+static const struct pmu_event pme_test_soc_sys[] = {
+	{
+		.name = "sys_ddr_pmu.write_cycles",
+		.event = "event=0x2b",
+		.desc = "ddr write-cycles event. Unit: uncore_sys_ddr_pmu ",
+		.compat = "v8",
+		.topic = "uncore",
+		.pmu = "uncore_sys_ddr_pmu",
+	},
+	{
+		.name = "sys_ccn_pmu.read_cycles",
+		.event = "config=0x2c",
+		.desc = "ccn read-cycles event. Unit: uncore_sys_ccn_pmu ",
+		.compat = "0x01",
+		.topic = "uncore",
+		.pmu = "uncore_sys_ccn_pmu",
+	},
+	{
+		.name = 0,
+		.event = 0,
+		.desc = 0,
+	},
+};
+
+const struct pmu_sys_events pmu_sys_event_tables[] = {
+	{
+		.table = pme_test_soc_sys,
+		.name = "pme_test_soc_sys",
+	},
+	{
+		.table = 0
+	},
+};
-- 
2.37.0.rc0.161.g10f37bed90-goog

