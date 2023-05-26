Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9159C77B7A
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 18:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242720AbjEZSen (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 14:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243077AbjEZSei (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 14:34:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4088CE5F
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 11:34:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bac6a453dd5so1439835276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126069; x=1687718069;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dgS4bW/LPPYZcMd883xwHFW9R70V4XWRzq37gFrjkM=;
        b=bgnX3tHvnxBh+hNk28qU6inGr0/y2LJhEfbvcuQRohYwnnrlKxVB7iy2dE+dywqium
         teJ3G3jfu+qHbKplXF98m6HDRich3Y47wL1LBNy0KNtgpPMzNVm2vYcqoIeiAtkfIqpn
         2vJHV7PATwxSvidtCYUdHxCU4kQ/N+UEayfSDWtpigqFt/hsIoilKZ8grHFF4StxBNQZ
         P7vxEAnbfU6zt91OfQxdTR/e022OJx0ufl4/sj730SU0HyFtMDabKZDTap02I5GiX3XC
         kTVjSCUa9amEggALYlenAuuzoo/FEDFeA1WMYcTcqQh7l0ALVZ6Ib1MSpQ9RviHuBVM4
         ylGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126069; x=1687718069;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7dgS4bW/LPPYZcMd883xwHFW9R70V4XWRzq37gFrjkM=;
        b=efzV14xcRPYHHi79H5mg/i3A7sXNg00i2Rw8+x76rFHfci6ueYmu38xDmv3emZyC2q
         ftmcGkCQUbXBjTEHa2BhVH7AlhAySuYFgqRw7qkoWrjfuCuoB2HO2UmaPAj2NPtUldDi
         +qEDsQWxqGZMh2oHcpgEASFqxU12gs3avSxBxxd7rlhRbmg3xJ6HKfV85hXyuKheU+Zt
         TaKGgLTNulVIrjXLcWAdliOqWAnAviQxhbRZ9gRsjZbrmDX09/sx/WEZZKlxTtlKg7jJ
         KuA1xh9ueggh6S0Yo9F2EnyOqwQSYWnVkTf/7MBeJ0pbaG9G9eZZrlmtkeq6xm+eJ1vQ
         pP0g==
X-Gm-Message-State: AC+VfDw344wt+0TtUGvegZLj7Ypq6Ckm4kJ41ksjGP92aumh4jikPpJ1
        FCPTVOaGXVbe+mOOc3ezvCZSMenQaabC
X-Google-Smtp-Source: ACHHUZ7DPPPyFo87kLo9HcNC1/dJJRnRDA3Hd8hWgyFbUgHKQeXag/jlFPxc7zz4+KPLF7Fzu7/gs3i8NoA2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a05:6902:4ef:b0:ba8:2e69:9e06 with SMTP id
 w15-20020a05690204ef00b00ba82e699e06mr1430153ybs.1.1685126069227; Fri, 26 May
 2023 11:34:29 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:53 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-9-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 08/16] perf daemon: Dynamically allocate path to perf
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Avoid a PATH_MAX array in __daemon (the .data section) by dynamically
allocating the memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-daemon.c | 44 +++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 34cbe3e959aa..f5674d824a40 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -90,7 +90,7 @@ struct daemon {
 	char			*base;
 	struct list_head	 sessions;
 	FILE			*out;
-	char			 perf[PATH_MAX];
+	char			*perf;
 	int			 signal_fd;
 	time_t			 start;
 };
@@ -1490,6 +1490,14 @@ static int __cmd_ping(struct daemon *daemon, struct option parent_options[],
 	return send_cmd(daemon, &cmd);
 }
 
+static char *alloc_perf_exe_path(void)
+{
+	char path[PATH_MAX];
+
+	perf_exe(path, sizeof(path));
+	return strdup(path);
+}
+
 int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
@@ -1502,8 +1510,12 @@ int cmd_daemon(int argc, const char **argv)
 			"field separator", "print counts with custom separator", ","),
 		OPT_END()
 	};
+	int ret = -1;
+
+	__daemon.perf = alloc_perf_exe_path();
+	if (!__daemon.perf)
+		return -ENOMEM;
 
-	perf_exe(__daemon.perf, sizeof(__daemon.perf));
 	__daemon.out = stdout;
 
 	argc = parse_options(argc, argv, daemon_options, daemon_usage,
@@ -1511,22 +1523,22 @@ int cmd_daemon(int argc, const char **argv)
 
 	if (argc) {
 		if (!strcmp(argv[0], "start"))
-			return __cmd_start(&__daemon, daemon_options, argc, argv);
+			ret = __cmd_start(&__daemon, daemon_options, argc, argv);
 		if (!strcmp(argv[0], "signal"))
-			return __cmd_signal(&__daemon, daemon_options, argc, argv);
+			ret = __cmd_signal(&__daemon, daemon_options, argc, argv);
 		else if (!strcmp(argv[0], "stop"))
-			return __cmd_stop(&__daemon, daemon_options, argc, argv);
+			ret = __cmd_stop(&__daemon, daemon_options, argc, argv);
 		else if (!strcmp(argv[0], "ping"))
-			return __cmd_ping(&__daemon, daemon_options, argc, argv);
-
-		pr_err("failed: unknown command '%s'\n", argv[0]);
-		return -1;
-	}
-
-	if (setup_config(&__daemon)) {
-		pr_err("failed: config not found\n");
-		return -1;
+			ret = __cmd_ping(&__daemon, daemon_options, argc, argv);
+		else
+			pr_err("failed: unknown command '%s'\n", argv[0]);
+	} else {
+		ret = setup_config(&__daemon);
+		if (ret)
+			pr_err("failed: config not found\n");
+		else
+			ret = send_cmd_list(&__daemon);
 	}
-
-	return send_cmd_list(&__daemon);
+	zfree(&__daemon.perf);
+	return ret;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

