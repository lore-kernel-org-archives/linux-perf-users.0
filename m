Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1E9C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbhL3HVT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbhL3HVK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794EBC061759
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b144-20020a253496000000b0060bddc72114so24591557yba.4
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4MpQqbzavNLo0+7JIiR5CNmzapIg19tJzrEy7JBYf1M=;
        b=kXoA13WOKQIftVzZWO4HPUuV3ZzbRFc766qGcXsU5lIzsbLaWePjPAChzhTjJw18XB
         ezxaXy4Uv1c2Du76Ko4gwC91vIrvCM3ggm9zIVTJr4hexeJm4z6dvMdozbh8tGvq+zmd
         /QnB9H3gMb1zivqVAQeXMeGVnxlaHXv8Y/wELEKdnZWWfFBJBztyK0Z95UQkaz7Y1oOE
         W6ki6PrsFwHa4/GIZfRZCPC72h4gi1/a62TR89XKPRzbO5VWS/+G836nopw/oJN2MBJC
         CypKer12qZ2GIMtMWwW1YMrCovGqMQLyh5XqpGWQL7eSMObFVRg7vZAcaLpiqcHRikLJ
         hRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4MpQqbzavNLo0+7JIiR5CNmzapIg19tJzrEy7JBYf1M=;
        b=bF4j0Y00MEQQrqeB2VxrObIg09i2jiE6R5T/m4wdpKS1i3670kb8wNtDSEaTxZYwMH
         xCNVpXN8Rkby8+I5K6k5gwnBerplknHIb8r/XRKwW2kkdyq7HKRTYE5mpb0dCD+THGTO
         A+TBeC9GQKO0sHDgIxrB0gNEfYEgpS7qeT2PdIEnvINALWyzt9SHpdUH3s+uaTCtablX
         1em5Z3jHHl/Kr8AQfP3KE/xIUf2JoZgWD9sERGBshn/MBFyUUpHXeGDuPe7oZkedhl/k
         mzC13hpOMS33s8MycUs1OGb83WStMjLG+09qjTR8/Bq8G5/fF28r8nZYur7i6GRFyMs4
         8aMA==
X-Gm-Message-State: AOAM5331nCbk07BnK9iyksB7jwZwSaiQO7f1lt/VGtGKIFPa4mx2BH1p
        fzJE1thJNxk24iAOs/sEZxSG03/y8Bv7
X-Google-Smtp-Source: ABdhPJwE0WxTfbpAvt6d/swn2WJ5h727lammLK2k1Me4z1oYDnY4PoE78/VcpLfmw8FLS4n+YKUA4Mk3yljz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:cdc3:: with SMTP id
 d186mr34482066ybf.400.1640848868720; Wed, 29 Dec 2021 23:21:08 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:54 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-14-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 12/48] perf cpumap: Remove unused cpu_map__socket
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

Unused function so remove.

Reviewed-by: James Clark <james.clark@arm.com>
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
2.34.1.448.ga2b2bfdf31-goog

