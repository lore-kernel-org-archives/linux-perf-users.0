Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EF7C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhL3HUj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbhL3HUj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:20:39 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36626C061574
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:20:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c132-20020a251c8a000000b0060c39ab7d36so23097145ybc.12
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R/ciplz7o8MJIByj4LFS+saOMsnt5V7JtjWFtjIV8fs=;
        b=hOnDJwZL1uLASJfxt16LE8RbyfAliT6lWhtat21Tok3eL5nEi56QviZgxbrBWkjbvH
         XcDTOXrfk8KXWSKd/gcxHMDBj8SDtjaQmSDkLF9iI1VtzccOrmo7SKYvF6BdZlEwhkjQ
         G52a+98JImuc8mE1Iu2+xNB5BY/m2ySBaJFm2e+nI+qUeCpD/NiVam89g+z03DkHfQWr
         kBkGfTlR3zL8pyYjAmdMbgLdMwagtqYMwfpD/bHcS9dibJZ6T0GjuIaKJP1TdvTHEZUt
         NCr4gAa47x5rn1N5jy478QfHJXvdXM61fjflTU+q5UEdUTdq+BaOzMnmqs0t8N5+FP67
         HCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R/ciplz7o8MJIByj4LFS+saOMsnt5V7JtjWFtjIV8fs=;
        b=cR52UsYS6FfcSyXw2hwfqliYKw5c0I+/u2zEgJAsXkTE6ug5VOmsiv+PnOZMJH/NNx
         43FF4BDzNa9eQb8p9V8SnUHQf6uv1yp6YkVWCZp0I1hVCF9qBxRAkA8cLONQfZ+PRBBF
         dZ++mxnScwxCsbW4FfuTFwbCKUX6p+neBkd0bVvd7BhHyIrCxPya7B9rF+b8RIXfJy0q
         UXGlD+lIPaey+kEgM+280pPVMhRuxzwBlbIc7udWRQhtmDcVYITIBV1ZhzFvJ8iVzFtY
         d8bclcUdRdCRFr1hzgM89Io5FB42N+uMjpUGkj8PmH54qPhP2A0S/zMdpKGvsvorgQhL
         AGTg==
X-Gm-Message-State: AOAM531hYhFdBZi7wiPhAb0pNkYHYmx7bSAURvdT4TggRzQ46b1psoPo
        LEiAopI965yqcNAt4fPCsEg0HG2qEl8x
X-Google-Smtp-Source: ABdhPJz0suG/e7yZrpxzUx3hVM4B9b7DWdq9+GCwNAbOY3zjXSahtZ9HZi+mnDCm0FVN8zGn882k7ziDe8sp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a5b:c01:: with SMTP id f1mr38085796ybq.47.1640848838463;
 Wed, 29 Dec 2021 23:20:38 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:42 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-2-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 01/48] libperf: Add comments to perf_cpu_map.
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
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
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
2.34.1.448.ga2b2bfdf31-goog

