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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FF5C4320A
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166A161156
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhHUJV7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhHUJVZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:21:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFE3C061757;
        Sat, 21 Aug 2021 02:20:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i6so17675105edu.1;
        Sat, 21 Aug 2021 02:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MOotWiEv+98ro2y3QGt/u7+sbNifTqAd54gUTUaSOVY=;
        b=WQwOgvKCgIfHmLnxQIvPieXmBZruWPCXgYrrC/NGtaFxT2VW5+VaGhuugXhZ/YjR+T
         kEarLJfNc3dOEIJM72h9fyK0clcpw/YclDgb7lRUpeGhCSVGfMmA6+PGzGLn+V2+5Lyx
         LKIeAXEqlW9I8//kwEpErGT9AolOUHfs9RYDCkfpIEfzHlbnkTBtvYXkwTwSfy61xfxu
         kbTreXMXdxqHSS32ZpMW8eD8X3rJ/m3/btXID3L147HN0XnMfs8UDRk/45mcr1U75zMc
         wSsfqIHvEW9cyDL38rYV9Khaa6MOD6F7uKeliwPSowNFL5K1Q5/vFiFLVt9iunMgzX9t
         cAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MOotWiEv+98ro2y3QGt/u7+sbNifTqAd54gUTUaSOVY=;
        b=iEk5UVM0BBDvoSYWVYWfRD+eUWupbpT9vZfEIZSg1c6mICdK3+FJepKVzkQY3w/hHg
         vQbuLb6Ud43ZmKCJOcELr/btfiNByuDyALM1stsNkYO1vXMYklskrHZzR3q3xoMFF69e
         zxfHLMftLFRmx6dim6TcPLmgmQ5YJ9THDLT78SRAuYOUHx9e3VvV3GX1LssCEycsiOim
         sK7nONe/BX/XgKDtjMuovaHSPRFCX65h1D/C3KpA3kTt4zlkp6Ny1vy/hv3PjUlh8K8r
         SFlnNDMdnYV8oc9N3B2UjxFFUHBdj6MW0tKlKRiJ1VzyaHr9+xMm0YtNMFqk1IaX7Tv8
         sEHA==
X-Gm-Message-State: AOAM532ejhQbKzpcpRYzTvh8yIkF5IWgZaEZ6wQQEh8DS1wP6DT1j0ak
        cBiEzXFlCPaSOyxZPEwvfKg=
X-Google-Smtp-Source: ABdhPJyW5yl0n572PbavDjuw61RHEFo3Jr1zPq0cWqyh+WG1+bF2jDt5++WL9keCJy/THQJi5sHnVw==
X-Received: by 2002:a05:6402:344f:: with SMTP id l15mr6771949edc.56.1629537613394;
        Sat, 21 Aug 2021 02:20:13 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:13 -0700 (PDT)
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
Subject: [RFC PATCH v1 20/37] perf evsel: separate rlimit increase from evsel__open_cpu
Date:   Sat, 21 Aug 2021 11:19:26 +0200
Message-Id: <2f256de8ec37b9809a5cef73c2fa7bce416af5d3.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is a preparatory patch for the following patches with the goal to
separate from evlist__open_cpu the actual opening (which could be
performed in parallel), from the existing fallback mechanisms, which
should be handled sequentially.

This patch separates the rlimit increase from evsel__open_cpu.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evsel.c | 50 ++++++++++++++++++++++++-----------------
 tools/perf/util/evsel.h |  3 +++
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c393bd992322d925..916930ea31450265 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1931,13 +1931,40 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	}
 }
 
+bool evsel__increase_rlimit(enum rlimit_action *set_rlimit)
+{
+	int old_errno;
+	struct rlimit l;
+
+	if (*set_rlimit < INCREASED_MAX) {
+
+		old_errno = errno;
+		if (getrlimit(RLIMIT_NOFILE, &l) == 0) {
+			if (*set_rlimit == NO_CHANGE)
+				l.rlim_cur = l.rlim_max;
+			else {
+				l.rlim_cur = l.rlim_max + 1000;
+				l.rlim_max = l.rlim_cur;
+			}
+			if (setrlimit(RLIMIT_NOFILE, &l) == 0) {
+				(*set_rlimit) += 1;
+				errno = old_errno;
+				return true;
+			}
+		}
+		errno = old_errno;
+	}
+
+	return false;
+}
+
 static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads,
 		int start_cpu, int end_cpu)
 {
 	int cpu, thread, nthreads;
 	int pid = -1, err, old_errno;
-	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
+	enum rlimit_action set_rlimit = NO_CHANGE;
 
 	err = __evsel__prepare_open(evsel, cpus, threads);
 	if (err)
@@ -2046,25 +2073,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * perf stat needs between 5 and 22 fds per CPU. When we run out
 	 * of them try to increase the limits.
 	 */
-	if (err == -EMFILE && set_rlimit < INCREASED_MAX) {
-		struct rlimit l;
-
-		old_errno = errno;
-		if (getrlimit(RLIMIT_NOFILE, &l) == 0) {
-			if (set_rlimit == NO_CHANGE)
-				l.rlim_cur = l.rlim_max;
-			else {
-				l.rlim_cur = l.rlim_max + 1000;
-				l.rlim_max = l.rlim_cur;
-			}
-			if (setrlimit(RLIMIT_NOFILE, &l) == 0) {
-				set_rlimit++;
-				errno = old_errno;
-				goto retry_open;
-			}
-		}
-		errno = old_errno;
-	}
+	if (err == -EMFILE && evsel__increase_rlimit(&set_rlimit))
+		goto retry_open;
 
 	if (err != -EINVAL || cpu > 0 || thread > 0)
 		goto out_close;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a83fb7f69b1ead73..bf9abd9a5cbf9852 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -290,6 +290,9 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads);
 bool evsel__detect_missing_features(struct evsel *evsel);
 
+enum rlimit_action { NO_CHANGE, SET_TO_MAX, INCREASED_MAX };
+bool evsel__increase_rlimit(enum rlimit_action *set_rlimit);
+
 struct perf_sample;
 
 void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name);
-- 
2.31.1

