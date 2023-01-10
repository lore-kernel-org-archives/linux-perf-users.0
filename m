Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B90CC46467
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Jan 2023 22:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjAJWWr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Jan 2023 17:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbjAJWWH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Jan 2023 17:22:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4881232187
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jan 2023 14:21:21 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t13-20020a056902018d00b0074747131938so14203476ybh.12
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jan 2023 14:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/FtIYr0/RheXwrssHV0cFATW8LMtUvVk/N1uI6ptIqc=;
        b=RNYP627ovo2gwEzsZZbFylrtQb+tRstmx8+kwVlpER/K5C5tNb2oBe50zVPZpE1xuZ
         NU9zXXblOxx6EAKLVYDrvaw3SP0ZyRrbegvCU8UFWhy7tdpYKJsjdqHS8Q8fCYTB2AA1
         XfxIcjNfCJVewHShT9ogfUdkxa5rGgTTPcO795wa5pyopE3PY7OwUHSfWNK2py18qEHb
         lU9rAZ5slO3ij3YjOrOQ5FnhJPYOoz0FdvRAzlSJcgOtT3Q85Tvra/8+nQofX8xCCpMS
         FEo/8EYdWVgxNvEjlwcyYar4md8dE1bKiVeg7zyJe6xTPO25BRQ85Hz4YMsQr4Ew/YJj
         ifFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FtIYr0/RheXwrssHV0cFATW8LMtUvVk/N1uI6ptIqc=;
        b=zHmsNKQJP+fyaaDCVN4mMG0uPEkg3apjUB/cIi/pWv9dZp1yxGh6Zm6g0xzZTZXu1A
         fgzrBxAGClB0E35gdvg8gYovDZpYrQI5m7I0Uhhy+o5tmobIhQrubp+2a8fBgpH4AZ8p
         dyF8CnCqbvEg4suf9e8Ffrl0bRHLjhkLkGioX2LN4v8nvnCewgT+i6U3jn9A00I6PL9D
         oqpuVFm4Ohy/PqWSt64YeHHeVRHDr+MYRT2UKPYBaEFjVAckjEFP9cR70ku79gBJdySm
         gEW8vVg0mv5zZ6ntr+Ut47GRIy6h+pJgoW6o8J9TxLKgq8g2HiIKF86ma9OA+ZkMaNFs
         5v8g==
X-Gm-Message-State: AFqh2kqXOI6Teo2qZdo6fnXI22Mx6YlkL460CNZd279ZZoSmiAdEWCmP
        Rmbdv001Ybe8vz/vwtSjqnICfHTRN2nw
X-Google-Smtp-Source: AMrXdXt8x+kd9UlLPbZYhu5Ooy9hNfxVHcOZmgh4OR3ywtB1lSBt3xtVEtTcEV9ZxG+DMlVpkAwMcWwdvcU8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cebf:c37e:8184:56])
 (user=irogers job=sendgmr) by 2002:a25:8110:0:b0:6f6:ec71:8ede with SMTP id
 o16-20020a258110000000b006f6ec718edemr5909003ybk.422.1673389272586; Tue, 10
 Jan 2023 14:21:12 -0800 (PST)
Date:   Tue, 10 Jan 2023 14:20:02 -0800
In-Reply-To: <20230110222003.1591436-1-irogers@google.com>
Message-Id: <20230110222003.1591436-7-irogers@google.com>
Mime-Version: 1.0
References: <20230110222003.1591436-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 6/7] perf help: Use run_command_strbuf
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Qi Liu <liuqi115@huawei.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Xin Gao <gaoxin@cdjrlc.com>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stephane Eranian <eranian@google.com>,
        German Gomez <german.gomez@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Remove boiler plate by using library routine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-help.c | 47 ++++++++++++---------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 8874e1e0335b..1cb87358cd20 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -70,46 +70,27 @@ static const char *get_man_viewer_info(const char *name)
 static int check_emacsclient_version(void)
 {
 	struct strbuf buffer = STRBUF_INIT;
-	struct child_process ec_process;
-	const char *argv_ec[] = { "emacsclient", "--version", NULL };
-	int version;
 	int ret = -1;
 
-	/* emacsclient prints its version number on stderr */
-	memset(&ec_process, 0, sizeof(ec_process));
-	ec_process.argv = argv_ec;
-	ec_process.err = -1;
-	ec_process.stdout_to_stderr = 1;
-	if (start_command(&ec_process)) {
-		fprintf(stderr, "Failed to start emacsclient.\n");
-		return -1;
-	}
-	if (strbuf_read(&buffer, ec_process.err, 20) < 0) {
-		fprintf(stderr, "Failed to read emacsclient version\n");
-		goto out;
-	}
-	close(ec_process.err);
-
 	/*
-	 * Don't bother checking return value, because "emacsclient --version"
-	 * seems to always exits with code 1.
+	 * emacsclient may print its version number on stderr. Don't bother
+	 * checking return value, because some "emacsclient --version" commands
+	 * seem to always exits with code 1.
 	 */
-	finish_command(&ec_process);
+	run_command_strbuf("emacsclient --version 2>&1", &buffer);
 
-	if (!strstarts(buffer.buf, "emacsclient")) {
+	if (!strstarts(buffer.buf, "emacsclient"))
 		fprintf(stderr, "Failed to parse emacsclient version.\n");
-		goto out;
-	}
-
-	version = atoi(buffer.buf + strlen("emacsclient"));
+	else {
+		int version = atoi(buffer.buf + strlen("emacsclient"));
 
-	if (version < 22) {
-		fprintf(stderr,
-			"emacsclient version '%d' too old (< 22).\n",
-			version);
-	} else
-		ret = 0;
-out:
+		if (version < 22) {
+			fprintf(stderr,
+				"emacsclient version '%d' too old (< 22).\n",
+				version);
+		} else
+			ret = 0;
+	}
 	strbuf_release(&buffer);
 	return ret;
 }
-- 
2.39.0.314.g84b9a713c41-goog

