Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B97C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF541611CC
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbhJORYW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242216AbhJORYJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 13:24:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107C2C061768
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:22:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q193-20020a252aca000000b005ba63482993so12062974ybq.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VIstaeQZI+Wai2pCT/Op6Lej4RdHRlayXu4Tr6JUk5I=;
        b=q1J3JtNJJ1kshCH1EqjTELtYKZ8m9bnJNgikGIxAPGfgJxCk89t7lDL594BPCIHMfm
         A6TkQGPn0/U2GS+/+3z2942QzK3gEcHsoxMyErAU2FXOGuPiBFAfm4rr3dlw77mANMH0
         U5urjp7CQgTKZ9g494mTritxzUYx39Th3TqEoT3AveYNuWhqjPKryIoRfApgnf2BmzDB
         nxaVATydyZnBnIIjF8Rbas0h0gJxSSZhTTESDBNx/oTNWfURbuFRNq0JfPtjwDYkZ/ao
         Bkl5bFTwc6aB2UVqsBerAZ0hLeRBWQF3AG4wTkS4ImS4AQxVj/UhKCspZe0MdFu/1GLj
         yt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VIstaeQZI+Wai2pCT/Op6Lej4RdHRlayXu4Tr6JUk5I=;
        b=wNXhLUoJx4PrBrC48VScfEOg11gS81lteBQlvoaXZsZ4Pb1EvmRHzoKLBSz/13OD7U
         lmJaPbAt6wVFegoKj3HSleQLCuzbjVzVUFwrStuixEUtDsOrtVT1JF0U1JD9whGjXptA
         qhy/PPy5eNJQK3YHJUnHimNs9qVQ+9W4EQfjlAFQB4PRKGkpPeec07MAnq0LbMADDffk
         TS5zrizsEURTiXb0dQ9uLBSZv3wHRMAJeO9BN2zKZpeD0uEh8dwW/nWtXyoStsNYmhsO
         tcS2++HmOaR6zYbBiA7BgznCpK53ZrADibvukrYlMMjqsuuuF22v0a5zXpViisa+C+iL
         9Ozw==
X-Gm-Message-State: AOAM533pEaJw7H9AYYiGylYJg3vo6I9uQUEf5ma55S4kic7qZnRYifwQ
        Vc+r1kzSgpFRToi/KKyMDCpdi094kY7b
X-Google-Smtp-Source: ABdhPJzBwuzphw0oF1OFoSTxFeZCoVWrE6jEfofeP6uamj+zucSxkBKq213QVv9yCxoZ0BHAmlyoyYMJvjVQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:2a89:: with SMTP id
 q131mr14838277ybq.404.1634318522014; Fri, 15 Oct 2021 10:22:02 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:21 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-11-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 10/21] perf metric: Comment data structures.
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Document the data structures maintained by metricgroup.c and used by
stat-shadow.c for metric output.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 88ba939a3082..3a51a84f440b 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -14,24 +14,51 @@ struct rblist;
 struct pmu_events_map;
 struct cgroup;
 
+/**
+ * A node in a rblist keyed by the evsel. The global rblist of metric events
+ * generally exists in perf_stat_config. The evsel is looked up in the rblist
+ * yielding a list of metric_expr.
+ */
 struct metric_event {
 	struct rb_node nd;
 	struct evsel *evsel;
 	struct list_head head; /* list of metric_expr */
 };
 
+/**
+ * A metric referenced by a metric_expr. When parsing a metric expression IDs
+ * will be looked up, matching either a value (from metric_events) or a
+ * metric_ref. A metric_ref will then be parsed recursively. The metric_refs and
+ * metric_events need to be known before parsing so that their values may be
+ * placed in the parse context for lookup.
+ */
 struct metric_ref {
 	const char *metric_name;
 	const char *metric_expr;
 };
 
+/**
+ * One in a list of metric_expr associated with an evsel. The data is used to
+ * generate a metric value during stat output.
+ */
 struct metric_expr {
 	struct list_head nd;
+	/** The expression to parse, for example, "instructions/cycles". */
 	const char *metric_expr;
+	/** The name of the meric such as "IPC". */
 	const char *metric_name;
+	/**
+	 * The "ScaleUnit" that scales and adds a unit to the metric during
+	 * output. For example, "6.4e-05MiB" means to scale the resulting metric
+	 * by 6.4e-05 (typically converting a unit like cache lines to something
+	 * more human intelligible) and then add "MiB" afterward when displayed.
+	 */
 	const char *metric_unit;
+	/** Null terminated array of events used by the metric. */
 	struct evsel **metric_events;
+	/** Null terminated array of referenced metrics. */
 	struct metric_ref *metric_refs;
+	/** A value substituted for '?' during parsing. */
 	int runtime;
 };
 
-- 
2.33.0.1079.g6e70778dc9-goog

