Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CD0C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 May 2022 18:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354482AbiE0Syj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 27 May 2022 14:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354475AbiE0Syg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 May 2022 14:54:36 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73B34C78F
        for <linux-perf-users@vger.kernel.org>; Fri, 27 May 2022 11:54:35 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mh6-20020a17090b4ac600b001df6cd6813cso5633965pjb.9
        for <linux-perf-users@vger.kernel.org>; Fri, 27 May 2022 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l8LOLSwnlaUETD5O6g2jiBiJ2+xrtDOjgye7LPk4gHE=;
        b=NX6+e5JHEcAkFvpSYP9RO7Ahc6FCZ8nUh2ilLA2ZxEulw0fyNepuYnIIWDqOp4uSCV
         dCB1gm1spSP0LNRhsEi7cAYcB8gxZSsxs7oTiyVAmwDrnycuJBxy/QHgEDtXBWS8fZjp
         spC7yjyZUl+mX0nh65tMOcBziI1y5F6UavU0ZxXy1rbPdt9SP3OSq7ETgeheeXsdEccS
         jZCI7pRQbr6pnB/nyt+DCZHAUJ9aq5neJhqrMN6BOa2eqUFbBzZI7OZw+pS/P/DEtyKt
         N4yftMjpGKXhIpoFS5OToT6/qTHiT1USHxHAIcGkGzbXmtdrQ0a+XAH58FCXsC4R/izS
         EGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l8LOLSwnlaUETD5O6g2jiBiJ2+xrtDOjgye7LPk4gHE=;
        b=ifLHpWMRkTaJgRIIH0tqwnUAgF/iTjFv5vZY6U84Fw7mMJ6sp8f1gWwBfxJW0LCM0z
         PeJAW0+VNznxVjPiAVOlDV9IziyTQwZoYeW8e3w2cHmms3+rwdNVxSAH4zn3AbNO7lSe
         NW+XcJMwkLXV86mW6CHo4pHN8DlC9X2jSGgYLrbi/0Z2Jg3UmP4DyqmJ04aI9mn3nVK+
         sFfXxgKuvWQzE+aZvUhmgTDufSnqFFKVsIFDPxx0LDIRunQ51SRyxZVW0wzK9NoHLHPl
         IiKEgcTPussEBPZj0RlI3EBCZdbN00vJ3vQ0Y4gnbKZ0bmpaIXMkFQ7QD0eb8QmaTRkb
         mPCA==
X-Gm-Message-State: AOAM533F8uV1JgSlV61dQJzU32/Fgy7aZPnI8m7kl1LZC+qvx5r8BxGI
        ay83NHZOvOBFI1CqUG3o3GIpHKYDAgBA
X-Google-Smtp-Source: ABdhPJzf2sUA6tN8PzgRshn/XDYAIt48RaXZM4eKClWUa9+M34ESpUTYJgtaDKlYwm+6wsAKd4S0HZ3h6Hss
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ed8f:39b4:b259:40ef])
 (user=irogers job=sendgmr) by 2002:a05:6a00:a02:b0:4fd:f9dd:5494 with SMTP id
 p2-20020a056a000a0200b004fdf9dd5494mr46130139pfh.68.1653677675107; Fri, 27
 May 2022 11:54:35 -0700 (PDT)
Date:   Fri, 27 May 2022 11:54:25 -0700
In-Reply-To: <20220527185426.240235-1-irogers@google.com>
Message-Id: <20220527185426.240235-3-irogers@google.com>
Mime-Version: 1.0
References: <20220527185426.240235-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3 2/3] perf jevents: Switch build to use jevents.py
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
index 73e0762092fe..9538d737d655 100644
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
+    JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3 and sys.version_info.minor >= 6) else "0")')
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
2.36.1.255.ge46751e96f-goog

