Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B9EC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346911AbhLWHqM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346909AbhLWHqL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:11 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1DEC061756
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:46:11 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so8653676ybe.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=88O+wwMIUMjGSp8vBh5a99/6nPbt91KU3ZoFuApgaYM=;
        b=kkIK6Jg8+WpZYmng3joQ3qp7DcIRoNBjVuzHPir6XhEiQ2dPDMf24HdOEIFj3H32O9
         iAV59G2dqE3olG8dUf/LvN+WWu5yfgmfxfZ8dbpDvAH7gRDurmrARUNNtzzHoYMTKDHK
         bvm6ebVeuPWxP3qt1IWSHXjt2CEDs3rvibkZprdo+h54jN0UFejfqm5XnZ+hkM1CkKv2
         Aoktcu01x4wkJ/4Owe/c+dJR8ZrXFc6418v3JO03Rj7gytXcvJSbvaCIZoOPzWUI/gpf
         kRnd7H+McfkEgdyWEtX5i7mcPvrtbLMMXFDUopiv4D9nLN6qYz+mknTdUvJhu1Mh6yxE
         dorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=88O+wwMIUMjGSp8vBh5a99/6nPbt91KU3ZoFuApgaYM=;
        b=p7EbgNPtm+rbBiVnj+O7+gTSTSCnfAvoEawHEolhvxldxY8OR5LYooafQjEByftIPa
         FQoJ29+R3Z9NNXzjPhY+QQag7PTQbAPRMqd92IYw2sBjT2kQWxsZpLWcarEWt1gJe2yo
         FJc41HvVSb//qr5BlmhxU1v5Lipg9lDGe5xJyecFQVr/aXMA4UhuVy4W/Xa1ex+kiYZ3
         hhvyQwkWUpzYSweOgJ5Xks7emWxiou1M6ujfF2OFQYaBtynR3WHFgGYBG8E8eOm1gVnl
         XjGEdbR2XgoVuC1F8nnf6khORb4KzeQCfRzEkasSZy985tTfcj3vp0xBazOQLKgfPB7s
         ce9w==
X-Gm-Message-State: AOAM532QAdFcHSoO6Q65H1Hw7XXVrtf9Pt7TMCH4ALW3QVRVkhHl9Ip2
        JXa0xndLYTwWn4/dJzkqKhUG2WUarlTq
X-Google-Smtp-Source: ABdhPJzjEgbayUhuRxq6Yf8H4X/kehgDmv/v3Teayg7xc+3ZCMqY4PFVtePthRhrD2JiHRScvPQB4dR3Qvxm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:d984:: with SMTP id
 q126mr1810815ybg.392.1640245570595; Wed, 22 Dec 2021 23:46:10 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:44:54 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-2-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 01/48] libperf: Add comments to perf_cpu_map.
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A particular observed problem is confusing the index with the CPU value,
documentation should hopefully reduce this type of problem.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/cpumap.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 840d4032587b..4054169c12c5 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -4,9 +4,18 @@
 
 #include <linux/refcount.h>
 
+/**
+ * A sized, reference counted, sorted array of integers representing CPU
+ * numbers. This is commonly used to capture which CPUs a PMU is associated
+ * with. The indices into the cpumap are frequently used as they avoid having
+ * gaps if CPU numbers were used. For events associated with a pid, rather than
+ * a CPU, a single dummy map with an entry of -1 is used.
+ */
 struct perf_cpu_map {
 	refcount_t	refcnt;
+	/** Length of the map array. */
 	int		nr;
+	/** The CPU values. */
 	int		map[];
 };
 
-- 
2.34.1.307.g9b7440fafd-goog

