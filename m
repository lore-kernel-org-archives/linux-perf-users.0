Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3C6C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347038AbhLWHrv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347108AbhLWHrD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF7FC061799
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s189-20020a252cc6000000b005c1f206d91eso8635402ybs.14
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jkb8WQdF9O+yiT4urJzPw184L/fpHPkSKVmnEzvHNI4=;
        b=cjmUrPorOPwMSR8Clp9D3BUztfdQynd9f+mTH9gfaUFdKwgXLjEpecPhtWm10pTf95
         kUko6md3ZhP8VUeVp+cOBc0Jy7VYksiU+XwG9bEZJZwyYpL5+WlBI25m6x8I0AoE7YBy
         /5hIfsd9OEg5Sd6a2fM8L2GTWOy0Qy3BrRE2imlAsxGVpL2bAMTuwSXqDv6IBpjLDw28
         Cih2qQTG3eSXRCzQsGWh/12JzeNtpxdPyM8wv8uXQza4zo9nnDbamcbPPwJEiqNLD2q9
         b6L5BCdYsBLbBj+19qoSMjTDstctOdLIIZKT6surEGtmeqFG6rPdV/KQvv303T+YxZTW
         YSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jkb8WQdF9O+yiT4urJzPw184L/fpHPkSKVmnEzvHNI4=;
        b=We4J97Q3ILBD74oMwF/WJkOlak77PsIFHRPzs1owkSEnjVVh+yk3l0SFLdG9L6gC8d
         ySsnGbfJ9yIgpXDxMbR9rTdKHChzRbDBIFV9t/Cn84NQXABixCslNhdvFIaN3X60wFL/
         0I+LNEK+r/UGWm/bAZ0XpchQD4Q0BkkULeyQvRptDCezcrxiTgccjaUkXwbappiY74jU
         5c+Poqeh0yii7V4C/4mX/pDUz7cbPvyJKsCt0OHra6OwyiWUNS8WEIH2XyjfwOUJlD1f
         ZOR+xQeqHxKznAaX6nrQUeHr81jRhIOZYz7a9f4tTj5EjdViRtPQ1dyYWtbmd7kiDaz5
         /Tyg==
X-Gm-Message-State: AOAM532TdJ4IadLcojdQ7pFAKCADO2Rl0k1SCk1IgONZpntYHszez/lZ
        udbtx0WBenUdG/pnSygNuJFjATh+llg8
X-Google-Smtp-Source: ABdhPJzRHzlckq6o8uuyeTGVvKZ4mtq8Xw/HKmt9jKvhxGET/afj05hc3jdaQ7vdvPJiKVhC3up45BXHd1bO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:d492:: with SMTP id
 m140mr1874549ybf.105.1640245620849; Wed, 22 Dec 2021 23:47:00 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:14 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-22-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 21/48] perf cpumap: Add some comments to cpu_aggr_map
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

Move cpu_aggr_map__empty_new to be with other cpu_aggr_map function.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 832fc53f3c11..8acef8ff8753 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -24,16 +24,18 @@ struct aggr_cpu_id {
 	int core;
 };
 
+/** A collection of aggr_cpu_id values, the "built" version is sorted and uniqued. */
 struct cpu_aggr_map {
 	refcount_t refcnt;
+	/** Number of valid entries. */
 	int nr;
+	/** The entries. */
 	struct aggr_cpu_id map[];
 };
 
 struct perf_record_cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
-struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
 
 struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
@@ -67,6 +69,12 @@ int cpu__get_die_id(int cpu);
  */
 int cpu__get_core_id(int cpu);
 
+/**
+ * cpu_aggr_map__empty_new - Create a cpu_aggr_map of size nr with every entry
+ * being empty.
+ */
+struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
+
 typedef struct aggr_cpu_id (*aggr_cpu_id_get_t)(int cpu, void *data);
 
 /**
-- 
2.34.1.307.g9b7440fafd-goog

