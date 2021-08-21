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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06974C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCA561101
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhHUJVk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhHUJVP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:21:15 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A42CC06124C;
        Sat, 21 Aug 2021 02:20:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ia27so2990907ejc.10;
        Sat, 21 Aug 2021 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJSUm8Y9WnxzFwDFjQxHNxBZXFxJQPdQmlVoLoTFeKI=;
        b=F3uSEingtZ8e2chaZYz9uYo2cTkvJWXNwlgxioO9kGhbAhoJKJhNipWw0o9rWStTzV
         RpZZJE1XvmbaVlHEWfapDpAg24tCNWhNNQJnBhDaBtgndh8XFnTvIwCTM2EWyMewMkPo
         /igCQT7wVgYn0BE1aJWEzqNOEHjQEYtxkz52VbnjiMx5At0Nlf9doLbgFzFmvrbEjoo+
         c+WZtAKgwiM+PUkfu0YwmUgf4zbqmgN7Zrg8xjvUTd1NypFWJsfWVw6k8ZqowqeT11u+
         BidrcuPhZ74fpLlBRtAz2D2jRnABTuckS12vIdwQaoy0T76sy3H//rE3ci3fbGNKNZdd
         Q3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJSUm8Y9WnxzFwDFjQxHNxBZXFxJQPdQmlVoLoTFeKI=;
        b=WhOntWXsy9wEBSoib79oc/2Uyg+9HlTrFzVaXMEEuD35g4SnaAdZ/+CT+hsMmaG+wu
         WgY3ngy6DaBIBmum1tbr6PywvzHwyENYsplg4ccYGonkbxk1W5oh0P6jLDkVaPKpCJJP
         qWBDE46RgteHe2YnuFFsiCw7n+CX2jfEZPm0/sYglJhYl2gcErGRJNIXCrW0Xrz1FDVG
         TI3brDmUVfOZCsbSS/3w4JPqDi9E1756OHwWelUMWyvwB8JA6ix+E8qYOP7U83Aix8T4
         JQburLmPlqFwYVvDV7DdJBYaUn6zSBPdXysqfB8WqOXI310eO/amcCyNXC9btyGG8Xk+
         oN6A==
X-Gm-Message-State: AOAM533iI6IVhrwVqLiD/opclEb/yLJQFjzYrsz9eSgf2hrpPK75SwaH
        Q5zG5G0+Uf+dBCt7+KcCCow=
X-Google-Smtp-Source: ABdhPJwOSjD4YnXLgM3rfVn2z0sRLUryjEgikOKbTOTa/LMfKaA5kNIsoN/FfqFjZuYHxvvjdl7rng==
X-Received: by 2002:a17:906:405:: with SMTP id d5mr25680829eja.189.1629537606974;
        Sat, 21 Aug 2021 02:20:06 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:06 -0700 (PDT)
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
Subject: [RFC PATCH v1 15/37] perf evsel: separate open preparation from open itself
Date:   Sat, 21 Aug 2021 11:19:21 +0200
Message-Id: <e14118b934c338dbbf68b8677f20d0d7dbf9359a.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is a preparatory patch for the following patches with the goal to
separate in evlist__open_cpu the actual perf_event_open, which could be
performed in parallel, from the existing fallback mechanisms, which
should be handled sequentially.

This patch separates the first lines of evsel__open_cpu into a new
__evsel__prepare_open function.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evsel.c | 45 +++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7b4bb3229a16524e..ddf324e2e17a0951 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1746,22 +1746,20 @@ static int perf_event_open(struct evsel *evsel,
 	return fd;
 }
 
-static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
-		struct perf_thread_map *threads,
-		int start_cpu, int end_cpu)
+
+static struct perf_cpu_map *empty_cpu_map;
+static struct perf_thread_map *empty_thread_map;
+
+static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
+		struct perf_thread_map *threads)
 {
-	int cpu, thread, nthreads;
-	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
-	int pid = -1, err, old_errno;
-	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
+	int nthreads;
 
 	if ((perf_missing_features.write_backward && evsel->core.attr.write_backward) ||
 	    (perf_missing_features.aux_output     && evsel->core.attr.aux_output))
 		return -EINVAL;
 
 	if (cpus == NULL) {
-		static struct perf_cpu_map *empty_cpu_map;
-
 		if (empty_cpu_map == NULL) {
 			empty_cpu_map = perf_cpu_map__dummy_new();
 			if (empty_cpu_map == NULL)
@@ -1772,8 +1770,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	}
 
 	if (threads == NULL) {
-		static struct perf_thread_map *empty_thread_map;
-
 		if (empty_thread_map == NULL) {
 			empty_thread_map = thread_map__new_by_tid(-1);
 			if (empty_thread_map == NULL)
@@ -1792,6 +1788,33 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	    perf_evsel__alloc_fd(&evsel->core, cpus->nr, nthreads) < 0)
 		return -ENOMEM;
 
+	return 0;
+}
+
+static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
+		struct perf_thread_map *threads,
+		int start_cpu, int end_cpu)
+{
+	int cpu, thread, nthreads;
+	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
+	int pid = -1, err, old_errno;
+	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
+
+	err = __evsel__prepare_open(evsel, cpus, threads);
+	if (err)
+		return err;
+
+	if (cpus == NULL)
+		cpus = empty_cpu_map;
+
+	if (threads == NULL)
+		threads = empty_thread_map;
+
+	if (evsel->core.system_wide)
+		nthreads = 1;
+	else
+		nthreads = threads->nr;
+
 	if (evsel->cgrp) {
 		flags |= PERF_FLAG_PID_CGROUP;
 		pid = evsel->cgrp->fd;
-- 
2.31.1

