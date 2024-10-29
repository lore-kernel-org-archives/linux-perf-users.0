Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1320C47D
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241894; cv=none; b=k4eYtdW7EUYjTZH3fB59okK4j3b+YWHLIIINNsZXEQ1mkKQOgF21SwgMQCoXpDmXRH2mgayfbhyBI0EtSp/hcd4BH+L8BEcimnpVxnn2kn23dBY7kT+652TmmQeMx0FToNX6h1basS8z5gDMz6DgZKGkSAVFghP79gvSYtUhIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241894; c=relaxed/simple;
	bh=eOhqswzbqiD/mQewQTcc7e297f5ySC3T7Rd4vlXk+CE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gEio1wzfikYrjU+77coDlYlHGpY9S3ucTnQ/J1+iNsaknMWDDBI5PnlEJKKTEkf/JIsyylDA5iVXtoGWSo2EwrboNWdrhmRSfMrspaZnNUq2qXLlKoJKW79IYvypw8OY57rtZI8SpDevQ5BlgYA33gF9Ibtf3bKIXeMweM0Zzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GLTyWU8B; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLTyWU8B"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e31d9c8efcso116499397b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241890; x=1730846690; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZniLOY6zt4yEfnCphzbGvx8nNysYFG4WnDu6HN1+kY=;
        b=GLTyWU8B716c3oURrAOhJeTe4LumrTn9HyYwy8iRACodLETeCyl6olbDcjS6iBf1EV
         dcOg1HJMwrZ+nlOKc76uN07t1EOrSg9pCfQ+1DcVvDCy2lJ4Noz84AQkeB+atjKIRGJ6
         lVs47SELFhy4wZYWSE7JUOyoqnENxUVjJpxZ6c5WUd6ckV4is5tYp9597jn9iurIZA5U
         ofmv84eajsV+RvygMKTCsmatdicgiv0cdTcEW31eE+lhb9QINQH5QM5kGjmuTDfYuh+/
         LrzFI4u2rfxwdcP0AVXTRKicFt0JvuF2cwuvt9OGdVLTHexxvn1bwmsx6eCjx+9Z4HN+
         taGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241890; x=1730846690;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZniLOY6zt4yEfnCphzbGvx8nNysYFG4WnDu6HN1+kY=;
        b=jsHXUNoH01+pgs239RV8KMhizLaf62bpzhymYxnhv9Tukwq6CVS82X21hEbXpWMQyk
         k+YgKpe0A/EEQi8zDc3Ny3yjtFe3b5/+5ZhMvIs8mMqpSSWpcHAYvIydX6m5cCwYBWKb
         SOC+PAbaSTIphvPFAZeRT+Q31snLKfTUO6TQjWFKUjRERkGMWPQL3l5hcEI8mcrdpjcm
         sTAt6skhPrN4Yk4PhuxUePjSuTL5c+YMTK9aEB7Y0opCAuMnjpH8oVDzmWgtzxsp3cFx
         6Hhjcl2lnAxqronfmJUYa4I0bZXBKT4v1EKW9iQDonK0X7kFKzsa+b4tqJCxAVWYieYA
         3ugQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt89JCSvqo3loawXXSNMPu5NFnv5NoV/4doV79ziWKGyKSoAAx0GGony4M6K41WGn9YS9411qyosv1G5tg9vAP@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZQkLzJQrl75/qbd2BL/YFteU/PZk9ndWthxDUr5FjJHUXxfF
	qpssO5N6qRexd/9w9a2n5Osxw19heEZ0TnL0Z2eSKlHWNQW+aGK5T7k7Pd2+33yiS5x6SmW8DiX
	WAfxeVQ==
X-Google-Smtp-Source: AGHT+IEHDW2f3XuycHFjPJqpz19RLyv5WtfYT95xhi1ztu4O7jYG7CzQUp81DfTvzq7RGFvKwkZ/fH3xQdBn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a05:690c:288e:b0:6e2:4b3:ee22 with SMTP id
 00721157ae682-6ea3b96d91emr238607b3.6.1730241890576; Tue, 29 Oct 2024
 15:44:50 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:18 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 06/19] perf script: Move find_scripts to browser/scripts.c
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The only use of find_scripts is in browser/scripts.c but the
definition in builtin causes linking problems requiring a stub in
python.c. Move the function to allow the stub to be removed.

Rewrite the directory iteration to use openat so that large character
arrays aren't needed. The arrays are warned about potential buffer
overflows by GCC now that all the code exists in a single C file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c      | 138 ------------------------
 tools/perf/builtin.h             |   6 --
 tools/perf/ui/browsers/scripts.c | 177 ++++++++++++++++++++++++++++++-
 tools/perf/util/path.c           |  10 ++
 tools/perf/util/path.h           |   1 +
 tools/perf/util/python.c         |   6 --
 6 files changed, 186 insertions(+), 152 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ff30fe466189..bbcba999c46a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3520,144 +3520,6 @@ static void free_dlarg(void)
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
-static int check_ev_match(char *dir_name, char *scriptname,
-			struct perf_session *session)
-{
-	char filename[MAXPATHLEN], evname[128];
-	char line[BUFSIZ], *p;
-	struct evsel *pos;
-	int match, len;
-	FILE *fp;
-
-	scnprintf(filename, MAXPATHLEN, "%s/bin/%s-record", dir_name, scriptname);
-
-	fp = fopen(filename, "r");
-	if (!fp)
-		return -1;
-
-	while (fgets(line, sizeof(line), fp)) {
-		p = skip_spaces(line);
-		if (*p == '#')
-			continue;
-
-		while (strlen(p)) {
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
-	char scripts_path[MAXPATHLEN], lang_path[MAXPATHLEN];
-	DIR *scripts_dir, *lang_dir;
-	struct perf_session *session;
-	struct perf_data data = {
-		.path = input_name,
-		.mode = PERF_DATA_MODE_READ,
-	};
-	char *temp;
-	int i = 0;
-
-	session = perf_session__new(&data, NULL);
-	if (IS_ERR(session))
-		return PTR_ERR(session);
-
-	snprintf(scripts_path, MAXPATHLEN, "%s/scripts", get_argv_exec_path());
-
-	scripts_dir = opendir(scripts_path);
-	if (!scripts_dir) {
-		perf_session__delete(session);
-		return -1;
-	}
-
-	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
-		scnprintf(lang_path, MAXPATHLEN, "%s/%s", scripts_path,
-			  lang_dirent->d_name);
-#ifndef HAVE_LIBPERL_SUPPORT
-		if (strstr(lang_path, "perl"))
-			continue;
-#endif
-#ifndef HAVE_LIBPYTHON_SUPPORT
-		if (strstr(lang_path, "python"))
-			continue;
-#endif
-
-		lang_dir = opendir(lang_path);
-		if (!lang_dir)
-			continue;
-
-		for_each_script(lang_path, lang_dir, script_dirent) {
-			/* Skip those real time scripts: xxxtop.p[yl] */
-			if (strstr(script_dirent->d_name, "top."))
-				continue;
-			if (i >= num)
-				break;
-			snprintf(scripts_path_array[i], pathlen, "%s/%s",
-				lang_path,
-				script_dirent->d_name);
-			temp = strchr(script_dirent->d_name, '.');
-			snprintf(scripts_array[i],
-				(temp - script_dirent->d_name) + 1,
-				"%s", script_dirent->d_name);
-
-			if (check_ev_match(lang_path,
-					scripts_array[i], session))
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
diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
index 00adf872bf00..9712466c51e2 100644
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -68,6 +68,16 @@ bool is_directory(const char *base_path, const struct dirent *dent)
 	return S_ISDIR(st.st_mode);
 }
 
+bool is_directory_at(int dir_fd, const char *path)
+{
+	struct stat st;
+
+	if (fstatat(dir_fd, path, &st, /*flags=*/0))
+		return false;
+
+	return S_ISDIR(st.st_mode);
+}
+
 bool is_executable_file(const char *base_path, const struct dirent *dent)
 {
 	char path[PATH_MAX];
diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
index d94902c22222..fbafbe7015dd 100644
--- a/tools/perf/util/path.h
+++ b/tools/perf/util/path.h
@@ -12,6 +12,7 @@ int path__join3(char *bf, size_t size, const char *path1, const char *path2, con
 
 bool is_regular_file(const char *file);
 bool is_directory(const char *base_path, const struct dirent *dent);
+bool is_directory_at(int dir_fd, const char *path);
 bool is_executable_file(const char *base_path, const struct dirent *dent);
 
 #endif /* _PERF_PATH_H */
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ab67abf3b607..5f11ae88943d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1306,12 +1306,6 @@ PyMODINIT_FUNC PyInit_perf(void)
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
2.47.0.163.g1226f6d8fa-goog

