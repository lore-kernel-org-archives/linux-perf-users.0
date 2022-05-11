Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F043C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 May 2022 07:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbiEKHB7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 May 2022 03:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242489AbiEKHBx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 May 2022 03:01:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C137A824
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 00:01:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j11-20020a05690212cb00b006454988d225so1091172ybu.10
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 00:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VAtZjV4MJ62CuOSAHGEHWfl01nSGCCkRqsoD+ghc728=;
        b=OnCQy6aa/8F3IasTk+TKYBxKBcBVGA8W8D6b67uA4tnYWKRc9A/P6aNvR2d2fVPTfb
         ia58ba6DjAXxmJpG3FBG1ZfGjQjowinNTBNrsU3cdR+yxfddSVOQZJ7KEDHfdQrB9Anm
         +r7thXz8jTYOiZYiQdBJ7/b6xyzE1QTbTVjDfrDAnSh1p1uyVZFuFR9slpaGwA20FIpH
         Ixf6NFOEbal+tv03tjlin/C6LhZNa0xURGYplTOUF7ZtoVnDz63+Hg6P4GsOyldopsyG
         r5Z9K5jr74OY4nOctQv6cyJWsM0QiQ8tcg545FJhvZ07MC93vZupY1vyhAHN3MaVxyAF
         kG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VAtZjV4MJ62CuOSAHGEHWfl01nSGCCkRqsoD+ghc728=;
        b=63ASDG3CTabIFQ6xzivUSMRN4VR8iaKpQbYAwat3xLcLig/k4kEGPKfpFwg/Nl9VWD
         P+cDbUHdjoDAbk6KBlPbokVYTg3Fz/6DOTQZtdIOpu/v4fF7dyIQ0jTDPMz15lX/V0Pr
         7EAxHWQObUf4zzy4lvfPqoX+De1DngUxWvS/sbU7y+tzqkCnbzzbjwKt7yn555Va89Nj
         YWGJ6x6Lkg2S5DU5QyBQQayUYRCTi3d+p4uNzbIZVvygJNuZ8ia4MB4yhPOD+45j399S
         r5dPLsBzfRfWA0bN0fJzeGOkiYe1fMy4QXsP589dvgTJgDqj164YDPFsZXjgNO0Jn7R4
         z/QA==
X-Gm-Message-State: AOAM533V8RYBdwsnC8v83s0cxcBvD8c/3S0jI71FYA2qzP04DILKwwYD
        RPb4m/GQCVzfOofzzFy0sIY8xCI1ONBX
X-Google-Smtp-Source: ABdhPJyOg3AbQYvg7iWNInX49t2eNCM02tWW+Uxc7y9UQkZcNbLgt4KalKmHIdtZS5kA4AYmawf2WK1fgoMX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b6c9:16a6:f912:39d5])
 (user=irogers job=sendgmr) by 2002:a05:6902:150d:b0:649:3b56:c671 with SMTP
 id q13-20020a056902150d00b006493b56c671mr22326727ybu.163.1652252510705; Wed,
 11 May 2022 00:01:50 -0700 (PDT)
Date:   Wed, 11 May 2022 00:01:32 -0700
In-Reply-To: <20220511070133.710721-1-irogers@google.com>
Message-Id: <20220511070133.710721-7-irogers@google.com>
Mime-Version: 1.0
References: <20220511070133.710721-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 6/7] perf jevents: Switch build to use jevents.py
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
jevents.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a055dee6a46a..ed7eabc64665 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -9,10 +9,11 @@ JSON		=  $(shell [ -d $(JDIR) ] &&				\
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
+$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY)
+	$(Q)$(call echo-cmd,gen)$(JEVENTS_PY) $(SRCARCH) pmu-events/arch $(OUTPUT)pmu-events/pmu-events.c
-- 
2.36.0.512.ge40c2bad7a-goog

