Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E460C67871
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 19:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiJXT7u (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiJXT6t (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 15:58:49 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18DB284849
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:21:17 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k131-20020a628489000000b0056b3e1a9629so3972831pfd.8
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IO66rWb82Ym5SFWEwsbpBF8A8iB7JwCydGL2I5mbLFY=;
        b=hds5L9pq39xD5mOs2wSydg/fTH9JKNsJ7Rbx4+Zwar0mwCiXd1hUG54QUFgvXIy46C
         0Nuybfzj2CtB9cQ87gNkJHD4MHJc113lhZZBc1ReSEFoxUjqpdWMir9O2DRmqD7ls/MW
         /M7P7UwALSMn681ZAGb7ZMYNuscUeK/5z2yD2R3faeyxN9tYpOCOSvAqSfBITEHXq4aM
         ZDekWbhsSEyGVKC9MlqoG8fW1+//MdAC2v70eHWLCMBgzcrePSjc7sMpNZJTy3eIjYJP
         auJ5eWSlKWzOox1BEvLJHFG/Y3irC2WZBoMDi9LvpgiZ1ZpS38/wuu4xWHW7ZGO8vbV7
         Bo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IO66rWb82Ym5SFWEwsbpBF8A8iB7JwCydGL2I5mbLFY=;
        b=2k70Lxr6fDj5eVK0HbogXj7btFoJkgDFuV9VPRS7sJg8cl3gP5QEf0xnXn6RIX75IH
         Gs/eCFZeebLGWRMyOKx6sWGGLFkbkGloQ2UvuT+h0jJvfFvbBXvAbgV51JPwjninBohf
         5nOir6Xq3C4eCL1iqriPHWBt6HzS4PoNmGKK6nspfAU4Ss8BV6gomdnAP56aJhVojOVE
         fYCMvt0qS/kbktCZ17VpZ4RvHjqA7NO7ggB2DAULsmGn48z6EVavtcK3Hg6UqVKnaji5
         /RbpWBJmBU2UpCDVKi+NSP/t0E9t25T4KMTQCX/cKb3gY5xAMPb5w2Hd3jq2XxtfnI2e
         yw7w==
X-Gm-Message-State: ACrzQf2AtR28s8CD/b2HAvfoBPZHJVAc1RWW/Y52wY9vixUzQom8jLxE
        INDFn1hm4Hb2f350ibY3MStGu8X0qLOH
X-Google-Smtp-Source: AMsMyM7mr42p3I5oH5NEpSHkDYBQ44el74P+LK4ELUYR9780/JS2/SSKzlney3clKu0vyZWDA8Pxbn80JtQY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90a:7a85:b0:20d:2891:15f with SMTP id
 q5-20020a17090a7a8500b0020d2891015fmr40660039pjf.107.1666635626193; Mon, 24
 Oct 2022 11:20:26 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:11 -0700
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
Message-Id: <20221024181913.630986-7-irogers@google.com>
Mime-Version: 1.0
References: <20221024181913.630986-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 6/8] perf stat: Use sig_atomic_t to avoid UB
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
 tools/perf/builtin-stat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 265b05157972..e1a5605adb97 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -173,7 +173,7 @@ static struct target target = {
 
 #define METRIC_ONLY_LEN 20
 
-static volatile pid_t		child_pid			= -1;
+static volatile sig_atomic_t	child_pid			= -1;
 static int			detailed_run			=  0;
 static bool			transaction_run;
 static bool			topdown_run			= false;
@@ -208,7 +208,7 @@ struct perf_stat {
 static struct perf_stat		perf_stat;
 #define STAT_RECORD		perf_stat.record
 
-static volatile int done = 0;
+static volatile sig_atomic_t done = 0;
 
 static struct perf_stat_config stat_config = {
 	.aggr_mode		= AGGR_GLOBAL,
@@ -569,7 +569,7 @@ static void disable_counters(void)
 	}
 }
 
-static volatile int workload_exec_errno;
+static volatile sig_atomic_t workload_exec_errno;
 
 /*
  * evlist__prepare_workload will send a SIGUSR1
@@ -1029,7 +1029,7 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	evlist__print_counters(evsel_list, &stat_config, &target, ts, argc, argv);
 }
 
-static volatile int signr = -1;
+static volatile sig_atomic_t signr = -1;
 
 static void skip_signal(int signo)
 {
-- 
2.38.0.135.g90850a2211-goog

