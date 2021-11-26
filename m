Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CFBC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 07:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352804AbhKZHSo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 02:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352874AbhKZHQo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 02:16:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF8DC061748
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Nov 2021 23:13:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l145-20020a25cc97000000b005c5d04a1d52so9379797ybf.23
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Nov 2021 23:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=W8hS1aIz252p/mMAVTvx9qDScElm2mCtCgsM5bMoDEk=;
        b=LtNaVZTVTBAxfs2FCwbd1IbM2oYejVO8saSuKjZwaKdsFsd/5e8cjS31/FErDyX2OJ
         vK40XcqfAe5++itK3t7bQ9k9xOF2xEatZWiwTV7W7r6XcYBAL3VIB3+ezGuns9n9RXjK
         eQTrDSFOm/47+6afws4MwbOv55vtblxBZVEnY+LNDtw4A/2LuoYp29L0HA/91gIasRcP
         4P8ZKM4scKYbjW6rsBzekXUtIoYFCdSvcsJoPV7ew9avb3l0G6w7ZinMuVyHD32l7kRi
         FfWVrbOxX0G3qqhKRgSoU1W3avNh1PsFxuDyHEXGketLoLlplkTGLtLDFGyEmeaEsfVP
         Y8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=W8hS1aIz252p/mMAVTvx9qDScElm2mCtCgsM5bMoDEk=;
        b=taZ/DTXD3VuCkjlVon6DyZwAcAVylPEF7qbzdvxEB1+HUpgCOd4aIsPd9ePyoYZhw8
         f3cf/I7nRpcvrPaE5FCJQrurlaqMcdbJ46i1Mi0LmxSxPyQOCF1xLVTSIkDxXhC4kZ6h
         v5t1YBy48M/6tWyHmPb5HNypTvwIQWTIqq9aA7weflw+ahUmHS9FAXlQDnXqSkrPotRb
         7ohiY0M7fiM2VvBL4qDN6vGf+RfNhGSkInDcTXjQ2+KIe1KyMZmO706iaIAab1mG6CpO
         LbTpOYj0Nhiu6HlFHPr56M1UBSE8G0jbqoY7Cz3sxjdbdFAjCP2g+8nsxF8ZyBXFSwaA
         wXQw==
X-Gm-Message-State: AOAM531EfHV66vU6iW3TZfaaENJepp9/jyn1SwyrldS23JSsL69vnt3v
        csxmdR593ItGsR1j/H6xDetLP9Pno+8Q
X-Google-Smtp-Source: ABdhPJyMhAlET7BZdwEfgs2s181EBLy1PpYEzdwf1yfnsLaCeGL40f4p8cmXJrPvHAP2UI8xq9+bWPWE4QGW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:cdec:1c24:b91d:377e])
 (user=irogers job=sendgmr) by 2002:a5b:b91:: with SMTP id l17mr12092261ybq.198.1637910789950;
 Thu, 25 Nov 2021 23:13:09 -0800 (PST)
Date:   Thu, 25 Nov 2021 23:13:05 -0800
Message-Id: <20211126071305.3733878-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [RFC PATCH] perf pmu-events: Don't lower case MetricExpr
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch changes MetricExpr to be written out in the same case. This
enables events in metrics to use modifiers like 'G' which currently
yield parse errors when made lower case. To keep tests passing the
literal #smt_on is compared in a non-case sensitive way - #SMT_on is
present in at least SkylakeX metrics.

This patch is on top of:
https://lore.kernel.org/lkml/20211124001231.3277836-1-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.c | 2 --
 tools/perf/util/expr.c          | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 2e7c4153875b..1a57c3f81dd4 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -672,8 +672,6 @@ static int json_events(const char *fn,
 				addfield(map, &je.metric_constraint, "", "", val);
 			} else if (json_streq(map, field, "MetricExpr")) {
 				addfield(map, &je.metric_expr, "", "", val);
-				for (s = je.metric_expr; *s; s++)
-					*s = tolower(*s);
 			} else if (json_streq(map, field, "ArchStdEvent")) {
 				addfield(map, &arch_std, "", "", val);
 				for (s = arch_std; *s; s++)
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index cdbab4f959fe..5cd6b9ff2489 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -397,7 +397,7 @@ double expr__get_literal(const char *literal)
 	static struct cpu_topology *topology;
 	double result = NAN;
 
-	if (!strcmp("#smt_on", literal)) {
+	if (!strcasecmp("#smt_on", literal)) {
 		result =  smt_on() > 0 ? 1.0 : 0.0;
 		goto out;
 	}
-- 
2.34.0.rc2.393.gf8c9666880-goog

