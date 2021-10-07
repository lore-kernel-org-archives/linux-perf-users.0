Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DE6C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CEDC61245
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbhJGRAY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242890AbhJGRAL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:00:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FF6C06178A
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 09:57:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 124-20020a251182000000b005a027223ed9so8620260ybr.13
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hUNQKi3zozMsCzX8TaWj996c7eJ8M2g/BZ3enRwyt2k=;
        b=mAycqC4Ck8XV/oS+/kw7wn0yOn6mHSAZ9J4pVhbswIYPGZCeP2pQf0n9m3K6tz+6KJ
         EVOsNZ/oWQ7T40lQdFTxvHEIqJa7HIgN0bc0kG68X9fHiE3303t8zZ6Vsh7URNXgbM3W
         Kv3BeEn42dK6gitnPBzOJdbf8Qk3hAeDwVpX05qpOFUQNH/rZcttpn1Bma8HN1a8eq3H
         23NjRpjuwmKZeZcTwe4yhCZNvHrTz5gLUzLEU+7a8Rt1ridZwhQHKkeGuh5qm+b9C3cq
         UIGblf7Z/yRfsk7P9q4qkBQer7rv/uJFnfeN2n8PWFmrh1rtecFBNALESADwBAiutXvS
         VSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hUNQKi3zozMsCzX8TaWj996c7eJ8M2g/BZ3enRwyt2k=;
        b=5fXmsWRNMGEv8FwR/xQNrpl3Yw4KI/+rkOcr9XQT8Effe67PM9g06Q0QIQiVfwJN+R
         2nkUIk3XjkesXIqxJxVLOcxImGajYDrscWRlk3M4GpeKVJFoRPrjgpyHPwNbuhEJnZcY
         Nr4flUnz8yT146nJ5zodlz8XQBUta06KCE6ieGMihBZp/IkWBYv8JO3U/wQ96EvyNuR3
         DfkAz3pZjiZe1WvjT5kCCO7sJzFE3bm7PWqzpq8YmeAtuEZiDJ0p1GNEK6+wuCeDCMkX
         CJBuOGBfiUgrK8m2S8tKGeqswLDBMllo6Fk2PS/2YZTycjgLVPN5ujhUEOao1FjKkgVS
         bsTw==
X-Gm-Message-State: AOAM532rdCGaC+scSNf/t6CBZwdaJWEsxtGjGDbPu6agCB0/jdyiRsf6
        uFwH0dMZIf+mMnBV+hcfePElP6Xg0Zle
X-Google-Smtp-Source: ABdhPJyqtOy6ZrDXmsKE3aU5aGQr5go9MqtJSw3eGUul+v3vFob29R97VmQE9K0T53VoY6CQSe7/4uZK9PmJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:a25:854c:: with SMTP id
 f12mr5761647ybn.95.1633625875202; Thu, 07 Oct 2021 09:57:55 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:37 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-12-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 11/21] perf metric: Document the internal 'struct metric'
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add documentation as part of code tidying.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c96f9fe163f9..632867cedbae 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -117,14 +117,34 @@ struct metric_ref_node {
 	struct list_head list;
 };
 
+/**
+ * The metric under construction. The data held here will be placed in a
+ * metric_expr.
+ */
 struct metric {
 	struct list_head nd;
+	/**
+	 * The expression parse context importantly holding the IDs contained
+	 * within the expression.
+	 */
 	struct expr_parse_ctx *pctx;
+	/** The name of the metric such as "IPC". */
 	const char *metric_name;
+	/** The expression to parse, for example, "instructions/cycles". */
 	const char *metric_expr;
+	/**
+	 * The "ScaleUnit" that scales and adds a unit to the metric during
+	 * output.
+	 */
 	const char *metric_unit;
+	/** The list of metrics referenced by this one. */
 	struct list_head metric_refs;
+	/** The size of the metric_refs list. */
 	int metric_refs_cnt;
+	/**
+	 * Is there a constraint on the group of events? In which case the
+	 * events won't be grouped.
+	 */
 	bool has_constraint;
 };
 
-- 
2.33.0.882.g93a45727a2-goog

