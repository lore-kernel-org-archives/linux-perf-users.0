Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30F2C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347012AbhLWHqh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346998AbhLWHqg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA4C061757
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:46:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so8723094ybj.2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i7256vb/Zx8IIeVMwww3dL/k4OEqcir0FFGgHyZofME=;
        b=ULf7pncHNSXp74XAiBkRZsQ2We3PFB8Q6TLzGDSIonox8ZanH6Qkow4Mrc4PWRHQfP
         q/Sfhe3s5uOsFTdgq1wgbUSW0223h23SUnF8X++qM+vLzFZSBgWEYuACJss2wepreTnK
         Jf3gJiLFO2iaB53o4KLMpAQ0fWqkPZCaD8drbNrmQv2mcqSv+8yyrPecChcT2dckeMM/
         k2w8pIiFpuL/8kSi1srTjFgPb/5EHoCETU/5ICYUhaN3EaDXOhXmvSZmadajv1/Qi5bV
         VSHoEm0TVW81+Qe9AIwsjsGB8B2Uq2SCU86B9CseVBXgUkMYa5KxDMu1vn6jG91+xUOU
         hFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i7256vb/Zx8IIeVMwww3dL/k4OEqcir0FFGgHyZofME=;
        b=3DuJAW5JWPWvgpa2MF17HXCzxIFIrcaD5OPxpJXKSJIMV1cX9TIEEAIUHulVQNwfnE
         Ppp/LzUAvdB0EVtB4XKxUPt7wBfcSbvBNP7TvpUauY1YK5Pn/75j3l8Kml1wSwUy5cSy
         DCM1WR/6ajoSBb89j6PWP9icgXoaAEkjQuwNdEiiFbYyCPRR6RwbpLQdPBD1BuqBOMMU
         4EN/itG575eGLOAfQt2TyrB+or1Eb65hOiKSQmuqhGWrdjHCSaVf8wli1K7X6T7ajc8D
         xobAI2Cuw6TosKE+eNAaD9NIlCHMxQRTeFZDMsHpiHZAsPvcBBMiX0mi7WIJTXa+pgel
         A9qA==
X-Gm-Message-State: AOAM532b7qXFEVVlJITX0uyCQMwBx7uIfICRD8+20hz07NjJIDVskMFN
        rCsdYoRa8x+ICKpQ83RpDQmaUUibBaM9
X-Google-Smtp-Source: ABdhPJyR5JZf5bjSrz0ulaEcX4bGs7VsSsfLIz8hrDRGWaiBoyyjWL+6gtkZ7bJTmSJ7QJfv+tI/QK92QsEU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:328b:: with SMTP id
 y133mr1567948yby.233.1640245595027; Wed, 22 Dec 2021 23:46:35 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:04 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-12-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 11/48] perf cpumap: Add comments to aggr_cpu_id
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
2.34.1.307.g9b7440fafd-goog

