Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CA4C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbhLWHtC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347193AbhLWHsP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:48:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30228C06175C
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so8659208ybe.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=84jiul3eS69fZOps8gyBR2xeuwa8naIlTNqvP/j/8xA=;
        b=eWvVaORPbPCnckO/NmOe+ry/whk3ae7kUZNUzcG+mrlyrUmZJAMUJzjb+aMMLos9VA
         3aF8p1UpAPuuUehAL4NI9mLMLA2AT7CimKeCxG1bJ4r8NrvH/Ag9dpRdUNMYOUpNz+NZ
         MDT7urMFaz5qbPYzLQUHQp1Nu3Dru8+RHWWE2nLNsuUxnBeAYtXxe5LgRY4izM2LoEQg
         +P+jY5XIjXuKW6r6/skwTDr3uoDZkiUCDd5RuCCqaGrh4QLQCEqGxXR3v0+3f6qvKYIH
         GMJmHEiZuL3CtVbNK2buWxV2fNimLbiDIbZ8hJcT+XyNiIhX/Y9qlYd2VOYotU5TM/t1
         Vjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=84jiul3eS69fZOps8gyBR2xeuwa8naIlTNqvP/j/8xA=;
        b=7Erx/aQQ1UyWJSUHeYgLEOMOFvk4hL5wJ44iv8ZI2lmi734XanOUO8y3kB275ezKXM
         eoDG+8gmoGuGE9VJ/T+8+8Nho+iEAOH7s+mjlZ/Ik5fVM+Jt23ygp2nAEEqsYVxA8p99
         b6qCnUBYSUkxDw00qkZKcjmgBHsEH1c1zs92HFQXR+hMKHcX82LKDhSpjtWkMIUtynU6
         4ol1r0YmHL+Exbkao1OZtlFnPNcLnVMicpdx3Hs2MynxCCMuxuVLYrwfd+csGCjT/lNL
         25KvlyCEYWCxtnaV6veecUh//chVsUrWCK7Ca1zczCtNodhG1fOr29VvU1GW5LZKfbQl
         77lg==
X-Gm-Message-State: AOAM5332/tR5VRT/7EDmj1YfXSK9ImTuW6hyUlObZST3nI4j/VtvFktQ
        1x/cSsjNhxT67VOp8ypx3M7zp56+WwZP
X-Google-Smtp-Source: ABdhPJxhU524UVDy65p+6AJP7nFi0/17OcNMoh/MQicxFL+nsP8RdWqJqC3cARe3QImikhkZrwzBUDdJOmI/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:13c6:: with SMTP id
 189mr1675596ybt.113.1640245672380; Wed, 22 Dec 2021 23:47:52 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:34 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-42-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 41/48] perf stat: Correct check_per_pkg cpu
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

Code was incorrectly using the cpu map index as the CPU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index f7f9757eba23..86ab427e87fc 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -292,11 +292,12 @@ static bool pkg_id_equal(const void *__key1, const void *__key2,
 	return *key1 == *key2;
 }
 
-static int check_per_pkg(struct evsel *counter,
-			 struct perf_counts_values *vals, int cpu, bool *skip)
+static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
+			 int cpu_map_idx, bool *skip)
 {
 	struct hashmap *mask = counter->per_pkg_mask;
 	struct perf_cpu_map *cpus = evsel__cpus(counter);
+	int cpu = perf_cpu_map__cpu(cpus, cpu_map_idx);
 	int s, d, ret = 0;
 	uint64_t *key;
 
-- 
2.34.1.307.g9b7440fafd-goog

