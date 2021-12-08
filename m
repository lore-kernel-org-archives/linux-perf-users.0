Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6C2C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 02:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243546AbhLHCuW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbhLHCuR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966BEC0617A2
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Dec 2021 18:46:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e131-20020a25d389000000b005fb5e6eb757so2017097ybf.22
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Dec 2021 18:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rTq2YskjpmXVXRfPu7O59kpDvN8VVeHIUZQ9nlJqsU4=;
        b=nUlEFDsP6fLKimtJIV4q+SFIqJLMqWEQ048ihlmwurraCkiFNybl4hHa7iWitlCw4a
         IyBAuOdNukFZ5fiNTly2wnn/rtBPQkwCtsdEnP+s4aivuKzUuOaSLgUGM/RlAu2K8svH
         S+ppK0vqWb73I0ga2AettVHio/n+HlJCU8etIRxjNPcX0y4UsZNcPRBn1PdUqNcndgTJ
         ysGFhb/2HttBGUJvU950o8paEg0m4YNQvXYqAANldOVL5sVjXuQaBDJ/80GP4/ZTkohN
         X0x77Po+QIEyugHoEzTYQFJoms/ZqXmQdsBZIWJo2RMDcOK0kPJKUvTHHVnH6z2GwpwS
         UWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rTq2YskjpmXVXRfPu7O59kpDvN8VVeHIUZQ9nlJqsU4=;
        b=hU03vHAOrPYhwAsg9ApIyc0kv+oDWVudBXUB0F1OQVkega9Iny4PSr+elCmsnzpUPB
         S02zZDKnYm+a1TYBzQF7UpOHlPiOWFZccl8xjkJ0uL6F0TeDU70KFV0XRNfT7i4qLzYL
         2iBh3l7eRyjUd8vKAvxolbKWenMeenijxsap5Y6H0IC2Ddcwl8TjTZBNLDaDdsNqMBFl
         ib/rrq4VSaIy5UcQ9V0C0fkYuC3znkAe62EVR20VI2rd+V/dmfhvebqHyivAHa0d92lN
         bdKvKu5HeDxqM6g8+AMzovNWT8by0FvpkZCViSPa+Rj4/EEN+PJx71rNCY2aVCFIdMJo
         KBuQ==
X-Gm-Message-State: AOAM532NWJrrSAo/5Gikt29oXAxHC//r1pFsMoDw/P0LOEVmnXOSNQJ3
        hnDJEsvNm+JzZFoznCoxadkrD4sn22up
X-Google-Smtp-Source: ABdhPJy/hokZEy+sBznkgBku3x531VQ30ZE5SCjzVyl6aTwPUvHtZ4Sk+7bEUVH1MIoOOrhhu9J7f6ciAPE5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a5b:c01:: with SMTP id f1mr54880603ybq.617.1638931605872;
 Tue, 07 Dec 2021 18:46:45 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:59 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-15-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 14/22] perf cpumap: Document cpu__get_node and remove
 redundant function
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

cpu_map__get_node_id isn't used externally and merely delegates to
cpu__get_node.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 11 +++++------
 tools/perf/util/cpumap.h |  5 ++++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index b3e1304aca0c..1626b0991408 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -16,6 +16,10 @@
 static int max_cpu_num;
 static int max_present_cpu_num;
 static int max_node_num;
+/**
+ * The numa node X as read from /sys/devices/system/node/nodeX indexed by the
+ * CPU number.
+ */
 static int *cpunode_map;
 
 static struct perf_cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
@@ -222,11 +226,6 @@ int cpu_map__get_core_id(int cpu)
 	return ret ?: value;
 }
 
-int cpu_map__get_node_id(int cpu)
-{
-	return cpu__get_node(cpu);
-}
-
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
 {
 	struct aggr_cpu_id id;
@@ -250,7 +249,7 @@ struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unu
 {
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
-	id.node = cpu_map__get_node_id(cpu);
+	id.node = cpu__get_node(cpu);
 	return id;
 }
 
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 9589b0001a28..f849f01c5860 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -45,7 +45,6 @@ int cpu_map__get_die_id(int cpu);
 struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
 int cpu_map__get_core_id(int cpu);
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
-int cpu_map__get_node_id(int cpu);
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp);
 int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep);
@@ -58,6 +57,10 @@ int cpu__setup_cpunode_map(void);
 int cpu__max_node(void);
 int cpu__max_cpu(void);
 int cpu__max_present_cpu(void);
+/**
+ * cpu__get_node - Returns the numa node X as read from
+ * /sys/devices/system/node/nodeX for the given CPU.
+ */
 int cpu__get_node(int cpu);
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
-- 
2.34.1.400.ga245620fadb-goog

