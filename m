Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76266C77B7E
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Apr 2023 07:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345600AbjD1Hkg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 03:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345612AbjD1Hka (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Apr 2023 03:40:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E194EE4
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:39:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7e76b32bso1857064276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667592; x=1685259592;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugIhEtk/VyqflTLZQyLveAtNDuQp0AbC6O0Oizom+5Y=;
        b=bKrI3I0E7mDZGIHzFFL6t1syGwwse2WTtdcLaY9TeF3RypIgA8yDxAyumXeI+73ZDo
         AxXxaWLbnMpZiiX4/Nq75FFu5aEs2IpkwHpLrKDylNueiDOEQmuBD063C/eVnx3DEDkn
         q/7w9a2ai7/2qohZKViLTMHWxD2JddIPdOJeKGtMQq9ZREo2NRbU1k7s5xPGfad7Ttr3
         EO0bJhpUo6QUkKTHVD8+juMI7hDkph+e2qJZ1HGkGkPjLDGEM7E2N4mmG+oeOXeREjny
         YsVSLEiS/FSRLkHYBRbDxED93kvDW+2xvnp8otGWtM3jGEoTBhjJkZ6lv0JmCbR5tENC
         QUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667592; x=1685259592;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugIhEtk/VyqflTLZQyLveAtNDuQp0AbC6O0Oizom+5Y=;
        b=Mk1P9e8dH2sTzkH4SzB6nIKdOc1YePcegz2XPXM1CHSFMXCTWK1oGKBPSP4Gxp4Ai2
         cNwvp7qPKmSYc4z/uS9guWqhaZvBplYMuP5PHpDDBNoKpF/uNLpQElAecRGW3xR0+PxH
         r5x+aPevcjKgU6BGVGWtzwCXKZGBvsB8tccJ37alFpUy783IupNWsbiOUzLFm9eeJWBb
         Ob+McK2n4rR7X91HT4EHrLmJCnZe9xvZVKjufA7oKCVvOIZWwQ7ZZWelRk19L2mlNnkJ
         VYoGT+8nlDTUmd3oClFRRNNr1qCj28rO/BkbjYUfRA5/KUe7Ix8hhSLlIgQ/ubj+920c
         ZllQ==
X-Gm-Message-State: AC+VfDzhimJNOGZefe8bcxTJkFfVdWhgMMZ3ALQ6BYQJOrtyrir6VWMj
        6kvOU1TaBXrgeZB8MM+bfnF8HLQGMjFf
X-Google-Smtp-Source: ACHHUZ5nJkKRWVKFoyNlyVjtP4LLhHoFmkoaY+wjirkA91uZk9JbB2dRl/7KN7qC/2SaQXx+KTghgF4v9FYP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a25:d6c1:0:b0:b96:7fb0:f927 with SMTP id
 n184-20020a25d6c1000000b00b967fb0f927mr2545334ybg.12.1682667592612; Fri, 28
 Apr 2023 00:39:52 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:35 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-10-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 09/43] perf stat: Avoid segv on counter->name
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

Switch to use evsel__name that doesn't return NULL for hardware and
similar events.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index df6337f2480b..7aa7e16fa7c4 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -748,7 +748,7 @@ static void uniquify_event_name(struct evsel *counter)
 	int ret = 0;
 
 	if (counter->uniquified_name || counter->use_config_name ||
-	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
+	    !counter->pmu_name || !strncmp(evsel__name(counter), counter->pmu_name,
 					   strlen(counter->pmu_name)))
 		return;
 
-- 
2.40.1.495.gc816e09b53d-goog

