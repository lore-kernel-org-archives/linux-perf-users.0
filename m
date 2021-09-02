Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5BFC432BE
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 08:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F9461059
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 08:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243811AbhIBITT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 04:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243655AbhIBITS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Sep 2021 04:19:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD2EC061757
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Sep 2021 01:18:20 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j16so301164pfc.2
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Sep 2021 01:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wI2EeO/lKrV6ZOTCZm6ZqifjFiAszk20GuR/ni0HaV8=;
        b=BYvawW1FNkTQ4OSXiV70BTle3CN+Z19E5m0SNV4TdEFkQUwUhukUs2Ya/sYgujZxyM
         IHU3OAJ+zWP8HXc4jTpw9jo4x7k+yLF/AAih9wp2ULMpJCIDRKtKA3/XxZdP9uNiDMWe
         BsImcIA8A/2Sgot8xkbgzCFo+rwNSp+8alJtsmrkGP4fH8OWdfmlSKZ4jPSyemFYenwj
         Tdd1z/5Vlrefr/hQG3zQJhMVJli5oS7axfUTZRq+mAGyOh7Lt7d9HJgBAtw6QHu+4/UQ
         1lfmLtmiesQpgjpM9Mwevjdd33w3JxfWNz3rY/fBcApDsRGDH0FT6nPr3EPUpAibQVT8
         f80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wI2EeO/lKrV6ZOTCZm6ZqifjFiAszk20GuR/ni0HaV8=;
        b=fctG1prL6TVE5gWcBXl5JK0Q2QUCtYy6MaxQ8wZUWvywQveiq7iguFh5csO/sGoVXP
         cW5iZrcodJfse00Nzo9Gb4uUGv35VS5vp/WTrI4uaYyRFMaHQKKFuDhUIgxNlkJWH3nv
         yPITO2LrohTD8E9Ryd22lmNAyAwsZIwIHG9y2n3eqATyYfOpzFTV5fervQ5sr/JzIIom
         KK20eG3hU4WgyIcyEGZF6A3yCa55pv9HzA0YB+BVEhserGXbxk3Gxs8ckoqdBrTCsVvP
         9un40lMn/HjMcciv79KuKbF+Gje5eOnwtqs0cECw8NyH5PJVE07JaY1GmJ6JMGBo6As/
         pIqA==
X-Gm-Message-State: AOAM530ni54lGlMV5p+KvZznIq/28yxBzd5D9hIpqrltsZ80IyNAAce6
        //9TC0anzaeyIuZW096OMJWYEQ==
X-Google-Smtp-Source: ABdhPJy9/N+eC1lvVXexIoXNMMzcJWV4EbnbFybPCyhnGO+OC1B5ul/gyqfhodAMgaTbjZY/5G6KSA==
X-Received: by 2002:a63:4384:: with SMTP id q126mr2045158pga.1.1630570699951;
        Thu, 02 Sep 2021 01:18:19 -0700 (PDT)
Received: from localhost ([204.124.181.224])
        by smtp.gmail.com with ESMTPSA id gk8sm1377002pjb.49.2021.09.02.01.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 01:18:19 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2] perf build: Report failure for testing feature libopencsd
Date:   Thu,  2 Sep 2021 16:18:00 +0800
Message-Id: <20210902081800.550016-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When build perf tool with passing option 'CORESIGHT=1' explicitly, if
the feature test fails for library libopencsd, the build doesn't
complain the feature failure and continue to build the tool with
disabling the CoreSight feature insteadly.

This patch changes the building behaviour, when build perf tool with the
option 'CORESIGHT=1' and detect the failure for testing feature
libopencsd, the build process will be aborted and it shows the complaint
info.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---

Changes from v1:
Fixed a typo in the error message.

 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4a0d9a6defc7..5df79538486b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -489,6 +489,8 @@ ifdef CORESIGHT
         CFLAGS += -DCS_RAW_PACKED
       endif
     endif
+  else
+    dummy := $(error Error: No libopencsd library found or the version is not up-to-date. Please install recent libopencsd to build with CORESIGHT=1)
   endif
 endif
 
-- 
2.25.1

