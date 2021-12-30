Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684F5C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhL3HVF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbhL3HVA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35C1C061756
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:20:59 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s83-20020a255e56000000b0060c46cc1890so21972593ybb.16
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I+B8qrA2cd/SP8Q+1EIjfviQAYs+Z/hoSScOqv9Gel0=;
        b=lCkRWKAn7Fa+jfz0d4hgkdKJv2mjjGswz+NBQBUOuRSoCdOBKJbyl3sEvCZH9S50rw
         PS4AVhK6dZ8fNZf57BsBrrGwEHk5IejbHwTK9PDcvy3qbM59VWWBOlAyxBkEbBUKzLwa
         JjQDd3iq9sNkIsH9g5Umm4CJ8rbSoehVuzGnUJIKTvNjp2GOCjWXCD91TgzHAIjaF5vc
         EuRtkvY2PYQ9GkbyJya3wkcWUDL0iLHN/fbnenkRx8SME6nB7Ga7R3Hu0eZPb1CFRiUU
         muh9+6RsbFN3cziMaL4lHVrztq3YFrdODhj7VSBN0UZ8Ufjj7wLpanYnbAtheK9k7dfM
         65Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I+B8qrA2cd/SP8Q+1EIjfviQAYs+Z/hoSScOqv9Gel0=;
        b=FkFWQN8ez3+b0LPlqdnyoDFbotDVKDDlpqFVe1L64gSU1jgkiYk6LLViGssyRJZFJk
         yj7768v/zFJsyWC09c+1l9zblLluc5xIjoXFFXjRjgQ2hEV67Q7nLQ6hx50kCqnmdNAJ
         G1BfQ7+QhJbyMvBjX5OfGYt1CdDOvtPQJTS/xQnv4JLTmQ9oZ3ThOlL//uN8WgohzBgg
         /fjY7HLfwMpGnvfwLolG9mwkpVuKF1WAO14oxaG+Gi0bDZN9W/M1lmYfaob7RruyxkVq
         Vin7vAhUk0zUWezv2NkF8FVkx/R8lHCzdCLAS39AZ8cwnjGKJIERuvyonRVZ2HgL5fzY
         BnKA==
X-Gm-Message-State: AOAM531CvRf9Mlx4PUSGu/R7Rks8hOP0NbilrczRLk8LM81isKTZlDe3
        EbR8/NaX7LlknssZ8FNb0zv6bumHmUoY
X-Google-Smtp-Source: ABdhPJwyOytQjn1OiPL02zTtOTw3G5TCU33Bkd3QWN2ohtlxmVv02HGZDXzkKLx1KZIDhEkQYV0+4Ot4P8+n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:2d6:: with SMTP id 205mr28389439ybc.425.1640848858996;
 Wed, 29 Dec 2021 23:20:58 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:50 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-10-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 08/48] perf cpumap: Remove map+index get_die
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

Migrate final users to appropriate cpu variant.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/topology.c | 2 +-
 tools/perf/util/cpumap.c    | 9 ---------
 tools/perf/util/cpumap.h    | 1 -
 tools/perf/util/stat.c      | 2 +-
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 69a64074b897..ce085b6f379b 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -136,7 +136,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 	// Test that die ID contains socket and die
 	for (i = 0; i < map->nr; i++) {
-		id = cpu_map__get_die(map, i, NULL);
+		id = cpu_map__get_die_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Die map - Socket ID doesn't match",
 			session->header.env.cpu[map->map[i]].socket_id == id.socket);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 342a5eaee9d3..ff91c32da688 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -216,15 +216,6 @@ struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx,
-				    void *data)
-{
-	if (idx < 0 || idx > map->nr)
-		return cpu_map__empty_aggr_cpu_id();
-
-	return cpu_map__get_die_aggr_by_cpu(map->map[idx], data);
-}
-
 int cpu_map__get_core_id(int cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index a53af24301d2..365ed69699e1 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -34,7 +34,6 @@ int cpu_map__get_socket_id(int cpu);
 struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data);
 int cpu_map__get_die_id(int cpu);
 struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
-struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_core_id(int cpu);
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 9eca1111fa52..5ed99bcfe91e 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -336,7 +336,7 @@ static int check_per_pkg(struct evsel *counter,
 	 * On multi-die system, die_id > 0. On no-die system, die_id = 0.
 	 * We use hashmap(socket, die) to check the used socket+die pair.
 	 */
-	d = cpu_map__get_die(cpus, cpu, NULL).die;
+	d = cpu_map__get_die_id(cpu);
 	if (d < 0)
 		return -1;
 
-- 
2.34.1.448.ga2b2bfdf31-goog

