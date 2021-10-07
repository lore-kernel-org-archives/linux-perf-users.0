Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED0C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F9C061245
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbhJGRAD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242940AbhJGQ7l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 12:59:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F5C06176C
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 09:57:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i83-20020a252256000000b005b67a878f56so8659655ybi.17
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 09:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DRXwnUru7xgoQlQZBPBaHLCwbvQMtCPz5sk7TfyGYpk=;
        b=O71Aox/UUGHruIs/AOmd32Pn/YczSsMbirBlrq0Xhvb3aR3sNha6+QMYzo+n6Yzo6U
         s3qUwtDHwAp+XQK59Y7OWPAvZ+jDpkmzTZ6g6dZDY2OE48El8ASB7lj2OcrEhBFlLycc
         NE4qSUsM65Qp+0SUvsvhBL/iLXXsvEhoMFc/bUoVIfIAyxKoHyOxFdIVL96s+xfVZQt4
         4rDXFdPFnGOhp2Kw/FaMtnoKcPL3tPm1NBm3B+OTuy6DM9yvOpm1kmWRWFBf71ATSFJF
         GZZ/+kFLOhfK9kMtAWBaRw+slkjqOhWcQntS8dzqBlKNaagqN7VITRCXQXYiTN0c1v0j
         aH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DRXwnUru7xgoQlQZBPBaHLCwbvQMtCPz5sk7TfyGYpk=;
        b=wiyCHvRKVaxHQl34N2OESZOS7/dzabDHXAH0i8bMsyJyQC1+tO8A6imc9l384gOgwS
         0Og4g7+196qNA7UgbChoo/BEw9+uDqnuaEggAXMfsikPnbH3tHtnZyD5PH41jrJt5Mzp
         IuQKQjLYq86Q0nkDPaCdgmHxLcAXk89sIXBkKjR7QIgOAkx7prLlRwapa8czi3d+wwLE
         PdJPp7xI5HkvFs5KlYCc4B6qO7FiTRIiV5BEGgzx+3vOPjPr2bhCgiMdOwBeS6ya0NZW
         gCvJz7vogz4HhYuyEqlQaERXptgNnC4bd9LIPCoJsIYU+3tJdXDFkYm6fZH4Uw6u/75i
         QLxw==
X-Gm-Message-State: AOAM531amsophMT6lZtX+cD9lHj9vELlfFLo3T7vylsBfOVDipho6mBj
        lro/+7ggbGLEGXHR9lBJvCHX4TBICPsV
X-Google-Smtp-Source: ABdhPJyDtFeXrtaaJx6PsKS1cT2j7I41TGQMqtTvjfIFBYgmD5Heuc7/5QwlFAcMB8HpiDVFQq5Fxk/ZUMNQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:a25:b29a:: with SMTP id
 k26mr5529132ybj.451.1633625866445; Thu, 07 Oct 2021 09:57:46 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:33 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-8-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 07/21] perf metric: Add metric new and free
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

Metrics are complex enough that a new/free reduces the risk of memory
leaks. Move static functions used in new.

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
2.33.0.882.g93a45727a2-goog

