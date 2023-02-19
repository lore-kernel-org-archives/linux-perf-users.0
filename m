Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C045FC05027
	for <linux-perf-users@archiver.kernel.org>; Sun, 19 Feb 2023 09:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBSJoF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Feb 2023 04:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBSJoE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Feb 2023 04:44:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2623CCDFB
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:43:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h204-20020a256cd5000000b00953ffdfbe1aso2275338ybc.23
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBrZSTZ6qIfneIElsj3tLlORrGgvVMiFEvu6xYZfR6w=;
        b=L9hQ5ciPXy/yk7YbGTA3vKiBvQF5mmWbEaTwZbD1xCIQmw5pyL8Ot5PeRaEcmzFgyb
         R2RHR+3J8rqQ+Z4Nmsdh1lP+useHJkLKOQmnzRHA2LJHmXdmBjltVFEL6i5MLOLW+Yg9
         qS0UsrjhG3rybTZddh87kURSAmDeFFI0w2fcKGSDjlDx3uWVgso/1COFLcjJvYbW6o+M
         +Diy/BkS+LGwu1Zt0MdjlHQT7bD1EMY0tbc38xpytZgpCaIzqt1Aip2yIf1mq7qu+kdh
         Co2aW9v1SuDUXVY4ThmRutlyPHc0KgLBet6MFTfDo6yeBAHvJcKeEbRUGL8BK38NcU/n
         u4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBrZSTZ6qIfneIElsj3tLlORrGgvVMiFEvu6xYZfR6w=;
        b=pGOCHRSgp/6In6K+rq2iFxTgegq5lE4k0xj6ycCFoir6K3Sy2VXJeJ7JO2jbtzzqeg
         KBeP6OIfBFrFHwnp1WJdEzzleXzgxGRvqxpeBPOma+MumuZ9d98fa2x2FvvFK3usat3g
         OgaQRQdVlVvHjxZGO+fhEWjaxafEL3l6apP8t7wlg10ob9o8gEb5aYAb+Yce4JGpNgob
         lG++vcD+mV1yr4sY8SPLJygdcoWLEWghQMl4FRmS3NShVpdecWZyz28Ea7YdEFqLTkA1
         3QUh2CoxrGc6pMflY3nvaO7YVPfY6dV2KgsEksQPy3bvpQxqqbZASbMqAHdZmqsNk8NT
         m5BQ==
X-Gm-Message-State: AO0yUKUHDzTNKgmlC8XTcFcZ8jQCqfq072FwrUFpPvCyjmCztqvYMrTj
        BD65jZ83GZ/2gzJQVAQwXjffCdSW8HwQ
X-Google-Smtp-Source: AK7set9coklGXJWklhGCexFRCjrsuoMJPfuJHaspfVdKYhv9BxN7GUWtfp1P0CI8Dnh5lcadLr10dnxpstnQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a5b:bcd:0:b0:8ac:a1b7:6fa3 with SMTP id
 c13-20020a5b0bcd000000b008aca1b76fa3mr1567241ybr.278.1676799233664; Sun, 19
 Feb 2023 01:33:53 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:32 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-36-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 35/51] perf list: Support for printing metric thresholds
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add to json output by default. For regular output, only enable with
the --detail flag.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 13 ++++++++++++-
 tools/perf/util/metricgroup.c  |  3 +++
 tools/perf/util/print-events.h |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 791f513ae5b4..76e1d31a68ee 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -168,6 +168,7 @@ static void default_print_metric(void *ps,
 				const char *desc,
 				const char *long_desc,
 				const char *expr,
+				const char *threshold,
 				const char *unit __maybe_unused)
 {
 	struct print_state *print_state = ps;
@@ -227,6 +228,11 @@ static void default_print_metric(void *ps,
 		wordwrap(expr, 8, pager_get_columns(), 0);
 		printf("]\n");
 	}
+	if (threshold && print_state->detailed) {
+		printf("%*s", 8, "[");
+		wordwrap(threshold, 8, pager_get_columns(), 0);
+		printf("]\n");
+	}
 }
 
 struct json_print_state {
@@ -367,7 +373,7 @@ static void json_print_event(void *ps, const char *pmu_name, const char *topic,
 static void json_print_metric(void *ps __maybe_unused, const char *group,
 			      const char *name, const char *desc,
 			      const char *long_desc, const char *expr,
-			      const char *unit)
+			      const char *threshold, const char *unit)
 {
 	struct json_print_state *print_state = ps;
 	bool need_sep = false;
@@ -388,6 +394,11 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 		fix_escape_printf(&buf, "%s\t\"MetricExpr\": \"%S\"", need_sep ? ",\n" : "", expr);
 		need_sep = true;
 	}
+	if (threshold) {
+		fix_escape_printf(&buf, "%s\t\"MetricThreshold\": \"%S\"", need_sep ? ",\n" : "",
+				  threshold);
+		need_sep = true;
+	}
 	if (unit) {
 		fix_escape_printf(&buf, "%s\t\"ScaleUnit\": \"%S\"", need_sep ? ",\n" : "", unit);
 		need_sep = true;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 868fc9c35606..b1d56a73223d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -368,6 +368,7 @@ struct mep {
 	const char *metric_desc;
 	const char *metric_long_desc;
 	const char *metric_expr;
+	const char *metric_threshold;
 	const char *metric_unit;
 };
 
@@ -447,6 +448,7 @@ static int metricgroup__add_to_mep_groups(const struct pmu_metric *pm,
 			me->metric_desc = pm->desc;
 			me->metric_long_desc = pm->long_desc;
 			me->metric_expr = pm->metric_expr;
+			me->metric_threshold = pm->metric_threshold;
 			me->metric_unit = pm->unit;
 		}
 	}
@@ -522,6 +524,7 @@ void metricgroup__print(const struct print_callbacks *print_cb, void *print_stat
 				me->metric_desc,
 				me->metric_long_desc,
 				me->metric_expr,
+				me->metric_threshold,
 				me->metric_unit);
 		next = rb_next(node);
 		rblist__remove_node(&groups, node);
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 716dcf4b4859..e75a3d7e3fe3 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -23,6 +23,7 @@ struct print_callbacks {
 			const char *desc,
 			const char *long_desc,
 			const char *expr,
+			const char *threshold,
 			const char *unit);
 };
 
-- 
2.39.2.637.g21b0678d19-goog

