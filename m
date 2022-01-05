Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E429C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 06:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbiAEGQZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbiAEGPd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C86C061190
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jan 2022 22:15:30 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a9-20020a251a09000000b0060b2c94d515so56598223yba.20
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 22:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XzElm/I104YF1oOu+ETkQDoVDrD7T7dkjmJMXov3Vlo=;
        b=QZ2qFGHJYt+gz6xOXt1LhDiyGD+OPylHFok9czJlkdjuWFUMdmdaVPI6oWRcEqfwK3
         XwF3f8SH1obOmcA2aH+7S9uxsp/MnFT8O7h0CRlq921GR3uNm82uuW0G7VA049i6Fpod
         HDxG9APN7M8zfaIhi+5h71bK/cVV2YcEDiFdK7po8enphcw/uerbn6SaNgEaw/kuAWXk
         G3z0WkaYphAsdgTqS9FohJRPxxtzAgrLCLADCU4thPERKLo9avwHssOY5J1Vh6cGBvF9
         ilgXMJld057L5ODWQRYooaOgwVrE3hu/x9OdDD9OHAczymIIiU+ZHzvpKW/rF0CWy/Z1
         LDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XzElm/I104YF1oOu+ETkQDoVDrD7T7dkjmJMXov3Vlo=;
        b=TT/SpiJwSM/G3/aFPd92hnu/2k7/1WVuZr3ZaBIouLAfWi/MHKAASyJ93nC/xrrqZj
         bCQ3ZNtq387t9CNWcFGqoL9+8j6W55cgunjQZMOF1pi9yGQNTas4RDF41JmTu5n3J3Ce
         FXDKryvLrae65yzWZjrBHnCrX/DzsJSWkO4rsqrKpafly5cfpQMsVV8oPJQQWGUUmg1F
         H/kDjWLbeQBOdc5rl8ylnkwGC9MbwxEZL+bitjW0+u6qMT+8pvphDwGdHNc7Mk65F/oY
         a0kMe0zHHYfFRMgjwaKWDo/Fisf8pzMd1xWG1OuVggPOvx16fCmzZ8kYaA/2zReNl0Ng
         lSMQ==
X-Gm-Message-State: AOAM530cTRfZRbFBMHRQ8+zaxE5f/LWgQr/S23Ub09HmciKy3kOjJ29C
        +W6/tfs5jg9V2Iq/weKf3Zh/nrT6wAwF
X-Google-Smtp-Source: ABdhPJwJ4RM9VYWq41fwhECqsHWaa6AOOt7H64isVIpH1h7i/JrS6rHORFMIbAVgnUhB8OfyDtXA7jZZ/TVS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:ab4c:: with SMTP id
 u70mr56995726ybi.211.1641363329998; Tue, 04 Jan 2022 22:15:29 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:40 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-38-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 37/48] perf evsel: Rename CPU around get_group_fd
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

CPU is really a cpu map index, change names to make code more intention
revealing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b4a2c5034cfe..4b3ba4408af2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1591,27 +1591,27 @@ int __evsel__read_on_cpu(struct evsel *evsel, int cpu_map_idx, int thread, bool
 }
 
 static int evsel__match_other_cpu(struct evsel *evsel, struct evsel *other,
-				  int cpu)
+				  int cpu_map_idx)
 {
-	int cpuid;
+	int cpu;
 
-	cpuid = perf_cpu_map__cpu(evsel->core.cpus, cpu);
-	return perf_cpu_map__idx(other->core.cpus, cpuid);
+	cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx);
+	return perf_cpu_map__idx(other->core.cpus, cpu);
 }
 
-static int evsel__hybrid_group_cpu(struct evsel *evsel, int cpu)
+static int evsel__hybrid_group_cpu_map_idx(struct evsel *evsel, int cpu_map_idx)
 {
 	struct evsel *leader = evsel__leader(evsel);
 
 	if ((evsel__is_hybrid(evsel) && !evsel__is_hybrid(leader)) ||
 	    (!evsel__is_hybrid(evsel) && evsel__is_hybrid(leader))) {
-		return evsel__match_other_cpu(evsel, leader, cpu);
+		return evsel__match_other_cpu(evsel, leader, cpu_map_idx);
 	}
 
-	return cpu;
+	return cpu_map_idx;
 }
 
-static int get_group_fd(struct evsel *evsel, int cpu, int thread)
+static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	struct evsel *leader = evsel__leader(evsel);
 	int fd;
@@ -1625,11 +1625,11 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
 	 */
 	BUG_ON(!leader->core.fd);
 
-	cpu = evsel__hybrid_group_cpu(evsel, cpu);
-	if (cpu == -1)
+	cpu_map_idx = evsel__hybrid_group_cpu_map_idx(evsel, cpu_map_idx);
+	if (cpu_map_idx == -1)
 		return -1;
 
-	fd = FD(leader, cpu, thread);
+	fd = FD(leader, cpu_map_idx, thread);
 	BUG_ON(fd == -1);
 
 	return fd;
-- 
2.34.1.448.ga2b2bfdf31-goog

