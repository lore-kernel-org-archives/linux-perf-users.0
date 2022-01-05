Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48003C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 06:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiAEGQS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbiAEGPU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:20 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A73C061761
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jan 2022 22:15:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b10-20020a251b0a000000b0060a7fbb7a64so60441729ybb.23
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 22:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zx3eoMgk2E9Q1m2Vv8UqlZ4wRR3W4iMt/10PWukXDj0=;
        b=JzhU/p628/opiLcLIsURp0pnOITWo3VMDbz1xTScpyWKXTQ80ky+9phYvVj5YskKIC
         ihV1UilgKg+fxIR4lNRHT2jbRH5xt6z9qcMV2CsvJwr2ey6a884uofLI44XNilaitkIZ
         t1vI3Whq21gSG5xhKvTtflEVRoIWzAK4x+EyoUSDkQVPS4z0aBp0uNzVJlG10nbmRXf8
         Qimi21bEbywjJXYALyBU8WePexxl8cnJyM5mN8wwdJ4Rd1VvdhyoWg/m61iwNEXsXuM7
         IW2j4cuizU/2649UP7UvfnXkYyF4DloSnqBcS5aq9woNDszcs1uyavBg6D5cRuOkmLwR
         +xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zx3eoMgk2E9Q1m2Vv8UqlZ4wRR3W4iMt/10PWukXDj0=;
        b=HdO6M2gKXgYWrY957gxbrEDwO0qq560q0gmlnlZdN7cbXBufDnaKbfHRMzqAadvoVc
         8tulvs/Ana79VQ+j/aFIM2ELhOwEcB1latQVp0UtlFJg5U56drSvHmWjCLvbkG3a9mZI
         LyeVLi1kJ6payMqIGkWAeX2J+60/RgSo8OGhmyjMvPg600VhR6lU6x89trXCM708bjzw
         u8rhQQNbjVcSyjQv5ewnyouh9sGahaWm4WX8GZ4Dw/Qh+n41VK2XumrGuvYSGOpiUiTP
         JN4sTmvbeWs34eoeVhqQTxrQJ8O1wZBsCli85kQgs08+BS/yvWkdF37DNy4XulcVva/C
         VeXw==
X-Gm-Message-State: AOAM532RbYt3yPi8JSvmsmqFuvUN3/kKwB2N1lcTESVFIKFHDpttBSWN
        +nBXZzU8DMprEpB/3mSjjwBr2MkY8SVr
X-Google-Smtp-Source: ABdhPJzsyfej2FDjgM0ae4+/ARSD37iN1p79WMe+BCIr76RgnKeFFpZkmXOBSkD22Il0+R8oWA1ghKXmKhIm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a5b:350:: with SMTP id q16mr367766ybp.639.1641363319931;
 Tue, 04 Jan 2022 22:15:19 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:36 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-34-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 33/48] libperf: Allow NULL in perf_cpu_map__idx
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

Return -1, not found, if NULL is passed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 3c36a06771af..eacea3ab965a 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -270,8 +270,13 @@ bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, int cpu)
 {
-	int low = 0, high = cpus->nr;
+	int low, high;
 
+	if (!cpus)
+		return -1;
+
+	low = 0;
+	high = cpus->nr;
 	while (low < high) {
 		int idx = (low + high) / 2,
 		    cpu_at_idx = cpus->map[idx];
-- 
2.34.1.448.ga2b2bfdf31-goog

