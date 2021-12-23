Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B6AC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347279AbhLWHsB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347142AbhLWHrL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31802C0617A1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t24-20020a252d18000000b005c225ae9e16so8617799ybt.15
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4fl4+/RnYjZ/c1n8ssVcVocIenEbnGshJWO17sTd1Uo=;
        b=oJfnWHmlynNBn19s9/HxQ1IK3WCOMXNxc7scb8vAYOYBizAcv9o6gqt8VqdYzDtnr9
         QljlK4aAp9ZJ6wHnEFE+wHnQEJgax6fbyNSRiXoXMnp3fdxKYbuOFB3tsUbPLAHwdv09
         UH6ahZ/BtFOvBp/9oAKJ7iNLsGXSpwH3K+nNRMfTfyiIAKSa2AbIPoyUU2G0JA30bfhO
         qRF0vfNwvNwh4XGqRc2shAkpVko8NMIOzTgm4GTLUms/OfNG8Wj5A5lAs4V7aFY2kFj1
         9NaVeAdM/eY304F8LTLkma1ZlpExQNsO1n+Wso+/AirzMTq0Q08KXvl22VIMPvmgu8Z1
         umTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4fl4+/RnYjZ/c1n8ssVcVocIenEbnGshJWO17sTd1Uo=;
        b=RXNky28eFEPt48XEDGM9gamqGNa3Fhy2fNLrC5p62cMZujxNdE140HtENJd+VxMQNO
         OPeM9m4GlmDBft3oM556j2YUDpRvjb3f52kDDPAgsKfFAMw1uFNV4R4j7tj0ci116Qqk
         HhbhoYZBisiworsYB4lqRBbuKWnh5aRQtP3hKn955boOZPS9O8VECURQLiNzQRORHoFs
         ZIr/4SAkDqnLJ7PYIIL30wXNCsE+nzF0ORXWYsybfRJU14TC3fStIqVmi2D4tFXPAzLN
         GOt0ip/BdaSk1OgKoiNX3ebPYGocix+P1bAeta2Ipwa/Z4L6T0DogUoLNlRSfTTXtOFj
         oemg==
X-Gm-Message-State: AOAM533pnUNFOsUWwI71eC79ghwL1w8+UjqKJ+l62tuasmHwhygKAGqG
        J5OJzsrCo+0ljSvwEcRgD66NStIaUWsg
X-Google-Smtp-Source: ABdhPJxeDyR4cL1775cPklXCUGbNUUrez4v3eL6JgYpB5hpzHlaMeypTbkzUhbIYH0sAg4bmvOd4T9kLv+ZI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a05:6902:706:: with SMTP id
 k6mr1788789ybt.643.1640245628437; Wed, 22 Dec 2021 23:47:08 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:17 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-25-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 24/48] perf cpumap: Add CPU to aggr_cpu_id
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

With no aggregration, such as 'perf stat -A', the aggr_cpu_id lacks a
way to describe per CPU aggregation and the core is set to the CPU in
places like print_counter_aggrdata in stat-display.c. Setting the core
to the CPU is undesirable as the CPU will exceed valid core values and
lead to confusion. Add a CPU variable to address this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/topology.c | 19 +++++++++++++++++++
 tools/perf/util/cpumap.c    | 23 ++++++++++++++++++++---
 tools/perf/util/cpumap.h    |  8 ++++++++
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index cb29ea7ec409..33e4cb81265c 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -119,6 +119,22 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 			 session->header.env.cpu[i].socket_id);
 	}
 
+	// Test that CPU ID contains socket, die, core and CPU
+	for (i = 0; i < map->nr; i++) {
+		id = aggr_cpu_id__cpu(perf_cpu_map__cpu(map, i), NULL);
+		TEST_ASSERT_VAL("Cpu map - CPU ID doesn't match", map->map[i] == id.cpu);
+
+		TEST_ASSERT_VAL("Cpu map - Core ID doesn't match",
+			session->header.env.cpu[map->map[i]].core_id == id.core);
+		TEST_ASSERT_VAL("Cpu map - Socket ID doesn't match",
+			session->header.env.cpu[map->map[i]].socket_id == id.socket);
+
+		TEST_ASSERT_VAL("Cpu map - Die ID doesn't match",
+			session->header.env.cpu[map->map[i]].die_id == id.die);
+		TEST_ASSERT_VAL("Cpu map - Node ID is set", id.node == -1);
+		TEST_ASSERT_VAL("Cpu map - Thread is set", id.thread == -1);
+	}
+
 	// Test that core ID contains socket, die and core
 	for (i = 0; i < map->nr; i++) {
 		id = aggr_cpu_id__core(perf_cpu_map__cpu(map, i), NULL);
@@ -145,6 +161,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Die map - Core is set", id.core == -1);
+		TEST_ASSERT_VAL("Die map - CPU is set", id.cpu == -1);
 		TEST_ASSERT_VAL("Die map - Thread is set", id.thread == -1);
 	}
 
@@ -157,6 +174,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Socket map - Die ID is set", id.die == -1);
 		TEST_ASSERT_VAL("Socket map - Core is set", id.core == -1);
+		TEST_ASSERT_VAL("Socket map - CPU is set", id.cpu == -1);
 		TEST_ASSERT_VAL("Socket map - Thread is set", id.thread == -1);
 	}
 
@@ -168,6 +186,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Node map - Socket is set", id.socket == -1);
 		TEST_ASSERT_VAL("Node map - Die ID is set", id.die == -1);
 		TEST_ASSERT_VAL("Node map - Core is set", id.core == -1);
+		TEST_ASSERT_VAL("Node map - CPU is set", id.cpu == -1);
 		TEST_ASSERT_VAL("Node map - Thread is set", id.thread == -1);
 	}
 	perf_session__delete(session);
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 985c87f1f1ca..a535fd360d46 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -253,6 +253,20 @@ struct aggr_cpu_id aggr_cpu_id__core(int cpu, void *data)
 
 }
 
+struct aggr_cpu_id aggr_cpu_id__cpu(int cpu, void *data)
+{
+	struct aggr_cpu_id id;
+
+	/* aggr_cpu_id__die returns a struct with socket and die set*/
+	id = aggr_cpu_id__core(cpu, data);
+	if (aggr_cpu_id__is_empty(&id))
+		return id;
+
+	id.cpu = cpu;
+	return id;
+
+}
+
 struct aggr_cpu_id aggr_cpu_id__node(int cpu, void *data __maybe_unused)
 {
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
@@ -576,7 +590,8 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b
 		a->node == b->node &&
 		a->socket == b->socket &&
 		a->die == b->die &&
-		a->core == b->core;
+		a->core == b->core &&
+		a->cpu == b->cpu;
 }
 
 bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
@@ -585,7 +600,8 @@ bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
 		a->node == -1 &&
 		a->socket == -1 &&
 		a->die == -1 &&
-		a->core == -1;
+		a->core == -1 &&
+		a->cpu == -1;
 }
 
 struct aggr_cpu_id aggr_cpu_id__empty(void)
@@ -595,7 +611,8 @@ struct aggr_cpu_id aggr_cpu_id__empty(void)
 		.node = -1,
 		.socket = -1,
 		.die = -1,
-		.core = -1
+		.core = -1,
+		.cpu = -1
 	};
 	return ret;
 }
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 8acef8ff8753..651c6417d3c3 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -22,6 +22,8 @@ struct aggr_cpu_id {
 	int die;
 	/** The core id as read from /sys/devices/system/cpu/cpuX/topology/core_id. */
 	int core;
+	/** CPU aggregation, note there is one CPU for each SMT thread. */
+	int cpu;
 };
 
 /** A collection of aggr_cpu_id values, the "built" version is sorted and uniqued. */
@@ -109,6 +111,12 @@ struct aggr_cpu_id aggr_cpu_id__die(int cpu, void *data);
  * compatible with aggr_cpu_id_get_t.
  */
 struct aggr_cpu_id aggr_cpu_id__core(int cpu, void *data);
+/**
+ * aggr_cpu_id__core - Create an aggr_cpu_id with the cpu, core, die and socket
+ * populated with the cpu, core, die and socket for cpu. The function signature
+ * is compatible with aggr_cpu_id_get_t.
+ */
+struct aggr_cpu_id aggr_cpu_id__cpu(int cpu, void *data);
 /**
  * aggr_cpu_id__node - Create an aggr_cpu_id with the numa node populated for
  * cpu. The function signature is compatible with aggr_cpu_id_get_t.
-- 
2.34.1.307.g9b7440fafd-goog

