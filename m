Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF69C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347477AbhLWHsh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347132AbhLWHr6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EA1C0619D9
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s189-20020a252cc6000000b005c1f206d91eso8637779ybs.14
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wM2F9YGkn6QITwu+SCK05wcndw1aQWuNO5bNevKaVrE=;
        b=I3VaHfG8SUE4Gt75X2npP4PVqrzNQI8mhPK/WMyNaMczZyFE4lEeZ1v5XP+qfE++LX
         UNrc3/Mao4f1U4CzploAaO/UNGOnxyLLE25GfvGxFm+SXdA6+HdNfDce+6AG4KhR4D50
         komQGpOo+IEhp+A7dk7STB67/rqJeWdHbjITILfjkQqWbHhf04fjo17PdPuwH1868JX0
         yPnH9v14Qqd6LXNbWGQrpn+gCOOfEJMy3Kk/IGfMM5KmZrRKL3nCL/JCQ1XgydSk/u2g
         ebZ5srkMSUF23E/szNLp3gdOeXkOEhmfFH8Jn41O8yGmp/hFy0snw57T1Kw1313pFInK
         uORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wM2F9YGkn6QITwu+SCK05wcndw1aQWuNO5bNevKaVrE=;
        b=nXasB0tbgrLKcNif5/aoRDuifdXGQMI3to+z8UoxdYxI6zBq/i3g28XAk69eyH/dKl
         2L1TsG199G4pYoVeAdRQ/j15iv1A7TfLEJD2CIV2S8/06aYC0uczzac+V2WjPEsoyMXQ
         PQLMzrKl9qJq1/YFck5TZasmXZ1EJgLqbf2ooT3ugkG/dAjOGtMAdCFt/MztUWWy/czT
         dmFU00SAHVM0rK4CWhWDazpIyDTvFmEC4OrmWabv5Q/97i86irYjFyblipHcmbJi8P2q
         b+4Cfb9N27SLMiYA73ZXdMXE5+qLZpK+NJYE52gBSW6VZDs17uLA3FJe1MvwwzgKGtiY
         a6+Q==
X-Gm-Message-State: AOAM532ecQZjaI0RY0qxiILRtiwQyeuI7n3pphH9Fc5CYOC7zOM7KYif
        s3OiaJSXeV0WS/98os99+0lig6PaOqOq
X-Google-Smtp-Source: ABdhPJy5p01OjIn0FII81SwAXYoRLRKDnND7XSXM7c5skduqLeZtLt2qI1Kg2O0zZxHK/3gbVHDbQLfJvgjP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:4d8:: with SMTP id 207mr1592266ybe.320.1640245664700;
 Wed, 22 Dec 2021 23:47:44 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:31 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-39-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 38/48] perf evsel: Reduce scope of evsel__ignore_missing_thread
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Move to being static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 8 ++++----
 tools/perf/util/evsel.h | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4b3ba4408af2..8911ebde54d6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1666,10 +1666,10 @@ static int update_fds(struct evsel *evsel,
 	return 0;
 }
 
-bool evsel__ignore_missing_thread(struct evsel *evsel,
-				  int nr_cpus, int cpu,
-				  struct perf_thread_map *threads,
-				  int thread, int err)
+static bool evsel__ignore_missing_thread(struct evsel *evsel,
+					 int nr_cpus, int cpu,
+					 struct perf_thread_map *threads,
+					 int thread, int err)
 {
 	pid_t ignore_pid = perf_thread_map__pid(threads, thread);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index c3db41282400..84e597f6c395 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -301,10 +301,6 @@ bool evsel__detect_missing_features(struct evsel *evsel);
 enum rlimit_action { NO_CHANGE, SET_TO_MAX, INCREASED_MAX };
 bool evsel__increase_rlimit(enum rlimit_action *set_rlimit);
 
-bool evsel__ignore_missing_thread(struct evsel *evsel,
-				  int nr_cpus, int cpu,
-				  struct perf_thread_map *threads,
-				  int thread, int err);
 bool evsel__precise_ip_fallback(struct evsel *evsel);
 
 struct perf_sample;
-- 
2.34.1.307.g9b7440fafd-goog

