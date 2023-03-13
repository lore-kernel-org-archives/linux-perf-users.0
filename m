Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216E4C6FD19
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 11:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjCMLnY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 07:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjCMLmP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 07:42:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76F5664F0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:41:47 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id rj10so1128566pjb.4
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fUVJ64SEnuw/uEL+nd4TijpPo7wgQdrNlutXsuxFPw=;
        b=nx7x7sJa4vO1BZbZZBGq8aty9HkU1min3aeiiVvaQq9K/WZb1iYrPP6cZMgRoi0BSC
         MCGPxPk2OqlG0aD3oieBm6tQ4LTcebLcYiea0Po4kcBybtudYud3j0qvvTlGdw5QmFSt
         apXGeRgQ7OKmOWyAKKJXLQABCmttd50P8oiuxRfiFSOzkpa4SOIwdLLJQOwU8+jCah9R
         TYpzBYepRDAUb1oZiwRQN32eBjvXc/F2GvutMAJxJYBDceM1gGeHqm/3yGEQ6Jco8xHn
         5aIW6RHLYCBJFhsJsqpZFSGDAZKMxsi/SqEMCVow3DEQpF2IYElj2xFYYFVY9/moWYUg
         sB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fUVJ64SEnuw/uEL+nd4TijpPo7wgQdrNlutXsuxFPw=;
        b=6hJTPVtCPeHkYFnH0ODJbU+no0HoHE242N0cb6wlr5IJxKf8Vl0asKE1vPO4Ymh8+j
         kcu2bJdqM4DONSAmInFhRNM0qffpzF3qxaV4yygiQ30p404g5EQTafLTfXYuRS8x6Fzt
         AVd/iZhNHLc/YGvwBH8tQE7VVPjOZAubjWFxsGAoYMzEmM4n6Z0+7JAOsaInI1BL0IDb
         43oSiGeZTzY5UEvMfcFk2Qtxe7UP+7V4S4M+91pE8uupABz0eern2VGQuT7RZZYq0voz
         GARqAkFimvdN/DOv5DBjakdt5C5b2bVa67su3/f3oKWpuNsGY+5cofqYj50XtV/Fb7L2
         nwDA==
X-Gm-Message-State: AO0yUKVXOE/CgpOKt7dD9bsp8F5XPMZQYfJxNJ7ZJ9MYOPULEpVvoy1H
        SNxhd6+tIrlVqpu2flupHVQ1INN3nNKmY6SzHullcX3p
X-Google-Smtp-Source: AK7set9/gbxblXwWYHW32OewJZrcp/QcEEM5ARA+uHA/hI74499fd6JnXCDnNkB8KpRvMOYYdJFQZg==
X-Received: by 2002:a17:90a:3fce:b0:23b:33ef:7991 with SMTP id u14-20020a17090a3fce00b0023b33ef7991mr6439168pjm.49.1678707705816;
        Mon, 13 Mar 2023 04:41:45 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 15/16] perf kvm: Add TUI mode for stat report
Date:   Mon, 13 Mar 2023 19:40:17 +0800
Message-Id: <20230313114018.543254-16-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since we have supported histograms list and prepared the dimensions in
the tool, this patch adds TUI mode for stat report.  It also adds UI
progress for sorting for better user experience.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 109 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/kvm-stat.h |   1 +
 2 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index ab1cd6b5e528..3dd44763d1fc 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -23,6 +23,8 @@
 #include "util/data.h"
 #include "util/ordered-events.h"
 #include "util/kvm-stat.h"
+#include "ui/browsers/hists.h"
+#include "ui/progress.h"
 #include "ui/ui.h"
 #include "util/string2.h"
 
@@ -495,6 +497,7 @@ static int kvm_hpp_list__parse(struct perf_hpp_list *hpp_list,
 
 static int kvm_hists__init(void)
 {
+	kvm_hists.list.nr_header_lines = 1;
 	__hists__init(&kvm_hists.hists, &kvm_hists.list);
 	perf_hpp_list__init(&kvm_hists.list);
 	return kvm_hpp_list__parse(&kvm_hists.list, NULL, "ev_name");
@@ -506,6 +509,93 @@ static int kvm_hists__reinit(const char *output, const char *sort)
 	return kvm_hpp_list__parse(&kvm_hists.list, output, sort);
 }
 
+static void print_result(struct perf_kvm_stat *kvm);
+
+#ifdef HAVE_SLANG_SUPPORT
+static void kvm_browser__update_nr_entries(struct hist_browser *hb)
+{
+	struct rb_node *nd = rb_first_cached(&hb->hists->entries);
+	u64 nr_entries = 0;
+
+	for (; nd; nd = rb_next(nd)) {
+		struct hist_entry *he = rb_entry(nd, struct hist_entry,
+						 rb_node);
+
+		if (!he->filtered)
+			nr_entries++;
+	}
+
+	hb->nr_non_filtered_entries = nr_entries;
+}
+
+static int kvm_browser__title(struct hist_browser *browser,
+			      char *buf, size_t size)
+{
+	scnprintf(buf, size, "KVM event statistics (%lu entries)",
+		  browser->nr_non_filtered_entries);
+	return 0;
+}
+
+static struct hist_browser*
+perf_kvm_browser__new(struct hists *hists)
+{
+	struct hist_browser *browser = hist_browser__new(hists);
+
+	if (browser)
+		browser->title = kvm_browser__title;
+
+	return browser;
+}
+
+static int kvm__hists_browse(struct hists *hists)
+{
+	struct hist_browser *browser;
+	int key = -1;
+
+	browser = perf_kvm_browser__new(hists);
+	if (browser == NULL)
+		return -1;
+
+	/* reset abort key so that it can get Ctrl-C as a key */
+	SLang_reset_tty();
+	SLang_init_tty(0, 0, 0);
+
+	kvm_browser__update_nr_entries(browser);
+
+	while (1) {
+		key = hist_browser__run(browser, "? - help", true, 0);
+
+		switch (key) {
+		case 'q':
+			goto out;
+		default:
+			break;
+		}
+	}
+
+out:
+	hist_browser__delete(browser);
+	return 0;
+}
+
+static void kvm_display(struct perf_kvm_stat *kvm)
+{
+	if (!use_browser)
+		print_result(kvm);
+	else
+		kvm__hists_browse(&kvm_hists.hists);
+}
+
+#else
+
+static void kvm_display(struct perf_kvm_stat *kvm)
+{
+	use_browser = 0;
+	print_result(kvm);
+}
+
+#endif /* HAVE_SLANG_SUPPORT */
+
 static const char *get_filename_for_perf_kvm(void)
 {
 	const char *filename;
@@ -970,12 +1060,15 @@ static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
 
 static void sort_result(struct perf_kvm_stat *kvm)
 {
+	struct ui_progress prog;
 	const char *output_columns = "ev_name,sample,percent_sample,"
 				     "time,percent_time,max_t,min_t,mean_t";
 
 	kvm_hists__reinit(output_columns, kvm->sort_key);
+	ui_progress__init(&prog, kvm_hists.hists.nr_entries, "Sorting...");
 	hists__collapse_resort(&kvm_hists.hists, NULL);
 	hists__output_resort_cb(&kvm_hists.hists, NULL, filter_cb);
+	ui_progress__finish();
 }
 
 static void print_vcpu_info(struct perf_kvm_stat *kvm)
@@ -1577,7 +1670,14 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	if (!register_kvm_events_ops(kvm))
 		goto exit;
 
-	setup_pager();
+	if (kvm->use_stdio) {
+		use_browser = 0;
+		setup_pager();
+	} else {
+		use_browser = 1;
+	}
+
+	setup_browser(false);
 
 	kvm_hists__init();
 
@@ -1586,7 +1686,7 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 		goto exit;
 
 	sort_result(kvm);
-	print_result(kvm);
+	kvm_display(kvm);
 
 exit:
 	return ret;
@@ -1693,6 +1793,7 @@ kvm_events_report(struct perf_kvm_stat *kvm, int argc, const char **argv)
 		OPT_STRING('p', "pid", &kvm->opts.target.pid, "pid",
 			   "analyze events only for given process id(s)"),
 		OPT_BOOLEAN('f', "force", &kvm->force, "don't complain, do it"),
+		OPT_BOOLEAN(0, "stdio", &kvm->use_stdio, "use the stdio interface"),
 		OPT_END()
 	};
 
@@ -1710,6 +1811,10 @@ kvm_events_report(struct perf_kvm_stat *kvm, int argc, const char **argv)
 					   kvm_events_report_options);
 	}
 
+#ifndef HAVE_SLANG_SUPPORT
+	kvm->use_stdio = true;
+#endif
+
 	if (!kvm->opts.target.pid)
 		kvm->opts.target.system_wide = true;
 
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 35d03894fac3..bc6c8e38ef50 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -103,6 +103,7 @@ struct perf_kvm_stat {
 	unsigned int display_time;
 	bool live;
 	bool force;
+	bool use_stdio;
 };
 
 struct kvm_reg_events_ops {
-- 
2.34.1

