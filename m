Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C31DC64EC7
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Feb 2023 11:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjB1Lyp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 06:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjB1Ly0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Feb 2023 06:54:26 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9730D1ADF9
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 03:53:59 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n6so8729569plf.5
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 03:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vka5hEENrebUCtUQDb6QxOdSux5yvJVVDFWdnRM5OH4=;
        b=LuZN489tRCN6oK6BA+OsNGUWh56v5Mf9d78DHFd78kk4livA+xYsmWrdVv49UUpn1W
         VDZ9iHiS6gbWdr+J9JTbKUy4skmvI3o1eKVMfIVl/uIgPra9JkhN7TnJQBZjxYT3cW66
         u90d88y0FiEFFWK2dspKPXlPB43l9PJwjsjO+gfjDGKAdHOpwR6AxxZBkGgtMvnoWsZQ
         QvSc3AGsydj1JNVd7yMUo66yv6MyP5+azpSJX4NKARZEvkuVvS0rFRQVEtAnQEyy8sqy
         sJVO91uM09OE/vmMkrQhNtfHiACI5QZhXiRSI0MHPVYu2qZVvxdxLNR/jAlREbMnA9eh
         2MZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vka5hEENrebUCtUQDb6QxOdSux5yvJVVDFWdnRM5OH4=;
        b=5HeVrDNhJFKpnXJApj+zQ7huAvjMm8FcayP7dhwfbUcqZqpQ3FysfWAGkfEdzfP72T
         w0lubqEQQdfx7cmYJuTauyNcyejl5KVgMDLPFxr/sLr90ZfFbSwdnZIp3+sqPF072t/I
         8lLvMO0IGwi57dG0lgKUVq1cqKC2AkVCJ/O4opJVng1VIZnPsaLc7ghEfpBS0Z+wEjVl
         HOlg7F8tudGk83M8U2GJcO7YDWXXrEPUx1Wdk+cioQGQLe2YMjtJ3iMYbdrc5gdBMV+9
         jkIRPcQQMBOdBxeRQ/+Cl/35g2MxnKbXbgu6FMhhkzGNX+CjsBTU6SeccTScDu+YGYqe
         r2Qg==
X-Gm-Message-State: AO0yUKX6M0Iv/GJVqmSgBuilgZUyLQNks8LR0EeUpubfctgsYpsl8bq7
        Y40Kh6LMolPztZf2AADX+8bC2g==
X-Google-Smtp-Source: AK7set/UxcCdfdy+rKYFpJnGmvaiW97qDLRdiDoLdkxviklh7ZLYAXzDQj6HzM7yoJh0UXkSYROsnQ==
X-Received: by 2002:a17:90b:1d92:b0:237:c5cc:15bf with SMTP id pf18-20020a17090b1d9200b00237c5cc15bfmr3118153pjb.13.1677585238615;
        Tue, 28 Feb 2023 03:53:58 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:53:58 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 13/14] perf kvm: Add TUI mode for stat report
Date:   Tue, 28 Feb 2023 19:51:24 +0800
Message-Id: <20230228115125.144172-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228115125.144172-1-leo.yan@linaro.org>
References: <20230228115125.144172-1-leo.yan@linaro.org>
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
 tools/perf/builtin-kvm.c   | 110 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/kvm-stat.h |   1 +
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 5b1b2042dfed..56ad3346ba08 100644
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
 
@@ -506,10 +508,98 @@ static int kvm_hists__init(struct perf_kvm_stat *kvm)
 
 	__hists__init(&kvm_hists.hists, &kvm_hists.list);
 	perf_hpp_list__init(&kvm_hists.list);
+	kvm_hists.list.nr_header_lines = 1;
 	return kvm_hpp_list__parse(&kvm_hists.list, output_columns,
 				   kvm->sort_key);
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
@@ -988,8 +1078,12 @@ static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
 
 static void sort_result(void)
 {
+	struct ui_progress prog;
+
+	ui_progress__init(&prog, kvm_hists.hists.nr_entries, "Sorting...");
 	hists__collapse_resort(&kvm_hists.hists, NULL);
 	hists__output_resort_cb(&kvm_hists.hists, NULL, filter_cb);
+	ui_progress__finish();
 }
 
 static void print_vcpu_info(struct perf_kvm_stat *kvm)
@@ -1587,7 +1681,14 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
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
 
 	kvm_hists__init(kvm);
 
@@ -1596,7 +1697,7 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 		goto exit;
 
 	sort_result();
-	print_result(kvm);
+	kvm_display(kvm);
 
 exit:
 	return ret;
@@ -1703,6 +1804,7 @@ kvm_events_report(struct perf_kvm_stat *kvm, int argc, const char **argv)
 		OPT_STRING('p', "pid", &kvm->opts.target.pid, "pid",
 			   "analyze events only for given process id(s)"),
 		OPT_BOOLEAN('f', "force", &kvm->force, "don't complain, do it"),
+		OPT_BOOLEAN(0, "stdio", &kvm->use_stdio, "use the stdio interface"),
 		OPT_END()
 	};
 
@@ -1720,6 +1822,10 @@ kvm_events_report(struct perf_kvm_stat *kvm, int argc, const char **argv)
 					   kvm_events_report_options);
 	}
 
+#ifndef HAVE_SLANG_SUPPORT
+	kvm->use_stdio = true;
+#endif
+
 	if (!kvm->opts.target.pid)
 		kvm->opts.target.system_wide = true;
 
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index a8e919ca59f4..b66eb4e8c547 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -97,6 +97,7 @@ struct perf_kvm_stat {
 	unsigned int display_time;
 	bool live;
 	bool force;
+	bool use_stdio;
 };
 
 struct kvm_reg_events_ops {
-- 
2.34.1

