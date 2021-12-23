Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E1C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346994AbhLWHqf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346985AbhLWHqb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD8AC061756
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:46:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p133-20020a255b8b000000b006086e19f89fso8555057ybb.19
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MCK3PXHKxnJ+ljXLSZiTWLvHtcXTKUfApdV6xTysANE=;
        b=KBqN6r7LevbIJ7DspJ9ZQuQ1H8mJQaV3PHwKSOvqliRrH0SmzqfHG43ZeW1Kd+mKpu
         8wcjrP78XSYonUw1hZvvoIexqKj5cAjqs3aaFZYqsFj6YtS7sUzKdMxWb5EOiA5IR9UY
         AJ1Lw56EryjZ0NDW58jhV2uGdg3izc2DVHPMEYeUBMG8Ku66IwtNaC9/l7EeMLSYyhFl
         6rvnc8+k6SXJmoWrCsmV7QnzkXXVeaO/hescaBe+W4Pq/nZAn7Z/CZrc138Kf7KZpBYS
         YI4ExYTI78g7QbmaMcGZ8vmbKe9gim6Mr2b01f8usfTgCMnPiUMgKAhNk2nxrPBAkg1a
         jLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MCK3PXHKxnJ+ljXLSZiTWLvHtcXTKUfApdV6xTysANE=;
        b=Pra7YJTdwZuAxhUv2MQaAaifdVJIPtsZE22lulZeovsNIKpgTQ+nFns2T+N1DFKetC
         VmoMvH1Ory2sO7BCha7+GZrfGyNbilo/BNw7sTDnddB872ehezvQN5OjXPqqbVcrcOcR
         9fS7wdvCssJwJOld4gkwA1mITwTgv2avuZXfjFpYD7h5lq4OhZcxfUYlixAb+CwXxntv
         8NCsDrRsSdI3JyXM1YvaZ7DJgCYO9a1zEDMM9lr/Ce6e0FLrAqPcXw+pznjev17gqL4n
         fOykICr5Tp+SXTf5uoYflZbVg2GPp3EPX64gRsrhq1469AiOiiN5mMPR9iWqo90sEpF0
         MChQ==
X-Gm-Message-State: AOAM531g2ILdyiMe4xUhsP+e8FZX7GOnkIS1C4KsjEA91oSKnPRM+9la
        kwsrMZweXsESkwCWCpM1ES74ecN6lxac
X-Google-Smtp-Source: ABdhPJy8YqT1jzES8T/J1ThGT2eMjmeaj38Tu5Uwrk0WsTJnid8jvKkoKLBXCSeX8B6vtH3kyibTDWhBeHuL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a5b:c8d:: with SMTP id i13mr1771035ybq.354.1640245590498;
 Wed, 22 Dec 2021 23:46:30 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:02 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-10-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 09/48] perf cpumap: Remove map+index get_core
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

Reviewed-by: James Clark <james.clark@arm.com>
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
2.34.1.307.g9b7440fafd-goog

