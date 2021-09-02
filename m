Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06290C432BE
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 07:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB631610CC
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 07:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhIBHpR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 03:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbhIBHpO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Sep 2021 03:45:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FB6C061575
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Sep 2021 00:44:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j2so657262pll.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Sep 2021 00:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZUk9y2sN7eMTc0e2t5VRlkEt6cGkUIJV1VN0ho5bQg=;
        b=D4F0q5mStXuTWiMTYq8qcr8a/9gvezDDS3wSCmjLLtRmepOErjDgDo0eLs+mjkcSMy
         q/KQD3YWUDEQjJFiRjfi9EXQYrVWfcrmyxTzBoRqncH333sb+hv9UqJnCFoeZcVn8/vd
         nKPfWuhvrwhFVLU2oEoosczR8H+wFPzLp9yEx4WCo5jXeTvP+2NhI5V2/s39yLwr2Ehc
         KF/vZy/m2TKvRs1DrFKk1WzNpf5YNmT822pZTXxjuTPHb43A66JFN4hK+Lch44rEk5Xh
         evP+cAoJ4h9yMZ2hq/CWo+sxZ6+f/dPNuU/kVYpEOkPhI4A0CzlGychNK1XFApu9hlnG
         wSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZUk9y2sN7eMTc0e2t5VRlkEt6cGkUIJV1VN0ho5bQg=;
        b=PwEVQitpsj/MTYCfz+46O6duQ6duaDSYGcMtuVpGK/r9baY+OIgo/DiAw7gU++bBMD
         wVnZBXXmzMIy24OB21ugd3JOWhmpPvjFFTOw7vIMs8d7BfW5NQMb2rt9FkdxbLOA0hSN
         Wp25bRkIJAw43M3an1Q2NKDwFqItPl5Zg1QTl0Axi68AtJfhce58bzSsZNGc6XcdgdxE
         zS+DFiPSsijS9PBZTh5DsgaabOUYjoJ9iybFe38EKRYtjOvW5XOoBUQKxkNKHioCyM6m
         5XUtXckTnU7jINbUyKscsxNSMw5XASM1Tl+NG5Ra6QzOMYfq3Xj/UIY6isjKNddhjDl2
         39pA==
X-Gm-Message-State: AOAM532zAdBvMei2XE5fB35Oo9AbPygq37zf1pFK1HojA85TrjnmMInl
        5OmYq9ScxtSnCfjP07y+17MamMMnony8RCxNR+I=
X-Google-Smtp-Source: ABdhPJyB+2ldaTd3k72K7+4suFtazNybjpsGv1F95SxuSPJCxKnqYzpPL979hOrQLyVQ0PZiHUI4fQ==
X-Received: by 2002:a17:90a:a581:: with SMTP id b1mr2252406pjq.153.1630568656433;
        Thu, 02 Sep 2021 00:44:16 -0700 (PDT)
Received: from localhost ([204.124.181.224])
        by smtp.gmail.com with ESMTPSA id j23sm1275257pjn.12.2021.09.02.00.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 00:44:15 -0700 (PDT)
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
Subject: [PATCH] perf build: Report failure for testing feature libopencsd
Date:   Thu,  2 Sep 2021 15:44:03 +0800
Message-Id: <20210902074403.545225-1-leo.yan@linaro.org>
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
+    dummy := $(error Error: No libopencsd library found or the version is not up-to-date. Please install recent libopencsd to build with COREISGHT=1)
   endif
 endif
 
-- 
2.25.1

