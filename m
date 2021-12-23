Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C3AC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347442AbhLWHs2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347252AbhLWHrw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE25C061759
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:42 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v20-20020a25fc14000000b005c2109e5ad1so8635315ybd.9
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Psj3VZxbAwFP1vAQTBNCyzZPof5d8rm7KZTKeBB5bD8=;
        b=XnaIT5sMNMofcBzh0eJYLWvadrz18KX/BFz9jUe2q1NXS2VPiNFBVEld/VzCGjO5AJ
         FesCgPT1eXtNtqbcNCKMNf9LycfaTJBJOlrce26GDAyFz6z4MXPt4bvKw/+SPq+6t1QL
         LZeUpr+1TVP1sNbr9rQ2lSQ8f3/oxHPpvg2nZQdb+I+3iT/KirMJfA5gx7uFjbvpZmK9
         0HfScruNAfRInokHPquRdRA7NlAKidAy4qpV7sD+jjGQP+aJEMbVJdPl3+UugILUOItq
         gdi9DnUHlx2K25ForCOERAX8Wo862UxrmXTHY42z5pCCMvsP4Amu8/YnLwOsebhY8Uqw
         f70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Psj3VZxbAwFP1vAQTBNCyzZPof5d8rm7KZTKeBB5bD8=;
        b=Aos11pZN3wU4x3Qaqp8UYiVwJalzKFl9Z+vX2F1bYUfbow3W7F1a1bOU+xfjbUFxSQ
         HvGWh0rWBQOyOcVDP5PdlbzG+ZDO2yxCAgTp3iK2CL5fOdy+UpmDkGYLp25o34LDMSYn
         dRzGUYbwM8AnEXap7e5+ibpxNVghficxqFV2LvQQsw5y/9rLicPaYOfuDTH+5Bs2abRf
         BzDnfc/lG8yn6I6eddsSvjm9wa/x28x/+rBXTk/QhDQ68xV8/0QU0dXE9mNhbB28VZgz
         gT5ljed2wRBQLKGxzkq7opbbAKtGZeAqVfHQyNSE0u6EG2sZ8EzsMijpVj77ChTaa0Q/
         F+KQ==
X-Gm-Message-State: AOAM531pTi5iAIuIuBclq0/KUz0/h+Oid+ifdnBYrsueXpGPfOBcGhy2
        aB24zpOxDky/Ll893VmrCP3taFpbfzKU
X-Google-Smtp-Source: ABdhPJzKXlgj+iaoDTmwl/snbfmWy/Imp/moMR6bS6PHjM3kYqJPPGlIKA4xq/Wbw+nE4uQY8vBCaZBQhOJt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:b5c7:: with SMTP id
 d7mr1660547ybg.741.1640245662171; Wed, 22 Dec 2021 23:47:42 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:30 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-38-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 37/48] perf evsel: Rename CPU around get_group_fd
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
2.34.1.307.g9b7440fafd-goog

