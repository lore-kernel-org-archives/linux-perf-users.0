Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17404879B
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Feb 2024 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764363; cv=none; b=ZzxjB59SwM988jJE0ODDEBuYHj9bZkCDETNJJB9hylNyfd9qyd18wN4OCsulHpJ8dIwQgqf4ELEFxFQafuAV07kwxWkWmnzQiBerz+/QlT17su95rPgfOxxdJSaWcebwS1Pn1D89KKnjsHstsQ6cMpsKNMLZdsWmIpqeHJQ/Ccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764363; c=relaxed/simple;
	bh=pokSEbOrag3uWdO1RhTKTOPvPSFp8ZMJI6bQo7DbnNA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uMHXqw0eEuHizsqctw5M8nudd3E4BNoUhVR8n6eGdFfxYepdHWB/b4yEQndgNRhERZTlwqpT9T2g9/1TvEoMpVL/B8QbsrYa29TCfsaigTxvvHRQ2k5z0W261y3yXN8+k9JoHDZrIfjfUS966BvsdkFj5JGl9CCWe3KVrJ3fwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJyBcTrZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJyBcTrZ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269b172so5768207276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Feb 2024 10:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707764361; x=1708369161; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEeFv0uon5WQC9cFYvgD6Kwx90gDUxQUuXbCDfN9dJU=;
        b=VJyBcTrZUBi5oZMBg6/NziPWTE5l63C+eegMy4hvn2u1fzJdXhxZXJynWerDIdnnsm
         hGqsnsBA+/P5Tvs5P4HBWph2ELiMM6DwNz3tz7JeYbwylImdmlvmKWzNC9El0oVUQwKP
         kFyWDi3mF0ZQpk9AtKrwePZQ6+fFRH7v50t7KX6eQzIpWqRJpwfMs+uN7bHcKcSd6B3F
         d5qowv4SL1d2wE3qnsaUY0EzzmrnDklS7nXsRiVaLNOpL11MzDOYJcXODklmGWQPq6OA
         jeZLHMkINn6/iMHZC+t1zNSs0zWP3f0IKOpyZ0NPQRwBZH4oN6kYZMIuve336JSLb0ui
         eNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764361; x=1708369161;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEeFv0uon5WQC9cFYvgD6Kwx90gDUxQUuXbCDfN9dJU=;
        b=Zc+S32kzXj8SWHUWbjMAAFd+4QbReomrrVkklKVp2pAtZce5w3Ab2u1J4+JihGOixu
         F434SWfWDM8A8ALT0WU4TFl4w0bZdtIHmIifkOZgAeiWduoXBMDg4rXMIJvLis+qvnu5
         ZEwjjV/blRn7VfiSnI2mHr4sCkBmYNnv4fhxbFyCFItPUdGGo6vzal18yC5kn+NKf3dP
         FranxB4otPBQTZHGQxewWQYYNdGCrIvHBIcxO9hpIbN8sQxkUmtLg7XySfLVXjZJNH6+
         4bBWw9E5/iwm2ESVAj4i8Y+zZkKj1SQqNZF9FtpjPGmlRzyafRQZZWwNby1O74p7ybHu
         mNVg==
X-Forwarded-Encrypted: i=1; AJvYcCXcaamDm3wfqOo8pInxZI6cpfboxDQ+8rfx8UW9r20GxwT33xpNXSld3xGAQfPGhTusb7Rd2oN2+63qpw6spskzEVSGsF5pRLUPvmGoq0t77w==
X-Gm-Message-State: AOJu0YyyJS/oT4kNuBxKop9nVigwGuo3x6vNPKgHN68esfjcTEZudtCK
	LiurRABCerZ7hqSBAKMCQfNFLRHNd77hpR9wNMWIk5LqlpOpcJjxG7PkvrxzD82Kr+Md/EepM2p
	3XOXUxg==
X-Google-Smtp-Source: AGHT+IEO1PiMz3c0RZTIoYJezmJDkE3dGRBEbQ9aT7WtE501MYAM1moyGkhzIzhdVkLI5mUBKa4Uy1qhvLLj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:125c:bcda:4fe2:b6e6])
 (user=irogers job=sendgmr) by 2002:a05:6902:1209:b0:dc7:7655:46ce with SMTP
 id s9-20020a056902120900b00dc7765546cemr64080ybu.2.1707764360768; Mon, 12 Feb
 2024 10:59:20 -0800 (PST)
Date: Mon, 12 Feb 2024 10:58:56 -0800
In-Reply-To: <20240212185858.68189-1-irogers@google.com>
Message-Id: <20240212185858.68189-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212185858.68189-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 6/8] perf tests: Use scandirat for shell script finding
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Avoid filename appending buffers by using openat, faccessat and
scandirat more widely. Turn the script's path back to a file name
using readlink from /proc/<pid>/fd/<fd>.

Read the script's description using api/io.h to avoid fdopen
conversions. Whilst reading perform additional sanity checks on the
script's contents.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c  |  21 ++---
 tools/perf/tests/tests-scripts.c | 144 ++++++++++++++++++-------------
 tools/perf/tests/tests-scripts.h |   1 -
 3 files changed, 95 insertions(+), 71 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index eff3c62e9b47..6d5001daaf63 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -300,22 +300,20 @@ static int test_and_print(struct test_suite *t, int subtest)
 }
 
 struct shell_test {
-	const char *dir;
 	const char *file;
 };
 
 static int shell_test__run(struct test_suite *test, int subdir __maybe_unused)
 {
 	int err;
-	char script[PATH_MAX];
 	struct shell_test *st = test->priv;
+	char *cmd;
 
-	path__join(script, sizeof(script) - 3, st->dir, st->file);
-
-	if (verbose > 0)
-		strncat(script, " -v", sizeof(script) - strlen(script) - 1);
-
-	err = system(script);
+	asprintf(&cmd, "%s%s", st->file, verbose ? " -v" : "");
+	if (!cmd)
+		return TEST_FAIL;
+	err = system(cmd);
+	free(cmd);
 	if (!err)
 		return TEST_OK;
 
@@ -331,7 +329,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 	files = list_script_files();
 	if (!files)
 		return 0;
-	for (file = files; file->dir; file++) {
+	for (file = files; file->file; file++) {
 		int curr = i++;
 		struct test_case test_cases[] = {
 			{
@@ -345,13 +343,12 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 			.test_cases = test_cases,
 			.priv = &st,
 		};
-		st.dir = file->dir;
+		st.file = file->file;
 
 		if (test_suite.desc == NULL ||
 		    !perf_test__matches(test_suite.desc, curr, argc, argv))
 			continue;
 
-		st.file = file->file;
 		pr_info("%3d: %-*s:", i, width, test_suite.desc);
 
 		if (intlist__find(skiplist, i)) {
@@ -455,7 +452,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
 	files = list_script_files();
 	if (!files)
 		return 0;
-	for (file = files; file->dir; file++) {
+	for (file = files; file->file; file++) {
 		int curr = i++;
 		struct test_suite t = {
 			.desc = file->desc
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 4ebd841da05b..9b3b66dd5508 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -14,6 +14,7 @@
 #include <subcmd/parse-options.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
+#include <api/io.h>
 #include "builtin.h"
 #include "tests-scripts.h"
 #include "color.h"
@@ -35,55 +36,69 @@ static size_t files_num = 0;
 static struct script_file *files = NULL;
 static int files_max_width = 0;
 
-static const char *shell_tests__dir(char *path, size_t size)
+static int shell_tests__dir_fd(void)
 {
-	const char *devel_dirs[] = { "./tools/perf/tests", "./tests", };
-	char *exec_path;
-	unsigned int i;
+	char path[PATH_MAX], *exec_path;
+	static const char * const devel_dirs[] = { "./tools/perf/tests/shell", "./tests/shell", };
 
-	for (i = 0; i < ARRAY_SIZE(devel_dirs); ++i) {
-		struct stat st;
+	for (size_t i = 0; i < ARRAY_SIZE(devel_dirs); ++i) {
+		int fd = open(devel_dirs[i], O_PATH);
 
-		if (!lstat(devel_dirs[i], &st)) {
-			scnprintf(path, size, "%s/shell", devel_dirs[i]);
-			if (!lstat(devel_dirs[i], &st))
-				return path;
-		}
+		if (fd >= 0)
+			return fd;
 	}
 
 	/* Then installed path. */
 	exec_path = get_argv_exec_path();
-	scnprintf(path, size, "%s/tests/shell", exec_path);
+	scnprintf(path, sizeof(path), "%s/tests/shell", exec_path);
 	free(exec_path);
-	return path;
+	return open(path, O_PATH);
 }
 
-static const char *shell_test__description(char *description, size_t size,
-                                           const char *path, const char *name)
+static char *shell_test__description(int dir_fd, const char *name)
 {
-	FILE *fp;
-	char filename[PATH_MAX];
-	int ch;
+	struct io io;
+	char buf[128], desc[256];
+	int ch, pos = 0;
 
-	path__join(filename, sizeof(filename), path, name);
-	fp = fopen(filename, "r");
-	if (!fp)
+	io__init(&io, openat(dir_fd, name, O_RDONLY), buf, sizeof(buf));
+	if (io.fd < 0)
 		return NULL;
 
 	/* Skip first line - should be #!/bin/sh Shebang */
+	if (io__get_char(&io) != '#')
+		goto err_out;
+	if (io__get_char(&io) != '!')
+		goto err_out;
 	do {
-		ch = fgetc(fp);
-	} while (ch != EOF && ch != '\n');
-
-	description = fgets(description, size, fp);
-	fclose(fp);
+		ch = io__get_char(&io);
+		if (ch < 0)
+			goto err_out;
+	} while (ch != '\n');
 
-	/* Assume first char on line is omment everything after that desc */
-	return description ? strim(description + 1) : NULL;
+	do {
+		ch = io__get_char(&io);
+		if (ch < 0)
+			goto err_out;
+	} while (ch == '#' || isspace(ch));
+	while (ch > 0 && ch != '\n') {
+		desc[pos++] = ch;
+		if (pos >= (int)sizeof(desc) - 1)
+			break;
+		ch = io__get_char(&io);
+	}
+	while (pos > 0 && isspace(desc[--pos]))
+		;
+	desc[++pos] = '\0';
+	close(io.fd);
+	return strdup(desc);
+err_out:
+	close(io.fd);
+	return NULL;
 }
 
 /* Is this full file path a shell script */
-static bool is_shell_script(const char *path)
+static bool is_shell_script(int dir_fd, const char *path)
 {
 	const char *ext;
 
@@ -91,20 +106,16 @@ static bool is_shell_script(const char *path)
 	if (!ext)
 		return false;
 	if (!strcmp(ext, ".sh")) { /* Has .sh extension */
-		if (access(path, R_OK | X_OK) == 0) /* Is executable */
+		if (faccessat(dir_fd, path, R_OK | X_OK, 0) == 0) /* Is executable */
 			return true;
 	}
 	return false;
 }
 
 /* Is this file in this dir a shell script (for test purposes) */
-static bool is_test_script(const char *path, const char *name)
+static bool is_test_script(int dir_fd, const char *name)
 {
-	char filename[PATH_MAX];
-
-	path__join(filename, sizeof(filename), path, name);
-	if (!is_shell_script(filename)) return false;
-	return true;
+	return is_shell_script(dir_fd, name);
 }
 
 /* Duplicate a string and fall over and die if we run out of memory */
@@ -120,12 +131,21 @@ static char *strdup_check(const char *str)
 	return newstr;
 }
 
-static void append_script(const char *dir, const char *file, const char *desc)
+static void append_script(int dir_fd, const char *name, char *desc)
 {
+	char filename[PATH_MAX], link[128];
 	struct script_file *files_tmp;
-	size_t files_num_tmp;
+	size_t files_num_tmp, len;
 	int width;
 
+	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
+	len = readlink(link, filename, sizeof(filename));
+	if (len < 0) {
+		pr_err("Failed to readlink %s", link);
+		return;
+	}
+	filename[len++] = '/';
+	strcpy(&filename[len], name);
 	files_num_tmp = files_num + 1;
 	if (files_num_tmp >= SIZE_MAX) {
 		pr_err("Too many script files\n");
@@ -142,10 +162,8 @@ static void append_script(const char *dir, const char *file, const char *desc)
 	/* Add file to end and NULL terminate the struct array */
 	files = files_tmp;
 	files_num = files_num_tmp;
-	files[files_num - 1].dir = strdup_check(dir);
-	files[files_num - 1].file = strdup_check(file);
-	files[files_num - 1].desc = strdup_check(desc);
-	files[files_num].dir = NULL;
+	files[files_num - 1].file = strdup_check(filename);
+	files[files_num - 1].desc = desc;
 	files[files_num].file = NULL;
 	files[files_num].desc = NULL;
 
@@ -154,32 +172,39 @@ static void append_script(const char *dir, const char *file, const char *desc)
 		files_max_width = width;
 }
 
-static void append_scripts_in_dir(const char *path)
+static void append_scripts_in_dir(int dir_fd)
 {
 	struct dirent **entlist;
 	struct dirent *ent;
 	int n_dirs, i;
-	char filename[PATH_MAX];
 
 	/* List files, sorted by alpha */
-	n_dirs = scandir(path, &entlist, NULL, alphasort);
+	n_dirs = scandirat(dir_fd, ".", &entlist, NULL, alphasort);
 	if (n_dirs == -1)
 		return;
 	for (i = 0; i < n_dirs && (ent = entlist[i]); i++) {
+		int fd;
+
 		if (ent->d_name[0] == '.')
 			continue; /* Skip hidden files */
-		if (is_test_script(path, ent->d_name)) { /* It's a test */
-			char bf[256];
-			const char *desc = shell_test__description
-				(bf, sizeof(bf), path, ent->d_name);
+		if (is_test_script(dir_fd, ent->d_name)) { /* It's a test */
+			char *desc = shell_test__description(dir_fd, ent->d_name);
 
 			if (desc) /* It has a desc line - valid script */
-				append_script(path, ent->d_name, desc);
-		} else if (is_directory(path, ent)) { /* Scan the subdir */
-			path__join(filename, sizeof(filename),
-				   path, ent->d_name);
-			append_scripts_in_dir(filename);
+				append_script(dir_fd, ent->d_name, desc);
+			continue;
+		}
+		if (ent->d_type != DT_DIR) {
+			struct stat st;
+
+			if (ent->d_type != DT_UNKNOWN)
+				continue;
+			fstatat(dir_fd, ent->d_name, &st, 0);
+			if (!S_ISDIR(st.st_mode))
+				continue;
 		}
+		fd = openat(dir_fd, ent->d_name, O_PATH);
+		append_scripts_in_dir(fd);
 	}
 	for (i = 0; i < n_dirs; i++) /* Clean up */
 		zfree(&entlist[i]);
@@ -188,14 +213,17 @@ static void append_scripts_in_dir(const char *path)
 
 const struct script_file *list_script_files(void)
 {
-	char path_dir[PATH_MAX];
-	const char *path;
+	int dir_fd;
 
 	if (files)
 		return files; /* Singleton - we already know our list */
 
-	path = shell_tests__dir(path_dir, sizeof(path_dir)); /* Walk  dir */
-	append_scripts_in_dir(path);
+	dir_fd = shell_tests__dir_fd(); /* Walk  dir */
+	if (dir_fd < 0)
+		return NULL;
+
+	append_scripts_in_dir(dir_fd);
+	close(dir_fd);
 
 	return files;
 }
diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
index 3a3ec6191848..3508a293aaf9 100644
--- a/tools/perf/tests/tests-scripts.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -3,7 +3,6 @@
 #define TESTS_SCRIPTS_H
 
 struct script_file {
-	char *dir;
 	char *file;
 	char *desc;
 };
-- 
2.43.0.687.g38aa6559b0-goog

