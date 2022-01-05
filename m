Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8362BC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 06:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiAEGOB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiAEGOA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5721DC061761
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jan 2022 22:14:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e137-20020a25378f000000b0060c1f2f4939so51882503yba.3
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 22:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R/ciplz7o8MJIByj4LFS+saOMsnt5V7JtjWFtjIV8fs=;
        b=V7JpZzJs2gXL96POm5sWbjGVFsxCEyU6yORHL0piIH+V2J0iDr8cqIhAdgxMk0NpG2
         ihnITjj6WX7sLmfTox6NWzGspuIm62GIfml/65OOMvopJzBHOpAV5NvT/hhGQxNEuRnW
         8RDHYeRtMWKki5fSh7Ny6J+QjLlwjf1vnpt95IVV8w5qDw/8x8bYkAK2pUBRQjBBuxYv
         x/hTszUvFk2V+4W/SRtHl/Wj/u0WC/ajefYMlRQKUkwfQw2Mn8SXIv8gd2ewaIfXVBkb
         KrxpGq9fT4o2/ny07PtqZNv6f5H4hmZvffJuvOcQ46bw0cftsmQ7f7IKboepRuzgeIqq
         CflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R/ciplz7o8MJIByj4LFS+saOMsnt5V7JtjWFtjIV8fs=;
        b=zzW2fofVwe0mdiMD58RQd4SUDZeVdL+tnOJmU81/5iRKJdBSJwpCIFAVGfyjBPJfL6
         J8zSijka0dvZCXPPJ6q30M4nBKGbUDIUFJgpnj7bPTKSRctTBHMAHWaFa9eLzeFu9d5P
         A2fTfCgdUWxPTLHR/mNmHsuvT0CC0/Ojhdk21pBfvNeVhGUj+hajbcOMVFEl9h1zUxgm
         lVCdsIBUDfRQ7UM3MxX4BhYR0LZrjxYbkFr6zzQVQz7wvNfkuwsqUBfevG510WVvr1zu
         YTnLvM7oYPuqgx3PlxutGklJiaObjk1COW4/0g+SO1Qqelx6T/fRrmbFAZdIq+LFpsd9
         nElg==
X-Gm-Message-State: AOAM531/XW7IbgdGlSkUIfoAJIvAp9gC/QsxNoXMYhXxqZI1G3VBpZlp
        g6oXGcZSmamn2s+GtUZ5Fpb8WZbG+MZU
X-Google-Smtp-Source: ABdhPJwdyf0wgTd2lSIk7nzyWpLw+BQ96MKzNpX/BLsv/eD23F915G6JTUqMUfh21ANltJJj5zhS0aBjI+rg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a5b:950:: with SMTP id x16mr51295346ybq.764.1641363239591;
 Tue, 04 Jan 2022 22:13:59 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:04 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-2-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 01/48] libperf: Add comments to perf_cpu_map.
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

