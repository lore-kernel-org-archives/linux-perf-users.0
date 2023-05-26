Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12BBC7EE2E
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 18:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbjEZSfF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 14:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243226AbjEZSek (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 14:34:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAE9189
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 11:34:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564fb1018bcso26955007b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126073; x=1687718073;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4mau+kNTkjearkZEwOGLqNrVUMBNYPnc3BA4EgUGCw=;
        b=1Px+qIzRsUdsP2fgrQLU4KStunvwa9NLpoiulRIDIQ6fNeD/JSY5sLj6lKfDw2YQNn
         hAhwLk2UDkapjkHomGS2RIYEXpcdCRoJxtVqr190r8nGLv9gtDUCWW7iYnKzge0yfFyX
         dqfcp8cYoT3G55yCvYtOMtGzKWHrSJ2qeh5zia2bexPzDYVSfeCJQxCSuMFyFldWqbq3
         U7VbtyR7Hped8uRJuRelNSl+6JXi9OF/y8m4a+FINFEz1dnA5AfVU9b+mvGgrX8bDEBG
         QMyd5w4V8mfUupr2gWu5ZbTrShoWm3fOVr8QbhHhGuvUQlXvEdoHjLEf9NMkwlP7h5lM
         Kx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126073; x=1687718073;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4mau+kNTkjearkZEwOGLqNrVUMBNYPnc3BA4EgUGCw=;
        b=U85SOsd1MUsGKUDjRs5dZdX3CWSxD2Viz+51XimogksAFzBdYzAZEl3v8ZEH9O9X5b
         XfeR14kujfP2fVB3nGz+yoCgiNv/3V17fs0CcrQ2ncJ93korAqnSVk2E6aFzw5DVHa7b
         e9xe9yLj/CiHNxHGNu3QTKOGT2APXRqh79tL5A6h5LvQD/h8eFF6+4qPLnCpwTffdYN9
         eETI+IGtdjvwZ4BLs9EXTRTEOf6as1l+VBHbYbewwifCTnWAaIWTRcmABa1LQLEnmhsl
         cRzxCMvw1JeLJGH1AZCe2HJVuT4Sw+fv8X+IR8L7CUgRw0fI4KwzzS9pzVsGkdUTuSdU
         9AbQ==
X-Gm-Message-State: AC+VfDwy+Q0D9I5CQlp9q5fWBV3/Bt4xiC7Run7Y1HalYR4pogdjSKNH
        cwkbERJOON3bfxbO4pTWGYZh0ARduW8/
X-Google-Smtp-Source: ACHHUZ4/ooV4uN9q1A338rkeLKvKvQrlTdkMU6a1DjOKnscVR49yyllBcTY0DiYg18FNUOwR0poOCFfbqAqH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:d84a:0:b0:562:837:122f with SMTP id
 n10-20020a81d84a000000b005620837122fmr1614586ywl.9.1685126073356; Fri, 26 May
 2023 11:34:33 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:55 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-11-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 10/16] perf timechart: Make large arrays dynamic
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Allocate start time and state arrays when command starts rather than
using 114,688 bytes in .bss.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 48 +++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index bce1cf896f9c..829d99fecfd0 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -315,10 +315,10 @@ static void pid_put_sample(struct timechart *tchart, int pid, int type,
 
 #define MAX_CPUS 4096
 
-static u64 cpus_cstate_start_times[MAX_CPUS];
-static int cpus_cstate_state[MAX_CPUS];
-static u64 cpus_pstate_start_times[MAX_CPUS];
-static u64 cpus_pstate_state[MAX_CPUS];
+static u64 *cpus_cstate_start_times;
+static int *cpus_cstate_state;
+static u64 *cpus_pstate_start_times;
+static u64 *cpus_pstate_state;
 
 static int process_comm_event(struct perf_tool *tool,
 			      union perf_event *event,
@@ -1981,12 +1981,34 @@ int cmd_timechart(int argc, const char **argv)
 		"perf timechart record [<options>]",
 		NULL
 	};
+	int ret;
+
+	cpus_cstate_start_times = calloc(MAX_CPUS, sizeof(*cpus_cstate_start_times));
+	if (!cpus_cstate_start_times)
+		return -ENOMEM;
+	cpus_cstate_state = calloc(MAX_CPUS, sizeof(*cpus_cstate_state));
+	if (!cpus_cstate_state) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	cpus_pstate_start_times = calloc(MAX_CPUS, sizeof(*cpus_pstate_start_times));
+	if (!cpus_pstate_start_times) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	cpus_pstate_state = calloc(MAX_CPUS, sizeof(*cpus_pstate_state));
+	if (!cpus_pstate_state) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	argc = parse_options_subcommand(argc, argv, timechart_options, timechart_subcommands,
 			timechart_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (tchart.power_only && tchart.tasks_only) {
 		pr_err("-P and -T options cannot be used at the same time.\n");
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
@@ -1996,17 +2018,25 @@ int cmd_timechart(int argc, const char **argv)
 
 		if (tchart.power_only && tchart.tasks_only) {
 			pr_err("-P and -T options cannot be used at the same time.\n");
-			return -1;
+			ret = -1;
+			goto out;
 		}
 
 		if (tchart.io_only)
-			return timechart__io_record(argc, argv);
+			ret = timechart__io_record(argc, argv);
 		else
-			return timechart__record(&tchart, argc, argv);
+			ret = timechart__record(&tchart, argc, argv);
+		goto out;
 	} else if (argc)
 		usage_with_options(timechart_usage, timechart_options);
 
 	setup_pager();
 
-	return __cmd_timechart(&tchart, output_name);
+	ret = __cmd_timechart(&tchart, output_name);
+out:
+	zfree(&cpus_cstate_start_times);
+	zfree(&cpus_cstate_state);
+	zfree(&cpus_pstate_start_times);
+	zfree(&cpus_pstate_state);
+	return ret;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

