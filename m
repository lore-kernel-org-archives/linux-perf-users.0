Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F15C7EE2F
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 07:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbjEYHNP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 03:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbjEYHM1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 03:12:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C3E5C
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337a578dso398675276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998741; x=1687590741;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQssMmRP2wJKhvVAGwMQRvc8xRuelQIJF/8q4jupSGA=;
        b=TJiixVtMZeC3209DI4a+Wqx30PTkEqVQGLcWxbs3F7IGJl+lLRC446HR6cgLqKXR1S
         OBgBG2Jr6hiM1VFANKz2VttplxhD0MeHEobRtPMPmii8E5p1nUbjYW1TfMauo+SN28z2
         lSI9iTRuICFrH1sYzHFOp7jdw/TUMpS8qPzZhxNgpVSEoF5Yn59/X292xPzEGADihn9b
         4v368nxohDWEtYg6FgH814JHLFeI5At+Q/Kr2/7RkzlM6fmOgEww6L9R10qBz5AXOwjL
         u82znnd74OoTpBjEvnk4ohaQbxyAg0kjvdNlqCiW1pgSLJLj2f1cgVr4PXixn/TPlQd+
         dM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998741; x=1687590741;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQssMmRP2wJKhvVAGwMQRvc8xRuelQIJF/8q4jupSGA=;
        b=EjeefAhzF4g6/0/bVOYbTsHcFnlN7eUvwxGpu7XKtwiuMEpzz3/LTRQDq7Bx5G2hZO
         rxBzYD5t60p5es4n2doLMneh6NPXkyIQuQ3VG4W4CGCi9qrPN7ulIhOKEaDLCS2xG+kH
         jHXuR51yMVBf629rd/it44hGDmcPDzx5t5YrTgvjUTYWLIgMcYOWiDl4F5tI52z4HeS1
         mcWl7BMJXEprPi8gjaCfVyWoFgRmPbBc8pGkSOiXIlg+ax7JlD0k5SxUSlnse3dNTdR1
         Z7Lr7Iu4BQ3ofZarmTywZXfScH8I15NSdcpsCee1mC/YlvWKGj81VvSFom4hHq2L87SX
         WpWw==
X-Gm-Message-State: AC+VfDyrOH0eGnyVIxT5HeEBSmvhR/6m3T4F19m6Ddd/DSXlHnqhXpoM
        FF9wWHe4MWywRLseG0EZ+wMhM6RScQgj
X-Google-Smtp-Source: ACHHUZ6dE51mtGFKTQu7+rwGV8dzbKxQILl/CC4V+X+bxRaBcGI79wTY5Ou0otAXiflY/HPYyXB8AgA9x986
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:2f4a:0:b0:ba8:3600:c3d0 with SMTP id
 v71-20020a252f4a000000b00ba83600c3d0mr1650408ybv.8.1684998740957; Thu, 25 May
 2023 00:12:20 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:27 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-11-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 10/16] perf timechart: Make large arrays dynamic
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
2.40.1.698.g37aff9b760-goog

