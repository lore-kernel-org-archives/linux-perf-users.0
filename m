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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AAEC4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01434611EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbhHUJWe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbhHUJV5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:21:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AF6C0611BD;
        Sat, 21 Aug 2021 02:20:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d6so17650276edt.7;
        Sat, 21 Aug 2021 02:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgPEK1IAfRbcf64sxtgFjOq9WczpOQefLSQknOJFNgw=;
        b=I+ilja/9mBtJaapuFwCjDpRGyqV9LZ0j1YOE1XhsqQh+VJfL1czIZpyz6YnvMGhy8F
         K2RKdt7PsrTVsWUe3QcRxSDN813QunrEfkmhL81CliwD3ub0Le2mCxTekPM3eiy56o7I
         3Mj6+5sO5anoZW4e0/swEnKy/ijORJ6nxj5S7zTNUFuD8ZNb0OwR1tqwLCKVftVPzPvf
         PK7/LD+Uwbok9vxdLX6/oAdwHiYruiywNUGrrGrjQvOPRpgvN2UGprYp3xrEqgpA2/St
         xBQqmgVmYIjkuFijUuQoMwDEYCKLkGWUvBTDM08RxDrrjU5NgZ13l5AAW093Ee6aSL6o
         aAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgPEK1IAfRbcf64sxtgFjOq9WczpOQefLSQknOJFNgw=;
        b=WP8dgJ7h38Zui2iSGMtgjjo8PKmBRUM08z1sz2fu0feH7/3ujD5nkToXAYDg1/kkgN
         4HI/G6y5ZQmKGhUtrJiwuiGcPAHUW/1pNhfj/xj2WKPdRbCv5m1KncD+/z2XlW9G5FEy
         LGuD2HsJXOQI2X6vFUXSPwS+Eaa07csh+tXmvOH5I8y+k6FkxpAHiO4LU9tS7VpjSRWo
         RdtzWkqDgof8/ApxYRUsro8eNuDjvAOgwbRKvAxruF6GFX6HVZ4KYP8iPR0YwaqmNw5H
         4BI8OnRVJCCwBDvVSQubfCWuRjWBdbmjpv+cjsgD1EyyM63z2bdkFRSZvIX0z4wM1A7X
         w6Qw==
X-Gm-Message-State: AOAM5300X6a8cLUttNGOwmy72x+vu+bnPa/Ti+NA4p4smB2wwtTOJi8b
        DafHAdWioZJf+R04Qb68XGY=
X-Google-Smtp-Source: ABdhPJwJ5CSBkK8BYON2RfmKUa50QoTJv2mHYsAVtFaW1wn56w+LImZ/DnlAKE6pqWouzfMZZ//fzA==
X-Received: by 2002:a05:6402:1cb9:: with SMTP id cz25mr190285edb.11.1629537618772;
        Sat, 21 Aug 2021 02:20:18 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:18 -0700 (PDT)
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
Subject: [RFC PATCH v1 24/37] perf evsel: handle precise_ip fallback in evsel__open_cpu
Date:   Sat, 21 Aug 2021 11:19:30 +0200
Message-Id: <74208c433d2024a6c4af9c0b140b54ed6b5ea810.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is another patch in the effort to separate the fallback mechanisms
from the open itself.

In case of precise_ip fallback, the original precise_ip will be stored
in the evsel (it was stored in a local variable) and the open will be
retried. Since the precise_ip fallback will be the first in the chain of
fallbacks, there should be no functional change with this patch.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evsel.c | 59 ++++++++++++++++++-----------------------
 tools/perf/util/evsel.h |  2 ++
 2 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3e556afed8dd396c..2e95416b8320c6b9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1709,42 +1709,29 @@ static void display_attr(struct perf_event_attr *attr)
 	}
 }
 
-static int perf_event_open(struct evsel *evsel,
-			   pid_t pid, int cpu, int group_fd)
+bool evsel__precise_ip_fallback(struct evsel *evsel)
 {
-	int precise_ip = evsel->core.attr.precise_ip;
-	int fd;
-
-	while (1) {
-		pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-			  pid, cpu, group_fd, evsel->open_flags);
-
-		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, group_fd, evsel->open_flags);
-		if (fd >= 0)
-			break;
-
-		/* Do not try less precise if not requested. */
-		if (!evsel->precise_max)
-			break;
-
-		/*
-		 * We tried all the precise_ip values, and it's
-		 * still failing, so leave it to standard fallback.
-		 */
-		if (!evsel->core.attr.precise_ip) {
-			evsel->core.attr.precise_ip = precise_ip;
-			break;
-		}
+	/* Do not try less precise if not requested. */
+	if (!evsel->precise_max)
+		return false;
 
-		pr_debug2_peo("\nsys_perf_event_open failed, error %d\n", -ENOTSUP);
-		evsel->core.attr.precise_ip--;
-		pr_debug2_peo("decreasing precise_ip by one (%d)\n", evsel->core.attr.precise_ip);
-		display_attr(&evsel->core.attr);
+	/*
+	 * We tried all the precise_ip values, and it's
+	 * still failing, so leave it to standard fallback.
+	 */
+	if (!evsel->core.attr.precise_ip) {
+		evsel->core.attr.precise_ip = evsel->precise_ip_original;
+		return false;
 	}
 
-	return fd;
-}
+	if (!evsel->precise_ip_original)
+		evsel->precise_ip_original = evsel->core.attr.precise_ip;
 
+	evsel->core.attr.precise_ip--;
+	pr_debug2_peo("decreasing precise_ip by one (%d)\n", evsel->core.attr.precise_ip);
+	display_attr(&evsel->core.attr);
+	return true;
+}
 
 static struct perf_cpu_map *empty_cpu_map;
 static struct perf_thread_map *empty_thread_map;
@@ -2004,8 +1991,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			test_attr__ready();
 
-			fd = perf_event_open(evsel, pid, cpus->map[cpu],
-					     group_fd);
+			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
+				pid, cpus->map[cpu], group_fd, evsel->open_flags);
+
+			fd = sys_perf_event_open(&evsel->core.attr, pid, cpus->map[cpu],
+						group_fd, evsel->open_flags);
 
 			FD(evsel, cpu, thread) = fd;
 
@@ -2058,6 +2048,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return 0;
 
 try_fallback:
+	if (evsel__precise_ip_fallback(evsel))
+		goto retry_open;
+
 	if (evsel__ignore_missing_thread(evsel, cpus->nr, cpu, threads, thread, err)) {
 		/* We just removed 1 thread, so lower the upper nthreads limit. */
 		nthreads--;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 661d2677a19b6248..0a245afab2d87d74 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -150,6 +150,7 @@ struct evsel {
 		struct bperf_follower_bpf *follower_skel;
 	};
 	unsigned long		open_flags;
+	int			precise_ip_original;
 };
 
 struct perf_missing_features {
@@ -297,6 +298,7 @@ bool evsel__ignore_missing_thread(struct evsel *evsel,
 				  int nr_cpus, int cpu,
 				  struct perf_thread_map *threads,
 				  int thread, int err);
+bool evsel__precise_ip_fallback(struct evsel *evsel);
 
 struct perf_sample;
 
-- 
2.31.1

