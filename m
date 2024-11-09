Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2114A0B9
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133120; cv=none; b=s45zWF7FSkzfxFWYJG7sYhqJ+RjDIRc1vonFvWS5hCD++FUWnt1LbVbWDglXilw7nmoWlcpLulqUlPM7xlSXqFjqUXNBIjcIw/5nHGIfcKGA57JjwlhqMKpMrCitT7GzUTKAOeT6Bnpycw8gEY/i0nTIfI8KKLTJDTQCXnC8NwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133120; c=relaxed/simple;
	bh=7TgB0AcBPzEPV7nSAaJTGLcx062mAxvJSe8i+Y/G1nQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZKSPYFEQhB11VUeQeSIzkY+UpFpm+KzUUIYveKUrWTrnjfulGkObD0GWjpYrTOenottgAyIVZI1t8U0meiAjBQhz28oOrfXLazAGnJn5UimjDq81RZFJegmsjjteRRQRO3qNb6GD8ajiSvFhFlAagqQmonC/bKDBdLy0kw3woOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5CC7YOG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5CC7YOG"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2954ada861so5101281276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133118; x=1731737918; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nD/NdnGAGoeL3cAcfuS47/M7Ih34fBwBdXC2Llg8WuI=;
        b=O5CC7YOG+6dhjYFS6DH6AQHU+wzN1gNqghD9V2R++uHyDWuZ3Qc3yrE4FhOjM8cuRk
         2Ip+uBzHU7Wg1aVcwg8qJbZI1rGyWRGUSl7BRwLSfzoUaHf63RmepU0akYQOTLbJFDZ3
         /1s5HDkreGrd690+Lb8YHAGox2e+T7FOZS/cz3QEznH7RmCINGM1NrX4wFNpJWfyYNid
         heWjphMJI6+ZKznYuPrjW1QU51jFGhZkWGLz7eYxZnRJKCRZPwmGNlHzCUauXwBDmRon
         H5KwIFFisZ/RmI7NxpctPSo4C0DDfDUytX38mhgbdRgOAa4Sd43yJr4qBAN3osHc4aXR
         GjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133118; x=1731737918;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nD/NdnGAGoeL3cAcfuS47/M7Ih34fBwBdXC2Llg8WuI=;
        b=N+pJNzEGl/eQFjGUjNyu/8WaO2W7VpFjk/9jUyQTdmIkcRChMlaKjQzbFggpggoSC3
         PY0bpABqedmrLipYtMxUNR4ZmrWh/rTAsBDW/rKDL7jaWXA9DPvphScc0oUmBqJS/myP
         79bvBAbEY45L73PaTJZi1otTxe3xws1xqRV5uXGipfpJkCtF7x5UXz1zdjYOlLajwhuU
         jM9va5QxFJ/XeSaOKhwIt17dgQyY/EvBDfhJoWOVhL87cqNLmwobq3b+w/4FtJCcucbq
         9B4z2wbqATiFJ85VN4/64K0VPrf0g3g5Y6njzyN+7OiIq+Wb7jKtItRis/8q8CeyS5gl
         gnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWysIm/+5nwcwv9ixyaL93QQYPE8iFLAjAqdDOo1CZ9kXPEaXdtgHgAwJaa074jTzJCsA4RAt21fRqMUp1pyrL2@vger.kernel.org
X-Gm-Message-State: AOJu0YzCSieWS+O9yCxnpA87Ga9Y7oikeWBX/LU4stRJRfxQrIHzS/x+
	tOrue0ysqaD0uwrER6ZmDwqT4wAcsrHaHUa1Wt7OBFVKtidYJVBb7MC4Cl6RQLmy9y90RHME+u7
	k+J48fw==
X-Google-Smtp-Source: AGHT+IGn5Cj5p/savbBcVXiDFCm/wa6fgQ+a4h8u/+LC3CFC15OcIo4Q7tebFb0apBRRgESmBpVaMSkxWyIF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:aa53:0:b0:e2b:ce2f:787a with SMTP id
 3f1490d57ef6-e337f861f01mr9642276.3.1731133117850; Fri, 08 Nov 2024 22:18:37
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:54 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 07/22] perf script: Move find_scripts to browser/scripts.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The only use of find_scripts is in browser/scripts.c but the
definition in builtin causes linking problems requiring a stub in
python.c. Move the function to allow the stub to be removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c      | 171 -----------------------------
 tools/perf/builtin.h             |   6 --
 tools/perf/ui/browsers/scripts.c | 177 ++++++++++++++++++++++++++++++-
 tools/perf/util/python.c         |   6 --
 4 files changed, 175 insertions(+), 185 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e20d55b8a741..e9ec74056f71 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3521,177 +3521,6 @@ static void free_dlarg(void)
 	free(dlargv);
 }
 
-/*
- * Some scripts specify the required events in their "xxx-record" file,
- * this function will check if the events in perf.data match those
- * mentioned in the "xxx-record".
- *
- * Fixme: All existing "xxx-record" are all in good formats "-e event ",
- * which is covered well now. And new parsing code should be added to
- * cover the future complex formats like event groups etc.
- */
-static int check_ev_match(int dir_fd, const char *scriptname, struct perf_session *session)
-{
-	char line[BUFSIZ];
-	FILE *fp;
-
-	{
-		char filename[FILENAME_MAX + 5];
-		int fd;
-
-		scnprintf(filename, sizeof(filename), "bin/%s-record", scriptname);
-		fd = openat(dir_fd, filename, O_RDONLY);
-		if (fd == -1)
-			return -1;
-		fp = fdopen(fd, "r");
-		if (!fp)
-			return -1;
-	}
-
-	while (fgets(line, sizeof(line), fp)) {
-		char *p = skip_spaces(line);
-
-		if (*p == '#')
-			continue;
-
-		while (strlen(p)) {
-			int match, len;
-			struct evsel *pos;
-			char evname[128];
-
-			p = strstr(p, "-e");
-			if (!p)
-				break;
-
-			p += 2;
-			p = skip_spaces(p);
-			len = strcspn(p, " \t");
-			if (!len)
-				break;
-
-			snprintf(evname, len + 1, "%s", p);
-
-			match = 0;
-			evlist__for_each_entry(session->evlist, pos) {
-				if (evsel__name_is(pos, evname)) {
-					match = 1;
-					break;
-				}
-			}
-
-			if (!match) {
-				fclose(fp);
-				return -1;
-			}
-		}
-	}
-
-	fclose(fp);
-	return 0;
-}
-
-/*
- * Return -1 if none is found, otherwise the actual scripts number.
- *
- * Currently the only user of this function is the script browser, which
- * will list all statically runnable scripts, select one, execute it and
- * show the output in a perf browser.
- */
-int find_scripts(char **scripts_array, char **scripts_path_array, int num,
-		 int pathlen)
-{
-	struct dirent *script_dirent, *lang_dirent;
-	int scripts_dir_fd, lang_dir_fd;
-	DIR *scripts_dir, *lang_dir;
-	struct perf_session *session;
-	struct perf_data data = {
-		.path = input_name,
-		.mode = PERF_DATA_MODE_READ,
-	};
-	char *temp;
-	int i = 0;
-	const char *exec_path = get_argv_exec_path();
-
-	session = perf_session__new(&data, NULL);
-	if (IS_ERR(session))
-		return PTR_ERR(session);
-
-	{
-		char scripts_path[PATH_MAX];
-
-		snprintf(scripts_path, sizeof(scripts_path), "%s/scripts", exec_path);
-		scripts_dir_fd = open(scripts_path, O_DIRECTORY);
-		pr_err("Failed to open directory '%s'", scripts_path);
-		if (scripts_dir_fd == -1) {
-			perf_session__delete(session);
-			return -1;
-		}
-	}
-	scripts_dir = fdopendir(scripts_dir_fd);
-	if (!scripts_dir) {
-		close(scripts_dir_fd);
-		perf_session__delete(session);
-		return -1;
-	}
-
-	while ((lang_dirent = readdir(scripts_dir)) != NULL) {
-		if (lang_dirent->d_type != DT_DIR &&
-		    (lang_dirent->d_type == DT_UNKNOWN &&
-		     !is_directory_at(scripts_dir_fd, lang_dirent->d_name)))
-			continue;
-		if (!strcmp(lang_dirent->d_name, ".") || !strcmp(lang_dirent->d_name, ".."))
-			continue;
-
-#ifndef HAVE_LIBPERL_SUPPORT
-		if (strstr(lang_dirent->d_name, "perl"))
-			continue;
-#endif
-#ifndef HAVE_LIBPYTHON_SUPPORT
-		if (strstr(lang_dirent->d_name, "python"))
-			continue;
-#endif
-
-		lang_dir_fd = openat(scripts_dir_fd, lang_dirent->d_name, O_DIRECTORY);
-		if (lang_dir_fd == -1)
-			continue;
-		lang_dir = fdopendir(lang_dir_fd);
-		if (!lang_dir) {
-			close(lang_dir_fd);
-			continue;
-		}
-		while ((script_dirent = readdir(lang_dir)) != NULL) {
-			if (script_dirent->d_type == DT_DIR)
-				continue;
-			if (script_dirent->d_type == DT_UNKNOWN &&
-			    is_directory_at(lang_dir_fd, script_dirent->d_name))
-				continue;
-			/* Skip those real time scripts: xxxtop.p[yl] */
-			if (strstr(script_dirent->d_name, "top."))
-				continue;
-			if (i >= num)
-				break;
-			scnprintf(scripts_path_array[i], pathlen, "%s/scripts/%s/%s",
-				exec_path,
-				lang_dirent->d_name,
-				script_dirent->d_name);
-			temp = strchr(script_dirent->d_name, '.');
-			snprintf(scripts_array[i],
-				(temp - script_dirent->d_name) + 1,
-				"%s", script_dirent->d_name);
-
-			if (check_ev_match(lang_dir_fd, scripts_array[i], session))
-				continue;
-
-			i++;
-		}
-		closedir(lang_dir);
-	}
-
-	closedir(scripts_dir);
-	perf_session__delete(session);
-	return i;
-}
-
 static char *get_script_path(const char *script_root, const char *suffix)
 {
 	struct dirent *script_dirent, *lang_dirent;
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 94f4b3769bf7..a07e93c53848 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -2,10 +2,6 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
 
-#include <stddef.h>
-#include <linux/compiler.h>
-#include <tools/config.h>
-
 struct feature_status {
 	const char *name;
 	const char *macro;
@@ -56,6 +52,4 @@ int cmd_ftrace(int argc, const char **argv);
 int cmd_daemon(int argc, const char **argv);
 int cmd_kwork(int argc, const char **argv);
 
-int find_scripts(char **scripts_array, char **scripts_path_array, int num,
-		 int pathlen);
 #endif
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index e437d7889de6..2d04ece833aa 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,16 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../../builtin.h"
-#include "../../perf.h"
 #include "../../util/util.h" // perf_exe()
 #include "../util.h"
+#include "../../util/evlist.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
+#include "../../util/session.h"
 #include "../../util/symbol.h"
 #include "../browser.h"
 #include "../libslang.h"
 #include "config.h"
+#include <linux/err.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <subcmd/exec-cmd.h>
 #include <stdlib.h>
 
 #define SCRIPT_NAMELEN	128
@@ -77,6 +79,177 @@ static int scripts_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
+/*
+ * Some scripts specify the required events in their "xxx-record" file,
+ * this function will check if the events in perf.data match those
+ * mentioned in the "xxx-record".
+ *
+ * Fixme: All existing "xxx-record" are all in good formats "-e event ",
+ * which is covered well now. And new parsing code should be added to
+ * cover the future complex formats like event groups etc.
+ */
+static int check_ev_match(int dir_fd, const char *scriptname, struct perf_session *session)
+{
+	char line[BUFSIZ];
+	FILE *fp;
+
+	{
+		char filename[FILENAME_MAX + 5];
+		int fd;
+
+		scnprintf(filename, sizeof(filename), "bin/%s-record", scriptname);
+		fd = openat(dir_fd, filename, O_RDONLY);
+		if (fd == -1)
+			return -1;
+		fp = fdopen(fd, "r");
+		if (!fp)
+			return -1;
+	}
+
+	while (fgets(line, sizeof(line), fp)) {
+		char *p = skip_spaces(line);
+
+		if (*p == '#')
+			continue;
+
+		while (strlen(p)) {
+			int match, len;
+			struct evsel *pos;
+			char evname[128];
+
+			p = strstr(p, "-e");
+			if (!p)
+				break;
+
+			p += 2;
+			p = skip_spaces(p);
+			len = strcspn(p, " \t");
+			if (!len)
+				break;
+
+			snprintf(evname, len + 1, "%s", p);
+
+			match = 0;
+			evlist__for_each_entry(session->evlist, pos) {
+				if (evsel__name_is(pos, evname)) {
+					match = 1;
+					break;
+				}
+			}
+
+			if (!match) {
+				fclose(fp);
+				return -1;
+			}
+		}
+	}
+
+	fclose(fp);
+	return 0;
+}
+
+/*
+ * Return -1 if none is found, otherwise the actual scripts number.
+ *
+ * Currently the only user of this function is the script browser, which
+ * will list all statically runnable scripts, select one, execute it and
+ * show the output in a perf browser.
+ */
+static int find_scripts(char **scripts_array, char **scripts_path_array, int num,
+		 int pathlen)
+{
+	struct dirent *script_dirent, *lang_dirent;
+	int scripts_dir_fd, lang_dir_fd;
+	DIR *scripts_dir, *lang_dir;
+	struct perf_session *session;
+	struct perf_data data = {
+		.path = input_name,
+		.mode = PERF_DATA_MODE_READ,
+	};
+	char *temp;
+	int i = 0;
+	const char *exec_path = get_argv_exec_path();
+
+	session = perf_session__new(&data, NULL);
+	if (IS_ERR(session))
+		return PTR_ERR(session);
+
+	{
+		char scripts_path[PATH_MAX];
+
+		snprintf(scripts_path, sizeof(scripts_path), "%s/scripts", exec_path);
+		scripts_dir_fd = open(scripts_path, O_DIRECTORY);
+		pr_err("Failed to open directory '%s'", scripts_path);
+		if (scripts_dir_fd == -1) {
+			perf_session__delete(session);
+			return -1;
+		}
+	}
+	scripts_dir = fdopendir(scripts_dir_fd);
+	if (!scripts_dir) {
+		close(scripts_dir_fd);
+		perf_session__delete(session);
+		return -1;
+	}
+
+	while ((lang_dirent = readdir(scripts_dir)) != NULL) {
+		if (lang_dirent->d_type != DT_DIR &&
+		    (lang_dirent->d_type == DT_UNKNOWN &&
+		     !is_directory_at(scripts_dir_fd, lang_dirent->d_name)))
+			continue;
+		if (!strcmp(lang_dirent->d_name, ".") || !strcmp(lang_dirent->d_name, ".."))
+			continue;
+
+#ifndef HAVE_LIBPERL_SUPPORT
+		if (strstr(lang_dirent->d_name, "perl"))
+			continue;
+#endif
+#ifndef HAVE_LIBPYTHON_SUPPORT
+		if (strstr(lang_dirent->d_name, "python"))
+			continue;
+#endif
+
+		lang_dir_fd = openat(scripts_dir_fd, lang_dirent->d_name, O_DIRECTORY);
+		if (lang_dir_fd == -1)
+			continue;
+		lang_dir = fdopendir(lang_dir_fd);
+		if (!lang_dir) {
+			close(lang_dir_fd);
+			continue;
+		}
+		while ((script_dirent = readdir(lang_dir)) != NULL) {
+			if (script_dirent->d_type == DT_DIR)
+				continue;
+			if (script_dirent->d_type == DT_UNKNOWN &&
+			    is_directory_at(lang_dir_fd, script_dirent->d_name))
+				continue;
+			/* Skip those real time scripts: xxxtop.p[yl] */
+			if (strstr(script_dirent->d_name, "top."))
+				continue;
+			if (i >= num)
+				break;
+			scnprintf(scripts_path_array[i], pathlen, "%s/scripts/%s/%s",
+				exec_path,
+				lang_dirent->d_name,
+				script_dirent->d_name);
+			temp = strchr(script_dirent->d_name, '.');
+			snprintf(scripts_array[i],
+				(temp - script_dirent->d_name) + 1,
+				"%s", script_dirent->d_name);
+
+			if (check_ev_match(lang_dir_fd, scripts_array[i], session))
+				continue;
+
+			i++;
+		}
+		closedir(lang_dir);
+	}
+
+	closedir(scripts_dir);
+	perf_session__delete(session);
+	return i;
+}
+
 /*
  * When success, will copy the full path of the selected script
  * into  the buffer pointed by script_name, and return 0.
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 94902652e371..eb15f3b6c4f5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1307,12 +1307,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-int find_scripts(char **scripts_array  __maybe_unused, char **scripts_path_array  __maybe_unused,
-		int num  __maybe_unused, int pathlen __maybe_unused)
-{
-	return -1;
-}
-
 void perf_stat__set_no_csv_summary(int set __maybe_unused)
 {
 }
-- 
2.47.0.277.g8800431eea-goog

