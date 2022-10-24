Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CDDC38A2D
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 18:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiJXS5s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiJXS5T (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 14:57:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEA8B7F71
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:37:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36bf9c132f9so43372407b3.8
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEp3gHOpXGArSFAK8kT0WcuQTUqFi2M7wcWMFBGh4Ac=;
        b=GN2Lg7OgUbAWHRuK4qJUwWr9eJwcQ3WTCuHSeezMa1W1zVxcuWl2iwk3n+jcrOHAEm
         aifzMeBo3/bJbLMhOZ65l2+B4Y8z+QQrx8f2wvgIkoYFd73QkNXUmkAb32PLV80i5Rr9
         TQqCmNn2OyWoR+48I1Y07KAJP4GgmKQGsVCQcgyeHJqiugcQf5osSD0zvchkWCcSA2YM
         kDCUDfUorZg8uTr7zN65tuziIfMpEqTtmH5deuJbnEkarcE3cB39VApi/RuRKtrJpfm9
         R9xOPvysoog3mqKdJL9BY7b5s3Ep/Ygk+IGoOmFvYFejdjcPTB37ya+iwD6plChLNX4g
         q84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEp3gHOpXGArSFAK8kT0WcuQTUqFi2M7wcWMFBGh4Ac=;
        b=u4VC0y/4dSJ4NGui5YeTXI1HU1MDAHivnLFZXZaICqH0SFeqSh27K6ZS/B5RJgjFPl
         SQHscYGBv0l4oF4kv/k7GZj0G00ab0azel4J+lVXa2dtlm/425IPYCx6jqkC9vOz0KPj
         lGuPsHBSqPBAcjQzYfiSWZ+CPfWqSoAsp4F8sF8wQM+ht7vTQrTAewWHpWQNFn3/+pow
         JJHng5hvXMwWGwy+bTn8cBnUHUBgKeqwclM08J4A6nD617GnVYEqJ94E5bRNOe4Twrul
         NwtCSZo7ewvf7zEZZ41/O6T3zdFDg7aHrKfNcVGxLBsvv6YNl87gYoWnvu4ST66+cK97
         s/9A==
X-Gm-Message-State: ACrzQf10/dRCVqt/jF8hRxUihtX6G2ewVuvOoCdjpXKMlzV67NBIPoKj
        o40C5Sq2Z+QL94EAywnXaIBbRAiYYRln
X-Google-Smtp-Source: AMsMyM7W/1twXXk2xSwyn1QT/KR8kARo2uyuqG1BSfQS7x1oOxpYAxTDtVWlLoC6G604YFTSmELHqi9t/72g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a0d:eb92:0:b0:36b:bf3:d56 with SMTP id
 u140-20020a0deb92000000b0036b0bf30d56mr11423120ywe.28.1666632990914; Mon, 24
 Oct 2022 10:36:30 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:21 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-7-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 6/8] perf stat: Use sig_atomic_t to avoid UB
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
 tools/perf/builtin-stat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 265b05157972..13bb8508d228 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -83,6 +83,7 @@
 #include <inttypes.h>
 #include <locale.h>
 #include <math.h>
+#include <stdatomic.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
@@ -173,7 +174,7 @@ static struct target target = {
 
 #define METRIC_ONLY_LEN 20
 
-static volatile pid_t		child_pid			= -1;
+static volatile sig_atomic_t	child_pid			= -1;
 static int			detailed_run			=  0;
 static bool			transaction_run;
 static bool			topdown_run			= false;
@@ -208,7 +209,7 @@ struct perf_stat {
 static struct perf_stat		perf_stat;
 #define STAT_RECORD		perf_stat.record
 
-static volatile int done = 0;
+static volatile sig_atomic_t done = 0;
 
 static struct perf_stat_config stat_config = {
 	.aggr_mode		= AGGR_GLOBAL,
@@ -569,7 +570,7 @@ static void disable_counters(void)
 	}
 }
 
-static volatile int workload_exec_errno;
+static volatile sig_atomic_t workload_exec_errno;
 
 /*
  * evlist__prepare_workload will send a SIGUSR1
@@ -1029,7 +1030,7 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	evlist__print_counters(evsel_list, &stat_config, &target, ts, argc, argv);
 }
 
-static volatile int signr = -1;
+static volatile sig_atomic_t signr = -1;
 
 static void skip_signal(int signo)
 {
-- 
2.38.0.135.g90850a2211-goog

