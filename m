Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B5AC4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7A461186
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbhHUJWM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhHUJVj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:21:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F08AC0611C1;
        Sat, 21 Aug 2021 02:20:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id n12so17621850edx.8;
        Sat, 21 Aug 2021 02:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kt1ytqrFQ3gxDFuU2/KO3OHIat7YiLJUy+EkQoB0jDg=;
        b=VQUzkOsgyk04CQmPGLMYJKdX92MbEcNeSP7aW98PvA8QFuZP3rFpJykMWn30t1FYky
         byLp9t4MJOgoMxmlBmGRnlNhwoSxVQKPj1GCtHp3f2AjnJIL8vnofjYqngZIbMK/58Sv
         Oot81y+bSDY21kzySyVJcJnXkyYYhDOPGN8V/DHGtwHSidIJyaR/TT1TM/Wx8BK+ekAk
         R+XTlxe0JkL0yEt0HpGTS7zDALlMbNOOSA6BbhkJy5Mc1NmifjjJnpXTra9nZHiEve8e
         6HeGnAE3cYjvb0bjoxsrriN4j01pOB9v+thg5srLjvPNsx43oh8MmpF9MxI4fOQcpPMH
         haXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kt1ytqrFQ3gxDFuU2/KO3OHIat7YiLJUy+EkQoB0jDg=;
        b=AEf5K1eTVFPWSiAD9jHR4w+NxCIll+Vztf/ZrR80Uzikbt+1k+OJI2UUQ5KgHlbMMJ
         2phSrXTl+VjBC/dbwBAFN1A2x58pRoZBAAIqjmg6E8AA33HEgXiGOWx3+tvC5thsb1xo
         mCDg9/ayDR0AcouMOrFQ13xg6TVLh/L8qEWDHG2UCAQdhgNh4sfI/9mD3qzJDG2b249U
         KHyYeAer1hAruY3kTTR7PY/LNDm+FlTyyi6gBHf9YqVCTtAB03wOeo04PwQIx24pWCz8
         15oxhf+AYOAAuGL4qWH3RYT2+F6Mil3drur7JNSfM4aVaDHfxiqa46SMnynxlCE6kb0l
         fJ+Q==
X-Gm-Message-State: AOAM533Da09PY4DEe/zxMakau4OgOiaB9E76fAsOR87vkbhixMXPwV84
        6HOjzfY1KpdFroLlvZYiT5U=
X-Google-Smtp-Source: ABdhPJzlgSjmm/lF0FgQ7+bskzwpSSZrrLGycbNOtdp017Sig4/W+nBL5b4RWVJoxp2k9By5mmSPKg==
X-Received: by 2002:aa7:c0c6:: with SMTP id j6mr15646714edp.146.1629537614656;
        Sat, 21 Aug 2021 02:20:14 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:14 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 21/37] perf evsel: move ignore_missing_thread to fallback code
Date:   Sat, 21 Aug 2021 11:19:27 +0200
Message-Id: <4eca51443c786baaf6811b7cd8e73aafd97f7606.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch moves ignore_missing_thread outside the perf_event_open loop.
Doing so, we need to move the retry_open flag a few places higher, with
minimal impact. Furthermore, thread need not be decreased since it won't
get increased by the for loop (since we're jumping back inside), but we
need to check that the nthreads decrease didn't put thread out of range.

The goal is to have fallbacks handled in one place only, since in the
future parallel code, these would be handled separately.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evsel.c | 29 +++++++++++++----------------
 tools/perf/util/evsel.h |  5 +++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 916930ea31450265..a1a88607fd59efcb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1656,7 +1656,7 @@ static int update_fds(struct evsel *evsel,
 	return 0;
 }
 
-static bool ignore_missing_thread(struct evsel *evsel,
+bool evsel__ignore_missing_thread(struct evsel *evsel,
 				  int nr_cpus, int cpu,
 				  struct perf_thread_map *threads,
 				  int thread, int err)
@@ -1993,12 +1993,15 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 		for (thread = 0; thread < nthreads; thread++) {
 			int fd, group_fd;
+retry_open:
+			if (thread >= nthreads)
+				break;
 
 			if (!evsel->cgrp && !evsel->core.system_wide)
 				pid = perf_thread_map__pid(threads, thread);
 
 			group_fd = get_group_fd(evsel, cpu, thread);
-retry_open:
+
 			test_attr__ready();
 
 			fd = perf_event_open(evsel, pid, cpus->map[cpu],
@@ -2016,20 +2019,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			if (fd < 0) {
 				err = -errno;
 
-				if (ignore_missing_thread(evsel, cpus->nr, cpu, threads, thread, err)) {
-					/*
-					 * We just removed 1 thread, so take a step
-					 * back on thread index and lower the upper
-					 * nthreads limit.
-					 */
-					nthreads--;
-					thread--;
-
-					/* ... and pretend like nothing have happened. */
-					err = 0;
-					continue;
-				}
-
 				pr_debug2_peo("\nsys_perf_event_open failed, error %d\n",
 					  err);
 				goto try_fallback;
@@ -2069,6 +2058,14 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return 0;
 
 try_fallback:
+	if (evsel__ignore_missing_thread(evsel, cpus->nr, cpu, threads, thread, err)) {
+		/* We just removed 1 thread, so lower the upper nthreads limit. */
+		nthreads--;
+
+		/* ... and pretend like nothing have happened. */
+		err = 0;
+		goto retry_open;
+	}
 	/*
 	 * perf stat needs between 5 and 22 fds per CPU. When we run out
 	 * of them try to increase the limits.
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index bf9abd9a5cbf9852..661d2677a19b6248 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -293,6 +293,11 @@ bool evsel__detect_missing_features(struct evsel *evsel);
 enum rlimit_action { NO_CHANGE, SET_TO_MAX, INCREASED_MAX };
 bool evsel__increase_rlimit(enum rlimit_action *set_rlimit);
 
+bool evsel__ignore_missing_thread(struct evsel *evsel,
+				  int nr_cpus, int cpu,
+				  struct perf_thread_map *threads,
+				  int thread, int err);
+
 struct perf_sample;
 
 void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name);
-- 
2.31.1

