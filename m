Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE930C77B7C
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 20:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjEDUi0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 16:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEDUiL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 16:38:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD16191EE
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 13:31:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f6bef3d4aso1967228276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683232245; x=1685824245;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uf90B0DNuv78Zar9yEbDcO4xMMRYhft3uy0mg3u42Sk=;
        b=sFQLlLIFZAhaYfJD5jfeXBrvNutgr5IEjPwCdAswSQPiVrruOeSGDV6qFW2z0c4nBy
         C/BGxfqhPKdAbJX6M0qamgmr1G7qNBHLW+7QblXe4fUI8cgngnZNmjBWFYg3hkalOW6k
         68fhVksoUZiUmPQbAPDwJs36Wk0TOErD0vr/7R6bn1mF15/r+BcDHehogM1U6KiC+C2a
         ok/Jkqfs15HUpLfNNnVoNxUodiUPtgBRrfmZ7GTw5I/P0v28qHW2RBjbJZ61je355YcT
         ZGRbAT1j6PRfAcsQFP+FbTZDfYOh+MgZQlSPe8dhKTk/Eu6mb2kP0KnrZCcjgnYcJ2eD
         xwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683232245; x=1685824245;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf90B0DNuv78Zar9yEbDcO4xMMRYhft3uy0mg3u42Sk=;
        b=JWy8eb/+gQusO992sPpmKvAvVBHvferWDjmMbW7JasMQ0OjRm5VUGeGKQd7v98iQR8
         0VJc3n0JxilLzRjZ+YQtwlL5h4l6095QfdvTbHyIC40VT/nqeerQBeCzptbkjptjqKPa
         M3o5yeTsuZ6W5O/8qhJh1a8g+HaBdbgfOw9wNuBlygvX08fXJSui8vwlC5ZYqCx/y93/
         RCFUyI7PnmAN3PZGjJ3NFGNjp86vgdKzX94RFsTUbNiieq0WE1eIWXVWWQZVZVdHb4gF
         A59hiS1GFHeRCggrIMJoPtJ+WJ0Wk6mb3Ur6IjIQmyZP9NeAW16kwXtX7Ype46PkRr3S
         y/Uw==
X-Gm-Message-State: AC+VfDzovmKA2lHAmF7v9tn+YoX7YyeE3rx47VbIyRvf3UcCwjCfOXhj
        AEV+x3vzzDNysREgd3tQG/qXXI/V5eHT
X-Google-Smtp-Source: ACHHUZ5D6oBfEWsjyxziFTJx5Gel0+EXHSwY0SgDL1ePNM78CRemBZVMsSyesUUrhKYz5oE4MEut4UEFSWec
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3367:2fed:395f:6f64])
 (user=irogers job=sendgmr) by 2002:a25:52d5:0:b0:b9a:7088:d95 with SMTP id
 g204-20020a2552d5000000b00b9a70880d95mr666862ybb.0.1683230297329; Thu, 04 May
 2023 12:58:17 -0700 (PDT)
Date:   Thu,  4 May 2023 12:58:03 -0700
In-Reply-To: <20230504195803.3331775-1-irogers@google.com>
Message-Id: <20230504195803.3331775-2-irogers@google.com>
Mime-Version: 1.0
References: <20230504195803.3331775-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Subject: [PATCH v1 2/2] perf stat: Document --metric-no-threshold and
 threshold colors
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Document the threshold behavior for -M/--metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-stat.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 29bdcfa93f04..ff71399db738 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -353,6 +353,15 @@ small group that need not have multiplexing is lowered. This option
 forbids the event merging logic from sharing events between groups and
 may be used to increase accuracy in this case.
 
+--metric-no-threshold::
+Metric thresholds may increase the number of events necessary to
+compute whether a metric has exceeded its threshold expression. This
+may not be desirable, for example, as the events can introduce
+multiplexing. This option disables the adding of threshold expression
+events for a metric. However, if there are sufficient events to
+compute the threshold then the threshold is still computed and used to
+color the metric's computed value.
+
 --quiet::
 Don't print output, warnings or messages. This is useful with perf stat
 record below to only write data to the perf.data file.
@@ -389,6 +398,12 @@ For a group all metrics from the group are added.
 The events from the metrics are automatically measured.
 See perf list output for the possible metrics and metricgroups.
 
+	When threshold information is available for a metric, the
+	color red is used to signify a metric has exceeded a threshold
+	while green shows it is hasn't. The default color means that
+	no threshold information was available or the threshold
+	couldn't be computed.
+
 -A::
 --no-aggr::
 Do not aggregate counts across all monitored CPUs.
-- 
2.40.1.521.gf1e218fcd8-goog

