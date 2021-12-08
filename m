Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E43FC433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 02:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbhLHCuQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243596AbhLHCuM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4257AC0698C4
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Dec 2021 18:46:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w5-20020a25ac05000000b005c55592df4dso2091310ybi.12
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Dec 2021 18:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JDNiGhsNHgdmMUztfVS0cnfpFuxHbFnC3w+TxzcO4qI=;
        b=JJ7/x6DfuHkASvF7wwLFs0k6i+67I0tnw9tx9PMmghz72m5Sn13MHx/YhyOjfi+Zr8
         SbC03NZPML15LTl1g3fxNoiQnFBYix6jL0tJhSL9vjfRNV9d+sRXhcX4EQtL+fF4uD5S
         frd4E+pDfSuJD/Mtpx4kHDsa81aCpq/49V629laKEw65BRMBPUXmeFIdkFt0c/9kPAH5
         BxaBF2GOAWQpfq6VS4FWgSN2s6ARePKRkJOFh7rRJ3nejs9sX/S07EztA6JktNQu6t94
         M6wXYcJsvH1v0Cx2s2YWOAB0ryUtrdXNshmjVYvI+oeDO8p9NCdj1jrtBtxufod4hrAd
         VtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JDNiGhsNHgdmMUztfVS0cnfpFuxHbFnC3w+TxzcO4qI=;
        b=MKU96DOMHNZT5bbY0oJCr6jiGGUoF7mdhkWQQLTIAa2Qz/8J8ysF2/ihTrQQsE0auz
         0ucTJmtdjxHABlFoLp0/GiX3aVe2iSi6OW0/dhsftE8yMamp+1p/hbVn1taxhOAaHtU2
         359NmpJ9+C/WI59dKFfJtjuA8fUGpKyqOMOs3vo+n7ejnu93vYCZLF5waDY7caOX83PU
         sFKBNVebsKVXPrsLqLDH/vYxidgrRjWjnySTwzfNrJ9e5QCVD2sfqAkaokIpj3zWhtEl
         43poVzo7IkfroAERqM/jpegjwMteGow45yfree+S9nojFVLTqzV/iRFkfh7mbxrYYWsf
         e7gg==
X-Gm-Message-State: AOAM530NxrRzw8OYtX2LmYmWjKPU1rhhGaCAt604o6kCl4ovDiF8yUgy
        k2aQVSQw8IlH43xatsNV6Wc/o2YM7/4S
X-Google-Smtp-Source: ABdhPJzCbvy3TlsCCC1ENscWrGWTXClq62iKwu8pToTV891HdLlKh5Rl3a8xK+72qtmxOd8TDK362KXAgy6e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:b18e:: with SMTP id
 h14mr29366868ybj.744.1638931598466; Tue, 07 Dec 2021 18:46:38 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:56 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-12-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 11/22] perf cpumap: Remove unused cpu_map__socket
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

Unused function so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index edd93e1db36a..22e53fd54657 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -53,13 +53,6 @@ int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **cor
 int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **nodep);
 const struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
 
-static inline int cpu_map__socket(struct perf_cpu_map *sock, int s)
-{
-	if (!sock || s > sock->nr || s < 0)
-		return 0;
-	return sock->map[s];
-}
-
 int cpu__setup_cpunode_map(void);
 
 int cpu__max_node(void);
-- 
2.34.1.400.ga245620fadb-goog

