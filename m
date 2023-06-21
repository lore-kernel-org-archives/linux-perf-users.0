Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5EAEB64D8
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 06:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjFUGjM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 02:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjFUGis (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 02:38:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7381FCB
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jun 2023 23:37:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57000a7480bso77071517b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jun 2023 23:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329476; x=1689921476;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtB++6Z7uRp2nCpFPIxo1JwHrDFmcvBxfRdKUwuoqWw=;
        b=CvgZ8AT0/FLCeoPngA5QS3EYZKUYh9uzv3Tm/IW6sDQDZtn+30OdFC8FX43ZEZKdEh
         r0eNvfGu8hUjeAIHhFHlvAgyDDT6UUmxKftbpTqy0mY3thy3X7SGHqSRPAAyaiUyQ2yt
         yxiVt+3Gw7ZAZCwK2B6Qea5APuWej0VodQ/aRWUlHjp+/+Q6bNeByhnQ01uibf4Xm6nu
         mwkLrXduorSMRcEi3UWS88pUcxP3bPCMTcbQFaWGotIN477yGLgDk0Tz8TMHdmuKq4Mt
         M4/EJyLFBlkYOm8E/wz07zukvwSZT0BhUPDvyLok+jqVFw6rt1WQfows7i0xgyJT3dLe
         BnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329476; x=1689921476;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtB++6Z7uRp2nCpFPIxo1JwHrDFmcvBxfRdKUwuoqWw=;
        b=OjZX+TXhhTlZZqS+0he5QKOJio9D27g7V6A78qIZilkEL8QHXnkX0hrUMO0r0CAw1C
         DhhrEdwZvnvhl2ZCmfS2VZY46y/Oyq7PqlBQYrXuxGCJoz2kjuXWtQtxUtZvgS3BfO1K
         x75eFCWmba/y0XutZyvHENQMALLsNQtCbkxXw2XGWQ+0hTzD1jckEB8tRnQfFXBH8kSI
         +PjxbAYcK1c0isLSRei2tczKu+yYWSTWAc5Ap/tZEjMG7yEFJLaAeacUxuk5/f4aNsdf
         4G9+a6z+X4oCLfSHtfTJ5wsSlsBRX7F+8dxpjijDS975d/xPV4zWNx3kYf1Lwo2weNu1
         nqWw==
X-Gm-Message-State: AC+VfDwnU2hXps9NfQMJXuwgEFK3XR1ynphBtWcWWzV0s9tHR74H3nnk
        QmeNNhugFhhW0vNyKBilO1bV8aOGBWG3
X-Google-Smtp-Source: ACHHUZ7z8fFTDElvzTHJBlYhiCv64lD5HeXdbu8NZw+V0ydijRelk06T/Nm99L/GVVCg8r7jRJGzh7gxInNh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8d1d:a59f:1372:6fb3])
 (user=irogers job=sendgmr) by 2002:a81:c60a:0:b0:573:8757:4124 with SMTP id
 l10-20020a81c60a000000b0057387574124mr1348878ywi.2.1687329475971; Tue, 20 Jun
 2023 23:37:55 -0700 (PDT)
Date:   Tue, 20 Jun 2023 23:37:49 -0700
In-Reply-To: <20230621063749.3358430-1-irogers@google.com>
Message-Id: <20230621063749.3358430-2-irogers@google.com>
Mime-Version: 1.0
References: <20230621063749.3358430-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 2/2] perf symbol_conf: Remove now unused sort_by_name
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

