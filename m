Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575CEC7EE2E
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 03:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbjFMDs0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 23:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjFMDsY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 23:48:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3621AD
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 20:48:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bc8c062d542so3225165276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 20:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686628103; x=1689220103;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFZEItTTBrSMUTBa58hKToUNkL4hMjjE5NbhujtdO6I=;
        b=sugIE8oskjJ0EeMybjZLw2QY8Hop8AEO4OtW23PCZWE3F2bKKMHhNiXsuJibFMMwGY
         o9JgVx3RwVyXpJif3Mj0k++i5lcshtCZnCpjD/0lbvoSGBi706rw/3HTUpwfpFDvvt6l
         R6JaGfUsg2ChbI9Lc4oNoQv9vp5k7VhrG92rk80H8sY6fT26z8Ca/LkSYbkAvWc+QHUc
         BND3MS/YPcPWMpbzXKIwqGGX3fonvC56Y6UQmkLh82amrlb3pdC3yS4MZuJZs68mxOWk
         Cv0L66ytK2vloI75LBX8XZkCUE0i8sfwHJkGWso6uGWxJuyaKFCWKdf09TQYNwDpwhPA
         Cn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686628103; x=1689220103;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFZEItTTBrSMUTBa58hKToUNkL4hMjjE5NbhujtdO6I=;
        b=jz9E48g8W8qT0hqYkGTolQWhiLC6b1wfW4TMF1z/qTuUYLQ8gl6m9j2P3Hs+20ZwSI
         T8PG9MDarriXZLbCIYB4CjHB1HLg3PD0v53SfUEbgeAxZno8NnSZHrXwPND6o0tdIbjy
         CkCrxlfv/miC3kPezGLZUyod05yZFdLHHtXAqdNk+cJ7U+wa/hWN4deGcpF7swD28yTQ
         3L8vd2C5MPS7rV4DZ1HGRlRJ8Gni+ySZ+0P3GKzYfZGqh3KB/zm/+zs28QnY1MLZF/DA
         /LBjpWduKImwhCrL78pW5BtqIBJ8yrmPF/uaEbFmaSgBgyO4Pl2LSWOl9xTzgpXC6R0t
         nrlQ==
X-Gm-Message-State: AC+VfDwhlP5Zn0y9pB4GoFyHG/uHFkU7UGND4WTFjcLojep9mri0DkLN
        T7KS3/oA1/FjEeiO8rgB5/8pBzkK+oBm
X-Google-Smtp-Source: ACHHUZ79nD4tHJp4BftcjKhgpKXuJELFAbzCZiWZNM9q+2bGeEAnsJjQvM5m0L1KgjOvrfxsRqfOhuz5toHp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a704:56d6:f79d:33e7])
 (user=irogers job=sendgmr) by 2002:a25:361f:0:b0:bc8:c749:eede with SMTP id
 d31-20020a25361f000000b00bc8c749eedemr299027yba.7.1686628102944; Mon, 12 Jun
 2023 20:48:22 -0700 (PDT)
Date:   Mon, 12 Jun 2023 20:48:16 -0700
In-Reply-To: <20230613034817.1356114-1-irogers@google.com>
Message-Id: <20230613034817.1356114-2-irogers@google.com>
Mime-Version: 1.0
References: <20230613034817.1356114-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 1/2] perf srcline: Make addr2line configuration failure
 more verbose
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Changbin Du <changbin.du@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

To aid debugging why it fails. Also, combine the loops for reading a
line for the llvm/binutils cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/srcline.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index aec596a0b0bb..d477332586b2 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -443,7 +443,7 @@ enum a2l_style {
 	LLVM,
 };
 
-static enum a2l_style addr2line_configure(struct child_process *a2l)
+static enum a2l_style addr2line_configure(struct child_process *a2l, const char *dso_name)
 {
 	static bool cached;
 	static enum a2l_style style;
@@ -452,6 +452,7 @@ static enum a2l_style addr2line_configure(struct child_process *a2l)
 		char buf[128];
 		struct io io;
 		int ch;
+		int lines;
 
 		if (write(a2l->in, ",\n", 2) != 2)
 			return BROKEN;
@@ -461,19 +462,29 @@ static enum a2l_style addr2line_configure(struct child_process *a2l)
 		if (ch == ',') {
 			style = LLVM;
 			cached = true;
+			lines = 1;
 		} else if (ch == '?') {
 			style = GNU_BINUTILS;
 			cached = true;
+			lines = 2;
 		} else {
-			style = BROKEN;
+			if (!symbol_conf.disable_add2line_warn) {
+				char *output = NULL;
+				size_t output_len;
+
+				io__getline(&io, &output, &output_len);
+				pr_warning("%s %s: addr2line configuration failed\n",
+					   __func__, dso_name);
+				pr_warning("\t%c%s", ch, output);
+			}
+			return BROKEN;
 		}
-		do {
+		while (lines) {
 			ch = io__get_char(&io);
-		} while (ch > 0 && ch != '\n');
-		if (style == GNU_BINUTILS) {
-			do {
-				ch = io__get_char(&io);
-			} while (ch > 0 && ch != '\n');
+			if (ch <= 0)
+				break;
+			if (ch == '\n')
+				lines--;
 		}
 		/* Ignore SIGPIPE in the event addr2line exits. */
 		signal(SIGPIPE, SIG_IGN);
@@ -593,12 +604,9 @@ static int addr2line(const char *dso_name, u64 addr,
 			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
 		goto out;
 	}
-	a2l_style = addr2line_configure(a2l);
-	if (a2l_style == BROKEN) {
-		if (!symbol_conf.disable_add2line_warn)
-			pr_warning("%s: addr2line configuration failed\n", __func__);
+	a2l_style = addr2line_configure(a2l, dso_name);
+	if (a2l_style == BROKEN)
 		goto out;
-	}
 
 	/*
 	 * Send our request and then *deliberately* send something that can't be interpreted as
-- 
2.41.0.162.gfafddb0af9-goog

