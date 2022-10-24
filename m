Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABEAFA3740
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 19:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiJXT7t (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbiJXT6s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 15:58:48 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D7E285117
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:21:22 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id lk10-20020a17090b33ca00b0020da9954852so9228337pjb.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzKQRTEXGqt08SGBdEhLKezf4NlN9FWNmZKirRw+wNE=;
        b=iiTJs0VEY07rTilwdAieFazat3VOy+LVzf466jKCU8DFFU3klelDhVQh411e4Fda+W
         LEuRBdu5LJXJRND4MI9Z5m59FiS19f6TSE25O5r/TPPn58S5GgDVU2YAsHHigzmAWW5K
         S2L4iZahsiLBOs9YUXiczWeQG9G/+qNfojh8Pd/yuqpT87M8udlLSpbpVUSicv0UHszq
         WUC47j2oZTq+UOoaGTGgbZVfAe28njxnsOhstYgGz7teIVnuNOE0Ee/PTTIqj/WNedF0
         sO0lxWfViGHOR2aRo/LnNfYE+7oupjVOGaFuOzh2y2uR4Gco+sfFuu/ErLgbWtfKNyQm
         8Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzKQRTEXGqt08SGBdEhLKezf4NlN9FWNmZKirRw+wNE=;
        b=CzseWoa8ipY5aDZsFFaCM5sTf6faWJ+d2HtBtFBOnOCD9QgYIkdYlTk2hEqrrWQc2j
         MywsajPC5mrCUOnWqQU+NIGxgMavVYMBJRYrCKKohUFyP1QhNIQDZLiVzZ9eMaRnM3NY
         koc1akPohK81NKfovQNKw8k2O0MP1ZdV/VLu4Ez9QFAtlpXf6DvRJF4lKmcSnm2cW1j+
         ijQAH+XK/IpikLfjDCBb2PHvwIqtOJuKfz5eoW0xSwqPsTViydq9DT9XaQVfhtLq8jYu
         L2Pga9+JY5j4CAC+He9DpRDKk1zZNp6XY1Lyn0NYJT0uhYfQ2jTSWmT3QkMfll6XGtaM
         yxsA==
X-Gm-Message-State: ACrzQf3btQBfySj4HxTTeOaPApF+XIsiQr/d+QL6B6j5EWrSjkrVopyY
        bdaWhYF0/Ejexb59SJx8G5GiXXwMxbWU
X-Google-Smtp-Source: AMsMyM4Ejr4u/zJQD1O1ntbW0fysOW1g8lIqixCh7xH5QCVGq9vEZLSvDzrM54rVza3CoTeOfEI7YSgyWHdA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a65:4943:0:b0:46e:f5e3:3e94 with SMTP id
 q3-20020a654943000000b0046ef5e33e94mr7928144pgs.75.1666635634101; Mon, 24 Oct
 2022 11:20:34 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:12 -0700
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
Message-Id: <20221024181913.630986-8-irogers@google.com>
Mime-Version: 1.0
References: <20221024181913.630986-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 7/8] perf top: Use sig_atomic_t to avoid UB
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use sig_atomic_t for variables written/accessed in signal
handlers. This is undefined behavior as per:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4b3ff7687236..bb5bd241246b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -87,8 +87,8 @@
 #include <linux/ctype.h>
 #include <perf/mmap.h>
 
-static volatile int done;
-static volatile int resize;
+static volatile sig_atomic_t done;
+static volatile sig_atomic_t resize;
 
 #define HEADER_LINE_NR  5
 
-- 
2.38.0.135.g90850a2211-goog

