Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D509EC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 02:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbhLHCuA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbhLHCt6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Dec 2021 21:49:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46378C061A32
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Dec 2021 18:46:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so2168572ybj.2
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Dec 2021 18:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PpkGjAiD9Pmgxn49wBUdltRtlg09Ht80vguCmSdr564=;
        b=bsO1/BZY715fnD+OpzLRRRLLq+1Qkd/M0Xht4yQ/MxVcTs2Bh1E8mXbJ9PyQ+cMAgP
         SyagxJP4dEj1r9/723wMxvgRNQdbkCT/qnqDpHDk2e2kD2wopTmMemeioX5yY/WdW5nV
         LnDRjfYmgJhnYjWZK1PvHi0STgA2Zm5cV7K3MRKo/k3IV1+SmrV8atV4cQ8LujhpZWxB
         5lV4i//hh7XeN1Hy9brrc/HBeEd6YSMjBr2/kgT63eXVocBws03o82mrA3+EmuRKLgJ+
         A615t1HWG7FoUxyivnL6cljdngV5VRpLCNTHST4h5rWd9mSeAo+KjlSk549sajZbaYrR
         5z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PpkGjAiD9Pmgxn49wBUdltRtlg09Ht80vguCmSdr564=;
        b=ngU1yUL2q7tBZDREykZ1780gWubJIAVgmH1oDyrueeDDEfJG+6sfFt6sJgRH6/4+/y
         XP56ab8fiKbEX2VxZYKGbNOJ8HIA+joZOVeU+Ca4aLKFH/1yR4zHG5UHUil98ET8Njnl
         ni4OYC0y8ip6pSTF6XXT4x7BCoN1axXCC/WnrnIWyjZzMAACNwSn+bp7ewI/CJFgDA7N
         Bid1TJGqTBcA8R4F5HNdH5p06smJ6qRQj5AnVM08eF0OrjIEWs5/MNUQuQNs3FGtuQJz
         /+OWx8IUB4t1037AVAXs4GkDV5dbdK0yzEAB9Nkozb0cHgp/JASSzY85L2tec6PKfhVS
         3GSA==
X-Gm-Message-State: AOAM5316j3CB9s8wXT6vZsupp9lK737+gI7TwDpgOsXWBGYEbs9dNqxP
        DbEODd1hSkTIiYGks0Af56GUjlONhxpU
X-Google-Smtp-Source: ABdhPJwRmlwXDMukk/OYba0wtfwfmmVyY39c1bnnpqA5sfA+W/TjhAXx8fflfpjQkKYAjg6Ahw88I/fRGCH/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:1c5:: with SMTP id 188mr55479456ybb.292.1638931586429;
 Tue, 07 Dec 2021 18:46:26 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:51 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-7-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 06/22] perf cpumap: Remove map+index get_socket
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
 tools/perf/util/cpumap.c    | 9 ---------
 tools/perf/util/cpumap.h    | 1 -
 tools/perf/util/stat.c      | 2 +-
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 869986139146..69a64074b897 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -150,7 +150,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 	// Test that socket ID contains only socket
 	for (i = 0; i < map->nr; i++) {
-		id = cpu_map__get_socket(map, i, NULL);
+		id = cpu_map__get_socket_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
 			session->header.env.cpu[map->map[i]].socket_id == id.socket);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index feaf34b25efc..342a5eaee9d3 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -136,15 +136,6 @@ struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_u
 	return id;
 }
 
-struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
-				       void *data)
-{
-	if (idx < 0 || idx > map->nr)
-		return cpu_map__empty_aggr_cpu_id();
-
-	return cpu_map__get_socket_aggr_by_cpu(map->map[idx], data);
-}
-
 static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 {
 	struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 9648816c4255..a53af24301d2 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -32,7 +32,6 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
 int cpu_map__get_socket_id(int cpu);
 struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data);
-struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_die_id(int cpu);
 struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 09ea334586f2..9eca1111fa52 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -328,7 +328,7 @@ static int check_per_pkg(struct evsel *counter,
 	if (!(vals->run && vals->ena))
 		return 0;
 
-	s = cpu_map__get_socket(cpus, cpu, NULL).socket;
+	s = cpu_map__get_socket_id(cpu);
 	if (s < 0)
 		return -1;
 
-- 
2.34.1.400.ga245620fadb-goog

