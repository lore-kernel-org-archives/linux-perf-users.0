Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0123C432BE
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DDD61209
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhHUJV0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhHUJUw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A5C0612AC;
        Sat, 21 Aug 2021 02:20:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h9so25216803ejs.4;
        Sat, 21 Aug 2021 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQW9vFf14CSQ8/UctEQPnfJzPFIegK8ITMd5pacLu0s=;
        b=oPSURToHwIk6vpDnWikcvdiqa3NRcqB5AjozmrGNhz5bHbGqpeygl/kT/OUJcVSx60
         8RaU/BSf0v4e317mZGJ+rBF71qk1Gvd6Vfqsu3Nt3AW4IlX9IjNMGx9/8TeqVMHUxNwv
         4XKpBPmyQqWC4FihySXcEAO0lyt5Ym8DzU9ESlL63+KJyisG4VQtWJKSOQ1NWL6OuKeE
         05/lNgfDdCmTzL3tsDg73k+gLEF0X4stcJUg7TxWDxS5VEcoOPAse9qiZ+5nawd9KzDx
         +qDZBj/2OggNBISVQAdHuwUsJZA7HfRa9iuIUBJs13N9+3XBd+nnoh9eAcv9UqFF2yxP
         crTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQW9vFf14CSQ8/UctEQPnfJzPFIegK8ITMd5pacLu0s=;
        b=ZV+eDjWT2ZCNaQ+t/xq1H7RRdmxd/UjqSgf0prM8BMYlq9dbWYPtgJczh8Wunt0kZS
         ZPJz/XkjGosjaPcJmLmcIY0jVcXk9bCt5XIwcCMYp3TGhMy8z3VZ+w5kfILeE0efi/+k
         +VD0IG5rid5N/2/jDvI7RlUDqjeDwqlvcfLcEHVpXYrkgGKZzpRRmmOEzmVAZ+JKWKLk
         NAhG4zfFenbOM7Vkm6Yj38Z+1iipGblezFuYtUoJSfhG8/hz4oa0tdwsHcfR4ImoPi2a
         SuTDAGglUYMV8j4TKvx9/4tuCbXn9fQfsDFReWd+NyBee3awHhIihT0gB/DDl/1PyW4p
         gSCA==
X-Gm-Message-State: AOAM533E5rwMd/uSKJa5QIAwgw0UEtwuZQppJofPNA1awOiQrK+Ou56H
        R9RV1+rvUE5yd8BCENgGxko=
X-Google-Smtp-Source: ABdhPJzIRHMGLNKiGZP2u9AbH/A1Whdva6pfc1wbHv+YzGJR33ApWIVgLpHZjiauuoji7WBa0ybsPQ==
X-Received: by 2002:a17:906:eda3:: with SMTP id sa3mr26444608ejb.451.1629537605773;
        Sat, 21 Aug 2021 02:20:05 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:05 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 14/37] perf evsel: remove retry_sample_id goto label
Date:   Sat, 21 Aug 2021 11:19:20 +0200
Message-Id: <340af0d03408d6621fd9c742e311db18b3585b3b.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

As far as I can tell, there is no good reason, apart from optimization
to have the retry_sample_id separate from fallback_missing_features.
Probably, this label was added to avoid reapplying patches for missing
features that had already been applied.
However, missing features that have been added later have not used this
optimization, always jumping to fallback_missing_features and reapplying
all missing features.

This patch removes that label, replacing it with
fallback_missing_features.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evsel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f61e5dd53f5d2859..7b4bb3229a16524e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1825,7 +1825,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		evsel->core.attr.bpf_event = 0;
 	if (perf_missing_features.branch_hw_idx)
 		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_HW_INDEX;
-retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->core.attr.sample_id_all = 0;
 
@@ -2006,7 +2005,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	} else if (!perf_missing_features.sample_id_all) {
 		perf_missing_features.sample_id_all = true;
 		pr_debug2_peo("switching off sample_id_all\n");
-		goto retry_sample_id;
+		goto fallback_missing_features;
 	} else if (!perf_missing_features.lbr_flags &&
 			(evsel->core.attr.branch_sample_type &
 			 (PERF_SAMPLE_BRANCH_NO_CYCLES |
-- 
2.31.1

