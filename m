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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFB9C4707F
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 23:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AEB613E6
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 23:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhEYXKL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 May 2021 19:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhEYXKK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 May 2021 19:10:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A25FC061574;
        Tue, 25 May 2021 16:08:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k14so46419800eji.2;
        Tue, 25 May 2021 16:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMIRIsHLMYiKVFve9WI8BvWkkQom+eJGIC8aLafFd2g=;
        b=iu78D2ggrcUFYDJlVxmxtlsw156D8XzmKADrIzyXy8r8VxmwQVaL5mBRD1h+a6iUCS
         UkeTlAvXvSXxvK1LjcAkorSqX3x1vGxKeefI6CjZANkV0Aasvs105Pern4f0a9v08Fbg
         WQbQyABp87lnZ/LJYmy+IDaV6gHj6yuFsmz7rA/Xzx340DYJv5PX/hMl9R5AytVS2L+e
         yhYuiFn3HE8x69SnhXV26Gpxpz6YUfPp/M8+TEHFJduDjL+huEpZYr+ejdL30PdZBHH7
         q8Z6RpAFC0cJU8vYq9kWs0LNdpJxiQElA/cpn+3MzqGd/qefhQsCSAOTZP4G3sz8T069
         jsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMIRIsHLMYiKVFve9WI8BvWkkQom+eJGIC8aLafFd2g=;
        b=MPSVuBcZ2kJ4yAvG5x/bvrsBJ2Ylox/3C1js16wpC30omDFOQaE0BiVhSTbiAz9LvF
         trZsLwbiAoJxgjWdAdGeh27l3Ub10Axg5osTtNfzS8srnYUiwO3GMhRf9GOJf3d2Kz9L
         egU3vqyX2O6w5T3xUjhDDTeGw0Q/p20ZroDFsQHsIN56Bb+LLRf8C8iGHCGECZiz0qoL
         29Dfa9+t+y3P8KqjbGk2MDB2zNZn9+ZLI4SLuxEhTXBSmRi1xiHM/amf0CFfDw3g8XVb
         Jn3Y5rrMn0fVA2DZ6fJIOmKjknSvIZydY0zw+9+ett0NfoVSusHyw9MtJz1kp/5msvYw
         HYjQ==
X-Gm-Message-State: AOAM533vdyGFMlgp5VHPou8YpTDoRyp/Mr2rVQNp73TwTpXCcCafdkOu
        uKTjE144DgFVB2PbZ90/9kU=
X-Google-Smtp-Source: ABdhPJwkpxBEU2nDrZql3qdShqoqOCyWG4dUJfB5Q/sCUy6gDy3AUMxa0yYJEmFc15N9+4NI8itNWw==
X-Received: by 2002:a17:906:2da1:: with SMTP id g1mr30604791eji.47.1621984117792;
        Tue, 25 May 2021 16:08:37 -0700 (PDT)
Received: from honeypot.. ([151.29.82.133])
        by smtp.googlemail.com with ESMTPSA id c6sm5511027eje.9.2021.05.25.16.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 16:08:37 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Fabian Hemmer <copy@copy.sh>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: iterate over shell tests in alphabetical order
Date:   Wed, 26 May 2021 01:05:17 +0200
Message-Id: <20210525230521.244553-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

for_each_shell_test macro iterated over all shell tests in the directory
using readdir, which does not guarantee any ordering, causing
problems on certain fs. However, the order in which they are visited
determines the id of the test, in case one wants to run a single test.

This patch replaces readdir with scandir using alphabetical sorting.
This guarantees that, given the same set of tests, all machines will
see the tests in the same order, and, thus, that test ids are
consistent.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 38 ++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c4b888f18e9ca..cbbfe48ab8029 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -510,8 +510,8 @@ static const char *shell_test__description(char *description, size_t size,
 	return description ? strim(description + 1) : NULL;
 }
 
-#define for_each_shell_test(dir, base, ent)	\
-	while ((ent = readdir(dir)) != NULL)	\
+#define for_each_shell_test(entlist, nr, base, ent)	                \
+	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
 		if (!is_directory(base, ent) && ent->d_name[0] != '.')
 
 static const char *shell_tests__dir(char *path, size_t size)
@@ -538,8 +538,9 @@ static const char *shell_tests__dir(char *path, size_t size)
 
 static int shell_tests__max_desc_width(void)
 {
-	DIR *dir;
+	struct dirent **entlist;
 	struct dirent *ent;
+	int n_dirs;
 	char path_dir[PATH_MAX];
 	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
 	int width = 0;
@@ -547,11 +548,11 @@ static int shell_tests__max_desc_width(void)
 	if (path == NULL)
 		return -1;
 
-	dir = opendir(path);
-	if (!dir)
+	n_dirs = scandir(path, &entlist, NULL, alphasort);
+	if (n_dirs == -1)
 		return -1;
 
-	for_each_shell_test(dir, path, ent) {
+	for_each_shell_test(entlist, n_dirs, path, ent) {
 		char bf[256];
 		const char *desc = shell_test__description(bf, sizeof(bf), path, ent->d_name);
 
@@ -563,7 +564,8 @@ static int shell_tests__max_desc_width(void)
 		}
 	}
 
-	closedir(dir);
+	free(entlist);
+
 	return width;
 }
 
@@ -589,8 +591,9 @@ static int shell_test__run(struct test *test, int subdir __maybe_unused)
 
 static int run_shell_tests(int argc, const char *argv[], int i, int width)
 {
-	DIR *dir;
+	struct dirent **entlist;
 	struct dirent *ent;
+	int n_dirs;
 	char path_dir[PATH_MAX];
 	struct shell_test st = {
 		.dir = shell_tests__dir(path_dir, sizeof(path_dir)),
@@ -599,14 +602,14 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
 	if (st.dir == NULL)
 		return -1;
 
-	dir = opendir(st.dir);
-	if (!dir) {
+	n_dirs = scandir(st.dir, &entlist, NULL, alphasort);
+	if (n_dirs == -1) {
 		pr_err("failed to open shell test directory: %s\n",
 			st.dir);
 		return -1;
 	}
 
-	for_each_shell_test(dir, st.dir, ent) {
+	for_each_shell_test(entlist, n_dirs, st.dir, ent) {
 		int curr = i++;
 		char desc[256];
 		struct test test = {
@@ -623,7 +626,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
 		test_and_print(&test, false, -1);
 	}
 
-	closedir(dir);
+	free(entlist);
 	return 0;
 }
 
@@ -722,19 +725,20 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 
 static int perf_test__list_shell(int argc, const char **argv, int i)
 {
-	DIR *dir;
+	struct dirent **entlist;
 	struct dirent *ent;
+	int n_dirs;
 	char path_dir[PATH_MAX];
 	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
 
 	if (path == NULL)
 		return -1;
 
-	dir = opendir(path);
-	if (!dir)
+	n_dirs = scandir(path, &entlist, NULL, alphasort);
+	if (n_dirs == -1)
 		return -1;
 
-	for_each_shell_test(dir, path, ent) {
+	for_each_shell_test(entlist, n_dirs, path, ent) {
 		int curr = i++;
 		char bf[256];
 		struct test t = {
@@ -747,7 +751,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
 		pr_info("%2d: %s\n", i, t.desc);
 	}
 
-	closedir(dir);
+	free(entlist);
 	return 0;
 }
 
-- 
2.31.1

