Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF06EB64DD
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 18:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjF0SKx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjF0SKu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 14:10:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78025272D
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 11:10:46 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-666e5f0d639so2054069b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889446; x=1690481446;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWCGE0gvk+pE+CmFQOT3NcABG9fSPb9UJ3AYuKosiSs=;
        b=U3tszF3iEnPlISAxvRgLQh2yAsfBXVo/Q6PsnR8CoF2tEFqxSBVSBaD/G6Pm6Cajnz
         aQ4XGOH4k9El84pkqkaI76GE6uJ3psK5/29cFwc9AT9tJ0m8tAFK7+Xup/A2reI81n96
         wPh32LcU2PSJ38NBnw3EifrTE5J7lYjzK/tvFFhsSwTOJh0hR8p061/PfLA9EeiBrAWn
         f3YBVRP3D9stcaMoLY8zd/yQdE/4vZRNkOGfqG4A8hU+Wzhq9+shpWzmiAmwTJntc0h3
         q9sKKT8u+w0OgGX1a2RMJvyThaU3d8/esnfAlURWDJq4i0smQ24u6vUoVwrace9wRXjl
         oqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889446; x=1690481446;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWCGE0gvk+pE+CmFQOT3NcABG9fSPb9UJ3AYuKosiSs=;
        b=QDGWFAN7mLayS+1ixbuMnRN95ECS2IYWmVGXuWr7wi3O+f45GskEk1taNl9ZSIZpsO
         crHWsgSiZJ/03jzeflPI/WMwzFNh0xK85dT69vIjuoHsnOtQ3EIUK+K+ZBQYh13DVCLG
         wRph9OIL96SoTNe0jcS6KjAXyngjZ3GbKFhIOVs+TixlLjF3bJDafYpLrPKQEVQGolsO
         qthpctcMDQTTQmHRnrf/iiRrbZpOiUO1/B3GcojvQGHZ7R1Cg7z7PErmu+i/lo7gN+xc
         3XFbFqHwS3jqa7AJq0t162WzbP33bptlDYtpfyuYlkvHtT0kOedM7P7bynCxgDLPEy4y
         GC6g==
X-Gm-Message-State: AC+VfDwGug1ZvVVO9U/5yr3hLMR0RI2DcHiEUpp2/fTjVzsCYtZeK6Ue
        6a1jX3uq6m0u9zDgthdQsncfMf2VJstI
X-Google-Smtp-Source: ACHHUZ7eXpeYFLZxfraqt2sq94LXekMZYj8K3lgYRHv1M1aPEVN24PTbJvBtf5w1JuRlH1u8acu24npK7HSM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1504:b0:668:7377:1fe3 with SMTP
 id q4-20020a056a00150400b0066873771fe3mr7745734pfu.2.1687889446028; Tue, 27
 Jun 2023 11:10:46 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:10:19 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-3-irogers@google.com>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 02/13] perf parse-events: Remove unused PE_KERNEL_PMU_EVENT token
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
 tools/perf/util/parse-events.y | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 64755f9cd600..4ee6c6865655 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -63,7 +63,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_LEGACY_CACHE
 %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
 %token PE_ERROR
-%token PE_KERNEL_PMU_EVENT
 %token PE_ARRAY_ALL PE_ARRAY_RANGE
 %token PE_DRV_CFG_TERM
 %token PE_TERM_HW
@@ -81,7 +80,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_MODIFIER_EVENT
 %type <str> PE_MODIFIER_BP
 %type <str> PE_EVENT_NAME
-%type <str> PE_KERNEL_PMU_EVENT
 %type <str> PE_DRV_CFG_TERM
 %type <str> name_or_raw name_or_legacy
 %destructor { free ($$); } <str>
@@ -358,18 +356,6 @@ PE_NAME opt_pmu_config
 #undef CLEANUP_YYABORT
 }
 |
-PE_KERNEL_PMU_EVENT sep_dc
-{
-	struct list_head *list;
-	int err;
-
-	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list);
-	free($1);
-	if (err < 0)
-		YYABORT;
-	$$ = list;
-}
-|
 PE_NAME sep_dc
 {
 	struct list_head *list;
@@ -381,19 +367,6 @@ PE_NAME sep_dc
 		YYABORT;
 	$$ = list;
 }
-|
-PE_KERNEL_PMU_EVENT opt_pmu_config
-{
-	struct list_head *list;
-	int err;
-
-	/* frees $2 */
-	err = parse_events_multi_pmu_add(_parse_state, $1, $2, &list);
-	free($1);
-	if (err < 0)
-		YYABORT;
-	$$ = list;
-}
 
 value_sym:
 PE_VALUE_SYM_HW
-- 
2.41.0.162.gfafddb0af9-goog

