Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC4FC7618E
	for <linux-perf-users@archiver.kernel.org>; Sat, 29 Apr 2023 05:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjD2Fic (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 29 Apr 2023 01:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347334AbjD2FiT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 29 Apr 2023 01:38:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09B04ECA
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 22:37:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559ea6b1065so2065787b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 22:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746665; x=1685338665;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf6Qd+fJp/raw+o0EdprpNNrlfsXq40MPV/2YI8RBqA=;
        b=Xbe1r6m7L5chppeUxtUtY3oVfViIOH8okQf+Pwr6lV9rshLhEV1Iw/1AjnR5O3ud0v
         y1g86fK5wXBJv2zc0b3cGczYoTmorczJP7p2MDWfOinYlWpFpP5eiWmokFiN04f9Q2HL
         H7uRozZ9pDXVLxZX/2zPVPdaEusK+RhFuqHPet0FDKCt/7sBG231fizW5NmvEYOCczO8
         /Ye4J3KdOI/9cMH5gdJTTIh4++b+/QJxw0JAotgnA78cmFRR2yXtU5v+7+na2RSKYEDa
         Y7JBdzRMLTmbTJ418zygZ5Ti7Gk+t+Ko6sy0jI7vCjGVh2EeR690CjOGeiWB176DDzpV
         Rn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746665; x=1685338665;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf6Qd+fJp/raw+o0EdprpNNrlfsXq40MPV/2YI8RBqA=;
        b=NwGQXVJRd6FuFTnwpXcrGLJbpD6AunqShqWF+66eUAAR70b/OpZoSkFVamVIvWCgnD
         KU1ZKzGpJrFfxkFQw1yNeh/yUdncHZgwIJWhe/+qTHwR5kSb/dwZURxGIOhk7JU6SOUq
         N7Vtj7g3Ysz1PEruKnSe1zzjWOlBCXnpCJepnFAdFITW/eNUfKULVYMhxT6K5nw4syfY
         YbA6UHwqwCel0yuMWkqPOjj+5URNhZJ47y8Ys19EchXTgfTMrLrYTk03OGCDJuWMryfE
         /1NVsc4YziI4ovJ+CCB5gTlLNZhNrtyG0TYuTNxgxLnWEjRSMwBjb6h/Edc7r8Xyswjb
         ninQ==
X-Gm-Message-State: AC+VfDwhZhHWJPdmKrJmDl3wjwJP3z07/gV3jmw/okEVMZ+jovpQ315/
        jok/tqtAeOyQb6Iydz4SLoVf0rZkt4O1
X-Google-Smtp-Source: ACHHUZ5OVe+qR1/gmMQaZaUudaLVwFiM0V2XjxlR46DODEVoqqQgrnYk37WUInGkm78gGuaZrHfxLB+h0OF2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a81:ac28:0:b0:559:d9a5:c6bd with SMTP id
 k40-20020a81ac28000000b00559d9a5c6bdmr738971ywh.5.1682746665423; Fri, 28 Apr
 2023 22:37:45 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:38 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-19-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 18/46] perf parse-events: Set pmu_name whenever a pmu is given
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Change add_event to always set pmu_name when possible as not all code
checks both pmu->name and evsel->pmu_name, for example,
uniquify_counter in stat-display.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 707c53f1be09..9cb5f040a74c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -269,6 +269,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
+	evsel->pmu_name = pmu && pmu->name ? strdup(pmu->name) : NULL;
 
 	if (name)
 		evsel->name = strdup(name);
@@ -1500,12 +1501,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 				    /*metric_id=*/NULL, pmu,
 				    /*config_terms=*/NULL, auto_merge_stats,
 				    /*cpu_list=*/NULL);
-		if (evsel) {
-			evsel->pmu_name = name ? strdup(name) : NULL;
-			return 0;
-		} else {
-			return -ENOMEM;
-		}
+		return evsel ? 0 : -ENOMEM;
 	}
 
 	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, head_config, &info))
@@ -1561,7 +1557,6 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (evsel->name)
 		evsel->use_config_name = true;
 
-	evsel->pmu_name = name ? strdup(name) : NULL;
 	evsel->percore = config_term_percore(&evsel->config_terms);
 
 	if (parse_state->fake_pmu)
-- 
2.40.1.495.gc816e09b53d-goog

