Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D9DC001B0
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 05:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjFWFpp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 01:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjFWFpg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 01:45:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14178213C
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 22:45:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5704970148dso2975427b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 22:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687499132; x=1690091132;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtB++6Z7uRp2nCpFPIxo1JwHrDFmcvBxfRdKUwuoqWw=;
        b=bDzILQhMXzrfU9fEWMg3KJEaLdiUdTcY+IfHtnfZExy0wZ+hACiNOtJzYLfaXYZLPb
         yT47bt/PbwN74hASHUftavYcnE7LtDLfs1S6YJYSzBxYljAuGk5JD1YEtRfQK04Wnomx
         GZM9AQ40i+rIxt4LfGQGAvklSmvwIcoetpqiSG+Xt/kTIUdZBojvT8/t6i7uMe+jvpXg
         XZ8/YJuJX8cc97BKjZwyH3kMgSiVCGdEI31eAdjKL0xEHC6n9VWVNYiTiz219aclaeXt
         SlO0RJ0sqWUvowGcgI1Ppo3YY4xEjkt6yUJwWs2Q5q5mtHTalvJCRw8nGPeV/msJUrBg
         bztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687499132; x=1690091132;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtB++6Z7uRp2nCpFPIxo1JwHrDFmcvBxfRdKUwuoqWw=;
        b=DUpqhLHZdp9aMiayI39j9LR49+q9h+U908WqLgFDPElEVPmCXRwpkfIDoVlbiiiR8H
         eCEARzBghUI32d74KOUYo2xfa7lb2nlsyBDrHoIm4rHCr+mYB+nNx7qjz10tes84AQjU
         KZJktOvPmLkq4aAEeGX8Nh8FW1CzU7oByTlTiJXUAJ4FWPQ8vIf+A5hChFO3twOFeHVR
         GdfPszn/2bBwc67d3AUGPcJyRuld6C5IOaBF6106Jb5i5za55nB95KySy16JZACt9E5W
         uzv25WyNApwDtTF/3pOyAzaLN6c3uF0DHNceDTHf+/i/ypuLCAdfB9Nwsk4Vjsbygobh
         DgDA==
X-Gm-Message-State: AC+VfDzek8oNRKk0opI8MA5ahMl5NYWikuHV4lqzZXo1hEot9LVI465A
        u0NpFfca6fDJca5X7Omo9nOyYFBln2Bc
X-Google-Smtp-Source: ACHHUZ64rHoVgDP/cgBIJCMPSTIGSXZBW1ifHlkWqVjtgMItk2WrQyAUm3wrv5AVfIG22AjUF9yXs8rpwrpQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a05:690c:727:b0:570:75a8:7869 with SMTP id
 bt7-20020a05690c072700b0057075a87869mr8456496ywb.5.1687499132354; Thu, 22 Jun
 2023 22:45:32 -0700 (PDT)
Date:   Thu, 22 Jun 2023 22:45:20 -0700
In-Reply-To: <20230623054520.4118442-1-irogers@google.com>
Message-Id: <20230623054520.4118442-4-irogers@google.com>
Mime-Version: 1.0
References: <20230623054520.4118442-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v3 3/3] perf symbol_conf: Remove now unused sort_by_name
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Wang <wangborong@cdjrlc.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Previously used to specify symbol_name_rb_node was in use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kallsyms.c   | 1 -
 tools/perf/builtin-lock.c       | 2 --
 tools/perf/builtin-report.c     | 1 -
 tools/perf/tests/builtin-test.c | 1 -
 tools/perf/util/probe-event.c   | 1 -
 tools/perf/util/symbol_conf.h   | 1 -
 6 files changed, 7 deletions(-)

diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index 3751df744577..7f75c5b73f26 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -62,7 +62,6 @@ int cmd_kallsyms(int argc, const char **argv)
 	if (argc < 1)
 		usage_with_options(kallsyms_usage, options);
 
-	symbol_conf.sort_by_name = true;
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
 	if (symbol__init(NULL) < 0)
 		return -1;
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 8b505e1e5002..da36ace66d68 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1774,7 +1774,6 @@ static int __cmd_report(bool display_info)
 	}
 
 	/* for lock function check */
-	symbol_conf.sort_by_name = true;
 	symbol_conf.allow_aliases = true;
 	symbol__init(&session->header.env);
 
@@ -1904,7 +1903,6 @@ static int __cmd_contention(int argc, const char **argv)
 		con.save_callstack = true;
 
 	/* for lock function check */
-	symbol_conf.sort_by_name = true;
 	symbol_conf.allow_aliases = true;
 	symbol__init(&session->header.env);
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index a31a23af5547..dcedfe00f04d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1676,7 +1676,6 @@ int cmd_report(int argc, const char **argv)
 			 * See symbol__browser_index.
 			 */
 			symbol_conf.priv_size += sizeof(u32);
-			symbol_conf.sort_by_name = true;
 		}
 		annotation_config__init(&report.annotation_opts);
 	}
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index aa44fdc84763..1f6557ce3b0a 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -542,7 +542,6 @@ int cmd_test(int argc, const char **argv)
 		return run_workload(workload, argc, argv);
 
 	symbol_conf.priv_size = sizeof(int);
-	symbol_conf.sort_by_name = true;
 	symbol_conf.try_vmlinux_path = true;
 
 	if (symbol__init(NULL) < 0)
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 277cb8f84cbc..16822a8a540f 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -74,7 +74,6 @@ int init_probe_symbol_maps(bool user_only)
 {
 	int ret;
 
-	symbol_conf.sort_by_name = true;
 	symbol_conf.allow_aliases = true;
 	ret = symbol__init(NULL);
 	if (ret < 0) {
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index f26f81eb8252..0b589570d1d0 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -18,7 +18,6 @@ struct symbol_conf {
 			show_kernel_path,
 			use_modules,
 			allow_aliases,
-			sort_by_name,
 			show_nr_samples,
 			show_total_period,
 			use_callchain,
-- 
2.41.0.162.gfafddb0af9-goog

