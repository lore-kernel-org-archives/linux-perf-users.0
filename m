Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C69C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 02:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243535AbhLHCuG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243496AbhLHCuD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427A2C061748
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Dec 2021 18:46:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so2146730ybj.5
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Dec 2021 18:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lKBQG/Ekkw/zKMpNY4MQJOhhYYASHe86aRRC9ME9N9k=;
        b=aysr4FYgggWLSG32lc1Zp1tFA9jVrWtq358PSTl96X35cwBdCkeHdnOryUFja9ei/4
         2Rba7HFiyhciodoYpj45ttiKRNQ9AuWc33q3AZkHOISWQdr0EQSw8gZOAI9X06pjEDwy
         D03L0FeIAAyOIXjLe80E6is2peRU0uzmcvg0zgKqkZdxm2AjGDiJIWwY6f0tJQ+gCGor
         5pEK8xnb9cUazVWT1gMj3Vxltt5xwhO2+zT7xFADISLFJfM/xEWkQH6UECpfEbWkoOwi
         0E++J3D3k0LejRGvNj9mI3HjjXDZLVOtGe13LPjYHIuDLf9UGSEAJ2ZFgFEWYJSO20Um
         E1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lKBQG/Ekkw/zKMpNY4MQJOhhYYASHe86aRRC9ME9N9k=;
        b=2pXsJAkIszNrKHEeLb6uVy+5iJhaNUyV72ASHOcXKibx35E0TzmbbF+D8v8kYtfkTB
         pt2Aklxk7UiaSnOgpchOHI+smn2qkcezHOYt3cCPTSPDirJ27Vp4bxo4HFK2vITeTpsu
         T768cb7dpYBwhwNEqJkknHBm65rKXLXUNFyqU8E0JS97C7lDjuRYJf2k3yQ2zNGQ6z+a
         8USBkvI587HELAc4qJE4bVql/w4vnNodke23dQYyhUtPGQANniJxdckiuB/0q3kb7MYc
         4GnnzzWQTQv9KWikif4e3LKjqVDx3yc6CZcry7kvnuBhZ+ZrQzaA4hkhj+AWRThJPSUn
         l2pw==
X-Gm-Message-State: AOAM532yVQH95qaptC0kslOTHUR+OPV14Zg+vNInuiio5MC72XuPEKSq
        cF8TFquJxmdx0ca+IbxJ646X8viK1NUw
X-Google-Smtp-Source: ABdhPJxLLNVszM6T/IPq3l6FGOk35N8B7s6un2gBi94tscNLoFZILaKoxoawKi35Fmu8gWPVG3XQhbNLlpaO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:2395:: with SMTP id
 j143mr54883725ybj.415.1638931591458; Tue, 07 Dec 2021 18:46:31 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:53 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-9-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 08/22] perf cpumap: Remove map+index get_core
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
index ce085b6f379b..9a671670415a 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -121,7 +121,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 	// Test that core ID contains socket, die and core
 	for (i = 0; i < map->nr; i++) {
-		id = cpu_map__get_core(map, i, NULL);
+		id = cpu_map__get_core_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Core map - Core ID doesn't match",
 			session->header.env.cpu[map->map[i]].core_id == id.core);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index ff91c32da688..e8149bcf8bfa 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -246,14 +246,6 @@ struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
 
 }
 
-struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
-{
-	if (idx < 0 || idx > map->nr)
-		return cpu_map__empty_aggr_cpu_id();
-
-	return cpu_map__get_core_aggr_by_cpu(map->map[idx], data);
-}
-
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unused)
 {
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 365ed69699e1..7e1829468bd6 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -36,7 +36,6 @@ int cpu_map__get_die_id(int cpu);
 struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
 int cpu_map__get_core_id(int cpu);
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
-struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_node_id(int cpu);
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data);
-- 
2.34.1.400.ga245620fadb-goog

