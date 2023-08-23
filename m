Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C27EE49A0
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 08:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjHWIMB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjHWIKp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 04:10:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301B4170E
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:09:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58caf216c55so119035147b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778144; x=1693382944;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PD4Z1HSbPqI+PYDaeSuUcOyp8wCv3Hn6s79y+f2o9yA=;
        b=5Swm+ynQycOaHY2H3lvYnF5DCgbMCPp2Sv3OWE7qagiXgBCCe1boVE0WGq7nxQvXzj
         CNn4/Mi646rmZ5jdcfeOMnz+GzOD0RfaQplNuvosFY19OtuHo7JH5+Pq04S0x+QGfoOx
         /t8MT1BODTjIZnhFR0tnqucNCgXv3Jgfti30qWbWtnItV99BuNvd2QROwAFv/1tpd2fS
         hMriiLHHyevQS4UxahO9SboMcaXdyk3PQ888uvXfQZkEJvoDIcF0CrJI1q2KLudzmavK
         hAmsz7IFjIa8bltOi8moEOm6mZiloDrrYmYjgqUj+ExFzlL52mxHv5xKy77xXeYxoOAN
         qIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778144; x=1693382944;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PD4Z1HSbPqI+PYDaeSuUcOyp8wCv3Hn6s79y+f2o9yA=;
        b=NNY1qAr7IUiw+Rn2wYSJvedmmHKdChr1TgQEhLiBtbLHjKXYyVO+bZgMQb/wUn57l6
         d34iF27EVxSEuOSY1OSoRkCR2HZ/YatnF8iHn01eqVVZCnkYC+gGokgcE4j9jsLZYY5S
         KdLaNqrR++er6RGSjWFYjWXlqrTBpJICroI4NFxchsDmE6RxerZ12xxx684sCAOsnNaz
         fi0zcBKX0EnHqfPPZmvJJ9PBPr7DGF57E3NfUryodCmlDvGTO1M+4aTffQKVZztzF81p
         I0lAjOmHaxuNpe9m7tI/LmKM+cLCpuGRkNYEynWLf4i3WyIK4aJIFyktjuDTpzwPNY2E
         IVoQ==
X-Gm-Message-State: AOJu0YwvCW4fqXBTsNyb40Jc5MV5CElk11unROjHC8Cq0U5OMO5oaXqg
        HdRd4NXzU1TgU5uts9meqaLKiIMH51+y
X-Google-Smtp-Source: AGHT+IFnVPI8k6B5G+QH3e0Bj9Dymv4VB/FhRNCGu7sBVEICr0moxZQsYBAXUeR9HMtreYF/f10tZbQYtHKi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a05:6902:566:b0:d15:53b5:509f with SMTP id
 a6-20020a056902056600b00d1553b5509fmr185925ybt.2.1692778144480; Wed, 23 Aug
 2023 01:09:04 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:16 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-14-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 13/25] perf parse-events: Improve error message for double setting
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Double setting information for an event would produce an error
message associated with the PMU rather than the term that was
double setting. Improve the error message to be on the term.

Before:
```
$ perf stat -e 'cpu/inst_retired.any,inst_retired.any/' true
event syntax error: 'cpu/inst_retired.any,inst_retired.any/'
                     \___ Bad event or PMU

Unabled to find PMU or event on a PMU of 'cpu'
Run 'perf list' for a list of valid events
```

After:
```
$ perf stat -e 'cpu/inst_retired.any,inst_retired.any/' true
event syntax error: '..etired.any,inst_retired.any/'
                                  \___ Bad event or PMU

Unabled to find PMU or event on a PMU of 'cpu'

Initial error:
event syntax error: '..etired.any,inst_retired.any/'
                                  \___ Attempt to set event's scale twice
Run 'perf list' for a list of valid events
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c |  2 +-
 tools/perf/util/pmu.c          | 34 +++++++++++++++++++++++++++-------
 tools/perf/util/pmu.h          |  2 +-
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7cad82a9f578..781747bedc3e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1348,7 +1348,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return evsel ? 0 : -ENOMEM;
 	}
 
-	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, head_config, &info))
+	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, head_config, &info, err))
 		return -EINVAL;
 
 	if (verbose > 1) {
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 95872bee28ac..0036e41f6baf 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1439,17 +1439,33 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 
 
 static int check_info_data(struct perf_pmu_alias *alias,
-			   struct perf_pmu_info *info)
+			   struct perf_pmu_info *info,
+			   struct parse_events_error *err,
+			   int column)
 {
 	/*
 	 * Only one term in event definition can
 	 * define unit, scale and snapshot, fail
 	 * if there's more than one.
 	 */
-	if ((info->unit && alias->unit[0]) ||
-	    (info->scale && alias->scale) ||
-	    (info->snapshot && alias->snapshot))
+	if (info->unit && alias->unit[0]) {
+		parse_events_error__handle(err, column,
+					strdup("Attempt to set event's unit twice"),
+					NULL);
+		return -EINVAL;
+	}
+	if (info->scale && alias->scale) {
+		parse_events_error__handle(err, column,
+					strdup("Attempt to set event's scale twice"),
+					NULL);
+		return -EINVAL;
+	}
+	if (info->snapshot && alias->snapshot) {
+		parse_events_error__handle(err, column,
+					strdup("Attempt to set event snapshot twice"),
+					NULL);
 		return -EINVAL;
+	}
 
 	if (alias->unit[0])
 		info->unit = alias->unit;
@@ -1468,7 +1484,7 @@ static int check_info_data(struct perf_pmu_alias *alias,
  * defined for the alias
  */
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
-			  struct perf_pmu_info *info)
+			  struct perf_pmu_info *info, struct parse_events_error *err)
 {
 	struct parse_events_term *term, *h;
 	struct perf_pmu_alias *alias;
@@ -1489,10 +1505,14 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 		if (!alias)
 			continue;
 		ret = pmu_alias_terms(alias, &term->list);
-		if (ret)
+		if (ret) {
+			parse_events_error__handle(err, term->err_term,
+						strdup("Failure to duplicate terms"),
+						NULL);
 			return ret;
+		}
 
-		ret = check_info_data(alias, info);
+		ret = check_info_data(alias, info, err, term->err_term);
 		if (ret)
 			return ret;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index f37e3d75094f..03211de345c1 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -185,7 +185,7 @@ int perf_pmu__config_terms(struct perf_pmu *pmu,
 __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
 int perf_pmu__format_type(struct perf_pmu *pmu, const char *name);
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
-			  struct perf_pmu_info *info);
+			  struct perf_pmu_info *info, struct parse_events_error *err);
 int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, pmu_event_callback cb);
 
 int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load);
-- 
2.42.0.rc1.204.g551eb34607-goog

