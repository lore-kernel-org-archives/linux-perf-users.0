Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52D7C43217
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 02:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJDCQg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJDCQe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Oct 2022 22:16:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862553DBFD
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Oct 2022 19:16:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-349423f04dbso127695567b3.13
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Oct 2022 19:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=Qii+hgPKPKNgROLcY0ySesmuzhBUXysFitkb8xtJsts=;
        b=CVG1JMVAPk0ysGQVkFr+p8ZsSG43IQs1odaJHsS41NmEifn8mEBoyp2NENh/4lZhal
         lSRpr2RLbt+koG/YTzIGoaWzp4jHtqDcvehRIrB/dNnKA+a7bWVfpsXf/JkhU2FabjtZ
         +wYDhJ+E01ggYxT73DeYZo+eEPjRF4SULbqdP8ZfgPBhOLcBoom/19AzrUzXU+UD9+z5
         Q/y7duzXhRmWmOYBu7Kk8BnFTWiE9gOfL6M910w/wOiZ0PxxTVrMvAh0hxiud9lodUh7
         WkudOOrwHKYmYCGBpCug5XYs6skuBkoUNWCRVaTIClR/759qeXbfNy94YRRfJ0jwcBVr
         K0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Qii+hgPKPKNgROLcY0ySesmuzhBUXysFitkb8xtJsts=;
        b=yGN6sQc++FnN2ar0bMo9RnBc9KZP9v2Nd/k5MQnW/hEInBkp+OFYMuzEaPXRfdSPyz
         WFZha8ZkLsDABFwXLJvCCYpl2u9Ujnj8TNKl4Tb/w9ZgLLINPxftEyJOEPEKK6r+TNzh
         YH01H6GqaH8Nb0PBrzBT4R6ebD68dk8LH0PeDjT31JpD6X/6HSNeFGoYA1+IMQPvxqoK
         gbdBch15RnNYR8aCKHbLXOY6XrqP1xRVWdQ2ttnSL92P86v5/1M/V177HfiklsMXL4SY
         vj+m4gkoKeBkY2AMP9vDGO2M5Y02WPZVYpfCBMU3t6Lqd/Uum0R8sWlob9E5kZv8nu3P
         sdUw==
X-Gm-Message-State: ACrzQf3wfAMD/YgZLNWkMWD+SVG96r8ynDZMO1lQ59/czxj92yq0DPUx
        j9FH1uEJPE7zRSqoWwJD9cNbL8AhzOsz
X-Google-Smtp-Source: AMsMyM4ocb0WPztz1ctwUeWWVnl3Ii+OXYn6QwPUb+UV6MBdJlEo5Djpx7XJRHKnq6NhDfZzb7JqSB4USi97
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a81:148f:0:b0:357:a69d:bb5f with SMTP id
 137-20020a81148f000000b00357a69dbb5fmr12937678ywu.495.1664849785102; Mon, 03
 Oct 2022 19:16:25 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:15:52 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-4-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 03/23] perf expr: Remove jevents case workaround
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

jevents.py no longer lowercases metrics and altering the case can cause
hashmap lookups to fail, so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index c6827900f8d3..aaacf514dc09 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -182,7 +182,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
 	char *old_key = NULL;
-	char *name, *p;
+	char *name;
 	int ret;
 
 	data_ptr = zalloc(sizeof(*data_ptr));
@@ -195,15 +195,6 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 		return -ENOMEM;
 	}
 
-	/*
-	 * The jevents tool converts all metric expressions
-	 * to lowercase, including metric references, hence
-	 * we need to add lowercase name for metric, so it's
-	 * properly found.
-	 */
-	for (p = name; *p; p++)
-		*p = tolower(*p);
-
 	/*
 	 * Intentionally passing just const char pointers,
 	 * originally from 'struct pmu_event' object.
-- 
2.38.0.rc1.362.ged0d419d3c-goog

