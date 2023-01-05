Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F96DC54EBF
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Jan 2023 08:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjAEI1Q (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Jan 2023 03:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjAEI0s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Jan 2023 03:26:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589404C706
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Jan 2023 00:26:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n190-20020a25dac7000000b007447d7a25e4so35656343ybf.9
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jan 2023 00:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7v/gEXdtTx+UxkZcAUgCVgz4MqYf6krsrfnmQSxx5Nk=;
        b=MOmoDn853XiABNLgzeFY1zINcWjdyYDZgMjA+UzzOZtj9lI8m9iFChZ8xKfl5yhu7m
         GgQ4eeoUjNQwcCp66d6+VkJLXk5f1vbaPSLFAy/6UxTPSUznUMcPxKpfnw2XsTl8fgsi
         bkDwzfeHUylhi+VwwPOZh1rvzAuP2xf/p0aBbDEckSzuITvMJZGzno5h8Cz8WLU90KIv
         95qcS0l7viSe07zEj+JjfkIKsgR4APZLrfGfEpD0xTWlxPrztm2446P9poO+EtTxj4Us
         ChabmwB0Gr7DT0OlsTqIhWL1e6E1yn5yVkl+xeuXIf4/TFzX/r0cfmm5xtQi6gbpnaLo
         ECOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7v/gEXdtTx+UxkZcAUgCVgz4MqYf6krsrfnmQSxx5Nk=;
        b=QlgfibjyvjHiSYxPqIRiDSICHG5rhgtm8mO7/rT5+isv061qsVNrCEf2c615oJF6DB
         grP9EBs07dYj7z0+GZTJmk75WF3u0+8bn87NNnW/m8CrJz3EwJBeNiX2A50x+je3KDkC
         wf9ptpZNGhglBnR3spka8657Hbgw1EX1aNaVwhATOyzoa/6JCHgc25Y36ox37nfBi4C3
         mX0RFcfnMC5dn40MvaZcm6JEAdL+TyOGmk+sdYQhmf2EcNhz0XRACnws2VEnu9I+7Lbz
         c3ChOZpsw1oQuxFvqg/rVKuIbQuWB8ONb5qUVyqaGL/ULgjsfB+zoXiIYnOMgY3OUL1r
         /znw==
X-Gm-Message-State: AFqh2kp5TVfjz8mKCU4jUCVzzRLAAm8bTep6EnuAhCN4rUpNAvRso0+z
        GPeE+MOBhB04Tp5mM29daAcrwo2tr1qz
X-Google-Smtp-Source: AMrXdXuewYyrwXwhMLNamHCQBtT1ApP5gJHM/sJsyBFYGsV/bQVTiEcy1qsCqV8yZhxZzVYytEaqhDTrPA5G
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8775:c864:37e:2f9b])
 (user=irogers job=sendgmr) by 2002:a0d:dbce:0:b0:4ad:7104:1f63 with SMTP id
 d197-20020a0ddbce000000b004ad71041f63mr1246510ywe.49.1672907206617; Thu, 05
 Jan 2023 00:26:46 -0800 (PST)
Date:   Thu,  5 Jan 2023 00:26:09 -0800
Message-Id: <20230105082609.344538-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1] perf llvm: Fix inadvertent file creation
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
        Tom Rix <trix@redhat.com>, Ian Rogers <irogers@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The LLVM template is first echo-ed into command_out and then
command_out executed. The echo surrounds the template with double
quotes, however, the template itself may contain quotes. This is
generally innocuous but in tools/perf/tests/bpf-script-test-prologue.c
we see:
...
SEC("func=null_lseek file->f_mode offset orig")
...
where the first double quote ends the double quote of the echo, then
the > redirects output into a file called f_mode.

To avoid this inadvertent behavior substitute redirects and similar
characters to be ASCII control codes, then substitute the output in
the echo back again.

Fixes: 5eab5a7ee032 ("perf llvm: Display eBPF compiling command in debug output")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/llvm-utils.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 650ffe336f3a..4e8e243a6e4b 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -531,14 +531,37 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 
 	pr_debug("llvm compiling command template: %s\n", template);
 
+	/*
+	 * Below, substitute control characters for values that can cause the
+	 * echo to misbehave, then substitute the values back.
+	 */
 	err = -ENOMEM;
-	if (asprintf(&command_echo, "echo -n \"%s\"", template) < 0)
+	if (asprintf(&command_echo, "echo -n \a%s\a", template) < 0)
 		goto errout;
 
+#define SWAP_CHAR(a, b) do { if (*p == a) *p = b; } while (0)
+	for (char *p = command_echo; *p; p++) {
+		SWAP_CHAR('<', '\001');
+		SWAP_CHAR('>', '\002');
+		SWAP_CHAR('"', '\003');
+		SWAP_CHAR('\'', '\004');
+		SWAP_CHAR('|', '\005');
+		SWAP_CHAR('&', '\006');
+		SWAP_CHAR('\a', '"');
+	}
 	err = read_from_pipe(command_echo, (void **) &command_out, NULL);
 	if (err)
 		goto errout;
 
+	for (char *p = command_out; *p; p++) {
+		SWAP_CHAR('\001', '<');
+		SWAP_CHAR('\002', '>');
+		SWAP_CHAR('\003', '"');
+		SWAP_CHAR('\004', '\'');
+		SWAP_CHAR('\005', '|');
+		SWAP_CHAR('\006', '&');
+	}
+#undef SWAP_CHAR
 	pr_debug("llvm compiling command : %s\n", command_out);
 
 	err = read_from_pipe(template, &obj_buf, &obj_buf_sz);
-- 
2.39.0.314.g84b9a713c41-goog

