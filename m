Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB314C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 02:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJDCQf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJDCQe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Oct 2022 22:16:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0E63E745
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Oct 2022 19:16:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-358a4ea26a2so60131967b3.16
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Oct 2022 19:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=HP8sEZI7Emeer8Gpo0u0RqVNXzqW3axisWvdt479D+w=;
        b=Ml6u7c4iPGaHKe5dlAcqKCA1eGbQy9o/sYmC4JFc5Qg02T7C56XjCqtT4kZE3VTWp5
         mjVE+m0SOuw7GPHkIkOpMjVLaa1J0VjO3a+9yBLLtwhPF5v00PN8CgDb3sWVxJEUPvy9
         twFjchFCGM2unnAQAQYilIWWnlUbZpYJpUz/F71smURaekVWp1bjmuzl5IrE3UDeSgkH
         7vKHoS0g8ukgq47WHm+V/K8/QmMvIUgMAEymY0zEYLp6vtrktY0mamX9aqZAOTYvSEVn
         KfonLjaFN07joo0ITcCVOpndM26ZU8CheihPcYhUGSL5bn00aN/GNyxKWV2j7/dgZAC8
         W9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=HP8sEZI7Emeer8Gpo0u0RqVNXzqW3axisWvdt479D+w=;
        b=zphx97oZWOw1FjZVmuQOUqikSK/iHKkrhrSR1baS6N/DEmi5Ia5KHgoQbf/M0Wr22R
         pyEQGyIOdbk3EjSROj/zhaaZBL8uBzsY8sH4roSPOmkkKVPh4RTRheMSja//gMo3ZSuH
         gWIuQmH6R7yg/dEN5TRcngPkcEtf6+iAZdPmN8kKirLaYRq/x7QaTGeUfTRp2ecwdMT7
         vjjcbrbNGNiG0+jjdAUOSaGtpySXHsIRKbgYBOAyuhCVQOYAsaw8Oh3KBTTf2iiQsMTY
         I7cSmLah/pQBsV+iU/rEXnRqXnbfM96KwihSEEIldoPZa4oOaBubdp+fAs10xi++VZeG
         jCaQ==
X-Gm-Message-State: ACrzQf0PxgEvStoaOQb+7oOi5SEa06defKSAnakZDOLcsTIubk8cCZtg
        PT3fiULgJrtfKk9YrsdXOIOD1YpT+euy
X-Google-Smtp-Source: AMsMyM7D+Nxaya/Kh39uYN9rJ3+UvaGMx8vYBJ4Z6REA17LIajsE5bi0vIHv1AnyP7Ng0TD5d8fuD9D0+xIT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a25:8a10:0:b0:6ae:af0d:65e5 with SMTP id
 g16-20020a258a10000000b006aeaf0d65e5mr23142640ybl.610.1664849787739; Mon, 03
 Oct 2022 19:16:27 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:15:53 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-5-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 04/23] perf metrics: Don't scale counts going into metrics
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
2.38.0.rc1.362.ged0d419d3c-goog

