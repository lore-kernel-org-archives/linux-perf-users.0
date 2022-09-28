Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77973C04A95
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Sep 2022 07:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiI1HW3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Sep 2022 03:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiI1HWP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Sep 2022 03:22:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6598DD5884
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 00:22:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m131-20020a252689000000b006b2bf1dd88cso10694891ybm.19
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 00:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=YPZVPn/GTh1TFAuZs4AqHXTtAyJBnhTYkrO6EMpJe5g=;
        b=IF0rILXSsrUUJJljm0eQbbs72q4mFDg+n66vVVTg/HiaWGMF9Z2RabOCmtM37prxKt
         FMdtXGRXt76fteg0sfKEkHgDavX+CfIg0hcyKosCuGKS19dS6qHuyiL/YaXciyxcVO/2
         axqcNDhHvReYrBz3MRw/UKjJgE6+8szcvhppTtdPtvWFVzpMQnNqJhB8zhC/9UXkJ5tL
         hnj2m1UhMvLZ6gqfsQbcV3Sb7ksKuaGHyt0eNjkkcCf5kmwfgVDVBYeGmaWOsZ/75sm+
         b+JD8QG/zDeq4QFY2RXpjT6nk22OMlpuks+YB8B6FnZAv9iQpNFvbMbGVQBbk6aKdbGj
         Y5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=YPZVPn/GTh1TFAuZs4AqHXTtAyJBnhTYkrO6EMpJe5g=;
        b=0pLREFw9YRpqq13QMoFi61+hl7h+aLZ9W4Xvo9LdK+NmRejBmNM5Q/S1gksZNATehe
         wFU51ska8bIoo2/k6Y1IFSXJ6Fi7uSmXiUMqEL77sBOA7LQedQJ2ruCLanJBODngkdjs
         Z5IhWn99cf9J1Ftg/OmFFejQStcXGDbWdhr5cu6p63kONOPnsSb4emyBb35LpNl0GwMM
         GOPgN4vNOg2YGO3dK9jUG43R6p/POqCoAV8EeSjx5aiqcU01wcSWy0HC7GBHaVaVxAtW
         NOWLCFkyQ6uEGgDQgd1/VSE1CQU5ZYmuVJ3BNXjiC7E9a3q4NhXRob49bGuNwyfSHZw4
         ILQA==
X-Gm-Message-State: ACrzQf0j0CyGwAPJMC13PVNnITGde/6eE+eNXHUCH2NLHPzyqsf5R/D3
        mJvG70fDv94dEGBe2JGvNJjnGnIbGwrW
X-Google-Smtp-Source: AMsMyM6WZhoDBs0nlE+B6MRvAzP4iw8WMDbSVU6/E3AHtH79AatyDR7f3lWD1YvhXfqr2e5wK35Zr8BPNXY1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7099:1ccb:612a:5ad6])
 (user=irogers job=sendgmr) by 2002:a25:4241:0:b0:6b4:bcc:609b with SMTP id
 p62-20020a254241000000b006b40bcc609bmr30680640yba.396.1664349734108; Wed, 28
 Sep 2022 00:22:14 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:21:44 -0700
In-Reply-To: <20220928072204.1613330-1-irogers@google.com>
Message-Id: <20220928072204.1613330-3-irogers@google.com>
Mime-Version: 1.0
References: <20220928072204.1613330-1-irogers@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Subject: [PATCH v1 02/22] perf expr: Remove jevents case workaround
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

jevents.py no longer lowercases metrics and altering the case can cause
hashmap lookups to fail, so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index c6827900f8d3..aaacf514dc09 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -182,7 +182,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
 	char *old_key = NULL;
-	char *name, *p;
+	char *name;
 	int ret;
 
 	data_ptr = zalloc(sizeof(*data_ptr));
@@ -195,15 +195,6 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 		return -ENOMEM;
 	}
 
-	/*
-	 * The jevents tool converts all metric expressions
-	 * to lowercase, including metric references, hence
-	 * we need to add lowercase name for metric, so it's
-	 * properly found.
-	 */
-	for (p = name; *p; p++)
-		*p = tolower(*p);
-
 	/*
 	 * Intentionally passing just const char pointers,
 	 * originally from 'struct pmu_event' object.
-- 
2.37.3.998.g577e59143f-goog

