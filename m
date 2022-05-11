Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6A1C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 May 2022 21:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348119AbiEKVQT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 May 2022 17:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348116AbiEKVPr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 May 2022 17:15:47 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BA75F6C
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 14:15:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so28845337b3.12
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 14:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D6em2/y0Ec3M3JoELPusdEp/9enysIaA1frZAYckr0E=;
        b=aIDLDCuhHE8szzALl3o4l1VcmbNHpCJrVV9g5TMIh4zA1eD44EtcAVT4j0t+29zjCB
         yCmL6UjQcrN68Nw/BhBwZqN+Qpk3L4lrYZYpBVVP5nSl/TW5JBV6OOEHc5DKJvx7042g
         p3RqUPbMNUljpY+o+q5HhEJf2yEGYyQlGxVY5fjt2u8rVU+hTlROiQ/IK8fFwNAsN3ZS
         KBExbsQVNevoBmRciu6IMypHDnM/Rbo7GUe0ps85yRhsbE6qY8GPr7AsvP+ZdHSfHR8Z
         koEwd+/DSsMW1CCzUGUov6wacVz+8p4UDbckTkdjLicUEj9Zf/Z+Z11CFW61J1KD2QAA
         TiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D6em2/y0Ec3M3JoELPusdEp/9enysIaA1frZAYckr0E=;
        b=5RrOKnLtUI7J+ztjgxpMdGdebGBauuEMr4ewMUd0ba/6gMDTeduMTT4dGdygAkCfrE
         Qh27LvAcoiQsTB0ZDUfCVbOCH/R420zNSPjJFWTVO4xASImdXAo9G3EWKaZCrO5gplzI
         ZZ43HXPtnT5czq5gmVVJphKvmIj15q4PWJKIHf28Pcuq7FdUoJwZ7bdSndAoH/7dDD4E
         NZwlZcsKIb+krSbOceHnczGyG8+TkWn0/42K0tJq/8JvG3ZRL4T7jrI62YJ7muXGxPtZ
         7ZQXVlMcJVN0Lwfn1s38SF3RRup4KSYM2590jIpKEw6Wlbhg+aoQrdeNWez+rp7h1CbV
         x1ZA==
X-Gm-Message-State: AOAM531Blt7jFOXVrW2COEm9lqdNMfpL6AxlQSKAOpcmzdUjMQDlI8ag
        hOnbTfeMQ1DklIJJceErzhe4X1wbFziW
X-Google-Smtp-Source: ABdhPJwQubfByYKyFe3OrB488XFwH81yKlDdIAz9ec5X0EWpKoovnt6VO0H5+cYx6bUCUAxcUY8ggwHFrzIv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5993:294b:7b62:54cb])
 (user=irogers job=sendgmr) by 2002:a81:b810:0:b0:2fb:2da2:e043 with SMTP id
 v16-20020a81b810000000b002fb2da2e043mr28869289ywe.483.1652303743938; Wed, 11
 May 2022 14:15:43 -0700 (PDT)
Date:   Wed, 11 May 2022 14:15:25 -0700
In-Reply-To: <20220511211526.1021908-1-irogers@google.com>
Message-Id: <20220511211526.1021908-7-irogers@google.com>
Mime-Version: 1.0
References: <20220511211526.1021908-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v2 6/7] perf jevents: Switch build to use jevents.py
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
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Generate pmu-events.c using jevents.py rather than the binary built from
jevents.c. Add a new config variable NO_JEVENTS that is set when there
is no architecture json or an appropriate python interpreter isn't present.
When NO_JEVENTS is defined the file pmu-events/empty-pmu-events.c is copied
and used as the pmu-events.c file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config               | 19 +++++++++++++++++++
 tools/perf/Makefile.perf                 |  1 +
 tools/perf/pmu-events/Build              | 11 +++++++++--
 tools/perf/pmu-events/empty-pmu-events.c | 21 +++++++++++++++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/pmu-events/empty-pmu-events.c

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d9b699ad402c..5a19469f0048 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -854,6 +854,25 @@ else
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
+    # jevents.py uses os.scandir and type hints present in Python 3.5 released in Sept. 2015.
+    JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3 and sys.version_info.minor >= 5) else "0")')
+    ifneq ($(JEVENTS_PYTHON_GOOD), 1)
+      $(warning Python interpreter too old (older than 3.5) disabling jevent generation)
+      NO_JEVENTS := 1
+    endif
+  endif
+endif
 
 ifndef NO_LIBBFD
   ifeq ($(feature-libbfd), 1)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 078f0b06f08a..db416a13dca7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -655,6 +655,7 @@ JEVENTS       := $(OUTPUT)pmu-events/jevents
 JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
 
 PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
+export NO_JEVENTS
 
 export JEVENTS
 
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a055dee6a46a..5e459e1c7a85 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -9,10 +9,17 @@ JSON		=  $(shell [ -d $(JDIR) ] &&				\
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
+	$(Q)cp $< $@
+else
+$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(SRCARCH) pmu-events/arch $@
+endif
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
new file mode 100644
index 000000000000..08fee615e015
--- /dev/null
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An empty pmu-events.c file used when there is no architecture json files in
+ * arch or when the jevents.py script cannot be run.
+ */
+#include "pmu-events/pmu-events.h"
+
+const struct pmu_events_map pmu_events_map[] = {
+	{
+		.cpuid = 0,
+		.version = 0,
+		.type = 0,
+		.table = 0,
+	},
+};
+
+const struct pmu_sys_events pmu_sys_event_tables[] = {
+	{
+		.table = 0
+	},
+};
-- 
2.36.0.512.ge40c2bad7a-goog

