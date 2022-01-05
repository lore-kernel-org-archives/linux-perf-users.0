Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3123CC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 06:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiAEGOh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbiAEGOZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174AC061785
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jan 2022 22:14:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a9-20020a251a09000000b0060b2c94d515so56593299yba.20
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 22:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dtLecDqeKsVhu8ABFSrCuZx030SIijpylbO9HpLxlsg=;
        b=rPvr9gWoMp+tcEvklfD5YFGVB4IOVMSXA117VxrsDkCGWfU/2AA1KKemErzaEz1j80
         nBOEQnRPHAZFKtZRHLMcfPdJO5iUjmMNZp+pTJc8ZThvUUVVivW4pU5HY/m1WM2hPB1r
         fFgp7YMx2E53p36U8UPtkcsIFA1BkZmpGUK1ebEvL0WRIuV4KUw2q5N6hk3ixJfP4Fec
         A8MOSS8M9nQVwuVHZmMKL5FR/AGkCMf1ZytTNVvm0hqsZVD9XiIXTOJWeoW3mW3a06mO
         jeK2e2sUGr8eVylaGRBrV3wSFdyuxaVMdsukodtAhx5H6uPONqT9WsqTOZvBplqlLHim
         sQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dtLecDqeKsVhu8ABFSrCuZx030SIijpylbO9HpLxlsg=;
        b=qNAb1Hir0n9xGQu6VYdq1qx7MEk2Zi8Yv02oO3vsmQXBiwOlfmNp28MQToKFE+7yia
         343mB5QW9F905HnXn5T5tXQc91dv17LGJX8q/FOc3vt4YUrxvtLJ+TvCGXQWt8rlwnuz
         1G69Z+pO4fhIbJJcRnpCnM4SBfBL3w9xjUMINVHwfTt9z9hwBv76aJSjXFVquuQb/cYZ
         SNRk7kUsHyl7YYs0rhmS1CJPKtV/OPA5CcPsqqSnpW0HqAbYipIw1h80aRvOp78OCqZ0
         NW2M9lRZdTbn7Ej0ahLVDYKmKJjCnwXCJgbKJ55p0ZVcqprDOBBOOPEpEWhj6bMJgTSi
         Q4pg==
X-Gm-Message-State: AOAM533+Ft6hQBviKPFMmBlhZHkKkIAgeExMLc2Pimd29Qzn+d+vjm9m
        oBqg0td/eJNUB1UnW62s8goXIO1G70hv
X-Google-Smtp-Source: ABdhPJyH6R41LCy4/zs50E9ENXaQ6Sbr6DfCrUwXfPwYx/SOE3XFHZos7IPT/kYvGsrk6IipKw4if2TGN8YU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:b1a7:: with SMTP id
 h39mr55511579ybj.142.1641363264670; Tue, 04 Jan 2022 22:14:24 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:14 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-12-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 11/48] perf cpumap: Add comments to aggr_cpu_id
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

This code is already tested in topology.c.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index f0121dd4fdcb..edd93e1db36a 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -7,11 +7,20 @@
 #include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
+/** Identify where counts are aggregated, -1 implies not to aggregate. */
 struct aggr_cpu_id {
+	/** A value in the range 0 to number of threads. */
 	int thread;
+	/** The numa node X as read from /sys/devices/system/node/nodeX. */
 	int node;
+	/**
+	 * The socket number as read from
+	 * /sys/devices/system/cpu/cpuX/topology/physical_package_id.
+	 */
 	int socket;
+	/** The die id as read from /sys/devices/system/cpu/cpuX/topology/die_id. */
 	int die;
+	/** The core id as read from /sys/devices/system/cpu/cpuX/topology/core_id. */
 	int core;
 };
 
-- 
2.34.1.448.ga2b2bfdf31-goog

