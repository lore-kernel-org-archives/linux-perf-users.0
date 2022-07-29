Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A164C00144
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 07:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiG2HoM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiG2HoL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5989274357
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 00:44:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u6-20020a25b7c6000000b00670862c5b16so3303530ybj.12
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 00:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n6t/pfc0M41ToUc5HflmTh98LQ2xLoF6/7gvlW5ZK2Q=;
        b=RmaMHRM7ZCMs2/Sqd/a9cdMCmqaHieNXVHN4Vuvjr+TsV/F8AClPvTIRagoDGDteWP
         JtTrLV93NxFRO9qxISgnIVfKmNRq7AhrSL9eH75+iyu2fez+WJO0lxUj+jqV/oKCfe3i
         nuyp1wAIJyjwZvdYgpNF0Ol7SaSvyWX3/OmBZc8xGOSfwNMMDJu83rG8aYZjNa9VjNGX
         68nHrV2nLH2zt4bKDZntZlSECtedzjURSUOIwFLvjqkwwAKOEq7Zao1TaGUi05MPmxbF
         xOeW23WnznBfPNyM8bDBJvTUDbitnImpHaGkGAe9c5bPYLuz2XRTTC+A6k5lQej39y3d
         o5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n6t/pfc0M41ToUc5HflmTh98LQ2xLoF6/7gvlW5ZK2Q=;
        b=sIJFTGxmQA7TtbWzPcg29OSDfDBvEGp7GV9HsOUOoh2BeTZXF2DN3cBT0xftlm4xD5
         35hskT1bTMUdIvB1F1g8ZtuZ+cXeAwCUYuMrLQ+mXNf+52xa7zWz7mYGrEBwwyNIcGQH
         76ddxjSWM5LVqsNa04gqoWQ0cjN2zA4l4pa8qMKqNrwaIsQ9VkHLNiU5SzsFZveGSuox
         j/BxbE79hCq1S5zrk+RUDQ0EmYnOZaxkmX2snVMC8ycI9bGt6fB5qn4q/fu09tQXOoS+
         p3uFMWjMBYQ9NsQk4IE+pKObgr9rqZ5v/brHM9zfSWt6fONZ7RFk+wLQtYOjtp8pMst+
         Apqg==
X-Gm-Message-State: ACgBeo0iq3Ty18g1cJMC8tvS8Unf+HOEX1AeAKMuS8/IVXu7sfspIFoZ
        sSnvO7qcxemlrLJMGVSKIQfN58CPCmmW
X-Google-Smtp-Source: AA6agR74CvzVSNoMfgJMhkgoW3tzfGVsYV/loT9yHflje8Np4KrnICz0V3tzbIuEozNJGPQW5nvajE6RSnDh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a25:aa2e:0:b0:674:d1f6:4480 with SMTP id
 s43-20020a25aa2e000000b00674d1f64480mr1535820ybi.591.1659080649673; Fri, 29
 Jul 2022 00:44:09 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:37 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-4-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 03/17] perf jevents: Add JEVENTS_ARCH make option
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Allow the architecture built into pmu-events.c to be set on the make
command line with JEVENTS_ARCH.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 28a9d01b08af..04ef95174660 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -7,6 +7,10 @@ JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')
 JEVENTS_PY	=  pmu-events/jevents.py
 
+ifeq ($(JEVENTS_ARCH),)
+JEVENTS_ARCH=$(SRCARCH)
+endif
+
 #
 # Locate/process JSON files in pmu-events/arch/
 # directory and create tables in pmu-events.c.
@@ -19,5 +23,5 @@ $(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
 else
 $(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(SRCARCH) pmu-events/arch $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) pmu-events/arch $@
 endif
-- 
2.37.1.455.g008518b4e5-goog

