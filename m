Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DE1C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 02:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243445AbhLHCuN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243483AbhLHCuG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:06 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72D1C061D60
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Dec 2021 18:46:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l145-20020a25cc97000000b005c5d04a1d52so1999423ybf.23
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Dec 2021 18:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qCcWQm7ULaKXv7EpzsJ1qS6IpbWkCU7LdRBfAG0kAPA=;
        b=JUhamctQ3qrTiZdiWXm5rjzzvF8rm6K1KVWWRTXCag/Q0GDX/jFOeNsLlZzhHsg+WT
         p3mANoXaz7q/TQ33ddEokLt/q38PFyB7fCaYRRrjcIWWvCtlMEOYgsHKPTvqL4K9lWaM
         cX0QHNFyW6grElO0zbPUlAQhtZeL2Kc4OsDAj37JEqB17zz9PyvLXgZ2zg4apR2X8UzD
         6e4COJT7/wAfrwVucscPyGa6LM3Z9KYDzAsB6W/poNnF+SjTUNIdhq8IXIO0UlqLLNKR
         FXbpB3lXunf7xuFzDxsPwFUci+z8Pmrq+gAS+5yOVhQ/T8hTrO/GB8s5R8iHl81J7Gab
         bcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qCcWQm7ULaKXv7EpzsJ1qS6IpbWkCU7LdRBfAG0kAPA=;
        b=Pp1oRS/Z+vbLaprhydycI4LHrie6v30yUFEdHD/NzcA/LL8NPgC+tIVh06jwGkOmxi
         /ThS9UWNLW+xDvuoFwzDupw21UlYaAC6xTvKKrAR6jEXcyGcnBlaE8+GfbqpMfcr+/eA
         ow7maWZoA8uEU5bAZ0RaoHKC0MnBnePZ9TLmyv9oVlptNcxll9kbJUwn+VyMijIebVl7
         UZB70yJvbcXNVjGUNBk0fj7fMwIPU+3G40R/I2V7wsWt8rMI66q7fo+VomSay7JmqrY7
         D0rOTBuiML40QTFD5WlPi1kSCP64nxSWM9gCojwEYpaMWglivxuVTl+NrYB8C7J2KgCL
         8fug==
X-Gm-Message-State: AOAM532gcJEjOs/XFO0+BK7Ouj4DOScQeAznc1KDqztuVSc7l6rviyPX
        +eSxnCf5LheBC5qTwfQLljn/WZC5Wuor
X-Google-Smtp-Source: ABdhPJycwV1Bbk3HYBtPNArxi0kiGj/djJFIS15dtHWtRyLPYZF7FzfNjhe/Rc2CC66KvaGLeMWzFNKsh7AH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a05:6902:709:: with SMTP id
 k9mr18161708ybt.222.1638931593911; Tue, 07 Dec 2021 18:46:33 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:54 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-10-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 09/22] perf cpumap: Remove map+index get_node
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

Migrate final users to appropriate cpu variant.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/topology.c | 2 +-
 tools/perf/util/cpumap.c    | 8 --------
 tools/perf/util/cpumap.h    | 1 -
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 9a671670415a..5992b323c4f5 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -162,7 +162,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 	// Test that node ID contains only node
 	for (i = 0; i < map->nr; i++) {
-		id = cpu_map__get_node(map, i, NULL);
+		id = cpu_map__get_node_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Node map - Node ID doesn't match",
 			cpu__get_node(map->map[i]) == id.node);
 		TEST_ASSERT_VAL("Node map - Socket is set", id.socket == -1);
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index e8149bcf8bfa..f67b2e7aac13 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -254,14 +254,6 @@ struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unu
 	return id;
 }
 
-struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data)
-{
-	if (idx < 0 || idx >= map->nr)
-		return cpu_map__empty_aggr_cpu_id();
-
-	return cpu_map__get_node_aggr_by_cpu(map->map[idx], data);
-}
-
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp)
 {
 	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket_aggr_by_cpu, NULL);
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 7e1829468bd6..f0121dd4fdcb 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -38,7 +38,6 @@ int cpu_map__get_core_id(int cpu);
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
 int cpu_map__get_node_id(int cpu);
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
-struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp);
 int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep);
 int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **corep);
-- 
2.34.1.400.ga245620fadb-goog

