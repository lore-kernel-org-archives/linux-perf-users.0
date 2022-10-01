Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A819CC433FE
	for <linux-perf-users@archiver.kernel.org>; Sat,  1 Oct 2022 06:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJAGG6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 1 Oct 2022 02:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJAGG4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 1 Oct 2022 02:06:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D91130F13
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Sep 2022 23:06:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3521c1a01b5so61331057b3.23
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Sep 2022 23:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=HP8sEZI7Emeer8Gpo0u0RqVNXzqW3axisWvdt479D+w=;
        b=Zo86w1JcZP0SwLmLGNZbnAfu15T7mKvR8zvQGA12p2mpV8zMZlYOthL30w2p7LZ1Ln
         8fxbzYboFouTztwetukz42wpV7hzW0Jg6p/QexYaRBvg95zi1oST81k30zEX7YuSqTyc
         eSilxCudAE8hDEk8MTVLrxT9KKD8x/v8Q+sQH/Yxe3APtq1Nq15RC9cDAgVAbCY7HP2E
         Acj+ZfWTB1EUhhLm497H4xp/53VA/L+jHNCzCzxn/j2ZJj5aIX1IWB6KJvSZXP3KWHci
         YJNuvXrl9vPYaakLHNPYNSkUN+5anpC5qirEs9fLLSaHTyBTFd4T6/2FxhVylR+ZKJuz
         qakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=HP8sEZI7Emeer8Gpo0u0RqVNXzqW3axisWvdt479D+w=;
        b=Z4UrzlVMkDhn/LbAX0X3Qvzyr5eZQ7KBd54H6GzJjryqqYTyE0acvJIKED9zS9e2xO
         jk0xZqbV06ZWMNbOH+KIMUskHH3/i92RfZHDT9Lm53/IZwMx3ndqa2r+NfYdIHQuaPHm
         quK0zWtH98XPHX6I9XXdwRhqXbedpCJ+q4uPsyOW6vtSKUumRkz2OlOuYiVrRRQgjKse
         0PDdUem9jdyjG12WUboZeZ6YntUxsRBGAHFVtCqJ00vVFQYbNhGuGY6p0G4DBdHHULOM
         BGhN/hutR7u4qWWqouIv29RJS1a5c5IoHSxw0jZSuVEUQY1+KB6Ydfiwmi7anKqeh72c
         RrFA==
X-Gm-Message-State: ACrzQf25KRxl7REQqoRiA7NqNeOuU5uh++C1ypws/zT428jG5Y/XpYT0
        W6EnVyimZkb1dMKqN5gwxg8vrL92FykS
X-Google-Smtp-Source: AMsMyM4GM2AzwBt4Mm2uplMShAXDEOgSI9+FipCwaQwrAVwq/yKgi0tGjWFWWd9Q2eklTv7s5Wd8EtSwp+7E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:de60:c6ac:8491:ce1e])
 (user=irogers job=sendgmr) by 2002:a81:498f:0:b0:355:bb57:f988 with SMTP id
 w137-20020a81498f000000b00355bb57f988mr8437612ywa.298.1664604410478; Fri, 30
 Sep 2022 23:06:50 -0700 (PDT)
Date:   Fri, 30 Sep 2022 23:06:17 -0700
In-Reply-To: <20221001060636.2661983-1-irogers@google.com>
Message-Id: <20221001060636.2661983-4-irogers@google.com>
Mime-Version: 1.0
References: <20221001060636.2661983-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v2 03/22] perf metrics: Don't scale counts going into metrics
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

