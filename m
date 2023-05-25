Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E1BC77B7A
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 07:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjEYHNF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 03:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbjEYHM0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 03:12:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A201DE4D
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8338f20bdso419679276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998736; x=1687590736;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JINgRbKyqeD/5xjEyB2Z8M27zbkpuoQ93P6f/ale0uI=;
        b=OP4afWsTIYHlIiVTegNyeLRIqJ2zMqeyRsGXo/7eq4nQ5gebMPUTViLGgtu89xP43w
         X25NyK2bhxqAHZtrw1issc4tRmXnff5EtFVyw+kq3E99WowlEQlVAV4935YOas6Bl/Bq
         LhMHBUoNbwpi0bpYt5T9maZQF4yoblT3yyX+IAZdUcmpyyuKxTOzG4miAldimh5JFUIB
         Hiu2a09aHEQYNjXmmZv0C//qoO+ntkS8zOpyqiIypFAXIpib6mKGDVU/UHRod0EfNM7Q
         nOsc/DeVMBBGfIoAUK4Fbqu4C3dpZ7W1WSvi/0P4y2uIevkTZhzXlmn9TyFaWIKeHC/j
         G8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998736; x=1687590736;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JINgRbKyqeD/5xjEyB2Z8M27zbkpuoQ93P6f/ale0uI=;
        b=bXsIIRToipXrLBFvNOFmCaZOuMk94qqZm7Kfm37MiW9/hYpIiG1Zz+8LNfaVrLljR1
         EBm/O81il8BUaPtYBLXUnE+PXieweBGS3ick6VnPQZTCsGqo559OjsqIuqQiLGk6R0PJ
         nAItPsJt1csu6YiD7pRnyOuBfUyzQRtV6u0B5nbW/yzLp+leOZM7C53iFhPINsMEJ3bA
         +AYPFZv9+IFSdj6QMyp0+GMWcBza3qgB9LHgv+rFzxtq7dKCf26706hZRDTzJ1KElwYh
         x7fr3v4noQRqVdtRuxC6qQF48U9HW377mfjAKDlrlcXcuMJBQ8PoRFEXUNV1vN6hj89t
         uxAQ==
X-Gm-Message-State: AC+VfDwRx/u89Lwj4jCyCgzyfF2uqxLmYq9z6aCnD1kPCvXX40JWOqBp
        DO5t75mLlJUA/V3shX+adhcmzB03lhx4
X-Google-Smtp-Source: ACHHUZ7sbw6AbhpElOgagS6t6+PV+X3bd3rUnq9Dqsw9hU6xB469HNKeglXDNdx1ojU0xz8YM86WvVJWnJUg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:7456:0:b0:ba7:1499:e202 with SMTP id
 p83-20020a257456000000b00ba71499e202mr1646377ybc.7.1684998736756; Thu, 25 May
 2023 00:12:16 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:25 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-9-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 08/16] perf daemon: Dynamically allocate path to perf
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
 tools/perf/builtin-daemon.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 34cbe3e959aa..adb5751c3ed0 100644
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
@@ -1490,6 +1490,15 @@ static int __cmd_ping(struct daemon *daemon, struct option parent_options[],
 	return send_cmd(daemon, &cmd);
 }
 
+static char *set_perf_exe(void)
+{
+	char path[PATH_MAX];
+
+	perf_exe(path, sizeof(path));
+	__daemon.perf = strdup(path);
+	return __daemon.perf;
+}
+
 int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
@@ -1503,7 +1512,9 @@ int cmd_daemon(int argc, const char **argv)
 		OPT_END()
 	};
 
-	perf_exe(__daemon.perf, sizeof(__daemon.perf));
+	if (!set_perf_exe())
+		return -ENOMEM;
+
 	__daemon.out = stdout;
 
 	argc = parse_options(argc, argv, daemon_options, daemon_usage,
-- 
2.40.1.698.g37aff9b760-goog

