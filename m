Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2AFC43334
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Jul 2022 20:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiGGUin (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Jul 2022 16:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiGGUim (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Jul 2022 16:38:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FB71CFD8
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Jul 2022 13:38:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j2-20020a2597c2000000b0064b3e54191aso14565403ybo.20
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Jul 2022 13:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MtmsWhHJfa7z6EGDAwuHnwZvzmYyvpgdzqZZqyHQmxU=;
        b=SvBsyqgeUtFCOrwSGE21tf7OVIzDLVqlgjC31Qjwz3eXSGy3keVTu5byI7NFAGM13Z
         DKHnL2hMKDyFYZseWOr8PLiB0Z0MexDr92vfEzihUDHIDr8H1Xgg+mWVtw7dPggcnx69
         AagT5Dlkmpn1tzFrNeW84M801vDVhdHqKZMJKndqrF/re3dWM95/ex/dj8vFDlhQr+ge
         pnWso1m+u2J6AVT+Rh1IqAdfTLTCWAcIAyypt3QQJ65nCETR8nmjDUyelkY856lyCp3z
         yejGaPAC2scFt6i7Z0k19x9RgCGB1O883p6rUoMhvDnbzoqfrlyiqzrszPLV3O92Dd/j
         pHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MtmsWhHJfa7z6EGDAwuHnwZvzmYyvpgdzqZZqyHQmxU=;
        b=oMNnVGKfJoKQ5jSO1odQeudULCY0aTHtiwHQ5r71EaOFtR4++34IghyXOBrLh2DpT0
         lXlHLG8t5NybRJQUmxdRgAP1vHsq6RWv6WrHZAoJHa4XQcv5vjxvh+CtkRHHXrxj3Ckm
         sME2p+udS4GALBtmPcrJ3Hq1WNHLaa9iGmd6jntucsEEGY6YYQWrrhc1K1D4iy1Tm0xa
         9RDcHjMcAtP+Ofbud6f1XTf9MRvGjkbROWTQ428GoAibDgE4P285PhdPRgQHQ86BVQ70
         pOuw7tVxy8H9HwvPFzJCjf7uTHlW6kkZRwWoaUfCvVbNyfDxot4hIfbI2Ijkw22D2qY3
         UY1g==
X-Gm-Message-State: AJIora9ajPSGVnjmVX4muF89yZmFnAT6UOx0/hxq89Vyd6Hsn+1VlVLp
        3oUDhgYcW5o4/Qp2La0RlBLEU/P2yKbS
X-Google-Smtp-Source: AGRyM1vslLtKenxRif28iTau2qVy76RKBRFTYtWiRIc+Cm3GzLY4Tsaqyt6Jd+NeqkRZ7LehqxcUHpVuKay+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf75:f79:d509:a8d1])
 (user=irogers job=sendgmr) by 2002:a0d:cc8c:0:b0:31d:1154:b730 with SMTP id
 o134-20020a0dcc8c000000b0031d1154b730mr10257ywd.440.1657226320914; Thu, 07
 Jul 2022 13:38:40 -0700 (PDT)
Date:   Thu,  7 Jul 2022 13:38:36 -0700
Message-Id: <20220707203836.345918-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2] perf gtk: Only support --gtk if compiled in
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        xaizek <xaizek@posteo.net>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If HAVE_GTK2_SUPPORT isn't defined then --gtk can't succeed, don't
support it as a command line option in this case.

v2. Is a rebase. Patch appears to have been missed in:
https://lore.kernel.org/lkml/Ygu40djM1MqAfkcF@kernel.org/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 8 ++++++++
 tools/perf/builtin-report.c   | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 2ffe071dbcff..f839e69492e8 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -50,7 +50,9 @@ struct perf_annotate {
 	bool	   use_tui;
 #endif
 	bool	   use_stdio, use_stdio2;
+#ifdef HAVE_GTK2_SUPPORT
 	bool	   use_gtk;
+#endif
 	bool	   skip_missing;
 	bool	   has_br_stack;
 	bool	   group_set;
@@ -526,7 +528,9 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_BOOLEAN('q', "quiet", &quiet, "do now show any message"),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
+#ifdef HAVE_GTK2_SUPPORT
 	OPT_BOOLEAN(0, "gtk", &annotate.use_gtk, "Use the GTK interface"),
+#endif
 #ifdef HAVE_SLANG_SUPPORT
 	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
 #endif
@@ -614,10 +618,12 @@ int cmd_annotate(int argc, const char **argv)
 	if (annotate_check_args(&annotate.opts) < 0)
 		return -EINVAL;
 
+#ifdef HAVE_GTK2_SUPPORT
 	if (symbol_conf.show_nr_samples && annotate.use_gtk) {
 		pr_err("--show-nr-samples is not available in --gtk mode at this time\n");
 		return ret;
 	}
+#endif
 
 	ret = symbol__validate_sym_arguments();
 	if (ret)
@@ -656,8 +662,10 @@ int cmd_annotate(int argc, const char **argv)
 	else if (annotate.use_tui)
 		use_browser = 1;
 #endif
+#ifdef HAVE_GTK2_SUPPORT
 	else if (annotate.use_gtk)
 		use_browser = 2;
+#endif
 
 	setup_browser(true);
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index afe4a5539ecc..91ed41cc7d88 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -74,7 +74,9 @@ struct report {
 #ifdef HAVE_SLANG_SUPPORT
 	bool			use_tui;
 #endif
+#ifdef HAVE_GTK2_SUPPORT
 	bool			use_gtk;
+#endif
 	bool			use_stdio;
 	bool			show_full_info;
 	bool			show_threads;
@@ -1227,7 +1229,9 @@ int cmd_report(int argc, const char **argv)
 #ifdef HAVE_SLANG_SUPPORT
 	OPT_BOOLEAN(0, "tui", &report.use_tui, "Use the TUI interface"),
 #endif
+#ifdef HAVE_GTK2_SUPPORT
 	OPT_BOOLEAN(0, "gtk", &report.use_gtk, "Use the GTK2 interface"),
+#endif
 	OPT_BOOLEAN(0, "stdio", &report.use_stdio,
 		    "Use the stdio interface"),
 	OPT_BOOLEAN(0, "header", &report.header, "Show data header."),
@@ -1516,8 +1520,10 @@ int cmd_report(int argc, const char **argv)
 	else if (report.use_tui)
 		use_browser = 1;
 #endif
+#ifdef HAVE_GTK2_SUPPORT
 	else if (report.use_gtk)
 		use_browser = 2;
+#endif
 
 	/* Force tty output for header output and per-thread stat. */
 	if (report.header || report.header_only || report.show_threads)
-- 
2.37.0.rc0.161.g10f37bed90-goog

