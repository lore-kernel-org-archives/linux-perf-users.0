Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB81C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 06:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiAEGPg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiAEGPL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1765C061792
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jan 2022 22:15:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u185-20020a2560c2000000b0060fd98540f7so12305011ybb.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 22:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8kii3dU4XUig2NsMBYh2ztP77tNeRDKF26nqmJlinnw=;
        b=BSYcjgUHghko72edoiIv4G3cjKBzq3ehGryZJE+H8BRTklqIkutZuePSRHPpMV6vBw
         Z06T8Bp1YNRRHloiV7U+1uZP2Bhs5d+lVTRziFfQ1AOLjcQwfiIexNiEc202pyfnMax9
         N9njEIRcEKtKTN1xsAVdtk9zmsWzAoJXPpVbJnBTZzYdCbodW2lknjllCqmCnVvemOci
         aTObHJCt6X4QIUGWKxDuN6UO6RAX/7XbOpdQaYSMetQVQ2PyU5Xr2EldMOS55EGCafWy
         LEgt2OIF8c5qVFS1B/5WOHwH7hrXZ0PVKuZkExuxCVbUTtBpOUW2PzbSueFNDveySNMH
         rMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8kii3dU4XUig2NsMBYh2ztP77tNeRDKF26nqmJlinnw=;
        b=eCuzbnzuXcZqfB97NAB+lW/PhXure+UxSaQF8+iUYORByDsuOygXoL5jVP3MbX1giu
         1Ym5MBJtAbfaYHbVJn/2SSdIWXz2EwHO+P3l7FRs6aFEEGPJGDhZNOwkiYJMUR3Ly01Q
         Q63novTFPaJDLwX0xwwQCTi0Vzrl22J/z7zZIpRmViF8V7VCeKm0IuUPXV/ZHClpkFaS
         Fyyys7vqcEOQ4I/xo0PEul3VJR8rHfPX0TKTLBd2b/JibhcpHvUnbdfcC1oYIVzt2SFL
         jVB2UeQEMHFKDwEETFcg+BIvMHGMfNAWImgcxvkIrnmUslwVoiEEKEPcvx/dTcXQh26B
         /QkA==
X-Gm-Message-State: AOAM533aKb6CL+gz1lw88klKOtB1oMerIWaoqaoFVcFwFFuM+mCoXRj+
        xZ47c4Rq4D3DcS01boSMgOH5Zxkykuqk
X-Google-Smtp-Source: ABdhPJyACmhRpL//P3NHuYdqf28x0b4/9Re1ZbBwgLpJRx+vhfd3Aq0crqV0mPEFMOz5FCU1L4iYQZxlghlk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:b5c3:: with SMTP id
 d3mr72174615ybg.665.1641363310263; Tue, 04 Jan 2022 22:15:10 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:32 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-30-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 29/48] perf counts: Switch name cpu to cpu_map_idx
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

Try to reduce confusion in particular when the cpu map doesn't contain
an entry for every CPU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/counts.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 3e275e9c60d1..5de275194f2b 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -18,21 +18,21 @@ struct perf_counts {
 
 
 static inline struct perf_counts_values*
-perf_counts(struct perf_counts *counts, int cpu, int thread)
+perf_counts(struct perf_counts *counts, int cpu_map_idx, int thread)
 {
-	return xyarray__entry(counts->values, cpu, thread);
+	return xyarray__entry(counts->values, cpu_map_idx, thread);
 }
 
 static inline bool
-perf_counts__is_loaded(struct perf_counts *counts, int cpu, int thread)
+perf_counts__is_loaded(struct perf_counts *counts, int cpu_map_idx, int thread)
 {
-	return *((bool *) xyarray__entry(counts->loaded, cpu, thread));
+	return *((bool *) xyarray__entry(counts->loaded, cpu_map_idx, thread));
 }
 
 static inline void
-perf_counts__set_loaded(struct perf_counts *counts, int cpu, int thread, bool loaded)
+perf_counts__set_loaded(struct perf_counts *counts, int cpu_map_idx, int thread, bool loaded)
 {
-	*((bool *) xyarray__entry(counts->loaded, cpu, thread)) = loaded;
+	*((bool *) xyarray__entry(counts->loaded, cpu_map_idx, thread)) = loaded;
 }
 
 struct perf_counts *perf_counts__new(int ncpus, int nthreads);
-- 
2.34.1.448.ga2b2bfdf31-goog

