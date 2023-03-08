Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DB8C678D5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 08:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCHISn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 03:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCHISf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 03:18:35 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99D9168A2
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 00:18:19 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536e8d6d9ceso163177267b3.12
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 00:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678263498;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjmM/9ZxcY4QPw1OT563S/xkYBM1O7yZVKEKyXWS5g=;
        b=pxEIKL3PPwlLN25TpuV0eautgYwV0o0aW2grlqQeTcfwjmIZQil6pJYUPMEAxU4Srb
         7+OwVGY8HDpmBsBFFS+oKiq/0OnJFSw3yr+fvEmx9wepn6Q1dHpQdhJpbeK8gd9PVEHK
         4FBPWrwDUUadtk0Gdf3tDQ5Ed66djl1JBTDVZxfvgA4m504KL7o9Ra8UxQIuntd+6DlH
         n5XFdEsf43PQ7RZhOnb6wys4naGaG31RZel3b39NTMP6PcWfVhy7V7ay9lC06kgXCsPt
         pgrINEKblHASyMrd53gusCR6hN9faCsRSq43QRhNT9OJKncHrUeoxMP+H1ZNWZhsUpSK
         6ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263498;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjmM/9ZxcY4QPw1OT563S/xkYBM1O7yZVKEKyXWS5g=;
        b=S3crBs8RQQPPpjo4RE7K1z8asaLoe8d0Iff7ZDsHFir0KpDUQ9demQtxZB6MJH0Jhg
         bgF3wT6ODM+Zb8h8XP6jJSYtgbkMeHk7/lHuS9aPYql8F78S91POFKg8qPVn8vT7A3DT
         6mD3/jcrOgtNN4CRxW4mPfcWHdDrnOPctAZ3sRWHCqs9hdknBuUVJueTrINEZUyBTPkx
         Pgi7vkY4pqOHUkHKH1W9CtHWeZSpYBXYs7pJf8ttr2CjDa8OOkGLiSJPaOxMEf90sr/x
         p0/uGv1/q9Zk190+YyxCtr9MuHQGwML7dWxYGDLwp/YcuIf+e5LCkCcQBiHkdwaLQbbn
         iq9Q==
X-Gm-Message-State: AO0yUKWEUKriy0PQok/9hBvNSL7gLekxMT7dN9Y/05jfp7bFU4KKQ53D
        SfojoxKXnaezZt1V2mQqjQeSMzlCNetW
X-Google-Smtp-Source: AK7set+9O9Wk5BTCkRajxDbon6ycn1pAYNIVG/NGlctTUcdXrjn2qjwP6WpHtNlyYFMb9Y/pOgb8vp5bjVOq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a5b:c0b:0:b0:80b:4f92:1623 with SMTP id
 f11-20020a5b0c0b000000b0080b4f921623mr6ybq.370.1678263498380; Wed, 08 Mar
 2023 00:18:18 -0800 (PST)
Date:   Wed,  8 Mar 2023 00:17:24 -0800
In-Reply-To: <20230308081731.1887278-1-irogers@google.com>
Message-Id: <20230308081731.1887278-5-irogers@google.com>
Mime-Version: 1.0
References: <20230308081731.1887278-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v3 04/11] perf stat: Modify the group test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently nr_members is 0 for an event with no group, however, they
are always a leader of their own group. A later change will make that
count 1 because the event is its own leader. Make the find_stat logic
consistent with this, an improvement suggested by Namhyung Kim.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index ef85f1ae1ab2..eeccab6751d7 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -163,7 +163,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 			continue;
 
 		/* Ignore evsels that are part of different groups. */
-		if (evsel->core.leader->nr_members &&
+		if (evsel->core.leader->nr_members > 1 &&
 		    evsel->core.leader != cur->core.leader)
 			continue;
 		/* Ignore evsels with mismatched modifiers. */
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

