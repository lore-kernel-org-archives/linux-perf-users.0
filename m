Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF315672
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979054; cv=none; b=OKKuRGVkq2/CgrMTvFgB0Eh6/yFEhfPWQeL7ryPzxVQddpKmnyr/M+zO5rCrmKUUrEzyNZ3wPZ2DYlt9XpJreHeQLisqMSdlrSnNycYPxRPhL453gpu3qrai9TgoefeVodIhKLIXNQXOa4cKiQPYtXusUADw6KBM1tmT/dqRPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979054; c=relaxed/simple;
	bh=rHwHHBC1gblY1Eotv4xOB/p4hXgB658TOIe86c0QPHY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=V6Ss7pHGyG3/jCSED8dLoHN1Akf0KlZekvYeu7dE9PGuibqvyHYNDs4IfG4S+1HFxKt0iIr7bpo1xH+H1ICaH7gsLbw0E1fRj81tHY/9BFqWmSNl9MDsP9svmEp4yHPwaydU548pGJgIg0S2btsgu7k5xamBke9vF1EUyzuF24k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEWMLPKS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEWMLPKS"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee51558e90so67606167b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979051; x=1732583851; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6d3NnEtZrqDPZDd85+OpARaP/oSw/tn+LnVNwTbe+g=;
        b=uEWMLPKS8nUp4TsZ8gM1JJq3KErnIN5H9yLwfcYrCtZ9uv27VgXfYAESzup9jUTANb
         I1k7llMOaNygdKr/GWIsxdsZ5B5mJUEbCebtDVFTyIw/h+29bE8va2iCGI7L0jCWyMa4
         5f0+hBSOKoN475QMbKg8LJXyPmW+usju93CdQ6I0ZSw+MhExkOVvsaWzVKqNwylT01/T
         iMiZna0t6tpucfkz0l6nTNAwMqBJgjaiCzdTHS5aFHyeP/3rvK4SeYvgn3N3/7FHcZLG
         qdY1QcTNZRFY32h6I3VWZaVPpKL38CuwEDeBAT9bNfwX6/N5Nqk2e01pUucomN0Eh/lz
         oA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979051; x=1732583851;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6d3NnEtZrqDPZDd85+OpARaP/oSw/tn+LnVNwTbe+g=;
        b=ZdUNx+Vg/k2+4OIYucTNR+vPtYk/RBmRraJqhHi0Ynkd8npvr8nqO6PpKttn0/rfPj
         97mjTJ62149hjmXSsSNwrhCENrjCATXB4AJkKSKixHaC0YFnjET3AyXO1314xlw2pnSg
         bbXBSFJxaJZZShN8i/D42S+KVdjz9kKf5df8Pfs0D3Uaz9hx4msxGelqU8Mr3KNCQtjG
         8tXPEr/KDlGLS098McqHea2vVFWaXIMhSKCiVmBvP5O38v7HBlMZYhzjicnKebRy89Qb
         6p+YCuwvuEF+1nqZplwMgTKZepCHBjUJypL8wmEA6Gh9CTAC+Vx5FZ1iFMGBdAUV4iY0
         qHpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV95YHBVPhU+UKU8n1X09iL2CqgC/G31UD1PokA+GCrhnqssdAHLdlrcftuw0Qz20GDcxjxWTnMuBeZWtAIOTB@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1Exn7nVTSrR5zKlailQFkTdgl3Ua2YaIgtYnYY5Ys9BjGu4M
	1GZx6gG/I+DAyhFkJ//bwYKEHpD58vXvJ/mTC1quC1yjIz3KbtHdX74aaHh9om7BQ76q2YE4dGt
	4BoWTEg==
X-Google-Smtp-Source: AGHT+IFZaHT2CJkG0agrDJb6LQCa/4cj+2AVXZD5gCLi1DBVTctbyMVHzwR7j8PooCS7GDEJe/WVAPAnengW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:39f:b0:6ec:b74d:9c59 with SMTP id
 00721157ae682-6ee55bc4b7bmr1981227b3.2.1731979051315; Mon, 18 Nov 2024
 17:17:31 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:29 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 07/22] perf script: Move find_scripts to browser/scripts.c
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
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-script.c      | 171 -----------------------------
 tools/perf/builtin.h             |   6 --
 tools/perf/ui/browsers/scripts.c | 177 ++++++++++++++++++++++++++++++-
 tools/perf/util/python.c         |   6 --
 4 files changed, 175 insertions(+), 185 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ebf9ac7a97b1..33f50a17338a 100644
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
index f8b291143884..4593c937febb 100644
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
2.47.0.338.g60cca15819-goog

