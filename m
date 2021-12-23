Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD4CC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbhLWHtM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242830AbhLWHsR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:48:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9545C0698D2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:48:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so8727734ybj.2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8dsbS5qNAaZwjjgso/tH43ZBCOZXMegiAB2IxZGAtxY=;
        b=PQhAtMAARGULqWwBTpXr3yXhs2ODyw/ITTTon4PBCLboBEqbgmDaHbmw4c6nePmtTs
         uAGCVnve4qdC3HB0ycP8Ffwg3laRq/3wRwQLITuj/NM6ljjzWyV2PuZsqKjsoKC7P0vV
         CxBdrtKujfQ5fKSG12PNfMvK51kmg7PJKeTxB2Hem9rrLzH2ujPUhnK3mh6yxmxEsRBt
         nJSUpYWHia6Jmf9ZYIq1Q4OHllCwz39+BFSwFa6deXzEI6bD2zJdbCJbhwaJNV7xH/7D
         1AQmqj0XFlL3Nzie5Ah66Swk9U5RR578skOC784re3hCuU1+PSmz32lI/J8gkXrBWiRr
         HBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8dsbS5qNAaZwjjgso/tH43ZBCOZXMegiAB2IxZGAtxY=;
        b=xfy9CCG2k200D5zUOApRdajZ5DsxE61qzBBCYF0D0lj1fq0Z2IF4LRyh+fAGFF3IFb
         268ENuctBvezbcsRiZOxAoN0/IBi7LLxzOv4OYInoiVjcis8QKDSIbxUCBnNNdHMKunJ
         USrJxqhuAvwglVL3syx9FKKL9QTyONa8U2uj3DBfUImEcfjCQRBtyC+ZUodBbrM5qAMI
         FSkNS7GIdPSe3b66o2Kp7GSSCux+QIndKm5w6dGuwsRBhO82/yNzUm80tWoiRrsu5d+T
         oi9VztSseoEPCqWl15aQijbV9hYgm3YowYNMH1M1DvfE/KBUpv2a0xk2oATRAZ32af+0
         y5vw==
X-Gm-Message-State: AOAM531UousxvkC4m1Qvg5vpJu7gzIoOTMpZNoHsnhixwlxRiIhWwyZp
        oMkRcOKa6K/AfxJ1g/EItNIznEF+xhs+
X-Google-Smtp-Source: ABdhPJzWqsoRQMCzJi9y2FpN5S2sgEEMwklh3mJKbN+pS1OAmbSTCoL/av3GIvKVh+8AzLIV6l2ui3xlohJr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:d743:: with SMTP id
 o64mr1575188ybg.81.1640245685068; Wed, 22 Dec 2021 23:48:05 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:39 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-47-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 46/48] perf script: Fix flipped index and cpu
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

perf_counts are accessed by the densely packed index.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index af06fe1271cc..de4af7af34c8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2129,7 +2129,7 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 		perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
 			struct perf_counts_values *counts;
 
-			counts = perf_counts(counter->counts, cpu, thread);
+			counts = perf_counts(counter->counts, idx, thread);
 
 			printf("%3d %8d %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %s\n",
 				cpu,
-- 
2.34.1.307.g9b7440fafd-goog

