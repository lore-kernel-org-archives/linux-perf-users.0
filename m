Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993A5C32771
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Sep 2022 07:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiI1HWb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Sep 2022 03:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiI1HWV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Sep 2022 03:22:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EA7D62F9
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 00:22:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-34577a9799dso112888017b3.6
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 00:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=kyButVpLUDmoK22yP9Tz8dG8x/bX/1WzYYTdRXgfVks=;
        b=nt1st7/BkdP2mNLSR4upYTuJ97yt67jFbSIOqYDJCdQIfZkRMkj42vbVuM2lEk3eOV
         TldUDa3mUUkrx95oVYqol3UT+anm30n2JWqpiOEL9p4E4+H1lp52gP9TR+siwfgahKJn
         bW60c1SwSTMUo2g/xzvfJwGtWk0nksXDdv0ILn9MhouPErw02VAflEspQP/kmYFBv6yS
         VfnNZH67UnGkJ8ncrbUAfQDgQCBgWl60Xn83K5sIRLyoqLGuIXdHT5GYSA0AyTFWAL9w
         /EmhQ/yWzwu6mz/OduP8SDFmR806RkQ+RY8lNEBl/+QavXvsmUkq4f5Y/9Tq6q9wmNYS
         HAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=kyButVpLUDmoK22yP9Tz8dG8x/bX/1WzYYTdRXgfVks=;
        b=NrOQjx+XraSv0wEiQeGx832U1imxMOsmvw4DZlWvZ5lLGBBT3y0+7wDgM9uagYhC6l
         299ECMVytmQCOIqjsNkUyBKAlpwy0VtwAi80qsWX5ns23USvgz2XR+x/zg4hNihHOgrr
         S4MABQ6VjFhsHWITqfJRsaZEiEMk9+pJhqOImdLMWVRHpLDvrsmbLz/ii26Hg1ZRcQEz
         BeT2njehNhOe8JfR/6DuL2UKAC5bTC94NJqvZ/MxLc/2s0h9rd532JUNjNyGVnxonch+
         dHSZeEl7NG6C+tJRNFv2mme/blHO6fZiFlWCfvgib+OOQTEdfa2l4YgBiMQQN2VOUX8m
         JGtg==
X-Gm-Message-State: ACrzQf0DzgtdY1TG0TmalMI+zrf3eMDJv5D5TY+1w82mNR9l0Q4bOuqv
        p1nW7z8DIYtjzVi2jgJoFpgVVtMSky4i
X-Google-Smtp-Source: AMsMyM6Kxupad9S1uMBq0IatbSrlKAE295hYThk2/2sn6a5M4JIcNaREH8vvz65Mun59fckETCG0KgATwBD1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7099:1ccb:612a:5ad6])
 (user=irogers job=sendgmr) by 2002:a25:9804:0:b0:6a8:e064:ef9a with SMTP id
 a4-20020a259804000000b006a8e064ef9amr27993713ybo.62.1664349736769; Wed, 28
 Sep 2022 00:22:16 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:21:45 -0700
In-Reply-To: <20220928072204.1613330-1-irogers@google.com>
Message-Id: <20220928072204.1613330-4-irogers@google.com>
Mime-Version: 1.0
References: <20220928072204.1613330-1-irogers@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Subject: [PATCH v1 03/22] perf metrics: Don't scale counts going into metrics
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

Counts are scaled prior to going into saved_value, reverse the scaling
so that metrics don't double scale values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 9e1eddeff21b..b5cedd37588f 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -865,11 +865,16 @@ static int prepare_metric(struct evsel **metric_events,
 			if (!v)
 				break;
 			stats = &v->stats;
-			scale = 1.0;
+			/*
+			 * If an event was scaled during stat gathering, reverse
+			 * the scale before computing the metric.
+			 */
+			scale = 1.0 / metric_events[i]->scale;
+
 			source_count = evsel__source_count(metric_events[i]);
 
 			if (v->metric_other)
-				metric_total = v->metric_total;
+				metric_total = v->metric_total * scale;
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
 		if (!n)
-- 
2.37.3.998.g577e59143f-goog

