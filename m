Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D343C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346953AbhLWHqY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346986AbhLWHqX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:23 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79488C061757
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:46:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v20-20020a25fc14000000b005c2109e5ad1so8631095ybd.9
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n0dEWZPTqb+S0pWa6wTVizZO8NEoLxYxvxJfIHMbS/U=;
        b=btq3RWNbpndjsgIOvBErrP3PHawbbLObRJa0DY/38ExCcxeDufdJRAe2TC7MAjkcaA
         YuObOtjjZk6loQwR8eaa+Ivk4Ue431uYQ8gpO6hnkKLNZZerfLbOuvwSlPia6/yw6C3/
         qaMzmRvJ7awM5GGcuqMmsmO7F0HCS+idM6UT8Zb5C6oaZlUlD4LiC27nxhOqYZfm/LCq
         cfRGuWQ1yDR/xJyWuPevvdDRcxYFTfMJjGpQXqvqsvfTttlvKAkJ0b/efz9FcotFGsag
         GGBtV/g3DIqmqVl5jGOCCljzrSJPC5iBKE5bgNUAmR1oQy1or7fT4uemK3Ql71A6ADvl
         f1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n0dEWZPTqb+S0pWa6wTVizZO8NEoLxYxvxJfIHMbS/U=;
        b=op5qYtsPtyqv2y+WGUJl8Z9Nyd3WzoD1Rfr1vbSrvr42hHPY8KkNcZQwg/RZnAWMF0
         FfYnMpygW5ctKqnmt5GHQJrqMyo2lV/ZB6Tj04SDw0HDW8Y3mWaQEtUAbRtWNarBwPan
         2xsCN+jeg7r06uCYJqJDh14pnuJO08vBKuFE7TeuJrSsyrHu0MQhE86oIlNDxnovkNOu
         puwmvbofn5mRBT0hNfeTxoqa38bj+FqcKi0Sd6y/0x+c9La8cpFDwH5+Ma+dGXy/Q2M5
         Cxm2lfBCrOjBRmXDp5cZxP4zxcQHhAbnILQ9BXB00grUzDx+0E8D1hvcaXOSEe/F6CLg
         0Wlw==
X-Gm-Message-State: AOAM531pae7zHPq87lL/b2/VwQakt6DaiSKAA9x0Z7/Zi+XfwFUG5+Pf
        3qO0VVyeozHttRw2h9do7qZceqvp82X2
X-Google-Smtp-Source: ABdhPJyfhg1rzaXCzlRw/tc0OBXQHu/3eLWhfN5LPpH7NAdg4kZGqvgjSa59t1ZUz+Aj0iATlFRmLZnOqipl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:418f:: with SMTP id
 o137mr1813615yba.154.1640245582689; Wed, 22 Dec 2021 23:46:22 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:44:59 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-7-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 06/48] perf cpumap: Switch cpu_map__build_map to cpu function
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

Avoid error prone cpu_map + idx variant. Remove now unused functions.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 28 ++++------------------------
 tools/perf/util/cpumap.c  | 12 ++++++------
 tools/perf/util/cpumap.h  |  2 +-
 3 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9791ae9b1a53..6b985abaa2d2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1504,11 +1504,6 @@ static struct aggr_cpu_id perf_env__get_socket_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_socket(struct perf_cpu_map *map, int idx, void *data)
-{
-	return perf_env__get_socket_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
-}
-
 static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(int cpu, void *data)
 {
 	struct perf_env *env = data;
@@ -1527,11 +1522,6 @@ static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_die(struct perf_cpu_map *map, int idx, void *data)
-{
-	return perf_env__get_die_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
-}
-
 static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(int cpu, void *data)
 {
 	struct perf_env *env = data;
@@ -1551,11 +1541,6 @@ static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_core(struct perf_cpu_map *map, int idx, void *data)
-{
-	return perf_env__get_core_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
-}
-
 static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(int cpu, void *data)
 {
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
@@ -1564,33 +1549,28 @@ static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_node(struct perf_cpu_map *map, int idx, void *data)
-{
-	return perf_env__get_node_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
-}
-
 static int perf_env__build_socket_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				      struct cpu_aggr_map **sockp)
 {
-	return cpu_map__build_map(cpus, sockp, perf_env__get_socket, env);
+	return cpu_map__build_map(cpus, sockp, perf_env__get_socket_aggr_by_cpu, env);
 }
 
 static int perf_env__build_die_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				   struct cpu_aggr_map **diep)
 {
-	return cpu_map__build_map(cpus, diep, perf_env__get_die, env);
+	return cpu_map__build_map(cpus, diep, perf_env__get_die_aggr_by_cpu, env);
 }
 
 static int perf_env__build_core_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				    struct cpu_aggr_map **corep)
 {
-	return cpu_map__build_map(cpus, corep, perf_env__get_core, env);
+	return cpu_map__build_map(cpus, corep, perf_env__get_core_aggr_by_cpu, env);
 }
 
 static int perf_env__build_node_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				    struct cpu_aggr_map **nodep)
 {
-	return cpu_map__build_map(cpus, nodep, perf_env__get_node, env);
+	return cpu_map__build_map(cpus, nodep, perf_env__get_node_aggr_by_cpu, env);
 }
 
 static struct aggr_cpu_id perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 49fba2c53822..feaf34b25efc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -163,7 +163,7 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 }
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
-		       struct aggr_cpu_id (*f)(struct perf_cpu_map *map, int cpu, void *data),
+		       struct aggr_cpu_id (*f)(int cpu, void *data),
 		       void *data)
 {
 	int nr = cpus->nr;
@@ -178,7 +178,7 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 	c->nr = 0;
 
 	for (cpu = 0; cpu < nr; cpu++) {
-		s1 = f(cpus, cpu, data);
+		s1 = f(cpu, data);
 		for (s2 = 0; s2 < c->nr; s2++) {
 			if (cpu_map__compare_aggr_cpu_id(s1, c->map[s2]))
 				break;
@@ -290,22 +290,22 @@ struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *da
 
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp)
 {
-	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket, NULL);
+	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket_aggr_by_cpu, NULL);
 }
 
 int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep)
 {
-	return cpu_map__build_map(cpus, diep, cpu_map__get_die, NULL);
+	return cpu_map__build_map(cpus, diep, cpu_map__get_die_aggr_by_cpu, NULL);
 }
 
 int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **corep)
 {
-	return cpu_map__build_map(cpus, corep, cpu_map__get_core, NULL);
+	return cpu_map__build_map(cpus, corep, cpu_map__get_core_aggr_by_cpu, NULL);
 }
 
 int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **numap)
 {
-	return cpu_map__build_map(cpus, numap, cpu_map__get_node, NULL);
+	return cpu_map__build_map(cpus, numap, cpu_map__get_node_aggr_by_cpu, NULL);
 }
 
 /* setup simple routines to easily access node numbers given a cpu number */
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index c62d67704425..9648816c4255 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -63,7 +63,7 @@ int cpu__max_present_cpu(void);
 int cpu__get_node(int cpu);
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
-		       struct aggr_cpu_id (*f)(struct perf_cpu_map *map, int cpu, void *data),
+		       struct aggr_cpu_id (*f)(int cpu, void *data),
 		       void *data);
 
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
-- 
2.34.1.307.g9b7440fafd-goog

