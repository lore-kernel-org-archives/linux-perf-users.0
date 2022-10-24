Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721FFECAAA1
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 19:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiJXTDu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiJXTD3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 15:03:29 -0400
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F758B2FE
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:42:49 -0700 (PDT)
Received: by mail-yb1-f202.google.com with SMTP id f126-20020a255184000000b006cb2aebd124so1757328ybb.11
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=anPThKUkfGYO4MityDcRpU1q0+xCNjbPUERJ4hXkoEA=;
        b=PfDVYoSTOvxujmA929mKarnso4WjqFDWW2bmFKktkEtczES8mG4DER2VLr5qv7Autw
         Q8VBpRY/deX1Dz17HaSk+iFAthZQb0VGSP2gad5/7EnWN575WvXu85aE6KNktQpT7e++
         JE6+jyt46d3qWFVVq763Vf48hue5KkqYQzzBw2r6i97cVYGX0Q16Y1gd513g30u7z8fh
         7XzpxBvtkSoBTXiUQMt1ymYvIYi1IrpBX85rr5+n82XhYhPyBHfx7wIxgk9JVXSWLkVT
         NjlWgVTl7f7ad/e2bemq4wNdBELHqDEe3O0B9mmkTKblHddHgxvkgxkGePJDeJCeO9gY
         snHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anPThKUkfGYO4MityDcRpU1q0+xCNjbPUERJ4hXkoEA=;
        b=Ojj2oEXIbBWk9ReE2JoqecPoFDldf5h4IafCS+CyM4TJKAzewZoSnig2u2ZatyJil1
         QZtIVPABj/AnOz4Yj9tRMIyZEZ0nwfZVbiJNclWG6xrZVRjOPLcyOYQWTI/4r75KNR0T
         KOXvNNc6k8DHF/Z2V5fnKVa0WdOvbjQ5NmCrTD6hkSKp21xV5F4Q9KxbV9dfmCxfGGjD
         8A3tu9s1oP7D6pJhS6XciVAOLx6MG7c2MYgy5GGm69sUUCa+lRIfess5akhsiKanzAr0
         HgsD0AlXZcTbL+tZCFnYDo8mxdNyhsN3kGZwVgKLZqSFEbgYoO2VeNyPfXLXMLIQswbT
         hXGA==
X-Gm-Message-State: ACrzQf0ArbOGZCiejC08vakAF6twnJKolUg45ycrLDVeuaX61M2Hl8pl
        RAxWApUtTKfJDlaVvUwc0f6sxyvNeZS+
X-Google-Smtp-Source: AMsMyM7P5d5LajPOjwQlwK82cvCrmTi1X25KVUyW6ylDi76/pIUXd7UlRm5bbfoDg4Upgsp0sliEKaXvVv45
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a81:2513:0:b0:368:3de2:7655 with SMTP id
 l19-20020a812513000000b003683de27655mr22126537ywl.488.1666632974562; Mon, 24
 Oct 2022 10:36:14 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:19 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-5-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 4/8] perf ftrace: Use sig_atomic_t to avoid UB
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
 tools/perf/builtin-ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7de07bb16d23..d7fe00f66b83 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -36,8 +36,8 @@
 
 #define DEFAULT_TRACER  "function_graph"
 
-static volatile int workload_exec_errno;
-static bool done;
+static volatile sig_atomic_t workload_exec_errno;
+static volatile sig_atomic_t done;
 
 static void sig_handler(int sig __maybe_unused)
 {
-- 
2.38.0.135.g90850a2211-goog

