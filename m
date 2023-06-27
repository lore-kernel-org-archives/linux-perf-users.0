Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F98DEB64DC
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 18:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjF0SKw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF0SKr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 14:10:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CBD2D45
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 11:10:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bfee66a6398so5245357276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889443; x=1690481443;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRovkRSYzzjqItxtlGi5Ku78WYBIH4P5/AOwfUisZaE=;
        b=RT8GMQDKiKYPOqkUNeCk3YCu7ZRMfW44W4/G5HoJ+P8tmBTDzR6CPQX/dkEE0ovK/g
         Q2c0m/7QnixPhPNA7FHxQeBOjHpCJQfyPz13NljLUYXdXx0oNeChnu678rbFV4T4ld56
         U0GRoWJwlkoX+536gIxfeZfIGNCImUYdVOc3nP3rl6gCkqAmiZoPJwMqmGcbm8bxHAjR
         2+0+JSUDailQ/C1DRR200Az3miWW4DupvVY4MMnILgxz0Ck4noFElwem/wDI+EK33IWd
         WQ4elNQZuNhFkGm/ig2O44qwqqr5MRkC51/M2S5QQNA/K3rSxQ/t/yQLB1n1a/t28Wyx
         oplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889443; x=1690481443;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRovkRSYzzjqItxtlGi5Ku78WYBIH4P5/AOwfUisZaE=;
        b=NOTx2ks2ZMAn+oIUhutIqtwPGVC/IFtDXa4JV1h786Uk4COuT+TPcbLf1pe4oPQby3
         msRXyV7Ghi0ASHmjFUqjf4WQaJrVdw1tr9E6L9PzJ/qHweIqZIZGsIRx1PUHFzt0R1X5
         9LybCRmNfzRHPj3II4HmpRd5F1/joJ7kGSkZnLfovYmE0DrMDvAz8gbR8MhhN4omBsUQ
         go45JWxgei5nwgwdkuc939JCHQd160RufntlDwOWYvV4KSl+OpPJPwnFUNMs4glJBbsI
         RbbHRMG+ZOWiyw/riHrqKhZ6rGjFNnvNFCtMdxA8qBLV5vKyHUot6+o565j9xR571l4T
         qmGw==
X-Gm-Message-State: AC+VfDyGn/8KR93ppVfIR4u/R5Hl2O1mXgHuW4ABMHJ0UmIcF9qOisD7
        pQWu7Ubj880Eef4Ra4Sdg3YLN3JIaH2z
X-Google-Smtp-Source: ACHHUZ4dCuXkazspQAeZywR+p2lXLl1x/iMDL5zaSkGcydnwubuqOiZR2nx8V7EWC/UfGvGDnGGBsylcGjVi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a25:ce8e:0:b0:ba8:4ff5:4671 with SMTP id
 x136-20020a25ce8e000000b00ba84ff54671mr14764241ybe.9.1687889443701; Tue, 27
 Jun 2023 11:10:43 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:10:18 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-2-irogers@google.com>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 01/13] perf parse-events: Remove unused PE_PMU_EVENT_FAKE token
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
PMUs before parsing").

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 42 ++--------------------------------
 1 file changed, 2 insertions(+), 40 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 9f28d4b5502f..64755f9cd600 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -63,7 +63,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_LEGACY_CACHE
 %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
 %token PE_ERROR
-%token PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
+%token PE_KERNEL_PMU_EVENT
 %token PE_ARRAY_ALL PE_ARRAY_RANGE
 %token PE_DRV_CFG_TERM
 %token PE_TERM_HW
@@ -81,7 +81,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_MODIFIER_EVENT
 %type <str> PE_MODIFIER_BP
 %type <str> PE_EVENT_NAME
-%type <str> PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
+%type <str> PE_KERNEL_PMU_EVENT
 %type <str> PE_DRV_CFG_TERM
 %type <str> name_or_raw name_or_legacy
 %destructor { free ($$); } <str>
@@ -394,44 +394,6 @@ PE_KERNEL_PMU_EVENT opt_pmu_config
 		YYABORT;
 	$$ = list;
 }
-|
-PE_PMU_EVENT_FAKE sep_dc
-{
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	if (!list)
-		YYABORT;
-
-	err = parse_events_add_pmu(_parse_state, list, $1, /*head_config=*/NULL,
-				   /*auto_merge_stats=*/false);
-	free($1);
-	if (err < 0) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
-|
-PE_PMU_EVENT_FAKE opt_pmu_config
-{
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	if (!list)
-		YYABORT;
-
-	err = parse_events_add_pmu(_parse_state, list, $1, $2, /*auto_merge_stats=*/false);
-	free($1);
-	parse_events_terms__delete($2);
-	if (err < 0) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
 
 value_sym:
 PE_VALUE_SYM_HW
-- 
2.41.0.162.gfafddb0af9-goog

