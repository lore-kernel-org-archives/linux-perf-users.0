Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F71AC77B75
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 22:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjEBW6T (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 18:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjEBW6R (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 18:58:17 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7150C3A94
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 15:57:45 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d75a77b69052e-3ef34e947edso52187061cf.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683068217; x=1685660217;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=udIESTQJWghJ0eXfw1zjkQa1ohgrnaNqFMimydoVXZk=;
        b=G0dhbvQ1uB1RX08e7VjYzC9RsxDJrJWfrLGinH2BNarAqZX3gaqAdYVDj7mYAcfxhM
         zA3HQezTeTX122VVSacuzSMfLXEbi+EduLc/af9G1wq16yhYTKLlfLYPIhZY3gTfCa1R
         i2OC9bB5sq0SreJfcIIACzHmoTI0pNOsQOrxFBJhWAH/C/iljzpPoIe81EngPiOtYunL
         ZlmoV5V8nbmBvhQ8dIxHZXb79oBmjpWXaXW3SV+r34FTNdksQIfqXuAWG+XAT6Pnvjwv
         bHQlBLuBkk7ABCDZJNAk9umF5U19yn6Zok1FgXiKvJ04DTdBOJ/+muCyVA0mS+/5jpG2
         ogOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683068217; x=1685660217;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udIESTQJWghJ0eXfw1zjkQa1ohgrnaNqFMimydoVXZk=;
        b=LC/VPANmrnzW3yUZ/KBhlWJsnBNNnjtnzpUYuYJ/QfHFw7Lapm+oNnwng3m4U2q2A1
         E2IX5wMQw/NuQJZN/U2hbCoYLOAOepiq5K67xYm+PUHPBcnntSpMqDMcMbZ7iAmdZg7z
         XVT304Y0TQBAEKsOo7zZbduERwQAKkI99jKUYAFjWuVCXkK9Y4mGb8fgnc7UHiA4/x4H
         TTUgwNlZCnjefW9SPBUZN4pdeeGR7UPusyG+ZFYHTpyHn5YN8ABbHtZKzqsZjyF7e0DI
         CNkSY/HthngjzetvFRj+sOdMCoEhr60UYFq2XkkFr3YA+e1UBp6qDJYwsITCSK7e3SMh
         M2fA==
X-Gm-Message-State: AC+VfDxRziRBS0cWWYsvpNR5b/uvDzaCaFAQH8b4QLineBvcW9qoVNaE
        I2prCs0vkV/WRjJBFrrPsNmsMx6H8Fs0
X-Google-Smtp-Source: ACHHUZ5zFcnSGoYy10fGDH40vDdIwUQ+uQ6vQnbd4Izu2cHsmeAi8zbJBTEGQqFzRAOUO0v/SGTjrmnnvfNE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a81:ad58:0:b0:559:f1b0:6eb with SMTP id
 l24-20020a81ad58000000b00559f1b006ebmr6888406ywk.4.1683067459645; Tue, 02 May
 2023 15:44:19 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:50 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-44-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 43/44] perf stat: Don't disable TopdownL1 metric on hybrid
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

Now that hybrid bugs are fixed sufficient to run TopdownL1 metrics,
don't implicitly disable them for hybrid.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f4e572f9de6b..67dc69270ae4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1900,12 +1900,7 @@ static int add_default_attributes(void)
 		 * Add TopdownL1 metrics if they exist. To minimize
 		 * multiplexing, don't request threshold computation.
 		 */
-		/*
-		 * TODO: TopdownL1 is disabled on hybrid CPUs to avoid a crashes
-		 * caused by exposing latent bugs. This is fixed properly in:
-		 * https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
-		 */
-		if (metricgroup__has_metric(pmu, "TopdownL1") && !perf_pmu__has_hybrid()) {
+		if (metricgroup__has_metric(pmu, "TopdownL1")) {
 			struct evlist *metric_evlist = evlist__new();
 			struct evsel *metric_evsel;
 
-- 
2.40.1.495.gc816e09b53d-goog

