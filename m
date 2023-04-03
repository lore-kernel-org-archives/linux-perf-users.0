Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB87AC76188
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Apr 2023 18:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjDCSk7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Apr 2023 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjDCSk5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Apr 2023 14:40:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B2A1FFB
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Apr 2023 11:40:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 204-20020a250fd5000000b00b6d6655dc35so29395851ybp.6
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Apr 2023 11:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680547253;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OQK7cbtnodbre4T5ZwtzhEhf4nO9+j+KlezsUdFmQZQ=;
        b=tVpMl+fJ2xR7lGshQRG8xRUYufXwnq8dpRGhpAI0fUvm1QubgYJszmtczDFduajoEc
         Gjb+Mxoj/C1y43MH1OvB9FeAvS8xd/j5xCiPvF9H5sTVhFSyInMI5EG8AH3j4uMCFk9O
         dLHSQdjGXWWGeYgmMgU+S+moRUoj9DRdGJJLvS7aaFCwIxHlu3B0qD/xi3zB3FrYx1gR
         mPn2HrRXHHS1UXbtC3m5VrkqpE8XKejgsW/RQQN5qDpS9+fyZkm4qbUl6u9hSTKM2o65
         jWYyaoY97OoN/LgCizXu2GS77wjShHgrnCeDBvlsXli4xhG7xFS7zty9OoUc46HiatTB
         rH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547253;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQK7cbtnodbre4T5ZwtzhEhf4nO9+j+KlezsUdFmQZQ=;
        b=b3TB4xIKGQLH1otG+kQhC5aH/WAEfUb93yingqqG63wCWPmsV+sI70MGZyraiVyf15
         RUqqbxYhrjt9vxUB3wScH+tmcAjDUNtQo4pnvGn4T8Lw8K1cZE7BVGH0N2xGUJi0JlfE
         jy6tYbHI0hiyWlkiPTfojfiCckGPsunp/7Pf9UqVEoh5o0br75oospw9GgVn4zQkEUXS
         eEH61JD1eWBDlGrNnhLG0ngDBO2T5rIyuDEmH0C29xEAT1b56OdLch3PI9xPeMnJytPu
         vZ33Q/DUD5n1bcIOSHmnQXA8ZNPbxLpzpJkGPG/xjPBmMFC9uILNT/GWZPu7AEav4nin
         FPtg==
X-Gm-Message-State: AAQBX9faLL4lsvN0swTApK+VuibtdjQbT+fuIedbudPTOJJ7xSMb5ta2
        67yyP04/tsfuw9oqBvTmg2MbnJv5c7FL
X-Google-Smtp-Source: AKy350btQSLJY7hMC9l8QtYL9jayZ1N7Wt61vjnXmuX90sothMMahfnjDpIneYhVgGZY+63cibM1MdKNrvU7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9dc:a977:817d:341])
 (user=irogers job=sendgmr) by 2002:a05:690c:dd0:b0:533:a15a:d33e with SMTP id
 db16-20020a05690c0dd000b00533a15ad33emr11091433ywb.5.1680547253518; Mon, 03
 Apr 2023 11:40:53 -0700 (PDT)
Date:   Mon,  3 Apr 2023 11:40:30 -0700
In-Reply-To: <20230403184033.1836023-1-irogers@google.com>
Message-Id: <20230403184033.1836023-2-irogers@google.com>
Mime-Version: 1.0
References: <20230403184033.1836023-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2 1/4] tools api: Add io__getline
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

Reads a line to allocated memory up to a newline following the getline
API.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h        | 45 +++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/api-io.c | 36 +++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index 777c20f6b604..d5e8cf0dada0 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -7,7 +7,9 @@
 #ifndef __API_IO__
 #define __API_IO__
 
+#include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 
 struct io {
@@ -112,4 +114,47 @@ static inline int io__get_dec(struct io *io, __u64 *dec)
 	}
 }
 
+/* Read up to and including the first newline following the pattern of getline. */
+static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_len_out)
+{
+	char buf[128];
+	int buf_pos = 0;
+	char *line = NULL, *temp;
+	size_t line_len = 0;
+	int ch = 0;
+
+	/* TODO: reuse previously allocated memory. */
+	free(*line_out);
+	while (ch != '\n') {
+		ch = io__get_char(io);
+
+		if (ch < 0)
+			break;
+
+		if (buf_pos == sizeof(buf)) {
+			temp = realloc(line, line_len + sizeof(buf));
+			if (!temp)
+				goto err_out;
+			line = temp;
+			memcpy(&line[line_len], buf, sizeof(buf));
+			line_len += sizeof(buf);
+			buf_pos = 0;
+		}
+		buf[buf_pos++] = (char)ch;
+	}
+	temp = realloc(line, line_len + buf_pos + 1);
+	if (!temp)
+		goto err_out;
+	line = temp;
+	memcpy(&line[line_len], buf, buf_pos);
+	line[line_len + buf_pos] = '\0';
+	line_len += buf_pos;
+	*line_out = line;
+	*line_len_out = line_len;
+	return line_len;
+err_out:
+	free(line);
+	return -ENOMEM;
+}
+
 #endif /* __API_IO__ */
diff --git a/tools/perf/tests/api-io.c b/tools/perf/tests/api-io.c
index e91cf2c127f1..6aea84ca6673 100644
--- a/tools/perf/tests/api-io.c
+++ b/tools/perf/tests/api-io.c
@@ -289,6 +289,40 @@ static int test_get_dec(void)
 	return ret;
 }
 
+static int test_get_line(void)
+{
+	char path[PATH_MAX];
+	struct io io;
+	char test_string[1024];
+	char *line = NULL;
+	size_t i, line_len = 0;
+	size_t buf_size = 128;
+	int ret = 0;
+
+	for (i = 0; i < 512; i++)
+		test_string[i] = 'a';
+	test_string[512] = '\n';
+	for (i = 513; i < 1023; i++)
+		test_string[i] = 'b';
+	test_string[1023] = '\0';
+
+	if (setup_test(path, test_string, buf_size, &io))
+		return -1;
+
+	EXPECT_EQUAL((int)io__getline(&io, &line, &line_len), 513);
+	EXPECT_EQUAL((int)strlen(line), 513);
+	for (i = 0; i < 512; i++)
+		EXPECT_EQUAL(line[i], 'a');
+	EXPECT_EQUAL(line[512], '\n');
+	EXPECT_EQUAL((int)io__getline(&io, &line, &line_len), 510);
+	for (i = 0; i < 510; i++)
+		EXPECT_EQUAL(line[i], 'b');
+
+	free(line);
+	cleanup_test(path, &io);
+	return ret;
+}
+
 static int test__api_io(struct test_suite *test __maybe_unused,
 			int subtest __maybe_unused)
 {
@@ -300,6 +334,8 @@ static int test__api_io(struct test_suite *test __maybe_unused,
 		ret = TEST_FAIL;
 	if (test_get_dec())
 		ret = TEST_FAIL;
+	if (test_get_line())
+		ret = TEST_FAIL;
 	return ret;
 }
 
-- 
2.40.0.348.gf938b09366-goog

