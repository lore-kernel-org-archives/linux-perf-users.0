Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEC6C25B06
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Aug 2022 22:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbiHDWSe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 18:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbiHDWSc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Aug 2022 18:18:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7178F6E8B8
        for <linux-perf-users@vger.kernel.org>; Thu,  4 Aug 2022 15:18:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m123-20020a253f81000000b0066ff6484995so571594yba.22
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Aug 2022 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=3zB40Ep346GFOYo22jSNwM76yKmEJRv1RJmbyyWyLHU=;
        b=E6Txk7uEstiYdwC8uzQETuPMRpo8BmaaDqinpQxoLfk0uI9AQjhfYYH3HqoMxCw+3u
         5N+dq3kX1h3my3fjW59H5ATiAPRBr4n7e9YZRCYRV4aK4abjUnTtcbvp6lHt+T5Zvk9D
         tB1+HDnx+9UzYK0okdF15reIkcSlL2XEX1DIT31RgQVVnVToVaeJ48Even3TbWVK7n3q
         BSmv3J9CWXZINfCIVhtZkYsVmILVfLouies1TSdpJbP8XZhO8ZC05tvS/pBJ/OpgOxYD
         7X7qKspHiCGI4NtyrJe2jT8zf9JNdJJAWOZ4+Bn1LjLrDSSOhk4sM7kgQkX2cKXm3THf
         Zaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=3zB40Ep346GFOYo22jSNwM76yKmEJRv1RJmbyyWyLHU=;
        b=tEGo8xBG0lmKIagLBqok/vlhHLpbC6j702a5vVWLMdYzfH/gI7wuP6noCcpkufw+mp
         ASNbOozg0gWJLWgmiAWAHp30bAdo/fR38IP7VE132vnyBsTd2PKJ9/7bz5jFAuSEOS8I
         dXHL0MZvmmwJ0wcEKDgPoKdZDKx18R0a9EoThYlDF+A8UKctcujLE06pyqJWlevhEcNe
         WsN9J3Nd/cNbJillJpGKSwKsCuDzkXyfoWjxUHGyxOuTQqjAEQr3vBsNvw/xHEDIiQex
         lVsg3y0nhdZPYO3Clxc02sxzFgvEM3tVha83SPyHYcG4YIswa4GnbHeDK+g4QNI27MOI
         fz1A==
X-Gm-Message-State: ACgBeo1YCt0IDVsGJHVNHLwNIr5q9X9E+nXupCUnHmaKx+3p6hukVL04
        pVAxBapAign4OvY3tHzd8h+EG/j79lIb
X-Google-Smtp-Source: AA6agR4fb4lCgBnjP7KBoxfNpkhYZA7oNOwumbQtO618B3WSAI3h5KQJV9FhksGoli47MgpbdpMkWxqNVy2J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a81:1014:0:b0:324:6c13:dc01 with SMTP id
 20-20020a811014000000b003246c13dc01mr3500805ywq.115.1659651510685; Thu, 04
 Aug 2022 15:18:30 -0700 (PDT)
Date:   Thu,  4 Aug 2022 15:18:02 -0700
In-Reply-To: <20220804221816.1802790-1-irogers@google.com>
Message-Id: <20220804221816.1802790-4-irogers@google.com>
Mime-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 03/17] perf jevents: Add JEVENTS_ARCH make option
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
2.37.1.559.g78731f0fdb-goog

