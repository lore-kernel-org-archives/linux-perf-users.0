Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F42ECAAA6
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 16:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbiHZQpF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344718AbiHZQoo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 12:44:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1F5DFB5F
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:43:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-337ed9110c2so33510787b3.15
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=ACInBWBwNvRh9+ZIkz7xZW+D59fAbxI1HNUoQj5EwTw=;
        b=A0ERzChba5qfQmN7t7ZnM+aWwRGaH2/CrJK4ga0h0ake/rNiQ1IkyR3JmXhJrMT9a2
         KnHqRjX6PAnDpWoIkW8DOomTPRLzc1TyRbC3t+/4APWQ++yOkmcb7vZpIh864xKc8YkK
         TXueOMvwyqUW3p/H3jsDEaZeJ+ManaFKIw162zxrEZglv7KFe53adPbLvLotwONtq3m/
         VkC4OmR/ajX51K4DFiENSlLRlXTjnnPJs3yS3cx54uVvE0IWijCmALy9ppEdFbi335dQ
         oYkX423X1tMjhhM+hPZBMshXdSCABfYwEL8duHu/C0YW0phgba8d6AjJngM2mSDJoJtU
         Qqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ACInBWBwNvRh9+ZIkz7xZW+D59fAbxI1HNUoQj5EwTw=;
        b=paB9+UZ6sVjnOxn96huUznYpLF3wHR//27hIOnnj1MXyFkxiFvUWmajIlPWUrpRMpp
         XULIL4os340HYCB1xIDitNeTLCSFhw83RdkbHUJ4WDzVILCOVkD0At510S0JxGaBSryh
         S3oLR6Uh3JCsmc7IMBswzcpF3lOqikY08XieI5OVIS3fTv3iOTt+Gtoum5qhuMzBjG5n
         rgV55cdS59dgx/ZiYzIwD8s3GeGHlY4bz7nflXXyLJTW6V8BoFREWFzopQlU4DF79fk8
         44N5L54u5UBxdSPcwB/gEDskV+iG9jOygf0stvUIqOTYcRhcrmKJ4VN+P5RBqhFMQ6CN
         qWHg==
X-Gm-Message-State: ACgBeo22Y5/UPSo0F78m6/n3XEmybdLJoFczh1Rn1/8GimdePD48r59/
        pOqzpbqAFgZABZ2H3/XtKS0LbHucGkvf
X-Google-Smtp-Source: AA6agR674nFvhyZ8kZZpDZ9P2qEjEXJiLqOtFWE4EU1fMUMemGrNgewnTe7bwqftGS+iFizSaZUFrMd6XEEw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a5b:6c7:0:b0:66e:3713:9929 with SMTP id
 r7-20020a5b06c7000000b0066e37139929mr535950ybq.34.1661532237966; Fri, 26 Aug
 2022 09:43:57 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:30 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-7-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 06/18] perf lock: Remove unused pthread.h include
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

No pthread usage in builtin-lock.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index dd11d3471baf..70197c0593b1 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -28,7 +28,6 @@
 #include <sys/types.h>
 #include <sys/prctl.h>
 #include <semaphore.h>
-#include <pthread.h>
 #include <math.h>
 #include <limits.h>
 
-- 
2.37.2.672.g94769d06f0-goog

