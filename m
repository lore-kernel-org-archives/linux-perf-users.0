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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BB7C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADED61186
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhHUJVQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbhHUJUs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B729C0612E7;
        Sat, 21 Aug 2021 02:20:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w5so25224867ejq.2;
        Sat, 21 Aug 2021 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYCZWFJIc++fa6HHlc4YfaHaR0UFJ1cN64ckPkTe/mE=;
        b=YnreBb68LiGNZPOjvwGEyR6jPj/i+sVhr1Z7zn2xSsRcwjbhgJN+AXLDnUEbfIHyJK
         Mm+RFqaxbHNsKJbj0rP/6inIPRCoJInpdOcV3tHEWWaV/BiywMyIBlG+TbIjp0e3FaLb
         VUZ+twcHjZnYLHiD6CQxRVjvFFct6zJkUFiX5T8bX6LTPNngQJHhdq+wNlApAYxA8BPn
         ckEHKjIBcA51FJG9ODsna2tkPVCNvsD1IA3Tx8igZJ8stXn5tvF+CJOEU2viagGGigkT
         l5iEjyQ3ZzYaLfkfwjaKjs08ScoC4hC4ClAvWenZfPwd5nZ/J8dffIDweqXnccbMYskQ
         oXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYCZWFJIc++fa6HHlc4YfaHaR0UFJ1cN64ckPkTe/mE=;
        b=q8lXm4qas2wK8DfdtdpE/mUqEcioWbeZDFFPneJGNbWOIHZTkPmY3J3xiD+cHzZMVC
         f172eznvD9ZAqpHrBX2BFIlFvn24FOotrBuT71zLoo3OjtrJ5h8vo0ufKzUsmtRPvSPE
         CRAxZh/7nJUVO6FEdlyAXB1DzHOxO3xiUUp9VDAL532i0/Etbxv067DGUsb7k3tNqcrJ
         B0/IMvpVQFl7vAcuu27Rj3OU0OrbOIL3lYujWa7dXKAX1WuOI1M5tdXZHudU+ibHnsFn
         Cv2/BRP20l0SphLDHxS6TbhXMvl5xZSYPh+zxtxL4xmIS2PKYuDCHdNE4lVg7KFaxBuO
         IVlQ==
X-Gm-Message-State: AOAM530V56Nya0ecnwCkTQheSOvbMC8rOmbS73OXzZyD66rIwheGroOs
        gt+0I4d32aziUmlMc+1XtXY=
X-Google-Smtp-Source: ABdhPJyce9hWXTkxRNdvnxtjxseU74yk9B1zgj+Ux05n1XUE6rDGvaA9arGsiHRn6W4IjKsc0RnpfQ==
X-Received: by 2002:a17:906:408d:: with SMTP id u13mr26070763ejj.344.1629537600562;
        Sat, 21 Aug 2021 02:20:00 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:00 -0700 (PDT)
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
Subject: [RFC PATCH v1 10/37] perf evlist: add multithreading helper
Date:   Sat, 21 Aug 2021 11:19:16 +0200
Message-Id: <34d8ec75acb56fbbbef08fee8be8404015e682cd.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds the function evlist__for_each_evsel_cpu, which executes
the given function on each evsel, for each cpu.

If perf_singlethreaded is unset, this function will use a workqueue to
execute the function.

This helper function will be used in the following patches.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evlist.c | 117 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h |  14 +++++
 2 files changed, 131 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3d55d9a53b9f4875..f9fdbd85a163ee97 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -27,6 +27,8 @@
 #include "util/perf_api_probe.h"
 #include "util/evsel_fprintf.h"
 #include "util/evlist-hybrid.h"
+#include "util/util.h"
+#include "util/workqueue/workqueue.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
@@ -41,6 +43,7 @@
 #include <sys/prctl.h>
 
 #include <linux/bitops.h>
+#include <linux/kernel.h>
 #include <linux/hash.h>
 #include <linux/log2.h>
 #include <linux/err.h>
@@ -369,6 +372,120 @@ static int evlist__is_enabled(struct evlist *evlist)
 	return false;
 }
 
+struct evlist_work {
+	struct work_struct work;
+	struct evlist *evlist;
+	int cpu;
+	evsel__cpu_func func;
+	void *args;
+	int ret;
+};
+
+static void evlist__for_each_evsel_cpu_thread_func(struct work_struct *_work)
+{
+	struct evlist_work *work = container_of(_work, struct evlist_work, work);
+	int cpu_idx, ret, err = 0;
+	struct evsel *pos;
+
+	work->ret = 0;
+	evlist__for_each_entry(work->evlist, pos) {
+		cpu_idx = evsel__find_cpu(pos, work->cpu);
+		if (cpu_idx < 0)
+			continue;
+		ret = work->func(work->evlist, pos, cpu_idx, work->args);
+		if (ret) {
+			work->ret = ret;
+			if (err < 0)		// error
+				return;
+		}
+	}
+}
+
+static int evlist__for_each_evsel_cpu_multithreaded(struct evlist *evlist,
+					evsel__cpu_func func, void *args)
+{
+	int i, cpu, ret;
+	struct evlist_work *works;
+	char errbuf[WORKQUEUE_STRERR_BUFSIZE];
+
+	works = calloc(perf_cpu_map__nr(evlist->core.all_cpus), sizeof(*works));
+	perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpus) {
+		init_work(&works[i].work);
+		works[i].evlist = evlist;
+		works[i].work.func = evlist__for_each_evsel_cpu_thread_func;
+		works[i].cpu = cpu;
+		works[i].func = func;
+		works[i].args = args;
+		works[i].ret = 0;
+
+		ret = schedule_work_on(cpu, &works[i].work);
+		if (ret) {
+			workqueue_strerror(global_wq, ret, errbuf, sizeof(errbuf));
+			pr_debug("schedule_work: %s\n", errbuf);
+			break;
+		}
+	}
+
+	ret = flush_scheduled_work();
+	if (ret) {
+		workqueue_strerror(global_wq, ret, errbuf, sizeof(errbuf));
+		pr_debug("flush_scheduled_work: %s\n", errbuf);
+		goto out;
+	}
+
+	perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpus) {
+		if (works[i].ret) {
+			ret = works[i].ret;
+			if (works[i].ret < 0)		// error
+				goto out;
+		}
+	}
+out:
+	free(works);
+
+	return ret;
+}
+
+static int evlist__for_each_evsel_cpu_singlethreaded(struct evlist *evlist,
+					evsel__cpu_func func, void *args)
+{
+	int ret, err = 0, i, cpu, cpu_idx;
+	struct affinity affinity;
+	struct evsel *pos;
+
+	if (affinity__setup(&affinity) < 0)
+		return -1;
+
+	evlist__for_each_cpu(evlist, i, cpu) {
+		affinity__set(&affinity, cpu);
+
+		evlist__for_each_entry(evlist, pos) {
+			cpu_idx = evsel__find_cpu(pos, cpu);
+			if (cpu_idx < 0)
+				continue;
+			ret = func(evlist, pos, cpu_idx, args);
+			if (ret) {
+				err = ret;
+				if (err < 0)		// error
+					goto out;
+			}
+		}
+	}
+
+out:
+	affinity__cleanup(&affinity);
+	return err;
+}
+
+int evlist__for_each_evsel_cpu(struct evlist *evlist, evsel__cpu_func func, void *args)
+{
+	if (perf_singlethreaded)
+		return evlist__for_each_evsel_cpu_singlethreaded(evlist, func, args);
+	else
+		return evlist__for_each_evsel_cpu_multithreaded(evlist, func, args);
+
+}
+
 static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index fde893170c7ba6d2..5f24a45d4e3cf30a 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -363,4 +363,18 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
 
 int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
 void evlist__check_mem_load_aux(struct evlist *evlist);
+
+/**
+ * evsel__cpu_func - function to run on each evsel for each cpu
+ * @evlist: the parent evlist
+ * @evsel: the processed evsel
+ * @cpu: index of the cpu in evsel->core.cpus
+ * @args: additional custom arguments
+ *
+ * Returns:
+ * A negative value is considered as an error.
+ * A positive value will be propagated to evlist__for_each_evsel_cpu.
+ */
+typedef int (*evsel__cpu_func)(struct evlist *evlist, struct evsel *evsel, int cpu, void *args);
+int evlist__for_each_evsel_cpu(struct evlist *evlist, evsel__cpu_func func, void *args);
 #endif /* __PERF_EVLIST_H */
-- 
2.31.1

