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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C13C47E4B
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA5F613F1
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhGOQKf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbhGOQKd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B14C061765;
        Thu, 15 Jul 2021 09:07:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m11-20020a05600c3b0bb0290228f19cb433so6398254wms.0;
        Thu, 15 Jul 2021 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gH/d2C/m7SH/VAGyzpEBHsSs1nSbLkvhvImcOI7Iy0=;
        b=mSW3DrcKpYrCebiadzQM25TKUrrqyUV1DD7dy/i5lUNp/RApxCSkboeK1KUS6zafln
         db0vsRft9r23a5djMVNwCiiaUITc9xWr7K1B6rtIaUnZ7IPyNiFh8KgwcR+5P1NExF2M
         YWMzaKGaPpomEL6L7v/P+1mrJ2/ESvsBJq5HJRXPlpu8jkfVJtazB/8IN1XuBaZ+5W6B
         OfxbuToYQZIma7s2EZgj3mVOlbiy+yK+iLsHi4+iuHUTrUR6bqITHTvLg04LmH6z4/G0
         QQCcfk61RGGcTqblVx3hGaecCgPYteObzLimsGz8tv7JzpHKfqsA98iSwlR9g3kQifV9
         Vp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gH/d2C/m7SH/VAGyzpEBHsSs1nSbLkvhvImcOI7Iy0=;
        b=MVkJGPDl29oPUQgd0hdK17ll2SWsLN6zB6ZnZxf4J7PSWFSTc95OSXJ8kY/CI6gzoS
         SVTSKrOqkiDbDapXvROw0wGd0+Gvuaz+rAsgT2tNQtAKSH3tlqRR51yzHMlTE3Pg03Xp
         MXxMsCbk2ZSc5yzChz9tBckyKlkMORjwemA4oWPkja9Vr/A8o7uOJ2vO+BBs/JWQD2hN
         Abbv/+iF36S6n6mrRcIaqRpFkMZ1uPf+DkYNUDph7kchJVzvhQ15yIp6/q2jeMtKdD2I
         HE3aTjAKQLrMhxrYvZiAMpUiuoYXJTwf0wBtd3d6TcHmbbZ+s/XHliOibEFw1mm7x0CA
         SuRA==
X-Gm-Message-State: AOAM531AcHLqAx2RP4308EUkYjLtFLuO9c2fahLC2Au0ECcEC9zCM/gK
        abg+z4L7EWqSzeyGXZMNBoo=
X-Google-Smtp-Source: ABdhPJxDvjMTsOm9UAD1M8waDz0Kc0MkWn2zll2eckjqrNn7R4rQZYP691eg/9/WLVgRgrjt9GITqA==
X-Received: by 2002:a1c:1dc6:: with SMTP id d189mr5510329wmd.154.1626365257616;
        Thu, 15 Jul 2021 09:07:37 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:37 -0700 (PDT)
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
Subject: [PATCH 09/20] perf report: free generated help strings for sort option
Date:   Thu, 15 Jul 2021 18:07:14 +0200
Message-Id: <a38b13f02812a8a6759200b9063c6191337f44d4.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports the memory leak of the strings allocated by sort_help when
running perf report.

This patch changes the returned pointer to char* (instead of const char*),
saves it in a temporary variable, and finally deallocates it at function
exit.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-report.c | 33 ++++++++++++++++++++++-----------
 tools/perf/util/sort.c      |  2 +-
 tools/perf/util/sort.h      |  2 +-
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 6386af6a2612367c..dc0364f671b97d26 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1175,6 +1175,8 @@ int cmd_report(int argc, const char **argv)
 		.annotation_opts	 = annotation__default_options,
 		.skip_empty		 = true,
 	};
+	char *sort_order_help = sort_help("sort by key(s):");
+	char *field_order_help = sort_help("output field(s): overhead period sample ");
 	const struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
@@ -1209,9 +1211,9 @@ int cmd_report(int argc, const char **argv)
 	OPT_BOOLEAN(0, "header-only", &report.header_only,
 		    "Show only data header."),
 	OPT_STRING('s', "sort", &sort_order, "key[,key2...]",
-		   sort_help("sort by key(s):")),
+		   sort_order_help),
 	OPT_STRING('F', "fields", &field_order, "key[,keys...]",
-		   sort_help("output field(s): overhead period sample ")),
+		   field_order_help),
 	OPT_BOOLEAN(0, "show-cpu-utilization", &symbol_conf.show_cpu_utilization,
 		    "Show sample percentage for different cpu modes"),
 	OPT_BOOLEAN_FLAG(0, "showcpuutilization", &symbol_conf.show_cpu_utilization,
@@ -1344,11 +1346,11 @@ int cmd_report(int argc, const char **argv)
 	char sort_tmp[128];
 
 	if (ret < 0)
-		return ret;
+		goto exit;
 
 	ret = perf_config(report__config, &report);
 	if (ret)
-		return ret;
+		goto exit;
 
 	argc = parse_options(argc, argv, options, report_usage, 0);
 	if (argc) {
@@ -1362,8 +1364,10 @@ int cmd_report(int argc, const char **argv)
 		report.symbol_filter_str = argv[0];
 	}
 
-	if (annotate_check_args(&report.annotation_opts) < 0)
-		return -EINVAL;
+	if (annotate_check_args(&report.annotation_opts) < 0) {
+		ret = -EINVAL;
+		goto exit;
+	}
 
 	if (report.mmaps_mode)
 		report.tasks_mode = true;
@@ -1377,12 +1381,14 @@ int cmd_report(int argc, const char **argv)
 	if (symbol_conf.vmlinux_name &&
 	    access(symbol_conf.vmlinux_name, R_OK)) {
 		pr_err("Invalid file: %s\n", symbol_conf.vmlinux_name);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto exit;
 	}
 	if (symbol_conf.kallsyms_name &&
 	    access(symbol_conf.kallsyms_name, R_OK)) {
 		pr_err("Invalid file: %s\n", symbol_conf.kallsyms_name);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto exit;
 	}
 
 	if (report.inverted_callchain)
@@ -1406,12 +1412,14 @@ int cmd_report(int argc, const char **argv)
 
 repeat:
 	session = perf_session__new(&data, false, &report.tool);
-	if (IS_ERR(session))
-		return PTR_ERR(session);
+	if (IS_ERR(session)) {
+		ret = PTR_ERR(session);
+		goto exit;
+	}
 
 	ret = evswitch__init(&report.evswitch, session->evlist, stderr);
 	if (ret)
-		return ret;
+		goto exit;
 
 	if (zstd_init(&(session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed. Reported data may be incomplete.\n");
@@ -1646,5 +1654,8 @@ int cmd_report(int argc, const char **argv)
 
 	zstd_fini(&(session->zstd_data));
 	perf_session__delete(session);
+exit:
+	free(sort_order_help);
+	free(field_order_help);
 	return ret;
 }
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 88ce47f2547e3558..568a88c001c6cb5a 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -3370,7 +3370,7 @@ static void add_hpp_sort_string(struct strbuf *sb, struct hpp_dimension *s, int
 		add_key(sb, s[i].name, llen);
 }
 
-const char *sort_help(const char *prefix)
+char *sort_help(const char *prefix)
 {
 	struct strbuf sb;
 	char *s;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 87a092645aa72e41..b67c469aba79587f 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -302,7 +302,7 @@ void reset_output_field(void);
 void sort__setup_elide(FILE *fp);
 void perf_hpp__set_elide(int idx, bool elide);
 
-const char *sort_help(const char *prefix);
+char *sort_help(const char *prefix);
 
 int report_parse_ignore_callees_opt(const struct option *opt, const char *arg, int unset);
 
-- 
2.31.1

