Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB3DCA0FF8
	for <linux-perf-users@archiver.kernel.org>; Fri,  1 Sep 2023 23:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348057AbjIAXkC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 1 Sep 2023 19:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344519AbjIAXkB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Sep 2023 19:40:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714E6E42
        for <linux-perf-users@vger.kernel.org>; Fri,  1 Sep 2023 16:39:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d72e09f1263so2261646276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Sep 2023 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693611597; x=1694216397; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YZKcv2qm654M/FYmU/pcNkIGZSygQHgArJvC8qgakL4=;
        b=cfUcMREeIHoZMx9zz/xZVLL96jrrq+P176s1qFuRb9Rf+5aO62K7P5hAw3Q9Rm+49v
         LSxf8fIF1SAsRiyWDANRbSqDKCFlMKDD7AWrxXfcC9yOvBB34lRwhw7fIRXj+t6JCQJb
         XIPauonP+Nmli/W9VFnY9dbaBHEa6XvghdH701LsDgxN1bsVAK4/Iu31QVXK7/zjV13O
         embm0Ngr8ablKpmj/hSrSRdCOvHw3T3tjRPaRqyZc3i416qlDpcI5llVUSSc0HIhqHih
         oF8aiJL49397F0r2IMXSZyMJr88pHcxzomYyQ+wz8R/S6iAD7hsy1UdVoKFll9m7bhPB
         pMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611597; x=1694216397;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZKcv2qm654M/FYmU/pcNkIGZSygQHgArJvC8qgakL4=;
        b=g82nQLviHuOhAakJMvaSq1i2DvPHfXhEqZwjSu+TxO91OFr3g9zmt7hRRUaa2iv8aB
         cb68n34kmQft4NdHCAwSCkWdJZnyONEBdphMjJP/Y9oW245bITfJOcnhXNfbkUln1KIq
         N+X7tnB20dHbaIoWOWFgOy9glXaQLHjDNHvQIS5chLSFtGSj4ZtpCR2k69UVrsReNV+B
         AUKqgOLWulzQ3Czwkl0eo9tc77VjamnEP/dsqwStd6S+mUXu8C2C3hSOrEV41tTrPKo3
         6dMEYfvmc84wyRZKzyu3e8TuXYEddue7DFS3Lw6jMUY3uW/LDOrg6rM8wmPcUlZT31dG
         /4Ng==
X-Gm-Message-State: AOJu0YwDdJBj79yugGODVKrk3N/A6ST5HmKvReXW3ljUuDj5RP4rIC0j
        4pWIkEfrGLnjhbgJBwTycsJ36MBJj3y6
X-Google-Smtp-Source: AGHT+IGUf8z/Ef1N9qQpMlK8pusRkaUoi/oIp67o+SdQgTpqE2A1CYGXu8LHKWLrOKdYfGF0ucSeN7DaD3gz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:51bc:d985:dbbd:10b])
 (user=irogers job=sendgmr) by 2002:a25:ca11:0:b0:d11:6816:2d31 with SMTP id
 a17-20020a25ca11000000b00d1168162d31mr100143ybg.7.1693611597740; Fri, 01 Sep
 2023 16:39:57 -0700 (PDT)
Date:   Fri,  1 Sep 2023 16:39:44 -0700
Message-Id: <20230901233949.2930562-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 1/6] perf parse-events: Fixes relating to no_value terms
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
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A term may have no value in which case it is assumed to have a value
of 1. It doesn't just apply to alias/event terms so change the
parse_events_term__to_strbuf assert.

Commit 99e7138eb789 ("perf tools: Fail on using multiple bits long
terms without value") made it so that no_value terms could only be for
a single bit. Prior to commit 64199ae4b8a3 ("perf parse-events: Fix
propagation of term's no_value when cloning") this missed a test case
where config1 had no_value.

Fixes: 64199ae4b8a3 ("perf parse-events: Fix propagation of term's no_value when cloning")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 2 +-
 tools/perf/util/parse-events.c  | 2 +-
 tools/perf/util/parse-events.h  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index d86076d575ed..d47f1f871164 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2170,7 +2170,7 @@ static const struct evlist_test test__events[] = {
 
 static const struct evlist_test test__events_pmu[] = {
 	{
-		.name  = "cpu/config=10,config1,config2=3,period=1000/u",
+		.name  = "cpu/config=10,config1=1,config2=3,period=1000/u",
 		.valid = test__pmu_cpu_valid,
 		.check = test__checkevent_pmu,
 		/* 0 */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 68fe2c4ff49f..65608a3cba81 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2607,7 +2607,7 @@ int parse_events_term__to_strbuf(struct list_head *term_list, struct strbuf *sb)
 
 		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
 			if (term->no_value) {
-				assert(term->type_term == PARSE_EVENTS__TERM_TYPE_USER);
+				assert(term->val.num == 1);
 				ret = strbuf_addf(sb, "%s", term->config);
 			} else
 				ret = strbuf_addf(sb, "%s=%#"PRIx64, term->config, term->val.num);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 855b0725c5d4..594e5d2dc67f 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -124,8 +124,8 @@ struct parse_events_term {
 	 */
 	bool weak;
 	/**
-	 * @no_value: Is there no value. TODO: this should really be part of
-	 * type_val.
+	 * @no_value: Is there no value. If a numeric term has no value then the
+	 * value is assumed to be 1. An event name also has no value.
 	 */
 	bool no_value;
 };
-- 
2.42.0.283.g2d96d420d3-goog

