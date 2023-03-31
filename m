Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF8CC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Fri, 31 Mar 2023 00:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCaAtp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Mar 2023 20:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCaAtn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Mar 2023 20:49:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACAD1204C
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2023 17:49:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54196bfcd5fso201391067b3.4
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2023 17:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680223771;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7oxd+W11NuknN5NF+IipV44WcyCkZNF/Dx6bcDvAiT8=;
        b=KsdyLKvSEFbnoBYCu2r2O888p0VE6efe0Pok+IhIFZthAU349DLJX2KPXHXB/YmZ7v
         mqWXRt6Cui7RbnAl+H+RBTwTdjrkrkoOdWmkqGI60wgpg/VK4A0DjJkm1PxmV5wmsOx1
         /TeYIQRcpu8HeSdv+xV9cGuDj+CPMoM2H8xJezT2JtwjmZHXevlnRAxN2onqgLnXMkeA
         EJDZ/Nl86FZA8YtiYDFWL2Jm/bKeDJQwcYdL68R3O+T3zup/3G56JVWmzwmNq/aDsw+n
         uwF5zl6K2NJEFZLTHkC4NMlAfkl8xzX0aeG22x4iUU1azRjNX2TV5k4/fX69Dedt2TWV
         xFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680223771;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oxd+W11NuknN5NF+IipV44WcyCkZNF/Dx6bcDvAiT8=;
        b=0vUKBr5gQNWugMipPvAxQM9n5sQFPhtmL36Z9Q178d1uGglDXAKS3gxLlu/VJWBoNJ
         frumE6EDRDrhW7E1TyIJ7bRcP6hZ7sjw6el9DTl9hGXte86ONl+cuRpSRFl9oZWcPmTG
         4xwffcaIF23zJtaOVB2BPM6fw/ecgL2b+6+w0vI4NY/zgfJL7enNvVBbp98Tv4GbDvFY
         QYUqq2Y95mFMmAUal01VXofcMEeA0sjYYmKDUdM8813GE/gUeptjNmPLqxVoFMLgdRjp
         7CJh70MkHb1xgwCYdqJ0Z0ss83lHs23eAO7RMpgyKoMerx3T24ZTKg64Fa3ED0arnh81
         GO5Q==
X-Gm-Message-State: AAQBX9eMQXX+FPYUDplaQ35LWhlAtD6WJnnjr5y/EQpSUuOBqPR+gphm
        7fHbD/dizauSG/J1MQp8J74wpsoFxFsM
X-Google-Smtp-Source: AKy350bDVwr8m1Oc+vefnZXhKJxJxJ5yTGusejTrFkjb+CBfOpCsR2pfVEtuUYmLYwF0e9gCesDEytfcOd9V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:11ea:eb75:e48c:2c04])
 (user=irogers job=sendgmr) by 2002:a05:6902:18cd:b0:b78:45fd:5f01 with SMTP
 id ck13-20020a05690218cd00b00b7845fd5f01mr15780898ybb.7.1680223770977; Thu,
 30 Mar 2023 17:49:30 -0700 (PDT)
Date:   Thu, 30 Mar 2023 17:48:43 -0700
In-Reply-To: <20230331004844.1592789-1-irogers@google.com>
Message-Id: <20230331004844.1592789-4-irogers@google.com>
Mime-Version: 1.0
References: <20230331004844.1592789-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 3/4] perf srcline: Support for llvm-addr2line
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
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The sentinel value differs for llvm-addr2line. Configure this once and
then detect when reading records.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/srcline.c | 65 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 2da86e57215d..423ddf3967b0 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -435,7 +435,50 @@ static struct child_process *addr2line_subprocess_init(const char *addr2line_pat
 	return a2l;
 }
 
+enum a2l_style {
+	BROKEN,
+	GNU_BINUTILS,
+	LLVM,
+};
+
+static enum a2l_style addr2line_configure(struct child_process *a2l)
+{
+	static bool cached;
+	static enum a2l_style style;
+
+	if (!cached) {
+		char buf[128];
+		struct io io;
+		int ch;
+
+		if (write(a2l->in, ",\n", 2) != 2)
+			return BROKEN;
+
+		io__init(&io, a2l->out, buf, sizeof(buf));
+		ch = io__get_char(&io);
+		if (ch == ',') {
+			style = LLVM;
+			cached = true;
+		} else if (ch == '?') {
+			style = GNU_BINUTILS;
+			cached = true;
+		} else {
+			style = BROKEN;
+		}
+		do {
+			ch = io__get_char(&io);
+		} while (ch > 0 && ch != '\n');
+		if (style == GNU_BINUTILS) {
+			do {
+				ch = io__get_char(&io);
+			} while (ch > 0 && ch != '\n');
+		}
+	}
+	return style;
+}
+
 static int read_addr2line_record(struct io *io,
+				 enum a2l_style style,
 				 char **function,
 				 char **filename,
 				 unsigned int *line_nr)
@@ -462,6 +505,12 @@ static int read_addr2line_record(struct io *io,
 
 	if (io__getline(&line, &line_len, io) < 0 || !line_len)
 		goto error;
+
+	if (style == LLVM && line_len == 2 && line[0] == ',') {
+		zfree(&line);
+		return 0;
+	}
+
 	if (function != NULL)
 		*function = strdup(strim(line));
 
@@ -471,7 +520,8 @@ static int read_addr2line_record(struct io *io,
 	if (io__getline(&line, &line_len, io) < 0 || !line_len)
 		goto error;
 
-	if (filename_split(line, line_nr == NULL ? &dummy_line_nr : line_nr) == 0) {
+	if (filename_split(line, line_nr == NULL ? &dummy_line_nr : line_nr) == 0 &&
+	    style == GNU_BINUTILS) {
 		ret = 0;
 		goto error;
 	}
@@ -523,6 +573,7 @@ static int addr2line(const char *dso_name, u64 addr,
 	char buf[128];
 	ssize_t written;
 	struct io io;
+	enum a2l_style a2l_style;
 
 	if (!a2l) {
 		if (!filename__has_section(dso_name, ".debug_line"))
@@ -538,6 +589,12 @@ static int addr2line(const char *dso_name, u64 addr,
 			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
 		goto out;
 	}
+	a2l_style = addr2line_configure(a2l);
+	if (a2l_style == BROKEN) {
+		if (!symbol_conf.disable_add2line_warn)
+			pr_warning("%s: addr2line configuration failed\n", __func__);
+		goto out;
+	}
 
 	/*
 	 * Send our request and then *deliberately* send something that can't be interpreted as
@@ -557,7 +614,8 @@ static int addr2line(const char *dso_name, u64 addr,
 	}
 	io__init(&io, a2l->out, buf, sizeof(buf));
 
-	switch (read_addr2line_record(&io, &record_function, &record_filename, &record_line_nr)) {
+	switch (read_addr2line_record(&io, a2l_style,
+				      &record_function, &record_filename, &record_line_nr)) {
 	case -1:
 		if (!symbol_conf.disable_add2line_warn)
 			pr_warning("%s %s: could not read first record\n", __func__, dso_name);
@@ -567,7 +625,7 @@ static int addr2line(const char *dso_name, u64 addr,
 		 * The first record was invalid, so return failure, but first read another
 		 * record, since we asked a junk question and have to clear the answer out.
 		 */
-		switch (read_addr2line_record(&io, NULL, NULL, NULL)) {
+		switch (read_addr2line_record(&io, a2l_style, NULL, NULL, NULL)) {
 		case -1:
 			if (!symbol_conf.disable_add2line_warn)
 				pr_warning("%s %s: could not read delimiter record\n",
@@ -606,6 +664,7 @@ static int addr2line(const char *dso_name, u64 addr,
 
 	/* We have to read the records even if we don't care about the inline info. */
 	while ((record_status = read_addr2line_record(&io,
+						      a2l_style,
 						      &record_function,
 						      &record_filename,
 						      &record_line_nr)) == 1) {
-- 
2.40.0.348.gf938b09366-goog

