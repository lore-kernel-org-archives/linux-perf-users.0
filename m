Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C57C54E94
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Jan 2023 01:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbjAZBVY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Jan 2023 20:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjAZBVS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Jan 2023 20:21:18 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA3461D4C
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 17:20:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-482d3bf0266so4113177b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 17:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjltbgFvPXxNxLiYStYE3VCcVG+pja2QaxGJnpw1y/o=;
        b=VxQifR4eTm/oiq+AtgXObEPg6PbS+FCbU66oTdjhqZ7NOq5U2vhhVAuJG7CJAmTAx4
         Lt50WFOtTpTs1TQKLM0aOwhl4/O9QSqsZ7GYnbdd8r+IghyCyr7DL5d6c/hl6Au4KTsM
         ErRsXqJd/YTXEyZLP90smJmcXZ2wm1RhUX1E2uhwba8PGvyRkWiCtQofEvi/IEOSjYLn
         WrQqm5BZ6+RZ99ZwhgD8m92fCZeLverYJd/5gsKFa6jFKD1Qm01QpjyXwVbdK1wdSPb8
         QXHTuTatMmpI9W2nK87lMLio5oAZirIt7fZGwV+avak9PsioHMSqNPVCTS6ndtiPIQqP
         D5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjltbgFvPXxNxLiYStYE3VCcVG+pja2QaxGJnpw1y/o=;
        b=sxAvGCw9vfVcZn7ZSPeSzmJciIyvoOEJHPolZzMtjqXHir1y64sJ+Eit+Jas9Rn6iv
         Mym4xtFqjAAdX9fnddfzgfz4SBj0gqS3QO4+SQ90QvskvYePpuy8N5+FijYbTk6qtv1J
         V6kaHP+he7EyxN1Tng7xKSKRhTHbYiJ7/n9XL2cYnsQPaqL8uNMta9hNrgmGTSK5pOZ9
         LmADfcQ5ObOqK75ZKz2+lC784iMWjWlFnQzePgphFY3lp258A+T5gW5nQBF/xP8SV/6j
         a0J1EFrpWWxki8ya0/XXr8yzjbi20oYDIVvuJLyX1ncWQbYeelkfkAlOoiRACthhrT0X
         WwaQ==
X-Gm-Message-State: AFqh2krmDHAl9cul01pycz68M8UCLo/SgF7d7w9u5exO3J+zJ+AnWNhC
        QW5OvZRMW+MlbRbbLKUDKhrxftJkacHw
X-Google-Smtp-Source: AMrXdXsACLfASuysaOm2/S/UHYpvgci8aYMjvrQ5T1As6a7u+QStn1ktC49JQqivsGHwIDxUs3nwQIls/UA1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:568d:4d98:b468:b025])
 (user=irogers job=sendgmr) by 2002:a81:ec05:0:b0:4fd:413d:204c with SMTP id
 j5-20020a81ec05000000b004fd413d204cmr2646561ywm.419.1674696041384; Wed, 25
 Jan 2023 17:20:41 -0800 (PST)
Date:   Wed, 25 Jan 2023 17:18:54 -0800
In-Reply-To: <20230126011854.198243-1-irogers@google.com>
Message-Id: <20230126011854.198243-13-irogers@google.com>
Mime-Version: 1.0
References: <20230126011854.198243-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v4 12/12] perf pmu-events: Fix testing with JEVENTS_ARCH=all
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The #slots literal will return NAN when not on ARM64 which causes a
perf test failure when not on an ARM64 for a JEVENTS_ARCH=all build:
..
 10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
..
Add an is_test boolean so that the failure can be avoided when running
as a test.

Fixes: acef233b7ca7 ("perf pmu: Add #slots literal support for arm64")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 1 +
 tools/perf/util/expr.h        | 1 +
 tools/perf/util/expr.l        | 8 +++++---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 962c3c0d53ba..accf44b3d968 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -950,6 +950,7 @@ static int metric_parse_fake(const char *metric_name, const char *str)
 		pr_debug("expr__ctx_new failed");
 		return TEST_FAIL;
 	}
+	ctx->sctx.is_test = true;
 	if (expr__find_ids(str, NULL, ctx) < 0) {
 		pr_err("expr__find_ids failed\n");
 		return -1;
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 029271540fb0..eaa44b24c555 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -9,6 +9,7 @@ struct expr_scanner_ctx {
 	char *user_requested_cpu_list;
 	int runtime;
 	bool system_wide;
+	bool is_test;
 };
 
 struct expr_parse_ctx {
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 0168a9637330..72ff4f3d6d4b 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -84,9 +84,11 @@ static int literal(yyscan_t scanner, const struct expr_scanner_ctx *sctx)
 	YYSTYPE *yylval = expr_get_lval(scanner);
 
 	yylval->num = expr__get_literal(expr_get_text(scanner), sctx);
-	if (isnan(yylval->num))
-		return EXPR_ERROR;
-
+	if (isnan(yylval->num)) {
+		if (!sctx->is_test)
+			return EXPR_ERROR;
+		yylval->num = 1;
+	}
 	return LITERAL;
 }
 %}
-- 
2.39.1.456.gfc5497dd1b-goog

