Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFCFC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbhL3HWn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbhL3HWH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA3C061759
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:22:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b144-20020a253496000000b0060bddc72114so24594286yba.4
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dr21UIWlWh08GpstPSt0DXreHsY1rvRjUlHXGQMgUUQ=;
        b=EzlOdQL0P3mQ5LLCjUBdScAdR4k8fbx3t1xiYbAGiLzrvhfYRNamUq3myYjTNbMt1z
         z1iM60q9zjlaQAcoCGdA/MylPvkoXxci2/mhvMITTMVzxFMmy1kLRBKwKSdlzO0kFLac
         rmX36ofvYh41GcgwoFMXtS3/igsv10WDIviUoefVvtAGryPH4lySTaSqzi51hQVUXRp+
         ocpdbQPHx5fHXPwVKhz5QvLiwYbqfx4x5Q5vidzBlB7alneeRNnVq+/RWxS64bjPHZdY
         MsTjekbO8bobE8pPkFVDaDAAyl1NvvRu7QWxrniO69RQBLBeqhVDpkbID3vcTO0EI6LS
         iryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dr21UIWlWh08GpstPSt0DXreHsY1rvRjUlHXGQMgUUQ=;
        b=uHDzsYs9yuK4v+mOMYBt+HmquraB3zNUde8OnxsA/J1avYIp2hcFBkpbHv2pCY6hs7
         dgoSNj7gDfYNVOjvgzD0Ft0ZWyZm35W4ygUgsrdQXbjfAiuB5u4xQQWc2PsrFlHwEyOx
         DUwQfzcxoeXeg8Z7azazpyatsP8kjMqsZKckteYjBDQ9Xkfp0UPU38LKvirtEyvUmZzr
         V9ghL3nw7Ls9wCvWIPAWsariwTjGvTC0oYjovnsSep4gzKCXpUs5JtH+G6kZmNoTI06q
         TOrfyRi5jP0KlApkC9iSnLOH76FvBa8QqdUbhUEhrpLM8A2sCVb2lGWJzKx3txBvIvcQ
         7FDA==
X-Gm-Message-State: AOAM533MZPxh5QZtU6MP1V8wqKKLhcxe6Cez33PjngOX8QNWa1ginbJ5
        O5euC3OFZbMMlf1I2LpnUj6IS+qpk+Yx
X-Google-Smtp-Source: ABdhPJyRfLGpoQ9H9fJ2Morzmd7n7bmZUL51X8hObRibMpoPCIExOKmteY86oNxmXqhmcVFjCo2lIJ4u9b0N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:7287:: with SMTP id
 n129mr36420396ybc.351.1640848926039; Wed, 29 Dec 2021 23:22:06 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:17 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-37-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 35/48] perf evsel: Pass cpu not cpu map index to synthesize
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

evsel__write_stat_event was incorrectly passing a cpu map index rather
than a CPU to perf_event__synthesize_stat.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f31bc34bd4cc..ec252579b587 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -327,10 +327,11 @@ static int write_stat_round_event(u64 tm, u64 type)
 
 #define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
 
-static int evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
+static int evsel__write_stat_event(struct evsel *counter, int cpu_map_idx, u32 thread,
 				   struct perf_counts_values *count)
 {
-	struct perf_sample_id *sid = SID(counter, cpu, thread);
+	struct perf_sample_id *sid = SID(counter, cpu_map_idx, thread);
+	int cpu = perf_cpu_map__cpu(evsel__cpus(counter), cpu_map_idx);
 
 	return perf_event__synthesize_stat(NULL, cpu, thread, sid->id, count,
 					   process_synthesized_event, NULL);
-- 
2.34.1.448.ga2b2bfdf31-goog

