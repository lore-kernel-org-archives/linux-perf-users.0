Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641EEC83003
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Aug 2023 04:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbjHXEO2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Aug 2023 00:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240061AbjHXEOD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Aug 2023 00:14:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66332170A
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 21:13:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58e4d2b7d16so82167947b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 21:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850433; x=1693455233;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ya/35txba4PAMPm8mMBnt/qSzsiHQTJEwaXtI6KarCw=;
        b=3VJfTM8kygD1T1PhmetM3PcBE1gQOcO3+ThUAN3fhGzT28M9PgychNxNpP8peY3l/g
         k9+S2Se3TL+up6K3bfFmxk1xOnuF1cgcM2yIFbQvyrLPjU8Ft0xRNjCskCm0lsM288DD
         ACZrScqJDpli5CCdWIHkT1NdEb/pj6wefraP7EBz5lTS3s24jmfIAGCARmB6Q1uYIL2J
         deXcbqUmoSWMIDh83MmYyXKLdpouS5M2bMGZqtEIRfHnfE6+mhzycoAS7dAA1WCN9LkB
         Tsrb5E1MJTU1BKSMcQuOyF7txVS9AK2kogzSobXJyFlhzxLCuQbeP4sJpc758bYbmEt0
         A6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850433; x=1693455233;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya/35txba4PAMPm8mMBnt/qSzsiHQTJEwaXtI6KarCw=;
        b=bwIf4YIRtY1+0DORoeW3Sx+V0g01wRAKa4DJySxeeE2UBDmw+wBs33RhcwK/+5uj2F
         opq0bePdiCdSTpiTctyyFm073k+2adpDDlPp/lCD6+Ut3qsy8Ot8O+4JD/h9H0/VGRtU
         F8pyA6XJTu/p43m15p+Usrd4yGqnXgrL2QmaNVGOOlmP6310fFl9WLzuXkHm+w7bOpIu
         GuWsLG9X3/YRsPmw20bDMvGFdDv/IDcJ8zC4nNHtaRCyW9Hx9ozAO0/1xd6hNSkcSf+a
         EgFko1YnoZEgADZGUMROD/3S2ISsQkOJbftogcPSKUSVU2G33x+/Aj/r3KyNuQU9UG/N
         XZGQ==
X-Gm-Message-State: AOJu0YysfcR1xPF7OvKFoYin83yk99HVsbsXaRLx4qfrNm5zyvyg5h3S
        mrz3FI1Lzdp7IOusjxa69cXFLp2e5eoN
X-Google-Smtp-Source: AGHT+IE7hk7aF5+o9K3xOuDaJwbkY2h6VIkgNVR7fuUCCjnbEaQYcnKDvLAmGG0IIa2nrQLjSHBXq2VjRk1S
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a81:ad43:0:b0:576:af04:3495 with SMTP id
 l3-20020a81ad43000000b00576af043495mr201866ywk.9.1692850433482; Wed, 23 Aug
 2023 21:13:53 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:17 -0700
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
Message-Id: <20230824041330.266337-6-irogers@google.com>
Mime-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 05/18] perf parse-events: Improve error message for double setting
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
index d91367155e29..0c82bbeea7d6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1443,17 +1443,33 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 
 
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
@@ -1472,7 +1488,7 @@ static int check_info_data(struct perf_pmu_alias *alias,
  * defined for the alias
  */
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
-			  struct perf_pmu_info *info)
+			  struct perf_pmu_info *info, struct parse_events_error *err)
 {
 	struct parse_events_term *term, *h;
 	struct perf_pmu_alias *alias;
@@ -1493,10 +1509,14 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
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

