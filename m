Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6895DC19F20
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 22:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjEBW6m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 18:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjEBW6j (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 18:58:39 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A323D10E7
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 15:58:13 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-19259b178dfso1925009fac.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 15:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683068261; x=1685660261;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMun7Fi9IhPa9JZ/I5pL4DGzuErIcYuCD85NRlCGuw4=;
        b=Naq4J1fjybcZBMtFsJmPsGOueqTj69KuJwGa9O4Ib97Jo026zMwj6u9Mjwb22x3dCI
         1PwWuEb65gu/Pk2PQBaim1QUR7cKzas+JVqJjFshm/8+9t+siRo6421OT11lJdUM/Ft2
         YK0BkLLmQ9p3XIaOSJ/3i16xgPJimnc43lTKx1PTlf5v2ud4Wo3/+SPgvEV69xhGiGe3
         uUg4neIxuVQ0OvbplAw12MGoh9cioauV6XTrWOYpM6uzK/hR7Ht17iMGMQs2A48xej0d
         bI84r07ZsQYpb102R2nmNZtuoqVLLp4Fdjjq/dcFbiq7XosSateWzNlPG2KFJkTDjgd4
         oYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683068261; x=1685660261;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMun7Fi9IhPa9JZ/I5pL4DGzuErIcYuCD85NRlCGuw4=;
        b=EoZxTvirHsqwbIugLDBxUt7Iy9EA5RQ5tnTRpuYqlowk2UmPI/JzkxLTSyIQuUeRTo
         yiV2VWC2meZH13yxNvyjw6ybHcMuMjKD9oaaNmZz2jHKhu4dpLXLEbYI8LFbxvxXy6jn
         JXnv2d4c2YNJa4jab88YlS0ufWpbDU3TyTqPvYdJZH8xB/+ukDv53SGhotvVVPwsLsKc
         DRyCiGNQqSOqh2x9Z1t58T4WRfWJ6gGBD9FnFCztN1ytCLQRywcbrjWYjlSJTlAHNB4n
         WT7HwQe/6vS+uoershbBmZPiVfOCJ/g6nUV6FBl4BJQ7MSq+TADuGpZoVpiBtUfGEv2k
         x3YQ==
X-Gm-Message-State: AC+VfDz5RgMHMRhpLfKcyMfpuUx+kulf2EhqoEmHTJFQKu9I/G6yqp4k
        kFqu8niKuVUHbEhtxsYuPnWHdZbITwpU
X-Google-Smtp-Source: ACHHUZ4lWGFd17WAQ+n3PFZEKj9tszZE7ynjvyLhtJMqHopAzrTcHJhP7ll2IAKwdDa1NwdvXrd82SqUeQRc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c4:b0:b99:45a4:3f96 with SMTP
 id ck4-20020a05690218c400b00b9945a43f96mr7961851ybb.5.1683067410339; Tue, 02
 May 2023 15:43:30 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:43 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-37-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 36/44] perf parse-events: Don't auto merge hybrid wildcard events
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Bring back the behavior of not auto-merging hybrid events by
delegating to a test in pmu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 5 ++++-
 tools/perf/util/parse-events.y | 4 +++-
 tools/perf/util/pmu.c          | 5 +++++
 tools/perf/util/pmu.h          | 1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5d5d77fa398b..2dad88a6bf19 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1714,16 +1714,19 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		struct perf_pmu_alias *alias;
+		bool auto_merge_stats;
 
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
 
+		auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
+
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			if (!strcasecmp(alias->name, str)) {
 				parse_events_copy_term_list(head, &orig_head);
 				if (!parse_events_add_pmu(parse_state, list,
 							  pmu->name, orig_head,
-							  /*auto_merge_stats=*/true)) {
+							  auto_merge_stats)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
 					ok++;
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f4ee03b5976b..4e1f5de35be8 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -327,10 +327,12 @@ PE_NAME opt_pmu_config
 				name += 7;
 			if (!perf_pmu__match(pattern, name, $1) ||
 			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
+				bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
+
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					CLEANUP_YYABORT;
 				if (!parse_events_add_pmu(parse_state, list, pmu->name, terms,
-							  /*auto_merge_stats=*/true)) {
+							  auto_merge_stats)) {
 					ok++;
 					parse_state->wild_card_pmus = true;
 				}
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index cd4247a379d4..f4f0afbc391c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1660,6 +1660,11 @@ bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu)
 	return is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
 }
 
+bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
+{
+	return !perf_pmu__is_hybrid(pmu->name);
+}
+
 static bool pmu_alias_is_duplicate(struct sevent *alias_a,
 				   struct sevent *alias_b)
 {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5a19536a5449..0e0cb6283594 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -222,6 +222,7 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 bool is_pmu_core(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
 bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu);
+bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
 void print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool pmu_have_event(const char *pname, const char *name);
 
-- 
2.40.1.495.gc816e09b53d-goog

