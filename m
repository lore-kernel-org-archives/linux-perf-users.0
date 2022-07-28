Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F4FC04A68
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Jul 2022 22:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiG1W2v (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 18:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiG1W2q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Jul 2022 18:28:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81BB79ED4
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 15:28:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f3-20020a5b0d43000000b00671194e39abso2548980ybr.4
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 15:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n6t/pfc0M41ToUc5HflmTh98LQ2xLoF6/7gvlW5ZK2Q=;
        b=HObRHFStBoemg6GfI4+h5JYgUZukoxtFMi2PAd2Rato78ijb6eCh0S2Rt4+0kbGtOU
         GDQz1AnPxYqghWmBpbEm/Pn7gEf4QlqJIpikzSE67GKHZgxOflw887q1I6b6BOH+PSyf
         obqRKJOdaJf/oK0pmMmZU62j3Cy2KozQJvbEsOlYYO1gXAol1hlyg5ax6+UwD6B/Kupz
         /LR73Zuo1A2HNLhs08nhjoAYbXKKBdTbyJOgbA42u9Z3TjhwR6NNxv3iJgjcXDuvNnvQ
         BkPNAKKNP1FVCVBWo1fjgIoXi4taTzcX8Xsfa1W5JLgC84/CcBN7ZNr5ooilyedMiHMf
         w1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n6t/pfc0M41ToUc5HflmTh98LQ2xLoF6/7gvlW5ZK2Q=;
        b=SzfR69wctgErRh5ruVKVRWyA1j9UI/WT3KRoxuo2yQjEYG/aC0DJAw0oeblViQhqMs
         7eJINUDn4TyLdb8q+QTsl1q+6OTfQ/6yioNNpgkz2dbTBTDq6GgtmaBvb4lN8oP5RIyY
         p5tiVrwFjqXZTe27W92eJqUUe5gGI4ioGw/2ESlfYVGcWafsESlA9q3ZPsjgPiQVqWka
         mjko9Wp2l4Oh9AqGXXj4Kg6QvTfrPCNK/1kRj8RvmGdf8De7TJvqfeH3ewQutOVJbMX+
         3d6GlF3ztN4q8yIOqWlTbe8H4lDJG7r+BjpcbvF3QyQU9SRReoUS7+oryNvrDgAylVcS
         xFxw==
X-Gm-Message-State: ACgBeo1gEK5S0bec89KpEYxGGn9s6HAGabUtxaMcdA7BH5Z1ANzMq7YC
        FJMoMkSqt2V/OX8s8T2HvVFSmFjne2V/
X-Google-Smtp-Source: AA6agR4KMM6ibROk6K6x3Xs/pYrP2iglSVvJhgBg1irTNchS8x1O674NlSSRMFVdz8YX3RikNrKvNLs5A9mj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fd09:96c3:28af:b08f])
 (user=irogers job=sendgmr) by 2002:a25:dc7:0:b0:671:82dc:2ed0 with SMTP id
 190-20020a250dc7000000b0067182dc2ed0mr619835ybn.220.1659047324914; Thu, 28
 Jul 2022 15:28:44 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:28:21 -0700
In-Reply-To: <20220728222835.3254224-1-irogers@google.com>
Message-Id: <20220728222835.3254224-3-irogers@google.com>
Mime-Version: 1.0
References: <20220728222835.3254224-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v2 02/16] perf jevents: Add JEVENTS_ARCH make option
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

