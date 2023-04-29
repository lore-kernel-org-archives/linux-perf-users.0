Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06DDC77B60
	for <linux-perf-users@archiver.kernel.org>; Sat, 29 Apr 2023 05:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347535AbjD2Fnl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 29 Apr 2023 01:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347527AbjD2Fna (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 29 Apr 2023 01:43:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CBB2D65
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 22:42:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-556011695d1so10727537b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 22:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746902; x=1685338902;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=udIESTQJWghJ0eXfw1zjkQa1ohgrnaNqFMimydoVXZk=;
        b=S7NAdMt/BLILu3k9cqlhzRidxjuY8lPnMt9sI+f7V2WnoL0rxhIkGSZbMkNXRfehPv
         5TPdUIB0O+pIIqNJVeoQHIqeLHdKnubmejL5VoddsDUULbDGIMPX1pvwM6yU06ZFwrQC
         0eXx+8aYwje6WrjerTb2LqIO9f52ufMyswrjFggR7oKPCkP48oaqYCu/R8K8JIRFgkSZ
         +HFtXojLsja1GXQtRnMhcQ3JfR3PLQbsgqaq6q3opqfKF6AOcHzH4KX1Ku6AcICuzCEb
         IC2Nt0douaEw6NzsuPzD+GLN4s4QEv9KyLJCP0fOzB4wXNJGtjSxVDJfH92Cu3jvRarf
         FnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746902; x=1685338902;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udIESTQJWghJ0eXfw1zjkQa1ohgrnaNqFMimydoVXZk=;
        b=U0F2/09ix3E6goMYwVBM/4aWq8Kmu4B5//UG1x+LUj6M8KMoT6uV4pWgY81jkS+kMC
         DduIyTHt7l/ERvc/raxRab2orfJi4Ogh6UrtwEfp4o/i/Erj5T5HdO0W1NJIFGvgfVyQ
         Hu2zHktFL5HTWvX2pmPCEEp1PSomjz2PrWTzn1sxmc3xtRZDAjt/I+dBae997ahOJNMv
         T9ytQQwsn5CXf+mte2fR4BwiJkdupBZhKlD/zmTIqvOPSZB1sXUUWEel0cgYe6lDYObG
         eNsQQFsALs55H5LiMu1Qaq9kVv4dGOk+ce+ChCKMv0A/zYx/AX2Qob/jU97aaPrbY48r
         aRmQ==
X-Gm-Message-State: AC+VfDy/zlosG9RfQ2Pkx+d/l0loW2sedZxX9L36TvWo9ShpgEdlS135
        uD7wcrnfaaE/TEpffIqTiXor9cQmmY4u
X-Google-Smtp-Source: ACHHUZ7k8C4QVLDrdXyiVNZRg12JQxu+fF1LLzI0V9ATuIhg9IT4+BweogTF3zAsKr75lqULh/D5/nYRSg8q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a81:ad07:0:b0:556:2da0:fc6 with SMTP id
 l7-20020a81ad07000000b005562da00fc6mr4244919ywh.7.1682746902557; Fri, 28 Apr
 2023 22:41:42 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:35:05 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-46-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 45/46] perf stat: Don't disable TopdownL1 metric on hybrid
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

