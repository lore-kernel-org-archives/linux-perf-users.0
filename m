Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639D1C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B95560273
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbhJORYJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242237AbhJORYC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 13:24:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9F7C06176A
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:21:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso12111327ybj.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rsYPFR1jhYl+rt/YSejsll2uuYIPQ++qbGkxFjBNOBE=;
        b=TUaJpJoGUek7AuGhL69HnX6CeQOu9+kmVisSSauyZM0x5XXo+Jz5QYHUy2ErCyW0RP
         SBroCJnUlt8AiSQBxGAHkKkMGhSqDKcUYdOMo39ao+1l53Oy9D6qTY6FBtZ1VPy2qnAh
         Vpgmzwtk4BQRzDBumAK/I1kbsYda+EXDuzOfS73WGJB0uqO0OIuw70Jc0Zsp1AhvCxZ0
         lbuuej50Muuc4geLT/X1qoXENWdbSdcGbds6qJG/da1dnwR5uFYfdgHDGolypQPJkeI9
         oM2qFdQ3qcE5hhycyViVIgtL1aglmdenvl405vdLoSwwgPPdxYErA2fqN5y3NxTN5m8P
         VghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rsYPFR1jhYl+rt/YSejsll2uuYIPQ++qbGkxFjBNOBE=;
        b=0nryOD+DsfoTSI6TihRJrFLLrGZKGgjxHYJDvX+4CeRWAXcLWdMZxdLfXvDFF8Y5FO
         i0YsFrKZj6DcqVRGlXQ0R/yAzZTuXMr0F+FLDnHMOYfkEaDEPexABZ1MRANTu1f67KkE
         vVQz+b+N793fIEyPu3aAeRO5HBcHIE6QMj2TK60w/9rZVqx0V3A/ZiL4ykSwRgK2pvPy
         mUJsUBBHcPGVDeNUWIfOGnl6SLR046sogesO1LvECyqAmzl47mHNLjYKHkUl/+ayTxWs
         8jhVZeUVwi1b9DcMySj+ZAG3TyFd06c/ydIsmrxKwGNXEmS1uDGcFQFjT8sa7tgodPbx
         J7UA==
X-Gm-Message-State: AOAM530rDn3EoWYOaLtTjDfcclIhlDmR4EVj9ST0xhVV50tvlaUi9nUv
        f27ybDU5yFaq8MoNboSujgwUqjcH/psU
X-Google-Smtp-Source: ABdhPJxRsJGUxnaywkkW6o2x/B1uRvDpggoDuH3uqALPZJq9gOp7swAXh4OEqiw57r+i7bX3q8pBinG+FWbk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:1487:: with SMTP id
 129mr15316536ybu.206.1634318515023; Fri, 15 Oct 2021 10:21:55 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:18 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-8-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 07/21] perf metric: Add metric new and free
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

Metrics are complex enough that a new/free reduces the risk of memory
leaks. Move static functions used in new.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 137 +++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 62 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 3e5f02938452..e4ce19389258 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -127,6 +127,78 @@ struct metric {
 	bool has_constraint;
 };
 
+static void metricgroup___watchdog_constraint_hint(const char *name, bool foot)
+{
+	static bool violate_nmi_constraint;
+
+	if (!foot) {
+		pr_warning("Splitting metric group %s into standalone metrics.\n", name);
+		violate_nmi_constraint = true;
+		return;
+	}
+
+	if (!violate_nmi_constraint)
+		return;
+
+	pr_warning("Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:\n"
+		   "    echo 0 > /proc/sys/kernel/nmi_watchdog\n"
+		   "    perf stat ...\n"
+		   "    echo 1 > /proc/sys/kernel/nmi_watchdog\n");
+}
+
+static bool metricgroup__has_constraint(const struct pmu_event *pe)
+{
+	if (!pe->metric_constraint)
+		return false;
+
+	if (!strcmp(pe->metric_constraint, "NO_NMI_WATCHDOG") &&
+	    sysctl__nmi_watchdog_enabled()) {
+		metricgroup___watchdog_constraint_hint(pe->metric_name, false);
+		return true;
+	}
+
+	return false;
+}
+
+static struct metric *metric__new(const struct pmu_event *pe,
+				  bool metric_no_group,
+				  int runtime)
+{
+	struct metric *m;
+
+	m = zalloc(sizeof(*m));
+	if (!m)
+		return NULL;
+
+	m->pctx = expr__ctx_new();
+	if (!m->pctx) {
+		free(m);
+		return NULL;
+	}
+
+	m->metric_name = pe->metric_name;
+	m->metric_expr = pe->metric_expr;
+	m->metric_unit = pe->unit;
+	m->pctx->runtime = runtime;
+	m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
+	INIT_LIST_HEAD(&m->metric_refs);
+	m->metric_refs_cnt = 0;
+
+	return m;
+}
+
+static void metric__free(struct metric *m)
+{
+	struct metric_ref_node *ref, *tmp;
+
+	list_for_each_entry_safe(ref, tmp, &m->metric_refs, list) {
+		list_del(&ref->list);
+		free(ref);
+	}
+	expr__ctx_free(m->pctx);
+	free(m);
+}
+
 #define RECURSION_ID_MAX 1000
 
 struct expr_ids {
@@ -736,39 +808,6 @@ static void metricgroup__add_metric_non_group(struct strbuf *events,
 	}
 }
 
-static void metricgroup___watchdog_constraint_hint(const char *name, bool foot)
-{
-	static bool violate_nmi_constraint;
-
-	if (!foot) {
-		pr_warning("Splitting metric group %s into standalone metrics.\n", name);
-		violate_nmi_constraint = true;
-		return;
-	}
-
-	if (!violate_nmi_constraint)
-		return;
-
-	pr_warning("Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:\n"
-		   "    echo 0 > /proc/sys/kernel/nmi_watchdog\n"
-		   "    perf stat ...\n"
-		   "    echo 1 > /proc/sys/kernel/nmi_watchdog\n");
-}
-
-static bool metricgroup__has_constraint(const struct pmu_event *pe)
-{
-	if (!pe->metric_constraint)
-		return false;
-
-	if (!strcmp(pe->metric_constraint, "NO_NMI_WATCHDOG") &&
-	    sysctl__nmi_watchdog_enabled()) {
-		metricgroup___watchdog_constraint_hint(pe->metric_name, false);
-		return true;
-	}
-
-	return false;
-}
-
 int __weak arch_get_runtimeparam(const struct pmu_event *pe __maybe_unused)
 {
 	return 1;
@@ -813,23 +852,10 @@ static int __add_metric(struct list_head *metric_list,
 		 * We got in here for the parent group,
 		 * allocate it and put it on the list.
 		 */
-		m = zalloc(sizeof(*m));
+		m = metric__new(pe, metric_no_group, runtime);
 		if (!m)
 			return -ENOMEM;
 
-		m->pctx = expr__ctx_new();
-		if (!m->pctx) {
-			free(m);
-			return -ENOMEM;
-		}
-		m->metric_name = pe->metric_name;
-		m->metric_expr = pe->metric_expr;
-		m->metric_unit = pe->unit;
-		m->pctx->runtime = runtime;
-		m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
-		INIT_LIST_HEAD(&m->metric_refs);
-		m->metric_refs_cnt = 0;
-
 		parent = expr_ids__alloc(ids);
 		if (!parent) {
 			free(m);
@@ -877,8 +903,7 @@ static int __add_metric(struct list_head *metric_list,
 	 */
 	if (expr__find_ids(pe->metric_expr, NULL, m->pctx) < 0) {
 		if (m->metric_refs_cnt == 0) {
-			expr__ctx_free(m->pctx);
-			free(m);
+			metric__free(m);
 			*mp = NULL;
 		}
 		return -EINVAL;
@@ -1251,25 +1276,13 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 	return ret;
 }
 
-static void metric__free_refs(struct metric *metric)
-{
-	struct metric_ref_node *ref, *tmp;
-
-	list_for_each_entry_safe(ref, tmp, &metric->metric_refs, list) {
-		list_del(&ref->list);
-		free(ref);
-	}
-}
-
 static void metricgroup__free_metrics(struct list_head *metric_list)
 {
 	struct metric *m, *tmp;
 
 	list_for_each_entry_safe (m, tmp, metric_list, nd) {
-		metric__free_refs(m);
-		expr__ctx_free(m->pctx);
 		list_del_init(&m->nd);
-		free(m);
+		metric__free(m);
 	}
 }
 
-- 
2.33.0.1079.g6e70778dc9-goog

