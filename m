Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C03ECAAA1
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 19:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiJXTHC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiJXTG2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 15:06:28 -0400
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38BBC06B5
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:45:37 -0700 (PDT)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-13b88262940so2475120fac.15
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3arsizWDDWH+MKNBhUVuOKkALW8L2napp9/1OYe9kXI=;
        b=OlvnzNTW+kTD3+3BfP32Lyp4zweV38hpVb3JBzX9Kl8cG8rpDJwS1PNWPBbQM81X7f
         XKoN0dP+gbL1BoM6bbsYOUT8B0ZSkP05gici5Rw/4uDCV2QhO5VIArmr/WGmb+lyquko
         MEp9EfBNLkEiRITbcWDMY5AfjBW0VSuakRM0IjX3+ypLC7et5HlFvKeeSZkkUyZ2fgYL
         qjcqke3JcYNj49+1ewf3HmEDkdr068IEqFDOtG5SXPz6C9CH3xahhFqdnIeu4U93HlqJ
         Wie9R7uYy/J60mKIfLJXhEBhu94B3NPzKcjwM8I4REAdx2vKxSEgeXC/g4fvTLoMXRJD
         WwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3arsizWDDWH+MKNBhUVuOKkALW8L2napp9/1OYe9kXI=;
        b=ILyWD73+FA8SdVbnLv1xCxnZ5CyLoJmIudV/AF9NuiqVkBCpES4LHI1EGKSaTFRssb
         2AO4kABqWP4zmscxNwXbXTJpci/aOSHjvD4Q7inYr7pDkYiYf0rU6u2o+xpdHW7fwM/c
         1fPtxNO4tEW2xZd7jr/pIzIdQqZtAWp/OyS0dVtzjwaUECK124eSJiDF4WeR6pRKWWDW
         qtGD0c3zt8H137P4NVKTqMjdQq9M9cy7zOsfJks9WjyHdOmJg+BY5qFmZP6MzfxQZ0kB
         Q6vU/fcpll1NxWuz1knCFzAGYytpNfBNia/NDuLDXp1ToRvk76LKzUVKKwpNtgA3BASe
         pMWw==
X-Gm-Message-State: ACrzQf2+ZXjQ+MwNoH6I+17BqaNPPFwK1mxHrTyTXatBmBkLkBoQCQB3
        q//vQY1p19ckcV2Kz1uoGWw0Kf1ysk88
X-Google-Smtp-Source: AMsMyM52C28bTdexwEVOx/oa6h7vzYixq1KPT8VWRN/t6wx6Lux1MD7mY1A8UAcbolqUTb6K9RrWJ6+cWh3U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90b:38c4:b0:20d:9dfa:4339 with SMTP id
 nn4-20020a17090b38c400b0020d9dfa4339mr72319030pjb.74.1666632966573; Mon, 24
 Oct 2022 10:36:06 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:18 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-4-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 3/8] perf daemon: Use sig_atomic_t to avoid UB
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

Use sig_atomic_t for a variable written to in a signal handler and
read elsewhere. This is undefined behavior as per:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-daemon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 6cb3f6cc36d0..d05084952c09 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <sys/file.h>
 #include <signal.h>
+#include <stdatomic.h>
 #include <stdlib.h>
 #include <time.h>
 #include <stdio.h>
@@ -105,7 +106,7 @@ static const char * const daemon_usage[] = {
 	NULL
 };
 
-static bool done;
+static volatile sig_atomic_t done;
 
 static void sig_handler(int sig __maybe_unused)
 {
-- 
2.38.0.135.g90850a2211-goog

